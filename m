Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B87C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 07:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAF142159F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 07:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KbNKhs/r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAF142159F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbeHXLMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 07:12:49 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:54059 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbeHXLMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 07:12:47 -0400
Received: by mail-it0-f65.google.com with SMTP id k188-v6so972394itk.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 00:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L6nwo8SLxlO4QIbUQ35KT/Lite+qG+oMbnu8Xy2VoFs=;
        b=KbNKhs/rHPR8Nkfvs+4qb+UmjZGx/P+vExr5tPYhk602pA6VSPLgNDYbD5fdd6isX1
         iP7dbp2BJsRqCaK0ke7hHJbaZ+eH/EeCs9JvY9pn+CjuNtW0FHtdQGvwowEDDSbCWX0W
         fqfrG7+5kWOMHii7NDCaeg+HuNSZPl8hQiyZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L6nwo8SLxlO4QIbUQ35KT/Lite+qG+oMbnu8Xy2VoFs=;
        b=VdvsbOBedc+L81B+RCg1GSlaUELMC8DoxCfulLGTpDdJeMTQD2NZJUnSroTRS6aGUY
         rXsHa7nMqGJoUQRPzFLUwDiDnzD/Jjym2IdGb4v1E6/PJxLI0b09IBkG0BPgrUYOtUuO
         rZn2lM3CqhG+AqCtSRLuBhmxyZDVxn3WIf5uy584ABuvR+l5Etasyx0eANH9fCaTRBpy
         O/kk+/OdxYMefs+yGU/8zUeV03UIck+X0HB5/BfdT20OYezfk9iFqlP7jTe2VC0senH5
         AvOrRisDbGmLYlj5gnbYVJxy9nj37gV0nNTCQOOXJcx0kliYA2ain3WM1W8KDCq8w/Gn
         K2cg==
X-Gm-Message-State: APzg51C5L4FCC+n8ioAurd2o3ODKsF1IkMtwnHaV26BI9Nry81DQb0dG
        mhSuQ7ZuxldAYOHDrSnowO3kvL8XItpCAw==
X-Google-Smtp-Source: ANB0VdYZfHLI79PECrdVm8NYAfAYYcIhrO6slCQt7pFPHpDcg/0DM80EsTg4EYo1u3jP4yAChVuihA==
X-Received: by 2002:a24:9ec1:: with SMTP id p184-v6mr547929itd.6.1535096362474;
        Fri, 24 Aug 2018 00:39:22 -0700 (PDT)
Received: from mail-io0-f176.google.com (mail-io0-f176.google.com. [209.85.223.176])
        by smtp.gmail.com with ESMTPSA id y21-v6sm1144005ioy.20.2018.08.24.00.39.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 00:39:21 -0700 (PDT)
Received: by mail-io0-f176.google.com with SMTP id v14-v6so6425772iob.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 00:39:21 -0700 (PDT)
X-Received: by 2002:a6b:33ce:: with SMTP id z197-v6mr396303ioz.112.1535096360445;
 Fri, 24 Aug 2018 00:39:20 -0700 (PDT)
MIME-Version: 1.0
References: <1535034528-11590-1-git-send-email-vgarodia@codeaurora.org> <1535034528-11590-5-git-send-email-vgarodia@codeaurora.org>
In-Reply-To: <1535034528-11590-5-git-send-email-vgarodia@codeaurora.org>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Fri, 24 Aug 2018 16:39:09 +0900
X-Gmail-Original-Message-ID: <CAPBb6MW8uN5_ghxx7h3g0TjmULUpvNSDn8g=trTC5fOegHP1QQ@mail.gmail.com>
Message-ID: <CAPBb6MW8uN5_ghxx7h3g0TjmULUpvNSDn8g=trTC5fOegHP1QQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] venus: firmware: register separate platform_device
 for firmware loader
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
> From: Stanimir Varbanov <stanimir.varbanov@linaro.org>
>
> This registers a firmware platform_device and associate it with
> video-firmware DT subnode. Then calls dma configure to initialize
> dma and iommu.
>
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  .../devicetree/bindings/media/qcom,venus.txt       | 13 +++++-
>  drivers/media/platform/qcom/venus/core.c           | 14 +++++--
>  drivers/media/platform/qcom/venus/firmware.c       | 49 ++++++++++++++++++++++
>  drivers/media/platform/qcom/venus/firmware.h       |  2 +
>  4 files changed, 73 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/media/qcom,venus.txt b/Documentation/devicetree/bindings/media/qcom,venus.txt
> index 00d0d1b..7e04586 100644
> --- a/Documentation/devicetree/bindings/media/qcom,venus.txt
> +++ b/Documentation/devicetree/bindings/media/qcom,venus.txt
> @@ -53,7 +53,7 @@
>
>  * Subnodes
>  The Venus video-codec node must contain two subnodes representing
> -video-decoder and video-encoder.
> +video-decoder and video-encoder, and one optional firmware subnode.

