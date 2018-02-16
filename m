Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755305AbeBPIxJ convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 03:53:09 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:55689 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755229AbeBPIxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 03:53:08 -0500
Date: Fri, 16 Feb 2018 09:53:03 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/2] kernel/sofirq: consolidate common code in
 __tasklet_schedule() + _hi_
Message-ID: <20180216085302.ptzq5yspmdq3zlh6@linutronix.de>
References: <20180215172042.31573-1-bigeasy@linutronix.de>
 <20180215172042.31573-2-bigeasy@linutronix.de>
 <20180215150707.49cc2332@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180215150707.49cc2332@gandalf.local.home>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-02-15 15:07:07 [-0500], Steven Rostedt wrote:
> On Thu, 15 Feb 2018 18:20:41 +0100
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > -void __tasklet_schedule(struct tasklet_struct *t)
> > +static void __tasklet_schedule_common(struct tasklet_struct *t,
> > +				      struct tasklet_head *head,
> > +				      unsigned int softirq_nr)
> >  {
> >  	unsigned long flags;
> >  
> >  	local_irq_save(flags);
> 
> If you look at the original patch, it did not move local_irq_save()
> into the common function.
correct but…

> >  	t->next = NULL;
> > -	*__this_cpu_read(tasklet_vec.tail) = t;
> > -	__this_cpu_write(tasklet_vec.tail, &(t->next));
> > -	raise_softirq_irqoff(TASKLET_SOFTIRQ);
> > +	*head->tail = t;
> > +	head->tail = &(t->next);
> > +	raise_softirq_irqoff(softirq_nr);
> >  	local_irq_restore(flags);
> >  }
> > +
> > +void __tasklet_schedule(struct tasklet_struct *t)
> > +{
> > +	__tasklet_schedule_common(t, this_cpu_ptr(&tasklet_vec),
> 
> What can happen is, we reference (tasklet_vec) on one CPU, get
> preempted (running in ksoftirqd), scheduled on another CPU, then when
> inside the common code, we are executing on a different CPU than the
> tasklet is for. The rasise_softirq() is happening on the wrong CPU.
> 
> The local_irq_save() can't be moved to the common function. It must be
> done by each individual function.

That __tasklet_schedule_common() part is usually invoked from an
interrupt context which attempts to schedule the tasklet so it should
with invoked with interrupts off. However there was one warn_on()
because something early in the boot managed to invoke it without
interrupts disabled (which I missed). Okay, granted, fixed.

As for the second invocation (tasklet_action_common() part) is always
invoked in BH-disabled context (even if called from ksoftirqd) so you
are never preemptible() and can't switch CPUs.
So I am going to correct this patch as you suggested but I don't see the
reason to do the same in the second one.

> -- Steve
Sebastian
