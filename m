Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EAAC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 07:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FAE62159F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 07:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hIBGOsE5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FAE62159F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbeHXLMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 07:12:45 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:36833 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbeHXLMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 07:12:44 -0400
Received: by mail-io0-f193.google.com with SMTP id q5-v6so3200618iop.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 00:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O8+ZrSrrYmeB0y0BOyaYP2/fY0441p92/h7FYP7EWjg=;
        b=hIBGOsE5It/xDjPduaYqBWv/VseoP2csTUHpK+k1x7eFNhlvHhle9Yiof/f4uJ1iaj
         qvHQREJZDV8SC1ElTQlxbVMIW32cZT+iO2bCQV1y1MV5jB8S6Z7S902sAVFOHBQjt+PK
         0pIMFULvE66LUMrfuFXFPwvhkQCvTu0uV50KE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O8+ZrSrrYmeB0y0BOyaYP2/fY0441p92/h7FYP7EWjg=;
        b=bbkk/99ny4BdA0MOEDTC9fElYAJSIBZSNuXQqv608GOGxIWSUke2Z/VnxxXgBk4xcH
         guZ5jw9vppkpRLNxhZfbtxZG8Y/hYT5XShN6hzwlZ2Wc/zdLUQUr7eOH/IMrJ6tN6Dcf
         GvMgbJljQQ2vZSy/OeXGpme27GlF8ATM68B4Cr7CuFDPzDIS/MddSKuwUnohDjnO5GrL
         ix0Ba6WQyvkPnobKETqzfEDYKlJ9HViaRTf9I15A3+N5MGujAFH6oiQrTeKrYYfvbDlD
         c1RxC6P/t1Wsg1Q16byBUO+dutKkxCj5ZaY1hket/t8WpjzG7PZ48bKR3iiHgU/GCb0D
         FWiA==
X-Gm-Message-State: APzg51CW0reNbQMu2vwki0XiPBE1U6UXxqyQbKCdEDoN3BfC/RK2uUST
        CvpVPE3r1EzinjozPRxG9GgIIBehV9sKLw==
X-Google-Smtp-Source: ANB0VdbYlbtEDUEKm2XhtOn4L+N7c8iofLKN+JDHHlXD/BlBbvH0VKNBLHBDWcYhimUnloRP3ZKBiA==
X-Received: by 2002:a6b:be46:: with SMTP id o67-v6mr343539iof.143.1535096359723;
        Fri, 24 Aug 2018 00:39:19 -0700 (PDT)
Received: from mail-it0-f49.google.com (mail-it0-f49.google.com. [209.85.214.49])
        by smtp.gmail.com with ESMTPSA id 5-v6sm2339655ioy.35.2018.08.24.00.39.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 00:39:19 -0700 (PDT)
Received: by mail-it0-f49.google.com with SMTP id e14-v6so980242itf.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 00:39:18 -0700 (PDT)
X-Received: by 2002:a24:400b:: with SMTP id n11-v6mr606860ita.2.1535096358405;
 Fri, 24 Aug 2018 00:39:18 -0700 (PDT)
