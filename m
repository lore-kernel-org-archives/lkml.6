Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751454AbeEDGLb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 02:11:31 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:41756 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751262AbeEDGL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 02:11:27 -0400
X-Google-Smtp-Source: AB8JxZrPhZPoVFfPK/FJbvDSffRXYuUARmH0rdTHr5rO2xhkF2lvGFC9D39fgtzSIkcaBnXMF8SsZA==
Date: Fri, 4 May 2018 11:41:23 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ilia Lin <ilialin@codeaurora.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
        mark.rutland@arm.com, rjw@rjwysocki.net, lgirdwood@gmail.com,
        broonie@kernel.org, andy.gross@linaro.org, david.brown@linaro.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rnayak@codeaurora.org,
        amit.kucheria@linaro.org, nicolas.dechesne@linaro.org,
        celster@codeaurora.org, tfinkel@codeaurora.org
Subject: Re: [PATCH v5 13/14] dt-bindings: cpufreq: Document
 operating-points-v2-kryo-cpu
Message-ID: <20180504061123.lf2ffpami23d3q72@vireshk-i7>
References: <1525348355-25471-1-git-send-email-ilialin@codeaurora.org>
 <1525348355-25471-14-git-send-email-ilialin@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525348355-25471-14-git-send-email-ilialin@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-05-18, 14:52, Ilia Lin wrote:
> In Certain Qualcomm Technologies, Inc. SoCs like apq8096 and msm8996
> that have KRYO processors, the CPU ferequencies subset and voltage value
> of each OPP varies based on the silicon variant in use.
> Qualcomm Technologies, Inc. Process Voltage Scaling Tables
> defines the voltage and frequency value based on the msm-id in SMEM
> and speedbin blown in the efuse combination.
> The qcom-cpufreq-kryo driver reads the msm-id and efuse value from the SoC
> to provide the OPP framework with required information.
> This is used to determine the voltage and frequency value for each OPP of
> operating-points-v2 table when it is parsed by the OPP framework.
> 
> This change adds documentation.
> 
> Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
> ---
>  .../devicetree/bindings/opp/kryo-cpufreq.txt       | 693 +++++++++++++++++++++
>  1 file changed, 693 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/opp/kryo-cpufreq.txt
> 
> diff --git a/Documentation/devicetree/bindings/opp/kryo-cpufreq.txt b/Documentation/devicetree/bindings/opp/kryo-cpufreq.txt
> new file mode 100644
> index 0000000..20cef9d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/opp/kryo-cpufreq.txt
> @@ -0,0 +1,693 @@
> +Qualcomm Technologies, Inc. KRYO CPUFreq and OPP bindings
> +===================================
> +
> +In Certain Qualcomm Technologies, Inc. SoCs like apq8096 and msm8996
> +that have KRYO processors, the CPU ferequencies subset and voltage value
> +of each OPP varies based on the silicon variant in use.
> +Qualcomm Technologies, Inc. Process Voltage Scaling Tables
> +defines the voltage and frequency value based on the msm-id in SMEM
> +and speedbin blown in the efuse combination.
> +The qcom-cpufreq-kryo driver reads the msm-id and efuse value from the SoC
> +to provide the OPP framework with required information (existing HW bitmap).
> +This is used to determine the voltage and frequency value for each OPP of
> +operating-points-v2 table when it is parsed by the OPP framework.
> +
> +Required properties:
> +--------------------
> +In 'cpus' nodes:
> +- operating-points-v2: Phandle to the operating-points-v2 table to use.
> +
> +In 'operating-points-v2' table:
> +- compatible: Should be
> +	- 'operating-points-v2-kryo-cpu' for apq8096 and msm8996.
> +- nvmem-cells: A phandle pointing to a nvmem-cells node representing the
> +		efuse registers that has information about the
> +		speedbin that is used to select the right frequency/voltage
> +		value pair.
> +		Please refer the for nvmem-cells
> +		bindings Documentation/devicetree/bindings/nvmem/nvmem.txt
> +		and also examples below.
> +
> +In every OPP node:
> +- opp-supported-hw: A single 32 bit bitmap value, representing compatible HW.
> +		    Bitmap:
> +			0:	MSM8996 V3, speedbin 0
> +			1:	MSM8996 V3, speedbin 1
> +			2:	MSM8996 V3, speedbin 2
> +			3:	unused
> +			4:	MSM8996 SG, speedbin 0
> +			5:	MSM8996 SG, speedbin 1
> +			6:	MSM8996 SG, speedbin 2
> +			7-31:	unused
> +
> +Example 1:
> +---------
> +
> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		CPU0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "qcom,kryo";
> +			reg = <0x0 0x0>;
> +			enable-method = "psci";
> +			clocks = <&kryocc 0>;
> +			cpu-supply = <&pm8994_s11_saw>;
> +			operating-points-v2 = <&cluster0_opp>;
> +			/* cooling options */
> +			cooling-min-level = <0>;
> +			cooling-max-level = <15>;

cooling min/max aren't required anymore, as I told you in the previous
version :)

> +	cluster0_opp: opp_table0 {
> +		compatible = "operating-points-v2-kryo-cpu";
> +		nvmem-cells = <&speedbin_efuse>;
> +		opp-shared;
> +
> +		opp-307200000 {
> +			opp-hz = /bits/ 64 <  307200000 >;

You fixed spacing around frequency values in the dts but not here.

> +			opp-microvolt = <905000 905000 1140000>;
> +			opp-supported-hw = <0x77>;
> +			clock-latency-ns = <200000>;
> +		};

-- 
viresh
