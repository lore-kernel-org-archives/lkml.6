Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10E7C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 00:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DCAA20659
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 00:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NNc2gt4b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbfAOAnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 19:43:12 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44655 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727599AbfAOAnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 19:43:11 -0500
Received: by mail-pf1-f193.google.com with SMTP id u6so416503pfh.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 16:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V9A8hHk0RKKoLRn7c+4Uk5RlsWngdSrAKnzXmZlEUHc=;
        b=NNc2gt4btC3oYpe0xgQIH2nMCgXOaDgTEGTTESr/Vmyv41GRIDNmjoKSu/NsMSG7l9
         oRYqo61LpZjJgJuCbuzlEMF1QcUgPzxoCmmVRt0OUcCNcvWsjewrBkkqLYXoFeAhblYo
         F+1gKQe8qukUbw9jaCeahzrsUC0jCVD+loMyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V9A8hHk0RKKoLRn7c+4Uk5RlsWngdSrAKnzXmZlEUHc=;
        b=OYZl1i0iilvjHcHMbaa056WusQwV7qSpsntC943+URyJAGKBX2UWj7z+ToARw5In6/
         RekFut9SIYfwZTpXCeTcCHbTB2Gh0SYjFrQfOBIPjwcGoj+P2t29dHHKGbjelrUHFFX0
         JqiN+8fA9kfWNoL4DO8ncl/M19MnYlo9HNWhimMRK7YDBgHj+gnbjU6bYdprzHwAxJ3z
         FSGgCnVFf0eM4QyFubWolAqI4WH9PJpK0YwKt8Q1gRT7tkJl337n5w7VXTtvSnZrdJxm
         nfmC6PRqcZ8tuQothFgIkGznuyQI5ZyXZ8FiH6UcVQIK0YToSHUEvR5r7y4xcWZ+soYc
         utFw==
X-Gm-Message-State: AJcUukfA1X6MDMxbz5luNNN1/RqfHJ/JiiWIwR2u+H997vK1N8cIXY2V
        aUQ+VjPnqCQ9MPbdz8Oi1Q/9Fw==
X-Google-Smtp-Source: ALg8bN5tdyB6xhjCiibAc8FkOCHFc8RwZYmdJQD8Pf9BlhmTfKgRM01JdaE/YNaSaPtitHnPNavtlg==
X-Received: by 2002:a63:fc05:: with SMTP id j5mr1217432pgi.434.1547512990851;
        Mon, 14 Jan 2019 16:43:10 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id t5sm2583324pfb.60.2019.01.14.16.43.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 16:43:10 -0800 (PST)
Date:   Mon, 14 Jan 2019 16:43:06 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     linus.walleij@linaro.org, sboyd@kernel.org, andy.gross@linaro.org,
        marc.zyngier@arm.com, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 10/14] arm64: dts: qcom: pm8005: add interrupt
 controller properties
Message-ID: <20190115004306.GN9278@minitux>
References: <20190113154716.5145-1-masneyb@onstation.org>
 <20190113154716.5145-11-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190113154716.5145-11-masneyb@onstation.org>
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
>  arch/arm64/boot/dts/qcom/pm8005.dtsi | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/pm8005.dtsi b/arch/arm64/boot/dts/qcom/pm8005.dtsi
> index 4d5aca3eeb69..c0ddf128136c 100644
> --- a/arch/arm64/boot/dts/qcom/pm8005.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8005.dtsi
> @@ -16,10 +16,8 @@
>  			reg = <0xc000>;
>  			gpio-controller;
>  			#gpio-cells = <2>;
> -			interrupts = <0 0xc0 0 IRQ_TYPE_NONE>,
> -				     <0 0xc1 0 IRQ_TYPE_NONE>,
> -				     <0 0xc2 0 IRQ_TYPE_NONE>,
> -				     <0 0xc3 0 IRQ_TYPE_NONE>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
>  		};
>  
>  	};
> -- 
> 2.17.2
> 
