Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D17C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 00:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5B8F20659
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 00:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FXifUxhL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727596AbfAOAnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 19:43:00 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43757 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727580AbfAOAm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 19:42:59 -0500
Received: by mail-pg1-f194.google.com with SMTP id v28so403464pgk.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 16:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dsW7Xwf/MSFyDOD+9G27anN/brv6VA/SzB6JIi9+yVQ=;
        b=FXifUxhLIOkpn98DhMGYoTYAew1ic6a0BWQ6eC8IAjbqh1Up1hNVjsyE0N8jgC0az8
         uuDmcyefoPK3teviFtjYk/sYNrmFO/ZQ9nr9HnqEuidwWSLj8Lr9/OGqjXoqaTjCGtXo
         gf4AUjgWnnDU9nKWCno15fBSkb22uxMiwD9xY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dsW7Xwf/MSFyDOD+9G27anN/brv6VA/SzB6JIi9+yVQ=;
        b=ZHmBjhRkcFdy86KfrqVFOrJs2WpEtFiakcnNF3gTCphPB0eoWH9oxJQMlisbCWV7Z0
         YFThRo5EhWrnbyUSx0qK29AsGyjBQTXFDfmIufjWrNOwdj2rhjXuFm0RX/FeQGltXRsl
         o9j9YKmXlCzx035Pubzca7jJMYVNO82Tn2Wmvi/FaECJMScEFbQ/Zry1gYOo4Qftv9VU
         QljOCoBdxxyc9IuIqswBjoxUjyrwGhSS89c3/L5xgaFCGcKuP7XczD/JSS/zTutM9PoE
         RVXm7Dzd6DXJulkzF/PfBaTDYY6jvAJK4m7PHLP0TMGXKSnr5nW04M8bqhZPN4b9ktGz
         trOA==
X-Gm-Message-State: AJcUukc2TU4EO+Az2ME10IOwx/hwiblxXGEd97h0J97lHhzc4hi25EE7
        EXUwtooJsGkdpJNpI9x4D4/omQ==
X-Google-Smtp-Source: ALg8bN645DNwnNM3lv0fQezAqWZUmpNLxmizrmFfO9QTOI7kuxJl3e7a+mn06bhv2hrnaMLfTENUfQ==
X-Received: by 2002:a62:5c1:: with SMTP id 184mr1160446pff.165.1547512978304;
        Mon, 14 Jan 2019 16:42:58 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id m198sm2239240pga.10.2019.01.14.16.42.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 16:42:57 -0800 (PST)
Date:   Mon, 14 Jan 2019 16:42:54 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     linus.walleij@linaro.org, sboyd@kernel.org, andy.gross@linaro.org,
        marc.zyngier@arm.com, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 09/14] ARM: dts: qcom: pma8084: add interrupt
 controller properties
Message-ID: <20190115004254.GM9278@minitux>
References: <20190113154716.5145-1-masneyb@onstation.org>
 <20190113154716.5145-10-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190113154716.5145-10-masneyb@onstation.org>
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
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> ---
> Chances since v3:
> - None
> 
>  arch/arm/boot/dts/qcom-pma8084.dtsi | 24 ++----------------------
>  1 file changed, 2 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-pma8084.dtsi b/arch/arm/boot/dts/qcom-pma8084.dtsi
> index aac7e73b6872..8f5ea7add20f 100644
> --- a/arch/arm/boot/dts/qcom-pma8084.dtsi
> +++ b/arch/arm/boot/dts/qcom-pma8084.dtsi
> @@ -32,28 +32,8 @@
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
> -				     <0 0xd5 0 IRQ_TYPE_NONE>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
>  		};
>  
>  		pma8084_mpps: mpps@a000 {
> -- 
> 2.17.2
> 
