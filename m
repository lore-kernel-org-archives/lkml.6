Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D1DC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 07:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7483F2157C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 07:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GzST9yii"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7483F2157C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbeHXLTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 07:19:33 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:35870 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbeHXLTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 07:19:33 -0400
Received: by mail-it0-f68.google.com with SMTP id p16-v6so969083itp.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 00:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EbTvhGYO33o4UuOx7PLXf3oOKcSQY6JoBBGVa6QXzaw=;
        b=GzST9yii4inRv/UKZNnIf6DPRpZsNeKxoXMiQfbeUOxXQj8C+IoGtcwujK6vcFRhmG
         Q6EtRNNXCGp8W+wRAnqrxqJVDh34LOaGxmtY52AuXw/eSwTXulyyfBR6b4wiZBT6mIQd
         XFtzyEWxOw8h7tqc87e+Lfyrr+T1px86M9sqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EbTvhGYO33o4UuOx7PLXf3oOKcSQY6JoBBGVa6QXzaw=;
        b=EkwVvYcXQ+lb/cyAewzJEAd2EAQ4TaCh78KQZj3nekN35B3K9Z5EAnmWIR63twZP+n
         7MI4n1Zst+wwlYNnB9dC81CboPbkzCKt+YrFuIhhh1rh8K84TogsuIZchz0LYtJD054Q
         AxAAN9TRQP/zJshE9/tQMswUh6LAs4/TGYHVOUoeqmDFSED8yZsj9nWKmEB9sWSBBOUu
         Yq+Wr0iqNEf08WIrqOOhFujGLipy2QpjeC0LujaRH8C54YMwC8zBwyNOL3f8+QPQqi3H
         3FI34lH6IBHDVgacK5B7gOfgbU3fPFLVtKKpvmkHQqIRY2gInfOrCCUvjOiCqxziALIY
         4UAQ==
X-Gm-Message-State: APzg51A3X3YaQKila1RoOsRhua9e8D785HUcINFlvDL3urfx5T6c+7Mc
        qoTNlcn9oTOQAv3nkUyaqHVOxEQaRDnGXQ==
X-Google-Smtp-Source: ANB0VdYAVV1Rb84TgsEBEH8cN1eENV7HKxnAJxvIK42qPQyJi67nwv7nbld4XFD+IOM79A/BTxJHiA==
X-Received: by 2002:a24:d311:: with SMTP id n17-v6mr515491itg.99.1535096766900;
        Fri, 24 Aug 2018 00:46:06 -0700 (PDT)
Received: from mail-io0-f174.google.com (mail-io0-f174.google.com. [209.85.223.174])
        by smtp.gmail.com with ESMTPSA id u68-v6sm314141ita.36.2018.08.24.00.46.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 00:46:06 -0700 (PDT)
Received: by mail-io0-f174.google.com with SMTP id y12-v6so6411314ioj.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 00:46:06 -0700 (PDT)
X-Received: by 2002:a6b:9792:: with SMTP id z140-v6mr351463iod.86.1535096354887;
 Fri, 24 Aug 2018 00:39:14 -0700 (PDT)
MIME-Version: 1.0
References: <1535034528-11590-1-git-send-email-vgarodia@codeaurora.org> <1535034528-11590-3-git-send-email-vgarodia@codeaurora.org>
In-Reply-To: <1535034528-11590-3-git-send-email-vgarodia@codeaurora.org>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Fri, 24 Aug 2018 16:39:03 +0900
X-Gmail-Original-Message-ID: <CAPBb6MXydrrfbWOps-xV4eRzgN6n6pT45B2C=H5tuF2pZOesZQ@mail.gmail.com>
Message-ID: <CAPBb6MXydrrfbWOps-xV4eRzgN6n6pT45B2C=H5tuF2pZOesZQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] venus: firmware: move load firmware in a separate function
To:     vgarodia@codeaurora.org
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
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

