Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0E3ECE562
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 10:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD26E214C1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 10:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVurwvMq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD26E214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbeIWQtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 12:49:18 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36792 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbeIWQtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 12:49:18 -0400
Received: by mail-lj1-f196.google.com with SMTP id v26-v6so15722980ljj.3;
        Sun, 23 Sep 2018 03:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K0GH2NVxQkTSkS8u1BEKMC2mAlJe+QorxWmVBJLGL2Y=;
        b=RVurwvMqZGuudiwFPI8sJYI8cFsAAvMAGhmv73Pl1OUSC4vjfwJ04Ph9Ds/dTVAAfB
         kzfoKzVga4rXuhTKG1KVboaa0ruMy4m6kZIgN6vgRUB0+CegSX18O+7hwsF/juyqVBEv
         piIivj0E5jgH33+Xv4lfao14AKyMMhdUoqn01o3UKBZ0xWMb33//a7MVhKiIr7SYzHSQ
         bCKrL3LZK0RztzmsxWBgQ5q/Z3lbLyfyIn2o0thk1iJ5XWzVVcYSKq8NDjrtpxtfjZXu
         5CubHYwvJ5XWeo64XdNGxbJ3xST+73PPnhrdUkQdFmXRU5nInNglJL1iLtrEPjGjUJWk
         rb+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K0GH2NVxQkTSkS8u1BEKMC2mAlJe+QorxWmVBJLGL2Y=;
        b=BSgtuBZJFmfs5fMlzyExkfgiGx12LH5yV3batD3xlBqH6pSZ0n+XGAKnRypWy9Y4Lf
         sW0yGkz0E0e5vdRpqsHB/L2DfvHu2V75sYCkYTUHTk1k9SOhOqNnjItfHkpyFY2ddvDp
         h8CV6nHYKQAiv1X9CseA77Mu5NiiUf2z0pi2D4LqCuw3P2bTUkCt4JVw8qkEhbrbRWrH
         nCogUSUJJFyAdYquDUrWqB4rwkGUJ7TZp7d9NO9HYF9tvz1BWwCYyRQclXNSo6AGm9rR
         bXhsMBXn+kTpddQ2PmffqCTjb2aZRefR2Me6wPvZmpThPY7BPC8Bl5hwPGnJGui1bpNi
         7GHw==
X-Gm-Message-State: APzg51CsdSdA/AYW8AfZyMpL2ZNmd85bDIlHkZJdJkAWM6UrhuZupbrr
        tCrElEQiFpsVSTR+RvJfv94=
X-Google-Smtp-Source: ACcGV61dFpRY7noihlPMeJWVVMQOXO1A5YIFfLZ8rYINs5Hh7wR1OTizICHcoDH1NJ1lmXyWXQfeJQ==
X-Received: by 2002:a2e:8513:: with SMTP id j19-v6mr7454235lji.10.1537699929521;
        Sun, 23 Sep 2018 03:52:09 -0700 (PDT)
Received: from z50.localnet (apn-31-0-38-37.dynamic.gprs.plus.pl. [31.0.38.37])
        by smtp.gmail.com with ESMTPSA id t200-v6sm61182lff.77.2018.09.23.03.52.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Sep 2018 03:52:08 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Rosin <peda@axentia.se>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jiri Slaby <jslaby@suse.com>, Willy Tarreau <w@1wt.eu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Rojhalat Ibrahim <imr@rtschenk.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Tony Lindgren <tony@atomide.com>,
        Yegor Yefremov <yegorslists@googlemail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: Re: [PATCH v7 4/4] gpiolib: Implement fast processing path in get/set array
