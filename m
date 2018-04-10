Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752054AbeDJWFv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 18:05:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:46404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751600AbeDJWFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 18:05:49 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6901421745
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Tue, 10 Apr 2018 18:05:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Zhou Chengming <zhouchengming1@huawei.com>
Cc: <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <peterz@infradead.org>, <huawei.libin@huawei.com>
Subject: Re: [PATCH] sched/rt.c: pick and check task if
 double_lock_balance() unlock the rq
Message-ID: <20180410180546.4159134c@gandalf.local.home>
In-Reply-To: <1505112709-102019-1-git-send-email-zhouchengming1@huawei.com>
References: <1505112709-102019-1-git-send-email-zhouchengming1@huawei.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Peter,

Going through my inbox, I stumbled across this one. And it doesn't
appear to be addressed.

I think this patch is a reasonable solution.

One small nit below though, but other than that.

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>


On Mon, 11 Sep 2017 14:51:49 +0800
Zhou Chengming <zhouchengming1@huawei.com> wrote:

> push_rt_task() pick the first pushable task and find an eligible
> lowest_rq, then double_lock_balance(rq, lowest_rq). So if
> double_lock_balance() unlock the rq (when double_lock_balance() return 1),
> we have to check if this task is still on the rq.
> 
> The problem is that the check conditions are not sufficient:
> 
> if (unlikely(task_rq(task) != rq ||
> 	     !cpumask_test_cpu(lowest_rq->cpu, &task->cpus_allowed) ||
> 	     task_running(rq, task) ||
> 	     !rt_task(task) ||
> 	     !task_on_rq_queued(task))) {
> 
> cpu2				cpu1			cpu0
> push_rt_task(rq1)
>   pick task_A on rq1
>   find rq0
>     double_lock_balance(rq1, rq0)
>       unlock(rq1)
> 				rq1 __schedule
> 				  pick task_A run
> 				task_A sleep (dequeued)
>       lock(rq0)
>       lock(rq1)
>     do_above_check(task_A)
>       task_rq(task_A) == rq1
>       cpus_allowed unchanged
>       task_running == false
>       rt_task(task_A) == true
> 							try_to_wake_up(task_A)
> 							  select_cpu = cpu3
> 							  enqueue(rq3, task_A)
> 							  task_A->on_rq = 1
>       task_on_rq_queued(task_A)
>     above_check passed, return rq0
>     ...
>     migrate task_A from rq1 to rq0
> 
> So we can't rely on these checks of task_A to make sure the task_A is
> still on the rq1, even though we hold the rq1->lock. This patch will
> repick the first pushable task to be sure the task is still on the rq.
> 
> Signed-off-by: Zhou Chengming <zhouchengming1@huawei.com>
> ---
>  kernel/sched/rt.c | 49 +++++++++++++++++++++++--------------------------
>  1 file changed, 23 insertions(+), 26 deletions(-)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 45caf93..787b721 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1703,6 +1703,26 @@ static int find_lowest_rq(struct task_struct *task)
>  	return -1;
>  }
>  
> +static struct task_struct *pick_next_pushable_task(struct rq *rq)
> +{
> +	struct task_struct *p;
> +
> +	if (!has_pushable_tasks(rq))
> +		return NULL;
> +
> +	p = plist_first_entry(&rq->rt.pushable_tasks,
> +			      struct task_struct, pushable_tasks);
> +
> +	BUG_ON(rq->cpu != task_cpu(p));
> +	BUG_ON(task_current(rq, p));
> +	BUG_ON(p->nr_cpus_allowed <= 1);
> +
> +	BUG_ON(!task_on_rq_queued(p));
> +	BUG_ON(!rt_task(p));
> +
> +	return p;
> +}
> +
>  /* Will lock the rq it finds */
>  static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
>  {
> @@ -1734,13 +1754,10 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
>  			 * We had to unlock the run queue. In
>  			 * the mean time, task could have
>  			 * migrated already or had its affinity changed.
> -			 * Also make sure that it wasn't scheduled on its rq.
>  			 */
> -			if (unlikely(task_rq(task) != rq ||
> -				     !cpumask_test_cpu(lowest_rq->cpu, &task->cpus_allowed) ||
> -				     task_running(rq, task) ||
> -				     !rt_task(task) ||
> -				     !task_on_rq_queued(task))) {
> +			struct task_struct *next_task = pick_next_pushable_task(rq);

I would put the above declaration before the above comment.

-- Steve

> +			if (unlikely(next_task != task ||
> +				     !cpumask_test_cpu(lowest_rq->cpu, &task->cpus_allowed))) {
>  
>  				double_unlock_balance(rq, lowest_rq);
>  				lowest_rq = NULL;
> @@ -1760,26 +1777,6 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
>  	return lowest_rq;
>  }
>  
> -static struct task_struct *pick_next_pushable_task(struct rq *rq)
> -{
> -	struct task_struct *p;
> -
> -	if (!has_pushable_tasks(rq))
> -		return NULL;
> -
> -	p = plist_first_entry(&rq->rt.pushable_tasks,
> -			      struct task_struct, pushable_tasks);
> -
> -	BUG_ON(rq->cpu != task_cpu(p));
> -	BUG_ON(task_current(rq, p));
> -	BUG_ON(p->nr_cpus_allowed <= 1);
> -
> -	BUG_ON(!task_on_rq_queued(p));
> -	BUG_ON(!rt_task(p));
> -
> -	return p;
> -}
> -
>  /*
>   * If the current CPU has more than one RT task, see if the non
>   * running task can migrate over to a CPU that is running a task
