Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E58C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 07:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 149922081B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 07:11:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 149922081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbeJXPiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 11:38:14 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33216 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbeJXPiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 11:38:14 -0400
Received: by mail-qt1-f193.google.com with SMTP id g12-v6so68018qtj.0;
        Wed, 24 Oct 2018 00:11:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CuUpeZ0dke/EP1avkSahmm4HvYvgjZeQbq9c2XpW9ck=;
        b=j4Vmv3B+0thECulUzx1pDtYIcUYXTk3lnR2US5x+aplfF0pxhjeCqrMVKW6x8rL12I
         m1QJK9qW5C8GtullOm6WE7rl7DM9JoX8GNTE8t/nB1/ebcKP0QubVc3J6BBOMCl5myGi
         +DWMVVodp8a/9D+pQ+E1qqGc5HIpXx62MwRZi8i5JPHObh+MXxpXHxbzVG+PrOcxDwud
         atwd9j6CTrE3I2fcDQ0Z5VXcSIFVHF5HMaTm88vXGvNrgpMhDoFMheYD+XVWBoPrpwAs
         xZqbF8GboGgFipX97+c9cdxcp9FyUIhAkvGEZiUEuilWAgiu+cooRLy7LUy2xl3KlT/x
         PblQ==
X-Gm-Message-State: AGRZ1gIqtVzgDuBu31gJf5+Mz4B4sU7M8CflfUSOicVwRDnD4lcBCJMS
        qTA6vZ1aGgrOh1lHxbdIwSVBq2yThfZYxqu9KkE=
X-Google-Smtp-Source: AJdET5ddlIuxCtX+fwBPgTf88cDbhlRKr77At5XnEXG09Hty9UZV23QzenyRg0locsz/DMQ9Ocj2vnMqLpl9xXWzH8M=
X-Received: by 2002:aed:35cb:: with SMTP id d11-v6mr1313094qte.212.1540365085755;
 Wed, 24 Oct 2018 00:11:25 -0700 (PDT)
MIME-Version: 1.0
References: <1539815349-24126-1-git-send-email-alcooperx@gmail.com> <1539815349-24126-5-git-send-email-alcooperx@gmail.com>
In-Reply-To: <1539815349-24126-5-git-send-email-alcooperx@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 24 Oct 2018 08:11:09 +0100
Message-ID: <CAK8P3a3Qw6YraHveY4MW=3u-q5YyOzM3X8V9Q=X7Wr4=1gApGg@mail.gmail.com>
Subject: Re: [PATCH V2 4/6] usb: ohci-platform: Add support for Broadcom STB SoC's
To:     Al Cooper <alcooperx@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Alban Bedel <albeu@free.fr>, Alex Elder <elder@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Avi Fishman <avifishman70@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        David Miller <davem@davemloft.net>,
        DTML <devicetree@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        gregkh <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Hans de Goede <hdegoede@redhat.com>,
        James Hogan <jhogan@kernel.org>, sunjianguo1@huawei.com,
        Johan Hovold <johan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        USB list <linux-usb@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        rishabhb@codeaurora.org, Rob Herring <robh+dt@kernel.org>,
        Roger Quadros <rogerq@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 11:30 PM Al Cooper <alcooperx@gmail.com> wrote:
>
> Add support for Broadcom STB SoC's to the ohci platform driver.
>
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> ---
>  drivers/usb/host/ohci-platform.c | 35 +++++++++++++++++++++++++++++------
>  include/linux/usb/ohci_pdriver.h |  1 +
>  2 files changed, 30 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
> index 65a1c3fdc88c..363d6fa676a5 100644
> --- a/drivers/usb/host/ohci-platform.c
> +++ b/drivers/usb/host/ohci-platform.c
> @@ -22,6 +22,7 @@
>  #include <linux/module.h>
>  #include <linux/err.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/reset.h>
> @@ -99,12 +100,24 @@ static int ohci_platform_probe(struct platform_device *dev)
>         if (usb_disabled())
>                 return -ENODEV;
>
> -       /*
> -        * Use reasonable defaults so platforms don't have to provide these
> -        * with DT probing on ARM.
> -        */
> -       if (!pdata)
> -               pdata = &ohci_platform_defaults;
> +       if (!pdata) {
> +               const struct usb_ohci_pdata *match_pdata;
> +
> +               match_pdata = of_device_get_match_data(&dev->dev);
> +               if (match_pdata) {
> +                       pdata = devm_kzalloc(&dev->dev, sizeof(*pdata),
> +                                            GFP_KERNEL);
> +                       if (!pdata)
> +                               return -ENOMEM;
> +                       *pdata = *match_pdata;

It looks like you copy the const pdata to get a non-const version.
Have you tried
propagating the 'const' modifier so that users can rely on that here?

> +               } else {
> +                       /*
> +                        * Use reasonable defaults so platforms don't have
> +                        * to provide these with DT probing on ARM.
> +                        */
> +                       pdata = &ohci_platform_defaults;
> +               }
> +       }

That would also allow you to unify it with the else path by listing
the ohci_platform_defaults
in the id table for all other compatible strings.

       Arnd
