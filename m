Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35917C282C5
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 08:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03ABF218A6
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 08:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfAZIaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 03:30:21 -0500
Received: from mail.qboosh.pl ([217.73.31.61]:58575 "EHLO mail.qboosh.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbfAZIaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 03:30:21 -0500
X-Greylist: delayed 417 seconds by postgrey-1.27 at vger.kernel.org; Sat, 26 Jan 2019 03:30:20 EST
Received: by mail.qboosh.pl (Postfix, from userid 1000)
        id 040B21A26DA9; Sat, 26 Jan 2019 09:23:22 +0100 (CET)
Date:   Sat, 26 Jan 2019 09:23:22 +0100
From:   Jakub Bogusz <qboosh@pld-linux.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Eric Wong <e@80x24.org>, lkml <linux-kernel@vger.kernel.org>,
        Miloslav Trmac <mitr@volny.cz>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Subject: Re: [PATCH][RESEND] wistron_btns needs executable BIOS image
Message-ID: <20190126082321.GA6792@mail>
References: <20170731182010.GA933@stranger.qboosh.pl> <20190125191437.GA25902@stranger.qboosh.pl> <20190125211349.nfbbcuaip5y6l5dr@dcvr> <CAKdAkRSZ6cT=fO42YG320Po6cYtWaPgg2puAf5jMnC+hD+Em2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKdAkRSZ6cT=fO42YG320Po6cYtWaPgg2puAf5jMnC+hD+Em2g@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 01:41:47PM -0800, Dmitry Torokhov wrote:
> On Fri, Jan 25, 2019 at 1:13 PM Eric Wong <e@80x24.org> wrote:
> >
> > Jakub Bogusz <qboosh@pld-linux.org> wrote:
> > > Let's try once again... (take 3)
> > >
> > > First time I sent this patch when I prepared it in 2013 for Linux 3.12,
> > > the second time after update for Linux 4.12 in 2017...
> > > And it still applies to Linux 4.20.
> >
> > Adding Dmitry Torokhov and linux-input to Cc:
> > (that's what ./scripts/get_maintainer.pl says)

Thanks. I was aware only of MAINTAINERS file.

[...]
> > > wistron_btns needs executable BIOS image.
> > >
> > > Signed-off-by: Jakub Bogusz <qboosh@pld-linux.org>
> > >
> > > --- linux-4.12/drivers/input/misc/wistron_btns.c.orig 2013-11-16 09:05:55.612742472 +0100
> > > +++ linux-4.12/drivers/input/misc/wistron_btns.c      2013-11-16 09:24:37.356028732 +0100
> > > @@ -33,6 +33,7 @@
> > >  #include <linux/types.h>
> > >  #include <linux/platform_device.h>
> > >  #include <linux/leds.h>
> > > +#include <asm/set_memory.h>
> > >
> > >  /* How often we poll keys - msecs */
> > >  #define POLL_INTERVAL_DEFAULT        500 /* when idle */
> > > @@ -124,6 +125,7 @@
> > >       if (entry_point >= 0xF0000) {
> > >               bios_code_map_base = base;
> > >               bios_entry_point = bios_code_map_base + (entry_point & 0xFFFF);
> > > +             set_memory_x((unsigned long)bios_code_map_base, 0x10000 >> PAGE_SHIFT);
> > >       } else {
> > >               iounmap(base);
> > >               bios_code_map_base = ioremap(entry_point & ~0x3FFF, 0x4000);
> > > @@ -134,6 +136,7 @@
> > >                       goto err;
> > >               }
> > >               bios_entry_point = bios_code_map_base + (entry_point & 0x3FFF);
> > > +             set_memory_x((unsigned long)bios_code_map_base, 0x4000 >> PAGE_SHIFT);
> > >       }
> > >       /* The Windows driver maps 0x10000 bytes, we keep only one page... */
> > >       bios_data_map_base = ioremap(0x400, 0xc00);
> 
> It is really weird have __iomem region to have executable bit set. I
> wonder if, along with the setting memory to X, we should not change
> that ioremap() to memremap()?

Maybe... this is area of BIOS ROM, not I/O. But I'm not sure about
cacheability.

Looking at recent kernel code (4.19 to be exact) ioremap ends in
__ioremap_caller with _PAGE_CACHE_MODE_UC_MINUS, while memremap would end
in __ioremap_caller with e.g. (depending on flags) _PAGE_CACHE_MODE_WT.

Unfortunately now I have rare access to this hardware (FS Amilo) to
test.


-- 
Jakub Bogusz    http://qboosh.pl/
