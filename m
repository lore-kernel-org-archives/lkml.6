Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B3CC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 03:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C9DA2173D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 03:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PvDyiEEU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C9DA2173D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbeH0Gzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 02:55:54 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:52094 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbeH0Gzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 02:55:54 -0400
Received: by mail-it0-f68.google.com with SMTP id e14-v6so9194803itf.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 20:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lqOUwzlcFoPBJsar8yymrAIlJ3mot1xGZZo2Nx01SOQ=;
        b=PvDyiEEUddGa0N9FDhiJFnRZXuiSNJxrBo3Oi/nopMVr/DjmMKwMcZOf7ERYwzH4ln
         n0mb0T8C2bFAU6a06wNiJU1/hVF/fKTBJBQ23drT/CtN01yufOYZHxfNO9/oAtMgYgBj
         J1mPh2vmYmN8yHSS2pSTtAdnvjl991pAHQdSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lqOUwzlcFoPBJsar8yymrAIlJ3mot1xGZZo2Nx01SOQ=;
        b=qSysB6P75y+9Gzinp+tw2IewYz1qZcdCVsqyYo2YeBoBj3eflTTB76HM5bF48sBziV
         /12kOBciYTtbHMfcU4zWWq9f4cnDALTK2og90lsfqxoCxTcjNgiC0mXmRrChGves5xwL
         vw+frVnGnANve8LxeLMIbq8vB5UqBvs//ITN7Pi1j38p8pd6tWq/RdiAV951bpCgMiXQ
         dJwGjzZ/dEHG1ouzJsHf+XG0aIpojjYgGL3jLcB3BVWmNBWpPQURL3tnGGcw3nmwuirw
         3upCQTYwR/idO2MYdC+yQQE9OwaZtLn675eWk09C/H6G2pJBGPJ3WnMmFu5x5XqOFSp3
         FpPA==
X-Gm-Message-State: APzg51DzyoMe5yyym+w0xZfxH0BUjBI0VMm9KljOMpQzBFUanm8jBbUW
        PvBiLGb5bRc2U/9qjq6GhcAxioawKaLboQ==
X-Google-Smtp-Source: ANB0Vdb+xlCamW1NnVjtLeNLTLmTzE+r6ddR03ruwMGE6nWX0bn0pT0x9y7EoihFSGgQi9ahA/+jPA==
X-Received: by 2002:a24:9343:: with SMTP id y64-v6mr5493152itd.33.1535339472718;
        Sun, 26 Aug 2018 20:11:12 -0700 (PDT)
Received: from mail-io0-f180.google.com (mail-io0-f180.google.com. [209.85.223.180])
        by smtp.gmail.com with ESMTPSA id r9-v6sm4467809ioj.86.2018.08.26.20.11.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 20:11:11 -0700 (PDT)
Received: by mail-io0-f180.google.com with SMTP id e12-v6so11680628iok.12
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 20:11:11 -0700 (PDT)
X-Received: by 2002:a6b:2387:: with SMTP id j129-v6mr917599ioj.86.1535339470663;
 Sun, 26 Aug 2018 20:11:10 -0700 (PDT)
MIME-Version: 1.0
References: <1535034528-11590-1-git-send-email-vgarodia@codeaurora.org>
 <1535034528-11590-3-git-send-email-vgarodia@codeaurora.org>
 <CAPBb6MXydrrfbWOps-xV4eRzgN6n6pT45B2C=H5tuF2pZOesZQ@mail.gmail.com> <ee7f8db9-8624-9e08-7ea2-7ea99c0ad289@linaro.org>
In-Reply-To: <ee7f8db9-8624-9e08-7ea2-7ea99c0ad289@linaro.org>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Mon, 27 Aug 2018 12:10:59 +0900
X-Gmail-Original-Message-ID: <CAPBb6MWYE2o+nPXeaVGq6Pvymb4NAivf6aM2srX++=fpAU6SwA@mail.gmail.com>
Message-ID: <CAPBb6MWYE2o+nPXeaVGq6Pvymb4NAivf6aM2srX++=fpAU6SwA@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] venus: firmware: move load firmware in a separate function
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     vgarodia@codeaurora.org, Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>, robh@kernel.org,
        mark.rutland@arm.com, Andy Gross <andy.gross@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, bjorn.andersson@linaro.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 6:01 PM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> Hi Alex,
