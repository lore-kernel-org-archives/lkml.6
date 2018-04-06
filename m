Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751649AbeDFR2r (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 13:28:47 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40296 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751276AbeDFR2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 13:28:46 -0400
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [PATCH] sched/fair: schedutil: update only with all info available
Date: Fri,  6 Apr 2018 18:28:35 +0100
Message-Id: <20180406172835.20078-1-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Schedutil is not properly updated when the first FAIR task wakes up on a
CPU and when a RQ is (un)throttled. This is mainly due to the current
integration strategy, which relies on updates being triggered implicitly
each time a cfs_rq's utilization is updated.

Those updates are currently provided (mainly) via
   cfs_rq_util_change()
which is used in:
 - update_cfs_rq_load_avg()
   when the utilization of a cfs_rq is updated
 - {attach,detach}_entity_load_avg()
This is done based on the idea that "we should callback schedutil
frequently enough" to properly update the CPU frequency at every
utilization change.

Since this recent schedutil update:

  commit 8f111bc357aa ("cpufreq/schedutil: Rewrite CPUFREQ_RT support")

we use additional RQ information to properly account for FAIR tasks
utilization. Specifically, cfs_rq::h_nr_running has to be non-zero
in sugov_aggregate_util() to sum up the cfs_rq's utilization.

However, cfs_rq::h_nr_running is usually updated as:

    enqueue_entity()
       ...
       update_load_avg()
          ...
          cfs_rq_util_change ==> trigger schedutil update
    ...
    cfs_rq->h_nr_running += number_of_tasks

both in enqueue_task_fair() as well as in unthrottle_cfs_rq().
A similar pattern is used also in dequeue_task_fair() and
throttle_cfs_rq() to remove tasks.

This means that we are likely to see a zero cfs_rq utilization when we
enqueue a task on an empty CPU, or a non-zero cfs_rq utilization when
instead, for example, we are throttling all the FAIR tasks of a CPU.

While the second issue is less important, since we are less likely to
reduce frequency when CPU utilization decreases, the first issue can
instead impact performance. Indeed, we potentially introduce a not desired
latency between a task enqueue on a CPU and its frequency increase.

Another possible unwanted side effect is the iowait boosting of a CPU
when we enqueue a task into a throttled cfs_rq.

Moreover, the current schedutil integration has these other downsides:

 - schedutil updates are triggered by RQ's load updates, which makes
   sense in general but it does not allow to know exactly which other RQ
   related information has been updated (e.g. h_nr_running).

 - increasing the chances to update schedutil does not always correspond
   to provide the most accurate information for a proper frequency
   selection, thus we can skip some updates.

 - we don't know exactly at which point a schedutil update is triggered,
   and thus potentially a frequency change started, and that's because
   the update is a side effect of cfs_rq_util_changed instead of an
   explicit call from the most suitable call path.

 - cfs_rq_util_change() is mainly a wrapper function for an already
   existing "public API", cpufreq_update_util(), to ensure we actually
   update schedutil only when we are updating a root RQ. Thus, especially
   when task groups are in use, most of the calls to this wrapper
   function are really not required.

 - the usage of a wrapper function is not completely consistent across
   fair.c, since we still need sometimes additional explicit calls to
   cpufreq_update_util(), for example to support the IOWAIT boot flag in
   the wakeup path

 - it makes it hard to integrate new features since it could require to
   change other function prototypes just to pass in an additional flag,
   as it happened for example here:

      commit ea14b57e8a18 ("sched/cpufreq: Provide migration hint")

All the above considered, let's try to make schedutil updates more
explicit in fair.c by:

 - removing the cfs_rq_util_change() wrapper function to use the
   cpufreq_update_util() public API only when root cfs_rq is updated

 - remove indirect and side-effect (sometimes not required) schedutil
   updates when the cfs_rq utilization is updated

 - call cpufreq_update_util() explicitly in the few call sites where it
   really makes sense and all the required information has been updated

By doing so, this patch mainly removes code and adds explicit calls to
schedutil only when we:
 - {enqueue,dequeue}_task_fair() a task to/from the root cfs_rq
 - (un)throttle_cfs_rq() a set of tasks up to the root cfs_rq
 - task_tick_fair() to update the utilization of the root cfs_rq

All the other code paths, currently _indirectly_ covered by a call to
update_load_avg(), are also covered by the above three calls.
Some already imply enqueue/dequeue calls:
 - switch_{to,from}_fair()
 - sched_move_task()
or are followed by enqueue/dequeue calls:
 - cpu_cgroup_fork() and
   post_init_entity_util_avg():
     are used at wakeup_new_task() time and thus already followed by an
     enqueue_task_fair()
 - migrate_task_rq_fair():
     updates the removed utilization but not the actual cfs_rq
     utilization, which is updated by a following sched event

This new proposal allows also to better aggregate schedutil related
flags, which are required only at enqueue_task_fair() time.
Indeed, IOWAIT and MIGRATION flags are now requested only when a task is
actually visible at the root cfs_rq level.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org

---

The SCHED_CPUFREQ_MIGRATION flags, recently introduced by:

   ea14b57e8a18 sched/cpufreq: Provide migration hint

is maintained although there are not actual usages so far in mainline
for this hint... do we really need it?
---
 kernel/sched/fair.c | 84 ++++++++++++++++++++++++-----------------------------
 1 file changed, 38 insertions(+), 46 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0951d1c58d2f..e726f91f0089 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -772,7 +772,7 @@ void post_init_entity_util_avg(struct sched_entity *se)
 			 * For !fair tasks do:
 			 *
 			update_cfs_rq_load_avg(now, cfs_rq);
-			attach_entity_load_avg(cfs_rq, se, 0);
+			attach_entity_load_avg(cfs_rq, se);
 			switched_from_fair(rq, p);
 			 *
 			 * such that the next switched_to_fair() has the
@@ -3009,29 +3009,6 @@ static inline void update_cfs_group(struct sched_entity *se)
 }
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 
-static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq, int flags)
-{
-	struct rq *rq = rq_of(cfs_rq);
-
-	if (&rq->cfs == cfs_rq || (flags & SCHED_CPUFREQ_MIGRATION)) {
-		/*
-		 * There are a few boundary cases this might miss but it should
-		 * get called often enough that that should (hopefully) not be
-		 * a real problem.
-		 *
-		 * It will not get called when we go idle, because the idle
-		 * thread is a different class (!fair), nor will the utilization
-		 * number include things like RT tasks.
-		 *
-		 * As is, the util number is not freq-invariant (we'd have to
-		 * implement arch_scale_freq_capacity() for that).
-		 *
-		 * See cpu_util().
-		 */
-		cpufreq_update_util(rq, flags);
-	}
-}
-
 #ifdef CONFIG_SMP
 /*
  * Approximate:
@@ -3712,9 +3689,6 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 	cfs_rq->load_last_update_time_copy = sa->last_update_time;
 #endif
 
-	if (decayed)
-		cfs_rq_util_change(cfs_rq, 0);
-
 	return decayed;
 }
 
@@ -3726,7 +3700,7 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
  * Must call update_cfs_rq_load_avg() before this, since we rely on
  * cfs_rq->avg.last_update_time being current.
  */
