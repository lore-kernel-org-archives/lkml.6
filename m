Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0031C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 11:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92EE42148E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 11:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbeLZLjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 06:39:31 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:36356 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbeLZLjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 06:39:31 -0500
Received: by mail-ua1-f68.google.com with SMTP id j3so5021112uap.3;
        Wed, 26 Dec 2018 03:39:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K8uHQBK+p8bWU3jeZO+0SoK4bhEO6ltE34jcIg+t5uo=;
        b=WuDf89GR2wJXiJJwpmtdF7vCbVk0A6uC5BlyJfIMF8D8mN1LePsVAxC7TN+aFUWb0a
         SOV5MpqNRnL6vV7zg/ycjoG9fxgWzUKE3qZCl9eqkaOO56WP4eriz2YvWmfk/ZajV0lh
         caid5TYn6yxjiMmhgjRNGaLmm7y6j3sAEleQpXkuJTLm4jxlp3fM2eW9SkEeV6dcoMGF
         N6OqsmBIFj2oyDCc0TwW/XKDh7x8M3ECPYX4U3IZxtuo3/vrYKeY9NPclabFwGLRB5Ed
         /WUVlkWaOHnnd1KOdWkHnNT9vRh60JFcN+fqkisqM+EaXn051LvHTUd3PSqc43V3Z57E
         iOIw==
X-Gm-Message-State: AJcUukfoSEnHdfpRuNPJfAYfhrrtdSTf9OX+y2iKKUdwP+uqak3BQ46g
        BIN9YfAvMHEr3vmD3I0Mmqgxtp0x8Ir8tDMWVRY=
X-Google-Smtp-Source: ALg8bN6da+emb0AX8yQqL0KJl8G9h8gRNDz/pB+stWFNT7wXe5k9x4ri+lnIdbVAjTEb7L+UCKZq4EslouklsoXDypI=
X-Received: by 2002:ab0:216:: with SMTP id 22mr7339580uas.28.1545824369729;
 Wed, 26 Dec 2018 03:39:29 -0800 (PST)
MIME-Version: 1.0
References: <20181218115931.GA21253@localhost.localdomain>
In-Reply-To: <20181218115931.GA21253@localhost.localdomain>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 26 Dec 2018 12:39:17 +0100
Message-ID: <CAMuHMdUbXeuemACL+GGx0HFjn2oKUb2UbDUKJedzCrm8JDfNaA@mail.gmail.com>
Subject: Re: [PATCH v3] regmap: regmap-irq/gpio-max77620: add level-irq support
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, heikki.haikola@fi.rohmeurope.com,
        mikko.mutanen@fi.rohmeurope.com, Mark Brown <broonie@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matti,

On Tue, Dec 18, 2018 at 1:00 PM Matti Vaittinen
<matti.vaittinen@fi.rohmeurope.com> wrote:
> Add level active IRQ support to regmap-irq irqchip. Change breaks
> existing regmap-irq type setting. Convert the existing drivers which

Indeed it does.

> use regmap-irq with trigger type setting (gpio-max77620) to work
> with this new approach. So we do not magically support level-active
> IRQs on gpio-max77620 - but add support to the regmap-irq for chips
> which support them =)
>
> We do not support distinguishing situation where HW supports rising
> and falling edge detection but not both. Separating this would require
> inventing yet another flags for IRQ types.
>
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

This is now upstream as commit 1c2928e3e3212252 ("regmap:
regmap-irq/gpio-max77620: add level-irq support"), and breaks da9063-rtc
on the Renesas Koelsch board:

    genirq: Setting trigger mode 8 for irq 157 failed
(regmap_irq_set_type+0x0/0x140)
    da9063-rtc da9063-rtc: Failed to request ALARM IRQ 157: -524
    da9063-rtc: probe of da9063-rtc failed with error -524

> ---
>
> Version 3 of this patch is intended to be functionally identical to v2.
> This patch is rebased on top of a tree which contains changes:
> "regmap: irq: handle HW using separate rising/falling edge interrupts"
> from Bartosz Golaszewski and the change
> "regmap: regmap-irq: Remove default irq type setting from core"
> (proposed here):
> https://lore.kernel.org/lkml/20181218105813.GA6957@localhost.localdomain/
>
> There should not be direct dependency to "regmap: regmap-irq: Remove
> default irq type setting from core" though. Patch was also tested to
> apply cleany on regmap-tree.
>
> Same statement regarding testing applies - gpio-max77620 are only
> tested to compile. All real testing would be _HIGHLY_ appreciated.
>
>  drivers/base/regmap/regmap-irq.c | 35 ++++++++++-----
>  drivers/gpio/gpio-max77620.c     | 96 ++++++++++++++++++++++++++--------------
>  include/linux/regmap.h           | 27 ++++++++---
>  3 files changed, 110 insertions(+), 48 deletions(-)
>
> diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
> index 8b216b2e2c19..31d23c9a5ae7 100644
> --- a/drivers/base/regmap/regmap-irq.c
> +++ b/drivers/base/regmap/regmap-irq.c
> @@ -199,7 +199,7 @@ static void regmap_irq_enable(struct irq_data *data)
>         const struct regmap_irq *irq_data = irq_to_regmap_irq(d, data->hwirq);
>         unsigned int mask, type;
>
> -       type = irq_data->type_falling_mask | irq_data->type_rising_mask;
> +       type = irq_data->type.type_falling_val | irq_data->type.type_rising_val;
>
>         /*
>          * The type_in_mask flag means that the underlying hardware uses
> @@ -234,27 +234,42 @@ static int regmap_irq_set_type(struct irq_data *data, unsigned int type)
>         struct regmap_irq_chip_data *d = irq_data_get_irq_chip_data(data);
>         struct regmap *map = d->map;
>         const struct regmap_irq *irq_data = irq_to_regmap_irq(d, data->hwirq);
> -       int reg = irq_data->type_reg_offset / map->reg_stride;
> +       int reg;
> +       const struct regmap_irq_type *t = &irq_data->type;
>
> -       if (!(irq_data->type_rising_mask | irq_data->type_falling_mask))
> -               return 0;
> +       if ((t->types_supported & type) != type)
> +               return -ENOTSUPP;

Given types_supported defaults to zero, I think this breaks every existing
setup using REGMAP_IRQ_REG().

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
