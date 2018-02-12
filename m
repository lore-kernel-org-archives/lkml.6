Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752501AbeBLRLf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 12:11:35 -0500
Received: from outbound-smtp20.blacknight.com ([46.22.139.247]:54886 "EHLO
        outbound-smtp20.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751527AbeBLRLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 12:11:33 -0500
From: Mel Gorman <mgorman@techsingularity.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 2/2] sched/numa: Delay retrying placement for automatic NUMA balance after wake_affine
Date: Mon, 12 Feb 2018 17:11:31 +0000
Message-Id: <20180212171131.26139-3-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180212171131.26139-1-mgorman@techsingularity.net>
References: <20180212171131.26139-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If wake_affine pulls a task to another node for any reason and the node is
no longer preferred then temporarily stop automatic NUMA balancing pulling
the task back. Otherwise, tasks with a strong waker/wakee relationship
may constantly fight automatic NUMA balancing over where a task should
be placed.

Once again netperf is interesting here. The performance barely changes
but automatic NUMA balancing is interesting.

Hmean     send-64         354.67 (   0.00%)      352.15 (  -0.71%)
Hmean     send-128        702.91 (   0.00%)      693.84 (  -1.29%)
Hmean     send-256       1350.07 (   0.00%)     1344.19 (  -0.44%)
Hmean     send-1024      5124.38 (   0.00%)     4941.24 (  -3.57%)
Hmean     send-2048      9687.44 (   0.00%)     9624.45 (  -0.65%)
Hmean     send-3312     14577.64 (   0.00%)    14514.35 (  -0.43%)
Hmean     send-4096     16393.62 (   0.00%)    16488.30 (   0.58%)
Hmean     send-8192     26877.26 (   0.00%)    26431.63 (  -1.66%)
Hmean     send-16384    38683.43 (   0.00%)    38264.91 (  -1.08%)
Hmean     recv-64         354.67 (   0.00%)      352.15 (  -0.71%)
Hmean     recv-128        702.91 (   0.00%)      693.84 (  -1.29%)
Hmean     recv-256       1350.07 (   0.00%)     1344.19 (  -0.44%)
Hmean     recv-1024      5124.38 (   0.00%)     4941.24 (  -3.57%)
Hmean     recv-2048      9687.43 (   0.00%)     9624.45 (  -0.65%)
Hmean     recv-3312     14577.59 (   0.00%)    14514.35 (  -0.43%)
Hmean     recv-4096     16393.55 (   0.00%)    16488.20 (   0.58%)
Hmean     recv-8192     26876.96 (   0.00%)    26431.29 (  -1.66%)
Hmean     recv-16384    38682.41 (   0.00%)    38263.94 (  -1.08%)

NUMA alloc hit                 1465986     1423090
NUMA alloc miss                      0           0
NUMA interleave hit                  0           0
NUMA alloc local               1465897     1423003
NUMA base PTE updates             1473        1420
NUMA huge PMD updates                0           0
NUMA page range updates           1473        1420
NUMA hint faults                  1383        1312
NUMA hint local faults             451         124
NUMA hint local percent             32           9

There is a slight degrading in performance but there are slightly fewer
NUMA faults. There is a large drop in the percentage of local faults but
the bulk of migrations for netperf are in small shared libraries so it's
reflecting the fact that automatic NUMA balancing has backed off. This is
a case where despite wake_affine and automatic NUMA balancing fighting
for placement that there is a marginal benefit to rescheduling to local
data quickly. However, it should be noted that wake_affine and automatic
NUMA balancing fighting each other constantly is undesirable.

However, the benefit in other cases is large. This is the result for NAS
with the D class sizing on a 4-socket machine

                          4.15.0                 4.15.0
                    sdnuma-v1r23       delayretry-v1r23
Time cg.D      557.00 (   0.00%)      431.82 (  22.47%)
Time ep.D       77.83 (   0.00%)       79.01 (  -1.52%)
Time is.D       26.46 (   0.00%)       26.64 (  -0.68%)
Time lu.D      727.14 (   0.00%)      597.94 (  17.77%)
Time mg.D      191.35 (   0.00%)      146.85 (  23.26%)

              4.15.0      4.15.0
        sdnuma-v1r23delayretry-v1r23
