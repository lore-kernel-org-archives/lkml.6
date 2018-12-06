Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195CAC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C811620878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GGNimdvy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C811620878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbeLFX5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 18:57:41 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39699 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbeLFX5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 18:57:41 -0500
Received: by mail-pf1-f194.google.com with SMTP id c72so965532pfc.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 15:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qm9objgF1dajBMnFwQLLrLy+YR6dE/kNBBHZNbHr9+Y=;
        b=GGNimdvyHrc80jB2kwqO8Ol5qbPMpcIyZt1Sfw3AMvf/cD31C3FgWMOjnDmbbSlcw+
         Pn2KIBk2JD8tXfSYYCeHaeKlDTU6C56Mh5M+luS8hOTOW/iL/TrMFOjVrR/T1E2ZX4bI
         rGwZvaRKuu9FEbiVq7nmBuCqLYsrjZHduljRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qm9objgF1dajBMnFwQLLrLy+YR6dE/kNBBHZNbHr9+Y=;
        b=QcAFXJtKaLKb0iiNkfDhQvC2uWaZ4RlanIoXXFMa56mTEyAIxjVXprDEAVSyi4Wtbt
         sqm6GyOjQVD+ScuHiTps+Q+BoB39enE5Dq42khqmGmYJNwQS8Ju/TD5cjidUEzsMQlQv
         qRzznmJwIMKjZp67sp/+A0q5dhe5hLfAPhab+OkiS+pfx8p+trGU/OKlT6NGiPKGQvB5
         Vsook5j7RKAErGA07lLaFNDPjEJJNDzhL1VgOyK67jWGnmc9WgTwDjANU05AmCIPEO8m
         rOvFQP5yudr2XTGU1z7gpw/6+07AH3T5F6ba4aekgofCxYOcqhlESb8lPsbe09mzsq5C
         ZR4g==
X-Gm-Message-State: AA+aEWZn+uGkW+dv2vePhPlNtA4lGbmZ3KXmZxeYFe0a0vm2DJwzBV7Z
        HJ/lqTL0qGqTcQXdvBwdhXpvmg==
X-Google-Smtp-Source: AFSGD/V92tiZHE/NJmMQrt/4/u/NazAtXCHFVdq+pbNmG/Fu2POduDUvrLF1oSlcZuHTURsv0qXyTA==
X-Received: by 2002:a62:4bcf:: with SMTP id d76mr938pfj.170.1544140660339;
        Thu, 06 Dec 2018 15:57:40 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id r80sm1891507pfa.111.2018.12.06.15.57.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 15:57:39 -0800 (PST)
Date:   Thu, 6 Dec 2018 15:57:37 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sdm845: Add SD nodes for
 sdm845-mtp
Message-ID: <20181206235737.GH12886@minitux>
References: <20181206184522.118062-1-evgreen@chromium.org>
 <20181206184522.118062-4-evgreen@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206184522.118062-4-evgreen@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 06 Dec 10:45 PST 2018, Evan Green wrote:

> Enable support for one of the micro SD slots on the MTP.
> 
> Signed-off-by: Evan Green <evgreen@chromium.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
> 
> Changes in v2:
>  - Fixed alphabetization of node placement in sdm845-mtp.dtsi (Doug)
>  - Fixed card detect name to match schematics (Doug).
>  - Moved comment about drive strength next to the drive-strength entry
>  (Doug)
>  - Removed drive-strength from card detect input pin (Doug).
>  - Consolidated tlmm nodes in MTP.
> 
>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 58 ++++++++++++++++++++++++-
>  1 file changed, 56 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> index b3def03581775..cde76da42cbb7 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> @@ -7,6 +7,7 @@
>  
>  /dts-v1/;
>  
> +#include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>  #include "sdm845.dtsi"
>  
> @@ -358,8 +359,16 @@
>  	status = "okay";
>  };
>  
> -&tlmm {
> -	gpio-reserved-ranges = <0 4>, <81 4>;
> +&sdhc_2 {
> +	status = "okay";
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sdc2_clk &sdc2_cmd &sdc2_data &sd_card_det_n>;
> +
> +	vmmc-supply = <&vreg_l21a_2p95>;
> +	vqmmc-supply = <&vddpx_2>;
> +
> +	cd-gpios = <&tlmm 126 GPIO_ACTIVE_LOW>;
>  };
>  
>  &uart9 {
> @@ -450,3 +459,48 @@
>  		bias-pull-up;
>  	};
>  };
> +
> +&tlmm {
> +	gpio-reserved-ranges = <0 4>, <81 4>;
> +
> +	sdc2_clk: sdc2-clk {
> +		pinconf {
> +			pins = "sdc2_clk";
> +			bias-disable;
> +
> +			/*
> +			 * It seems that mmc_test reports errors if drive
> +			 * strength is not 16 on clk, cmd, and data pins.
> +			 */
> +			drive-strength = <16>;
> +		};
> +	};
> +
> +	sdc2_cmd: sdc2-cmd {
> +		pinconf {
> +			pins = "sdc2_cmd";
> +			bias-pull-up;
> +			drive-strength = <16>;
> +		};
> +	};
> +
> +	sdc2_data: sdc2-data {
> +		pinconf {
> +			pins = "sdc2_data";
> +			bias-pull-up;
> +			drive-strength = <16>;
> +		};
> +	};
> +
> +	sd_card_det_n: sd-card-det-n {
> +		pinmux {
> +			pins = "gpio126";
> +			function = "gpio";
> +		};
> +
> +		pinconf {
> +			pins = "gpio126";
> +			bias-pull-up;
> +		};
> +	};
> +};
> -- 
> 2.18.1
> 
