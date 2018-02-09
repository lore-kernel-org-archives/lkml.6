Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751132AbeBIFb7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 00:31:59 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:46044 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751060AbeBIFbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 00:31:55 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3E3A060240
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [PATCH v6 15/15] dt-bindings: cpufreq: Document
 operating-points-v2-krait-cpu
To: Rob Herring <robh@kernel.org>
Cc: viresh.kumar@linaro.org, mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@codeaurora.org, linux@armlinux.org.uk, andy.gross@linaro.org,
        david.brown@linaro.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <1517890108-8140-1-git-send-email-sricharan@codeaurora.org>
 <1517890108-8140-16-git-send-email-sricharan@codeaurora.org>
 <20180209025449.qvbirdvflijxo62j@rob-hp-laptop>
From: Sricharan R <sricharan@codeaurora.org>
Message-ID: <b81953c3-3bbd-2a06-90d3-a3cdd2a86418@codeaurora.org>
Date: Fri, 9 Feb 2018 11:01:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180209025449.qvbirdvflijxo62j@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 2/9/2018 8:24 AM, Rob Herring wrote:
> On Tue, Feb 06, 2018 at 09:38:28AM +0530, Sricharan R wrote:
>> In Certain QCOM SoCs like ipq8064, apq8064, msm8960, msm8974
>> that has KRAIT processors the voltage/current value of each OPP
>> varies based on the silicon variant in use.
>> operating-points-v2-krait-cpu specifies the phandle to nvmem efuse cells
>> and the operating-points-v2 table for each opp. The qcom-cpufreq driver
>> reads the efuse value from the SoC to provide the required information
>> that is used to determine the voltage and current value for each OPP of
>> operating-points-v2 table when it is parsed by the OPP framework.
>>
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> ---
>>  .../devicetree/bindings/cpufreq/krait-cpufreq.txt  | 363 +++++++++++++++++++++
>>  1 file changed, 363 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/cpufreq/krait-cpufreq.txt
>>
>> diff --git a/Documentation/devicetree/bindings/cpufreq/krait-cpufreq.txt b/Documentation/devicetree/bindings/cpufreq/krait-cpufreq.txt
>> new file mode 100644
>> index 0000000..e7351f7
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/cpufreq/krait-cpufreq.txt
>> @@ -0,0 +1,363 @@
>> +QCOM KRAIT CPUFreq and OPP bindings
>> +===================================
>> +
>> +In Certain QCOM SoCs like ipq8064, apq8064, msm8960, msm8974
>> +that has KRAIT processors the voltage value of each OPP varies
>> +based on the silicon variant in use. Qualcomm Process Voltage Scaling Tables
>> +defines the voltage and current value based on the speed/pvs/version
>> +combination blown in the efuse. The qcom-cpufreq driver reads the efuse
>> +value from the SoC to provide the OPP framework with required information.
>> +This is used to determine the voltage and current value for each OPP of
>> +operating-points-v2 table when it is parsed by the OPP framework.
>> +
>> +Required properties:
>> +--------------------
>> +In 'cpus' nodes:
>> +- operating-points-v2: Phandle to the operating-points-v2 table to use.
>> +
>> +In 'operating-points-v2' table:
>> +- compatible: Should be
>> +	- 'operating-points-v2-krait-cpu' for ipq8064, apq8064, msm8960,
>> +					      msm8974.
>> +- nvmem-cells: A phandle pointing to a nvmem-cells node representing the
>> +		efuse registers that has information about the
>> +		speedbin/pvs/version that is used to select the right
>> +		voltage/current value pair. Note that the length field of the
>> +		nvmem-cell is used to differentiate between format 'A' or 'B'
>> +		efuse settings. len of '4' bytes is for format 'A' and '8'
>> +		bytes for format 'B'. Please refer the for nvmem-cells
>> +		bindings Documentation/devicetree/bindings/nvmem/nvmem.txt
>> +		and also examples below for both the cases.
>> +Example 1:
>> +---------
>> +
>> +/* For arch/arm/boot/dts/apq8064.dtsi --> format 'A' */
>> +cpus {
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +
>> +	CPU0: cpu@0 {
>> +		compatible = "qcom,krait";
>> +		enable-method = "qcom,kpss-acc-v1";
>> +		device_type = "cpu";
>> +		reg = <0>;
>> +		next-level-cache = <&L2>;
>> +		qcom,acc = <&acc0>;
>> +		qcom,saw = <&saw0>;
>> +		cpu-idle-states = <&CPU_SPC>;
>> +		operating-points-v2 = <&cpu_opp_table>;
>> +	};
>> +};
>> +
>> +qfprom: qfprom@700000 {
>> +	  compatible      = "qcom,qfprom";
>> +	  reg	      = <0x00700000 0x1000>;
>> +	  #address-cells  = <1>;
>> +	  #size-cells     = <1>;
>> +	  ranges;
>> +	  pvs_efuse: pvs {
>> +		reg = <0xc0 0x4>;
>> +	};
>> +};
>> +
>> +cpu_opp_table: opp-table {
>> +	compatible = "operating-points-v2-krait-cpu";
>> +	nvmem-cells = <&pvs_efuse>;
>> +
>> +		/*
>> +		 * Missing opp-shared property means CPUs switch DVFS states
>> +		 * independently.
>> +		 */
>> +
>> +	       opp-918000000 {
>> +			opp-hz = /bits/ 64 <918000000>;
>> +			opp-microvolt-speed0-pvs0-v0 = <1100000>;
> 
> Where is this property defined? I'm not that happy with it, but don't 
> have a better suggestion. Maybe make pvsN be an array of values with 0 
> for any skipped indexes? The '-v0' seems pointless. 
> 

 'opp-microvolt' is the property that comes from OPP-V2 bindings and rest
  of the string "speed%s-pvs%s-v%s" gets concatenated to the string
  by the cpufreq driver using dev_pm_opp_set_prop_name api. So all
  the three speed,pvs,v (version) come from efuse and can vary.
  Just that in the data so far, v is always '0'.

>> +			opp-microvolt-speed0-pvs1-v0 = <1050000>;
>> +			opp-microvolt-speed0-pvs3-v0 = <1000000>;
>> +			opp-microvolt-speed0-pvs4-v0 = <975000>;
>> +			opp-microvolt-speed1-pvs0-v0 = <1025000>;
>> +			opp-microvolt-speed1-pvs1-v0 = <1000000>;
>> +			opp-microvolt-speed1-pvs2-v0 = <950000>;
>> +			opp-microvolt-speed1-pvs3-v0 = <925000>;
>> +			opp-microvolt-speed1-pvs4-v0 = <900000>;
>> +			opp-microvolt-speed1-pvs5-v0 = <900000>;
>> +			opp-microvolt-speed1-pvs6-v0 = <900000>;
>> +			opp-microvolt-speed2-pvs0-v0 = <975000>;
>> +			opp-microvolt-speed2-pvs1-v0 = <950000>;
>> +			opp-microvolt-speed2-pvs2-v0 = <925000>;
>> +			opp-microvolt-speed2-pvs3-v0 = <912500>;
>> +			opp-microvolt-speed2-pvs4-v0 = <900000>;
>> +			opp-microvolt-speed2-pvs5-v0 = <900000>;
>> +			opp-microvolt-speed2-pvs6-v0 = <900000>;
>> +			opp-microvolt-speed14-pvs0-v0 = <1025000>;
>> +			opp-microvolt-speed14-pvs1-v0 = <1000000>;
>> +			opp-microvolt-speed14-pvs2-v0 = <950000>;
>> +			opp-microvolt-speed14-pvs3-v0 = <925000>;
>> +			opp-microvolt-speed14-pvs4-v0 = <900000>;
>> +			opp-microvolt-speed14-pvs5-v0 = <900000>;
>> +			opp-microvolt-speed14-pvs6-v0 = <900000>;
>> +		};
>> +
>> +		opp-810000000 {
>> +			opp-hz = /bits/ 64 <810000000>;
>> +			opp-microvolt-speed0-pvs0-v0 =  < 1075000>;
>> +			opp-microvolt-speed0-pvs1-v0 = 	< 1025000>;
>> +			opp-microvolt-speed0-pvs3-v0 = 	< 975000>;
>> +			opp-microvolt-speed0-pvs3-v0 = 	< 962500>;
>> +			opp-microvolt-speed1-pvs0-v0 = 	< 1000000>;
>> +			opp-microvolt-speed1-pvs1-v0 = 	< 975000>;
>> +			opp-microvolt-speed1-pvs2-v0 = 	< 937500>;
>> +			opp-microvolt-speed1-pvs3-v0 = 	< 900000>;
>> +			opp-microvolt-speed1-pvs4-v0 = 	< 887500>;
>> +			opp-microvolt-speed1-pvs5-v0 = 	< 887500>;
>> +			opp-microvolt-speed1-pvs6-v0 = 	< 887500>;
>> +			opp-microvolt-speed2-pvs0-v0 = 	< 962500>;
>> +			opp-microvolt-speed2-pvs1-v0 = 	< 937500>;
>> +			opp-microvolt-speed2-pvs2-v0 = 	< 912500>;
>> +			opp-microvolt-speed2-pvs3-v0 = 	< 900000>;
>> +			opp-microvolt-speed2-pvs4-v0 = 	< 887500>;
>> +			opp-microvolt-speed2-pvs5-v0 = 	< 887500>;
>> +			opp-microvolt-speed2-pvs6-v0 = 	< 887500>;
> 
> Some space then tab issues on the above. Also, drop the space after the 
> '<'.

 ok, will fix it.

> 
>> +			opp-microvolt-speed14-pvs0-v0 =	< 1000000>;
>> +			opp-microvolt-speed14-pvs1-v0 =	< 975000>;
>> +			opp-microvolt-speed14-pvs2-v0 =	< 937500>;
>> +			opp-microvolt-speed14-pvs3-v0 =	< 900000>;
>> +			opp-microvolt-speed14-pvs4-v0 =	< 887500>;
>> +			opp-microvolt-speed14-pvs5-v0 =	< 887500>;
>> +			opp-microvolt-speed14-pvs6-v0 =	< 887500>;
>> +		};
>> +
>> +		opp-702000000 {
>> +			 opp-hz = /bits/ 64 <702000000>;
>> +			 opp-microvolt-speed0-pvs0-v0 =  <1025000>;
>> +			 opp-microvolt-speed0-pvs1-v0 =  <975000>;
>> +			 opp-microvolt-speed0-pvs3-v0 =  <925000>;
>> +			 opp-microvolt-speed0-pvs3-v0 =  <925000>;
>> +			 opp-microvolt-speed1-pvs0-v0 =  <962500>;
>> +			 opp-microvolt-speed1-pvs1-v0 =  <962500>;
>> +			 opp-microvolt-speed1-pvs2-v0 =  <925000>;
>> +			 opp-microvolt-speed1-pvs3-v0 =  <900000>;
>> +			 opp-microvolt-speed1-pvs4-v0 =  <875000>;
>> +			 opp-microvolt-speed1-pvs5-v0 =  <875000>;
>> +			 opp-microvolt-speed1-pvs6-v0 =  <875000>;
>> +			 opp-microvolt-speed2-pvs0-v0 =  <950000>;
>> +			 opp-microvolt-speed2-pvs1-v0 =  <925000>;
>> +			 opp-microvolt-speed2-pvs2-v0 =  <900000>;
>> +			 opp-microvolt-speed2-pvs3-v0 =  <900000>;
>> +			 opp-microvolt-speed2-pvs4-v0 =  <875000>;
>> +			 opp-microvolt-speed2-pvs5-v0 =  <875000>;
>> +			 opp-microvolt-speed2-pvs6-v0 =  <875000>;
>> +			 opp-microvolt-speed14-pvs0-v0 = <962500>;
>> +			 opp-microvolt-speed14-pvs1-v0 = <962500>;
>> +			 opp-microvolt-speed14-pvs2-v0 = <925000>;
>> +			 opp-microvolt-speed14-pvs3-v0 = <900000>;
>> +			 opp-microvolt-speed14-pvs4-v0 = <875000>;
>> +			 opp-microvolt-speed14-pvs5-v0 = <875000>;
>> +			 opp-microvolt-speed14-pvs6-v0 = <875000>;
>> +		};
>> +
>> +		opp-594000000 {
>> +			opp-hz = /bits/ 64 <594000000>;
>> +			opp-microvolt-speed0-pvs0-v0 =  <1000000>;
>> +			opp-microvolt-speed0-pvs1-v0 = 	<950000>;
>> +			opp-microvolt-speed0-pvs3-v0 = 	<900000>;
>> +			opp-microvolt-speed0-pvs3-v0 = 	<900000>;
>> +			opp-microvolt-speed1-pvs0-v0 = 	<950000>;
>> +			opp-microvolt-speed1-pvs1-v0 = 	<950000>;
>> +			opp-microvolt-speed1-pvs2-v0 = 	<925000>;
>> +			opp-microvolt-speed1-pvs3-v0 = 	<900000>;
>> +			opp-microvolt-speed1-pvs4-v0 = 	<875000>;
>> +			opp-microvolt-speed1-pvs5-v0 = 	<875000>;
>> +			opp-microvolt-speed1-pvs6-v0 = 	<875000>;
>> +			opp-microvolt-speed2-pvs0-v0 = 	<950000>;
>> +			opp-microvolt-speed2-pvs1-v0 = 	<925000>;
>> +			opp-microvolt-speed2-pvs2-v0 = 	<900000>;
>> +			opp-microvolt-speed2-pvs3-v0 = 	<900000>;
>> +			opp-microvolt-speed2-pvs4-v0 = 	<875000>;
>> +			opp-microvolt-speed2-pvs5-v0 = 	<875000>;
>> +			opp-microvolt-speed2-pvs6-v0 = 	<875000>;
> 
> More space then tab issues after the '='.
> 
 ok, will fix.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
