Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9432EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 11:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BA3721479
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 11:10:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BA3721479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=santannapisa.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbeJJScf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 14:32:35 -0400
Received: from mail.sssup.it ([193.205.80.99]:52966 "EHLO mail.santannapisa.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726468AbeJJScf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 14:32:35 -0400
Received: from [10.30.3.207] (account l.abeni@santannapisa.it HELO luca64)
  by santannapisa.it (CommuniGate Pro SMTP 6.1.11)
  with ESMTPSA id 133570290; Wed, 10 Oct 2018 13:10:53 +0200
Date:   Wed, 10 Oct 2018 13:10:48 +0200
From:   luca abeni <luca.abeni@santannapisa.it>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        alessio.balsini@gmail.com, bristot@redhat.com, will.deacon@arm.com,
        andrea.parri@amarulasolutions.com, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com, henrik@austad.us,
        linux-rt-users@vger.kernel.org
Subject: Re: [RFD/RFC PATCH 5/8] sched: Add proxy execution
Message-ID: <20181010131048.54afd1b6@luca64>
In-Reply-To: <20181009092434.26221-6-juri.lelli@redhat.com>
References: <20181009092434.26221-1-juri.lelli@redhat.com>
        <20181009092434.26221-6-juri.lelli@redhat.com>
Organization: Scuola Superiore S. Anna
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue,  9 Oct 2018 11:24:31 +0200
Juri Lelli <juri.lelli@redhat.com> wrote:
[...]
> +migrate_task:
[...]
> +	put_prev_task(rq, next);
> +	if (rq->curr != rq->idle) {
> +		rq->proxy = rq->idle;
> +		set_tsk_need_resched(rq->idle);
> +		/*
> +		 * XXX [juril] don't we still need to migrate @next
> to
> +		 * @owner's CPU?
> +		 */
> +		return rq->idle;
> +	}

If I understand well, this code ends up migrating the task only if the
CPU was previously idle? (scheduling the idle task if the CPU was not
previously idle)

Out of curiosity (I admit this is my ignorance), why is this needed?
If I understand well, after scheduling the idle task the scheduler will
be invoked again (because of the set_tsk_need_resched(rq->idle)) but I
do not understand why it is not possible to migrate task "p" immediately
(I would just check "rq->curr != p", to avoid migrating the currently
scheduled task).


			Thanks,
				Luca

> +	rq->proxy = &fake_task;
> +
> +	for (; p; p = p->blocked_task) {
> +		int wake_cpu = p->wake_cpu;
> +
> +		WARN_ON(p == rq->curr);
> +
> +		p->on_rq = TASK_ON_RQ_MIGRATING;
> +		dequeue_task(rq, p, 0);
> +		set_task_cpu(p, that_cpu);
> +		/*
> +		 * We can abuse blocked_entry to migrate the thing,
> because @p is
> +		 * still on the rq.
> +		 */
> +		list_add(&p->blocked_entry, &migrate_list);
> +
> +		/*
> +		 * Preserve p->wake_cpu, such that we can tell where
> it
> +		 * used to run later.
> +		 */
> +		p->wake_cpu = wake_cpu;
> +	}
> +
> +	rq_unpin_lock(rq, rf);
> +	raw_spin_unlock(&rq->lock);
> +	raw_spin_lock(&that_rq->lock);
> +
> +	while (!list_empty(&migrate_list)) {
> +		p = list_first_entry(&migrate_list, struct
> task_struct, blocked_entry);
> +		list_del_init(&p->blocked_entry);
> +
> +		enqueue_task(that_rq, p, 0);
> +		check_preempt_curr(that_rq, p, 0);
> +		p->on_rq = TASK_ON_RQ_QUEUED;
> +		resched_curr(that_rq);
> +	}
> +
> +	raw_spin_unlock(&that_rq->lock);
> +	raw_spin_lock(&rq->lock);
> +	rq_repin_lock(rq, rf);
> +
> +	return NULL; /* Retry task selection on _this_ CPU. */
> +
> +owned_task:
> +	/*
> +	 * Its possible we interleave with mutex_unlock like:
> +	 *
> +	 *				lock(&rq->lock);
> +	 *				  proxy()
> +	 * mutex_unlock()
> +	 *   lock(&wait_lock);
> +	 *   next(owner) = current->blocked_task;
> +	 *   unlock(&wait_lock);
> +	 *
> +	 *   wake_up_q();
> +	 *     ...
> +	 *       ttwu_remote()
> +	 *         __task_rq_lock()
> +	 *				  lock(&wait_lock);
> +	 *				  owner == p
> +	 *
> +	 * Which leaves us to finish the ttwu_remote() and make it
> go.
> +	 *
> +	 * XXX is this happening in case of an HANDOFF to p?
> +	 * In any case, reading of the owner in
> __mutex_unlock_slowpath is
> +	 * done atomically outside wait_lock (only adding waiters to
> wake_q is
> +	 * done inside the critical section).
> +	 * Does this means we can get to proxy _w/o an owner_ if
> that was
> +	 * cleared before grabbing wait_lock? Do we account for this
> case?
> +	 * OK we actually do (see PROXY_EXEC ifdeffery in unlock
> function).
> +	 */
> +
> +	/*
> +	 * Finish wakeup, will make the contending ttwu do a
> +	 * _spurious_ wakeup, but all code should be able to
> +	 * deal with that.
> +	 */
> +	owner->blocked_on = NULL;
> +	owner->state = TASK_RUNNING;
> +	// XXX task_woken
> +
> +	/*
> +	 * If @owner/@p is allowed to run on this CPU, make it go.
> +	 */
> +	if (cpumask_test_cpu(this_cpu, &owner->cpus_allowed)) {
> +		raw_spin_unlock(&mutex->wait_lock);
> +		return owner;
> +	}
> +
> +	/*
> +	 * We have to let ttwu fix things up, because we
> +	 * can't restore the affinity. So dequeue.
> +	 */
> +	owner->on_rq = 0;
> +	deactivate_task(rq, p, DEQUEUE_SLEEP);
> +	goto blocked_task;
> +
> +blocked_task:
> +	/*
> +	 * If !@owner->on_rq, holding @rq->lock will not pin the
> task,
> +	 * so we cannot drop @mutex->wait_lock until we're sure its
> a blocked
> +	 * task on this rq.
> +	 *
> +	 * We use @owner->blocked_lock to serialize against
> ttwu_activate().
> +	 * Either we see its new owner->on_rq or it will see our
> list_add().
> +	 */
> +	raw_spin_lock(&owner->blocked_lock);
> +
> +	/*
> +	 * If we became runnable while waiting for blocked_lock,
> retry.
> +	 */
> +	if (owner->on_rq) {
> +		/*
> +		 * If we see the new on->rq, we must also see the
> new task_cpu().
> +		 */
> +		raw_spin_unlock(&owner->blocked_lock);
> +		goto retry_owner;
> +	}
> +
> +	/*
> +	 * Walk back up the blocked_task relation and enqueue them
> all on @owner
> +	 *
> +	 * ttwu_activate() will pick them up and place them on
> whatever rq
> +	 * @owner will run next.
> +	 */
> +	for (; p; p = p->blocked_task) {
> +		p->on_rq = 0;
> +		deactivate_task(rq, p, DEQUEUE_SLEEP);
> +		list_add(&p->blocked_entry, &owner->blocked_entry);
> +	}
> +	raw_spin_unlock(&owner->blocked_lock);
> +	raw_spin_unlock(&mutex->wait_lock);
> +
> +	return NULL; /* retry task selection */
> +}
> +#else /* PROXY_EXEC */
> +static struct task_struct *
> +proxy(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
> +{
> +	return next;
> +}
> +#endif /* PROXY_EXEC */
> +
>  /*
>   * __schedule() is the main scheduler function.
>   *
> @@ -3439,12 +3798,19 @@ static void __sched notrace __schedule(bool
> preempt) if (unlikely(signal_pending_state(prev->state, prev))) {
>  			prev->state = TASK_RUNNING;
>  		} else {
> -			deactivate_task(rq, prev, DEQUEUE_SLEEP |
> DEQUEUE_NOCLOCK);
> -			prev->on_rq = 0;
> -
> -			if (prev->in_iowait) {
> -				atomic_inc(&rq->nr_iowait);
> -				delayacct_blkio_start();
> +			if (!task_is_blocked(prev)) {
> +				prev->on_rq = 0;
> +				deactivate_task(rq, prev,
> DEQUEUE_SLEEP | DEQUEUE_NOCLOCK);
> +			} else {
> +				/*
> +				 * XXX
> +				 * Let's make this task, which is
> blocked on
> +				 * a mutex, (push/pull)able (RT/DL).
> +				 * Unfortunately we can only deal
> with that by
> +				 * means of a dequeue/enqueue
> cycle. :-/
> +				 */
> +				dequeue_task(rq, prev, 0);
> +				enqueue_task(rq, prev, 0);
>  			}
>  
>  			/*
> @@ -3463,7 +3829,23 @@ static void __sched notrace __schedule(bool
> preempt) switch_count = &prev->nvcsw;
>  	}
>  
> -	next = pick_next_task(rq, prev, &rf);
> +pick_again:
> +	/*
> +	 * If picked task is actually blocked it means that it can
> act as a
> +	 * proxy for the task that is holding the mutex picked task
> is blocked
> +	 * on. Get a reference to the blocked (going to be proxy)
> task here.
> +	 * Note that if next isn't actually blocked we will have
> rq->proxy ==
> +	 * rq->curr == next in the end, which is intended and means
> that proxy
> +	 * execution is currently "not in use".
> +	 */
> +	rq->proxy = next = pick_next_task(rq, rq->proxy, &rf);
> +	next->blocked_task = NULL;
> +	if (unlikely(task_is_blocked(next))) {
> +		next = proxy(rq, next, &rf);
> +		if (!next)
> +			goto pick_again;
> +	}
> +
>  	clear_tsk_need_resched(prev);
>  	clear_preempt_need_resched();
>  
> @@ -5441,7 +5823,7 @@ void init_idle(struct task_struct *idle, int
> cpu) __set_task_cpu(idle, cpu);
>  	rcu_read_unlock();
>  
> -	rq->curr = rq->idle = idle;
> +	rq->curr = rq->proxy = rq->idle = idle;
>  	idle->on_rq = TASK_ON_RQ_QUEUED;
>  #ifdef CONFIG_SMP
>  	idle->on_cpu = 1;
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 91e4202b0634..9336310c541d 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1499,7 +1499,7 @@ static void enqueue_task_dl(struct rq *rq,
> struct task_struct *p, int flags) 
>  	enqueue_dl_entity(&p->dl, pi_se, flags);
>  
> -	if (!task_current(rq, p) && p->nr_cpus_allowed > 1)
> +	if (!task_current(rq, p) && p->nr_cpus_allowed > 1
> && !task_is_blocked(p)) enqueue_pushable_dl_task(rq, p);
>  }
>  
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 7f8a5dcda923..3f9f60bdc1d6 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7043,6 +7043,9 @@ int can_migrate_task(struct task_struct *p,
> struct lb_env *env) 
>  	lockdep_assert_held(&env->src_rq->lock);
>  
> +	if (task_is_blocked(p))
> +		return 0;
> +
>  	/*
>  	 * We do not migrate tasks that are:
>  	 * 1) throttled_lb_pair, or
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 2e2955a8cf8f..9dada9e0d699 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1334,7 +1334,7 @@ enqueue_task_rt(struct rq *rq, struct
> task_struct *p, int flags) 
>  	enqueue_rt_entity(rt_se, flags);
>  
> -	if (!task_current(rq, p) && p->nr_cpus_allowed > 1)
> +	if (!task_current(rq, p) && p->nr_cpus_allowed > 1
> && !task_is_blocked(p)) enqueue_pushable_task(rq, p);
>  }
>  

