Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935685AbeBLNk7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 08:40:59 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51157 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935663AbeBLNk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 08:40:56 -0500
X-Google-Smtp-Source: AH8x224wQymi7gZfmsZ+s8J7e+BaT4piT3Ri8UC4pSnvOUskneyGtZgedN7nryXm1/dzgp2ApMPCxA==
From: Juri Lelli <juri.lelli@redhat.com>
To: peterz@infradead.org, mingo@redhat.com
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, bristot@redhat.com,
        mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com,
        morten.rasmussen@arm.com, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com, alessio.balsini@arm.com,
        juri.lelli@redhat.com, Tejun Heo <tj@kernel.org>
Subject: [RFC PATCH 2/3] sched/deadline: add task groups bandwidth management support
Date: Mon, 12 Feb 2018 14:40:29 +0100
Message-Id: <20180212134030.12846-3-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180212134030.12846-1-juri.lelli@redhat.com>
References: <20180212134030.12846-1-juri.lelli@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the missing features of DEADLINE (w.r.t. RT) is some way of controlling
CPU bandwidth allocation for task groups. Such feature would be especially
useful to be able to let normal users use DEADLINE, as the sys admin (with root
privilegies) could reserve a fraction of the total available bandwidth to users
and let them allocate what needed inside such space.

This patch implements cgroup support for DEADLINE, with the following design
choices:

 - implementation _is not_ hierarchical: only single/plain DEADLINE entities
   can be handled, and they get scheduled at root rq level

 - DEADLINE_GROUP_SCHED requires RT_GROUP_SCHED (because of the points below)

 - DEADLINE and RT share bandwidth; therefore, DEADLINE tasks will eat RT
   bandwidth, as they do today at root level; support for RT_RUNTIME_ SHARE is
   however missing, an RT task might be able to exceed its group bandwidth
   constrain if such feature is enabled (more thinking required)

 - and therefore cpu.rt_runtime_us and cpu.rt_period_us are still controlling a
   group bandwidth; however, two additional knobs are added

     # cpu.dl_bw : maximum bandwidth available for the group on each CPU
                   (rt_runtime_us/rt_period_us)
     # cpu.dl_total_bw : current total (across CPUs) amount of bandwidth
                         allocated by the group (sum of tasks bandwidth)

 - father/children/siblings rules are the same as for RT

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Luca Abeni <luca.abeni@santannapisa.it>
Cc: linux-kernel@vger.kernel.org
---
 init/Kconfig             |  12 ++++
 kernel/sched/autogroup.c |   7 +++
 kernel/sched/core.c      |  54 +++++++++++++++-
 kernel/sched/deadline.c  | 159 ++++++++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/rt.c        |  52 ++++++++++++++--
 kernel/sched/sched.h     |  20 +++++-
 6 files changed, 292 insertions(+), 12 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index e37f4b2a6445..c6ddda90d51f 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -751,6 +751,18 @@ config RT_GROUP_SCHED
 	  realtime bandwidth for them.
 	  See Documentation/scheduler/sched-rt-group.txt for more information.
 
+config DEADLINE_GROUP_SCHED
+	bool "Group scheduling for SCHED_DEADLINE"
+	depends on CGROUP_SCHED
+	select RT_GROUP_SCHED
+	default n
+	help
+	  This feature lets you explicitly specify, in terms of runtime
+	  and period, the bandwidth of each task control group. This means
+	  tasks (and other groups) can be added to it only up to such
+	  "bandwidth cap", which might be useful for avoiding or
+	  controlling oversubscription.
+
 endif #CGROUP_SCHED
 
 config CGROUP_PIDS
diff --git a/kernel/sched/autogroup.c b/kernel/sched/autogroup.c
index a43df5193538..7cba2e132ac7 100644
--- a/kernel/sched/autogroup.c
+++ b/kernel/sched/autogroup.c
@@ -90,6 +90,13 @@ static inline struct autogroup *autogroup_create(void)
 	free_rt_sched_group(tg);
 	tg->rt_se = root_task_group.rt_se;
 	tg->rt_rq = root_task_group.rt_rq;
