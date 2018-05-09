Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965534AbeEIQbT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 12:31:19 -0400
Received: from outbound-smtp12.blacknight.com ([46.22.139.17]:46182 "EHLO
        outbound-smtp12.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934914AbeEIQbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 12:31:18 -0400
Date: Wed, 9 May 2018 17:31:15 +0100
From: Mel Gorman <mgorman@techsingularity.net>
To: mingo@kernel.org, peterz@infradead.org
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        torvalds@linux-foundation.org, tglx@linutronix.de, hpa@zytor.com,
        efault@gmx.de, linux-kernel@vger.kernel.org, matt@codeblueprint.co.uk,
        ggherdovich@suse.cz, mpe@ellerman.id.au
Subject: [PATCH] Revert "sched/numa: Delay retrying placement for automatic
 NUMA balance after wake_affine()"
Message-ID: <20180509163115.6fnnyeg4vdm2ct4v@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 7347fc87dfe6b7315e74310ee1243dc222c68086.

Srikar Dronamra pointed out that while the commit in question did show
a performance improvement on ppc64, it did so at the cost of disabling
active CPU migration by automatic NUMA balancing which was not the intent.
The issue was that a serious flaw in the logic failed to ever active balance
if SD_WAKE_AFFINE was disabled on scheduler domains. Even when it's enabled,
the logic is still bizarre and against the original intent.

Investigation showed that fixing the patch in either the way he suggested,
using the correct comparison for jiffies values or introducing a new
numa_migrate_deferred variable in task_struct all perform similarly to a
revert with a mix of gains and losses depending on the workload, machine
and socket count.

The original intent of the commit was to handle a problem whereby
wake_affine, idle balancing and automatic NUMA balancing disagree on the
appropriate placement for a task. This was particularly true for cases where
a single task was a massive waker of tasks but where wake_wide logic did
not apply.  This was particularly noticeable when a futex (a barrier) woke
all worker threads and tried pulling the wakees to the waker nodes. In that
specific case, it could be handled by tuning MPI or openMP appropriately,
but the behavior is not illogical and was worth attempting to fix. However,
the approach was wrong. Given that we're at rc4 and a fix is not obvious,
it's better to play safe, revert this commit and retry later.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 57 +----------------------------------------------------
 1 file changed, 1 insertion(+), 56 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 54dc31e7ab9b..f43627c6bb3d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1854,7 +1854,6 @@ static int task_numa_migrate(struct task_struct *p)
 static void numa_migrate_preferred(struct task_struct *p)
 {
 	unsigned long interval = HZ;
-	unsigned long numa_migrate_retry;
 
 	/* This task has no NUMA fault statistics yet */
 	if (unlikely(p->numa_preferred_nid == -1 || !p->numa_faults))
@@ -1862,18 +1861,7 @@ static void numa_migrate_preferred(struct task_struct *p)
 
 	/* Periodically retry migrating the task to the preferred node */
 	interval = min(interval, msecs_to_jiffies(p->numa_scan_period) / 16);
-	numa_migrate_retry = jiffies + interval;
-
-	/*
-	 * Check that the new retry threshold is after the current one. If
-	 * the retry is in the future, it implies that wake_affine has
-	 * temporarily asked NUMA balancing to backoff from placement.
-	 */
-	if (numa_migrate_retry > p->numa_migrate_retry)
-		return;
-
-	/* Safe to try placing the task on the preferred node */
-	p->numa_migrate_retry = numa_migrate_retry;
+	p->numa_migrate_retry = jiffies + interval;
 
 	/* Success if task is already running on preferred CPU */
 	if (task_node(p) == p->numa_preferred_nid)
@@ -5922,48 +5910,6 @@ wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
 	return this_eff_load < prev_eff_load ? this_cpu : nr_cpumask_bits;
 }
 
-#ifdef CONFIG_NUMA_BALANCING
-static void
-update_wa_numa_placement(struct task_struct *p, int prev_cpu, int target)
-{
-	unsigned long interval;
-
-	if (!static_branch_likely(&sched_numa_balancing))
-		return;
-
-	/* If balancing has no preference then continue gathering data */
-	if (p->numa_preferred_nid == -1)
-		return;
-
-	/*
-	 * If the wakeup is not affecting locality then it is neutral from
-	 * the perspective of NUMA balacing so continue gathering data.
-	 */
-	if (cpu_to_node(prev_cpu) == cpu_to_node(target))
-		return;
-
-	/*
-	 * Temporarily prevent NUMA balancing trying to place waker/wakee after
-	 * wakee has been moved by wake_affine. This will potentially allow
-	 * related tasks to converge and update their data placement. The
-	 * 4 * numa_scan_period is to allow the two-pass filter to migrate
-	 * hot data to the wakers node.
-	 */
-	interval = max(sysctl_numa_balancing_scan_delay,
-			 p->numa_scan_period << 2);
-	p->numa_migrate_retry = jiffies + msecs_to_jiffies(interval);
-
-	interval = max(sysctl_numa_balancing_scan_delay,
-			 current->numa_scan_period << 2);
-	current->numa_migrate_retry = jiffies + msecs_to_jiffies(interval);
-}
-#else
-static void
-update_wa_numa_placement(struct task_struct *p, int prev_cpu, int target)
-{
-}
-#endif
-
 static int wake_affine(struct sched_domain *sd, struct task_struct *p,
 		       int this_cpu, int prev_cpu, int sync)
 {
@@ -5979,7 +5925,6 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
 	if (target == nr_cpumask_bits)
 		return prev_cpu;
 
-	update_wa_numa_placement(p, prev_cpu, target);
 	schedstat_inc(sd->ttwu_move_affine);
 	schedstat_inc(p->se.statistics.nr_wakeups_affine);
 	return target;
