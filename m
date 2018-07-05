Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0D0C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1765024137
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TfZAovrl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1765024137
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754766AbeGENJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:09:47 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:42649 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754608AbeGENJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:09:44 -0400
Received: by mail-io0-f195.google.com with SMTP id r24-v6so7673939ioh.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 06:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Fe8j+6MxvYAr7ONStUnksGWHHmGE9fpfBjjpvTXpylc=;
        b=TfZAovrlujwTc5ozKaQpkUdZzVCVx93xERjOEIdtCAq+GzFcJZjnltXnGQU6uNzcBl
         epQVtvM0q18fvvsw2ENx+lm29fnl4pCMmaRxmIQPtp2+XvdPdsMo1NQJU+ReeuNWIViR
         eUThkRVbZPUgSw45a8G5eea+1JOX7gL723z+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Fe8j+6MxvYAr7ONStUnksGWHHmGE9fpfBjjpvTXpylc=;
        b=WbARpaVjCuhQYnMiL+jGKh3IqqoS9lRgDh34yc6CnfB1IT9gDTQhdoYj1FDQ1hXnDT
         U3BbxXpxtNXNMgzHMYueWKUnb1DVaWVRP3Qe40LgVXbN0hjGIJznzWpwu1/VXlLjll0C
         ej6o/nV4XtW0F0FE6OOZ2MP7XF3LN1BcVgs4c+fUrOCOPJF8FBoS0fPX6TBvSq1WKgM0
         9jWZqFV13rgdiMadHFN4IvXRYpXfITHA3rf4dbnezIBSEqVbJVuVqZGmuCvgNm1+7YG9
         KK/VkYu7woNsl4d3JWBHIpryggk/ccmYSbB8w4ijGNgBk7798oF6YNkNQh0oHGypYwFI
         AhPg==
X-Gm-Message-State: AOUpUlE1KgzlKfbci9/9NkwQFP0iEfSTgHr51rbz+hiQRpSImoNeOQpL
        HjouXr6sWRYRmH7gCMV4ptV66QGHxvYnCufkBdExQA==
X-Google-Smtp-Source: AAOMgpfFIEDEP8uAc90Q27Y+B4/hJlQyixsYQUHc+yIJb/Ktr+0ehSvZx0nJ/VpSTkB+FakU1PWXGeKfqs7v6+AQ8W4=
X-Received: by 2002:a6b:144c:: with SMTP id 73-v6mr4772365iou.218.1530796183608;
 Thu, 05 Jul 2018 06:09:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:818f:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 06:09:43 -0700 (PDT)
In-Reply-To: <20180705121500.6256-1-stefan@agner.ch>
References: <20180705121500.6256-1-stefan@agner.ch>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 5 Jul 2018 15:09:43 +0200
Message-ID: <CAPDyKFrHH2Hm+Z1DgJiSunFwaC_yed_oVp82Y0dw7UMAhAq3+w@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: disable clocks before changing frequency
To:     Stefan Agner <stefan@agner.ch>
Cc:     Adrian Hunter <adrian.hunter@intel.com>, marcel@ziswiler.com,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 July 2018 at 14:15, Stefan Agner <stefan@agner.ch> wrote:
> In the uSDHC case (e.g. i.MX 6) clocks only get disabled if frequency
> is set to 0. However, it could be that the stack asks for a frequency
> change while clocks are on. In that case the function clears the
> divider registers (by clearing ESDHC_CLOCK_MASK) while the clock is
> enabled! This causes a short period of time where the clock is
> undivided (on a i.MX 6DL a clock of 196MHz has been measured).
>
> For older IP variants the driver disables clock by clearing some bits
> in ESDHC_SYSTEM_CONTROL.
>
> Make sure to disable card clock before chainging frequency for uSDHC
> IP variants too. Also fix indent to make disable/enable clock look
> alike.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Thanks, applied for next!

Please tell if you want this for fixes and if I should add a stable tag.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 85fd5a8b0b6d..aa48f4b2541a 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -708,14 +708,14 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
>         int div = 1;
>         u32 temp, val;
>
> +       if (esdhc_is_usdhc(imx_data)) {
> +               val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
> +               writel(val & ~ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
> +                       host->ioaddr + ESDHC_VENDOR_SPEC);
> +       }
> +
>         if (clock == 0) {
>                 host->mmc->actual_clock = 0;
> -
> -               if (esdhc_is_usdhc(imx_data)) {
> -                       val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
> -                       writel(val & ~ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
> -                                       host->ioaddr + ESDHC_VENDOR_SPEC);
> -               }
>                 return;
>         }
>
> @@ -761,7 +761,7 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
>         if (esdhc_is_usdhc(imx_data)) {
>                 val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
>                 writel(val | ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
> -               host->ioaddr + ESDHC_VENDOR_SPEC);
> +                       host->ioaddr + ESDHC_VENDOR_SPEC);
>         }
>
>         mdelay(1);
> --
> 2.18.0
>
