Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B95C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 09:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABF2F204EC
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 09:25:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABF2F204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbeJIQlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 12:41:15 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45693 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbeJIQlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 12:41:14 -0400
Received: by mail-wr1-f65.google.com with SMTP id q5-v6so983767wrw.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 02:25:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+cjCeGEsALGT85+w1aNXsrRxI3c/zOrYhv/6cRh9D2E=;
        b=HPixmj4JKOEYE/ASmhxfSHny8A5yANa6Yy7Bukm+2CaFcaAjSx7AP9kZqF/0EUi0Zn
         J77qetlK6CcreupJ5cGtAJk2CNJTpuUZzRwrTvophwHC8y+iTM46t1gU8W/HJqi0tXEW
         L6SRdxCsxYwTswEagLIN4HvITo/1/2YIfLqklK//mfBbUkkCPysgW/E5v6Ym6hEmirBO
         t+roPVUIpRZBBo4yotzskEkY3rvEiQgDMQ7FnxVb8luq/Jhdt3LIygzl7XEmncOzZTTd
         +qV1h1vIk2PtbYs9B45KVwNF5Wvl7fJQF4feZGR6rFWzQQWlvU9yKgjmop9j+MiAo4ES
         bO+Q==
X-Gm-Message-State: ABuFfohxToMXxEk/DD5TYSbY9+lXpH67EUvt6Ta+bNrYCQtfm4rQMnCd
        UnTiVB6ykGIFDyTsMR2cC+yAkg==
X-Google-Smtp-Source: ACcGV63dbNIiOAcrpl1sxv8ihWbuDiKgnnPQsxARdMLIFGQtshzi6Tl88sJ8D+IiSyv7F0el0NMLAg==
X-Received: by 2002:adf:fbce:: with SMTP id d14-v6mr7340495wrs.253.1539077113643;
        Tue, 09 Oct 2018 02:25:13 -0700 (PDT)
Received: from localhost.localdomain.Speedport_W_921V_1_44_000 (p200300EF2BD31613C1F2E846AEDA540D.dip0.t-ipconnect.de. [2003:ef:2bd3:1613:c1f2:e846:aeda:540d])
        by smtp.gmail.com with ESMTPSA id o201-v6sm16049413wmg.16.2018.10.09.02.25.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 02:25:12 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     rostedt@goodmis.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        alessio.balsini@gmail.com, bristot@redhat.com, will.deacon@arm.com,
        andrea.parri@amarulasolutions.com, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com, henrik@austad.us,
        linux-rt-users@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
Subject: [RFD/RFC PATCH 5/8] sched: Add proxy execution
Date:   Tue,  9 Oct 2018 11:24:31 +0200
Message-Id: <20181009092434.26221-6-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181009092434.26221-1-juri.lelli@redhat.com>
References: <20181009092434.26221-1-juri.lelli@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

A task currently holding a mutex (executing a critical section) might
find benefit in using scheduling contexts of other tasks blocked on the
same mutex if they happen to have higher priority of the current owner
(e.g., to prevent priority inversions).

Proxy execution lets a task do exactly that: if a mutex owner has
waiters, it can use waiters' scheduling context to potentially continue
running if preempted.

The basic mechanism is implemented by this patch, the core of which
resides in the proxy() function. Potential proxies (i.e., tasks blocked
on a mutex) are not dequeued, so, if one of them is actually selected by
schedule() as the next task to be put to run on a CPU, proxy() is used
to walk the blocked_on relation and find which task (mutex owner) might
be able to use the proxy's scheduling context.

