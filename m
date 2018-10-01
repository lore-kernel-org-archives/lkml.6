Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36EC7C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 19:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4CA32089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 19:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QsbffuAE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4CA32089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbeJBCNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 22:13:37 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37375 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeJBCNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 22:13:37 -0400
Received: by mail-lf1-f67.google.com with SMTP id a82-v6so10791952lfa.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 12:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WE6bg/u8kWTPklkSHisKe+2DhmhRyPobMv7+snR8F9s=;
        b=QsbffuAEMSrJ1mPrwNpjE2crjjeMsTBNDxMYcPQA3Vrjn0DSHuV5/W+LLp+U8oHxwg
         pYkQh+sNmGRQVgWgj3VR/wyVuTGLrytrF/X7Q3Y859cGHsh4K1GHV/Ga26ytZd7m/dtK
         S/e4Noup6tE0mia+cpUpcASb4k6SvX519rXdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WE6bg/u8kWTPklkSHisKe+2DhmhRyPobMv7+snR8F9s=;
        b=tB6zRlJwbzNZG6jou9IgJx1D42wHg0fKGa+kdeIN/j4SyMX03izp+DQAhcG306/DN6
         jZkm9MW7qYnAaWCLvGRPWzT/pX2FnCf4E77KSlgfNLVXHK5XLqHcYl79GfHk6527RZ+N
         Ec1ZVV6L7Gmhx3Iolw/DuI5qZRBmOXLWGW1yo8OF9nC4AKCznkgg3Ue6GNr1PJ0HBNJG
         NkwrGnWzob1U6Lm90kEeF/RvoLK6QHjyPoMjJgX96zheN86uwxvtMhe0jiEu8CBSlOVN
         m4wazhJiqjR3jbRaruGNVBBAn4ixryuHTzs3QbgikZJ202692Nd8r4Ajbs8Y7wY7ZtX6
         YYSA==
X-Gm-Message-State: ABuFfoihKlPnfReA0s61KnVz80jZZ+40YyXdaI0F47FJG1ACLMDDYFot
        +Ay3xt0iJrX1T0YnMW5PBl/sMw==
X-Google-Smtp-Source: ACcGV61H3ILw+H5c3Z1x2GRIHnuphP76fp+3PlvLsi1f3oXK62w1oGrhCwSIQnOTzSqH0YOODkPGTg==
X-Received: by 2002:a19:9cd4:: with SMTP id f203-v6mr6163246lfe.76.1538422457172;
        Mon, 01 Oct 2018 12:34:17 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id 24-v6sm2910948ljb.76.2018.10.01.12.34.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 12:34:16 -0700 (PDT)
Date:   Mon, 1 Oct 2018 21:34:14 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v3 0/3] pinctrl: msm interrupt and muxing fixes
Message-ID: <20181001193414.GA4441@centauri.lan>
References: <20180816200648.90458-1-swboyd@chromium.org>
 <20180912103431.GA27204@centauri.ideon.se>
 <153841961783.119890.13486677118739554119@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153841961783.119890.13486677118739554119@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 11:46:57AM -0700, Stephen Boyd wrote:
> Quoting Niklas Cassel (2018-09-12 03:34:31)
> > Hello Stephen,
> > 
> > I'm getting this warning on dragonboard 820c (msm8996) when booting linux-next:
> > 
> > [    3.211575] WARNING: CPU: 1 PID: 1 at drivers/pinctrl/qcom/pinctrl-msm.c:164 msm_pinmux_set_mux+0xc8/0x150
> > [    3.212127] l28: ramp_delay not set
> 
> Thanks for testing. I think the problem is I messed up the function 0
> and enum 0. Can you try this patch?

Hello Stephen,

This patch does indeed remove the warning.
Thanks!

Kind regards,
Niklas

> 
> --8<---
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> index 1684b2da09d5..b925b8feac95 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> @@ -188,7 +188,7 @@ static int msm_pinmux_request_gpio(struct pinctrl_dev *pctldev,
>  		return 0;
>  
>  	/* For now assume function 0 is GPIO because it always is */
> -	return msm_pinmux_set_mux(pctldev, 0, offset);
> +	return msm_pinmux_set_mux(pctldev, g->funcs[0], offset);
>  }
>  
>  static const struct pinmux_ops msm_pinmux_ops = {
