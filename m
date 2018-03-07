Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934850AbeCGUlU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 15:41:20 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:46350 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934411AbeCGUlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 15:41:17 -0500
X-Google-Smtp-Source: AG47ELuiHJM98GuNOIMiuOm5zKfXUiZ2mSQU1JVSL3BTJ7KwVsz9EgWJAjgE9U03MNEbvcjFklRsTQ==
Date: Wed, 7 Mar 2018 14:41:15 -0600
From: Rob Herring <robh@kernel.org>
To: Ilia Lin <ilialin@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org, mark.rutland@arm.com,
        amit.kucheria@linaro.org, nicolas.dechesne@linaro.org,
        celster@codeaurora.org, tfinkel@codeaurora.org
Subject: Re: [PATCH 2/2] dt-bindings: Add support for SAW documentation
Message-ID: <20180307204115.mugm7m3egrc73og2@rob-hp-laptop>
References: <1520166709-554-1-git-send-email-ilialin@codeaurora.org>
 <1520166709-554-3-git-send-email-ilialin@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520166709-554-3-git-send-email-ilialin@codeaurora.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 04, 2018 at 02:31:49PM +0200, Ilia Lin wrote:
> Add support for SAW controlled regulators in 8x96.
> Document it.
> 
> Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
> ---
>  .../bindings/regulator/qcom,spmi-regulator.txt     | 45 ++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
> index 57d2c65..406f2e5 100644
> --- a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
> +++ b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
> @@ -110,6 +110,11 @@ Qualcomm SPMI Regulators
>  	Definition: Reference to regulator supplying the input pin, as
>  		    described in the data sheet.
>  
> +- qcom,saw-reg:
> +	Usage: optional
> +	Value type: <phandle>
> +	Description: Reference to syscon node defining the SAW registers.
> +
>  
>  The regulator node houses sub-nodes for each regulator within the device. Each
>  sub-node is identified using the node's name, with valid values listed for each
> @@ -201,6 +206,17 @@ see regulator.txt - with additional custom properties described below:
>  			2 = 0.55 uA
>  			3 = 0.75 uA
>  
> +- qcom,saw-slave:
> +	Usage: optional
> +	Value type: <boo>
> +	Description: SAW controlled gang slave. Will not be configured.
> +
> +- qcom,saw-leader:
> +	Usage: optional
> +	Value type: <boo>
> +	Description: SAW controlled gang leader. Will be configured as
> +		     SAW regulator.
> +
>  Example:
>  
>  	regulators {
> @@ -221,3 +237,32 @@ Example:
>  
>  		....
>  	};
> +
> +Example 2:
> +
> +	saw3: syscon@9A10000 {
> +		compatible = "syscon";

syscon should not be used alone. It should have a specific compatible 
too.

> +		reg = <0x9A10000 0x1000>;
> +	};
> +
> +	...
> +
> +	spm-regulators {
> +		compatible = "qcom,pm8994-regulators";
> +		qcom,saw-reg = <&saw3>;

Why not just a child of the syscon?

> +		s8 {
> +			qcom,saw-slave;
> +		};
> +		s9 {
> +			qcom,saw-slave;
> +		};
> +		s10 {
> +			qcom,saw-slave;
> +		};
> +		pm8994_s11_saw: s11 {
> +			qcom,saw-leader;
> +			regulator-always-on;
> +			regulator-min-microvolt = <900000>;
> +			regulator-max-microvolt = <1140000>;
> +		};
> +	};
> -- 
> Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
