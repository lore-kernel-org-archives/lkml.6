Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752018AbeCLOLP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 10:11:15 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:46247 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751255AbeCLOLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 10:11:13 -0400
Date: Mon, 12 Mar 2018 15:11:07 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Corey Minyard <cminyard@mvista.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>
Subject: Re: Warning from swake_up_all in 4.14.15-rt13 non-RT
Message-ID: <20180312141107.roveviectc6a75s7@linutronix.de>
References: <20180306174604.nta5rcvfvrfdfftz@linutronix.de>
 <1704d817-8fb9-ce8f-1aa1-fe6e8b0c3919@mvista.com>
 <20180308174103.mduy5qq2ttlcvig3@linutronix.de>
 <a11f140e-c44f-f967-1cd4-d8a6f09d4d29@mvista.com>
 <20180309110418.lwtennjqwqcxh422@linutronix.de>
 <20180309174605.GC4064@hirez.programming.kicks-ass.net>
 <20180309202550.j66qphz3txupt55u@linutronix.de>
 <20180309222643.GC5926@hirez.programming.kicks-ass.net>
 <20180312105113.p7jifhwdwbhpvxds@linutronix.de>
 <20180312132729.GI4064@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180312132729.GI4064@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-12 14:27:29 [+0100], Peter Zijlstra wrote:
> On Mon, Mar 12, 2018 at 11:51:13AM +0100, Sebastian Andrzej Siewior wrote:
> > On 2018-03-09 23:26:43 [+0100], Peter Zijlstra wrote:
> > > On Fri, Mar 09, 2018 at 09:25:50PM +0100, Sebastian Andrzej Siewior wrote:
> > > > Is it just about the irqsave() usage or something else? I doubt it is
> > > > the list walk. It is still unbound if not called from irq-off region.
> > > 
> > > The current list walk is preemptible. You put the entire iteration (of
> > > unbound length) inside a single critical section which destroy RT.
> > 
> > I considered that list walk as cheap. We don't do any wake ups with the
> > list walk - just mark the task for a later wake up. But if it is not I
> > could add an upper limit of 20 iterations or so.
> 
> So the problem is that as soon as this is exposed to userspace you've
> lost.

I know. We had this very same problem with clock_nanosleep() which got
solved after timer rework.

> If a user can stack like 10000 tasks on the completion before triggering
> it, you've got yourself a giant !preempt section. Yes the wake_q stuff
> is cheaper, but unbound is still unbound.
> 
> wake_all must not be used from !preemptible (IRQ or otherwise) sections.
> And I'm not seeing how waking just the top 20 helps.

I assumed you complained about the unbounded list-walk with interrupts
disabled (which is cheap but unbound is unbound). So here I suggested I
move 20 entries off that list a time and enable interrupts again so an
interrupt could set need_resched.
But if we get invoked !preemptible then nothing changes.

> > > Why isn't this a problem on RT?
> > So we remain in the preempt_disable() section due to RCU-sched so we
> > have this, yes. But the "disabled interrupts" part is due to
> > spin_lock_irqsave() which is a non-issue on RT. So if we managed to get
> > rid of the rcu-sched then the swait can go and we can stick with the
> > wake_up_all() on RT, too.
> 
> OK, so for RT we simply loose the IRQ-disable thing, but its still a
> !preemptible section.

exactly. The irqsafe() was to guard non-RT config which uses the same
code.
So do I understand you correctly that irqsafe may remain for !RT config
but that invocation with disabled preemption due to sched_rcu (on RT,
too) must go?

Sebastian
