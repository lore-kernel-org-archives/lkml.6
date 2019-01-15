Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28D1C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 00:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EC8D20659
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 00:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bd45a9qp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfAOAnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 19:43:46 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42830 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbfAOAnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 19:43:45 -0500
Received: by mail-pg1-f194.google.com with SMTP id d72so407895pga.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 16:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SDd/BCcVJplv9UKf2OVwuYWSNkUtpUsoVH4+4N1FW9U=;
        b=bd45a9qpMhYVW7IzTnv4vbkOjYM84pw016VUmCGBfDeKvAqxj1As90t4FhGPZL6YFY
         3dS/IXQyutzqvS+dspFtG+fn5TQ5LzK7N8M+7uRI1S/bUJJo3NoPUV1dpgv5S0a/VGSB
         d/pPWTfViUj1YhQv0NHh2vJ87Y1VpB5ZPp4Fo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SDd/BCcVJplv9UKf2OVwuYWSNkUtpUsoVH4+4N1FW9U=;
        b=qPYpT4iCPdtzJTMPsacnz14BId8zaekTqxDBGKQQOXFx5Cs3rJ4MeP/AJdXg1nE+zV
         ItlW6pthLrg/laOCW+uMrUklrTbaObzak2BxEtc9DrFYmIIFJP4A1PEg+MS/snIF9OBN
         mZU9kkjS58evHpWyhuwTUUq20qJYU53k0rbO47RF2/I8wD+PUDNX3X9hM/WuuuMV2qb9
         fabVwdODIhT2K+L+9dO2hkYHSubDKk9khI1JZ5yLlPGqIjuSxIzQjqCMTi90SAX1AkSP
         Zsz/Nwfi8lEZsdJDwE7UGgu1wqSyNVIRjf4UGTFjZB3SwIbw+v6hhzIY1P33lb/bvhEf
         hxDA==
X-Gm-Message-State: AJcUukeRaQW+g5XBO4A8fvWt0qvL52p82sIEX5lfUhwunwieLw6C/HGQ
        JzcTmx4rL6NCl63E9PYXlTJd5Q==
X-Google-Smtp-Source: ALg8bN5mWPzpS6b24G4W5pfenYJXFe6cAngVfKKVUZoCLSU22PQ3kaJHTVxO5K/RWzxYu3CMZkI48w==
X-Received: by 2002:a63:b24a:: with SMTP id t10mr1139040pgo.223.1547513024865;
        Mon, 14 Jan 2019 16:43:44 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 125sm2131774pfg.39.2019.01.14.16.43.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 16:43:44 -0800 (PST)
Date:   Mon, 14 Jan 2019 16:43:40 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     linus.walleij@linaro.org, sboyd@kernel.org, andy.gross@linaro.org,
        marc.zyngier@arm.com, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 12/14] arm64: dts: qcom: pmi8994: add interrupt
 controller properties
Message-ID: <20190115004340.GP9278@minitux>
References: <20190113154716.5145-1-masneyb@onstation.org>
 <20190113154716.5145-13-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190113154716.5145-13-masneyb@onstation.org>
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
>  arch/arm64/boot/dts/qcom/pmi8994.dtsi | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/pmi8994.dtsi b/arch/arm64/boot/dts/qcom/pmi8994.dtsi
> index dae1cdc23f54..3aee10e3f921 100644
> --- a/arch/arm64/boot/dts/qcom/pmi8994.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pmi8994.dtsi
> @@ -15,16 +15,8 @@
>  			reg = <0xc000>;
>  			gpio-controller;
>  			#gpio-cells = <2>;
> -			interrupts = <2 0xc0 0 IRQ_TYPE_NONE>,
> -				     <2 0xc1 0 IRQ_TYPE_NONE>,
> -				     <2 0xc2 0 IRQ_TYPE_NONE>,
> -				     <2 0xc3 0 IRQ_TYPE_NONE>,
> -				     <2 0xc4 0 IRQ_TYPE_NONE>,
> -				     <2 0xc5 0 IRQ_TYPE_NONE>,
> -				     <2 0xc6 0 IRQ_TYPE_NONE>,
> -				     <2 0xc7 0 IRQ_TYPE_NONE>,
> -				     <2 0xc8 0 IRQ_TYPE_NONE>,
> -				     <2 0xc9 0 IRQ_TYPE_NONE>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
>  		};
>  	};
>  
> -- 
> 2.17.2
> 