+#endif
+#ifdef CONFIG_DEADLINE_GROUP_SCHED
+	/*
+	 * Similarly to what above we do for DEADLINE tasks.
+	 */
+	free_dl_sched_group(tg);
+	tg->dl_rq = root_task_group.dl_rq;
 #endif
 	tg->autogroup = ag;
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 772a6b3239eb..8bb3e74b9486 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4225,7 +4225,8 @@ static int __sched_setscheduler(struct task_struct *p,
 #endif
 #ifdef CONFIG_SMP
 		if (dl_bandwidth_enabled() && dl_policy(policy) &&
-				!(attr->sched_flags & SCHED_FLAG_SUGOV)) {
+				!(attr->sched_flags & SCHED_FLAG_SUGOV) &&
+				!task_group_is_autogroup(task_group(p))) {
 			cpumask_t *span = rq->rd->span;
 
 			/*
@@ -5900,6 +5901,9 @@ void __init sched_init(void)
 #endif
 #ifdef CONFIG_RT_GROUP_SCHED
 	alloc_size += 2 * nr_cpu_ids * sizeof(void **);
+#endif
+#ifdef CONFIG_DEADLINE_GROUP_SCHED
+	alloc_size += nr_cpu_ids * sizeof(void **);
 #endif
 	if (alloc_size) {
 		ptr = (unsigned long)kzalloc(alloc_size, GFP_NOWAIT);
@@ -5920,6 +5924,11 @@ void __init sched_init(void)
 		ptr += nr_cpu_ids * sizeof(void **);
 
 #endif /* CONFIG_RT_GROUP_SCHED */
+#ifdef CONFIG_DEADLINE_GROUP_SCHED
+		root_task_group.dl_rq = (struct dl_rq **)ptr;
+		ptr += nr_cpu_ids * sizeof(void **);
+
+#endif /* CONFIG_DEADLINE_GROUP_SCHED */
 	}
 #ifdef CONFIG_CPUMASK_OFFSTACK
 	for_each_possible_cpu(i) {
@@ -5941,6 +5950,11 @@ void __init sched_init(void)
 	init_rt_bandwidth(&root_task_group.rt_bandwidth,
 			global_rt_period(), global_rt_runtime());
 #endif /* CONFIG_RT_GROUP_SCHED */
+#ifdef CONFIG_DEADLINE_GROUP_SCHED
+	init_dl_bandwidth(&root_task_group.dl_bandwidth,
+			global_rt_period(), global_rt_runtime());
+#endif /* CONFIG_DEADLINE_GROUP_SCHED */
+
 
 #ifdef CONFIG_CGROUP_SCHED
 	task_group_cache = KMEM_CACHE(task_group, 0);
@@ -5993,6 +6007,10 @@ void __init sched_init(void)
 #ifdef CONFIG_RT_GROUP_SCHED
 		init_tg_rt_entry(&root_task_group, &rq->rt, NULL, i, NULL);
 #endif
+#ifdef CONFIG_DEADLINE_GROUP_SCHED
+		init_tg_dl_entry(&root_task_group, &rq->dl, NULL, i, NULL);
+#endif
+
 
 		for (j = 0; j < CPU_LOAD_IDX_MAX; j++)
 			rq->cpu_load[j] = 0;
@@ -6225,6 +6243,7 @@ static void sched_free_group(struct task_group *tg)
 {
 	free_fair_sched_group(tg);
 	free_rt_sched_group(tg);
+	free_dl_sched_group(tg);
 	autogroup_free(tg);
 	kmem_cache_free(task_group_cache, tg);
 }
@@ -6244,6 +6263,9 @@ struct task_group *sched_create_group(struct task_group *parent)
 	if (!alloc_rt_sched_group(tg, parent))
 		goto err;
 
+	if (!alloc_dl_sched_group(tg, parent))
+		goto err;
+
 	return tg;
 
 err:
@@ -6427,14 +6449,20 @@ static int cpu_cgroup_can_attach(struct cgroup_taskset *tset)
 	int ret = 0;
 
 	cgroup_taskset_for_each(task, css, tset) {
+#if defined CONFIG_DEADLINE_GROUP_SCHED || defined CONFIG_RT_GROUP_SCHED
+#ifdef CONFIG_DEADLINE_GROUP_SCHED
+		if (!sched_dl_can_attach(css_tg(css), task))
+			return -EINVAL;
+#endif /* CONFIG_DEADLINE_GROUP_SCHED */
 #ifdef CONFIG_RT_GROUP_SCHED
 		if (!sched_rt_can_attach(css_tg(css), task))
 			return -EINVAL;
+#endif /* CONFIG_RT_GROUP_SCHED */
 #else
 		/* We don't support RT-tasks being in separate groups */
 		if (task->sched_class != &fair_sched_class)
 			return -EINVAL;
-#endif
+#endif /* CONFIG_DEADLINE_GROUP_SCHED || CONFIG_RT_GROUP_SCHED */
 		/*
 		 * Serialize against wake_up_new_task() such that if its
 		 * running, we're sure to observe its full state.
@@ -6750,6 +6778,18 @@ static u64 cpu_rt_period_read_uint(struct cgroup_subsys_state *css,
 	return sched_group_rt_period(css_tg(css));
 }
 #endif /* CONFIG_RT_GROUP_SCHED */
+#ifdef CONFIG_DEADLINE_GROUP_SCHED
+static u64 cpu_dl_bw_read(struct cgroup_subsys_state *css,
+			  struct cftype *cft)
+{
+	return sched_group_dl_bw(css_tg(css));
+}
+static u64 cpu_dl_total_bw_read(struct cgroup_subsys_state *css,
+				struct cftype *cft)
+{
+	return sched_group_dl_total_bw(css_tg(css));
+}
+#endif /* CONFIG_DEADLINE_GROUP_SCHED */
 
 static struct cftype cpu_legacy_files[] = {
 #ifdef CONFIG_FAIR_GROUP_SCHED
@@ -6786,6 +6826,16 @@ static struct cftype cpu_legacy_files[] = {
 		.read_u64 = cpu_rt_period_read_uint,
 		.write_u64 = cpu_rt_period_write_uint,
 	},
+#endif
+#ifdef CONFIG_DEADLINE_GROUP_SCHED
+	{
+		.name = "dl_bw",
+		.read_u64 = cpu_dl_bw_read,
+	},
+	{
+		.name = "dl_total_bw",
+		.read_u64 = cpu_dl_total_bw_read,
+	},
 #endif
 	{ }	/* Terminate */
 };
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index de19bd7feddb..25ed0a01623e 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -361,7 +361,6 @@ void init_dl_rq(struct dl_rq *dl_rq)
 	dl_rq->overloaded = 0;
 	dl_rq->pushable_dl_tasks_root = RB_ROOT_CACHED;
 #else
-	init_dl_bandwidth(&dl_rq->dl_bw);
 	init_dl_bandwidth(&dl_rq->dl_bw, global_rt_period(), global_rt_runtime());
 #endif
 
@@ -370,6 +369,129 @@ void init_dl_rq(struct dl_rq *dl_rq)
 	init_dl_rq_bw_ratio(dl_rq);
 }
 
+#ifdef CONFIG_DEADLINE_GROUP_SCHED
+u64 sched_group_dl_bw(struct task_group *tg)
+{
+	return tg->dl_bandwidth.dl_bw;
+}
+
+u64 sched_group_dl_total_bw(struct task_group *tg)
+{
+	return tg->dl_bandwidth.dl_total_bw;
+}
+
+/* Must be called with tasklist_lock held */
+int tg_has_dl_tasks(struct task_group *tg)
+{
+	struct task_struct *g, *p;
+
+	/*
+	 * Autogroups do not have DL tasks; see autogroup_create().
+	 */
+	if (task_group_is_autogroup(tg))
+		return 0;
+
+	do_each_thread(g, p) {
+		if (task_has_dl_policy(p) && task_group(p) == tg)
+			return 1;
+	} while_each_thread(g, p);
+
+	return 0;
+}
+
+int sched_dl_can_attach(struct task_group *tg, struct task_struct *tsk)
+{
+	int cpus, ret = 1;
+	struct rq_flags rf;
+	struct task_group *orig_tg;
+	struct rq *rq = task_rq_lock(tsk, &rf);
+
+	if (!dl_task(tsk))
+		goto unlock_rq;
+
+	/* Don't accept tasks when there is no way for them to run */
+	if (tg->dl_bandwidth.dl_runtime == 0) {
+		ret = 0;
+		goto unlock_rq;
+	}
+
+	/*
+	 * Check that the group has enough bandwidth left to accept this task.
+	 *
+	 * If there is space for the task:
+	 *   - reserve space for it in destination group
+	 *   - remove task bandwidth contribution from current group
+	 */
+	raw_spin_lock(&tg->dl_bandwidth.dl_runtime_lock);
+	cpus = dl_bw_cpus(task_cpu(tsk));
+	if (__dl_overflow(&tg->dl_bandwidth, cpus, 0, tsk->dl.dl_bw)) {
+		ret = 0;
+	} else {
+		tg->dl_bandwidth.dl_total_bw += tsk->dl.dl_bw;
+	}
+	raw_spin_unlock(&tg->dl_bandwidth.dl_runtime_lock);
+
+	/*
+	 * We managed to allocate tsk bandwidth in the new group,
+	 * remove that from the old one.
+	 * Doing this here is preferred instead of taking both
+	 * dl_runtime_lock together.
+	 */
+	if (ret) {
+		orig_tg = task_group(tsk);
+		raw_spin_lock(&orig_tg->dl_bandwidth.dl_runtime_lock);
+		orig_tg->dl_bandwidth.dl_total_bw -= tsk->dl.dl_bw;
+		raw_spin_unlock(&orig_tg->dl_bandwidth.dl_runtime_lock);
+	}
+
+unlock_rq:
+	task_rq_unlock(rq, tsk, &rf);
+
+	return ret;
+}
+
+void init_tg_dl_entry(struct task_group *tg, struct dl_rq *dl_rq,
+		struct sched_dl_entity *dl_se, int cpu,
+		struct sched_dl_entity *parent)
+{
+	tg->dl_rq[cpu] = dl_rq;
+}
+
+int alloc_dl_sched_group(struct task_group *tg, struct task_group *parent)
+{
+	struct rq *rq;
+	int i;
+
+	tg->dl_rq = kzalloc(sizeof(struct dl_rq *) * nr_cpu_ids, GFP_KERNEL);
+	if (!tg->dl_rq)
+		return 0;
+
+	init_dl_bandwidth(&tg->dl_bandwidth,
+			ktime_to_ns(def_dl_bandwidth.dl_period), 0);
+
+	for_each_possible_cpu(i) {
+		rq = cpu_rq(i);
+		init_tg_dl_entry(tg, &rq->dl, NULL, i, NULL);
+	}
+
+	return 1;
+}
+
+void free_dl_sched_group(struct task_group *tg)
+{
+	kfree(tg->dl_rq);
+}
+
+#else /* !CONFIG_DEADLINE_GROUP_SCHED */
+int alloc_dl_sched_group(struct task_group *tg, struct task_group *parent)
+{
+	return 1;
+}
+
+void free_dl_sched_group(struct task_group *tg) { }
+
+#endif /*CONFIG_DEADLINE_GROUP_SCHED*/
+
 #ifdef CONFIG_SMP
 
 static inline int dl_overloaded(struct rq *rq)
@@ -1223,14 +1345,23 @@ static void update_curr_dl(struct rq *rq)
 	 * account our runtime there too, otherwise actual rt tasks
 	 * would be able to exceed the shared quota.
 	 *
-	 * Account to the root rt group for now.
+	 * Account to curr's group, or the root rt group if group scheduling
+	 * is not in use. XXX if RT_RUNTIME_SHARE is enabled we should
+	 * probably split accounting between all rd rt_rq(s), but locking is
+	 * ugly. :/
 	 *
 	 * The solution we're working towards is having the RT groups scheduled
 	 * using deadline servers -- however there's a few nasties to figure
 	 * out before that can happen.
 	 */
 	if (rt_bandwidth_enabled()) {
+#ifdef CONFIG_DEADLINE_GROUP_SCHED
+		struct rt_bandwidth *rt_b =
+			sched_rt_bandwidth_tg(task_group(curr));
+		struct rt_rq *rt_rq = sched_rt_period_rt_rq(rt_b, cpu_of(rq));
+#else
 		struct rt_rq *rt_rq = &rq->rt;
+#endif /* CONFIG_DEADLINE_GROUP_SCHED */
 
 		raw_spin_lock(&rt_rq->rt_runtime_lock);
 		/*
@@ -1267,6 +1398,14 @@ static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
 		raw_spin_lock(&dl_b->dl_runtime_lock);
 		__dl_sub(dl_b, p->dl.dl_bw, dl_bw_cpus(task_cpu(p)));
 		raw_spin_unlock(&dl_b->dl_runtime_lock);
+#ifdef CONFIG_DEADLINE_GROUP_SCHED
+		{
+		struct dl_bandwidth *tg_b = &task_group(p)->dl_bandwidth;
+		raw_spin_lock(&tg_b->dl_runtime_lock);
+		tg_b->dl_total_bw -= p->dl.dl_bw;
+		raw_spin_unlock(&tg_b->dl_runtime_lock);
+		}
+#endif /* CONFIG_DEADLINE_GROUP_SCHED */
 		__dl_clear_params(p);
 
 		goto unlock;
@@ -2488,7 +2627,7 @@ int sched_dl_overflow(struct task_struct *p, int policy,
 	u64 period = attr->sched_period ?: attr->sched_deadline;
 	u64 runtime = attr->sched_runtime;
 	u64 new_bw = dl_policy(policy) ? to_ratio(period, runtime) : 0;
-	int cpus, err = -1;
+	int cpus, err = -1, change = 0;
 
 	if (attr->sched_flags & SCHED_FLAG_SUGOV)
 		return 0;
@@ -2522,6 +2661,7 @@ int sched_dl_overflow(struct task_struct *p, int policy,
 		__dl_sub(dl_b, p->dl.dl_bw, cpus);
 		__dl_add(dl_b, new_bw, cpus);
 		dl_change_utilization(p, new_bw);
+		change = 1;
 		err = 0;
 	} else if (!dl_policy(policy) && task_has_dl_policy(p)) {
 		/*
@@ -2533,6 +2673,19 @@ int sched_dl_overflow(struct task_struct *p, int policy,
 	}
 	raw_spin_unlock(&dl_b->dl_runtime_lock);
 
+#ifdef CONFIG_DEADLINE_GROUP_SCHED
+	/* Add new_bw to task group p belongs to. */
+	if (!err) {
+		struct dl_bandwidth *tg_b = &task_group(p)->dl_bandwidth;
+
+		raw_spin_lock(&tg_b->dl_runtime_lock);
+		if (change)
+			tg_b->dl_total_bw -= p->dl.dl_bw;
+		tg_b->dl_total_bw += new_bw;
+		raw_spin_unlock(&tg_b->dl_runtime_lock);
+	}
+#endif /* CONFIG_DEADLINE_GROUP_SCHED */
+
 	return err;
 }
 
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 862a513adca3..70d7d3b71f81 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -547,7 +547,6 @@ static inline const struct cpumask *sched_rt_period_mask(void)
 }
 #endif
 
-static inline
 struct rt_rq *sched_rt_period_rt_rq(struct rt_bandwidth *rt_b, int cpu)
 {
 	return container_of(rt_b, struct task_group, rt_bandwidth)->rt_rq[cpu];
@@ -558,6 +557,11 @@ static inline struct rt_bandwidth *sched_rt_bandwidth(struct rt_rq *rt_rq)
 	return &rt_rq->tg->rt_bandwidth;
 }
 
+struct rt_bandwidth *sched_rt_bandwidth_tg(struct task_group *tg)
+{
+	return &tg->rt_bandwidth;
+}
+
 #else /* !CONFIG_RT_GROUP_SCHED */
 
 static inline u64 sched_rt_runtime(struct rt_rq *rt_rq)
@@ -609,7 +613,6 @@ static inline const struct cpumask *sched_rt_period_mask(void)
 	return cpu_online_mask;
 }
 
-static inline
 struct rt_rq *sched_rt_period_rt_rq(struct rt_bandwidth *rt_b, int cpu)
 {
 	return &cpu_rq(cpu)->rt;
@@ -620,14 +623,20 @@ static inline struct rt_bandwidth *sched_rt_bandwidth(struct rt_rq *rt_rq)
 	return &def_rt_bandwidth;
 }
 
+struct rt_bandwidth *sched_rt_bandwidth_tg(struct task_group *tg)
+{
+	return &def_rt_bandwidth;
+}
+
 #endif /* CONFIG_RT_GROUP_SCHED */
 
 bool sched_rt_bandwidth_account(struct rt_rq *rt_rq)
 {
 	struct rt_bandwidth *rt_b = sched_rt_bandwidth(rt_rq);
 
-	return (hrtimer_active(&rt_b->rt_period_timer) ||
-		rt_rq->rt_time < rt_b->rt_runtime);
+	return (rt_rq->rt_nr_running &&
+		(hrtimer_active(&rt_b->rt_period_timer) ||
+		 rt_rq->rt_time < rt_b->rt_runtime));
 }
 
 #ifdef CONFIG_SMP
@@ -2423,9 +2432,14 @@ static int tg_rt_schedulable(struct task_group *tg, void *data)
 		return -EINVAL;
 
 	/*
-	 * Ensure we don't starve existing RT tasks.
+	 * Ensure we don't starve existing RT or DEADLINE tasks.
 	 */
-	if (rt_bandwidth_enabled() && !runtime && tg_has_rt_tasks(tg))
+	if (rt_bandwidth_enabled() && !runtime &&
+			(tg_has_rt_tasks(tg)
+#ifdef CONFIG_DEADLINE_GROUP_SCHED
+			 || tg_has_dl_tasks(tg)
+#endif /* CONFIG_DEADLINE_GROUP_SCHED */
+			 ))
 		return -EBUSY;
 
 	total = to_ratio(period, runtime);
@@ -2436,8 +2450,19 @@ static int tg_rt_schedulable(struct task_group *tg, void *data)
 	if (total > to_ratio(global_rt_period(), global_rt_runtime()))
 		return -EINVAL;
 
+#ifdef CONFIG_DEADLINE_GROUP_SCHED
+	/*
+	 * If decreasing our own bandwidth we must be sure we didn't already
+	 * allocate too much bandwidth.
+	 */
+	if (total < tg->dl_bandwidth.dl_total_bw)
+		return -EBUSY;
+#endif /* CONFIG_DEADLINE_GROUP_SCHED */
+
 	/*
 	 * The sum of our children's runtime should not exceed our own.
+	 * Also check that none of our children already allocated more than
+	 * the new bandwidth we want to set for ourself.
 	 */
 	list_for_each_entry_rcu(child, &tg->children, siblings) {
 		period = ktime_to_ns(child->rt_bandwidth.rt_period);
@@ -2448,6 +2473,11 @@ static int tg_rt_schedulable(struct task_group *tg, void *data)
 			runtime = d->rt_runtime;
 		}
 
+#ifdef CONFIG_DEADLINE_GROUP_SCHED
+		if (total < child->dl_bandwidth.dl_total_bw)
+			return -EBUSY;
+#endif /* CONFIG_DEADLINE_GROUP_SCHED */
+
 		sum += to_ratio(period, runtime);
 	}
 
@@ -2507,6 +2537,16 @@ static int tg_set_rt_bandwidth(struct task_group *tg,
 		rt_rq->rt_runtime = rt_runtime;
 		raw_spin_unlock(&rt_rq->rt_runtime_lock);
 	}
+
+#ifdef CONFIG_DEADLINE_GROUP_SCHED
+	raw_spin_lock(&tg->dl_bandwidth.dl_runtime_lock);
+	tg->dl_bandwidth.dl_period = tg->rt_bandwidth.rt_period;
+	tg->dl_bandwidth.dl_runtime = tg->rt_bandwidth.rt_runtime;
+	tg->dl_bandwidth.dl_bw =
+		to_ratio(tg->dl_bandwidth.dl_period,
+			 tg->dl_bandwidth.dl_runtime);
+	raw_spin_unlock(&tg->dl_bandwidth.dl_runtime_lock);
+#endif /* CONFIG_DEADLINE_GROUP_SCHED */
 	raw_spin_unlock_irq(&tg->rt_bandwidth.rt_runtime_lock);
 unlock:
 	read_unlock(&tasklist_lock);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 7c44c8baa98c..850aacc8f241 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -285,6 +285,7 @@ extern bool dl_cpu_busy(unsigned int cpu);
 
 struct cfs_rq;
 struct rt_rq;
+struct dl_rq;
 
 extern struct list_head task_groups;
 
@@ -333,6 +334,10 @@ struct task_group {
 
 	struct rt_bandwidth rt_bandwidth;
 #endif
+#ifdef CONFIG_DEADLINE_GROUP_SCHED
+	struct dl_rq **dl_rq;
+	struct dl_bandwidth dl_bandwidth;
+#endif
 
 	struct rcu_head rcu;
 	struct list_head list;
@@ -404,6 +409,19 @@ extern int sched_group_set_rt_period(struct task_group *tg, u64 rt_period_us);
 extern long sched_group_rt_runtime(struct task_group *tg);
 extern long sched_group_rt_period(struct task_group *tg);
 extern int sched_rt_can_attach(struct task_group *tg, struct task_struct *tsk);
+extern struct rt_rq *sched_rt_period_rt_rq(struct rt_bandwidth *rt_b, int cpu);
+extern struct rt_bandwidth *sched_rt_bandwidth_tg(struct task_group *tg);
+
+extern void free_dl_sched_group(struct task_group *tg);
+extern int alloc_dl_sched_group(struct task_group *tg, struct task_group *parent);
+extern void init_tg_dl_entry(struct task_group *tg, struct dl_rq *dl_rq,
+		struct sched_dl_entity *dl_se, int cpu,
+		struct sched_dl_entity *parent);
+extern int tg_has_dl_tasks(struct task_group *tg);
+extern u64 sched_group_dl_bw(struct task_group *tg);
+extern u64 sched_group_dl_total_bw(struct task_group *tg);
+extern int sched_dl_can_attach(struct task_group *tg, struct task_struct *tsk);
+
 
 extern struct task_group *sched_create_group(struct task_group *parent);
 extern void sched_online_group(struct task_group *tg,
@@ -1194,7 +1212,7 @@ static inline struct task_group *task_group(struct task_struct *p)
 /* Change a task's cfs_rq and parent entity if it moves across CPUs/groups */
 static inline void set_task_rq(struct task_struct *p, unsigned int cpu)
 {
-#if defined(CONFIG_FAIR_GROUP_SCHED) || defined(CONFIG_RT_GROUP_SCHED)
+#if defined(CONFIG_FAIR_GROUP_SCHED) || defined(CONFIG_RT_GROUP_SCHED) || defined(CONFIG_DEADLINE_GROUP_SCHED)
 	struct task_group *tg = task_group(p);
 #endif
 
-- 
2.14.3
