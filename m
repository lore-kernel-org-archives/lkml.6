Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753873AbeBLNlf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 08:41:35 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36298 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933300AbeBLNky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 08:40:54 -0500
X-Google-Smtp-Source: AH8x2246zFBDno2ATQ7tVDlm+QoDMFiUn/4aen6oSl0uiq8kPneGKfvm9QXmocXCnEsKI+7ZbFpyiQ==
From: Juri Lelli <juri.lelli@redhat.com>
To: peterz@infradead.org, mingo@redhat.com
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, bristot@redhat.com,
        mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com,
        morten.rasmussen@arm.com, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com, alessio.balsini@arm.com,
        juri.lelli@redhat.com
Subject: [RFC PATCH 1/3] sched/deadline: merge dl_bw into dl_bandwidth
Date: Mon, 12 Feb 2018 14:40:28 +0100
Message-Id: <20180212134030.12846-2-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180212134030.12846-1-juri.lelli@redhat.com>
References: <20180212134030.12846-1-juri.lelli@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both dl_bandwidth and dl_bw hold information about DEADLINE bandwidth admitted
to the system (at different levels). However, they are separate and threated as
two different beasts.

Merge them as it makes more sense, it's easier to manage and to better align
with RT (that already has a single rt_bandwidth).

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Luca Abeni <luca.abeni@santannapisa.it>
Cc: linux-kernel@vger.kernel.org
---
 kernel/sched/core.c     |  2 +-
 kernel/sched/deadline.c | 84 +++++++++++++++++++++++--------------------------
 kernel/sched/debug.c    |  6 ++--
 kernel/sched/sched.h    | 48 +++++++++++-----------------
 kernel/sched/topology.c |  2 +-
 5 files changed, 63 insertions(+), 79 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ee420d78e674..772a6b3239eb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4234,7 +4234,7 @@ static int __sched_setscheduler(struct task_struct *p,
 			 * will also fail if there's no bandwidth available.
 			 */
 			if (!cpumask_subset(span, &p->cpus_allowed) ||
-			    rq->rd->dl_bw.bw == 0) {
+			    rq->rd->dl_bw.dl_bw == 0) {
 				task_rq_unlock(rq, p, &rf);
 				return -EPERM;
 			}
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 9bb0e0c412ec..de19bd7feddb 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -46,7 +46,7 @@ static inline int on_dl_rq(struct sched_dl_entity *dl_se)
 }
 
 #ifdef CONFIG_SMP
-static inline struct dl_bw *dl_bw_of(int i)
+static inline struct dl_bandwidth *dl_bw_of(int i)
 {
 	RCU_LOCKDEP_WARN(!rcu_read_lock_sched_held(),
 			 "sched RCU must be held");
@@ -66,7 +66,7 @@ static inline int dl_bw_cpus(int i)
 	return cpus;
 }
 #else
-static inline struct dl_bw *dl_bw_of(int i)
+static inline struct dl_bandwidth *dl_bw_of(int i)
 {
 	return &cpu_rq(i)->dl.dl_bw;
 }
@@ -275,14 +275,14 @@ static void task_non_contending(struct task_struct *p)
 		if (dl_task(p))
 			sub_running_bw(dl_se, dl_rq);
 		if (!dl_task(p) || p->state == TASK_DEAD) {
-			struct dl_bw *dl_b = dl_bw_of(task_cpu(p));
+			struct dl_bandwidth *dl_b = dl_bw_of(task_cpu(p));
 
 			if (p->state == TASK_DEAD)
 				sub_rq_bw(&p->dl, &rq->dl);
-			raw_spin_lock(&dl_b->lock);
+			raw_spin_lock(&dl_b->dl_runtime_lock);
 			__dl_sub(dl_b, p->dl.dl_bw, dl_bw_cpus(task_cpu(p)));
 			__dl_clear_params(p);
-			raw_spin_unlock(&dl_b->lock);
+			raw_spin_unlock(&dl_b->dl_runtime_lock);
 		}
 
 		return;
@@ -342,18 +342,11 @@ void init_dl_bandwidth(struct dl_bandwidth *dl_b, u64 period, u64 runtime)
 	raw_spin_lock_init(&dl_b->dl_runtime_lock);
 	dl_b->dl_period = period;
 	dl_b->dl_runtime = runtime;
