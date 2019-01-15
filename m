Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A0FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 00:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C208920659
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 00:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jUVjWd06"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbfAOAoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 19:44:02 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44701 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbfAOAoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 19:44:01 -0500
Received: by mail-pf1-f195.google.com with SMTP id u6so417342pfh.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 16:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SFH3qmAy3rcdwTptc1TGolsrmB7Ai2uKoE4LWC/vFSI=;
        b=jUVjWd060OKWOdaLw1XKMYUm3sjIrp9ydg6VGGstuQjw85gqAeqNnrpS1f9uNE/3dB
         a+OKUZwTWAfaLajCmwQM7z+V6JQs1+3gc1h3cd0voWW5CZANcTbrHbjTHZgNy6nbQ/Hf
         3jzCpcRtQfvf5c47pISVnQfCV77cIsy/X56do=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SFH3qmAy3rcdwTptc1TGolsrmB7Ai2uKoE4LWC/vFSI=;
        b=I1mU+DYZGxCkLewrM6QTqSW8htdzBN43jdu97E7VWF8EbGC6GBMTukzKwM77xHiu5Q
         FPakRItIQc2YsSJYnsY9Ci3+JfEmHQ2FEgfhKCdUBqzO3guBgV0uTzNlpAuRHn3EFe4Q
         FLQQM70C4J4C7eMTdYGqOA635TVxUuwuyCamDOzdJjPXTAllmLbomJBW/du4ClT0ROeX
         CdmFOcqQxeJcJaNZ2H5uUg1mwnFgdWXZ2DXfUBdVp6nrp853DHCWme6OH2BDYoOA8ROR
         L+ufYgopXA5cwi3JaTP6pKYpHcurbdLTYLC43Sf2a5Rbd+nHEnXzYBaG+LD4RJK/R5AV
         Qrww==
X-Gm-Message-State: AJcUukc3jB+Ri4ZPVHG5P+vsZd3DrCobIDg/97nDCVdDyVvM4q6NURV0
        N+jN4uXGRFwnVpsV4OiHOnsv5A==
X-Google-Smtp-Source: ALg8bN76x6BzjuF0WSXwiP1tXqWW0Yh2OWTiGGyNnkAdrtSJBAdrQElG0BfRE8YTP8eZN1xEo86LXA==
X-Received: by 2002:a62:1992:: with SMTP id 140mr1192869pfz.33.1547513040669;
        Mon, 14 Jan 2019 16:44:00 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id c13sm1810295pfo.121.2019.01.14.16.43.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 16:44:00 -0800 (PST)
Date:   Mon, 14 Jan 2019 16:43:56 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     linus.walleij@linaro.org, sboyd@kernel.org, andy.gross@linaro.org,
        marc.zyngier@arm.com, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 13/14] arm64: dts: qcom: pmi8998: add interrupt
 controller properties
Message-ID: <20190115004356.GQ9278@minitux>
References: <20190113154716.5145-1-masneyb@onstation.org>
 <20190113154716.5145-14-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190113154716.5145-14-masneyb@onstation.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 13 Jan 07:47 PST 2019, Brian Masney wrote:

> Add interrupt controller properties now that spmi-gpio is a proper
> hierarchical IRQ chip. The interrupts property is no longer needed so
> remove it.
> 
> This change was not tested on any hardware but the same change was
> tested on qcom-pm8941.dtsi using a LG Nexus 5 (hammerhead) phone with
> no issues.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
> This is a new patch introduced in V4.
> 
>  arch/arm64/boot/dts/qcom/pmi8998.dtsi | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/pmi8998.dtsi b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
> index da3285e216e2..051f57e7d6ac 100644
> --- a/arch/arm64/boot/dts/qcom/pmi8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
> @@ -14,20 +14,8 @@
>  			reg = <0xc000>;
>  			gpio-controller;
>  			#gpio-cells = <2>;
> -			interrupts = <0 0xc0 0 IRQ_TYPE_NONE>,
> -				     <0 0xc1 0 IRQ_TYPE_NONE>,
> -				     <0 0xc2 0 IRQ_TYPE_NONE>,
> -				     <0 0xc3 0 IRQ_TYPE_NONE>,
> -				     <0 0xc4 0 IRQ_TYPE_NONE>,
> -				     <0 0xc5 0 IRQ_TYPE_NONE>,
> -				     <0 0xc6 0 IRQ_TYPE_NONE>,
> -				     <0 0xc7 0 IRQ_TYPE_NONE>,
> -				     <0 0xc8 0 IRQ_TYPE_NONE>,
> -				     <0 0xc9 0 IRQ_TYPE_NONE>,
> -				     <0 0xca 0 IRQ_TYPE_NONE>,
> -				     <0 0xcb 0 IRQ_TYPE_NONE>,
> -				     <0 0xcc 0 IRQ_TYPE_NONE>,
> -				     <0 0xcd 0 IRQ_TYPE_NONE>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
>  		};
>  	};
>  
> -- 
> 2.17.2
> 
