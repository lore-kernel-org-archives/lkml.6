Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E599C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28D5D223C8
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:20:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28D5D223C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbeKLTNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 14:13:08 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:52236 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbeKLTNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 14:13:07 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 23541297DB;
        Mon, 12 Nov 2018 04:20:43 -0500 (EST)
Date:   Mon, 12 Nov 2018 20:21:02 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Arnd Bergmann <arnd@arndb.de>,
        Stephen N Chivers <schivers@csc.com.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 07/13] m68k: amiga: Convert to clocksource API
In-Reply-To: <CAMuHMdU15gaEcwG4JCFxDwsA-dm0uHzZe_EmtoSLgOV2XAgWbQ@mail.gmail.com>
Message-ID: <alpine.LNX.2.21.1811122007531.351@nippy.intranet>
References: <cover.1541995959.git.fthain@telegraphics.com.au> <cbfa6a4e8a1a36e22969e63b703015007abe8593.1541995959.git.fthain@telegraphics.com.au> <CAMuHMdU15gaEcwG4JCFxDwsA-dm0uHzZe_EmtoSLgOV2XAgWbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Nov 2018, Geert Uytterhoeven wrote:

> Hi Finn,
> 
> On Mon, Nov 12, 2018 at 5:46 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> > Add a platform clocksource by adapting the existing arch_gettimeoffset
> > implementation.
> >
> > Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> 
> Thanks for your patch!
> 

Thanks for your review.

> > --- a/arch/m68k/amiga/config.c
> > +++ b/arch/m68k/amiga/config.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/mm.h>
> >  #include <linux/seq_file.h>
> >  #include <linux/tty.h>
> > +#include <linux/clocksource.h>
> >  #include <linux/console.h>
> >  #include <linux/rtc.h>
> >  #include <linux/init.h>
> > @@ -461,7 +462,30 @@ void __init config_amiga(void)
> >                 *(unsigned char *)ZTWO_VADDR(0xde0002) |= 0x80;
> >  }
> >
> > +static u64 amiga_read_clk(struct clocksource *cs);
> > +
> > +static struct clocksource amiga_clk = {
> > +       .name   = "ciab",
> > +       .rating = 250,
> > +       .read   = amiga_read_clk,
> > +       .mask   = CLOCKSOURCE_MASK(32),
> > +       .flags  = CLOCK_SOURCE_IS_CONTINUOUS,
> > +};
> > +
> >  static unsigned short jiffy_ticks;
> > +static u32 clk_total;
> 
> Shouldn't clk_total be u64?
> 

Well, it was intentionally u32, and amiga_clk.mask was intentionally 
CLOCKSOURCE_MASK(32)...

> > +
> > +static irqreturn_t ciab_timer_handler(int irq, void *data)
> > +{
> > +       irq_handler_t timer_routine = data;
> > +       unsigned long flags;
> > +
> > +       local_irq_save(flags);
> > +       clk_total += jiffy_ticks;
> > +       local_irq_restore(flags);
> > +
> > +       return timer_routine(irq, data);
> > +}
> 
> [...]
> 
> > -static u32 amiga_gettimeoffset(void)
> > +static u64 amiga_read_clk(struct clocksource *cs)
> >  {
> >         unsigned long flags;
> >         unsigned short hi, lo, hi2;
> > @@ -512,14 +537,13 @@ static u32 amiga_gettimeoffset(void)
> >         if (ticks > jiffy_ticks / 2)
> >                 /* check for pending interrupt */
> >                 if (cia_set_irq(&ciab_base, 0) & CIA_ICR_TA)
> > -                       offset = 10000;
> > +                       offset = jiffy_ticks;
> >
> >         local_irq_restore(flags);
> >
> >         ticks = jiffy_ticks - ticks;
> > -       ticks = (10000 * ticks) / jiffy_ticks;
> >
> > -       return (ticks + offset) * 1000;
> > +       return clk_total + ticks + offset;
> 
> ... to return a full 64-bit value here?
> 

It's certainly possible. Is it better? It sounds like a question about the 
cost of wrap-around in the clocksource core vs. the cost of 64-bit 
additions in the arch code.

Looking at __clocksource_update_freq_scale() there are some consequences 
to choosing a 32-bit mask --

                 * For clocksources which have a mask > 32-bit
                 * we need to limit the max sleep time to have a good
                 * conversion precision.

I don't know the answer, sorry.

-- 

> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> 
