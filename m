Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91536C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 18:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55A1B2245E
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 18:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bxVr7kvM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55A1B2245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730401AbeKMEVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 23:21:54 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44791 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730354AbeKMEVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 23:21:52 -0500
Received: by mail-lf1-f67.google.com with SMTP id z13so6877712lfe.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 10:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iD4+FFw9vvrbeEERM8B0jmC6cMIkmSki+Y3vqZudkkY=;
        b=bxVr7kvMqpQrO/B7vP/3Smo5fK4TFU53niXmb/Gosp+k+K+VDWmjS0MfrpttDHoJnx
         nrt38FCRmH4gVbpx7/8qY2V+q9J+IeZQ2XG5UuB99x/RZM9HPWkrukK22LStpp6lTTTB
         t8oQYP1mb728HguIGM5FJLBn/63uLq+r2mryg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iD4+FFw9vvrbeEERM8B0jmC6cMIkmSki+Y3vqZudkkY=;
        b=JfeDag0MgOVAfHBM+FS+2q3fSA9Q3hRxzYzwARi/WKzQl7P9lqIxxHOwfZOS/EmuGE
         nTbTZg3hVZOuMgrOs/kYcoe57I1Si4inmHkXznMwBkVJkC/g5aUALpkYHJ2ahvBHoHvn
         /Ud+ASaxqiiAqVKw1ruWUlOb2hPHJ/iTURTY/6a8le3mfSABTNBJwtrvgBBnN0hwrTfv
         DjEATK3A5sp+zePzR9WGn2/Sd0ZQ6WZM+CE/WSYFfft3vqYNOfoTBs5huoGBotOkVSwC
         /je26dIg4cININoDpHkI/NPu4/oE11+dNh+QMLYBEHCloBlmhywfjUzlvhu5ZJ6xz2+5
         Q/IQ==
X-Gm-Message-State: AGRZ1gIzoJMw+xJ2FTXcYKRVzfJEllWzd36YsWh+IV10o+v7myXjxcG5
        WpSiQxjhR304NTfqc1ZaeUzj3jvJGTs=
X-Google-Smtp-Source: AJdET5df+a/sLWO2aMjEmbuRPpeRCih0bwW6BmNUuwaFd8aZN59avN/C501niotvwrlOnwK3C/GMow==
X-Received: by 2002:a19:ec16:: with SMTP id b22mr1336885lfa.65.1542047245710;
        Mon, 12 Nov 2018 10:27:25 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id y80sm472134lfd.36.2018.11.12.10.27.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 10:27:24 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id e26so5112466lfc.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 10:27:24 -0800 (PST)
X-Received: by 2002:a19:a60c:: with SMTP id p12mr1347522lfe.63.1542047244462;
 Mon, 12 Nov 2018 10:27:24 -0800 (PST)
MIME-Version: 1.0
References: <20181109222835.60607-1-evgreen@chromium.org> <20181110072045.GB4373@minitux>
In-Reply-To: <20181110072045.GB4373@minitux>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 12 Nov 2018 10:26:48 -0800
X-Gmail-Original-Message-ID: <CAE=gft5EvmFUtJOUXaSLiK=Y=Kx-J7d825OjRg3OmZ7A_k8tYA@mail.gmail.com>
Message-ID: <CAE=gft5EvmFUtJOUXaSLiK=Y=Kx-J7d825OjRg3OmZ7A_k8tYA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: msm: Add sleep pinctrl state transitions
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>, swboyd@chromium.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 9, 2018 at 11:20 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Fri 09 Nov 14:28 PST 2018, Evan Green wrote:
>
> > Add PM suspend callbacks to the msm core driver that select the
> > sleep and default pinctrl states. Then wire those callbacks up
> > in the sdm845 driver, for those boards that may have GPIO hogs
> > that need to change state during suspend.
> >
> > Signed-off-by: Evan Green <evgreen@chromium.org>
> > ---
> >
> >  drivers/pinctrl/qcom/pinctrl-msm.c    | 16 ++++++++++++++++
> >  drivers/pinctrl/qcom/pinctrl-msm.h    |  2 ++
> >  drivers/pinctrl/qcom/pinctrl-sdm845.c |  4 ++++
> >  3 files changed, 22 insertions(+)
> >
> > diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> > index 7c7d083e2c0dc..d505d0a50f0a5 100644
> > --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> > +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> > @@ -1072,6 +1072,22 @@ static void msm_pinctrl_setup_pm_reset(struct msm_pinctrl *pctrl)
> >               }
> >  }
> >
> > +int msm_pinctrl_suspend(struct device *dev)
> > +{
> > +     struct msm_pinctrl *pctrl = dev_get_drvdata(dev);
> > +
> > +     return pinctrl_force_sleep(pctrl->pctrl);
> > +}
> > +EXPORT_SYMBOL(msm_pinctrl_suspend);
> > +
> > +int msm_pinctrl_resume(struct device *dev)
> > +{
> > +     struct msm_pinctrl *pctrl = dev_get_drvdata(dev);
> > +
> > +     return pinctrl_force_default(pctrl->pctrl);
> > +}
> > +EXPORT_SYMBOL(msm_pinctrl_resume);
> > +
> >  int msm_pinctrl_probe(struct platform_device *pdev,
> >                     const struct msm_pinctrl_soc_data *soc_data)
> >  {
> > diff --git a/drivers/pinctrl/qcom/pinctrl-msm.h b/drivers/pinctrl/qcom/pinctrl-msm.h
> > index 29172fdf5882c..e163ca600ecd3 100644
> > --- a/drivers/pinctrl/qcom/pinctrl-msm.h
> > +++ b/drivers/pinctrl/qcom/pinctrl-msm.h
> > @@ -123,6 +123,8 @@ struct msm_pinctrl_soc_data {
> >       unsigned int ntiles;
> >  };
> >
> > +int msm_pinctrl_suspend(struct device *dev);
> > +int msm_pinctrl_resume(struct device *dev);
> >  int msm_pinctrl_probe(struct platform_device *pdev,
> >                     const struct msm_pinctrl_soc_data *soc_data);
> >  int msm_pinctrl_remove(struct platform_device *pdev);
> > diff --git a/drivers/pinctrl/qcom/pinctrl-sdm845.c b/drivers/pinctrl/qcom/pinctrl-sdm845.c
> > index 2ab7a88857579..a3ac9cbeabad1 100644
> > --- a/drivers/pinctrl/qcom/pinctrl-sdm845.c
> > +++ b/drivers/pinctrl/qcom/pinctrl-sdm845.c
> > @@ -1287,6 +1287,9 @@ static const struct msm_pinctrl_soc_data sdm845_pinctrl = {
> >       .ngpios = 150,
> >  };
> >
> > +static SIMPLE_DEV_PM_OPS(sdm845_pinctrl_dev_pm_ops, msm_pinctrl_suspend,
> > +                      msm_pinctrl_resume);
>
> I don't expect this to differ between the various platforms, so how
> about moving it to pinctrl-msm?

Sounds good! Will spin.
