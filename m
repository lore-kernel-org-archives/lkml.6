Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751916AbeA3KqY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 05:46:24 -0500
Received: from outbound-smtp23.blacknight.com ([81.17.249.191]:49762 "EHLO
        outbound-smtp23.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751505AbeA3Kp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 05:45:57 -0500
From: Mel Gorman <mgorman@techsingularity.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 2/4] sched/fair: Restructure wake_affine to return a CPU id
Date: Tue, 30 Jan 2018 10:45:53 +0000
Message-Id: <20180130104555.4125-3-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180130104555.4125-1-mgorman@techsingularity.net>
References: <20180130104555.4125-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparation patch that has wake_affine return a CPU ID instead of
a boolean. The intent is to allow the wake_affine() helpers to be avoided
if a decision is already made. This patch has no functional change.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9a5d8462c13c..1aebe79da2ab 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5696,7 +5696,7 @@ static int wake_wide(struct task_struct *p)
  *			  scheduling latency of the CPUs. This seems to work
  *			  for the overloaded case.
  */
-static bool
+static int
 wake_affine_idle(int this_cpu, int prev_cpu, int sync)
 {
 	/*
@@ -5706,15 +5706,15 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
 	 * node depending on the IO topology or IRQ affinity settings.
 	 */
 	if (idle_cpu(this_cpu) && cpus_share_cache(this_cpu, prev_cpu))
-		return true;
+		return this_cpu;
 
 	if (sync && cpu_rq(this_cpu)->nr_running == 1)
-		return true;
+		return this_cpu;
 
-	return false;
+	return nr_cpumask_bits;
 }
 
-static bool
+static int
 wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
 		   int this_cpu, int prev_cpu, int sync)
 {
@@ -5728,7 +5728,7 @@ wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
 		unsigned long current_load = task_h_load(current);
 
 		if (current_load > this_eff_load)
-			return true;
+			return this_cpu;
 
 		this_eff_load -= current_load;
 	}
@@ -5745,28 +5745,28 @@ wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
 		prev_eff_load *= 100 + (sd->imbalance_pct - 100) / 2;
 	prev_eff_load *= capacity_of(this_cpu);
 
-	return this_eff_load <= prev_eff_load;
+	return this_eff_load <= prev_eff_load ? this_cpu : nr_cpumask_bits;
 }
 
 static int wake_affine(struct sched_domain *sd, struct task_struct *p,
 		       int prev_cpu, int sync)
 {
 	int this_cpu = smp_processor_id();
-	bool affine = false;
+	int target = nr_cpumask_bits;
 
 	if (sched_feat(WA_IDLE))
-		affine = wake_affine_idle(this_cpu, prev_cpu, sync);
+		target = wake_affine_idle(this_cpu, prev_cpu, sync);
 
-	if (sched_feat(WA_WEIGHT) && !affine)
-		affine = wake_affine_weight(sd, p, this_cpu, prev_cpu, sync);
+	if (sched_feat(WA_WEIGHT) && target == nr_cpumask_bits)
+		target = wake_affine_weight(sd, p, this_cpu, prev_cpu, sync);
 
 	schedstat_inc(p->se.statistics.nr_wakeups_affine_attempts);
-	if (affine) {
-		schedstat_inc(sd->ttwu_move_affine);
-		schedstat_inc(p->se.statistics.nr_wakeups_affine);
-	}
+	if (target == nr_cpumask_bits)
+		return prev_cpu;
 
-	return affine;
+	schedstat_inc(sd->ttwu_move_affine);
+	schedstat_inc(p->se.statistics.nr_wakeups_affine);
+	return target;
 }
 
 static inline int task_util(struct task_struct *p);
@@ -6359,8 +6359,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
 		if (cpu == prev_cpu)
 			goto pick_cpu;
 
-		if (wake_affine(affine_sd, p, prev_cpu, sync))
-			new_cpu = cpu;
+		new_cpu = wake_affine(affine_sd, p, prev_cpu, sync);
 	}
 
 	if (sd && !(sd_flag & SD_BALANCE_FORK)) {
-- 
2.15.1
