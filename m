Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752522AbeBICy6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 21:54:58 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35738 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752465AbeBICyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 21:54:51 -0500
X-Google-Smtp-Source: AH8x224X8UK4/IeYxHLS+gqnHsnqdIUMphdcoBzheqkUPLnvARS8f0l6RXtdh6a5J44lhDfnLaAf9w==
Date: Thu, 8 Feb 2018 20:54:49 -0600
From: Rob Herring <robh@kernel.org>
To: Sricharan R <sricharan@codeaurora.org>
Cc: viresh.kumar@linaro.org, mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@codeaurora.org, linux@armlinux.org.uk, andy.gross@linaro.org,
        david.brown@linaro.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 15/15] dt-bindings: cpufreq: Document
 operating-points-v2-krait-cpu
Message-ID: <20180209025449.qvbirdvflijxo62j@rob-hp-laptop>
References: <1517890108-8140-1-git-send-email-sricharan@codeaurora.org>
 <1517890108-8140-16-git-send-email-sricharan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517890108-8140-16-git-send-email-sricharan@codeaurora.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06, 2018 at 09:38:28AM +0530, Sricharan R wrote:
> In Certain QCOM SoCs like ipq8064, apq8064, msm8960, msm8974
> that has KRAIT processors the voltage/current value of each OPP
> varies based on the silicon variant in use.
> operating-points-v2-krait-cpu specifies the phandle to nvmem efuse cells
> and the operating-points-v2 table for each opp. The qcom-cpufreq driver
> reads the efuse value from the SoC to provide the required information
> that is used to determine the voltage and current value for each OPP of
> operating-points-v2 table when it is parsed by the OPP framework.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---
>  .../devicetree/bindings/cpufreq/krait-cpufreq.txt  | 363 +++++++++++++++++++++
>  1 file changed, 363 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/krait-cpufreq.txt
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/krait-cpufreq.txt b/Documentation/devicetree/bindings/cpufreq/krait-cpufreq.txt
> new file mode 100644
> index 0000000..e7351f7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/krait-cpufreq.txt
> @@ -0,0 +1,363 @@
> +QCOM KRAIT CPUFreq and OPP bindings
> +===================================
> +
> +In Certain QCOM SoCs like ipq8064, apq8064, msm8960, msm8974
> +that has KRAIT processors the voltage value of each OPP varies
> +based on the silicon variant in use. Qualcomm Process Voltage Scaling Tables
> +defines the voltage and current value based on the speed/pvs/version
> +combination blown in the efuse. The qcom-cpufreq driver reads the efuse
> +value from the SoC to provide the OPP framework with required information.
> +This is used to determine the voltage and current value for each OPP of
> +operating-points-v2 table when it is parsed by the OPP framework.
> +
> +Required properties:
> +--------------------
> +In 'cpus' nodes:
> +- operating-points-v2: Phandle to the operating-points-v2 table to use.
> +
> +In 'operating-points-v2' table:
> +- compatible: Should be
> +	- 'operating-points-v2-krait-cpu' for ipq8064, apq8064, msm8960,
> +					      msm8974.
> +- nvmem-cells: A phandle pointing to a nvmem-cells node representing the
> +		efuse registers that has information about the
> +		speedbin/pvs/version that is used to select the right
> +		voltage/current value pair. Note that the length field of the
> +		nvmem-cell is used to differentiate between format 'A' or 'B'
> +		efuse settings. len of '4' bytes is for format 'A' and '8'
> +		bytes for format 'B'. Please refer the for nvmem-cells
> +		bindings Documentation/devicetree/bindings/nvmem/nvmem.txt
> +		and also examples below for both the cases.
> +Example 1:
> +---------
> +
> +/* For arch/arm/boot/dts/apq8064.dtsi --> format 'A' */
> +cpus {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	CPU0: cpu@0 {
> +		compatible = "qcom,krait";
> +		enable-method = "qcom,kpss-acc-v1";
> +		device_type = "cpu";
> +		reg = <0>;
> +		next-level-cache = <&L2>;
> +		qcom,acc = <&acc0>;
> +		qcom,saw = <&saw0>;
> +		cpu-idle-states = <&CPU_SPC>;
> +		operating-points-v2 = <&cpu_opp_table>;
> +	};
> +};
> +
> +qfprom: qfprom@700000 {
> +	  compatible      = "qcom,qfprom";
> +	  reg	      = <0x00700000 0x1000>;
> +	  #address-cells  = <1>;
> +	  #size-cells     = <1>;
> +	  ranges;
> +	  pvs_efuse: pvs {
> +		reg = <0xc0 0x4>;
> +	};
> +};
> +
> +cpu_opp_table: opp-table {
> +	compatible = "operating-points-v2-krait-cpu";
> +	nvmem-cells = <&pvs_efuse>;
> +
> +		/*
> +		 * Missing opp-shared property means CPUs switch DVFS states
> +		 * independently.
> +		 */
> +
> +	       opp-918000000 {
> +			opp-hz = /bits/ 64 <918000000>;
> +			opp-microvolt-speed0-pvs0-v0 = <1100000>;

Where is this property defined? I'm not that happy with it, but don't 
have a better suggestion. Maybe make pvsN be an array of values with 0 
for any skipped indexes? The '-v0' seems pointless. 

> +			opp-microvolt-speed0-pvs1-v0 = <1050000>;
> +			opp-microvolt-speed0-pvs3-v0 = <1000000>;
> +			opp-microvolt-speed0-pvs4-v0 = <975000>;
> +			opp-microvolt-speed1-pvs0-v0 = <1025000>;
> +			opp-microvolt-speed1-pvs1-v0 = <1000000>;
> +			opp-microvolt-speed1-pvs2-v0 = <950000>;
> +			opp-microvolt-speed1-pvs3-v0 = <925000>;
> +			opp-microvolt-speed1-pvs4-v0 = <900000>;
> +			opp-microvolt-speed1-pvs5-v0 = <900000>;
> +			opp-microvolt-speed1-pvs6-v0 = <900000>;
> +			opp-microvolt-speed2-pvs0-v0 = <975000>;
> +			opp-microvolt-speed2-pvs1-v0 = <950000>;
> +			opp-microvolt-speed2-pvs2-v0 = <925000>;
> +			opp-microvolt-speed2-pvs3-v0 = <912500>;
> +			opp-microvolt-speed2-pvs4-v0 = <900000>;
> +			opp-microvolt-speed2-pvs5-v0 = <900000>;
> +			opp-microvolt-speed2-pvs6-v0 = <900000>;
> +			opp-microvolt-speed14-pvs0-v0 = <1025000>;
> +			opp-microvolt-speed14-pvs1-v0 = <1000000>;
> +			opp-microvolt-speed14-pvs2-v0 = <950000>;
> +			opp-microvolt-speed14-pvs3-v0 = <925000>;
> +			opp-microvolt-speed14-pvs4-v0 = <900000>;
> +			opp-microvolt-speed14-pvs5-v0 = <900000>;
> +			opp-microvolt-speed14-pvs6-v0 = <900000>;
> +		};
> +
> +		opp-810000000 {
> +			opp-hz = /bits/ 64 <810000000>;
> +			opp-microvolt-speed0-pvs0-v0 =  < 1075000>;
> +			opp-microvolt-speed0-pvs1-v0 = 	< 1025000>;
> +			opp-microvolt-speed0-pvs3-v0 = 	< 975000>;
> +			opp-microvolt-speed0-pvs3-v0 = 	< 962500>;
> +			opp-microvolt-speed1-pvs0-v0 = 	< 1000000>;
> +			opp-microvolt-speed1-pvs1-v0 = 	< 975000>;
> +			opp-microvolt-speed1-pvs2-v0 = 	< 937500>;
> +			opp-microvolt-speed1-pvs3-v0 = 	< 900000>;
> +			opp-microvolt-speed1-pvs4-v0 = 	< 887500>;
> +			opp-microvolt-speed1-pvs5-v0 = 	< 887500>;
> +			opp-microvolt-speed1-pvs6-v0 = 	< 887500>;
> +			opp-microvolt-speed2-pvs0-v0 = 	< 962500>;
> +			opp-microvolt-speed2-pvs1-v0 = 	< 937500>;
> +			opp-microvolt-speed2-pvs2-v0 = 	< 912500>;
> +			opp-microvolt-speed2-pvs3-v0 = 	< 900000>;
> +			opp-microvolt-speed2-pvs4-v0 = 	< 887500>;
> +			opp-microvolt-speed2-pvs5-v0 = 	< 887500>;
> +			opp-microvolt-speed2-pvs6-v0 = 	< 887500>;

Some space then tab issues on the above. Also, drop the space after the 
'<'.

> +			opp-microvolt-speed14-pvs0-v0 =	< 1000000>;
> +			opp-microvolt-speed14-pvs1-v0 =	< 975000>;
> +			opp-microvolt-speed14-pvs2-v0 =	< 937500>;
> +			opp-microvolt-speed14-pvs3-v0 =	< 900000>;
> +			opp-microvolt-speed14-pvs4-v0 =	< 887500>;
> +			opp-microvolt-speed14-pvs5-v0 =	< 887500>;
> +			opp-microvolt-speed14-pvs6-v0 =	< 887500>;
> +		};
> +
> +		opp-702000000 {
> +			 opp-hz = /bits/ 64 <702000000>;
> +			 opp-microvolt-speed0-pvs0-v0 =  <1025000>;
> +			 opp-microvolt-speed0-pvs1-v0 =  <975000>;
> +			 opp-microvolt-speed0-pvs3-v0 =  <925000>;
> +			 opp-microvolt-speed0-pvs3-v0 =  <925000>;
> +			 opp-microvolt-speed1-pvs0-v0 =  <962500>;
> +			 opp-microvolt-speed1-pvs1-v0 =  <962500>;
> +			 opp-microvolt-speed1-pvs2-v0 =  <925000>;
> +			 opp-microvolt-speed1-pvs3-v0 =  <900000>;
> +			 opp-microvolt-speed1-pvs4-v0 =  <875000>;
> +			 opp-microvolt-speed1-pvs5-v0 =  <875000>;
> +			 opp-microvolt-speed1-pvs6-v0 =  <875000>;
> +			 opp-microvolt-speed2-pvs0-v0 =  <950000>;
> +			 opp-microvolt-speed2-pvs1-v0 =  <925000>;
> +			 opp-microvolt-speed2-pvs2-v0 =  <900000>;
> +			 opp-microvolt-speed2-pvs3-v0 =  <900000>;
> +			 opp-microvolt-speed2-pvs4-v0 =  <875000>;
> +			 opp-microvolt-speed2-pvs5-v0 =  <875000>;
> +			 opp-microvolt-speed2-pvs6-v0 =  <875000>;
> +			 opp-microvolt-speed14-pvs0-v0 = <962500>;
> +			 opp-microvolt-speed14-pvs1-v0 = <962500>;
> +			 opp-microvolt-speed14-pvs2-v0 = <925000>;
> +			 opp-microvolt-speed14-pvs3-v0 = <900000>;
> +			 opp-microvolt-speed14-pvs4-v0 = <875000>;
> +			 opp-microvolt-speed14-pvs5-v0 = <875000>;
> +			 opp-microvolt-speed14-pvs6-v0 = <875000>;
> +		};
> +
> +		opp-594000000 {
> +			opp-hz = /bits/ 64 <594000000>;
> +			opp-microvolt-speed0-pvs0-v0 =  <1000000>;
> +			opp-microvolt-speed0-pvs1-v0 = 	<950000>;
> +			opp-microvolt-speed0-pvs3-v0 = 	<900000>;
> +			opp-microvolt-speed0-pvs3-v0 = 	<900000>;
> +			opp-microvolt-speed1-pvs0-v0 = 	<950000>;
> +			opp-microvolt-speed1-pvs1-v0 = 	<950000>;
> +			opp-microvolt-speed1-pvs2-v0 = 	<925000>;
> +			opp-microvolt-speed1-pvs3-v0 = 	<900000>;
> +			opp-microvolt-speed1-pvs4-v0 = 	<875000>;
> +			opp-microvolt-speed1-pvs5-v0 = 	<875000>;
> +			opp-microvolt-speed1-pvs6-v0 = 	<875000>;
> +			opp-microvolt-speed2-pvs0-v0 = 	<950000>;
> +			opp-microvolt-speed2-pvs1-v0 = 	<925000>;
> +			opp-microvolt-speed2-pvs2-v0 = 	<900000>;
> +			opp-microvolt-speed2-pvs3-v0 = 	<900000>;
> +			opp-microvolt-speed2-pvs4-v0 = 	<875000>;
> +			opp-microvolt-speed2-pvs5-v0 = 	<875000>;
> +			opp-microvolt-speed2-pvs6-v0 = 	<875000>;

More space then tab issues after the '='.

> +			opp-microvolt-speed14-pvs0-v0 =	<950000>;
> +			opp-microvolt-speed14-pvs1-v0 =	<950000>;
> +			opp-microvolt-speed14-pvs2-v0 =	<925000>;
> +			opp-microvolt-speed14-pvs3-v0 =	<900000>;
> +			opp-microvolt-speed14-pvs4-v0 =	<875000>;
> +			opp-microvolt-speed14-pvs5-v0 =	<875000>;
> +			opp-microvolt-speed14-pvs6-v0 =	<875000>;
> +		};
> +
> +		opp-486000000 {
> +			 opp-hz = /bits/ 64 <486000000>;
> +			 opp-microvolt-speed0-pvs0-v0 = <975000>;
> +			 opp-microvolt-speed0-pvs1-v0 = <925000>;
> +			 opp-microvolt-speed0-pvs3-v0 = <875000>;
> +			 opp-microvolt-speed0-pvs3-v0 = <875000>;
> +			 opp-microvolt-speed1-pvs0-v0 = <950000>;
> +			 opp-microvolt-speed1-pvs1-v0 = <950000>;
> +			 opp-microvolt-speed1-pvs2-v0 = <925000>;
> +			 opp-microvolt-speed1-pvs3-v0 = <900000>;
> +			 opp-microvolt-speed1-pvs4-v0 = <875000>;
> +			 opp-microvolt-speed1-pvs5-v0 = <875000>;
> +			 opp-microvolt-speed1-pvs6-v0 = <875000>;
> +			 opp-microvolt-speed2-pvs0-v0 = <950000>;
> +			 opp-microvolt-speed2-pvs1-v0 = <925000>;
> +			 opp-microvolt-speed2-pvs2-v0 = <900000>;
> +			 opp-microvolt-speed2-pvs3-v0 = <900000>;
> +			 opp-microvolt-speed2-pvs4-v0 = <875000>;
> +			 opp-microvolt-speed2-pvs5-v0 = <875000>;
> +			 opp-microvolt-speed2-pvs6-v0 = <875000>;
> +			 opp-microvolt-speed14-pvs0-v0 = <950000>;
> +			 opp-microvolt-speed14-pvs1-v0 = <950000>;
> +			 opp-microvolt-speed14-pvs2-v0 = <925000>;
> +			 opp-microvolt-speed14-pvs3-v0 = <900000>;
> +			 opp-microvolt-speed14-pvs4-v0 = <875000>;
> +			 opp-microvolt-speed14-pvs5-v0 = <875000>;
> +			 opp-microvolt-speed14-pvs6-v0 = <875000>;
> +		};
> +
> +		opp-384000000 {
> +			opp-hz = /bits/ 64 <384000000>;
> +			opp-microvolt-speed0-pvs0-v0 = <950000>;
> +			opp-microvolt-speed0-pvs1-v0 = <900000>;
> +			opp-microvolt-speed0-pvs3-v0 = <850000>;
> +			opp-microvolt-speed0-pvs3-v0 = <850000>;
> +			opp-microvolt-speed1-pvs0-v0 = <950000>;
> +			opp-microvolt-speed1-pvs1-v0 = <950000>;
> +			opp-microvolt-speed1-pvs2-v0 = <925000>;
> +			opp-microvolt-speed1-pvs3-v0 = <900000>;
> +			opp-microvolt-speed1-pvs4-v0 = <875000>;
> +			opp-microvolt-speed1-pvs5-v0 = <875000>;
> +			opp-microvolt-speed1-pvs6-v0 = <875000>;
> +			opp-microvolt-speed2-pvs0-v0 = <950000>;
> +			opp-microvolt-speed2-pvs1-v0 = <925000>;
> +			opp-microvolt-speed2-pvs2-v0 = <900000>;
> +			opp-microvolt-speed2-pvs3-v0 = <900000>;
> +			opp-microvolt-speed2-pvs4-v0 = <875000>;
> +			opp-microvolt-speed2-pvs5-v0 = <875000>;
> +			opp-microvolt-speed2-pvs6-v0 = <875000>;
> +			opp-microvolt-speed14-pvs0-v0 = <950000>;
> +			opp-microvolt-speed14-pvs1-v0 = <950000>;
> +			opp-microvolt-speed14-pvs2-v0 = <925000>;
> +			opp-microvolt-speed14-pvs3-v0 = <900000>;
> +			opp-microvolt-speed14-pvs4-v0 = <875000>;
> +			opp-microvolt-speed14-pvs5-v0 = <875000>;
> +			opp-microvolt-speed14-pvs6-v0 = <875000>;
> +		};
> +};
> +
> +EXAMPLE 2:
> +---------
> +/* For arch/arm/boot/dts/qcom-msm8974.dtsi--> format 'B' */
> +
> +qfprom: qfprom@700000 {
> +	  compatible      = "qcom,qfprom";
> +	  reg	      = <0x00700000 0x1000>;
> +	  #address-cells  = <1>;
> +	  #size-cells     = <1>;
> +	  ranges;
> +	  pvs_efuse: pvs {
> +		reg = <0xc0 0x8>;
> +	};
> +};
> +
> +cpu_opp_table: opp-table {
> +	compatible = "operating-points-v2-krait-cpu";
> +	nvmem-cells = <&pvs_efuse>;
> +
> +		/*
> +		 * Missing opp-shared property means CPUs switch DVFS states
> +		 * independently.
> +		 */
> +	opp-960000000 {
> +		opp-hz = /bits/ 64 <960000000>;
> +		opp-microvolt-speed0-pvs0-v0 = <915000>;
> +		opp-microvolt-speed0-pvs1-v0 = <895000>;
> +		opp-microvolt-speed0-pvs2-v0 = <875000>;
> +		opp-microvolt-speed0-pvs3-v0 = <860000>;
> +		opp-microvolt-speed0-pvs4-v0 = <850000>;
> +		opp-microvolt-speed0-pvs5-v0 = <840000>;
> +		opp-microvolt-speed0-pvs6-v0 = <830000>;
> +		opp-microvolt-speed2-pvs0-v0 = <875000>;
> +		opp-microvolt-speed2-pvs1-v0 = <860000>;
> +		opp-microvolt-speed2-pvs2-v0 = <845000>;
> +		opp-microvolt-speed2-pvs3-v0 = <830000>;
> +		opp-microvolt-speed2-pvs4-v0 = <820000>;
> +		opp-microvolt-speed2-pvs5-v0 = <810000>;
> +		opp-microvolt-speed2-pvs6-v0 = <800000>;
> +		opp-microvolt-speed1-pvs0-v0 = <840000>;
> +		opp-microvolt-speed1-pvs1-v0 = <825000>;
> +		opp-microvolt-speed1-pvs2-v0 = <810000>;
> +		opp-microvolt-speed1-pvs3-v0 = <795000>;
> +		opp-microvolt-speed1-pvs4-v0 = <785000>;
> +		opp-microvolt-speed1-pvs5-v0 = <775000>;
> +		opp-microvolt-speed1-pvs6-v0 = <765000>;
> +
> +		opp-microamp-speed0-pvs0-v0 = <252>;
> +		opp-microamp-speed0-pvs1-v0 = <252>;
> +		opp-microamp-speed0-pvs2-v0 = <252>;
> +		opp-microamp-speed0-pvs3-v0 = <252>;
> +		opp-microamp-speed0-pvs4-v0 = <252>;
> +		opp-microamp-speed0-pvs5-v0 = <252>;
> +		opp-microamp-speed0-pvs6-v0 = <252>;
> +		opp-microamp-speed2-pvs0-v0 = <245>;
> +		opp-microamp-speed2-pvs1-v0 = <245>;
> +		opp-microamp-speed2-pvs2-v0 = <245>;
> +		opp-microamp-speed2-pvs3-v0 = <245>;
> +		opp-microamp-speed2-pvs4-v0 = <245>;
> +		opp-microamp-speed2-pvs5-v0 = <245>;
> +		opp-microamp-speed2-pvs6-v0 = <245>;
> +		opp-microamp-speed1-pvs0-v0 = <242>;
> +		opp-microamp-speed1-pvs1-v0 = <242>;
> +		opp-microamp-speed1-pvs2-v0 = <242>;
> +		opp-microamp-speed1-pvs3-v0 = <242>;
> +		opp-microamp-speed1-pvs4-v0 = <242>;
> +		opp-microamp-speed1-pvs5-v0 = <242>;
> +		opp-microamp-speed1-pvs6-v0 = <242>;
> +	};
> +
> +	opp-883200000 {
> +		opp-hz = /bits/ 64 <883200000>;
> +		opp-microvolt-speed0-pvs0-v0 = <900000>;
> +		opp-microvolt-speed0-pvs1-v0 = <885000>;
> +		opp-microvolt-speed0-pvs2-v0 = <865000>;
> +		opp-microvolt-speed0-pvs3-v0 = <850000>;
> +		opp-microvolt-speed0-pvs4-v0 = <840000>;
> +		opp-microvolt-speed0-pvs5-v0 = <830000>;
> +		opp-microvolt-speed0-pvs6-v0 = <820000>;
> +		opp-microvolt-speed2-pvs0-v0 = <865000>;
> +		opp-microvolt-speed2-pvs1-v0 = <850000>;
> +		opp-microvolt-speed2-pvs2-v0 = <835000>;
> +		opp-microvolt-speed2-pvs3-v0 = <820000>;
> +		opp-microvolt-speed2-pvs4-v0 = <810000>;
> +		opp-microvolt-speed2-pvs5-v0 = <800000>;
> +		opp-microvolt-speed2-pvs6-v0 = <790000>;
> +		opp-microvolt-speed1-pvs0-v0 = <830000>;
> +		opp-microvolt-speed1-pvs1-v0 = <815000>;
> +		opp-microvolt-speed1-pvs2-v0 = <800000>;
> +		opp-microvolt-speed1-pvs3-v0 = <785000>;
> +		opp-microvolt-speed1-pvs4-v0 = <775000>;
> +		opp-microvolt-speed1-pvs5-v0 = <765000>;
> +		opp-microvolt-speed1-pvs6-v0 = <755000>;
> +
> +		opp-microamp-speed0-pvs0-v0 = <229>;
> +		opp-microamp-speed0-pvs1-v0 = <229>;
> +		opp-microamp-speed0-pvs2-v0 = <229>;
> +		opp-microamp-speed0-pvs3-v0 = <229>;
> +		opp-microamp-speed0-pvs4-v0 = <229>;
> +		opp-microamp-speed0-pvs5-v0 = <229>;
> +		opp-microamp-speed0-pvs6-v0 = <229>;
> +		opp-microamp-speed2-pvs0-v0 = <223>;
> +		opp-microamp-speed2-pvs1-v0 = <223>;
> +		opp-microamp-speed2-pvs2-v0 = <223>;
> +		opp-microamp-speed2-pvs3-v0 = <223>;
> +		opp-microamp-speed2-pvs4-v0 = <223>;
> +		opp-microamp-speed2-pvs5-v0 = <223>;
> +		opp-microamp-speed2-pvs6-v0 = <223>;
> +		opp-microamp-speed1-pvs0-v0 = <221>;
> +		opp-microamp-speed1-pvs1-v0 = <221>;
> +		opp-microamp-speed1-pvs2-v0 = <221>;
> +		opp-microamp-speed1-pvs3-v0 = <221>;
> +		opp-microamp-speed1-pvs4-v0 = <221>;
> +		opp-microamp-speed1-pvs5-v0 = <221>;
> +		opp-microamp-speed1-pvs6-v0 = <221>;
> +	};
> +};
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
> 
