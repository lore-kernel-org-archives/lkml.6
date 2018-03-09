Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933274AbeCIW04 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 17:26:56 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42336 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932584AbeCIW0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 17:26:53 -0500
Date: Fri, 9 Mar 2018 23:26:43 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Corey Minyard <cminyard@mvista.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>
Subject: Re: Warning from swake_up_all in 4.14.15-rt13 non-RT
Message-ID: <20180309222643.GC5926@hirez.programming.kicks-ass.net>
References: <dd6ad0b5-569b-067d-257f-dbf15ffa7077@mvista.com>
 <20180306174604.nta5rcvfvrfdfftz@linutronix.de>
 <1704d817-8fb9-ce8f-1aa1-fe6e8b0c3919@mvista.com>
 <20180308174103.mduy5qq2ttlcvig3@linutronix.de>
 <a11f140e-c44f-f967-1cd4-d8a6f09d4d29@mvista.com>
 <20180309110418.lwtennjqwqcxh422@linutronix.de>
 <20180309174605.GC4064@hirez.programming.kicks-ass.net>
 <20180309202550.j66qphz3txupt55u@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180309202550.j66qphz3txupt55u@linutronix.de>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09, 2018 at 09:25:50PM +0100, Sebastian Andrzej Siewior wrote:
> Is it just about the irqsave() usage or something else? I doubt it is
> the list walk. It is still unbound if not called from irq-off region.

The current list walk is preemptible. You put the entire iteration (of
unbound length) inside a single critical section which destroy RT.

> But it is now possible, I agree. The wake_q usage should be cheaper
> compared to IRQ off+on in each loop. And we wanted to do the wake ups
> with enabled interrupts - there is still the list_splice() from that
> attempt. Now it can be.

Unbound is still unbound, inf/n := inf. A 'cheaper' unbound doesn't RT
make.

> > Yes, wake_up_all() is crap, it is also fundamentally incompatible with
> > in-*irq usage. Nothing to be done about that.
> I still have (or need) completions which are swait based and do
> complete_all(). 

That's fine, as long as they're done from preemptible context. Back when
we introduced swait this was an explicit design goal/limitation. And
there were no in-irq users of this.

> There are complete_all() caller which wake more than one
> waiter (that is PM and crypto from the reports I got once I added the
> WARN_ON())).
> The in-IRQ usage is !RT only and was there before.

Then that's broken and needs to be undone. Also, why did you need the
WARN, lockdep should've equally triggered on this, no?

> > So NAK on this.
> So I need completions to be swait based and do complete_all() from IRQ
> (on !RT, not RT). I have this one call which breaks the usage on !RT and
> has wake_up_all() in it in vanilla which needs an swait equivalent since
> it calls its callback from an rcu-sched section.

Why isn't this a problem on RT?
