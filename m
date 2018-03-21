Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751811AbeCUICX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 04:02:23 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:44937 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751715AbeCUICT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 04:02:19 -0400
X-Google-Smtp-Source: AG47ELudYvIO6DGi2CrVeitSplb8hc5nscJOgFrq+3XUEVd77GDwjqSBkyLa9+Jb5qWJRw50HTPJRjY/imis4Y/xcFA=
MIME-Version: 1.0
In-Reply-To: <20180320215615.zszlfw5pnecfqhpt@pengutronix.de>
References: <20171019131003.9684-1-gregory.clement@free-electrons.com>
 <CACRpkdbqjh5U5QoE_B+7GfSyDdHW-NCAvogGq-2n8j6L6nG-Gw@mail.gmail.com>
 <20171031131617.GA11647@lunn.ch> <20180320215615.zszlfw5pnecfqhpt@pengutronix.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 21 Mar 2018 09:02:17 +0100
Message-ID: <CACRpkdaAytp4veUYSYaJ8GB7+1EMbTFz2NMNv4GQrLhiWH8g3A@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: armada-37xx: Add edge both type gpio irq support
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Jason Cooper <jason@lakedaemon.net>, Hua Jing <jinghua@marvell.com>,
        Ken Ma <make@marvell.com>,
        Antoine Tenart <antoine.tenart@free-electrons.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nadav Haklai <nadavh@marvell.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Victor Gu <xigu@marvell.com>, Neta Zur Hershkovits <neta@marvell.com>,
        =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@free-electrons.com>,
        Gregory CLEMENT <gregory.clement@free-electrons.com>,
        Marcin Wojtas <mw@semihalf.com>, Wilson Ding <dingwei@marvell.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2L82VTt020249

On Tue, Mar 20, 2018 at 10:56 PM, Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:

> Maybe I'm wrong, but I wonder if there could be a set of helper
> functions provided by the gpio core that helps implementing this
> software simulation of IRQ_TYPE_EDGE_BOTH reliably (i.e. as good as
> possible in software) to prevent common mistakes.
>
> First draft:
>
>                 disable_irq_nosync(...);
>                 level = gpio_get(...);
>         retry:
>                 if (level)
>                         configure_for_falling_edge();
>                 else
>                         configure_for_raising_edge();
>                 postlevel = gpio_get(...);
>
>                 if (level != postlevel) {
>                         mark_irq_pending(); /* something like desc->istate |= IRQS_PENDING */
>                         level = postlevel;
>                         goto retry;
>                 }
>
>                 enable_irq(...); /* this resends the irq */
>
> I think this only looses an event if there is an edge between gpio_get
> and the configure_for_${some}_edge and another before postlevel = ...
> that make the two events invisible. But I think this is okish, as a
> short spike might also be missed by a hw-edge-detector. And compared to
> the current code there should be no way to end in a state where we
> configured for raising edge and the level is already high.

This is looking good compared to the solutions people have hacked up.

> When the gpio toggles quickly this might keep the cpu busy in an endless
> loop, but such a sequence would also block a controller that can trigger
> on both edges in hardware. Not sure if breaking the loop at some point
> is sensible anyhow. Also calling the irq handlers would be beneficial,
> but I don't know if/how this works without (more) racing.

What would make sense (if you want a perfect solution) is to enforce
some reasonable debouncing on double edges.

That may seem hard to do since not all HW has debounce.

In the past I had the idea to implement also generic debounce with a timer
in gpiolib, so that gpiod_set_debounce() would never fail, so in effect
to factor the code from drivers/input/keyboard/gpio_keys.c
over to gpiolib so they don't need a fallback at all, and then with
double edges, enforce some debouncing based on HZ.

At one point I tried to bring the debounce code over from the
input driver, but I hit some snag, I don't remember what though.
An optional per-gpiod timer can be created in struct gpio_desc
when needed.

> A similar approach would be great to have to "simulate" level sensitive
> irqs if the hardware only implements edge logic (which affects
> armada-37xx, too, which annoys me).

Yes that would be neat too...

Yours,
Linus Walleij
