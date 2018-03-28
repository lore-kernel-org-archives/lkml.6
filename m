Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752065AbeC1JHl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 05:07:41 -0400
Received: from foss.arm.com ([217.140.101.70]:38456 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751750AbeC1JHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 05:07:38 -0400
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>,
        Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>
Subject: [PATCH] cpufreq/schedutil: Cleanup and document iowait boost
Date: Wed, 28 Mar 2018 10:07:21 +0100
Message-Id: <20180328090721.26068-1-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The iowait boosting code has been recently updated to add a progressive
boosting behavior which allows to be less aggressive in boosting tasks
doing only sporadic IO operations, thus being more energy efficient for
example on mobile platforms.

The current code is now however a bit convoluted. Some functionalities
(e.g. iowait boost reset) are replicated in different paths and their
documentation is slightly misaligned.

Let's cleanup the code by consolidating all the IO wait boosting related
functionality inside the already existing functions and better define
their role:

- sugov_set_iowait_boost: is now in charge only to set/increase the IO
     wait boost, every time a task wakes up from an IO wait.

- sugov_iowait_boost: is now in charge to reset/reduce the IO wait
     boost, every time a sugov update is triggered, as well as
     to (eventually) enforce the currently required IO boost value.

This is possible since these two functions are already used one after
the other, both in single and shared frequency domains, following the
same template:

   /* Configure IO boost, if required */
   sugov_set_iowait_boost()

   /* Return here if freq change is in progress or throttled */

   /* Collect and aggregate utilization information */
   sugov_get_util()
   sugov_aggregate_util()

   /* Add IO boost if currently enabled */
   sugov_iowait_boost()

As a extra bonus, let's also add the documentation for these two
functions and better align the in-code documentation.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Steve Muckle <smuckle@google.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org

---
Based on today's tip/sched/core:
   b720342 sched/core: Update preempt_notifier_key to modern API
---
 kernel/sched/cpufreq_schedutil.c | 111 ++++++++++++++++++++++++---------------
 1 file changed, 68 insertions(+), 43 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 2b124811947d..c840b0626735 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -201,43 +201,80 @@ static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
 	return min(util, sg_cpu->max);
 }
 
