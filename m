Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D24C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 06:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9352221564
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 06:18:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9352221564
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbeHXJvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 05:51:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38144 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbeHXJvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 05:51:03 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 33E3225A;
        Fri, 24 Aug 2018 06:17:54 +0000 (UTC)
Date:   Fri, 24 Aug 2018 08:17:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        stable@vger.kernel.org
Subject: Re: [PATCH] nohz: Fix missing tick reprog while interrupting inline
 timer softirq
Message-ID: <20180824061750.GA20523@kroah.com>
References: <1533077570-9169-1-git-send-email-frederic@kernel.org>
 <8ecb9229-4c14-6967-0863-15b47cefd251@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ecb9229-4c14-6967-0863-15b47cefd251@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 05:57:06PM -0500, Grygorii Strashko wrote:
> Hi
> 
> On 07/31/2018 05:52 PM, Frederic Weisbecker wrote:
> > Before updating the full nohz tick or the idle time on IRQ exit, we
> > check first if we are not in a nesting interrupt, whether the inner
> > interrupt is a hard or a soft IRQ.
> > 
> > There is a historical reason for that: the dyntick idle mode used to
> > reprogram the tick on IRQ exit, after softirq processing, and there was
> > no point in doing that job in the outer nesting interrupt because the
> > tick update will be performed through the end of the inner interrupt
> > eventually, with even potential new timer updates.
> > 
> > One corner case could show up though: if an idle tick interrupts a softirq
> > executing inline in the idle loop (through a call to local_bh_enable())
> > after we entered in dynticks mode, the IRQ won't reprogram the tick
> > because it assumes the softirq executes on an inner IRQ-tail. As a
> > result we might put the CPU in sleep mode with the tick completely
> > stopped whereas a timer can still be enqueued. Indeed there is no tick
> > reprogramming in local_bh_enable(). We probably asssumed there was no bh
> > disabled section in idle, although there didn't seem to be debug code
> > ensuring that.
> > 
> > Nowadays the nesting interrupt optimization still stands but only concern
> > full dynticks. The tick is stopped on IRQ exit in full dynticks mode
> > and we want to wait for the end of the inner IRQ to reprogramm the tick.
> > But in_interrupt() doesn't make a difference between softirqs executing
> > on IRQ tail and those executing inline. What was to be considered a
> > corner case in dynticks-idle mode now becomes a serious opportunity for
> > a bug in full dynticks mode: if a tick interrupts a task executing
> > softirq inline, the tick reprogramming will be ignored and we may exit
> > to userspace after local_bh_enable() with an enqueued timer that will
> > never fire.
> > 
> > To fix this, simply keep reprogramming the tick if we are in a hardirq
> > interrupting softirq. We can still figure out a way later to restore
> > this optimization while excluding inline softirq processing.
> > 
> > Reported-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Tested-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
> > ---
> >   kernel/softirq.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/softirq.c b/kernel/softirq.c
> > index 900dcfe..0980a81 100644
> > --- a/kernel/softirq.c
> > +++ b/kernel/softirq.c
> > @@ -386,7 +386,7 @@ static inline void tick_irq_exit(void)
> >   
> >   	/* Make sure that timer wheel updates are propagated */
> >   	if ((idle_cpu(cpu) && !need_resched()) || tick_nohz_full_cpu(cpu)) {
> > -		if (!in_interrupt())
> > +		if (!in_irq())
> >   			tick_nohz_irq_exit();
> >   	}
> >   #endif
> > 
> 
> This patch was back ported to the Stable linux-4.14.y and It causes regression -
>  flood of "NOHZ: local_softirq_pending" messages on all TI boards during boot (NFS boot):
> 
> [    4.179796] NOHZ: local_softirq_pending 2c2 in sirq 256
> [    4.185051] NOHZ: local_softirq_pending 2c2 in sirq 256
> 
> the same is not reproducible with LKML - seems due to changes in tick-sched.c 
> __tick_nohz_idle_enter()/tick_nohz_irq_exit().

What changes do you think fixed this?

> I've generated backtrace from  can_stop_idle_tick() (see below) and seems this
> patch makes tick_nohz_irq_exit() call unconditional in case of nested interrupt:
> 
> gic_handle_irq
>  |- irq_exit
>     |- preempt_count_sub(HARDIRQ_OFFSET); <-- [1]
>     |-__do_softirq 
> 	<irqs enabled>
> 	|- gic_handle_irq()
> 	   |- irq_exit()
> 		|- tick_irq_exit()
> 		   if (!in_irq()) <-- My understanding is that this condition will be always true due to [1]
> 			tick_nohz_irq_exit();
> 			|-__tick_nohz_idle_enter()
> 			  |- can_stop_idle_tick()
> 
> Sry, not sure if my conclusion is right and how can it be fixed.

Any pointers to a patch that might need to be backported would be
appreciated.

thanks,

greg k-h
