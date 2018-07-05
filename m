Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3E6C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F2524137
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hzDw14IZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96F2524137
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754779AbeGENKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:10:21 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:50939 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754615AbeGENKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:10:09 -0400
Received: by mail-it0-f67.google.com with SMTP id u4-v6so11900743itg.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 06:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bY83nIQM5ZIls4Ebyoe6EPsn0kQlVqHVRRPsriDcF6Y=;
        b=hzDw14IZRJ2EKByRvmsDMCqDPxzEH6muzzZcxtg/dFvGRMTwbBsQd53nlwu4sbKd0M
         tlqzaga8h/LAB0F1GZ+1EheoA5lB+GC8evgOFva7ljf3WiM9VkwySk8hGUpU32naXaSe
         1kyD1ZDXL8nGxC3YkRRq6u8dgC4GgesKbgEig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bY83nIQM5ZIls4Ebyoe6EPsn0kQlVqHVRRPsriDcF6Y=;
        b=L6Ad3mqsqsC1rAX1nOwcx/l8dx4Ua7/LuUBffgadlIHJQ88neJO6dRqBBtEHQazyeM
         vmgkNIFpDzckk49GHIB58OZWjjpJrPA+h484qub09f0Ux3O2GYJDH0tHPOzXIl7Mpmly
         kGKdclyUbwVJ5dlJwiBORX0L2wnteWFHBAalUfl4Ri2L4QXgOba3f+wv9elDCJX7Lqjg
         pu34jAeXVCifkjoLgsCTgANIE6rPS7dHB+XujVtuN7DZaQkbv27X1rrMmd0mj0CGj4Hi
         EL2EBgiCdbXNlTq27DfdokpTSDBoh2wPByfY0fCw8AymyP3a6kUVaxSb2RT/y5P8aXWz
         yfHw==
X-Gm-Message-State: APt69E25sXgH/GKEFfrKcNoMxkLSxa3NkiPIRT2zsf3OjhvXUFtzApz9
        Ha+evBCFjxqBifuDGeF6ZWTkyEldhzFGqAC/CyfK0Q==
X-Google-Smtp-Source: AAOMgpc5mkM0WHVwlGbt0it3yJPzYz+4vUvVIJy9M19/YmVHywBj4aUciB3VeXfvuhkQ7AjGIU9dtgQxmHoJwN78DjE=
X-Received: by 2002:a24:69cb:: with SMTP id e194-v6mr5169884itc.102.1530796208538;
 Thu, 05 Jul 2018 06:10:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:818f:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 06:10:08 -0700 (PDT)
In-Reply-To: <20180705121819.7157-1-stefan@agner.ch>
References: <20180705121819.7157-1-stefan@agner.ch>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 5 Jul 2018 15:10:08 +0200
Message-ID: <CAPDyKFrrWnT6qfXYnbh3Q5gbnELqBMm==kyy1JBvWPER1ZZa6A@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: do not try to use 3.3V signaling if not supported
To:     Stefan Agner <stefan@agner.ch>
Cc:     Adrian Hunter <adrian.hunter@intel.com>, marcel@ziswiler.com,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 July 2018 at 14:18, Stefan Agner <stefan@agner.ch> wrote:
> For eMMC devices it is valid to only support 1.8V signaling. When
> vqmmc is set to a fixed 1.8V regulator the stack tries to set 3.3V
> initially and prints the following warning:
>    mmc1: Switching to 3.3V signalling voltage failed
>
> Clear the MMC_SIGNAL_VOLTAGE_330 flag in case 3.3V is signaling is
> not available. This prevents the stack from even trying to use
> 3.3V signaling and avoids the above warning.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 1c828e0e9905..a7b5602ef6f7 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3734,14 +3734,21 @@ int sdhci_setup_host(struct sdhci_host *host)
>             mmc_gpio_get_cd(host->mmc) < 0)
>                 mmc->caps |= MMC_CAP_NEEDS_POLL;
>
> -       /* If vqmmc regulator and no 1.8V signalling, then there's no UHS */
>         if (!IS_ERR(mmc->supply.vqmmc)) {
>                 ret = regulator_enable(mmc->supply.vqmmc);
> +
> +               /* If vqmmc provides no 1.8V signalling, then there's no UHS */
>                 if (!regulator_is_supported_voltage(mmc->supply.vqmmc, 1700000,
>                                                     1950000))
>                         host->caps1 &= ~(SDHCI_SUPPORT_SDR104 |
>                                          SDHCI_SUPPORT_SDR50 |
>                                          SDHCI_SUPPORT_DDR50);
> +
> +               /* In eMMC case vqmmc might be a fixed 1.8V regulator */
> +               if (!regulator_is_supported_voltage(mmc->supply.vqmmc, 2700000,
> +                                                   3600000))
> +                       host->flags &= ~SDHCI_SIGNALING_330;
> +
>                 if (ret) {
>                         pr_warn("%s: Failed to enable vqmmc regulator: %d\n",
>                                 mmc_hostname(mmc), ret);
> --
> 2.18.0
>
