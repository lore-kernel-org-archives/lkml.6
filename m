Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8F4C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3F0F20821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aAJRtw1f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3F0F20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbeLJV04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:26:56 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43883 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729332AbeLJV0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 16:26:55 -0500
Received: by mail-lf1-f66.google.com with SMTP id u18so9123360lff.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 13:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FPmgRoYss87Fzp8JXknW3SMAvMtaUZ+65dTTwzIkXoA=;
        b=aAJRtw1f+8cCHB6Tlkx4Y91LhH5RN2WUshgN0cKMbkT6ONDmbDpnkt4hR8sNLehSdo
         5rgyaHfZVe9u3J+UuW6D52MINMncoOPTtbQSppfJMFB1becW6MkIckix4S1mG5rNamR2
         4eUo9nWhM/83Y7ZiH7E2IhmOPZHnX1nXQgUvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FPmgRoYss87Fzp8JXknW3SMAvMtaUZ+65dTTwzIkXoA=;
        b=TPI5iW/q6oYuhnvW0taZ1tsclTf8MiV44ILlt8GE5aPfWsuPzKHUqofiGB3zmI4CCL
         bver3mz1E0GSNQ++FfzRQpq3/IwiaXvIDgxgeEv8aLLIpSbqLg8noLPUzsndDjVm3KxK
         glYtSF1ZPm8ZNJ8jVLoFpjJIC8XggqWTNfCyezovhg8RMwBUov1/N6OaLoIGOX88EF/F
         JjqdCMMy71EerVGGanesvpuTxpw2+m1TGK1X8IcqpX2UIsN/D+xkI9khFOJNoCu3d3OK
         M1GaUOj05rR73PR5K8KAFWSK9m7ZUJiT5s7gfu73s0EW3uyDbOcvsf41oL5u9hOEeAFn
         F21g==
X-Gm-Message-State: AA+aEWYI6WwPpJeKpNhn7PkSg9gUA2t24OxTHNyzj8oeFnT/g8Znirsz
        y5pGVGed2qRiehX9GuKLaP4oj/ptT0w=
X-Google-Smtp-Source: AFSGD/Wwl8FVkbosD2GuJwQLfOZhbuRTiHpU3W6zuGTcwk856rhrgREI+ARSH6P27jCMA+/kBB6plw==
X-Received: by 2002:a19:9c92:: with SMTP id f140mr7432939lfe.41.1544477212931;
        Mon, 10 Dec 2018 13:26:52 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id b20sm2248447lfj.61.2018.12.10.13.26.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 13:26:51 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id i26so9170182lfc.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 13:26:51 -0800 (PST)
X-Received: by 2002:a19:4287:: with SMTP id p129mr8133965lfa.135.1544477210744;
 Mon, 10 Dec 2018 13:26:50 -0800 (PST)
MIME-Version: 1.0
References: <20181210205955.3254660-1-arnd@arndb.de>
In-Reply-To: <20181210205955.3254660-1-arnd@arndb.de>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 10 Dec 2018 13:26:14 -0800
X-Gmail-Original-Message-ID: <CAE=gft43eL--acrZ18cRhKcDLJ7u2nVeOOYreS30yBYk7q7=uw@mail.gmail.com>
Message-ID: <CAE=gft43eL--acrZ18cRhKcDLJ7u2nVeOOYreS30yBYk7q7=uw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: msm: mark PM functions as __maybe_unused
To:     arnd@arndb.de
Cc:     bjorn.andersson@linaro.org, linus.walleij@linaro.org,
        swboyd@chromium.org, timur@codeaurora.org, dianders@chromium.org,
        ricardo.ribalda@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 1:00 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Without CONFIG_PM_SLEEP, we get annoyting warnings about unused functions:
>
> drivers/pinctrl/qcom/pinctrl-msm.c:1082:12: error: 'msm_pinctrl_resume' defined but not used [-Werror=unused-function]
>  static int msm_pinctrl_resume(struct device *dev)
>             ^~~~~~~~~~~~~~~~~~
> drivers/pinctrl/qcom/pinctrl-msm.c:1075:12: error: 'msm_pinctrl_suspend' defined but not used [-Werror=unused-function]
>  static int msm_pinctrl_suspend(struct device *dev)
>
> Mark them as __maybe_unused to shut up the warning and silently drop
> the functions without having to add ugly #ifdefs.
>
> Fixes: 977d057ad346 ("pinctrl: msm: Add sleep pinctrl state transitions")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/pinctrl/qcom/pinctrl-msm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> index 87cbebe217fd..ee8119879c4c 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> @@ -1072,14 +1072,14 @@ static void msm_pinctrl_setup_pm_reset(struct msm_pinctrl *pctrl)
>                 }
>  }
>
> -static int msm_pinctrl_suspend(struct device *dev)
> +static __maybe_unused int msm_pinctrl_suspend(struct device *dev)
>  {
>         struct msm_pinctrl *pctrl = dev_get_drvdata(dev);
>
>         return pinctrl_force_sleep(pctrl->pctrl);
>  }
>
> -static int msm_pinctrl_resume(struct device *dev)
> +static __maybe_unused int msm_pinctrl_resume(struct device *dev)
>  {
>         struct msm_pinctrl *pctrl = dev_get_drvdata(dev);
>

Thanks Arnd.

Reviewed-by: Evan Green <evgreen@chromium.org>
