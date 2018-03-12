Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751279AbeCLKvU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 06:51:20 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45824 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750752AbeCLKvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 06:51:19 -0400
Date: Mon, 12 Mar 2018 11:51:13 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Corey Minyard <cminyard@mvista.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>
Subject: Re: Warning from swake_up_all in 4.14.15-rt13 non-RT
Message-ID: <20180312105113.p7jifhwdwbhpvxds@linutronix.de>
References: <dd6ad0b5-569b-067d-257f-dbf15ffa7077@mvista.com>
 <20180306174604.nta5rcvfvrfdfftz@linutronix.de>
 <1704d817-8fb9-ce8f-1aa1-fe6e8b0c3919@mvista.com>
 <20180308174103.mduy5qq2ttlcvig3@linutronix.de>
 <a11f140e-c44f-f967-1cd4-d8a6f09d4d29@mvista.com>
 <20180309110418.lwtennjqwqcxh422@linutronix.de>
 <20180309174605.GC4064@hirez.programming.kicks-ass.net>
 <20180309202550.j66qphz3txupt55u@linutronix.de>
 <20180309222643.GC5926@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180309222643.GC5926@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-09 23:26:43 [+0100], Peter Zijlstra wrote:
> On Fri, Mar 09, 2018 at 09:25:50PM +0100, Sebastian Andrzej Siewior wrote:
> > Is it just about the irqsave() usage or something else? I doubt it is
> > the list walk. It is still unbound if not called from irq-off region.
> 
> The current list walk is preemptible. You put the entire iteration (of
> unbound length) inside a single critical section which destroy RT.

I considered that list walk as cheap. We don't do any wake ups with the
list walk - just mark the task for a later wake up. But if it is not I
could add an upper limit of 20 iterations or so.

> > But it is now possible, I agree. The wake_q usage should be cheaper
> > compared to IRQ off+on in each loop. And we wanted to do the wake ups
> > with enabled interrupts - there is still the list_splice() from that
> > attempt. Now it can be.
> 
> Unbound is still unbound, inf/n := inf. A 'cheaper' unbound doesn't RT
> make.

What I meant is that wake_q() is invoked with interrupts enabled and we
don't need the IRQ on/off on each iteration. But as I said in the upper
paragraph, I can add an upper limit for the list walk. And wake up
itself is with enabled interrupts.

> > > Yes, wake_up_all() is crap, it is also fundamentally incompatible with
> > > in-*irq usage. Nothing to be done about that.
> > I still have (or need) completions which are swait based and do
> > complete_all(). 
> 
> That's fine, as long as they're done from preemptible context. Back when
> we introduced swait this was an explicit design goal/limitation. And
> there were no in-irq users of this.

Yes at that time in !RT. wake_up() is using sleeping locks on RT and
swait is the only thing that can be used there. So if I don't get rid if
that !preemptible part I try to switch to swait.

> > There are complete_all() caller which wake more than one
> > waiter (that is PM and crypto from the reports I got once I added the
> > WARN_ON())).
> > The in-IRQ usage is !RT only and was there before.
> 
> Then that's broken and needs to be undone. Also, why did you need the
> WARN, lockdep should've equally triggered on this, no?

I added WARN_ON() and I didn't even think about lockdep. I wanted to
see a warning even with lockdep off.
After adding this for testing:

        {
                 raw_spin_lock_irq(&lock1);
                 raw_spin_unlock_irq(&lock1);
                 raw_spin_lock_irq(&lock2);
                 raw_spin_unlock_irq(&lock2);
 
                 raw_spin_lock_irq(&lock1);
                 raw_spin_lock_irq(&lock2);
                 raw_spin_unlock_irq(&lock2);
                 raw_spin_unlock_irq(&lock1);

                 raw_spin_lock_irq(&lock2);
                 raw_spin_lock_irq(&lock1);
                 raw_spin_unlock_irq(&lock1);
                 raw_spin_unlock_irq(&lock2);
         }

I see only one complaint about the lock order in the last block. With
that one gone there is no complain about the second block. So no,
lockdep does not report such things (this was just tested on RT and
TIP).

> > > So NAK on this.
> > So I need completions to be swait based and do complete_all() from IRQ
> > (on !RT, not RT). I have this one call which breaks the usage on !RT and
> > has wake_up_all() in it in vanilla which needs an swait equivalent since
> > it calls its callback from an rcu-sched section.
> 
> Why isn't this a problem on RT?
So we remain in the preempt_disable() section due to RCU-sched so we
have this, yes. But the "disabled interrupts" part is due to
spin_lock_irqsave() which is a non-issue on RT. So if we managed to get
rid of the rcu-sched then the swait can go and we can stick with the
wake_up_all() on RT, too.

Sebastian
