/* 1. Divide by 51 since there are 51 values between 0.0 and 5.0 inclusive incrementing by 0.1
 * 2. Numerator width: must be 8 bits to accommodate 8 bit input
 * 3. Denominator: only need 7 bits since we only divide by 51
 * 4. 3.984V would give a simpler design since 255/3.984 = 64, which is a power of two. This 
      means that each division could be accomplished with a right shift. 
 * 5. Improve accuracy by making more digits like this: pass the remainder of the tenths digit
 *    to another divider and divide by 51. Multiply output by 10. This would give another digit.
 *    Can repeat until you get your desired precision.
 */
module dac(d, ones_digit, tenths_digit);

	input[7:0] d;
	output[7:0] ones_digit, tenths_digit;

	wire[7:0] remainder, hundr_digit;

	lpm_divider dividerOnes(.denom(7'd51), .numer(d), .quotient(ones_digit), .remain(remainder));

	lpm_divider dividerTenths(.denom(7'd51), .numer(remainder), .quotient(tenths_digit));

	assign tenths_digit = (8'd10)*hundr_digit;

endmodule //dac