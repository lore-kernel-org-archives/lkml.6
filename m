Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755681AbeEAAUQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 20:20:16 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38229 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751346AbeEAAUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 20:20:13 -0400
X-Google-Smtp-Source: AB8JxZrbdCT5JEZIMEsi+BIVjO75fAKyf8FoZZPiJOoUFiteQgP0Y5cUBSQUgKI0luEBdG++TcjlOA==
Date: Mon, 30 Apr 2018 17:20:10 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Sibi Sankar <sibis@codeaurora.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-soc@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: Add SDM845 SMEM nodes
Message-ID: <20180501002009.GP18510@minitux>
References: <20180430144428.3288-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180430144428.3288-1-sibis@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 30 Apr 07:44 PDT 2018, Sibi Sankar wrote:

> Add all the necessary dt nodes to support SMEM driver
> on SDM845. It also adds the required memory carveouts
> so that the kernel does not access memory that is in
> use.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
> 
> This patch depends on:
> https://patchwork.kernel.org/patch/10276419/
> https://patchwork.kernel.org/patch/10363361/
> 
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 38 ++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 9be763da0664..55e7d7e23b10 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -21,6 +21,27 @@
>  		reg = <0 0x80000000 0 0>;
>  	};
>  
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		memory@85fc0000 {
> +			reg = <0 0x85fc0000 0 0x20000>;
> +			no-map;
> +		};
> +
> +		smem_mem: memory@86000000 {
> +			reg = <0x0 0x86000000 0x0 0x200000>;
> +			no-map;
> +		};
> +
> +		memory@86200000 {
> +			reg = <0 0x86200000 0 0x2d00000>;
> +			no-map;
> +		};
> +	};
> +
>  	cpus {
>  		#address-cells = <2>;
>  		#size-cells = <0>;
> @@ -147,6 +168,18 @@
>  		};
>  	};
>  
> +	tcsr_mutex: hwlock {
> +		compatible = "qcom,tcsr-mutex";
> +		syscon = <&tcsr_mutex_regs 0 0x1000>;
> +		#hwlock-cells = <1>;
> +	};
> +
> +	smem {
> +		compatible = "qcom,smem";
> +		memory-region = <&smem_mem>;
> +		hwlocks = <&tcsr_mutex 3>;
> +	};
> +
>  	psci {
>  		compatible = "arm,psci-1.0";
>  		method = "smc";
> @@ -339,6 +372,11 @@
>  			};
>  		};
>  
> +		tcsr_mutex_regs: syscon@1f40000 {
> +			compatible = "syscon";
> +			reg = <0x1f40000 0x40000>;
> +		};
> +
>  		apss_shared: mailbox@17990000 {
>  			compatible = "qcom,sdm845-apss-shared";
>  			reg = <0x17990000 0x1000>;
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
