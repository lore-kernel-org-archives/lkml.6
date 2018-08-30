Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A86C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 07:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45D452082C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 07:41:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45D452082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbeH3Llv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 07:41:51 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:42271 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727098AbeH3Llv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 07:41:51 -0400
Received: by mail-vk0-f66.google.com with SMTP id t4-v6so3816062vke.9;
        Thu, 30 Aug 2018 00:41:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=efCK0MvyuRJeCqIEWKlmp0CxxDPL4uAwuhnr8YddIWA=;
        b=VdN2LHmz1eHIQ2wMo15P4+T5pr0T+a7pACAUMhDcbiKAovE/YJJa4Wh1+vyI9uKdSH
         MUgVz9NDB6jFO8W9wUTWeBaXnc24vudtHTU8QTr/d8Dsq84lgVsNu0c2oCi39LSOMyfE
         LiFKt8HkMiacFL1qp+0k07E7/S8GyyvtAGu5TKe33mCvDL3fPtLhn6Z9vEFoPBcZrYYS
         cWFHMnBmPEEcJWUNRetXNF/KPNPoIvdm0Vv4ZWeP/B5j9we+SMEcpnpzsJcSmmpLwPio
         vVO/XUJwO2GsUas1jLfAW1slUQWQzouKmJuy9BEoPDa/kL0nrvy6HRIoW/Mh6FsosdX4
         4emQ==
X-Gm-Message-State: APzg51A4m3yY5O6+VYPN/T2Z3EaY0QoD3GJMsF94Q7MPm8b+xByRwMAu
        ygMgZ9nqGbiQbaqgQ6179diIi2uesepck5AsKw4=
X-Google-Smtp-Source: ANB0VdbqzuGkF3OMAHDQYNQk10DVx7Y6wOHT2BSzGxYYc7yIkD+KjvN9fD7h4a4CqBHy5y9QwsnioXbaa0ou73oRCkA=
X-Received: by 2002:a1f:9004:: with SMTP id s4-v6mr6090841vkd.10.1535614860657;
 Thu, 30 Aug 2018 00:41:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180820234341.5271-1-jmkrzyszt@gmail.com> <20180829204900.19390-1-jmkrzyszt@gmail.com>
 <20180829204900.19390-2-jmkrzyszt@gmail.com>
In-Reply-To: <20180829204900.19390-2-jmkrzyszt@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 30 Aug 2018 09:40:47 +0200
Message-ID: <CAMuHMdW4QHuab8xuqNxc-yg_RiH0+Pb4yJryarDq6bgjtGvWsQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] gpiolib: Pass bitmaps, not integer arrays, to
 get/set array
To:     jmkrzyszt@gmail.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        peter.korsgaard@barco.com, Peter Rosin <peda@axentia.se>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Jiri Slaby <jslaby@suse.com>, Willy Tarreau <w@1wt.eu>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, linux-iio@vger.kernel.org,
        driverdevel <devel@driverdev.osuosl.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Janusz,

On Wed, Aug 29, 2018 at 10:48 PM Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> Most users of get/set array functions iterate consecutive bits of data,
> usually a single integer, while processing array of results obtained
> from, or building an array of values to be passed to those functions.
> Save time wasted on those iterations by changing the functions' API to
> accept bitmaps.
>
> All current users are updated as well.
>
> More benefits from the change are expected as soon as planned support
> for accepting/passing those bitmaps directly from/to respective GPIO
> chip callbacks if applicable is implemented.
>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
> Cc: Peter Korsgaard <peter.korsgaard@barco.com>
> Cc: Peter Rosin <peda@axentia.se>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks for your patch!

