Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22907C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 11:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7651218A1
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 11:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbeL2LNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 06:13:46 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:44097 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbeL2LNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 06:13:46 -0500
Received: by mail-vs1-f65.google.com with SMTP id z23so11055435vsj.11
        for <linux-kernel@vger.kernel.org>; Sat, 29 Dec 2018 03:13:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SsdMP4tMaKgMronza7Qf/UgE2j2tDASazSY4oBtkHi4=;
        b=lakcea09az1fkyfgLqXwHgsMtY0H/K4Yr0tqFyK4Q0K1sGDBlndbdVLId5OHQhjMFi
         88HnL8itiLN6++RqOgdDgfb4jLJW5ta8obsAC6JnGJ+axLNvY491RfCOO05b6ilaI5Ra
         Rs2jOFyQ3rE0rj1cSZxgL7mzr1PSxxXeXsDfthvGq7H6yDxEebmYlmEzFbh83zG3mmIy
         Pismy9Zy5gDcnfR2MUQIu1+8cK35mRas5c5i48MWeOffEm4NwX1ldh/7A1Ko93xTQ+1s
         UKam0rZ49/LMBIEFXvxQQ8WR9gcDpaSGwujX3JmskHRP1UCvbjnWY2Btv1+He3AZ5D1z
         UVHg==
X-Gm-Message-State: AA+aEWai5vxPyP39zOG6Tj+923eKDIDjSArGJvlBdm32a31hVDpfO1lo
        zaIfWs8T0kTTYuVA2Q8C6dioQ/9wyr8eLAHGl00=
X-Google-Smtp-Source: ALg8bN6HvEA/Qn+/Ds9z7BVvNn+shuJtJer74xxW7C8VjIesOmDBIHSiarTAdc34Y2X8uVaHEftocPYxWlUsE4Xt5Rw=
X-Received: by 2002:a67:d119:: with SMTP id u25mr11764990vsi.63.1546082024833;
 Sat, 29 Dec 2018 03:13:44 -0800 (PST)
MIME-Version: 1.0
References: <20181227084443.GA23991@localhost.localdomain>
In-Reply-To: <20181227084443.GA23991@localhost.localdomain>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 29 Dec 2018 12:13:32 +0100
Message-ID: <CAMuHMdUg=C+pNrbauM-f7LchXRnwu1ufYyUSp=jO+8hs_SrgXQ@mail.gmail.com>
Subject: Re: [PATCH] regmap: regmap-irq: silently ignore unsupported type settings
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, Mark Brown <broonie@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matti,

On Thu, Dec 27, 2018 at 9:44 AM Matti Vaittinen
<matti.vaittinen@fi.rohmeurope.com> wrote:
> Do not return error if irq-type setting is requested for
> controlloer which does not support this. This is how
> regmap-irq has previously handled the undupported type
> settings and existing drivers seem to be upset if failure
> is now reported.
>
> Fixes: 1c2928e3e321 ("regmap: regmap-irq/gpio-max77620: add level-irq support")
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>

> ---
>
> Geert reported that 1c2928e3e321 breaks da9063-rtc on the Renesas
> Koelsch board:
>
> https://lore.kernel.org/lkml/20181227075648.GB2461@localhost.localdomain/T/#m194616cc88d7b4c2a78f7ce07907608fdb64a092
>
> Geert, do you know if anyone vould to test this?

Thanks, that seems to fix the issue with da9063-rtc.

I don't know how to trigger an actual interrupt, though.

> --- a/drivers/base/regmap/regmap-irq.c
> +++ b/drivers/base/regmap/regmap-irq.c
> @@ -258,7 +258,7 @@ static int regmap_irq_set_type(struct irq_data *data, unsigned int type)
>         const struct regmap_irq_type *t = &irq_data->type;
>
>         if ((t->types_supported & type) != type)
> -               return -ENOTSUPP;
> +               return 0;
>
>         reg = t->type_reg_offset / map->reg_stride;
>
> --
> 2.14.3

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
