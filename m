Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388E0C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 15:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E54472086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 15:08:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E54472086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbeICT2e convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 15:28:34 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:46546 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeICT2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 15:28:33 -0400
Received: by mail-vk0-f67.google.com with SMTP id b14-v6so286939vke.13;
        Mon, 03 Sep 2018 08:07:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HPSp+Jn8jv1Vh1YsfpKRDgDd3bmQ8AAw73WdrmW3V5Y=;
        b=Qw633aw4HPgFKjGwOfuMZ59qefIUkj8fUb5wpiDPEpMSRM6IqqwtbY6KPrs0DZloKK
         GZwsA0CbxS/cpANq07YgSI4hFNNNbE7J63VNUtSBcV8GI50vOlzk6dcozzPAh09IsjNC
         nVKhs5AvfxZdbQFWnJiDPon/qa1/SFsi4p8MySryOtbEhs9KP3QqWJ2tImJqxKYoyDPd
         MgKNGK7pCoCkGrwq/hkjMlg6+RmXOuYWzC0gjdRCZHfhxf9YMAMk7+K8I140RtNMLlK/
         UMU/n2pO8+uw3wNskYN5E+XBqDvTEX9veXattmK+LA9woWHXNEbdULCIs7Mb8XLq4PKP
         8GFw==
X-Gm-Message-State: APzg51CR08Yx4i4jcUSYCUjxTxCuk8J7Mu63IRro/UpEzBNbrxniCv1s
        xpf2cs/xXg0R5nD/iwpluRQNFY3JUtcHp5tUCkQ=
X-Google-Smtp-Source: ANB0VdZwrSGUbocz+e7hD7Hi/+8Gop2gS+ScDfXzu9LH8WFlEKRoZCp+/SVu/E4taR+o9fvA7dzr606ru+QiMIPz2zQ=
X-Received: by 2002:a1f:6307:: with SMTP id x7-v6mr6412045vkb.111.1535987277086;
 Mon, 03 Sep 2018 08:07:57 -0700 (PDT)
MIME-Version: 1.0
References: <20180831225616.29221-1-jmkrzyszt@gmail.com> <20180902120144.6855-1-jmkrzyszt@gmail.com>
 <20180902120144.6855-2-jmkrzyszt@gmail.com>
In-Reply-To: <20180902120144.6855-2-jmkrzyszt@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 3 Sep 2018 17:07:44 +0200
Message-ID: <CAMuHMdXScsLg+LsQDn0dU8qSV30uWaeGQsNDPssm0H5y6UPAWw@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] gpiolib: Pass bitmaps, not integer arrays, to
 get/set array
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        sebastien.bourdelin@savoirfairelinux.com,
        Lukas Wunner <lukas@wunner.de>,
        Rojhalat Ibrahim <imr@rtschenk.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        ext Tony Lindgren <tony@atomide.com>,
        Yegor Yefremov <yegorslists@googlemail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Janusz,

On Sun, Sep 2, 2018 at 2:01 PM Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
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
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Peter Korsgaard <peter.korsgaard@barco.com>
> Cc: Peter Rosin <peda@axentia.se>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Rojhalat Ibrahim <imr@rtschenk.de>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: Russell King <rmk+kernel@armlinux.org.uk>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: Yegor Yefremov <yegorslists@googlemail.com>
> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

> --- a/drivers/auxdisplay/hd44780.c
> +++ b/drivers/auxdisplay/hd44780.c
> @@ -62,17 +62,12 @@ static void hd44780_strobe_gpio(struct hd44780 *hd)
>  /* write to an LCD panel register in 8 bit GPIO mode */
>  static void hd44780_write_gpio8(struct hd44780 *hd, u8 val, unsigned int rs)
>  {
> -       int values[10]; /* for DATA[0-7], RS, RW */
> -       unsigned int i, n;
> -
> -       for (i = 0; i < 8; i++)
> -               values[PIN_DATA0 + i] = !!(val & BIT(i));
> -       values[PIN_CTRL_RS] = rs;
> -       n = 9;
> -       if (hd->pins[PIN_CTRL_RW]) {
> -               values[PIN_CTRL_RW] = 0;
> -               n++;
> -       }
> +       DECLARE_BITMAP(values, 10); /* for DATA[0-7], RS, RW */
> +       unsigned int n;
> +
> +       *values = val;

Given DECLARE_BITMAP() creates an array, the above line looks a bit funny now.

IMHO, either you use

    unsigned long values;
    values = val;
    __assign_bit(8, &values, rs);

or

    DECLARE_BITMAP(values, 10);
    values[0] = val;
    __assign_bit(8, values, rs);

Nevertheless, for hd44780.c:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