-static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
+static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	u32 divider = LOAD_AVG_MAX - 1024 + cfs_rq->avg.period_contrib;
 
@@ -3762,7 +3736,6 @@ static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 
 	add_tg_cfs_propagate(cfs_rq, se->avg.load_sum);
 
-	cfs_rq_util_change(cfs_rq, flags);
 }
 
 /**
@@ -3781,7 +3754,6 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 
 	add_tg_cfs_propagate(cfs_rq, -se->avg.load_sum);
 
-	cfs_rq_util_change(cfs_rq, 0);
 }
 
 /*
@@ -3818,7 +3790,7 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 		 *
 		 * IOW we're enqueueing a task on a new CPU.
 		 */
-		attach_entity_load_avg(cfs_rq, se, SCHED_CPUFREQ_MIGRATION);
+		attach_entity_load_avg(cfs_rq, se);
 		update_tg_load_avg(cfs_rq, 0);
 
 	} else if (decayed && (flags & UPDATE_TG))
@@ -4028,13 +4000,12 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 
 static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int not_used1)
 {
-	cfs_rq_util_change(cfs_rq, 0);
 }
 
 static inline void remove_entity_load_avg(struct sched_entity *se) {}
 
 static inline void
-attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags) {}
+attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) {}
 static inline void
 detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) {}
 
