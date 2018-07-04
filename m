Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6D8C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 19:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1972C219A6
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 19:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EDq4616M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1972C219A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752815AbeGDTCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 15:02:18 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:39478 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752567AbeGDTCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 15:02:16 -0400
Received: by mail-pf0-f195.google.com with SMTP id s21-v6so3296523pfm.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 12:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eOyDRmj8tOF5WXYmNC3jwUCPDGxh1fvdp3yERzy5Qqo=;
        b=EDq4616Mq5nbPjfsyB1fRAd4p97RbGU7YfZlW7pkpQrliS9OVGz6B7brS40lNAeLP2
         znkBW3IgcO5Pfggpq2MdgDowSlngNf2SpO3ZK9d1Zg/x9gdS0agOKy0LOgBTVABr8aOQ
         rLgrEgyrL8vvefX1cpIj97Gq3wFgPty56EKkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eOyDRmj8tOF5WXYmNC3jwUCPDGxh1fvdp3yERzy5Qqo=;
        b=sXM4yDfkHOh/Fdg+uIVdP6yD5sUo34qjSq5+tn5tH5CtpA8yvBtOoTrG3Btc2i+Xwr
         3D1MbcZtUsYdSQg7x3a07hTqTXUOJU2qgskYwSH31xUML4IlbKFn5vag7DZmMkuf3SfW
         +MhQZMS/eJjOUnIuDHREfEdz4GRsBNfE30wkehcOJexFsgrvQZXxgtRn7cZYwtlbkhZz
         NdVl4KVKaMGm6wkB7jjvYE2CUi1rVOHvycUznHVyfYbT3Un69uWA308n+/BF/V3eZXrh
         jIvIgflh59tER1oGSIAPWyWpS/hed5ymNfeTYNBtAIWe6AZPq23ygH8cCLW0FqXj69X2
         wB0g==
X-Gm-Message-State: APt69E2iNVTWo6062VYezshxnKGX/6jBRDbdjzvENJt7QqFOxu9dZiaz
        PlSweHIqSr5kfOClKvw5bgv8Gg==
X-Google-Smtp-Source: AAOMgpfCUvShN2F4EEWLYEGmQlRNVadDFNEZr3VFdi2QDIYTx6W8hElP1FYb3yQNZsj8FvvfZrWbaA==
X-Received: by 2002:a65:5c83:: with SMTP id a3-v6mr2945924pgt.164.1530730935315;
        Wed, 04 Jul 2018 12:02:15 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id g124-v6sm7125471pfb.5.2018.07.04.12.02.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 12:02:14 -0700 (PDT)
Date:   Wed, 4 Jul 2018 12:02:16 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sricharan R <sricharan@codeaurora.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm: dts: qcom: Fix 'interrupts = <>' property to use
 proper  macros
Message-ID: <20180704190216.GA16463@builder>
References: <1529486619-443-1-git-send-email-sricharan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529486619-443-1-git-send-email-sricharan@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 20 Jun 02:23 PDT 2018, Sricharan R wrote:

