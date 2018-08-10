Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B2FC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 17:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D83D422448
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 17:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L3XbsYjx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D83D422448
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbeHJTwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 15:52:41 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45808 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbeHJTwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 15:52:40 -0400
Received: by mail-lj1-f195.google.com with SMTP id w16-v6so7717662ljh.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 10:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t/Se3Nd0WWN0u5SexQX2aqlVv+RzyYhhGV7AdwnImfg=;
        b=L3XbsYjxD5xYBfvO6iinlg3xV8E3qVH+hWt+Y3VZr9j6hpU/k60RSkpAxzdqZiNNpc
         ct8tQNkTFBt81/QEnsXr2aaeEHFQnguHgcexQXHTTei19ZmKa9lCW/M471Cr2EdJ/UYv
         BiubtCUVP5WUO1VaxEGceWHojCldt92K4uCPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t/Se3Nd0WWN0u5SexQX2aqlVv+RzyYhhGV7AdwnImfg=;
        b=hPStj4gfKuv9Ugrm1fste2E2qY/UBBGfRJRQQO4KTnvdHIBAcI7sf/e2a/RP2nAcIl
         YrVuAhtdkrd4kZ93yAYOvcYoV4znVM7R6kyjtvjoOCIc6ku2zTxUvdOEHyOZ7M5m/SBg
         7dn/Y9TDU0SLge6HB7ZsSAARA4Ea6th8DBoxsBBCeo9wazDdHIt7I4FJ1s8iCKhHfivQ
         P9uM9kL+afaLXdkZxMTN9tgqbT7GQzkVcy9FVMUnt2ULYbQbu/7W92yVyVaBpIldCDfM
         rWVYirkA1xEQRQUOUqRvBbCd1a3DRAnNUbRttbwcweTvY6Z/4pc6tLCZnCMtetVuzTVN
         469w==
X-Gm-Message-State: AOUpUlHP88Z0fiKjBnmogC9AKmx6re5PxLMAVnYaeh675bSdB0dCxRIB
        GioHXEz+1/dHFxYjtlOUbrew3iYH0U0=
X-Google-Smtp-Source: AA+uWPwYiKrMMybGvchpehKct62giAuqVowjKOHGEx1pDsaWg8i8dapD3QwLpvRKWRRcITfi3zD29A==
X-Received: by 2002:a2e:291c:: with SMTP id u28-v6mr5248957lje.70.1533921714310;
        Fri, 10 Aug 2018 10:21:54 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id b80-v6sm2026252lfe.83.2018.08.10.10.21.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 10:21:53 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id q127-v6so7699731ljq.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 10:21:51 -0700 (PDT)
X-Received: by 2002:a2e:1207:: with SMTP id t7-v6mr5216042lje.129.1533921711484;
 Fri, 10 Aug 2018 10:21:51 -0700 (PDT)
MIME-Version: 1.0
References: <1533155615-27929-1-git-send-email-vnkgutta@codeaurora.org> <1533155615-27929-3-git-send-email-vnkgutta@codeaurora.org>
In-Reply-To: <1533155615-27929-3-git-send-email-vnkgutta@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 10 Aug 2018 10:21:14 -0700
X-Gmail-Original-Message-ID: <CAE=gft4zc8vHt_O0dTomu=3zq-_ri52WnjH=F6BhyaNoybu2hQ@mail.gmail.com>
Message-ID: <CAE=gft4zc8vHt_O0dTomu=3zq-_ri52WnjH=F6BhyaNoybu2hQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] drivers: soc: Add support to register LLCC EDAC driver
To:     vnkgutta@codeaurora.org
Cc:     robh@kernel.org, mchehab@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, tsoni@codeaurora.org,
        ckadabi@codeaurora.org, rishabhb@codeaurora.org, bp@alien8.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 1:33 PM Venkata Narendra Kumar Gutta
<vnkgutta@codeaurora.org> wrote:
>
> Cache error reporting controller is to detect and report single
> and double bit errors on Last Level Cache Controller (LLCC) cache.
> Add required support to register LLCC EDAC driver as platform driver,
> from LLCC driver.
>
> Signed-off-by: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
> ---
>  drivers/soc/qcom/llcc-slice.c      | 18 ++++++++++++++++--
>  include/linux/soc/qcom/llcc-qcom.h |  2 ++
>  2 files changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/soc/qcom/llcc-slice.c b/drivers/soc/qcom/llcc-slice.c
> index a63640d..09c8bb0 100644
> --- a/drivers/soc/qcom/llcc-slice.c
> +++ b/drivers/soc/qcom/llcc-slice.c
> @@ -224,7 +224,7 @@ static int qcom_llcc_cfg_program(struct platform_device *pdev)
>         u32 attr0_val;
>         u32 max_cap_cacheline;
>         u32 sz;
> -       int ret;
> +       int ret = 0;
>         const struct llcc_slice_config *llcc_table;
>         struct llcc_slice_desc desc;
>
> @@ -282,6 +282,7 @@ int qcom_llcc_probe(struct platform_device *pdev,
>         struct resource *llcc_banks_res, *llcc_bcast_res;
>         void __iomem *llcc_banks_base, *llcc_bcast_base;
>         int ret, i;
> +       struct platform_device *llcc_edac;
>
>         drv_data = devm_kzalloc(dev, sizeof(*drv_data), GFP_KERNEL);
>         if (!drv_data)
> @@ -341,6 +342,19 @@ int qcom_llcc_probe(struct platform_device *pdev,
>         mutex_init(&drv_data->lock);
>         platform_set_drvdata(pdev, drv_data);
>
> -       return qcom_llcc_cfg_program(pdev);
> +       ret = qcom_llcc_cfg_program(pdev);
> +       if (ret)
> +               return ret;
> +
> +       drv_data->ecc_irq = platform_get_irq(pdev, 0);
> +       if (drv_data->ecc_irq >= 0) {

This condition will always be true for u32. See below...

> +               llcc_edac = platform_device_register_data(&pdev->dev,
> +                                               "qcom_llcc_edac", -1, drv_data,
> +                                               sizeof(*drv_data));
> +               if (IS_ERR(llcc_edac))
> +                       dev_err(dev, "Failed to register llcc edac driver\n");
> +       }
> +
> +       return ret;
>  }
>  EXPORT_SYMBOL_GPL(qcom_llcc_probe);
> diff --git a/include/linux/soc/qcom/llcc-qcom.h b/include/linux/soc/qcom/llcc-qcom.h
> index c681e79..1a3bc25 100644
> --- a/include/linux/soc/qcom/llcc-qcom.h
> +++ b/include/linux/soc/qcom/llcc-qcom.h
> @@ -78,6 +78,7 @@ struct llcc_slice_config {
>   * @num_banks: Number of llcc banks
>   * @bitmap: Bit map to track the active slice ids
>   * @offsets: Pointer to the bank offsets array
> + * @ecc_irq: interrupt for llcc cache error detection and reporting
>   */
>  struct llcc_drv_data {
>         struct regmap *regmap;
> @@ -89,6 +90,7 @@ struct llcc_drv_data {
>         u32 num_banks;
>         unsigned long *bitmap;
>         u32 *offsets;
> +       u32 ecc_irq;

The return type for platform_get_irq is int, so this should probably
be int, or "unsigned", but then you'd need to fix your logic above.

>  };
>
>  #if IS_ENABLED(CONFIG_QCOM_LLCC)
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