Just noticed that the document does not explain in which case the
firmware subnode must be used. Maybe we should have a sentence
explaining that without it we will be using TrustZone to load the
firmware?

>
>  Every of video-encoder or video-decoder subnode should have:
>
> @@ -79,6 +79,13 @@ Every of video-encoder or video-decoder subnode should have:
>                     power domain which is responsible for collapsing
>                     and restoring power to the subcore.
>
> +The firmware subnode must have:
> +
> +- iommus:
> +       Usage: required
> +       Value type: <prop-encoded-array>
> +       Definition: A list of phandle and IOMMU specifier pairs.
> +
>  * An Example
>         video-codec@1d00000 {
>                 compatible = "qcom,msm8916-venus";
> @@ -105,4 +112,8 @@ Every of video-encoder or video-decoder subnode should have:
>                         clock-names = "core";
>                         power-domains = <&mmcc VENUS_CORE1_GDSC>;
>                 };
> +
> +               video-firmware {
> +                       iommus = <&apps_iommu 0x10b2 0x0>;
> +               };
>         };
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> index 393994e..3bd3b8a 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -284,6 +284,14 @@ static int venus_probe(struct platform_device *pdev)
>         if (ret < 0)
>                 goto err_runtime_disable;
>
> +       ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
> +       if (ret)
> +               goto err_runtime_disable;
> +
> +       ret = venus_firmware_init(core);
> +       if (ret)
> +               goto err_runtime_disable;
> +
>         ret = venus_boot(core);
>         if (ret)
>                 goto err_runtime_disable;
> @@ -308,10 +316,6 @@ static int venus_probe(struct platform_device *pdev)
>         if (ret)
>                 goto err_core_deinit;
>
> -       ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
> -       if (ret)
> -               goto err_dev_unregister;
> -
>         ret = pm_runtime_put_sync(dev);
>         if (ret)
>                 goto err_dev_unregister;
> @@ -347,6 +351,8 @@ static int venus_remove(struct platform_device *pdev)
>         venus_shutdown(core);
>         of_platform_depopulate(dev);
>
> +       venus_firmware_deinit(core);
> +
>         pm_runtime_put_sync(dev);
>         pm_runtime_disable(dev);
>
> diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
> index 79b3858..86a26fb 100644
> --- a/drivers/media/platform/qcom/venus/firmware.c
> +++ b/drivers/media/platform/qcom/venus/firmware.c
> @@ -20,6 +20,7 @@
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/platform_device.h>
> +#include <linux/of_device.h>
>  #include <linux/qcom_scm.h>
>  #include <linux/sizes.h>
>  #include <linux/soc/qcom/mdt_loader.h>
> @@ -228,3 +229,51 @@ int venus_shutdown(struct venus_core *core)
>
>         return ret;
>  }
> +
> +int venus_firmware_init(struct venus_core *core)
> +{
> +       struct platform_device_info info;
> +       struct platform_device *pdev;
> +       struct device_node *np;
> +       int ret;
> +
> +       np = of_get_child_by_name(core->dev->of_node, "video-firmware");
> +       if (!np)
> +               return 0;
> +
> +       memset(&info, 0, sizeof(info));
> +       info.fwnode = &np->fwnode;
> +       info.parent = core->dev;
> +       info.name = np->name;
> +       info.dma_mask = DMA_BIT_MASK(32);
> +
> +       pdev = platform_device_register_full(&info);
> +       if (IS_ERR(pdev)) {
> +               of_node_put(np);
> +               return PTR_ERR(pdev);
> +       }
> +
> +       pdev->dev.of_node = np;
> +
> +       ret = of_dma_configure(&pdev->dev, np);
> +       if (ret)
> +               dev_err(core->dev, "dma configure fail\n");
> +
> +       of_node_put(np);
> +
> +       if (ret)
> +               return ret;
> +
> +       core->no_tz = true;
> +       core->fw.dev = &pdev->dev;
> +
> +       return 0;
> +}
> +
> +void venus_firmware_deinit(struct venus_core *core)
> +{
> +       if (!core->fw.dev)
> +               return;
> +
> +       platform_device_unregister(to_platform_device(core->fw.dev));
> +}
> diff --git a/drivers/media/platform/qcom/venus/firmware.h b/drivers/media/platform/qcom/venus/firmware.h
> index f41b615..119a9a4 100644
> --- a/drivers/media/platform/qcom/venus/firmware.h
> +++ b/drivers/media/platform/qcom/venus/firmware.h
> @@ -16,6 +16,8 @@
>
>  struct device;
>
> +int venus_firmware_init(struct venus_core *core);
> +void venus_firmware_deinit(struct venus_core *core);
>  int venus_boot(struct venus_core *core);
>  int venus_shutdown(struct venus_core *core);
>  int venus_set_hw_state(struct venus_core *core, bool suspend);
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