>
> On 08/24/2018 10:39 AM, Alexandre Courbot wrote:
> > On Thu, Aug 23, 2018 at 11:29 PM Vikash Garodia <vgarodia@codeaurora.org> wrote:
> >>
> >> Separate firmware loading part into a new function.
> >>
> >> Signed-off-by: Vikash Garodia <vgarodia@codeaurora.org>
> >> ---
> >>  drivers/media/platform/qcom/venus/core.c     |  4 +-
> >>  drivers/media/platform/qcom/venus/firmware.c | 55 ++++++++++++++++++----------
> >>  drivers/media/platform/qcom/venus/firmware.h |  2 +-
> >>  3 files changed, 38 insertions(+), 23 deletions(-)
> >>
> >> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> >> index bb6add9..75b9785 100644
> >> --- a/drivers/media/platform/qcom/venus/core.c
> >> +++ b/drivers/media/platform/qcom/venus/core.c
> >> @@ -84,7 +84,7 @@ static void venus_sys_error_handler(struct work_struct *work)
> >>
> >>         pm_runtime_get_sync(core->dev);
> >>
> >> -       ret |= venus_boot(core->dev, core->res->fwname);
> >> +       ret |= venus_boot(core);
> >>
> >>         ret |= hfi_core_resume(core, true);
> >>
> >> @@ -284,7 +284,7 @@ static int venus_probe(struct platform_device *pdev)
> >>         if (ret < 0)
> >>                 goto err_runtime_disable;
> >>
> >> -       ret = venus_boot(dev, core->res->fwname);
> >> +       ret = venus_boot(core);
> >>         if (ret)
> >>                 goto err_runtime_disable;
> >>
> >> diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
> >> index a9d042e..34224eb 100644
> >> --- a/drivers/media/platform/qcom/venus/firmware.c
> >> +++ b/drivers/media/platform/qcom/venus/firmware.c
> >> @@ -60,20 +60,18 @@ int venus_set_hw_state(struct venus_core *core, bool resume)
> >>         return 0;
> >>  }
> >>
> >> -int venus_boot(struct device *dev, const char *fwname)
> >> +static int venus_load_fw(struct venus_core *core, const char *fwname,
> >> +                        phys_addr_t *mem_phys, size_t *mem_size)
> >
> > Following the remarks of the previous patch, you would have mem_phys
> > and mem_size as members of venus_core (probably renamed as fw_mem_addr
> > and fw_mem_size).
> >
> >>  {
> >>         const struct firmware *mdt;
> >>         struct device_node *node;
> >> -       phys_addr_t mem_phys;
> >> +       struct device *dev;
> >>         struct resource r;
> >>         ssize_t fw_size;
> >> -       size_t mem_size;
> >>         void *mem_va;
> >>         int ret;
> >>
> >> -       if (!IS_ENABLED(CONFIG_QCOM_MDT_LOADER) || !qcom_scm_is_available())
> >> -               return -EPROBE_DEFER;
> >
> > !IS_ENABLED(CONFIG_QCOM_MDT_LOADER) is not a condition that can change
> > at runtime, and returning -EPROBE_DEFER in that case seems erroneous
> > to me. Instead, wouldn't it make more sense to make the driver depend
> > on QCOM_MDT_LOADER?
>
> That was made on purpose, for more info git show b8f9bdc151e4a

Ah, I see. Still, in the current form it seems like
qcom_scm_is_available() is not resolved thanks to a compiler
optimization. Wouldn't it be more explicit to do something like

#if IS_ENABLED(CONFIG_QCOM_MDT_LOADER)
if (!qcom_scm_is_available())
    return -EPROBE_DEFER;
#endif

instead?
