Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C905DC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 757692075E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:21:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 757692075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbeICSmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 14:42:11 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:39715 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbeICSmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 14:42:10 -0400
Received: by mail-ua1-f67.google.com with SMTP id g18-v6so537762uam.6;
        Mon, 03 Sep 2018 07:21:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=puTAeydjxn5dvYiCYLIwqdqVR43ON5sBctrZUAuiI9Y=;
        b=UN3JaEKmk5rFHHth+j+KTXv7UcjfT2dVMsfvdmFPRlV5Q8vGdWk3BaWFkBCSGfmz5n
         fATwj1ygFP6/UHsLKqfesGm/S9bZfbWpxrW7ukicDcX8hpndWi/+t0U1dwKlIMvRN8rm
         URgpbBwnpE/3J6tjL9Yd1p8/PrFB2CtMmMGitzRrBfPWTGMxUNAPIYTvMbiueYGWBop0
         1JwQsyiuVdfF4b3t1dVPQmqmGbU4Qg60cauGES8h0w+mK/sCJpn6UhUiMaqtGNI4ZeOl
         ULxwdLimrlkiyKYqT2O1geRVla8dhfFw28i5ec4c4cgm31kLYOQodaWyecuKl0hy2+3O
         nJUg==
X-Gm-Message-State: APzg51ApCOrlQbl/f3+ilCgLDVmJwo8QJcQ/BLOz6ING1x6nmyRmo4Mt
        Vm9marK9KBBRkXn5oS2/1XyASLXt5Gvi+TjnDaQ=
X-Google-Smtp-Source: ANB0Vdb+4l/ufaXNKqkIWmmE2MwSIHB1LGSwWm/WaiQl6ADJw4OJiXQvj+JFFcNaSc/lZSe7kncLbY+qmqNff5YxmdM=
X-Received: by 2002:a67:6908:: with SMTP id e8-v6mr8749136vsc.21.1535984505642;
 Mon, 03 Sep 2018 07:21:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180831225616.29221-1-jmkrzyszt@gmail.com> <20180902120144.6855-1-jmkrzyszt@gmail.com>
 <20180902120144.6855-4-jmkrzyszt@gmail.com>
In-Reply-To: <20180902120144.6855-4-jmkrzyszt@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 3 Sep 2018 16:21:33 +0200
Message-ID: <CAMuHMdV66N_YAvvZjk7kEf_aLNNFo6HA8S4JjzkM2d3QC-ZS5A@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] gpiolib: Pass array info to get/set array functions
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 2, 2018 at 2:01 PM Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> In order to make use of array info obtained from gpiod_get_array() and
> speed up processing of arrays matching single GPIO chip layout, that
> information must be passed to get/set array functions.  Extend the
> functions' API with that additional parameter and update all users.
> Pass NULL if a user bulids an array itself from single GPIOs.

builds

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