Date:   Sun, 23 Sep 2018 12:43:53 +0200
Message-ID: <2785169.v6aIfS3K2k@z50>
In-Reply-To: <20180921141409eucas1p190a47e2608429870d23516ee5e75c191~Wb8z_FmwI1466414664eucas1p1F@eucas1p1.samsung.com>
References: <20180831225616.29221-1-jmkrzyszt@gmail.com> <CAGfqbt7xJxGbq3oOJp9S0Sg7Z9=T6Dy52MDNWSDdsU==kPt1KQ@mail.gmail.com> <20180921141409eucas1p190a47e2608429870d23516ee5e75c191~Wb8z_FmwI1466414664eucas1p1F@eucas1p1.samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, September 21, 2018 4:14:06 PM CEST Marek Szyprowski wrote:
> Hi Janusz,
> 
> 
> On 2018-09-21 12:51, Janusz Krzysztofik wrote:
> > 2018-09-21 10:18 GMT+02:00, Marek Szyprowski <m.szyprowski@samsung.com>:
> >> On 2018-09-20 18:21, Janusz Krzysztofik wrote:
> >>> On Thursday, September 20, 2018 5:48:22 PM CEST Janusz Krzysztofik wrote:
> >>>> On Thursday, September 20, 2018 12:11:48 PM CEST Marek Szyprowski 
wrote:
> >>>>> On 2018-09-02 14:01, Janusz Krzysztofik wrote:
> >>>>>> Certain GPIO descriptor arrays returned by gpio_get_array() may
> >>>>>> contain
> >>>>>> information on direct mapping of array members to pins of a single
> >>>>>> GPIO
> >>>>>> chip in hardware order.  In such cases, bitmaps of values can be
> >>>>>> passed
> >>>>>> directly from/to the chip's .get/set_multiple() callbacks without
> >>>>>> wasting time on iterations.
> >>>>>>
> >>>>>> Add respective code to gpiod_get/set_array_bitmap_complex() 
functions.
> >>>>>> Pins not applicable for fast path are processed as before, skipping
> >>>>>> over the 'fast' ones.
> >>>>>>
> >>>>>> Cc: Jonathan Corbet <corbet@lwn.net>
> >>>>>> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> >>>>> I've just noticed that this patch landed in today's linux-next. Sadly
> >>>>> it
> >>>>> breaks booting of Exynos5250-based Samsung Snow Chromebook (ARM 32bit,
> >>>>> device-tree source arch/arm/boot/dts/exynos5250-snow.dts).
> >>>>>
> >>>>> Booting hangs after detecting MMC cards. Reverting this patch fixes the
> >>>>> boot. I will try later to add some debugs and investigate it further
> >>>>> what
> >>>>> really happens when booting hangs.
> >>>> Hi Marek,
> >>>>
> >>>> Thanks for reporting. Could you please try the following fix?
> >>> Hi again,
> >>>
> >>> I realized the patch was not correct, j, not i, should be updated in
> >>> second
> >>> hunk. Please try the following one.
> >>>
> >>> Thanks,
> >>> Janusz
> >>>
> >>> >From a919c504850f6cb40e8e81267a3a37537f7c4fd4 Mon Sep 17 00:00:00 2001
> >>> From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> >>> Date: Thu, 20 Sep 2018 17:37:21 +0200
> >>> Subject: [PATCH] gpiolib: Fix bitmap index not updated
> >>> While skipping fast path bits, bitmap index is not updated with next
> >>> found zero bit position. Fix it.
> >>>
> >>> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> >> This one also doesn't help. A quick compare of logs with this version and
> >> a working system shows, that with your patch (and fix) there are no calls
> >> to
> >> gpx0-2 pin (which are a part of mmc pwrseq), what causes mmc failure. If
> >> you need any more information (what kind of logs will help?), let me 
know.
> > There is a debug message on array_info content available at the end of
> > gpiod_get_array(), could you please activate it and post the message so
> > we can understand better what is going on?
> 
> With debug enabled on next-20180919:
> [    2.499153] pwrseq_simple mmc3_pwrseq: GPIO array info: chip=gpx0, 
> size=2, get_mask=2, set_mask=2, invert_mask=2

Looks good to me, i..e., in line with what one could expect.  However, ...

> On next-20180920 I get no this message and booting hangs.
> 
> Same with next-20180920 + your second fix from this thread.
> 
> I will try to debug this more on Monday.
> 
> > On the other hand, I've had a look your device-tree configuration and
> > it looks like that specific setup won't benefit from the fast bitmap path.
> > You have pin 2 at position 0 and pin 1 at position 1 of the array.
> > Hence, the fast bitmap path covers only pin 1, and pin 2 is processed
> > by the old path with apparently buggy code for skipping over fast pins.
> >
> > As a temporary workaround, you could try to revert the order of pins in
> > your dts file (pin 1 at position 0, pin 2 at 1) and the mmc pwrseq code
> > should work for you again by taking the original old path, not skipping
> > over fast pins.  Results of such check may also help us to better
> > understand and resolve the issue.
> 
> Changing the order of mmc pwrseq gpio pins fixes boot hang.

Not being able to discover more coding bugs in the code modified by the series, 
I'm wondering if the reason for the issue you are observing comes from the 
fact both pins are no longer manipulated together within a single 
.set_multiple() chip callback. I'm working on a fix which prevents from that.

Thanks,
Janusz