User        75665.20    70413.30
System      20321.59     8861.67
Elapsed       766.13      634.92

Minor Faults                  16528502     7127941
Major Faults                      4553        5068
NUMA alloc local               6963197     6749135
NUMA base PTE updates        366409093   107491434
NUMA huge PMD updates           687556      198880
NUMA page range updates      718437765   209317994
NUMA hint faults              13643410     4601187
NUMA hint local faults         9212593     3063996
NUMA hint local percent             67          66

Note the massive reduction in system CPU usage even though the percentage
of local faults is barely affected. There is a massive reduction in the
number of PTE updates showing that automatic NUMA balancing has backed off.
A critical observation is also that there is a massive reduction in minor
faults which is due to far fewer NUMA hinting faults being trapped.

Other workloads like hackbench, tbench, dbench and schbench are barely
affected. dbench shows a mix of gains and losses depending on the machine
although in general, the results are more stable.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0192448e43a2..396d95f06f35 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1869,6 +1869,7 @@ static int task_numa_migrate(struct task_struct *p)
 static void numa_migrate_preferred(struct task_struct *p)
 {
 	unsigned long interval = HZ;
+	unsigned long numa_migrate_retry;
 
 	/* This task has no NUMA fault statistics yet */
 	if (unlikely(p->numa_preferred_nid == -1 || !p->numa_faults))
@@ -1876,7 +1877,18 @@ static void numa_migrate_preferred(struct task_struct *p)
 
 	/* Periodically retry migrating the task to the preferred node */
 	interval = min(interval, msecs_to_jiffies(p->numa_scan_period) / 16);
-	p->numa_migrate_retry = jiffies + interval;
+	numa_migrate_retry = jiffies + interval;
+
+	/*
+	 * Check that the new retry threshold is after the current one. If
+	 * the retry is in the future, it implies that wake_affine has
+	 * temporarily asked NUMA balancing to backoff from placement.
+	 */
+	if (numa_migrate_retry > p->numa_migrate_retry)
+		return;
+
+	/* Safe to try placing the task on the preferred node */
+	p->numa_migrate_retry = numa_migrate_retry;
 
 	/* Success if task is already running on preferred CPU */
 	if (task_node(p) == p->numa_preferred_nid)
@@ -5765,6 +5777,45 @@ wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
 	return this_eff_load < prev_eff_load ? this_cpu : nr_cpumask_bits;
 }
 
+#ifdef CONFIG_NUMA_BALANCING
+static void
+update_wa_numa_placement(struct task_struct *p, int prev_cpu, int target)
+{
+	unsigned long interval;
+
+	if (!static_branch_likely(&sched_numa_balancing))
+		return;
+
+	/* If balancing has no preference then accept the target */
+	if (p->numa_preferred_nid == -1)
+		return;
+
+	/* If the wakeup is not affecting locality then accept the target */
+	if (cpus_share_cache(prev_cpu, target))
+		return;
+
+	/*
+	 * Temporarily prevent NUMA balancing trying to place waker/wakee after
+	 * wakee has been moved by wake_affine. This will potentially allow
+	 * related tasks to converge and update their data placement. The
+	 * 4 * numa_scan_period is to allow the two-pass filter to migrate
+	 * hot data to the wakers node.
+	 */
+	interval = max(sysctl_numa_balancing_scan_delay,
+			 p->numa_scan_period << 2);
+	p->numa_migrate_retry = jiffies + msecs_to_jiffies(interval);
+
+	interval = max(sysctl_numa_balancing_scan_delay,
+			 current->numa_scan_period << 2);
+	current->numa_migrate_retry = jiffies + msecs_to_jiffies(interval);
+}
+#else
+static void
+update_wa_numa_placement(struct task_struct *p, int prev_cpu, int target)
+{
+}
+#endif
+
 static int wake_affine(struct sched_domain *sd, struct task_struct *p,
 		       int this_cpu, int prev_cpu, int sync)
 {
@@ -5780,6 +5831,7 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
 	if (target == nr_cpumask_bits)
 		return prev_cpu;
 
+	update_wa_numa_placement(p, prev_cpu, target);
 	schedstat_inc(sd->ttwu_move_affine);
 	schedstat_inc(p->se.statistics.nr_wakeups_affine);
 	return target;
-- 
2.15.1
