Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752861AbeBFMAg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 07:00:36 -0500
Received: from terminus.zytor.com ([65.50.211.136]:48467 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752403AbeBFMA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 07:00:28 -0500
Date: Tue, 6 Feb 2018 03:56:02 -0800
From: tip-bot for Mel Gorman <tipbot@zytor.com>
Message-ID: <tip-3b76c4a33959ca98a573cd9c94c8690d123912ca@git.kernel.org>
Cc: tglx@linutronix.de, peterz@infradead.org, mgorman@techsingularity.net,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        mingo@kernel.org, matt@codeblueprint.co.uk, hpa@zytor.com,
        efault@gmx.de
Reply-To: mgorman@techsingularity.net, peterz@infradead.org,
        tglx@linutronix.de, efault@gmx.de, hpa@zytor.com,
        matt@codeblueprint.co.uk, mingo@kernel.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
In-Reply-To: <20180130104555.4125-3-mgorman@techsingularity.net>
References: <20180130104555.4125-3-mgorman@techsingularity.net>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] sched/fair: Restructure wake_affine*() to return
 a CPU id
Git-Commit-ID: 3b76c4a33959ca98a573cd9c94c8690d123912ca
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  3b76c4a33959ca98a573cd9c94c8690d123912ca
Gitweb:     https://git.kernel.org/tip/3b76c4a33959ca98a573cd9c94c8690d123912ca
Author:     Mel Gorman <mgorman@techsingularity.net>
AuthorDate: Tue, 30 Jan 2018 10:45:53 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 6 Feb 2018 10:20:35 +0100

sched/fair: Restructure wake_affine*() to return a CPU id

This is a preparation patch that has wake_affine*() return a CPU ID instead of
a boolean. The intent is to allow the wake_affine() helpers to be avoided
if a decision is already made. This patch has no functional change.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180130104555.4125-3-mgorman@techsingularity.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0a551dfe..4c400d7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5692,7 +5692,7 @@ static int wake_wide(struct task_struct *p)
  *			  scheduling latency of the CPUs. This seems to work
  *			  for the overloaded case.
  */
-static bool
+static int
 wake_affine_idle(int this_cpu, int prev_cpu, int sync)
 {
 	/*
@@ -5702,15 +5702,15 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
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
@@ -5724,7 +5724,7 @@ wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
 		unsigned long current_load = task_h_load(current);
 
 		if (current_load > this_eff_load)
-			return true;
+			return this_cpu;
 
 		this_eff_load -= current_load;
 	}
@@ -5741,28 +5741,28 @@ wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
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
 
 static inline unsigned long task_util(struct task_struct *p);
@@ -6355,8 +6355,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
 		if (cpu == prev_cpu)
 			goto pick_cpu;
 
-		if (wake_affine(affine_sd, p, prev_cpu, sync))
-			new_cpu = cpu;
+		new_cpu = wake_affine(affine_sd, p, prev_cpu, sync);
 	}
 
 	if (sd && !(sd_flag & SD_BALANCE_FORK)) {