-static void sugov_set_iowait_boost(struct sugov_cpu *sg_cpu, u64 time, unsigned int flags)
+/**
+ * sugov_set_iowait_boost updates the IO boost at each wakeup from IO.
+ * @sg_cpu: the sugov data for the CPU to boost
+ * @flags:  SCHED_CPUFREQ_IOWAIT if the task is waking up after an IO wait
+ *
+ * Each time a task wakes up after an IO operation, the CPU utilization can be
+ * boosted to a certain utilization which is doubled at each wakeup
+ * from IO, starting from the utilization of the minimum OPP to that of the
+ * maximum one.
+ */
+static void sugov_set_iowait_boost(struct sugov_cpu *sg_cpu, unsigned int flags)
 {
-	if (flags & SCHED_CPUFREQ_IOWAIT) {
-		if (sg_cpu->iowait_boost_pending)
-			return;
 
-		sg_cpu->iowait_boost_pending = true;
+	/* Boost only tasks waking up after IO */
+	if (!(flags & SCHED_CPUFREQ_IOWAIT))
+		return;
 
-		if (sg_cpu->iowait_boost) {
-			sg_cpu->iowait_boost <<= 1;
-			if (sg_cpu->iowait_boost > sg_cpu->iowait_boost_max)
-				sg_cpu->iowait_boost = sg_cpu->iowait_boost_max;
-		} else {
-			sg_cpu->iowait_boost = sg_cpu->sg_policy->policy->min;
-		}
-	} else if (sg_cpu->iowait_boost) {
-		s64 delta_ns = time - sg_cpu->last_update;
+	/* Ensure IO boost doubles only one time at each frequency increase */
+	if (sg_cpu->iowait_boost_pending)
+		return;
+	sg_cpu->iowait_boost_pending = true;
 
-		/* Clear iowait_boost if the CPU apprears to have been idle. */
-		if (delta_ns > TICK_NSEC) {
-			sg_cpu->iowait_boost = 0;
-			sg_cpu->iowait_boost_pending = false;
-		}
+	/* Double the IO boost at each frequency increase */
+	if (sg_cpu->iowait_boost) {
+		sg_cpu->iowait_boost <<= 1;
+		if (sg_cpu->iowait_boost > sg_cpu->iowait_boost_max)
+			sg_cpu->iowait_boost = sg_cpu->iowait_boost_max;
+		return;
 	}
+
+	/* At first wakeup after IO, start with minimum boost */
+	sg_cpu->iowait_boost = sg_cpu->sg_policy->policy->min;
 }
 
-static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, unsigned long *util,
-			       unsigned long *max)
+/**
+ * sugov_iowait_boost boosts a CPU after a wakeup from IO.
+ * @sg_cpu: the sugov data for the cpu to boost
+ * @time:   the update time from the caller
+ * @util:   the utilization to (eventually) boost
+ * @max:    the maximum value the utilization can be boosted to
+ *
+ * A CPU running a task which woken up after an IO operation can have its
+ * utilization boosted to speed up the completion of those IO operations.
+ * The IO boost value is increased each time a task wakes up from IO, in
+ * sugov_set_iowait_boost(), and it's instead decreased by this function,
+ * each time an increase has not been requested (!iowait_boost_pending).
+ *
+ * A CPU which also appears to have been idle for at least one tick has also
+ * its IO boost utilization reset.
+ *
+ * This mechanism is designed to boost high frequently IO waiting tasks, while
+ * being more conservative on tasks which does sporadic IO operations.
+ */
+static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
+			       unsigned long *util, unsigned long *max)
 {
 	unsigned int boost_util, boost_max;
 
-	if (!sg_cpu->iowait_boost)
+	/* Clear boost if the CPU appears to have been idle enough */
+	if (sg_cpu->iowait_boost) {
+		s64 delta_ns = time - sg_cpu->last_update;
+
+		if (delta_ns > TICK_NSEC) {
+			sg_cpu->iowait_boost = 0;
+			sg_cpu->iowait_boost_pending = false;
+		}
 		return;
+	}
 
+	/* An IO waiting task has just woken up, use the boost value */
 	if (sg_cpu->iowait_boost_pending) {
 		sg_cpu->iowait_boost_pending = false;
 	} else {
+		/* Reduce the boost value otherwise */
 		sg_cpu->iowait_boost >>= 1;
 		if (sg_cpu->iowait_boost < sg_cpu->sg_policy->policy->min) {
 			sg_cpu->iowait_boost = 0;
@@ -248,6 +285,10 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, unsigned long *util,
 	boost_util = sg_cpu->iowait_boost;
 	boost_max = sg_cpu->iowait_boost_max;
 
+	/*
+	 * A CPU is boosted only if its current utilization is smaller then
+	 * the current IO boost level.
+	 */
 	if (*util * boost_max < *max * boost_util) {
 		*util = boost_util;
 		*max = boost_max;
@@ -286,7 +327,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 	unsigned int next_f;
 	bool busy;
 
-	sugov_set_iowait_boost(sg_cpu, time, flags);
+	sugov_set_iowait_boost(sg_cpu, flags);
 	sg_cpu->last_update = time;
 
 	ignore_dl_rate_limit(sg_cpu, sg_policy);
@@ -299,7 +340,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 	sugov_get_util(sg_cpu);
 	max = sg_cpu->max;
 	util = sugov_aggregate_util(sg_cpu);
-	sugov_iowait_boost(sg_cpu, &util, &max);
+	sugov_iowait_boost(sg_cpu, time, &util, &max);
 	next_f = get_next_freq(sg_policy, util, max);
 	/*
 	 * Do not reduce the frequency if the CPU has not been idle
@@ -325,28 +366,12 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
 	for_each_cpu(j, policy->cpus) {
 		struct sugov_cpu *j_sg_cpu = &per_cpu(sugov_cpu, j);
 		unsigned long j_util, j_max;
-		s64 delta_ns;
 
 		sugov_get_util(j_sg_cpu);
-
-		/*
-		 * If the CFS CPU utilization was last updated before the
-		 * previous frequency update and the time elapsed between the
-		 * last update of the CPU utilization and the last frequency
-		 * update is long enough, reset iowait_boost and util_cfs, as
-		 * they are now probably stale. However, still consider the
-		 * CPU contribution if it has some DEADLINE utilization
-		 * (util_dl).
-		 */
-		delta_ns = time - j_sg_cpu->last_update;
-		if (delta_ns > TICK_NSEC) {
-			j_sg_cpu->iowait_boost = 0;
-			j_sg_cpu->iowait_boost_pending = false;
-		}
-
 		j_max = j_sg_cpu->max;
 		j_util = sugov_aggregate_util(j_sg_cpu);
-		sugov_iowait_boost(j_sg_cpu, &j_util, &j_max);
+		sugov_iowait_boost(j_sg_cpu, time, &j_util, &j_max);
+
 		if (j_util * max > j_max * util) {
 			util = j_util;
 			max = j_max;
@@ -365,7 +390,7 @@ sugov_update_shared(struct update_util_data *hook, u64 time, unsigned int flags)
 
 	raw_spin_lock(&sg_policy->update_lock);
 
-	sugov_set_iowait_boost(sg_cpu, time, flags);
+	sugov_set_iowait_boost(sg_cpu, flags);
 	sg_cpu->last_update = time;
 
 	ignore_dl_rate_limit(sg_cpu, sg_policy);
-- 
2.15.1
