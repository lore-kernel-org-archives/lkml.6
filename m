Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965160AbeEXHoS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 03:44:18 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:48452 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935502AbeEXHoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 03:44:17 -0400
Date: Thu, 24 May 2018 09:44:14 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] sched,tracing: Correct trace_sched_pi_setprio() for
 deboosting
Message-ID: <20180524074413.dukslrbgqfvaab5b@linutronix.de>
References: <20180523141107.6417-1-bigeasy@linutronix.de>
 <20180523172819.GW12198@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180523172819.GW12198@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-23 19:28:19 [+0200], Peter Zijlstra wrote:
> On Wed, May 23, 2018 at 04:11:07PM +0200, Sebastian Andrzej Siewior wrote:
> 
> > Since that commit I see during a deboost a task this:
> > |futex sched_pi_setprio: comm=futex_requeue_p pid=2234 oldprio=98 newprio=98
> > |futex sched_switch: prev_comm=futex_requeue_p prev_pid=2234 prev_prio=120
> > 
> > and after the revert, the `newprio' shows the correct value again:
> > 
> > |futex sched_pi_setprio: comm=futex_requeue_p pid=2220 oldprio=98 newprio=120
> > |futex sched_switch: prev_comm=futex_requeue_p prev_pid=2220 prev_prio=120
> 
> > @@ -435,7 +435,7 @@ TRACE_EVENT(sched_pi_setprio,
> >  		memcpy(__entry->comm, tsk->comm, TASK_COMM_LEN);
> >  		__entry->pid		= tsk->pid;
> >  		__entry->oldprio	= tsk->prio;
> > -		__entry->newprio	= pi_task ? pi_task->prio : tsk->prio;
> > +		__entry->newprio	= new_prio;
> >  		/* XXX SCHED_DEADLINE bits missing */
> >  	),
> >  
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 092f7c4de903..888df643b99b 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -3823,7 +3823,7 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
> >  		goto out_unlock;
> >  	}
> >  
> > -	trace_sched_pi_setprio(p, pi_task);
> > +	trace_sched_pi_setprio(p, prio);
> 
> at this point:
> 
> 	prio = pi_task ? min(p->normal_prio, pi->task->prio) : p->normal_prio;
> 
> (aka __rt_effective_prio)
> 
> Should we put that in the tracepoint instead?

I don't see the point in open coding __rt_effective_prio() and
recomputing the value we already have. I'm a little worried that if
something happens to `prio' we might miss it and notice later while
debugging.
However, if they are reasons like breaking the trace-API for $tools, I
can update it.

Sebastian
