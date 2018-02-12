Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932972AbeBLIsK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 03:48:10 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55696 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932804AbeBLIsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 03:48:08 -0500
X-Google-Smtp-Source: AH8x224agO572J+DS9tUC7hqUo6X3d9DaXBKX2Sp/qhARQmCKPaSYVN/WmRO+aut0kNfgakBu88BgA==
MIME-Version: 1.0
In-Reply-To: <1518316987.5562.7.camel@gmail.com>
References: <1518316987.5562.7.camel@gmail.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 12 Feb 2018 16:47:45 +0800
X-Gmail-Original-Message-ID: <CAGb2v64L8Va65vf1_cgW8GkdmWuROGC6aUXsLytjcxipUWGWEw@mail.gmail.com>
Message-ID: <CAGb2v64L8Va65vf1_cgW8GkdmWuROGC6aUXsLytjcxipUWGWEw@mail.gmail.com>
Subject: Re: [BUG]: A83T - AC100 gets the wrong number of parents
To: Philipp Rossak <embed3d@gmail.com>
Cc: linux-sunxi <linux-sunxi@googlegroups.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        linux-rtc@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 11, 2018 at 10:43 AM, Philipp Rossak <embed3d@gmail.com> wrote:
> Hey,
>
> When I boot my A83T I get the following bootlog [1].
>
> After some debugging, I found out that the function call:
> clk_hw_get_num_parents() returns 2. After a look in the devicetree I
> found out that this value should be 1, since we only have one parent
> clock [3].

Not really. The first parent is registered within the rtc-ac100 driver,
which also handles the clocks on the RTC side of the chip.

The clock in the device tree is meant to tie the two parts of the chip
together: the codec side provides a high speed clock to the RTC side.

> Setting the variable num_parents to 1 fixes the problem, but this is no
> soultion.

A good fix would be to check the return value of clk_hw_get_parent_by_index()
here: http://lxr.bootlin.com/linux/v4.16-rc1/source/drivers/rtc/rtc-ac100.c#L186
and skip it if it's NULL.

The driver is setup this way because the codec side is not implemented,
but the device tree binding is partially defined to include the clock.

ChenYu

> Regards,
> Philipp
>
>
>
> [1]: https://pastebin.com/5c7hxjsS
> [2]: http://lxr.bootlin.com/linux/v4.15/source/drivers/rtc/rtc-ac100.c#
> L180
> [3]: http://lxr.bootlin.com/linux/v4.15/source/arch/arm/boot/dts/sun8i-
> a83t-bananapi-m3.dts#L159
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
