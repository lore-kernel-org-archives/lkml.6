Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933873AbeEWR23 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 13:28:29 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48862 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932667AbeEWR22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 13:28:28 -0400
Date: Wed, 23 May 2018 19:28:19 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] sched,tracing: Correct trace_sched_pi_setprio() for
 deboosting
Message-ID: <20180523172819.GW12198@hirez.programming.kicks-ass.net>
References: <20180523141107.6417-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523141107.6417-1-bigeasy@linutronix.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 04:11:07PM +0200, Sebastian Andrzej Siewior wrote:

> Since that commit I see during a deboost a task this:
> |futex sched_pi_setprio: comm=futex_requeue_p pid=2234 oldprio=98 newprio=98
> |futex sched_switch: prev_comm=futex_requeue_p prev_pid=2234 prev_prio=120
> 
> and after the revert, the `newprio' shows the correct value again:
> 
> |futex sched_pi_setprio: comm=futex_requeue_p pid=2220 oldprio=98 newprio=120
> |futex sched_switch: prev_comm=futex_requeue_p prev_pid=2220 prev_prio=120

> @@ -435,7 +435,7 @@ TRACE_EVENT(sched_pi_setprio,
>  		memcpy(__entry->comm, tsk->comm, TASK_COMM_LEN);
>  		__entry->pid		= tsk->pid;
>  		__entry->oldprio	= tsk->prio;
> -		__entry->newprio	= pi_task ? pi_task->prio : tsk->prio;
> +		__entry->newprio	= new_prio;
>  		/* XXX SCHED_DEADLINE bits missing */
>  	),
>  
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 092f7c4de903..888df643b99b 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3823,7 +3823,7 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
>  		goto out_unlock;
>  	}
>  
> -	trace_sched_pi_setprio(p, pi_task);
> +	trace_sched_pi_setprio(p, prio);

at this point:

	prio = pi_task ? min(p->normal_prio, pi->task->prio) : p->normal_prio;

(aka __rt_effective_prio)

Should we put that in the tracepoint instead?

>  	oldprio = p->prio;
>  
>  	if (oldprio == prio)
