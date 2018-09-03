Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BDFC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF3D520868
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:24:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF3D520868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbeICSoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 14:44:54 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:33586 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbeICSoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 14:44:54 -0400
Received: by mail-ua1-f65.google.com with SMTP id i4-v6so562951uak.0;
        Mon, 03 Sep 2018 07:24:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ieJYxPIHnls2eLt2LBMcGhyRCnh9HRaFFFqYzIhSTtA=;
        b=AxXaxI1zazlA0wM2fmhmVJLnZyNdVPd+NqDqeZ4EQ3Z+o3eRZ+ex+Luo53F1unBZwl
         S/noQHcLLUW+fjakFixVGcGh8r0CsDXEBvP2B7Z95cWDoVX6IuDSjVFXuc6MbcD+EGvS
         4WWzKveZKAN8qUX3+hfqK6fO9Q3lnmg2S+pDYvkQ4x6ffi/Ut6CcKOKlz/eSQbis/U3H
         b5LKFppefROtNklGzi5+1p5UnQQ1PQwGlISr2dicIQGFwoo8iT82Zf6J6JG4Szg3tTJB
         3BEHiqa1HAAnt511ZmM7kf5WoVw0YhgBgaEPxHrsmrtvgeQWeJItOtE42ED8SDsHdbVb
         9vEw==
X-Gm-Message-State: APzg51DBEvuhJdT2DETdn76YjQMRyP21lGZwGXh3IFQTdXX6cPDjbohF
        XL/79XYca7psy3baIAUr+EjK1jm0ycvu362QrAg=
X-Google-Smtp-Source: ANB0VdYc0uFhudAZYRI11k3s/6tF2r21oi2twj7zlYx95Pv2IaBYCu0e5XLEGGOQ+tFpIfbxNuTUJQcymqKAVxC/OSo=
X-Received: by 2002:ab0:72ca:: with SMTP id g10-v6mr15954675uap.33.1535984668854;
 Mon, 03 Sep 2018 07:24:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180831225616.29221-1-jmkrzyszt@gmail.com> <20180902120144.6855-1-jmkrzyszt@gmail.com>
 <20180902120144.6855-2-jmkrzyszt@gmail.com> <20180903043129.GA17856@bombadil.infradead.org>
In-Reply-To: <20180903043129.GA17856@bombadil.infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 3 Sep 2018 16:24:16 +0200
Message-ID: <CAMuHMdXU394+E3Z3tR-6iRSiWVDWUpxPLZdxg8zdgWxW5+SOOg@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] gpiolib: Pass bitmaps, not integer arrays, to
 get/set array
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
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
        <u.kleine-koenig@pengutronix.de>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 3, 2018 at 6:31 AM Matthew Wilcox <willy@infradead.org> wrote:
> > +++ b/drivers/auxdisplay/hd44780.c
> > @@ -62,17 +62,12 @@ static void hd44780_strobe_gpio(struct hd44780 *hd)
> >  /* write to an LCD panel register in 8 bit GPIO mode */
> >  static void hd44780_write_gpio8(struct hd44780 *hd, u8 val, unsigned int rs)
> >  {
> > -     int values[10]; /* for DATA[0-7], RS, RW */
> > -     unsigned int i, n;
> > -
> > -     for (i = 0; i < 8; i++)
> > -             values[PIN_DATA0 + i] = !!(val & BIT(i));
> > -     values[PIN_CTRL_RS] = rs;
> > -     n = 9;
> > -     if (hd->pins[PIN_CTRL_RW]) {
> > -             values[PIN_CTRL_RW] = 0;
> > -             n++;
> > -     }
> > +     DECLARE_BITMAP(values, 10); /* for DATA[0-7], RS, RW */
> > +     unsigned int n;
> > +
> > +     *values = val;
> > +     __assign_bit(8, values, rs);
> > +     n = hd->pins[PIN_CTRL_RW] ? 10 : 9;
>
> Doesn't this assume little endian bitmaps?  Has anyone tested this on
> big-endian machines?

include/linux/bitops.h:

static __always_inline void __assign_bit(long nr, volatile unsigned long *addr,
                                         bool value)
{
        if (value)
                __set_bit(nr, addr);
        else
                __clear_bit(nr, addr);
}

include/asm-generic/bitops/non-atomic.h:

static inline void __set_bit(int nr, volatile unsigned long *addr)
{
        unsigned long mask = BIT_MASK(nr);
        unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);

        *p  |= mask;
}

include/linux/bits.h:

#define BIT_MASK(nr)            (1UL << ((nr) % BITS_PER_LONG))

Looks like native endianness to me.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
