Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752534AbeESSAn (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 14:00:43 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:45036 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752414AbeESSAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 14:00:40 -0400
X-Google-Smtp-Source: AB8JxZqwkyeEfGiasMexYRt/RX1LRTZPZKzHYoIqBWboJsVrcMDcLj8czpBMe8oUp9/lkBuKAQhV6JWHbPvZSWsFuWc=
MIME-Version: 1.0
In-Reply-To: <3427199.r4OBoDP6Xz@z50>
References: <20180518210954.29044-1-jmkrzyszt@gmail.com> <20180518210954.29044-5-jmkrzyszt@gmail.com>
 <CAHp75VdNUW6KoM6oupyQ80A1WVRk7vewwDt6WEZOyjrAUifqRg@mail.gmail.com> <3427199.r4OBoDP6Xz@z50>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 19 May 2018 21:00:38 +0300
Message-ID: <CAHp75VcUxjubx=zOGyCjmpjCk5RBLPCaHcaOieDie9LdTCa+5g@mail.gmail.com>
Subject: Re: [PATCH 5/6] mtd: rawnand: ams-delta: use GPIO lookup table
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Mark Brown <broonie@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>,
        Richard Weinberger <richard@nod.at>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        linux-fbdev@vger.kernel.org,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 19, 2018 at 2:15 AM, Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> On Friday, May 18, 2018 11:21:14 PM CEST Andy Shevchenko wrote:
>> On Sat, May 19, 2018 at 12:09 AM, Janusz Krzysztofik
>>
>> <jmkrzyszt@gmail.com> wrote:
>> > +       gpiod_rdy = devm_gpiod_get_optional(&pdev->dev, "rdy", GPIOD_IN);
>> > +       if (!IS_ERR_OR_NULL(gpiod_rdy)) {
>>
>> So, is it optional or not at the end?
>> If it is, why do we check for NULL?
>
> As far as I can understand, nand_chip->dev_ready() callback is optional.
> That's why I decided to use the _optional variant of devm_gpiod_get(). In case
> of ams-delta, the dev_ready() callback depends on availability of the 'rdy'
> GPIO pin. As a consequence, I'm checking for both NULL and ERR in order to
> decide if dev_ready() will be supported.
>
> I can pretty well replace it with the standard form and check for ERR only if
> the purpose of the _optional form is different.

NULL check in practice discards the _optional part of gpiod_get(). So,
either you use non-optional variant and decide how to handle an
errors, or user _optional w/o NULL check.

>> > +err_gpiod:
>> > +       if (err == -ENODEV || err == -ENOENT)
>> > +               err = -EPROBE_DEFER;
>>
>> Hmm...
>
> Amstrad Delta uses gpio-mmio driver. Unfortunatelty that driver is not
> availble before device init phase, unlike other crucial GPIO drivers which are
> initialized earlier, e.g. during the postcore or at latetst the subsys phase.
> Hence, devices which depend on GPIO pins provided by gpio-mmio must either be
> declared late or fail softly so they get another chance of being probed
> succesfully.
>
> I thought of replacing the gpio-mmio platform driver with bgpio functions it
> exports but for now I haven't implemented it, not even shared the idea.
>
> Does it really hurt to return -EPROBE_DEFER if a GPIO pin can't be obtained?

I'm only concerned if it would be an infinite defer in the case when
driver will never appear.
But I don't remember the details.

-- 
With Best Regards,
Andy Shevchenko
