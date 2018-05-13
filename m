Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751489AbeEMMJ0 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 08:09:26 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49141 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751247AbeEMMJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 08:09:25 -0400
Date: Sun, 13 May 2018 14:09:24 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] scheduler fix for 4.17
Message-ID: <alpine.DEB.2.21.1805131405070.1582@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest sched-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

Revert the new NUMA aware placement approach which turned out to create
more problems than it solved.

Thanks,

	tglx

------------------>
Mel Gorman (1):
      Revert "sched/numa: Delay retrying placement for automatic NUMA balance after wake_affine()"


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