Here come the tricky bits. In fact, owner task might be in all sort of
states when a proxy is found (blocked, executing on a different CPU,
etc.). Details on how to handle different situations are to be found in
proxy() code comments.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
[rebased, added comments and changelog]
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 include/linux/sched.h   |   2 +
 init/Kconfig            |   4 +
 init/init_task.c        |   1 +
 kernel/Kconfig.locks    |   2 +-
 kernel/fork.c           |   2 +
 kernel/locking/mutex.c  |  47 ++++-
 kernel/sched/core.c     | 408 ++++++++++++++++++++++++++++++++++++++--
 kernel/sched/deadline.c |   2 +-
 kernel/sched/fair.c     |   3 +
 kernel/sched/rt.c       |   2 +-
 10 files changed, 455 insertions(+), 18 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index a35e8ab3eef1..e3e7b1bcb8fa 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -909,6 +909,8 @@ struct task_struct {
 
 	struct task_struct 	*blocked_task;	/* task that's boosting us */
 	struct mutex 		*blocked_on;	/* lock we're blocked on */
+	struct list_head	blocked_entry;  /* tasks blocked on us */
+	raw_spinlock_t		blocked_lock;
 
 #ifdef CONFIG_TRACE_IRQFLAGS
 	unsigned int			irq_events;
diff --git a/init/Kconfig b/init/Kconfig
index 317d5ccb5191..210edff253f8 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -667,6 +667,10 @@ config NUMA_BALANCING_DEFAULT_ENABLED
 	  If set, automatic NUMA balancing will be enabled if running on a NUMA
 	  machine.
 
+config PROXY_EXEC
+	bool "Proxy Execution"
+	default n
+
 menuconfig CGROUPS
 	bool "Control Group support"
 	select KERNFS
diff --git a/init/init_task.c b/init/init_task.c
index 5aebe3be4d7c..6505df95f6ac 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -117,6 +117,7 @@ struct task_struct init_task
 	.journal_info	= NULL,
 	INIT_CPU_TIMERS(init_task)
 	.pi_lock	= __RAW_SPIN_LOCK_UNLOCKED(init_task.pi_lock),
+	.blocked_lock	= __RAW_SPIN_LOCK_UNLOCKED(init_task.blocked_lock),
 	.timer_slack_ns = 50000, /* 50 usec default slack */
 	.thread_pid	= &init_struct_pid,
 	.thread_group	= LIST_HEAD_INIT(init_task.thread_group),
diff --git a/kernel/Kconfig.locks b/kernel/Kconfig.locks
index 84d882f3e299..5a627839a048 100644
--- a/kernel/Kconfig.locks
+++ b/kernel/Kconfig.locks
@@ -225,7 +225,7 @@ config ARCH_SUPPORTS_ATOMIC_RMW
 
 config MUTEX_SPIN_ON_OWNER
 	def_bool y
-	depends on SMP && ARCH_SUPPORTS_ATOMIC_RMW
+	depends on SMP && ARCH_SUPPORTS_ATOMIC_RMW && !PROXY_EXEC
 
 config RWSEM_SPIN_ON_OWNER
        def_bool y
diff --git a/kernel/fork.c b/kernel/fork.c
index ef27a675b0d7..b56ca9780194 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1723,6 +1723,7 @@ static __latent_entropy struct task_struct *copy_process(
 	ftrace_graph_init_task(p);
 
 	rt_mutex_init_task(p);
+	raw_spin_lock_init(&p->blocked_lock);
 
 #ifdef CONFIG_PROVE_LOCKING
 	DEBUG_LOCKS_WARN_ON(!p->hardirqs_enabled);
@@ -1829,6 +1830,7 @@ static __latent_entropy struct task_struct *copy_process(
 
 	p->blocked_task = NULL; /* nobody is boosting us yet*/
 	p->blocked_on = NULL;  /* not blocked yet */
+	INIT_LIST_HEAD(&p->blocked_entry);
 
 #ifdef CONFIG_BCACHE
 	p->sequential_io	= 0;
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 76b59b555da3..23312afa7fca 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -35,6 +35,10 @@
 # include "mutex.h"
 #endif
 
+#if defined(CONFIG_PROXY_EXEC) && defined(CONFIG_MUTEX_SPIN_ON_OWNER)
+#error BOOM
+#endif
+
 void
 __mutex_init(struct mutex *lock, const char *name, struct lock_class_key *key)
 {
@@ -1021,6 +1025,10 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 				__mutex_set_flag(lock, MUTEX_FLAG_HANDOFF);
 		}
 
+		/*
+		 * Gets reset by ttwu_remote().
+		 */
+		current->blocked_on = lock;
 		set_current_state(state);
 		/*
 		 * Here we order against unlock; we must either see it change
@@ -1206,10 +1214,21 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 {
 	struct task_struct *next = NULL;
 	DEFINE_WAKE_Q(wake_q);
-	unsigned long owner;
+	/*
+	 * XXX [juril] Proxy Exec forces always an HANDOFF (so that owner is
+	 * never empty when there are waiters wating?). Should we make this
+	 * conditional on having proxy exec configured in?
+	 */
+	unsigned long owner = MUTEX_FLAG_HANDOFF;
 
 	mutex_release(&lock->dep_map, 1, ip);
 
+	/*
+	 * XXX must always handoff the mutex to avoid !owner in proxy().
+	 * scheduler delay is minimal since we hand off to the task that
+	 * is to be scheduled next.
+	 */
+#ifndef CONFIG_PROXY_EXEC
 	/*
 	 * Release the lock before (potentially) taking the spinlock such that
 	 * other contenders can get on with things ASAP.
@@ -1240,10 +1259,34 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 
 		owner = old;
 	}
+#endif
 
 	raw_spin_lock(&lock->wait_lock);
 	debug_mutex_unlock(lock);
-	if (!list_empty(&lock->wait_list)) {
+
+#ifdef CONFIG_PROXY_EXEC
+	/*
+	 * If we have a task boosting us, and that task was boosting us through
+	 * this lock, hand the lock that that task, as that is the highest
+	 * waiter, as selected by the scheduling function.
+	 *
+	 * XXX existance guarantee on ->blocked_task ?
+	 */
+	next = current->blocked_task;
+	if (next && next->blocked_on != lock)
+		next = NULL;
+
+	/*
+	 * XXX if there was no higher prio proxy, ->blocked_task will not have
+	 * been set.  Therefore lower prio contending tasks are serviced in
+	 * FIFO order.
+	 */
+#endif
+
+	/*
+	 * Failing that, pick any on the wait list.
+	 */
+	if (!next && !list_empty(&lock->wait_list)) {
 		/* get the first entry from the wait-list: */
 		struct mutex_waiter *waiter =
 			list_first_entry(&lock->wait_list,
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d3c481b734dd..e3e3eea3f5b2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1646,8 +1646,31 @@ ttwu_stat(struct task_struct *p, int cpu, int wake_flags)
 
 static inline void ttwu_activate(struct rq *rq, struct task_struct *p, int en_flags)
 {
+	/*
+	 * XXX can we possibly avoid the spinlock ? See proxy()'s blocked_task
+	 * case.
+	 */
+	raw_spin_lock(&p->blocked_lock);
 	activate_task(rq, p, en_flags);
+
+	/*
+	 * A whole bunch of 'proxy' tasks back this blocked task, wake
+	 * them all up to give this task its 'fair' share.
+	 */
+	while (!list_empty(&p->blocked_entry)) {
+		struct task_struct *pp =
+			list_first_entry(&p->blocked_entry,
+					 struct task_struct,
+					 blocked_entry);
+
+		list_del_init(&pp->blocked_entry);
+		activate_task(rq, pp, en_flags);
+		pp->on_rq = TASK_ON_RQ_QUEUED;
+		resched_curr(rq);
+	}
+
 	p->on_rq = TASK_ON_RQ_QUEUED;
+	raw_spin_unlock(&p->blocked_lock);
 
 	/* If a worker is waking up, notify the workqueue: */
 	if (p->flags & PF_WQ_WORKER)
@@ -1722,12 +1745,46 @@ static int ttwu_remote(struct task_struct *p, int wake_flags)
 	int ret = 0;
 
 	rq = __task_rq_lock(p, &rf);
-	if (task_on_rq_queued(p)) {
-		/* check_preempt_curr() may use rq clock */
-		update_rq_clock(rq);
-		ttwu_do_wakeup(rq, p, wake_flags, &rf);
-		ret = 1;
+	if (!task_on_rq_queued(p)) {
+		BUG_ON(p->state == TASK_RUNNING);
+		goto out_unlock;
 	}
+
+	/*
+	 * ttwu_do_wakeup()->
+	 *   check_preempt_curr() may use rq clock
+	 */
+	update_rq_clock(rq);
+
+	/*
+	 * Since we don't dequeue for blocked-on relations, we'll always
+	 * trigger the on_rq_queued() clause for them.
+	 */
+	if (task_is_blocked(p)) {
+		p->blocked_on = NULL; /* let it run again */
+		if (!cpumask_test_cpu(cpu_of(rq), &p->cpus_allowed)) {
+			/*
+			 * proxy stuff moved us outside of the affinity mask
+			 * 'sleep' now and fail the direct wakeup so that the
+			 * normal wakeup path will fix things.
+			 */
+			p->on_rq = 0;
+			/* XXX [juril] SLEEP|NOCLOCK ? */
+			deactivate_task(rq, p, DEQUEUE_SLEEP);
+			goto out_unlock;
+		}
+
+		/*
+		 * Must resched after killing a blocked_on relation. The currently
+		 * executing context might not be the most elegible anymore.
+		 */
+		resched_curr(rq);
+	}
+
+	ttwu_do_wakeup(rq, p, wake_flags, &rf);
+	ret = 1;
+
+out_unlock:
 	__task_rq_unlock(rq, &rf);
 
 	return ret;
@@ -3360,6 +3417,308 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	BUG();
 }
 
+#ifdef CONFIG_PROXY_EXEC
+static struct task_struct fake_task;
+
+/*
+ * Follow the blocked-on relation:
+ *
+ *                ,-> task
+ *                |     | blocked-on
+ *                |     v
+ *   blocked-task |   mutex
+ *                |     | owner
+ *                |     v
+ *                `-- task
+ *
+ * and set the blocked-task relation, this latter is used by the mutex code
+ * to find which (blocked) task to hand-off to.
+ *
+ * Lock order:
+ *
+ *   p->pi_lock
+ *     rq->lock
+ *       mutex->wait_lock
+ *         p->blocked_lock
+ *
+ * Returns the task that is going to be used as execution context (the one
+ * that is actually going to be put to run on cpu_of(rq)).
+ *
+ */
+static struct task_struct *
+proxy(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
+{
+	struct task_struct *p = next;
+	struct task_struct *owner;
+	struct mutex *mutex;
+	struct rq *that_rq;
+	int this_cpu, that_cpu;
+	LIST_HEAD(migrate_list);
+
+	this_cpu = cpu_of(rq);
+
+	/*
+	 * Follow blocked_on chain.
+	 *
+	 * TODO: deadlock detection
+	 */
+	for (p = next; p->blocked_on; p = owner) {
+		mutex = p->blocked_on;
+
+		/*
+		 * By taking mutex->wait_lock we hold off concurrent mutex_unlock()
+		 * and ensure @owner sticks around.
+		 */
+		raw_spin_lock(&mutex->wait_lock);
+		owner = __mutex_owner(mutex);
+		/*
+		 * XXX can't this be 0|FLAGS? See __mutex_unlock_slowpath for(;;)
+		 * Mmm, OK, this can't probably happend because we forse
+		 * unlock to skip the for(;;) loop. Is this acceptable though?
+		 */
+retry_owner:
+		if (task_cpu(owner) != this_cpu)
+			goto migrate_task;
+
+		if (owner == p)
+			goto owned_task;
+
+		if (!owner->on_rq)
+			goto blocked_task;
+
+		/*
+		 * OK, now we're absolutely sure @owner is not blocked _and_
+		 * on this rq, therefore holding @rq->lock is sufficient to
+		 * guarantee its existence, as per ttwu_remote().
+		 */
+		raw_spin_unlock(&mutex->wait_lock);
+
+		owner->blocked_task = p;
+	}
+
+	WARN_ON_ONCE(!owner->on_rq);
+
+	return owner;
+
+migrate_task:
+	/*
+	 * The blocked-on relation must not cross CPUs, if this happens
+	 * migrate @p to the @owner's CPU.
+	 *
+	 * This is because we must respect the CPU affinity of execution
+	 * contexts (@owner) but we can ignore affinity for scheduling
+	 * contexts (@p). So we have to move scheduling contexts towards
+	 * potential execution contexts.
+	 *
+	 * XXX [juril] what if @p is not the highest prio task once migrated
+	 * to @owner's CPU?
+	 *
+	 * XXX [juril] also, after @p is migrated it is not migrated back once
+	 * @owner releases the lock? Isn't this a potential problem w.r.t.
+	 * @owner affinity settings?
+	 * [juril] OK. It is migrated back into its affinity mask in
+	 * ttwu_remote(), or by using wake_cpu via select_task_rq, guess we
+	 * might want to add a comment about that here. :-)
+	 *
+	 * TODO: could optimize by finding the CPU of the final owner
+	 * and migrating things there. Given:
+	 *
+	 *	CPU0	CPU1	CPU2
+	 *
+	 *	 a ----> b ----> c
+	 *
+	 * the current scheme would result in migrating 'a' to CPU1,
+	 * then CPU1 would migrate b and a to CPU2. Only then would
+	 * CPU2 run c.
+	 */
+	that_cpu = task_cpu(owner);
+	that_rq = cpu_rq(that_cpu);
+	/*
+	 * @owner can disappear, simply migrate to @that_cpu and leave that CPU
+	 * to sort things out.
+	 */
+	raw_spin_unlock(&mutex->wait_lock);
+
+	/*
+	 * Since we're going to drop @rq, we have to put(@next) first,
+	 * otherwise we have a reference that no longer belongs to us.  Use
+	 * @fake_task to fill the void and make the next pick_next_task()
+	 * invocation happy.
+	 *
+	 * XXX double, triple think about this.
+	 * XXX put doesn't work with ON_RQ_MIGRATE
+	 *
+	 * CPU0				CPU1
+	 *
+	 *				B mutex_lock(X)
+	 *
+	 * A mutex_lock(X) <- B
+	 * A __schedule()
+	 * A pick->A
+	 * A proxy->B
+	 * A migrate A to CPU1
+	 *				B mutex_unlock(X) -> A
+	 *				B __schedule()
+	 *				B pick->A
+	 *				B switch_to (A)
+	 *				A ... does stuff
+	 * A ... is still running here
+	 *
+	 *		* BOOM *
+	 */
+	put_prev_task(rq, next);
+	if (rq->curr != rq->idle) {
+		rq->proxy = rq->idle;
+		set_tsk_need_resched(rq->idle);
+		/*
+		 * XXX [juril] don't we still need to migrate @next to
+		 * @owner's CPU?
+		 */
+		return rq->idle;
+	}
+	rq->proxy = &fake_task;
+
+	for (; p; p = p->blocked_task) {
+		int wake_cpu = p->wake_cpu;
+
+		WARN_ON(p == rq->curr);
+
+		p->on_rq = TASK_ON_RQ_MIGRATING;
+		dequeue_task(rq, p, 0);
+		set_task_cpu(p, that_cpu);
+		/*
+		 * We can abuse blocked_entry to migrate the thing, because @p is
+		 * still on the rq.
+		 */
+		list_add(&p->blocked_entry, &migrate_list);
+
+		/*
+		 * Preserve p->wake_cpu, such that we can tell where it
+		 * used to run later.
+		 */
+		p->wake_cpu = wake_cpu;
+	}
+
+	rq_unpin_lock(rq, rf);
+	raw_spin_unlock(&rq->lock);
+	raw_spin_lock(&that_rq->lock);
+
+	while (!list_empty(&migrate_list)) {
+		p = list_first_entry(&migrate_list, struct task_struct, blocked_entry);
+		list_del_init(&p->blocked_entry);
+
+		enqueue_task(that_rq, p, 0);
+		check_preempt_curr(that_rq, p, 0);
+		p->on_rq = TASK_ON_RQ_QUEUED;
+		resched_curr(that_rq);
+	}
+
+	raw_spin_unlock(&that_rq->lock);
+	raw_spin_lock(&rq->lock);
+	rq_repin_lock(rq, rf);
+
+	return NULL; /* Retry task selection on _this_ CPU. */
+
+owned_task:
+	/*
+	 * Its possible we interleave with mutex_unlock like:
+	 *
+	 *				lock(&rq->lock);
+	 *				  proxy()
+	 * mutex_unlock()
+	 *   lock(&wait_lock);
+	 *   next(owner) = current->blocked_task;
+	 *   unlock(&wait_lock);
+	 *
+	 *   wake_up_q();
+	 *     ...
+	 *       ttwu_remote()
+	 *         __task_rq_lock()
+	 *				  lock(&wait_lock);
+	 *				  owner == p
+	 *
+	 * Which leaves us to finish the ttwu_remote() and make it go.
+	 *
+	 * XXX is this happening in case of an HANDOFF to p?
+	 * In any case, reading of the owner in __mutex_unlock_slowpath is
+	 * done atomically outside wait_lock (only adding waiters to wake_q is
+	 * done inside the critical section).
+	 * Does this means we can get to proxy _w/o an owner_ if that was
+	 * cleared before grabbing wait_lock? Do we account for this case?
+	 * OK we actually do (see PROXY_EXEC ifdeffery in unlock function).
+	 */
+
+	/*
+	 * Finish wakeup, will make the contending ttwu do a
+	 * _spurious_ wakeup, but all code should be able to
+	 * deal with that.
+	 */
+	owner->blocked_on = NULL;
+	owner->state = TASK_RUNNING;
+	// XXX task_woken
+
+	/*
+	 * If @owner/@p is allowed to run on this CPU, make it go.
+	 */
+	if (cpumask_test_cpu(this_cpu, &owner->cpus_allowed)) {
+		raw_spin_unlock(&mutex->wait_lock);
+		return owner;
+	}
+
+	/*
+	 * We have to let ttwu fix things up, because we
+	 * can't restore the affinity. So dequeue.
+	 */
+	owner->on_rq = 0;
+	deactivate_task(rq, p, DEQUEUE_SLEEP);
+	goto blocked_task;
+
+blocked_task:
+	/*
+	 * If !@owner->on_rq, holding @rq->lock will not pin the task,
+	 * so we cannot drop @mutex->wait_lock until we're sure its a blocked
+	 * task on this rq.
+	 *
+	 * We use @owner->blocked_lock to serialize against ttwu_activate().
+	 * Either we see its new owner->on_rq or it will see our list_add().
+	 */
+	raw_spin_lock(&owner->blocked_lock);
+
+	/*
+	 * If we became runnable while waiting for blocked_lock, retry.
+	 */
+	if (owner->on_rq) {
+		/*
+		 * If we see the new on->rq, we must also see the new task_cpu().
+		 */
+		raw_spin_unlock(&owner->blocked_lock);
+		goto retry_owner;
+	}
+
+	/*
+	 * Walk back up the blocked_task relation and enqueue them all on @owner
+	 *
+	 * ttwu_activate() will pick them up and place them on whatever rq
+	 * @owner will run next.
+	 */
+	for (; p; p = p->blocked_task) {
+		p->on_rq = 0;
+		deactivate_task(rq, p, DEQUEUE_SLEEP);
+		list_add(&p->blocked_entry, &owner->blocked_entry);
+	}
+	raw_spin_unlock(&owner->blocked_lock);
+	raw_spin_unlock(&mutex->wait_lock);
+
+	return NULL; /* retry task selection */
+}
+#else /* PROXY_EXEC */
+static struct task_struct *
+proxy(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
+{
+	return next;
+}
+#endif /* PROXY_EXEC */
+
 /*
  * __schedule() is the main scheduler function.
  *
@@ -3439,12 +3798,19 @@ static void __sched notrace __schedule(bool preempt)
 		if (unlikely(signal_pending_state(prev->state, prev))) {
 			prev->state = TASK_RUNNING;
 		} else {
-			deactivate_task(rq, prev, DEQUEUE_SLEEP | DEQUEUE_NOCLOCK);
-			prev->on_rq = 0;
-
-			if (prev->in_iowait) {
-				atomic_inc(&rq->nr_iowait);
-				delayacct_blkio_start();
+			if (!task_is_blocked(prev)) {
+				prev->on_rq = 0;
+				deactivate_task(rq, prev, DEQUEUE_SLEEP | DEQUEUE_NOCLOCK);
+			} else {
+				/*
+				 * XXX
+				 * Let's make this task, which is blocked on
+				 * a mutex, (push/pull)able (RT/DL).
+				 * Unfortunately we can only deal with that by
+				 * means of a dequeue/enqueue cycle. :-/
+				 */
+				dequeue_task(rq, prev, 0);
+				enqueue_task(rq, prev, 0);
 			}
 
 			/*
@@ -3463,7 +3829,23 @@ static void __sched notrace __schedule(bool preempt)
 		switch_count = &prev->nvcsw;
 	}
 
-	next = pick_next_task(rq, prev, &rf);
+pick_again:
+	/*
+	 * If picked task is actually blocked it means that it can act as a
+	 * proxy for the task that is holding the mutex picked task is blocked
+	 * on. Get a reference to the blocked (going to be proxy) task here.
+	 * Note that if next isn't actually blocked we will have rq->proxy ==
+	 * rq->curr == next in the end, which is intended and means that proxy
+	 * execution is currently "not in use".
+	 */
+	rq->proxy = next = pick_next_task(rq, rq->proxy, &rf);
+	next->blocked_task = NULL;
+	if (unlikely(task_is_blocked(next))) {
+		next = proxy(rq, next, &rf);
+		if (!next)
+			goto pick_again;
+	}
+
 	clear_tsk_need_resched(prev);
 	clear_preempt_need_resched();
 
@@ -5441,7 +5823,7 @@ void init_idle(struct task_struct *idle, int cpu)
 	__set_task_cpu(idle, cpu);
 	rcu_read_unlock();
 
-	rq->curr = rq->idle = idle;
+	rq->curr = rq->proxy = rq->idle = idle;
 	idle->on_rq = TASK_ON_RQ_QUEUED;
 #ifdef CONFIG_SMP
 	idle->on_cpu = 1;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 91e4202b0634..9336310c541d 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1499,7 +1499,7 @@ static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 
 	enqueue_dl_entity(&p->dl, pi_se, flags);
 
-	if (!task_current(rq, p) && p->nr_cpus_allowed > 1)
+	if (!task_current(rq, p) && p->nr_cpus_allowed > 1 && !task_is_blocked(p))
 		enqueue_pushable_dl_task(rq, p);
 }
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7f8a5dcda923..3f9f60bdc1d6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7043,6 +7043,9 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 
 	lockdep_assert_held(&env->src_rq->lock);
 
+	if (task_is_blocked(p))
+		return 0;
+
 	/*
 	 * We do not migrate tasks that are:
 	 * 1) throttled_lb_pair, or
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 2e2955a8cf8f..9dada9e0d699 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1334,7 +1334,7 @@ enqueue_task_rt(struct rq *rq, struct task_struct *p, int flags)
 
 	enqueue_rt_entity(rt_se, flags);
 
-	if (!task_current(rq, p) && p->nr_cpus_allowed > 1)
+	if (!task_current(rq, p) && p->nr_cpus_allowed > 1 && !task_is_blocked(p))
 		enqueue_pushable_task(rq, p);
 }
 
-- 
2.17.1

