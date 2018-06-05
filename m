Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752037AbeFEQfU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 12:35:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41586 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751748AbeFEQfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 12:35:19 -0400
Date: Tue, 5 Jun 2018 18:35:16 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Kohli, Gaurav" <gkohli@codeaurora.org>, tglx@linutronix.de,
        mpe@ellerman.id.au, mingo@kernel.org, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v1] kthread/smpboot: Serialize kthread parking against
 wakeup
Message-ID: <20180605163515.GB24053@redhat.com>
References: <20180501131904.GG12217@hirez.programming.kicks-ass.net>
 <9b289790-9b3a-73bd-7166-bf39f32cefd8@codeaurora.org>
 <20180502082011.GB12180@hirez.programming.kicks-ass.net>
 <830d7225-af90-a55a-991a-bb2023d538f1@codeaurora.org>
 <cdd5d434-9c11-7c19-2895-0f7f3811eb11@codeaurora.org>
 <55221a5b-dd52-3359-f582-86830dd9f205@codeaurora.org>
 <ba12bc49-33c0-b4ee-05cf-f84124bd66cc@codeaurora.org>
 <20180605150841.GA24053@redhat.com>
 <20180605152212.GY12180@hirez.programming.kicks-ass.net>
 <20180605154053.GB12235@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605154053.GB12235@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05, Peter Zijlstra wrote:
>
> On Tue, Jun 05, 2018 at 05:22:12PM +0200, Peter Zijlstra wrote:
> 
> > > OK, but __kthread_parkme() can be preempted before it calls schedule(), so the
> > > caller still can be migrated? Plus kthread_park_complete() can be called twice.
> > 
> > Argh... I forgot TASK_DEAD does the whole thing with preempt_disable().
> > Let me stare at that a bit.
> 
> This should ensure we only ever complete when we read PARKED, right?
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 8d59b259af4a..e513b4600796 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2641,7 +2641,7 @@ prepare_task_switch(struct rq *rq, struct task_struct *prev,
>   * past. prev == current is still correct but we need to recalculate this_rq
>   * because prev may have moved to another CPU.
>   */
> -static struct rq *finish_task_switch(struct task_struct *prev)
> +static struct rq *finish_task_switch(struct task_struct *prev, bool preempt)
>  	__releases(rq->lock)
>  {
>  	struct rq *rq = this_rq();
> @@ -2674,7 +2674,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
>  	 *
>  	 * We must observe prev->state before clearing prev->on_cpu (in
>  	 * finish_task), otherwise a concurrent wakeup can get prev
> -	 * running on another CPU and we could rave with its RUNNING -> DEAD
> +	 * running on another CPU and we could race with its RUNNING -> DEAD
>  	 * transition, resulting in a double drop.
>  	 */
>  	prev_state = prev->state;
> @@ -2720,7 +2720,8 @@ static struct rq *finish_task_switch(struct task_struct *prev)
>  			break;
>
>  		case TASK_PARKED:
> -			kthread_park_complete(prev);
> +			if (!preempt)
> +				kthread_park_complete(prev);


Yes, but this won't fix the race decribed by Kohli...

Plus this complicates the schedule() paths for the very special case, and to me
it seems that all this kthread_park/unpark logic needs some serious cleanups...

Not that I can suggest something better right now.

Oleg.
