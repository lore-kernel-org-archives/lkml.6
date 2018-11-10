Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA1AC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 00:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2DDD20818
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 00:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FGZHIRhj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2DDD20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbeKJJpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 04:45:46 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37260 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbeKJJpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 04:45:46 -0500
Received: by mail-pl1-f196.google.com with SMTP id p6-v6so1634969pll.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 16:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=hV3hxxWdTSA6QFgyEk13J4mQ9Uf50eIGYj7l8gdbEY0=;
        b=FGZHIRhjENxXl4JwosLathu5zGhLCXuSCSslfpv33kLozhDqzcTwKDfGQi9qyuJ3QC
         vmiffl79YThPdjZfk5nlzYuLIHHu2ZtZH9obaBqo99dTqTJKDvPSHtw0HquQsJE47DQB
         tsXIr3HqteEAH/Fd5bYEmX33nrg4EJLS16wbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=hV3hxxWdTSA6QFgyEk13J4mQ9Uf50eIGYj7l8gdbEY0=;
        b=qAY0o1KP/Nda4Ih/IHbJ1P0TyDLrKEdoSQwT1AXz4z6HJP9Lkh0p2np2zxgUn8Xp0h
         pIPThLOE2LCCuyzpZZyvp+aR5A4O1RnhYHMynoEg7YoJZIRX3aoNix5818jp9Zb1AmhS
         +XCz8e8SP/cVVrPHjr/pDfNUObM0vu633/wn83eiWAhUW/IzPqMKbupsHPfKsd14rrGo
         zjMGupbokOf56VYOAQEoYCOnolhBR2W0y+BXTQmvNDSTKTBOE+4aaZzJc9o8J3KcrUjN
         u7mFy1jJe3+VthRURNgioU1p+bHm8PEVsGNp6kYRDSgEywu8PRHMW7VXV2IOZErjKG+E
         BHnQ==
X-Gm-Message-State: AGRZ1gI2j2+3A5QcDUVVZeunAIxtFdh876R2wrGK0PzIqPYXr6gpzYX3
        SUIHDpSjB71IqM9o4NGuY0jYFQ==
X-Google-Smtp-Source: AJdET5fgO2q/voh3EZxKPoMUvAyoPcqAJeAuBsHgywmFr/LjAZMExRPhjIZpTw9iLFBfJ2Rd6XfdZA==
X-Received: by 2002:a17:902:7b91:: with SMTP id w17-v6mr10700303pll.289.1541808170078;
        Fri, 09 Nov 2018 16:02:50 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id u6sm7941280pgr.79.2018.11.09.16.02.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 16:02:49 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20181109222835.60607-1-evgreen@chromium.org>
Cc:     Evan Green <evgreen@chromium.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20181109222835.60607-1-evgreen@chromium.org>
Message-ID: <154180816857.88331.11328422006723958300@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] pinctrl: msm: Add sleep pinctrl state transitions
Date:   Fri, 09 Nov 2018 16:02:48 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Evan Green (2018-11-09 14:28:35)
> Add PM suspend callbacks to the msm core driver that select the
> sleep and default pinctrl states. Then wire those callbacks up
> in the sdm845 driver, for those boards that may have GPIO hogs
> that need to change state during suspend.
> =

> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

> =

>  drivers/pinctrl/qcom/pinctrl-msm.c    | 16 ++++++++++++++++
>  drivers/pinctrl/qcom/pinctrl-msm.h    |  2 ++
>  drivers/pinctrl/qcom/pinctrl-sdm845.c |  4 ++++
>  3 files changed, 22 insertions(+)
> =

> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pi=
nctrl-msm.c
> index 7c7d083e2c0dc..d505d0a50f0a5 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> @@ -1072,6 +1072,22 @@ static void msm_pinctrl_setup_pm_reset(struct msm_=
pinctrl *pctrl)
>                 }
>  }
>  =

> +int msm_pinctrl_suspend(struct device *dev)
> +{
> +       struct msm_pinctrl *pctrl =3D dev_get_drvdata(dev);
> +
> +       return pinctrl_force_sleep(pctrl->pctrl);
> +}
> +EXPORT_SYMBOL(msm_pinctrl_suspend);
> +
> +int msm_pinctrl_resume(struct device *dev)
> +{
> +       struct msm_pinctrl *pctrl =3D dev_get_drvdata(dev);
> +
> +       return pinctrl_force_default(pctrl->pctrl);
> +}
> +EXPORT_SYMBOL(msm_pinctrl_resume);

It's too bad this can't be installed by default into the driver somehow
so we don't have to repeat this for each device driver. O well!