-}
-
-void init_dl_bw(struct dl_bw *dl_b)
-{
-	raw_spin_lock_init(&dl_b->lock);
-	raw_spin_lock(&def_dl_bandwidth.dl_runtime_lock);
-	if (global_rt_runtime() == RUNTIME_INF)
-		dl_b->bw = -1;
+	if (runtime == RUNTIME_INF)
+		dl_b->dl_bw = -1;
 	else
-		dl_b->bw = to_ratio(global_rt_period(), global_rt_runtime());
-	raw_spin_unlock(&def_dl_bandwidth.dl_runtime_lock);
-	dl_b->total_bw = 0;
+		dl_b->dl_bw = to_ratio(period, runtime);
+	dl_b->dl_total_bw = 0;
 }
 
 void init_dl_rq(struct dl_rq *dl_rq)
@@ -368,7 +361,8 @@ void init_dl_rq(struct dl_rq *dl_rq)
 	dl_rq->overloaded = 0;
 	dl_rq->pushable_dl_tasks_root = RB_ROOT_CACHED;
 #else
-	init_dl_bw(&dl_rq->dl_bw);
+	init_dl_bandwidth(&dl_rq->dl_bw);
+	init_dl_bandwidth(&dl_rq->dl_bw, global_rt_period(), global_rt_runtime());
 #endif
 
 	dl_rq->running_bw = 0;
