Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA31C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91DB92147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbfBSQNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:13:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58500 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbfBSQNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 11:13:47 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D773D8E59D;
        Tue, 19 Feb 2019 16:13:46 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8973D19C68;
        Tue, 19 Feb 2019 16:13:45 +0000 (UTC)
Date:   Tue, 19 Feb 2019 11:13:43 -0500
From:   Phil Auld <pauld@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        tim.c.chen@linux.intel.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com
Subject: Re: [RFC][PATCH 03/16] sched: Wrap rq::lock access
Message-ID: <20190219161343.GA10816@pauld.bos.csb>
References: <20190218165620.383905466@infradead.org>
 <20190218173514.064516553@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190218173514.064516553@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 19 Feb 2019 16:13:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 05:56:23PM +0100 Peter Zijlstra wrote:
> In preparation of playing games with rq->lock, abstract the thing
> using an accessor.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Hi Peter,

Sorry... what tree are these for?  They don't apply to mainline. 
Some branch on tip, I guess?


Thanks,
Phil



> ---
>  kernel/sched/core.c     |   44 ++++++++++----------
>  kernel/sched/deadline.c |   18 ++++----
>  kernel/sched/debug.c    |    4 -
>  kernel/sched/fair.c     |   41 +++++++++----------
>  kernel/sched/idle.c     |    4 -
>  kernel/sched/pelt.h     |    2 
>  kernel/sched/rt.c       |    8 +--
>  kernel/sched/sched.h    |  102 ++++++++++++++++++++++++------------------------
>  kernel/sched/topology.c |    4 -
>  9 files changed, 114 insertions(+), 113 deletions(-)
> 
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -72,12 +72,12 @@ struct rq *__task_rq_lock(struct task_st
>  
>  	for (;;) {
>  		rq = task_rq(p);
> -		raw_spin_lock(&rq->lock);
> +		raw_spin_lock(rq_lockp(rq));
>  		if (likely(rq == task_rq(p) && !task_on_rq_migrating(p))) {
>  			rq_pin_lock(rq, rf);
>  			return rq;
>  		}
> -		raw_spin_unlock(&rq->lock);
> +		raw_spin_unlock(rq_lockp(rq));
>  
>  		while (unlikely(task_on_rq_migrating(p)))
>  			cpu_relax();
> @@ -96,7 +96,7 @@ struct rq *task_rq_lock(struct task_stru
>  	for (;;) {
>  		raw_spin_lock_irqsave(&p->pi_lock, rf->flags);
>  		rq = task_rq(p);
> -		raw_spin_lock(&rq->lock);
> +		raw_spin_lock(rq_lockp(rq));
>  		/*
>  		 *	move_queued_task()		task_rq_lock()
>  		 *
> @@ -118,7 +118,7 @@ struct rq *task_rq_lock(struct task_stru
>  			rq_pin_lock(rq, rf);
>  			return rq;
>  		}
> -		raw_spin_unlock(&rq->lock);
> +		raw_spin_unlock(rq_lockp(rq));
>  		raw_spin_unlock_irqrestore(&p->pi_lock, rf->flags);
>  
>  		while (unlikely(task_on_rq_migrating(p)))
> @@ -188,7 +188,7 @@ void update_rq_clock(struct rq *rq)
>  {
>  	s64 delta;
>  
> -	lockdep_assert_held(&rq->lock);
> +	lockdep_assert_held(rq_lockp(rq));
>  
>  	if (rq->clock_update_flags & RQCF_ACT_SKIP)
>  		return;
> @@ -497,7 +497,7 @@ void resched_curr(struct rq *rq)
>  	struct task_struct *curr = rq->curr;
>  	int cpu;
>  
> -	lockdep_assert_held(&rq->lock);
> +	lockdep_assert_held(rq_lockp(rq));
>  
>  	if (test_tsk_need_resched(curr))
>  		return;
> @@ -521,10 +521,10 @@ void resched_cpu(int cpu)
>  	struct rq *rq = cpu_rq(cpu);
>  	unsigned long flags;
>  
> -	raw_spin_lock_irqsave(&rq->lock, flags);
> +	raw_spin_lock_irqsave(rq_lockp(rq), flags);
>  	if (cpu_online(cpu) || cpu == smp_processor_id())
>  		resched_curr(rq);
> -	raw_spin_unlock_irqrestore(&rq->lock, flags);
> +	raw_spin_unlock_irqrestore(rq_lockp(rq), flags);
>  }
>  
>  #ifdef CONFIG_SMP
> @@ -956,7 +956,7 @@ static inline bool is_cpu_allowed(struct
>  static struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
>  				   struct task_struct *p, int new_cpu)
>  {
> -	lockdep_assert_held(&rq->lock);
> +	lockdep_assert_held(rq_lockp(rq));
>  
>  	WRITE_ONCE(p->on_rq, TASK_ON_RQ_MIGRATING);
>  	dequeue_task(rq, p, DEQUEUE_NOCLOCK);
> @@ -1070,7 +1070,7 @@ void do_set_cpus_allowed(struct task_str
>  		 * Because __kthread_bind() calls this on blocked tasks without
>  		 * holding rq->lock.
>  		 */
> -		lockdep_assert_held(&rq->lock);
> +		lockdep_assert_held(rq_lockp(rq));
>  		dequeue_task(rq, p, DEQUEUE_SAVE | DEQUEUE_NOCLOCK);
>  	}
>  	if (running)
> @@ -1203,7 +1203,7 @@ void set_task_cpu(struct task_struct *p,
>  	 * task_rq_lock().
>  	 */
>  	WARN_ON_ONCE(debug_locks && !(lockdep_is_held(&p->pi_lock) ||
> -				      lockdep_is_held(&task_rq(p)->lock)));
> +				      lockdep_is_held(rq_lockp(task_rq(p)))));
>  #endif
>  	/*
>  	 * Clearly, migrating tasks to offline CPUs is a fairly daft thing.
> @@ -1732,7 +1732,7 @@ ttwu_do_activate(struct rq *rq, struct t
>  {
>  	int en_flags = ENQUEUE_WAKEUP | ENQUEUE_NOCLOCK;
>  
> -	lockdep_assert_held(&rq->lock);
> +	lockdep_assert_held(rq_lockp(rq));
>  
>  #ifdef CONFIG_SMP
>  	if (p->sched_contributes_to_load)
> @@ -2123,7 +2123,7 @@ static void try_to_wake_up_local(struct
>  	    WARN_ON_ONCE(p == current))
>  		return;
>  
> -	lockdep_assert_held(&rq->lock);
> +	lockdep_assert_held(rq_lockp(rq));
>  
>  	if (!raw_spin_trylock(&p->pi_lock)) {
>  		/*
> @@ -2606,10 +2606,10 @@ prepare_lock_switch(struct rq *rq, struc
>  	 * do an early lockdep release here:
>  	 */
>  	rq_unpin_lock(rq, rf);
> -	spin_release(&rq->lock.dep_map, 1, _THIS_IP_);
> +	spin_release(&rq_lockp(rq)->dep_map, 1, _THIS_IP_);
>  #ifdef CONFIG_DEBUG_SPINLOCK
>  	/* this is a valid case when another task releases the spinlock */
> -	rq->lock.owner = next;
> +	rq_lockp(rq)->owner = next;
>  #endif
>  }
>  
> @@ -2620,8 +2620,8 @@ static inline void finish_lock_switch(st
>  	 * fix up the runqueue lock - which gets 'carried over' from
>  	 * prev into current:
>  	 */
> -	spin_acquire(&rq->lock.dep_map, 0, 0, _THIS_IP_);
> -	raw_spin_unlock_irq(&rq->lock);
> +	spin_acquire(&rq_lockp(rq)->dep_map, 0, 0, _THIS_IP_);
> +	raw_spin_unlock_irq(rq_lockp(rq));
>  }
>  
>  /*
> @@ -2771,7 +2771,7 @@ static void __balance_callback(struct rq
>  	void (*func)(struct rq *rq);
>  	unsigned long flags;
>  
> -	raw_spin_lock_irqsave(&rq->lock, flags);
> +	raw_spin_lock_irqsave(rq_lockp(rq), flags);
>  	head = rq->balance_callback;
>  	rq->balance_callback = NULL;
>  	while (head) {
> @@ -2782,7 +2782,7 @@ static void __balance_callback(struct rq
>  
>  		func(rq);
>  	}
> -	raw_spin_unlock_irqrestore(&rq->lock, flags);
> +	raw_spin_unlock_irqrestore(rq_lockp(rq), flags);
>  }
>  
>  static inline void balance_callback(struct rq *rq)
> @@ -5411,7 +5411,7 @@ void init_idle(struct task_struct *idle,
>  	unsigned long flags;
>  
>  	raw_spin_lock_irqsave(&idle->pi_lock, flags);
> -	raw_spin_lock(&rq->lock);
> +	raw_spin_lock(rq_lockp(rq));
>  
>  	__sched_fork(0, idle);
>  	idle->state = TASK_RUNNING;
> @@ -5448,7 +5448,7 @@ void init_idle(struct task_struct *idle,
>  #ifdef CONFIG_SMP
>  	idle->on_cpu = 1;
>  #endif
> -	raw_spin_unlock(&rq->lock);
> +	raw_spin_unlock(rq_lockp(rq));
>  	raw_spin_unlock_irqrestore(&idle->pi_lock, flags);
>  
>  	/* Set the preempt count _outside_ the spinlocks! */
> @@ -6016,7 +6016,7 @@ void __init sched_init(void)
>  		struct rq *rq;
>  
>  		rq = cpu_rq(i);
> -		raw_spin_lock_init(&rq->lock);
> +		raw_spin_lock_init(&rq->__lock);
>  		rq->nr_running = 0;
>  		rq->calc_load_active = 0;
>  		rq->calc_load_update = jiffies + LOAD_FREQ;
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -80,7 +80,7 @@ void __add_running_bw(u64 dl_bw, struct
>  {
>  	u64 old = dl_rq->running_bw;
>  
> -	lockdep_assert_held(&(rq_of_dl_rq(dl_rq))->lock);
> +	lockdep_assert_held(rq_lockp((rq_of_dl_rq(dl_rq))));
>  	dl_rq->running_bw += dl_bw;
>  	SCHED_WARN_ON(dl_rq->running_bw < old); /* overflow */
>  	SCHED_WARN_ON(dl_rq->running_bw > dl_rq->this_bw);
> @@ -93,7 +93,7 @@ void __sub_running_bw(u64 dl_bw, struct
>  {
>  	u64 old = dl_rq->running_bw;
>  
> -	lockdep_assert_held(&(rq_of_dl_rq(dl_rq))->lock);
> +	lockdep_assert_held(rq_lockp((rq_of_dl_rq(dl_rq))));
>  	dl_rq->running_bw -= dl_bw;
>  	SCHED_WARN_ON(dl_rq->running_bw > old); /* underflow */
>  	if (dl_rq->running_bw > old)
> @@ -107,7 +107,7 @@ void __add_rq_bw(u64 dl_bw, struct dl_rq
>  {
>  	u64 old = dl_rq->this_bw;
>  
> -	lockdep_assert_held(&(rq_of_dl_rq(dl_rq))->lock);
> +	lockdep_assert_held(rq_lockp((rq_of_dl_rq(dl_rq))));
>  	dl_rq->this_bw += dl_bw;
>  	SCHED_WARN_ON(dl_rq->this_bw < old); /* overflow */
>  }
> @@ -117,7 +117,7 @@ void __sub_rq_bw(u64 dl_bw, struct dl_rq
>  {
>  	u64 old = dl_rq->this_bw;
>  
> -	lockdep_assert_held(&(rq_of_dl_rq(dl_rq))->lock);
> +	lockdep_assert_held(rq_lockp((rq_of_dl_rq(dl_rq))));
>  	dl_rq->this_bw -= dl_bw;
>  	SCHED_WARN_ON(dl_rq->this_bw > old); /* underflow */
>  	if (dl_rq->this_bw > old)
> @@ -893,7 +893,7 @@ static int start_dl_timer(struct task_st
>  	ktime_t now, act;
>  	s64 delta;
>  
> -	lockdep_assert_held(&rq->lock);
> +	lockdep_assert_held(rq_lockp(rq));
>  
>  	/*
>  	 * We want the timer to fire at the deadline, but considering
> @@ -1003,9 +1003,9 @@ static enum hrtimer_restart dl_task_time
>  		 * If the runqueue is no longer available, migrate the
>  		 * task elsewhere. This necessarily changes rq.
>  		 */
> -		lockdep_unpin_lock(&rq->lock, rf.cookie);
> +		lockdep_unpin_lock(rq_lockp(rq), rf.cookie);
>  		rq = dl_task_offline_migration(rq, p);
> -		rf.cookie = lockdep_pin_lock(&rq->lock);
> +		rf.cookie = lockdep_pin_lock(rq_lockp(rq));
>  		update_rq_clock(rq);
>  
>  		/*
> @@ -1620,7 +1620,7 @@ static void migrate_task_rq_dl(struct ta
>  	 * from try_to_wake_up(). Hence, p->pi_lock is locked, but
>  	 * rq->lock is not... So, lock it
>  	 */
> -	raw_spin_lock(&rq->lock);
> +	raw_spin_lock(rq_lockp(rq));
>  	if (p->dl.dl_non_contending) {
>  		sub_running_bw(&p->dl, &rq->dl);
>  		p->dl.dl_non_contending = 0;
> @@ -1635,7 +1635,7 @@ static void migrate_task_rq_dl(struct ta
>  			put_task_struct(p);
>  	}
>  	sub_rq_bw(&p->dl, &rq->dl);
> -	raw_spin_unlock(&rq->lock);
> +	raw_spin_unlock(rq_lockp(rq));
>  }
>  
>  static void check_preempt_equal_dl(struct rq *rq, struct task_struct *p)
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -515,7 +515,7 @@ void print_cfs_rq(struct seq_file *m, in
>  	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "exec_clock",
>  			SPLIT_NS(cfs_rq->exec_clock));
>  
> -	raw_spin_lock_irqsave(&rq->lock, flags);
> +	raw_spin_lock_irqsave(rq_lockp(rq), flags);
>  	if (rb_first_cached(&cfs_rq->tasks_timeline))
>  		MIN_vruntime = (__pick_first_entity(cfs_rq))->vruntime;
>  	last = __pick_last_entity(cfs_rq);
> @@ -523,7 +523,7 @@ void print_cfs_rq(struct seq_file *m, in
>  		max_vruntime = last->vruntime;
>  	min_vruntime = cfs_rq->min_vruntime;
>  	rq0_min_vruntime = cpu_rq(0)->cfs.min_vruntime;
> -	raw_spin_unlock_irqrestore(&rq->lock, flags);
> +	raw_spin_unlock_irqrestore(rq_lockp(rq), flags);
>  	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "MIN_vruntime",
>  			SPLIT_NS(MIN_vruntime));
>  	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "min_vruntime",
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4966,7 +4966,7 @@ static void __maybe_unused update_runtim
>  {
>  	struct task_group *tg;
>  
> -	lockdep_assert_held(&rq->lock);
> +	lockdep_assert_held(rq_lockp(rq));
>  
>  	rcu_read_lock();
>  	list_for_each_entry_rcu(tg, &task_groups, list) {
> @@ -4985,7 +4985,7 @@ static void __maybe_unused unthrottle_of
>  {
>  	struct task_group *tg;
>  
> -	lockdep_assert_held(&rq->lock);
> +	lockdep_assert_held(rq_lockp(rq));
>  
>  	rcu_read_lock();
>  	list_for_each_entry_rcu(tg, &task_groups, list) {
> @@ -6743,7 +6743,7 @@ static void migrate_task_rq_fair(struct
>  		 * In case of TASK_ON_RQ_MIGRATING we in fact hold the 'old'
>  		 * rq->lock and can modify state directly.
>  		 */
> -		lockdep_assert_held(&task_rq(p)->lock);
> +		lockdep_assert_held(rq_lockp(task_rq(p)));
>  		detach_entity_cfs_rq(&p->se);
>  
>  	} else {
> @@ -7317,7 +7317,7 @@ static int task_hot(struct task_struct *
>  {
>  	s64 delta;
>  
> -	lockdep_assert_held(&env->src_rq->lock);
> +	lockdep_assert_held(rq_lockp(env->src_rq));
>  
>  	if (p->sched_class != &fair_sched_class)
>  		return 0;
> @@ -7411,7 +7411,7 @@ int can_migrate_task(struct task_struct
>  {
>  	int tsk_cache_hot;
>  
> -	lockdep_assert_held(&env->src_rq->lock);
> +	lockdep_assert_held(rq_lockp(env->src_rq));
>  
>  	/*
>  	 * We do not migrate tasks that are:
> @@ -7489,7 +7489,7 @@ int can_migrate_task(struct task_struct
>   */
>  static void detach_task(struct task_struct *p, struct lb_env *env)
>  {
> -	lockdep_assert_held(&env->src_rq->lock);
> +	lockdep_assert_held(rq_lockp(env->src_rq));
>  
>  	p->on_rq = TASK_ON_RQ_MIGRATING;
>  	deactivate_task(env->src_rq, p, DEQUEUE_NOCLOCK);
> @@ -7506,7 +7506,7 @@ static struct task_struct *detach_one_ta
>  {
>  	struct task_struct *p;
>  
> -	lockdep_assert_held(&env->src_rq->lock);
> +	lockdep_assert_held(rq_lockp(env->src_rq));
>  
>  	list_for_each_entry_reverse(p,
>  			&env->src_rq->cfs_tasks, se.group_node) {
> @@ -7542,7 +7542,7 @@ static int detach_tasks(struct lb_env *e
>  	unsigned long load;
>  	int detached = 0;
>  
> -	lockdep_assert_held(&env->src_rq->lock);
> +	lockdep_assert_held(rq_lockp(env->src_rq));
>  
>  	if (env->imbalance <= 0)
>  		return 0;
> @@ -7623,7 +7623,7 @@ static int detach_tasks(struct lb_env *e
>   */
>  static void attach_task(struct rq *rq, struct task_struct *p)
>  {
> -	lockdep_assert_held(&rq->lock);
> +	lockdep_assert_held(rq_lockp(rq));
>  
>  	BUG_ON(task_rq(p) != rq);
>  	activate_task(rq, p, ENQUEUE_NOCLOCK);
> @@ -9164,7 +9164,7 @@ static int load_balance(int this_cpu, st
>  		if (need_active_balance(&env)) {
>  			unsigned long flags;
>  
> -			raw_spin_lock_irqsave(&busiest->lock, flags);
> +			raw_spin_lock_irqsave(rq_lockp(busiest), flags);
>  
>  			/*
>  			 * Don't kick the active_load_balance_cpu_stop,
> @@ -9172,8 +9172,7 @@ static int load_balance(int this_cpu, st
>  			 * moved to this_cpu:
>  			 */
>  			if (!cpumask_test_cpu(this_cpu, &busiest->curr->cpus_allowed)) {
> -				raw_spin_unlock_irqrestore(&busiest->lock,
> -							    flags);
> +				raw_spin_unlock_irqrestore(rq_lockp(busiest), flags);
>  				env.flags |= LBF_ALL_PINNED;
>  				goto out_one_pinned;
>  			}
> @@ -9188,7 +9187,7 @@ static int load_balance(int this_cpu, st
>  				busiest->push_cpu = this_cpu;
>  				active_balance = 1;
>  			}
> -			raw_spin_unlock_irqrestore(&busiest->lock, flags);
> +			raw_spin_unlock_irqrestore(rq_lockp(busiest), flags);
>  
>  			if (active_balance) {
>  				stop_one_cpu_nowait(cpu_of(busiest),
> @@ -9897,7 +9896,7 @@ static void nohz_newidle_balance(struct
>  	    time_before(jiffies, READ_ONCE(nohz.next_blocked)))
>  		return;
>  
> -	raw_spin_unlock(&this_rq->lock);
> +	raw_spin_unlock(rq_lockp(this_rq));
>  	/*
>  	 * This CPU is going to be idle and blocked load of idle CPUs
>  	 * need to be updated. Run the ilb locally as it is a good
> @@ -9906,7 +9905,7 @@ static void nohz_newidle_balance(struct
>  	 */
>  	if (!_nohz_idle_balance(this_rq, NOHZ_STATS_KICK, CPU_NEWLY_IDLE))
>  		kick_ilb(NOHZ_STATS_KICK);
> -	raw_spin_lock(&this_rq->lock);
> +	raw_spin_lock(rq_lockp(this_rq));
>  }
>  
>  #else /* !CONFIG_NO_HZ_COMMON */
> @@ -9966,7 +9965,7 @@ static int idle_balance(struct rq *this_
>  		goto out;
>  	}
>  
> -	raw_spin_unlock(&this_rq->lock);
> +	raw_spin_unlock(rq_lockp(this_rq));
>  
>  	update_blocked_averages(this_cpu);
>  	rcu_read_lock();
> @@ -10007,7 +10006,7 @@ static int idle_balance(struct rq *this_
>  	}
>  	rcu_read_unlock();
>  
> -	raw_spin_lock(&this_rq->lock);
> +	raw_spin_lock(rq_lockp(this_rq));
>  
>  	if (curr_cost > this_rq->max_idle_balance_cost)
>  		this_rq->max_idle_balance_cost = curr_cost;
> @@ -10443,11 +10442,11 @@ void online_fair_sched_group(struct task
>  		rq = cpu_rq(i);
>  		se = tg->se[i];
>  
> -		raw_spin_lock_irq(&rq->lock);
> +		raw_spin_lock_irq(rq_lockp(rq));
>  		update_rq_clock(rq);
>  		attach_entity_cfs_rq(se);
>  		sync_throttle(tg, i);
> -		raw_spin_unlock_irq(&rq->lock);
> +		raw_spin_unlock_irq(rq_lockp(rq));
>  	}
>  }
>  
> @@ -10470,9 +10469,9 @@ void unregister_fair_sched_group(struct
>  
>  		rq = cpu_rq(cpu);
>  
> -		raw_spin_lock_irqsave(&rq->lock, flags);
> +		raw_spin_lock_irqsave(rq_lockp(rq), flags);
>  		list_del_leaf_cfs_rq(tg->cfs_rq[cpu]);
> -		raw_spin_unlock_irqrestore(&rq->lock, flags);
> +		raw_spin_unlock_irqrestore(rq_lockp(rq), flags);
>  	}
>  }
>  
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -390,10 +390,10 @@ pick_next_task_idle(struct rq *rq, struc
>  static void
>  dequeue_task_idle(struct rq *rq, struct task_struct *p, int flags)
>  {
> -	raw_spin_unlock_irq(&rq->lock);
> +	raw_spin_unlock_irq(rq_lockp(rq));
>  	printk(KERN_ERR "bad: scheduling from the idle thread!\n");
>  	dump_stack();
> -	raw_spin_lock_irq(&rq->lock);
> +	raw_spin_lock_irq(rq_lockp(rq));
>  }
>  
>  static void put_prev_task_idle(struct rq *rq, struct task_struct *prev)
> --- a/kernel/sched/pelt.h
> +++ b/kernel/sched/pelt.h
> @@ -116,7 +116,7 @@ static inline void update_idle_rq_clock_
>  
>  static inline u64 rq_clock_pelt(struct rq *rq)
>  {
> -	lockdep_assert_held(&rq->lock);
> +	lockdep_assert_held(rq_lockp(rq));
>  	assert_clock_updated(rq);
>  
>  	return rq->clock_pelt - rq->lost_idle_time;
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -845,7 +845,7 @@ static int do_sched_rt_period_timer(stru
>  		if (skip)
>  			continue;
>  
> -		raw_spin_lock(&rq->lock);
> +		raw_spin_lock(rq_lockp(rq));
>  		update_rq_clock(rq);
>  
>  		if (rt_rq->rt_time) {
> @@ -883,7 +883,7 @@ static int do_sched_rt_period_timer(stru
>  
>  		if (enqueue)
>  			sched_rt_rq_enqueue(rt_rq);
> -		raw_spin_unlock(&rq->lock);
> +		raw_spin_unlock(rq_lockp(rq));
>  	}
>  
>  	if (!throttled && (!rt_bandwidth_enabled() || rt_b->rt_runtime == RUNTIME_INF))
> @@ -2034,9 +2034,9 @@ void rto_push_irq_work_func(struct irq_w
>  	 * When it gets updated, a check is made if a push is possible.
>  	 */
>  	if (has_pushable_tasks(rq)) {
> -		raw_spin_lock(&rq->lock);
> +		raw_spin_lock(rq_lockp(rq));
>  		push_rt_tasks(rq);
> -		raw_spin_unlock(&rq->lock);
> +		raw_spin_unlock(rq_lockp(rq));
>  	}
>  
>  	raw_spin_lock(&rd->rto_lock);
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -806,7 +806,7 @@ extern void rto_push_irq_work_func(struc
>   */
>  struct rq {
>  	/* runqueue lock: */
> -	raw_spinlock_t		lock;
> +	raw_spinlock_t		__lock;
>  
>  	/*
>  	 * nr_running and cpu_load should be in the same cacheline because
> @@ -979,6 +979,10 @@ static inline int cpu_of(struct rq *rq)
>  #endif
>  }
>  
> +static inline raw_spinlock_t *rq_lockp(struct rq *rq)
> +{
> +	return &rq->__lock;
> +}
>  
>  #ifdef CONFIG_SCHED_SMT
>  extern void __update_idle_core(struct rq *rq);
> @@ -1046,7 +1050,7 @@ static inline void assert_clock_updated(
>  
>  static inline u64 rq_clock(struct rq *rq)
>  {
> -	lockdep_assert_held(&rq->lock);
> +	lockdep_assert_held(rq_lockp(rq));
>  	assert_clock_updated(rq);
>  
>  	return rq->clock;
> @@ -1054,7 +1058,7 @@ static inline u64 rq_clock(struct rq *rq
>  
>  static inline u64 rq_clock_task(struct rq *rq)
>  {
> -	lockdep_assert_held(&rq->lock);
> +	lockdep_assert_held(rq_lockp(rq));
>  	assert_clock_updated(rq);
>  
>  	return rq->clock_task;
> @@ -1062,7 +1066,7 @@ static inline u64 rq_clock_task(struct r
>  
>  static inline void rq_clock_skip_update(struct rq *rq)
>  {
> -	lockdep_assert_held(&rq->lock);
> +	lockdep_assert_held(rq_lockp(rq));
>  	rq->clock_update_flags |= RQCF_REQ_SKIP;
>  }
>  
> @@ -1072,7 +1076,7 @@ static inline void rq_clock_skip_update(
>   */
>  static inline void rq_clock_cancel_skipupdate(struct rq *rq)
>  {
> -	lockdep_assert_held(&rq->lock);
> +	lockdep_assert_held(rq_lockp(rq));
>  	rq->clock_update_flags &= ~RQCF_REQ_SKIP;
>  }
>  
> @@ -1091,7 +1095,7 @@ struct rq_flags {
>  
>  static inline void rq_pin_lock(struct rq *rq, struct rq_flags *rf)
>  {
> -	rf->cookie = lockdep_pin_lock(&rq->lock);
> +	rf->cookie = lockdep_pin_lock(rq_lockp(rq));
>  
>  #ifdef CONFIG_SCHED_DEBUG
>  	rq->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
> @@ -1106,12 +1110,12 @@ static inline void rq_unpin_lock(struct
>  		rf->clock_update_flags = RQCF_UPDATED;
>  #endif
>  
> -	lockdep_unpin_lock(&rq->lock, rf->cookie);
> +	lockdep_unpin_lock(rq_lockp(rq), rf->cookie);
>  }
>  
>  static inline void rq_repin_lock(struct rq *rq, struct rq_flags *rf)
>  {
> -	lockdep_repin_lock(&rq->lock, rf->cookie);
> +	lockdep_repin_lock(rq_lockp(rq), rf->cookie);
>  
>  #ifdef CONFIG_SCHED_DEBUG
>  	/*
> @@ -1132,7 +1136,7 @@ static inline void __task_rq_unlock(stru
>  	__releases(rq->lock)
>  {
>  	rq_unpin_lock(rq, rf);
> -	raw_spin_unlock(&rq->lock);
> +	raw_spin_unlock(rq_lockp(rq));
>  }
>  
>  static inline void
> @@ -1141,7 +1145,7 @@ task_rq_unlock(struct rq *rq, struct tas
>  	__releases(p->pi_lock)
>  {
>  	rq_unpin_lock(rq, rf);
> -	raw_spin_unlock(&rq->lock);
> +	raw_spin_unlock(rq_lockp(rq));
>  	raw_spin_unlock_irqrestore(&p->pi_lock, rf->flags);
>  }
>  
> @@ -1149,7 +1153,7 @@ static inline void
>  rq_lock_irqsave(struct rq *rq, struct rq_flags *rf)
>  	__acquires(rq->lock)
>  {
> -	raw_spin_lock_irqsave(&rq->lock, rf->flags);
> +	raw_spin_lock_irqsave(rq_lockp(rq), rf->flags);
>  	rq_pin_lock(rq, rf);
>  }
>  
> @@ -1157,7 +1161,7 @@ static inline void
>  rq_lock_irq(struct rq *rq, struct rq_flags *rf)
>  	__acquires(rq->lock)
>  {
> -	raw_spin_lock_irq(&rq->lock);
> +	raw_spin_lock_irq(rq_lockp(rq));
>  	rq_pin_lock(rq, rf);
>  }
>  
> @@ -1165,7 +1169,7 @@ static inline void
>  rq_lock(struct rq *rq, struct rq_flags *rf)
>  	__acquires(rq->lock)
>  {
> -	raw_spin_lock(&rq->lock);
> +	raw_spin_lock(rq_lockp(rq));
>  	rq_pin_lock(rq, rf);
>  }
>  
> @@ -1173,7 +1177,7 @@ static inline void
>  rq_relock(struct rq *rq, struct rq_flags *rf)
>  	__acquires(rq->lock)
>  {
> -	raw_spin_lock(&rq->lock);
> +	raw_spin_lock(rq_lockp(rq));
>  	rq_repin_lock(rq, rf);
>  }
>  
> @@ -1182,7 +1186,7 @@ rq_unlock_irqrestore(struct rq *rq, stru
>  	__releases(rq->lock)
>  {
>  	rq_unpin_lock(rq, rf);
> -	raw_spin_unlock_irqrestore(&rq->lock, rf->flags);
> +	raw_spin_unlock_irqrestore(rq_lockp(rq), rf->flags);
>  }
>  
>  static inline void
> @@ -1190,7 +1194,7 @@ rq_unlock_irq(struct rq *rq, struct rq_f
>  	__releases(rq->lock)
>  {
>  	rq_unpin_lock(rq, rf);
> -	raw_spin_unlock_irq(&rq->lock);
> +	raw_spin_unlock_irq(rq_lockp(rq));
>  }
>  
>  static inline void
> @@ -1198,7 +1202,7 @@ rq_unlock(struct rq *rq, struct rq_flags
>  	__releases(rq->lock)
>  {
>  	rq_unpin_lock(rq, rf);
> -	raw_spin_unlock(&rq->lock);
> +	raw_spin_unlock(rq_lockp(rq));
>  }
>  
>  static inline struct rq *
> @@ -1261,7 +1265,7 @@ queue_balance_callback(struct rq *rq,
>  		       struct callback_head *head,
>  		       void (*func)(struct rq *rq))
>  {
> -	lockdep_assert_held(&rq->lock);
> +	lockdep_assert_held(rq_lockp(rq));
>  
>  	if (unlikely(head->next))
>  		return;
> @@ -1917,7 +1921,7 @@ static inline int _double_lock_balance(s
>  	__acquires(busiest->lock)
>  	__acquires(this_rq->lock)
>  {
> -	raw_spin_unlock(&this_rq->lock);
> +	raw_spin_unlock(rq_lockp(this_rq));
>  	double_rq_lock(this_rq, busiest);
>  
>  	return 1;
> @@ -1936,20 +1940,22 @@ static inline int _double_lock_balance(s
>  	__acquires(busiest->lock)
>  	__acquires(this_rq->lock)
>  {
> -	int ret = 0;
> +	if (rq_lockp(this_rq) == rq_lockp(busiest))
> +		return 0;
>  
> -	if (unlikely(!raw_spin_trylock(&busiest->lock))) {
> -		if (busiest < this_rq) {
> -			raw_spin_unlock(&this_rq->lock);
> -			raw_spin_lock(&busiest->lock);
> -			raw_spin_lock_nested(&this_rq->lock,
> -					      SINGLE_DEPTH_NESTING);
> -			ret = 1;
> -		} else
> -			raw_spin_lock_nested(&busiest->lock,
> -					      SINGLE_DEPTH_NESTING);
> +	if (likely(raw_spin_trylock(rq_lockp(busiest))))
> +		return 0;
> +
> +	if (busiest >= this_rq) {
> +		raw_spin_lock_nested(rq_lockp(busiest), SINGLE_DEPTH_NESTING);
> +		return 0;
>  	}
> -	return ret;
> +
> +	raw_spin_unlock(rq_lockp(this_rq));
> +	raw_spin_lock(rq_lockp(busiest));
> +	raw_spin_lock_nested(rq_lockp(this_rq), SINGLE_DEPTH_NESTING);
> +
> +	return 1;
>  }
>  
>  #endif /* CONFIG_PREEMPT */
> @@ -1959,20 +1965,16 @@ static inline int _double_lock_balance(s
>   */
>  static inline int double_lock_balance(struct rq *this_rq, struct rq *busiest)
>  {
> -	if (unlikely(!irqs_disabled())) {
> -		/* printk() doesn't work well under rq->lock */
> -		raw_spin_unlock(&this_rq->lock);
> -		BUG_ON(1);
> -	}
> -
> +	lockdep_assert_irqs_disabled();
>  	return _double_lock_balance(this_rq, busiest);
>  }
>  
>  static inline void double_unlock_balance(struct rq *this_rq, struct rq *busiest)
>  	__releases(busiest->lock)
>  {
> -	raw_spin_unlock(&busiest->lock);
> -	lock_set_subclass(&this_rq->lock.dep_map, 0, _RET_IP_);
> +	if (rq_lockp(this_rq) != rq_lockp(busiest))
> +		raw_spin_unlock(rq_lockp(busiest));
> +	lock_set_subclass(&rq_lockp(this_rq)->dep_map, 0, _RET_IP_);
>  }
>  
>  static inline void double_lock(spinlock_t *l1, spinlock_t *l2)
> @@ -2013,16 +2015,16 @@ static inline void double_rq_lock(struct
>  	__acquires(rq2->lock)
>  {
>  	BUG_ON(!irqs_disabled());
> -	if (rq1 == rq2) {
> -		raw_spin_lock(&rq1->lock);
> +	if (rq_lockp(rq1) == rq_lockp(rq2)) {
> +		raw_spin_lock(rq_lockp(rq1));
>  		__acquire(rq2->lock);	/* Fake it out ;) */
>  	} else {
>  		if (rq1 < rq2) {
> -			raw_spin_lock(&rq1->lock);
> -			raw_spin_lock_nested(&rq2->lock, SINGLE_DEPTH_NESTING);
> +			raw_spin_lock(rq_lockp(rq1));
> +			raw_spin_lock_nested(rq_lockp(rq2), SINGLE_DEPTH_NESTING);
>  		} else {
> -			raw_spin_lock(&rq2->lock);
> -			raw_spin_lock_nested(&rq1->lock, SINGLE_DEPTH_NESTING);
> +			raw_spin_lock(rq_lockp(rq2));
> +			raw_spin_lock_nested(rq_lockp(rq1), SINGLE_DEPTH_NESTING);
>  		}
>  	}
>  }
> @@ -2037,9 +2039,9 @@ static inline void double_rq_unlock(stru
>  	__releases(rq1->lock)
>  	__releases(rq2->lock)
>  {
> -	raw_spin_unlock(&rq1->lock);
> -	if (rq1 != rq2)
> -		raw_spin_unlock(&rq2->lock);
> +	raw_spin_unlock(rq_lockp(rq1));
> +	if (rq_lockp(rq1) != rq_lockp(rq2))
> +		raw_spin_unlock(rq_lockp(rq2));
>  	else
>  		__release(rq2->lock);
>  }
> @@ -2062,7 +2064,7 @@ static inline void double_rq_lock(struct
>  {
>  	BUG_ON(!irqs_disabled());
>  	BUG_ON(rq1 != rq2);
> -	raw_spin_lock(&rq1->lock);
> +	raw_spin_lock(rq_lockp(rq1));
>  	__acquire(rq2->lock);	/* Fake it out ;) */
>  }
>  
> @@ -2077,7 +2079,7 @@ static inline void double_rq_unlock(stru
>  	__releases(rq2->lock)
>  {
>  	BUG_ON(rq1 != rq2);
> -	raw_spin_unlock(&rq1->lock);
> +	raw_spin_unlock(rq_lockp(rq1));
>  	__release(rq2->lock);
>  }
>  
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -442,7 +442,7 @@ void rq_attach_root(struct rq *rq, struc
>  	struct root_domain *old_rd = NULL;
>  	unsigned long flags;
>  
> -	raw_spin_lock_irqsave(&rq->lock, flags);
> +	raw_spin_lock_irqsave(rq_lockp(rq), flags);
>  
>  	if (rq->rd) {
>  		old_rd = rq->rd;
> @@ -468,7 +468,7 @@ void rq_attach_root(struct rq *rq, struc
>  	if (cpumask_test_cpu(rq->cpu, cpu_active_mask))
>  		set_rq_online(rq);
>  
> -	raw_spin_unlock_irqrestore(&rq->lock, flags);
> +	raw_spin_unlock_irqrestore(rq_lockp(rq), flags);
>  
>  	if (old_rd)
>  		call_rcu(&old_rd->rcu, free_rootdomain);
> 
> 

-- 
