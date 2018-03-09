Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932325AbeCIUZ5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 15:25:57 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:42319 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751192AbeCIUZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 15:25:56 -0500
Date: Fri, 9 Mar 2018 21:25:50 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Corey Minyard <cminyard@mvista.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>
Subject: Re: Warning from swake_up_all in 4.14.15-rt13 non-RT
Message-ID: <20180309202550.j66qphz3txupt55u@linutronix.de>
References: <dd6ad0b5-569b-067d-257f-dbf15ffa7077@mvista.com>
 <20180306174604.nta5rcvfvrfdfftz@linutronix.de>
 <1704d817-8fb9-ce8f-1aa1-fe6e8b0c3919@mvista.com>
 <20180308174103.mduy5qq2ttlcvig3@linutronix.de>
 <a11f140e-c44f-f967-1cd4-d8a6f09d4d29@mvista.com>
 <20180309110418.lwtennjqwqcxh422@linutronix.de>
 <20180309174605.GC4064@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180309174605.GC4064@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-09 18:46:05 [+0100], Peter Zijlstra wrote:
> On Fri, Mar 09, 2018 at 12:04:18PM +0100, Sebastian Andrzej Siewior wrote:
> > +void swake_add_all_wq(struct swait_queue_head *q, struct wake_q_head *wq)
> >  {
> >  	struct swait_queue *curr;
> >  
> >  	while (!list_empty(&q->task_list)) {
> >  
> >  		curr = list_first_entry(&q->task_list, typeof(*curr),
> >  					task_list);
> >  		list_del_init(&curr->task_list);
> > +		wake_q_add(wq, curr->task);
> >  	}
> >  }
> > +EXPORT_SYMBOL(swake_add_all_wq);
> >  
> >  void swake_up(struct swait_queue_head *q)
> >  {
> > @@ -66,25 +62,14 @@ EXPORT_SYMBOL(swake_up);
> >   */
> >  void swake_up_all(struct swait_queue_head *q)
> >  {
> > +	unsigned long flags;
> > +	DEFINE_WAKE_Q(wq);
> >  
> > +	raw_spin_lock_irqsave(&q->lock, flags);
> > +	swake_add_all_wq(q, &wq);
> > +	raw_spin_unlock_irqrestore(&q->lock, flags);
> >  
> > +	wake_up_q(&wq);
> >  }
> >  EXPORT_SYMBOL(swake_up_all);
> 
> This is fundamentally wrong. The whole point of wake_up_all() is that
> _all_ is unbounded and should not ever land in a single critical
> section, be it IRQ or PREEMPT disabled. The above does both.

Is it just about the irqsave() usage or something else? I doubt it is
the list walk. It is still unbound if not called from irq-off region.
But it is now possible, I agree. The wake_q usage should be cheaper
compared to IRQ off+on in each loop. And we wanted to do the wake ups
with enabled interrupts - there is still the list_splice() from that
attempt. Now it can be.

> Yes, wake_up_all() is crap, it is also fundamentally incompatible with
> in-*irq usage. Nothing to be done about that.
I still have (or need) completions which are swait based and do
complete_all(). There are complete_all() caller which wake more than one
waiter (that is PM and crypto from the reports I got once I added the
WARN_ON())).
The in-IRQ usage is !RT only and was there before.

> So NAK on this.
So I need completions to be swait based and do complete_all() from IRQ
(on !RT, not RT). I have this one call which breaks the usage on !RT and
has wake_up_all() in it in vanilla which needs an swait equivalent since
it calls its callback from an rcu-sched section.

Sebastian
