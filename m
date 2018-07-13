Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7F4ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 669F020875
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 20:08:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 669F020875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731944AbeGMUYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 16:24:48 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:33192 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731342AbeGMUYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 16:24:47 -0400
Received: by mail-vk0-f66.google.com with SMTP id y70-v6so16533688vkc.0;
        Fri, 13 Jul 2018 13:08:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sj3UdCdoOIB7vFt8H4NM/QX+76s8Bh+g6rRWTux0JM0=;
        b=XL84QxffieGAfi9OxzYrXxaa74vzIKNdP9kBCZZCHoF30I8zw5hxO2cdy0oMRmsDNU
         VZbOyvenyiJ6/2Jf7PmoLXBK7TclhmlZuy74Fv3ZBsD6y+3Hy8OQ7H/TMUEUt/A2xe+2
         kGJ3lwxmkjlWFm7KwtKQ2HjS+RILkF41tIrxxUhTsf1Nk6aE+TLJf44MyFkYXr8X3khK
         NWcKfYoX/U4/XJgJqpKJ0efpyGx7q028BLz6AxtTPxn+FJ0m6POtrg+vULblpQtgbEk3
         gz1khsyh1mrKC7AGjbQBLiYQxxg2Z3WbhmQmySsn1yAFfE/MrXwhTxPoVX1WOFQyKA/r
         YwyQ==
X-Gm-Message-State: AOUpUlHtuwN4i+4LnLWADbgGIYpiDYLSV7GnPazHfesyGqLMqe3a4Bm6
        zhxUbM9irtjTHKxSHv2tva/bcmYuC0WbEl6zID8=
X-Google-Smtp-Source: AAOMgpehQkpH1H9w6vnr4WmmnP9PaRj11HhYR9GpjTCdFpottYKNcg/ejA4WWZoI8dXsnaINW++ztgkt73VPI7+DUUE=
X-Received: by 2002:a1f:2cce:: with SMTP id s197-v6mr4505309vks.106.1531512520437;
 Fri, 13 Jul 2018 13:08:40 -0700 (PDT)
MIME-Version: 1.0
References: <20180713154720.18316-1-geert+renesas@glider.be> <20180713154720.18316-2-geert+renesas@glider.be>
In-Reply-To: <20180713154720.18316-2-geert+renesas@glider.be>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 13 Jul 2018 22:08:28 +0200
Message-ID: <CAMuHMdVdd1o51X-DwntSjxcMBjA30Unnorv4_A=5TXYFh6_n1w@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] regulator: bd9571mwv: Use "backup_mode" sysfs file
 instead of "wake_up"
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 6:31 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> Currently the BD9571MWV PMIC driver uses the standard "wake_up" sysfs
> file to control enablement of DDR Backup Mode.
>
> However, configuring DDR Backup Mode is not really equivalent to
> configuring the PMIC as a wake-up source.  To avoid confusion, use a
> custom "backup_mode" attribute file in sysfs instead.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v3:
>   - New.
> ---
>  drivers/regulator/bd9571mwv-regulator.c | 52 ++++++++++++++++++++++---
>  1 file changed, 46 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/regulator/bd9571mwv-regulator.c b/drivers/regulator/bd9571mwv-regulator.c
> index be574eb444ebda97..7432b605db4dc879 100644
> --- a/drivers/regulator/bd9571mwv-regulator.c
> +++ b/drivers/regulator/bd9571mwv-regulator.c

> @@ -270,15 +298,26 @@ static int bd9571mwv_regulator_probe(struct platform_device *pdev)
>                 return -EINVAL;
>         }
>
> +#ifdef CONFIG_PM_SLEEP
>         if (bdreg->bkup_mode_cnt_keepon) {
> -               device_set_wakeup_capable(&pdev->dev, true);
>                 /*
> -                * Wakeup is enabled by default in pulse mode, but needs
> +                * Backup mode is enabled by default in pulse mode, but needs
>                  * explicit user setup in level mode.
>                  */
> -               device_set_wakeup_enable(&pdev->dev, bdreg->rstbmode_pulse);
> +               bdreg->bkup_mode_enabled = bdreg->rstbmode_pulse;
> +
> +               ret = device_create_file(&pdev->dev, &dev_attr_backup_mode);
> +               if (ret)
> +                       return ret;
>         }
> +#endif /* CONFIG_PM_SLEEP */
> +
> +       return 0;
> +}
>
> +static int bd9571mwv_regulator_remove(struct platform_device *pdev)
> +{
> +       device_remove_file(&pdev->dev, &dev_attr_backup_mode);

Woops, this line needs to be protected by CONFIG_PM_SLEEP.
Thank you, 0-day!

>         return 0;
>  }
>
> @@ -294,6 +333,7 @@ static struct platform_driver bd9571mwv_regulator_driver = {
>                 .pm = DEV_PM_OPS,
>         },
>         .probe = bd9571mwv_regulator_probe,
> +       .remove = bd9571mwv_regulator_remove,
>         .id_table = bd9571mwv_regulator_id_table,
>  };
>  module_platform_driver(bd9571mwv_regulator_driver);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
