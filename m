Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E90C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F93A22507
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 00:11:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F93A22507
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730541AbeKMKGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 05:06:40 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:42186 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbeKMKGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 05:06:40 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 574EA29C7D;
        Mon, 12 Nov 2018 19:11:06 -0500 (EST)
Date:   Tue, 13 Nov 2018 11:11:33 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Thomas Gleixner <tglx@linutronix.de>
cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen N Chivers <schivers@csc.com.au>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 13/13] m68k: mvme16x: Convert to clocksource API
In-Reply-To: <alpine.DEB.2.21.1811121001140.14703@nanos.tec.linutronix.de>
Message-ID: <alpine.LNX.2.21.1811130826260.356@nippy.intranet>
References: <cover.1541995959.git.fthain@telegraphics.com.au> <2f4015ba435f6f06b874295d2a47319875474c7f.1541995959.git.fthain@telegraphics.com.au> <alpine.DEB.2.21.1811121001140.14703@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Nov 2018, Thomas Gleixner wrote:

> Finn,
> 
> First of all, thanks for tackling this!
> 

Happy to help. Thanks for your review.

> > +static u32 clk_total;
> > +
> > +#define PCC_TIMER_CLOCK_FREQ 1000000
> > +#define PCC_TIMER_CYCLES     (PCC_TIMER_CLOCK_FREQ / HZ)
> > +
> >  static irqreturn_t mvme16x_timer_int (int irq, void *dev_id)
> >  {
> > +    irq_handler_t tick_handler = dev_id;
> > +    unsigned long flags;
> > +
> > +    local_irq_save(flags);
> 
> No need for local_irq_save() here. Interrupt handlers are guaranteed to be
> called with interrupts disabled.
> 

That's not the case on m68k, as I understand it. However, the CPU 
interrupt level does prevent interrupt handlers from nesting.

> >      *(volatile unsigned char *)0xfff4201b |= 8;
> > +    clk_total += PCC_TIMER_CYCLES;
> 
> Looking at the read function below, I assume that this magic 0xfff42008 
> register counts up to PCC_TIMER_CYCLES, which triggers the timer 
> interrupt and then starts from 0 again. And looking at the programming 
> manual actually confirms that assumption (COC is set in the control 
> reg).
> 
> > -u32 mvme16x_gettimeoffset(void)
> > +static u64 mvme16x_read_clk(struct clocksource *cs)
> >  {
> > -    return (*(volatile u32 *)0xfff42008) * 1000;
> > +    u32 count = *(volatile u32 *)0xfff42008;
> > +
> > +    return clk_total + count;
> >  }
> 
> There is a problem with that approach. Assume the following situation:
> 
> 				Counter value (HZ = 100)
>        local_irq_disable()	
>        ...
>        ktime_get()		9999
>        ....			10000 -> 0 (interrupt is triggered)
>        ktime_get()		1
> 
> IOW, time goes backwards.
> 

Yes. It's not a new problem. I think hp300 and mvme147 have similar 
issues.

If the clocksource core is badly affected by this problem then I'll have 
to address it.

> There are two ways to solve that:
> 
>  1) Take the overflow bits in the timer control register into account,
>     which makes time readout even slower because you need to do it like
>     this:
> 
>     do {
>        ovfl = read(TCR1);
>        now = read(TCNT1);
>     while (ovfl != read(TCR1));
>     ....
>   

How about,

	local_irq_save(flags);
	ovfl = read(TCR1);
	now = read(TCNT1);
	if (ovfl != read(TCR1))
		now = read(TCNT1);

	ticks = clk_total + now;
	offset = (ovfl >> 4) * PCC_TIMER_CYCLES;
	local_irq_restore(flags);

	return offset + ticks;

This has to be synchronized with the interrupt handler because the 
interrupt handler must clear the overflow counter in TCR1 when it does 
clk_total += PCC_TIMER_CYCLES;

BTW, there are some synchronization bugs in this patch series that will be 
addressed in the next submission. They have been fixed in my github repo.

> 
>  2) Use Timer2 in freerunning mode which means it will use the full 32bit
>     and then wrap back to 0. That's fine and the clocksource core handles
>     that.
> 
>     That removes the clk_total thing and just works.
> 

I really like this suggestion!

But I fear it is a change that cannot be checked by inspection. If I wrote 
it, I'd want to test it, or have someone else test it. (Stephen?)

I wonder if there exists an emulator for MVME 162/166/167/172/177 machines 
capable of booting Linux...

-- 

> Thanks,
> 
> 	tglx
> 