> Fix all nodes to use proper GIC_* macros for the interrupt type and the
> interrupt trigger settings to avoid the boot warnings.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  arch/arm/boot/dts/qcom-ipq8064.dtsi | 41 ++++++++++++++++++++++---------------
>  1 file changed, 24 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> index 1e0a3b4..70790ac 100644
> --- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> @@ -5,6 +5,7 @@
>  #include <dt-bindings/clock/qcom,gcc-ipq806x.h>
>  #include <dt-bindings/clock/qcom,lcc-ipq806x.h>
>  #include <dt-bindings/soc/qcom,gsbi.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>  
>  / {
>  	model = "Qualcomm IPQ8064";
> @@ -43,7 +44,8 @@
>  
>  	cpu-pmu {
>  		compatible = "qcom,krait-pmu";
> -		interrupts = <1 10 0x304>;
> +		interrupts = <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) |
> +					  IRQ_TYPE_LEVEL_HIGH)>;
>  	};
>  
>  	reserved-memory {
> @@ -97,7 +99,7 @@
>  			clock-names = "ahbix-clk",
>  					"mi2s-osr-clk",
>  					"mi2s-bit-clk";
> -			interrupts = <0 85 1>;
> +			interrupts = <GIC_SPI 85 IRQ_TYPE_EDGE_RISING>;
>  			interrupt-names = "lpass-irq-lpaif";
>  			reg = <0x28100000 0x10000>;
>  			reg-names = "lpass-lpaif";
> @@ -111,7 +113,7 @@
>  			#gpio-cells = <2>;
>  			interrupt-controller;
>  			#interrupt-cells = <2>;
> -			interrupts = <0 16 0x4>;
> +			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
>  		};
>  
>  		intc: interrupt-controller@2000000 {
> @@ -125,11 +127,16 @@
>  		timer@200a000 {
>  			compatible = "qcom,kpss-timer",
>  				     "qcom,kpss-wdt-ipq8064", "qcom,msm-timer";
> -			interrupts = <1 1 0x301>,
> -				     <1 2 0x301>,
> -				     <1 3 0x301>,
> -				     <1 4 0x301>,
> -				     <1 5 0x301>;
> +			interrupts = <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(2) |
> +						 IRQ_TYPE_EDGE_RISING)>,
> +				     <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(2) |
> +						 IRQ_TYPE_EDGE_RISING)>,
> +				     <GIC_PPI 3 (GIC_CPU_MASK_SIMPLE(2) |
> +						 IRQ_TYPE_EDGE_RISING)>,
> +				     <GIC_PPI 4 (GIC_CPU_MASK_SIMPLE(2) |
> +						 IRQ_TYPE_EDGE_RISING)>,
> +				     <GIC_PPI 5 (GIC_CPU_MASK_SIMPLE(2) |
> +						 IRQ_TYPE_EDGE_RISING)>;
>  			reg = <0x0200a000 0x100>;
>  			clock-frequency = <25000000>,
>  					  <32768>;
> @@ -177,7 +184,7 @@
>  				compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
>  				reg = <0x12490000 0x1000>,
>  				      <0x12480000 0x1000>;
> -				interrupts = <0 195 0x0>;
> +				interrupts = <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&gcc GSBI2_UART_CLK>, <&gcc GSBI2_H_CLK>;
>  				clock-names = "core", "iface";
>  				status = "disabled";
> @@ -186,7 +193,7 @@
>  			i2c@124a0000 {
>  				compatible = "qcom,i2c-qup-v1.1.1";
>  				reg = <0x124a0000 0x1000>;
> -				interrupts = <0 196 0>;
> +				interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>;
>  
>  				clocks = <&gcc GSBI2_QUP_CLK>, <&gcc GSBI2_H_CLK>;
>  				clock-names = "core", "iface";
> @@ -215,7 +222,7 @@
>  				compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
>  				reg = <0x16340000 0x1000>,
>  				      <0x16300000 0x1000>;
> -				interrupts = <0 152 0x0>;
> +				interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&gcc GSBI4_UART_CLK>, <&gcc GSBI4_H_CLK>;
>  				clock-names = "core", "iface";
>  				status = "disabled";
> @@ -224,7 +231,7 @@
>  			i2c@16380000 {
>  				compatible = "qcom,i2c-qup-v1.1.1";
>  				reg = <0x16380000 0x1000>;
> -				interrupts = <0 153 0>;
> +				interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
>  
>  				clocks = <&gcc GSBI4_QUP_CLK>, <&gcc GSBI4_H_CLK>;
>  				clock-names = "core", "iface";
> @@ -252,7 +259,7 @@
>  				compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
>  				reg = <0x1a240000 0x1000>,
>  				      <0x1a200000 0x1000>;
> -				interrupts = <0 154 0x0>;
> +				interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&gcc GSBI5_UART_CLK>, <&gcc GSBI5_H_CLK>;
>  				clock-names = "core", "iface";
>  				status = "disabled";
> @@ -261,7 +268,7 @@
>  			i2c@1a280000 {
>  				compatible = "qcom,i2c-qup-v1.1.1";
>  				reg = <0x1a280000 0x1000>;
> -				interrupts = <0 155 0>;
> +				interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
>  
>  				clocks = <&gcc GSBI5_QUP_CLK>, <&gcc GSBI5_H_CLK>;
>  				clock-names = "core", "iface";
> @@ -274,7 +281,7 @@
>  			spi@1a280000 {
>  				compatible = "qcom,spi-qup-v1.1.1";
>  				reg = <0x1a280000 0x1000>;
> -				interrupts = <0 155 0>;
> +				interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
>  
>  				clocks = <&gcc GSBI5_QUP_CLK>, <&gcc GSBI5_H_CLK>;
>  				clock-names = "core", "iface";
> @@ -301,7 +308,7 @@
>  				compatible = "qcom,msm-uartdm-v1.3", "qcom,msm-uartdm";
>  				reg = <0x16640000 0x1000>,
>  				      <0x16600000 0x1000>;
> -				interrupts = <0 158 0x0>;
> +				interrupts = <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&gcc GSBI7_UART_CLK>, <&gcc GSBI7_H_CLK>;
>  				clock-names = "core", "iface";
>  				status = "disabled";
> @@ -323,7 +330,7 @@
>  			compatible = "qcom,ipq806x-ahci", "generic-ahci";
>  			reg = <0x29000000 0x180>;
>  
> -			interrupts = <0 209 0x0>;
> +			interrupts = <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
>  
>  			clocks = <&gcc SFAB_SATA_S_H_CLK>,
>  				 <&gcc SATA_H_CLK>,
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc.
> is a member of Code Aurora Forum, hosted by The Linux Foundation
> 