MIME-Version: 1.0
References: <1535034528-11590-1-git-send-email-vgarodia@codeaurora.org> <1535034528-11590-4-git-send-email-vgarodia@codeaurora.org>
In-Reply-To: <1535034528-11590-4-git-send-email-vgarodia@codeaurora.org>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Fri, 24 Aug 2018 16:39:06 +0900
X-Gmail-Original-Message-ID: <CAPBb6MV1jjksgbSaCuUcY_ZbjfGeK-GaQ_+OZ7LWUv4ehA3dGQ@mail.gmail.com>
Message-ID: <CAPBb6MV1jjksgbSaCuUcY_ZbjfGeK-GaQ_+OZ7LWUv4ehA3dGQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] venus: firmware: add no TZ boot and shutdown routine
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
> Video hardware is mainly comprised of vcodec subsystem and video
> control subsystem. Video control has ARM9 which executes the video
> firmware instructions whereas vcodec does the video frame processing.
> This change adds support to load the video firmware and bring ARM9
> out of reset for platforms which does not have trustzone.
>
> Signed-off-by: Vikash Garodia <vgarodia@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/core.c         |  6 +-
>  drivers/media/platform/qcom/venus/core.h         |  7 ++
>  drivers/media/platform/qcom/venus/firmware.c     | 90 +++++++++++++++++++++++-
>  drivers/media/platform/qcom/venus/firmware.h     |  2 +-
>  drivers/media/platform/qcom/venus/hfi_venus_io.h |  1 +
>  5 files changed, 99 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> index 75b9785..393994e 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -76,7 +76,7 @@ static void venus_sys_error_handler(struct work_struct *work)
>         hfi_core_deinit(core, true);
>         hfi_destroy(core);
>         mutex_lock(&core->lock);
> -       venus_shutdown(core->dev);
> +       venus_shutdown(core);
>
>         pm_runtime_put_sync(core->dev);
>
> @@ -323,7 +323,7 @@ static int venus_probe(struct platform_device *pdev)
>  err_core_deinit:
>         hfi_core_deinit(core, false);
>  err_venus_shutdown:
> -       venus_shutdown(dev);
> +       venus_shutdown(core);
>  err_runtime_disable:
>         pm_runtime_set_suspended(dev);
>         pm_runtime_disable(dev);
> @@ -344,7 +344,7 @@ static int venus_remove(struct platform_device *pdev)
>         WARN_ON(ret);
>
>         hfi_destroy(core);
> -       venus_shutdown(dev);
> +       venus_shutdown(core);
>         of_platform_depopulate(dev);
>
>         pm_runtime_put_sync(dev);
> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
> index dfd5c10..b2cb359 100644
> --- a/drivers/media/platform/qcom/venus/core.h
> +++ b/drivers/media/platform/qcom/venus/core.h
> @@ -81,6 +81,11 @@ struct venus_caps {
>         bool valid;     /* used only for Venus v1xx */
>  };
>
> +struct video_firmware {
> +       struct device *dev;
> +       struct iommu_domain *iommu_domain;
> +};
> +
>  /**
>   * struct venus_core - holds core parameters valid for all instances
>   *
> @@ -98,6 +103,7 @@ struct venus_caps {
>   * @dev:               convenience struct device pointer
>   * @dev_dec:   convenience struct device pointer for decoder device
>   * @dev_enc:   convenience struct device pointer for encoder device
> + * @fw:                a struct for venus firmware info
>   * @no_tz:     a flag that suggests presence of trustzone
>   * @lock:      a lock for this strucure
>   * @instances: a list_head of all instances
> @@ -130,6 +136,7 @@ struct venus_core {
>         struct device *dev;
>         struct device *dev_dec;
>         struct device *dev_enc;
> +       struct video_firmware fw;

Since struct video_firmware is only used here I think you can declare
it inline, i.e.

    struct {
        struct device *dev;
        struct iommu_domain *iommu_domain;
    } fw;

This structure is actually a good candidate to hold the firmware
memory area start address and size.

>         bool no_tz;
>         struct mutex lock;
>         struct list_head instances;
> diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
> index 34224eb..79b3858 100644
> --- a/drivers/media/platform/qcom/venus/firmware.c
> +++ b/drivers/media/platform/qcom/venus/firmware.c
> @@ -15,9 +15,11 @@
>  #include <linux/device.h>
>  #include <linux/firmware.h>
>  #include <linux/kernel.h>
> +#include <linux/iommu.h>
>  #include <linux/io.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> +#include <linux/platform_device.h>
>  #include <linux/qcom_scm.h>
>  #include <linux/sizes.h>
>  #include <linux/soc/qcom/mdt_loader.h>
> @@ -120,6 +122,76 @@ static int venus_load_fw(struct venus_core *core, const char *fwname,
>         return ret;
>  }
>
> +static int venus_boot_no_tz(struct venus_core *core, phys_addr_t mem_phys,
> +                           size_t mem_size)

After moving the firmware address and size into venus_core you won't
need the last two arguments.

> +{
> +       struct iommu_domain *iommu_dom;
> +       struct device *dev;
> +       int ret;
> +
> +       dev = core->fw.dev;
> +       if (!dev)
> +               return -EPROBE_DEFER;
> +
> +       iommu_dom = iommu_domain_alloc(&platform_bus_type);
> +       if (!iommu_dom) {
> +               dev_err(dev, "Failed to allocate iommu domain\n");
> +               return -ENOMEM;
> +       }
> +
> +       ret = iommu_attach_device(iommu_dom, dev);
> +       if (ret) {
> +               dev_err(dev, "could not attach device\n");
> +               goto err_attach;
> +       }

I think like the above belongs more in venus_firmware_init()
(introduced in patch 4/4) than here. There is no reason to
detach/reattach the iommu if we stop the firmware.

> +
> +       ret = iommu_map(iommu_dom, VENUS_FW_START_ADDR, mem_phys, mem_size,
> +                       IOMMU_READ | IOMMU_WRITE | IOMMU_PRIV);
> +       if (ret) {
> +               dev_err(dev, "could not map video firmware region\n");
> +               goto err_map;
> +       }

Maybe this too?

> +
> +       core->fw.iommu_domain = iommu_dom;
> +       venus_reset_cpu(core);
> +
> +       return 0;
> +
> +err_map:
> +       iommu_detach_device(iommu_dom, dev);
> +err_attach:
> +       iommu_domain_free(iommu_dom);
> +       return ret;
> +}
> +
> +static int venus_shutdown_no_tz(struct venus_core *core)
> +{
> +       struct iommu_domain *iommu;
> +       size_t unmapped;
> +       u32 reg;
> +       struct device *dev = core->fw.dev;
> +       void __iomem *base = core->base;
> +
> +       /* Assert the reset to ARM9 */
> +       reg = readl_relaxed(base + WRAPPER_A9SS_SW_RESET);
> +       reg |= WRAPPER_A9SS_SW_RESET_BIT;
> +       writel_relaxed(reg, base + WRAPPER_A9SS_SW_RESET);
> +
> +       /* Make sure reset is asserted before the mapping is removed */
> +       mb();
> +
> +       iommu = core->fw.iommu_domain;
> +
> +       unmapped = iommu_unmap(iommu, VENUS_FW_START_ADDR, VENUS_FW_MEM_SIZE);
> +       if (unmapped != VENUS_FW_MEM_SIZE)
> +               dev_err(dev, "failed to unmap firmware\n");
> +
> +       iommu_detach_device(iommu, dev);
> +       iommu_domain_free(iommu);

Accordingly, this would also be moved into venus_firmware_deinit().
