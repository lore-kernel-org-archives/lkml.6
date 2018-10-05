Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2997AC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE2BB2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 07:08:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE2BB2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbeJEOFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 10:05:45 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60269 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727185AbeJEOFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 10:05:45 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 84F7120890; Fri,  5 Oct 2018 09:08:21 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3FC742072B;
        Fri,  5 Oct 2018 09:08:11 +0200 (CEST)
Date:   Fri, 5 Oct 2018 09:08:11 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 10/10] mtd: maps: gpio-addr-flash: Add support for
 device-tree devices
Message-ID: <20181005090811.6b7e9957@bbrezillon>
In-Reply-To: <CAPybu_26HST5xGfhE6MoVTRZok_gfDqN=ZOAesuEMVskdrCpLA@mail.gmail.com>
References: <20181004142942.11887-1-ricardo.ribalda@gmail.com>
        <20181004142942.11887-2-ricardo.ribalda@gmail.com>
        <20181005002125.12fd229f@bbrezillon>
        <CAPybu_26HST5xGfhE6MoVTRZok_gfDqN=ZOAesuEMVskdrCpLA@mail.gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

On Fri, 5 Oct 2018 08:31:35 +0200
Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com> wrote:

> Hi Boris
> 
> 
> On Fri, Oct 5, 2018 at 12:21 AM Boris Brezillon
> <boris.brezillon@bootlin.com> wrote:
> >
> > Hi Ricardo,
> >
> > On Thu,  4 Oct 2018 16:29:42 +0200
> > Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com> wrote:
> >  
> > > Allow creating gpio-addr-flash via device-tree and not just via platform
> > > data.
> > >
> > > Mimic what physmap_of_versatile and physmap_of_gemini does to reduce
> > > code duplicity.
> > >
> > > Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> > > ---
> > >  drivers/mtd/maps/Kconfig           |  8 +++
> > >  drivers/mtd/maps/Makefile          |  3 +-
> > >  drivers/mtd/maps/gpio-addr-flash.c | 95 +++++++++++++++++++-----------
> > >  drivers/mtd/maps/gpio-addr-flash.h | 34 +++++++++++
> > >  drivers/mtd/maps/physmap_of_core.c |  5 ++
> > >  drivers/mtd/maps/physmap_of_gpio.c | 21 +++++++
> > >  6 files changed, 129 insertions(+), 37 deletions(-)
> > >  create mode 100644 drivers/mtd/maps/gpio-addr-flash.h
> > >  create mode 100644 drivers/mtd/maps/physmap_of_gpio.c
> > >
> > > diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
> > > index afb36bff13a7..427143d42168 100644
> > > --- a/drivers/mtd/maps/Kconfig
> > > +++ b/drivers/mtd/maps/Kconfig
> > > @@ -94,6 +94,14 @@ config MTD_PHYSMAP_OF_GEMINI
> > >         platforms, some detection and setting up parallel mode on the
> > >         external interface.
> > >
> > > +config MTD_PHYSMAP_OF_GPIO
> > > +     bool "GPIO-assisted OF-based physical memory map handling"
> > > +     depends on MTD_PHYSMAP_OF
> > > +     depends on MTD_GPIO_ADDR
> > > +     help
> > > +       This provides some extra DT physmap parsing for flashes that are
> > > +       partially physically addressed and assisted by GPIOs.
> > > +  
> >
> > Hm, so now we have the physmap_of driver which uses a function exposed
> > by the gpio-addr-flash module, but this module is also declaring a
> > platform_driver. It's probably working fine, but it's hard to follow.
> >
> > So, I decided to give it a try and started to rework a bit the physmap,
> > physmap_of and gpio-addr-flash drivers. Here is the result [1] (it's
> > only been compile tested). With this rework we now have a single
> > driver which supports DT and !DT init and can also use GPIOs to
> > extend the physical memory range in case it's not large enough to
> > address the whole memory dev.
> >
> > Let me know what you think of this approach.
> >  
> 
> The code is definitely easier to follow. But I believe you should
> rebase your changes on mines (1-9) and instead of 10 apply your
> patch-set.:
> - "mtd: maps: Merge gpio-addr-flash.c into physmap-core.c" includes
> all my changes and some of them are not obvious:( Port to gpiod,
> gpio_values, win_order, use new apis....)

True.

> - Also there would be 1 (or 2) fixes that should be included in stable
> that we lose using your approach "mtd: maps: gpio-addr-flash: Fix
> ioremapped size", "mtd: physmap_of: Release resources on error"

I'm not sure this is really useful to backport them to stable since
blackfin users never complained about it (plus, blackin arch is now
gone), but okay.

> - And last, but not least, I want some credit for all this work ;)
> After 10 iterations I guess that I deserve more than a Documentation
> change, specially when my code would be on the tree.

Fair enough.

> 
> My other concern is that maybe we are giving too much entity to
> gpio-addr by including it in the core. But if you are fine with it, I
> am fine with it.

Well, the gpio-addr stuff is just here to support platforms that do not
have enough ADDR lines (or iomem address space) to address the whole
device. I see it as an 'extension' of the physmap logic, which is why I
think it makes sense to have this logic in the physmap driver instead
of creating a completely new driver.

> 
> If you want i can do the rebase and start testing on my board. What do
> you think?

That'd be great!

Thanks,

Boris