On Thu, Aug 23, 2018 at 11:29 PM Vikash Garodia <vgarodia@codeaurora.org> wrote:
>
> Separate firmware loading part into a new function.
>
> Signed-off-by: Vikash Garodia <vgarodia@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/core.c     |  4 +-
>  drivers/media/platform/qcom/venus/firmware.c | 55 ++++++++++++++++++----------
>  drivers/media/platform/qcom/venus/firmware.h |  2 +-
>  3 files changed, 38 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> index bb6add9..75b9785 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -84,7 +84,7 @@ static void venus_sys_error_handler(struct work_struct *work)
>
>         pm_runtime_get_sync(core->dev);
>
> -       ret |= venus_boot(core->dev, core->res->fwname);
> +       ret |= venus_boot(core);
>
>         ret |= hfi_core_resume(core, true);
>
> @@ -284,7 +284,7 @@ static int venus_probe(struct platform_device *pdev)
>         if (ret < 0)
>                 goto err_runtime_disable;
>
> -       ret = venus_boot(dev, core->res->fwname);
> +       ret = venus_boot(core);
>         if (ret)
>                 goto err_runtime_disable;
>
> diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
> index a9d042e..34224eb 100644
> --- a/drivers/media/platform/qcom/venus/firmware.c
> +++ b/drivers/media/platform/qcom/venus/firmware.c
> @@ -60,20 +60,18 @@ int venus_set_hw_state(struct venus_core *core, bool resume)
>         return 0;
>  }
>
> -int venus_boot(struct device *dev, const char *fwname)
> +static int venus_load_fw(struct venus_core *core, const char *fwname,
> +                        phys_addr_t *mem_phys, size_t *mem_size)

Following the remarks of the previous patch, you would have mem_phys
and mem_size as members of venus_core (probably renamed as fw_mem_addr
and fw_mem_size).

>  {
>         const struct firmware *mdt;
>         struct device_node *node;
> -       phys_addr_t mem_phys;
> +       struct device *dev;
>         struct resource r;
>         ssize_t fw_size;
> -       size_t mem_size;
>         void *mem_va;
>         int ret;
>
> -       if (!IS_ENABLED(CONFIG_QCOM_MDT_LOADER) || !qcom_scm_is_available())
> -               return -EPROBE_DEFER;

!IS_ENABLED(CONFIG_QCOM_MDT_LOADER) is not a condition that can change
at runtime, and returning -EPROBE_DEFER in that case seems erroneous
to me. Instead, wouldn't it make more sense to make the driver depend
on QCOM_MDT_LOADER?

> -
> +       dev = core->dev;
>         node = of_parse_phandle(dev->of_node, "memory-region", 0);
>         if (!node) {
>                 dev_err(dev, "no memory-region specified\n");
> @@ -84,16 +82,16 @@ int venus_boot(struct device *dev, const char *fwname)
>         if (ret)
>                 return ret;
>
> -       mem_phys = r.start;
> -       mem_size = resource_size(&r);
> +       *mem_phys = r.start;
> +       *mem_size = resource_size(&r);
>
> -       if (mem_size < VENUS_FW_MEM_SIZE)
> +       if (*mem_size < VENUS_FW_MEM_SIZE)
>                 return -EINVAL;
>
> -       mem_va = memremap(r.start, mem_size, MEMREMAP_WC);
> +       mem_va = memremap(r.start, *mem_size, MEMREMAP_WC);
>         if (!mem_va) {
>                 dev_err(dev, "unable to map memory region: %pa+%zx\n",
> -                       &r.start, mem_size);
> +                       &r.start, *mem_size);
>                 return -ENOMEM;
>         }
>
> @@ -108,23 +106,40 @@ int venus_boot(struct device *dev, const char *fwname)
>                 goto err_unmap;
>         }
>
> -       ret = qcom_mdt_load(dev, mdt, fwname, VENUS_PAS_ID, mem_va, mem_phys,
> -                           mem_size, NULL);
> +       if (core->no_tz)
> +               ret = qcom_mdt_load_no_init(dev, mdt, fwname, VENUS_PAS_ID,
> +                                           mem_va, *mem_phys, *mem_size, NULL);
> +       else
> +               ret = qcom_mdt_load(dev, mdt, fwname, VENUS_PAS_ID,
> +                                   mem_va, *mem_phys, *mem_size, NULL);
>
>         release_firmware(mdt);
>
> -       if (ret)
> -               goto err_unmap;
> -
> -       ret = qcom_scm_pas_auth_and_reset(VENUS_PAS_ID);
> -       if (ret)
> -               goto err_unmap;
> -
>  err_unmap:
>         memunmap(mem_va);
>         return ret;
>  }
>
> +int venus_boot(struct venus_core *core)
> +{
> +       struct device *dev = core->dev;
> +       phys_addr_t mem_phys;
> +       size_t mem_size;
> +       int ret;
> +
> +       if (!IS_ENABLED(CONFIG_QCOM_MDT_LOADER) ||
> +           (!core->no_tz && !qcom_scm_is_available()))
> +               return -EPROBE_DEFER;

Same remark as above here.