@@ -4762,8 +4733,11 @@ static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
 			dequeue = 0;
 	}
 
-	if (!se)
+	/* The tasks are no more visible from the root cfs_rq */
+	if (!se) {
 		sub_nr_running(rq, task_delta);
+		cpufreq_update_util(rq, 0);
+	}
 
 	cfs_rq->throttled = 1;
 	cfs_rq->throttled_clock = rq_clock(rq);
@@ -4825,8 +4799,11 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 			break;
 	}
 
-	if (!se)
+	/* The tasks are now visible from the root cfs_rq */
+	if (!se) {
 		add_nr_running(rq, task_delta);
+		cpufreq_update_util(rq, 0);
+	}
 
 	/* Determine whether we need to wake up potentially idle CPU: */
 	if (rq->curr == rq->idle && rq->cfs.nr_running)
@@ -5356,14 +5333,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &p->se;
 
-	/*
-	 * If in_iowait is set, the code below may not trigger any cpufreq
-	 * utilization updates, so do it here explicitly with the IOWAIT flag
-	 * passed.
-	 */
-	if (p->in_iowait)
-		cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
-
 	for_each_sched_entity(se) {
 		if (se->on_rq)
 			break;
@@ -5394,9 +5363,27 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		update_cfs_group(se);
 	}
 
-	if (!se)
+	/* The task is visible from the root cfs_rq */
+	if (!se) {
+		unsigned int flags = 0;
+
 		add_nr_running(rq, 1);
 
+		if (p->in_iowait)
+			flags |= SCHED_CPUFREQ_IOWAIT;
+
+		/*
+		 * !last_update_time means we've passed through
+		 * migrate_task_rq_fair() indicating we migrated.
+		 *
+		 * IOW we're enqueueing a task on a new CPU.
+		 */
+		if (!p->se.avg.last_update_time)
+			flags |= SCHED_CPUFREQ_MIGRATION;
+
+		cpufreq_update_util(rq, flags);
+	}
+
 	util_est_enqueue(&rq->cfs, p);
 	hrtick_update(rq);
 }
@@ -5454,8 +5441,11 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		update_cfs_group(se);
 	}
 
-	if (!se)
+	/* The task is no more visible from the root cfs_rq */
+	if (!se) {
 		sub_nr_running(rq, 1);
+		cpufreq_update_util(rq, 0);
+	}
 
 	util_est_dequeue(&rq->cfs, p, task_sleep);
 	hrtick_update(rq);
@@ -9950,6 +9940,8 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 
 	if (static_branch_unlikely(&sched_numa_balancing))
 		task_tick_numa(rq, curr);
+
+	cpufreq_update_util(rq, 0);
 }
 
 /*
@@ -10087,7 +10079,7 @@ static void attach_entity_cfs_rq(struct sched_entity *se)
 
 	/* Synchronize entity with its cfs_rq */
 	update_load_avg(cfs_rq, se, sched_feat(ATTACH_AGE_LOAD) ? 0 : SKIP_AGE_LOAD);
-	attach_entity_load_avg(cfs_rq, se, 0);
+	attach_entity_load_avg(cfs_rq, se);
 	update_tg_load_avg(cfs_rq, false);
 	propagate_entity_cfs_rq(se);
 }
-- 
2.15.1