> --- a/drivers/auxdisplay/hd44780.c
> +++ b/drivers/auxdisplay/hd44780.c
> @@ -62,20 +62,19 @@ static void hd44780_strobe_gpio(struct hd44780 *hd)
>  /* write to an LCD panel register in 8 bit GPIO mode */
>  static void hd44780_write_gpio8(struct hd44780 *hd, u8 val, unsigned int rs)
>  {
> -       int values[10]; /* for DATA[0-7], RS, RW */
> -       unsigned int i, n;
> +       unsigned long value_bitmap[1];  /* for DATA[0-7], RS, RW */
> +       unsigned int n;
>
> -       for (i = 0; i < 8; i++)
> -               values[PIN_DATA0 + i] = !!(val & BIT(i));
> -       values[PIN_CTRL_RS] = rs;
> +       value_bitmap[0] = val;
> +       __assign_bit(PIN_CTRL_RS, value_bitmap, rs);


>         n = 9;
>         if (hd->pins[PIN_CTRL_RW]) {
> -               values[PIN_CTRL_RW] = 0;
> +               __clear_bit(PIN_CTRL_RW, value_bitmap);

The clearing is not needed, as this has been done by 'value_bitmap[0] = val;'

>                 n++;
>         }

So the above block can be simplified to:

        n = hd->pins[PIN_CTRL_RW] ? 10 : 9;

>
>         /* Present the data to the port */
> -       gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA0], values);
> +       gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA0], value_bitmap);
>
>         hd44780_strobe_gpio(hd);
>  }
> @@ -83,32 +82,31 @@ static void hd44780_write_gpio8(struct hd44780 *hd, u8 val, unsigned int rs)
>  /* write to an LCD panel register in 4 bit GPIO mode */
>  static void hd44780_write_gpio4(struct hd44780 *hd, u8 val, unsigned int rs)
>  {
> -       int values[10]; /* for DATA[0-7], RS, RW, but DATA[0-3] is unused */
> -       unsigned int i, n;
> +       /* for DATA[0-7], RS, RW, but DATA[0-3] is unused */

This comment is not correct, as the low bits will be used.

        /* DATA[4-7], RS, RW */

> +       unsigned long value_bitmap[1];
> +       unsigned int n;
>
>         /* High nibble + RS, RW */
> -       for (i = 4; i < 8; i++)
> -               values[PIN_DATA0 + i] = !!(val & BIT(i));
> -       values[PIN_CTRL_RS] = rs;
> +       value_bitmap[0] = val;
> +       __assign_bit(PIN_CTRL_RS, value_bitmap, rs);
>         n = 5;
>         if (hd->pins[PIN_CTRL_RW]) {
> -               values[PIN_CTRL_RW] = 0;
> +               __clear_bit(PIN_CTRL_RW, value_bitmap);

Not needed.

>                 n++;
>         }

Hence:

        n = hd->pins[PIN_CTRL_RW] ? 6: 5;

> +       value_bitmap[0] >>= PIN_DATA4;

Yuck?!?

Isn't it more readable to just do:

        /* High nibble + RS, RW */
        value_bitmap[0] = val >> 4;
        __assign_bit(4, value_bitmap, rs);
        n = hd->pins[PIN_CTRL_RW] ? 6: 5;

>
>         /* Present the data to the port */
> -       gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4],
> -                                      &values[PIN_DATA4]);
> +       gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4], value_bitmap);
>
>         hd44780_strobe_gpio(hd);
>
>         /* Low nibble */
> -       for (i = 0; i < 4; i++)
> -               values[PIN_DATA4 + i] = !!(val & BIT(i));
> +       value_bitmap[0] &= ~((1 << PIN_DATA4) - 1);
> +       value_bitmap[0] |= val & ~((1 << PIN_DATA4) - 1);

... and:

         /* Low nibble */
        value_bitmap[0] &= ~0x0f;
        value_bitmap[0] |= val & 0x0f;

>
>         /* Present the data to the port */
> -       gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4],
> -                                      &values[PIN_DATA4]);
> +       gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4], value_bitmap);
>
>         hd44780_strobe_gpio(hd);
>  }
> @@ -155,23 +153,23 @@ static void hd44780_write_cmd_gpio4(struct charlcd *lcd, int cmd)
>  /* Send 4-bits of a command to the LCD panel in raw 4 bit GPIO mode */
>  static void hd44780_write_cmd_raw_gpio4(struct charlcd *lcd, int cmd)
>  {
> -       int values[10]; /* for DATA[0-7], RS, RW, but DATA[0-3] is unused */
> +       /* for DATA[0-7], RS, RW, but DATA[0-3] is unused */

This comment is not correct, as the low bits will be used.

        /* DATA[4-7], RS, RW */

> +       unsigned long value_bitmap[1];
>         struct hd44780 *hd = lcd->drvdata;
> -       unsigned int i, n;
> +       unsigned int n;
>
>         /* Command nibble + RS, RW */
> -       for (i = 0; i < 4; i++)
> -               values[PIN_DATA4 + i] = !!(cmd & BIT(i));
> -       values[PIN_CTRL_RS] = 0;
> +       value_bitmap[0] = cmd << PIN_DATA4;
> +       __clear_bit(PIN_CTRL_RS, value_bitmap);

Implied by the assignment above.

>         n = 5;
>         if (hd->pins[PIN_CTRL_RW]) {
> -               values[PIN_CTRL_RW] = 0;
> +               __clear_bit(PIN_CTRL_RW, value_bitmap);
>                 n++;
>         }
> +       value_bitmap[0] = value_bitmap[0] >> PIN_DATA4;

Hence:

        /* Command nibble + RS, RW */
        value_bitmap[0] = cmd;
        n = hd->pins[PIN_CTRL_RW] ? 6: 5;


>
>         /* Present the data to the port */
> -       gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4],
> -                                      &values[PIN_DATA4]);
> +       gpiod_set_array_value_cansleep(n, &hd->pins[PIN_DATA4], value_bitmap);
>
>         hd44780_strobe_gpio(hd);
>  }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
