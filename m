Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15632C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 00:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D801920659
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 00:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SxkQKpHf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfAOAnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 19:43:31 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38167 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbfAOAna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 19:43:30 -0500
Received: by mail-pf1-f194.google.com with SMTP id q1so432015pfi.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 16:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jpx+GbueRScflYls7iXH7fQMaDRGjOqbP8sGhnDaB5E=;
        b=SxkQKpHfYA1CTiSAHPBv/q33/P5WhIE1Y307QruDZUxGt340tVqy8aQBjIG8EH63vF
         mUHU7sdq4R2F3fMF2w142bv71yBNnUoeukjBmGvifnqE0vIkDlfK+5nhRXOm+OpxbS0a
         TuyhtblIozG15XRqFAz3xwOHBDt7PCeE4L3Ig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jpx+GbueRScflYls7iXH7fQMaDRGjOqbP8sGhnDaB5E=;
        b=g+7ehjkqA2Ho4Tvc79folMpIT+FnhvlsI51jpf4QHJE7VwL+knog3wMuh+XxgQ9Q/2
         CHRXK3NHRv3KG7Gu9VCVPuDN/DPX32oHE41IFWZid45R2giMWB38vgH/OpTQuTlBmDgO
         f6v2uZbBUWk2VYIKrY8EsevdjRnordQrRl8WFiMMmvPiAyBQPG2SkGT96xfElgVGjdFo
         JN4ds6+skrMpIOZzlgVcpcD7/ktvLIMw4lCmBcWZuD6tscRM3UPq4S5Wo3tj/3rN5Us4
         8CLLbwBmmDHmvxBe46yfBaqFVLxUy+EUjESp2vKa7HWIxk34jF4LPGcjdj9zHSx+Jcea
         E1VQ==
X-Gm-Message-State: AJcUukdEOco27q1xF2XTsRZinpSuQmeY3PBX4zbCjiRfCVaQNvhYL1wU
        iGcNw6HTOGEL8j6ZBerdQ7dfPA==
X-Google-Smtp-Source: ALg8bN5ClkuiS3hhESDt2h0RMe5Gwnw8Pti1vUR6tiWYN9bOs+yUXcbGPDwn8qKUmXlFUvKx7v9TJA==
X-Received: by 2002:a62:be0c:: with SMTP id l12mr1162272pff.51.1547513009601;
        Mon, 14 Jan 2019 16:43:29 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id m9sm1760282pgd.32.2019.01.14.16.43.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 16:43:28 -0800 (PST)
Date:   Mon, 14 Jan 2019 16:43:25 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     linus.walleij@linaro.org, sboyd@kernel.org, andy.gross@linaro.org,
        marc.zyngier@arm.com, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 11/14] arm64: dts: qcom: pm8998: add interrupt
 controller properties
Message-ID: <20190115004325.GO9278@minitux>
References: <20190113154716.5145-1-masneyb@onstation.org>
 <20190113154716.5145-12-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190113154716.5145-12-masneyb@onstation.org>
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
>  arch/arm64/boot/dts/qcom/pm8998.dtsi | 28 ++--------------------------
>  1 file changed, 2 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> index f1025a50c227..43cb5ea14089 100644
> --- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> @@ -94,32 +94,8 @@
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
> -				     <0 0xcd 0 IRQ_TYPE_NONE>,
> -				     <0 0xce 0 IRQ_TYPE_NONE>,
> -				     <0 0xcf 0 IRQ_TYPE_NONE>,
> -				     <0 0xd0 0 IRQ_TYPE_NONE>,
> -				     <0 0xd1 0 IRQ_TYPE_NONE>,
> -				     <0 0xd2 0 IRQ_TYPE_NONE>,
> -				     <0 0xd3 0 IRQ_TYPE_NONE>,
> -				     <0 0xd4 0 IRQ_TYPE_NONE>,
> -				     <0 0xd5 0 IRQ_TYPE_NONE>,
> -				     <0 0xd6 0 IRQ_TYPE_NONE>,
> -				     <0 0xd7 0 IRQ_TYPE_NONE>,
> -				     <0 0xd8 0 IRQ_TYPE_NONE>,
> -				     <0 0xd9 0 IRQ_TYPE_NONE>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
>  		};
>  
>  	};
> -- 
> 2.17.2
> 