@@ -1262,7 +1256,7 @@ static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
 	rq = task_rq_lock(p, &rf);
 
 	if (!dl_task(p) || p->state == TASK_DEAD) {
-		struct dl_bw *dl_b = dl_bw_of(task_cpu(p));
+		struct dl_bandwidth *dl_b = dl_bw_of(task_cpu(p));
 
 		if (p->state == TASK_DEAD && dl_se->dl_non_contending) {
 			sub_running_bw(&p->dl, dl_rq_of_se(&p->dl));
@@ -1270,9 +1264,9 @@ static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
 			dl_se->dl_non_contending = 0;
 		}
 
-		raw_spin_lock(&dl_b->lock);
+		raw_spin_lock(&dl_b->dl_runtime_lock);
 		__dl_sub(dl_b, p->dl.dl_bw, dl_bw_cpus(task_cpu(p)));
-		raw_spin_unlock(&dl_b->lock);
+		raw_spin_unlock(&dl_b->dl_runtime_lock);
 		__dl_clear_params(p);
 
 		goto unlock;
@@ -2223,7 +2217,7 @@ static void set_cpus_allowed_dl(struct task_struct *p,
 	 * domain (see cpuset_can_attach()).
 	 */
 	if (!cpumask_intersects(src_rd->span, new_mask)) {
-		struct dl_bw *src_dl_b;
+		struct dl_bandwidth *src_dl_b;
 
 		src_dl_b = dl_bw_of(cpu_of(rq));
 		/*
@@ -2231,9 +2225,9 @@ static void set_cpus_allowed_dl(struct task_struct *p,
 		 * off. In the worst case, sched_setattr() may temporary fail
 		 * until we complete the update.
 		 */
-		raw_spin_lock(&src_dl_b->lock);
+		raw_spin_lock(&src_dl_b->dl_runtime_lock);
 		__dl_sub(src_dl_b, p->dl.dl_bw, dl_bw_cpus(task_cpu(p)));
-		raw_spin_unlock(&src_dl_b->lock);
+		raw_spin_unlock(&src_dl_b->dl_runtime_lock);
 	}
 
 	set_cpus_allowed_common(p, new_mask);
@@ -2406,7 +2400,7 @@ int sched_dl_global_validate(void)
 	u64 runtime = global_rt_runtime();
 	u64 period = global_rt_period();
 	u64 new_bw = to_ratio(period, runtime);
-	struct dl_bw *dl_b;
+	struct dl_bandwidth *dl_b;
 	int cpu, ret = 0;
 	unsigned long flags;
 
@@ -2423,10 +2417,10 @@ int sched_dl_global_validate(void)
 		rcu_read_lock_sched();
 		dl_b = dl_bw_of(cpu);
 
-		raw_spin_lock_irqsave(&dl_b->lock, flags);
-		if (new_bw < dl_b->total_bw)
+		raw_spin_lock_irqsave(&dl_b->dl_runtime_lock, flags);
+		if (new_bw < dl_b->dl_total_bw)
 			ret = -EBUSY;
-		raw_spin_unlock_irqrestore(&dl_b->lock, flags);
+		raw_spin_unlock_irqrestore(&dl_b->dl_runtime_lock, flags);
 
 		rcu_read_unlock_sched();
 
@@ -2453,7 +2447,7 @@ void init_dl_rq_bw_ratio(struct dl_rq *dl_rq)
 void sched_dl_do_global(void)
 {
 	u64 new_bw = -1;
-	struct dl_bw *dl_b;
+	struct dl_bandwidth *dl_b;
 	int cpu;
 	unsigned long flags;
 
@@ -2470,9 +2464,9 @@ void sched_dl_do_global(void)
 		rcu_read_lock_sched();
 		dl_b = dl_bw_of(cpu);
 
-		raw_spin_lock_irqsave(&dl_b->lock, flags);
-		dl_b->bw = new_bw;
-		raw_spin_unlock_irqrestore(&dl_b->lock, flags);
+		raw_spin_lock_irqsave(&dl_b->dl_runtime_lock, flags);
+		dl_b->dl_bw = new_bw;
+		raw_spin_unlock_irqrestore(&dl_b->dl_runtime_lock, flags);
 
 		rcu_read_unlock_sched();
 		init_dl_rq_bw_ratio(&cpu_rq(cpu)->dl);
@@ -2490,7 +2484,7 @@ void sched_dl_do_global(void)
 int sched_dl_overflow(struct task_struct *p, int policy,
 		      const struct sched_attr *attr)
 {
-	struct dl_bw *dl_b = dl_bw_of(task_cpu(p));
+	struct dl_bandwidth *dl_b = dl_bw_of(task_cpu(p));
 	u64 period = attr->sched_period ?: attr->sched_deadline;
 	u64 runtime = attr->sched_runtime;
 	u64 new_bw = dl_policy(policy) ? to_ratio(period, runtime) : 0;
@@ -2508,7 +2502,7 @@ int sched_dl_overflow(struct task_struct *p, int policy,
 	 * its parameters, we may need to update accordingly the total
 	 * allocated bandwidth of the container.
 	 */
-	raw_spin_lock(&dl_b->lock);
+	raw_spin_lock(&dl_b->dl_runtime_lock);
 	cpus = dl_bw_cpus(task_cpu(p));
 	if (dl_policy(policy) && !task_has_dl_policy(p) &&
 	    !__dl_overflow(dl_b, cpus, 0, new_bw)) {
@@ -2537,7 +2531,7 @@ int sched_dl_overflow(struct task_struct *p, int policy,
 		 */
 		err = 0;
 	}
-	raw_spin_unlock(&dl_b->lock);
+	raw_spin_unlock(&dl_b->dl_runtime_lock);
 
 	return err;
 }
@@ -2655,14 +2649,14 @@ int dl_task_can_attach(struct task_struct *p, const struct cpumask *cs_cpus_allo
 {
 	unsigned int dest_cpu = cpumask_any_and(cpu_active_mask,
 							cs_cpus_allowed);
-	struct dl_bw *dl_b;
+	struct dl_bandwidth *dl_b;
 	bool overflow;
 	int cpus, ret;
 	unsigned long flags;
 
 	rcu_read_lock_sched();
 	dl_b = dl_bw_of(dest_cpu);
-	raw_spin_lock_irqsave(&dl_b->lock, flags);
+	raw_spin_lock_irqsave(&dl_b->dl_runtime_lock, flags);
 	cpus = dl_bw_cpus(dest_cpu);
 	overflow = __dl_overflow(dl_b, cpus, 0, p->dl.dl_bw);
 	if (overflow)
@@ -2677,7 +2671,7 @@ int dl_task_can_attach(struct task_struct *p, const struct cpumask *cs_cpus_allo
 		__dl_add(dl_b, p->dl.dl_bw, cpus);
 		ret = 0;
 	}
-	raw_spin_unlock_irqrestore(&dl_b->lock, flags);
+	raw_spin_unlock_irqrestore(&dl_b->dl_runtime_lock, flags);
 	rcu_read_unlock_sched();
 	return ret;
 }
@@ -2686,18 +2680,18 @@ int dl_cpuset_cpumask_can_shrink(const struct cpumask *cur,
 				 const struct cpumask *trial)
 {
 	int ret = 1, trial_cpus;
-	struct dl_bw *cur_dl_b;
+	struct dl_bandwidth *cur_dl_b;
 	unsigned long flags;
 
 	rcu_read_lock_sched();
 	cur_dl_b = dl_bw_of(cpumask_any(cur));
 	trial_cpus = cpumask_weight(trial);
 
-	raw_spin_lock_irqsave(&cur_dl_b->lock, flags);
-	if (cur_dl_b->bw != -1 &&
-	    cur_dl_b->bw * trial_cpus < cur_dl_b->total_bw)
+	raw_spin_lock_irqsave(&cur_dl_b->dl_runtime_lock, flags);
+	if (cur_dl_b->dl_bw != -1 &&
+	    cur_dl_b->dl_bw * trial_cpus < cur_dl_b->dl_total_bw)
 		ret = 0;
-	raw_spin_unlock_irqrestore(&cur_dl_b->lock, flags);
+	raw_spin_unlock_irqrestore(&cur_dl_b->dl_runtime_lock, flags);
 	rcu_read_unlock_sched();
 	return ret;
 }
@@ -2705,16 +2699,16 @@ int dl_cpuset_cpumask_can_shrink(const struct cpumask *cur,
 bool dl_cpu_busy(unsigned int cpu)
 {
 	unsigned long flags;
-	struct dl_bw *dl_b;
+	struct dl_bandwidth *dl_b;
 	bool overflow;
 	int cpus;
 
 	rcu_read_lock_sched();
 	dl_b = dl_bw_of(cpu);
-	raw_spin_lock_irqsave(&dl_b->lock, flags);
+	raw_spin_lock_irqsave(&dl_b->dl_runtime_lock, flags);
 	cpus = dl_bw_cpus(cpu);
 	overflow = __dl_overflow(dl_b, cpus, 0, 0);
-	raw_spin_unlock_irqrestore(&dl_b->lock, flags);
+	raw_spin_unlock_irqrestore(&dl_b->dl_runtime_lock, flags);
 	rcu_read_unlock_sched();
 	return overflow;
 }
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 1ca0130ed4f9..cf736a30350e 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -622,7 +622,7 @@ void print_rt_rq(struct seq_file *m, int cpu, struct rt_rq *rt_rq)
 
 void print_dl_rq(struct seq_file *m, int cpu, struct dl_rq *dl_rq)
 {
-	struct dl_bw *dl_bw;
+	struct dl_bandwidth *dl_bw;
 
 	SEQ_printf(m, "\ndl_rq[%d]:\n", cpu);
 
@@ -636,8 +636,8 @@ void print_dl_rq(struct seq_file *m, int cpu, struct dl_rq *dl_rq)
 #else
 	dl_bw = &dl_rq->dl_bw;
 #endif
-	SEQ_printf(m, "  .%-30s: %lld\n", "dl_bw->bw", dl_bw->bw);
-	SEQ_printf(m, "  .%-30s: %lld\n", "dl_bw->total_bw", dl_bw->total_bw);
+	SEQ_printf(m, "  .%-30s: %lld\n", "dl_bw->dl_bw", dl_bw->dl_bw);
+	SEQ_printf(m, "  .%-30s: %lld\n", "dl_bw->dl_total_bw", dl_bw->dl_total_bw);
 
 #undef PU
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2e95505e23c6..7c44c8baa98c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -213,7 +213,7 @@ void __dl_clear_params(struct task_struct *p);
 /*
  * To keep the bandwidth of -deadline tasks and groups under control
  * we need some place where:
- *  - store the maximum -deadline bandwidth of the system (the group);
+ *  - store the maximum -deadline bandwidth of the system (the domain);
  *  - cache the fraction of that bandwidth that is currently allocated.
  *
  * This is all done in the data structure below. It is similar to the
@@ -224,20 +224,16 @@ void __dl_clear_params(struct task_struct *p);
  *
  * With respect to SMP, the bandwidth is given on a per-CPU basis,
  * meaning that:
- *  - dl_bw (< 100%) is the bandwidth of the system (group) on each CPU;
- *  - dl_total_bw array contains, in the i-eth element, the currently
- *    allocated bandwidth on the i-eth CPU.
- * Moreover, groups consume bandwidth on each CPU, while tasks only
- * consume bandwidth on the CPU they're running on.
- * Finally, dl_total_bw_cpu is used to cache the index of dl_total_bw
- * that will be shown the next time the proc or cgroup controls will
- * be red. It on its turn can be changed by writing on its own
- * control.
+ *  - dl_bw (< 100%) is the bandwidth of the system (domain) on each CPU;
+ *  - dl_total_bw array contains the currently allocated bandwidth on the
+ *    i-eth CPU.
  */
 struct dl_bandwidth {
 	raw_spinlock_t dl_runtime_lock;
-	u64 dl_runtime;
 	u64 dl_period;
+	u64 dl_runtime;
+	u64 dl_bw;
+	u64 dl_total_bw;
 };
 
 static inline int dl_bandwidth_enabled(void)
@@ -245,36 +241,30 @@ static inline int dl_bandwidth_enabled(void)
 	return sysctl_sched_rt_runtime >= 0;
 }
 
-struct dl_bw {
-	raw_spinlock_t lock;
-	u64 bw, total_bw;
-};
-
-static inline void __dl_update(struct dl_bw *dl_b, s64 bw);
+static inline void __dl_update(struct dl_bandwidth *dl_b, s64 bw);
 
 static inline
-void __dl_sub(struct dl_bw *dl_b, u64 tsk_bw, int cpus)
+void __dl_sub(struct dl_bandwidth *dl_b, u64 tsk_bw, int cpus)
 {
-	dl_b->total_bw -= tsk_bw;
+	dl_b->dl_total_bw -= tsk_bw;
 	__dl_update(dl_b, (s32)tsk_bw / cpus);
 }
 
 static inline
-void __dl_add(struct dl_bw *dl_b, u64 tsk_bw, int cpus)
+void __dl_add(struct dl_bandwidth *dl_b, u64 tsk_bw, int cpus)
 {
-	dl_b->total_bw += tsk_bw;
+	dl_b->dl_total_bw += tsk_bw;
 	__dl_update(dl_b, -((s32)tsk_bw / cpus));
 }
 
 static inline
-bool __dl_overflow(struct dl_bw *dl_b, int cpus, u64 old_bw, u64 new_bw)
+bool __dl_overflow(struct dl_bandwidth *dl_b, int cpus, u64 old_bw, u64 new_bw)
 {
-	return dl_b->bw != -1 &&
-	       dl_b->bw * cpus < dl_b->total_bw - old_bw + new_bw;
+	return dl_b->dl_bw != -1 &&
+	       dl_b->dl_bw * cpus < dl_b->dl_total_bw - old_bw + new_bw;
 }
 
 void dl_change_utilization(struct task_struct *p, u64 new_bw);
-extern void init_dl_bw(struct dl_bw *dl_b);
 extern int sched_dl_global_validate(void);
 extern void sched_dl_do_global(void);
 extern int sched_dl_overflow(struct task_struct *p, int policy,
@@ -600,7 +590,7 @@ struct dl_rq {
 	 */
 	struct rb_root_cached pushable_dl_tasks_root;
 #else
-	struct dl_bw dl_bw;
+	struct dl_bandwidth dl_bw;
 #endif
 	/*
 	 * "Active utilization" for this runqueue: increased when a
@@ -659,7 +649,7 @@ struct root_domain {
 	 */
 	cpumask_var_t dlo_mask;
 	atomic_t dlo_count;
-	struct dl_bw dl_bw;
+	struct dl_bandwidth dl_bw;
 	struct cpudl cpudl;
 
 #ifdef HAVE_RT_PUSH_IPI
@@ -2018,7 +2008,7 @@ static inline void nohz_balance_exit_idle(unsigned int cpu) { }
 
 #ifdef CONFIG_SMP
 static inline
-void __dl_update(struct dl_bw *dl_b, s64 bw)
+void __dl_update(struct dl_bandwidth *dl_b, s64 bw)
 {
 	struct root_domain *rd = container_of(dl_b, struct root_domain, dl_bw);
 	int i;
@@ -2033,7 +2023,7 @@ void __dl_update(struct dl_bw *dl_b, s64 bw)
 }
 #else
 static inline
-void __dl_update(struct dl_bw *dl_b, s64 bw)
+void __dl_update(struct dl_bandwidth *dl_b, s64 bw)
 {
 	struct dl_rq *dl = container_of(dl_b, struct dl_rq, dl_bw);
 
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 034cbed7f88b..0700f3f40445 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -276,7 +276,7 @@ static int init_rootdomain(struct root_domain *rd)
 	init_irq_work(&rd->rto_push_work, rto_push_irq_work_func);
 #endif
 
-	init_dl_bw(&rd->dl_bw);
+	init_dl_bandwidth(&rd->dl_bw, global_rt_period(), global_rt_runtime());
 	if (cpudl_init(&rd->cpudl) != 0)
 		goto free_rto_mask;
 
-- 
2.14.3
