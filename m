Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751276AbeEUIwt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 04:52:49 -0400
Received: from foss.arm.com ([217.140.101.70]:45132 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750945AbeEUIvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 04:51:42 -0400
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>
Subject: [PATCH v3 2/2] cpufreq: schedutil: Cleanup and document iowait boost
Date: Mon, 21 May 2018 09:51:20 +0100
Message-Id: <20180521085120.7902-3-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180521085120.7902-1-patrick.bellasi@arm.com>
References: <20180521085120.7902-1-patrick.bellasi@arm.com>
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
functionality within within few dedicated functions and better define
their role:

- sugov_iowait_boost: set/increase the IO wait boost of a CPU
- sugov_iowait_apply: apply/reduce the IO wait boost of a CPU

Both these two function are used at every sugov updated and they makes
use of a unified IO wait boost reset policy provided by:

- sugov_iowait_reset: reset/disable the IO wait boost of a CPU
     if a CPU is not updated for more then one tick

This makes possible a cleaner and more self-contained design for the IO
wait boosting code since the rest of the sugov update routines, both for
single and shared frequency domains, follow the same template:

   /* Configure IO boost, if required */
   sugov_iowait_boost()

   /* Return here if freq change is in progress or throttled */

   /* Collect and aggregate utilization information */
   sugov_get_util()
   sugov_aggregate_util()

   /*
    * Add IO boost, if currently enabled, on top of the aggregated
    * utilization value
    */
   sugov_iowait_apply()

As a extra bonus, let's also add the documentation for the new
functions and better align the in-code documentation.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org

---
Changes in v3:
 - renamed the iowait boost functions (Peter)
 - moved boost reset into a dedicated function (Peter)
 - split the fix into a separated patch (Viresh)
---
 kernel/sched/cpufreq_schedutil.c | 152 +++++++++++++++++++++++++++------------
 1 file changed, 107 insertions(+), 45 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index c4063e578e4d..1a50e1e95f4b 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -51,7 +51,7 @@ struct sugov_cpu {
 	bool			iowait_boost_pending;
 	unsigned int		iowait_boost;
 	unsigned int		iowait_boost_max;
-	u64 last_update;
+	u64			last_update;
 
 	/* The fields below are only needed when sharing a policy: */
 	unsigned long		util_cfs;
@@ -201,45 +201,120 @@ static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
 	return min(util, sg_cpu->max);
 }
 
-static void sugov_set_iowait_boost(struct sugov_cpu *sg_cpu, u64 time, unsigned int flags)
+/**
+ * sugov_iowait_reset() - Reset the IO boost status of a CPU.
+ * @sg_cpu: the sugov data for the CPU to boost
+ * @time: the update time from the caller
+ * @set_iowait_boost: true if an IO boost has been requested
+ *
+ * The IO wait boost of a task is disabled after a tick since the last update
+ * of a CPU. If a new IO wait boost is requested after more then a tick, then
+ * we enable the boost starting from the minimum frequency, which improves
+ * energy efficiency by ignoring sporadic wakeups from IO.
+ */
+static bool sugov_iowait_reset(struct sugov_cpu *sg_cpu, u64 time,
+			       bool set_iowait_boost)
 {
-	/* Clear iowait_boost if the CPU apprears to have been idle. */
-	if (sg_cpu->iowait_boost) {
-		s64 delta_ns = time - sg_cpu->last_update;
+	s64 delta_ns = time - sg_cpu->last_update;
 
-		if (delta_ns > TICK_NSEC) {
-			sg_cpu->iowait_boost = 0;
-			sg_cpu->iowait_boost_pending = false;
-		}
-	}
+	/* Reset boost only if a tick has elapsed since last request */
+	if (delta_ns <= TICK_NSEC)
+		return false;
 
-	if (flags & SCHED_CPUFREQ_IOWAIT) {
-		if (sg_cpu->iowait_boost_pending)
-			return;
+	sg_cpu->iowait_boost = set_iowait_boost
+		? sg_cpu->sg_policy->policy->min : 0;
+	sg_cpu->iowait_boost_pending = set_iowait_boost;
 
-		sg_cpu->iowait_boost_pending = true;
+	return true;
+}
 
-		if (sg_cpu->iowait_boost) {
-			sg_cpu->iowait_boost <<= 1;
-			if (sg_cpu->iowait_boost > sg_cpu->iowait_boost_max)
-				sg_cpu->iowait_boost = sg_cpu->iowait_boost_max;
-		} else {
-			sg_cpu->iowait_boost = sg_cpu->sg_policy->policy->min;
-		}
+/**
+ * sugov_iowait_boost() - Updates the IO boost status of a CPU.
+ * @sg_cpu: the sugov data for the CPU to boost
+ * @time: the update time from the caller
+ * @flags: SCHED_CPUFREQ_IOWAIT if the task is waking up after an IO wait
+ *
+ * Each time a task wakes up after an IO operation, the CPU utilization can be
+ * boosted to a certain utilization which doubles at each "frequent and
+ * successive" wakeup from IO, ranging from the utilization of the minimum
+ * OPP to the utilization of the maximum OPP.
+ * To keep doubling, an IO boost has to be requested at least once per tick,
+ * otherwise we restart from the utilization of the minimum OPP.
+ */
+static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
+			       unsigned int flags)
+{
+	bool set_iowait_boost = flags & SCHED_CPUFREQ_IOWAIT;
+
+	/* Reset boost if the CPU appears to have been idle enough */
+	if (sg_cpu->iowait_boost &&
+	    sugov_iowait_reset(sg_cpu, time, set_iowait_boost))
+		return;
+
+	/* Boost only tasks waking up after IO */
+	if (!set_iowait_boost)
+		return;
+
+	/* Ensure boost doubles only one time at each request */
+	if (sg_cpu->iowait_boost_pending)
+		return;
+	sg_cpu->iowait_boost_pending = true;
+
+	/* Double the boost at each request */
+	if (sg_cpu->iowait_boost) {
+		sg_cpu->iowait_boost <<= 1;
+		if (sg_cpu->iowait_boost > sg_cpu->iowait_boost_max)
+			sg_cpu->iowait_boost = sg_cpu->iowait_boost_max;
+		return;
 	}
+
+	/* First wakeup after IO: start with minimum boost */
+	sg_cpu->iowait_boost = sg_cpu->sg_policy->policy->min;
 }
 
-static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, unsigned long *util,
-			       unsigned long *max)
+/**
+ * sugov_iowait_apply() - Apply the IO boost to a CPU.
+ * @sg_cpu: the sugov data for the cpu to boost
+ * @time: the update time from the caller
+ * @util: the utilization to (eventually) boost
+ * @max: the maximum value the utilization can be boosted to
+ *
+ * A CPU running a task which woken up after an IO operation can have its
+ * utilization boosted to speed up the completion of those IO operations.
+ * The IO boost value is increased each time a task wakes up from IO, in
+ * sugov_iowait_apply(), and it's instead decreased by this function,
+ * each time an increase has not been requested (!iowait_boost_pending).
+ *
+ * A CPU which also appears to have been idle for at least one tick has also
+ * its IO boost utilization reset.
+ *
+ * This mechanism is designed to boost high frequently IO waiting tasks, while
+ * being more conservative on tasks which does sporadic IO operations.
+ */
+static void sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
+			       unsigned long *util, unsigned long *max)
 {
 	unsigned int boost_util, boost_max;
 
+	/* No boost currently required */
 	if (!sg_cpu->iowait_boost)
 		return;
 
+	/* Reset boost if the CPU appears to have been idle enough */
+	if (sugov_iowait_reset(sg_cpu, time, false))
+		return;
+
+	/*
+	 * An IO waiting task has just woken up:
+	 * allow to further double the boost value
+	 */
 	if (sg_cpu->iowait_boost_pending) {
 		sg_cpu->iowait_boost_pending = false;
 	} else {
+		/*
+		 * Otherwise: reduce the boost value and disable it when we
+		 * reach the minimum.
+		 */
 		sg_cpu->iowait_boost >>= 1;
 		if (sg_cpu->iowait_boost < sg_cpu->sg_policy->policy->min) {
 			sg_cpu->iowait_boost = 0;
@@ -247,9 +322,12 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, unsigned long *util,
 		}
 	}
 
+	/*
+	 * Apply the current boost value: a CPU is boosted only if its current
+	 * utilization is smaller then the current IO boost level.
+	 */
 	boost_util = sg_cpu->iowait_boost;
 	boost_max = sg_cpu->iowait_boost_max;
-
 	if (*util * boost_max < *max * boost_util) {
 		*util = boost_util;
 		*max = boost_max;
@@ -288,7 +366,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 	unsigned int next_f;
 	bool busy;
 
-	sugov_set_iowait_boost(sg_cpu, time, flags);
+	sugov_iowait_boost(sg_cpu, time, flags);
 	sg_cpu->last_update = time;
 
 	ignore_dl_rate_limit(sg_cpu, sg_policy);
@@ -301,7 +379,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 	sugov_get_util(sg_cpu);
 	max = sg_cpu->max;
 	util = sugov_aggregate_util(sg_cpu);
-	sugov_iowait_boost(sg_cpu, &util, &max);
+	sugov_iowait_apply(sg_cpu, time, &util, &max);
 	next_f = get_next_freq(sg_policy, util, max);
 	/*
 	 * Do not reduce the frequency if the CPU has not been idle
@@ -328,28 +406,12 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
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
+		sugov_iowait_apply(j_sg_cpu, time, &j_util, &j_max);
+
 		if (j_util * max > j_max * util) {
 			util = j_util;
 			max = j_max;
@@ -368,7 +430,7 @@ sugov_update_shared(struct update_util_data *hook, u64 time, unsigned int flags)
 
 	raw_spin_lock(&sg_policy->update_lock);
 
-	sugov_set_iowait_boost(sg_cpu, time, flags);
+	sugov_iowait_boost(sg_cpu, time, flags);
 	sg_cpu->last_update = time;
 
 	ignore_dl_rate_limit(sg_cpu, sg_policy);
-- 
2.15.1
