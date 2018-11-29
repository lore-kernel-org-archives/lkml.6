Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5678AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 00:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1378D2133F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 00:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qm6VZMNb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1378D2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbeK2LGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 06:06:36 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43237 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbeK2LGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 06:06:36 -0500
Received: by mail-pl1-f193.google.com with SMTP id gn14so45951plb.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 16:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lHdGKMDaB1hNwlp9byJgP+Q4wzUTvWJVl3NQIWeie9g=;
        b=Qm6VZMNb2FHPCom8HuaYaMSP0G3qQA7uEqB+JCnIejCK/2vKrf+R+AIcQKmgqxvSrd
         QwLXPToR+OEUqwNjNLIvk80fPXjKxqXcochFZhPgEi/5asnTcDm5sk8gRiZyD1xUsHfE
         apzIYsSfrCDZvzH3TLuKSzPvPWElgLT7X8t0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lHdGKMDaB1hNwlp9byJgP+Q4wzUTvWJVl3NQIWeie9g=;
        b=TYHO+2LKlUNcUpxY0BePPq9tf+xDITjZOZRBnOI48T3OBQU4x8uTkkAJYoTcPbqgFe
         Qcky7MryBarfEgyx5JbbnbatRmU7RS3+601SyjC+UEnLdcgwbZFgMpSrJ2lOaVKy4bBh
         3pzikK8TlYCpjgSPFCSra0BwdfZcwSHzuSVEIsU+tJ/9VMqoiF2jli/9OuNj61ZmiyfN
         tuSsRGplDsej2890n6Ur7ugGz1YGKO6Z98P9donKR/LJMvMaRzcxWAHSoT+FfI1M/19J
         RphGsQV4VnQCM9woOZnjavSU7ZjQEd2yFDNIIjn0P8S2TiEUs9edChTnSAgZ2w06No+7
         jOSg==
X-Gm-Message-State: AA+aEWYj+IsfnvXaQtp+fJ4migVN0EO2PfIvh+VU81ys3TxRoWh1dIyc
        70ypwiaH4M8tKyCO1yKAE/QSfg==
X-Google-Smtp-Source: AFSGD/Xb7V2695QbaQWz1tklcAR+JLG597va2UZVx7cWHWL5+bOK94e+KYsa5yP2gyPmzeOlPVgpSw==
X-Received: by 2002:a17:902:724a:: with SMTP id c10mr23401111pll.51.1543449792836;
        Wed, 28 Nov 2018 16:03:12 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id u78sm152730pfi.2.2018.11.28.16.03.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 16:03:11 -0800 (PST)
Date:   Wed, 28 Nov 2018 16:03:08 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: dts: qcom: Add SoC-specific string for
 sdhci-msm-v4 nodes
Message-ID: <20181129000308.GF24969@minitux>
References: <20181105210921.253707-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105210921.253707-1-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 05 Nov 13:09 PST 2018, Douglas Anderson wrote:

> As per upstream discussion [1], we should have an SoC-specific
> compatible string for Qualcomm's SDHCI nodes.  Let's add it.
> 
> [1] https://lkml.kernel.org/r/20181105203657.GA32282@bogus
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
> 
>  arch/arm/boot/dts/qcom-apq8084.dtsi | 4 ++--
>  arch/arm/boot/dts/qcom-msm8974.dtsi | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom-apq8084.dtsi
> index 0e1e98707e3f..899f28533ed7 100644
> --- a/arch/arm/boot/dts/qcom-apq8084.dtsi
> +++ b/arch/arm/boot/dts/qcom-apq8084.dtsi
> @@ -412,7 +412,7 @@
>  		};
>  
>  		sdhci@f9824900 {
> -			compatible = "qcom,sdhci-msm-v4";
> +			compatible = "qcom,apq8084-sdhci", "qcom,sdhci-msm-v4";
>  			reg = <0xf9824900 0x11c>, <0xf9824000 0x800>;
>  			reg-names = "hc_mem", "core_mem";
>  			interrupts = <0 123 0>, <0 138 0>;
> @@ -425,7 +425,7 @@
>  		};
>  
>  		sdhci@f98a4900 {
> -			compatible = "qcom,sdhci-msm-v4";
> +			compatible = "qcom,apq8084-sdhci", "qcom,sdhci-msm-v4";
>  			reg = <0xf98a4900 0x11c>, <0xf98a4000 0x800>;
>  			reg-names = "hc_mem", "core_mem";
>  			interrupts = <0 125 0>, <0 221 0>;
> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
> index aba159d5a95a..891990c0d0b4 100644
> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
> @@ -602,7 +602,7 @@
>  		};
>  
>  		sdhci@f9824900 {
> -			compatible = "qcom,sdhci-msm-v4";
> +			compatible = "qcom,msm8974-sdhci", "qcom,sdhci-msm-v4";
>  			reg = <0xf9824900 0x11c>, <0xf9824000 0x800>;
>  			reg-names = "hc_mem", "core_mem";
>  			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
> @@ -616,7 +616,7 @@
>  		};
>  
>  		sdhci@f9864900 {
> -			compatible = "qcom,sdhci-msm-v4";
> +			compatible = "qcom,msm8974-sdhci", "qcom,sdhci-msm-v4";
>  			reg = <0xf9864900 0x11c>, <0xf9864000 0x800>;
>  			reg-names = "hc_mem", "core_mem";
>  			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
> @@ -630,7 +630,7 @@
>  		};
>  
>  		sdhci@f98a4900 {
> -			compatible = "qcom,sdhci-msm-v4";
> +			compatible = "qcom,msm8974-sdhci", "qcom,sdhci-msm-v4";
>  			reg = <0xf98a4900 0x11c>, <0xf98a4000 0x800>;
>  			reg-names = "hc_mem", "core_mem";
>  			interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
> -- 
> 2.19.1.930.g4563a0d9d0-goog
> 
