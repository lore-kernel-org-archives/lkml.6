Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755238AbeDZKbI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 06:31:08 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:39685 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754081AbeDZKbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 06:31:04 -0400
X-Google-Smtp-Source: AIpwx48IE1Ilz5pc5cZi3TQRerWgyXhwDMByIlscKM37IXhqI8kP4bQD6S6OziNPtjnXBgo59c0rdQ==
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rohit Jain <rohit.k.jain@oracle.com>, linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/2] sched/fair: Rearrange select_task_rq_fair() to optimize it
Date: Thu, 26 Apr 2018 16:00:50 +0530
Message-Id: <20831b8d237bf3a20e4e328286f678b425ff04c9.1524738578.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.15.0.194.g9af6a3dea062
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rearrange select_task_rq_fair() a bit to avoid executing some
conditional statements in few specific code-paths. That gets rid of the
goto as well.

This shouldn't result in any functional changes.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Tested-by: Rohit Jain <rohit.k.jain@oracle.com>

---
V1->V2:
- Optimize a bit more and get rid of affine_sd variable (Valentin)
- Add unlikely while checking for non-NULL sd and add fast/slow path
  comments (Joel)
- Add tested-by from Rohit.

 kernel/sched/fair.c | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 54dc31e7ab9b..84fc74ddbd4b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6613,7 +6613,7 @@ static int wake_cap(struct task_struct *p, int cpu, int prev_cpu)
 static int
 select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_flags)
 {
-	struct sched_domain *tmp, *affine_sd = NULL, *sd = NULL;
+	struct sched_domain *tmp, *sd = NULL;
 	int cpu = smp_processor_id();
 	int new_cpu = prev_cpu;
 	int want_affine = 0;
@@ -6636,7 +6636,10 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
 		 */
 		if (want_affine && (tmp->flags & SD_WAKE_AFFINE) &&
 		    cpumask_test_cpu(prev_cpu, sched_domain_span(tmp))) {
-			affine_sd = tmp;
+			if (cpu != prev_cpu)
+				new_cpu = wake_affine(tmp, p, cpu, prev_cpu, sync);
+
+			sd = NULL; /* Prefer wake_affine over balance flags */
 			break;
 		}
 
@@ -6646,33 +6649,25 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
 			break;
 	}
 
-	if (affine_sd) {
-		sd = NULL; /* Prefer wake_affine over balance flags */
-		if (cpu == prev_cpu)
-			goto pick_cpu;
-
-		new_cpu = wake_affine(affine_sd, p, cpu, prev_cpu, sync);
-	}
+	if (unlikely(sd)) {
+		/* Slow path */
 
-	if (sd && !(sd_flag & SD_BALANCE_FORK)) {
 		/*
 		 * We're going to need the task's util for capacity_spare_wake
 		 * in find_idlest_group. Sync it up to prev_cpu's
 		 * last_update_time.
 		 */
-		sync_entity_load_avg(&p->se);
-	}
-
-	if (!sd) {
-pick_cpu:
-		if (sd_flag & SD_BALANCE_WAKE) { /* XXX always ? */
-			new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
+		if (!(sd_flag & SD_BALANCE_FORK))
+			sync_entity_load_avg(&p->se);
 
-			if (want_affine)
-				current->recent_used_cpu = cpu;
-		}
-	} else {
 		new_cpu = find_idlest_cpu(sd, p, cpu, prev_cpu, sd_flag);
+	} else if (sd_flag & SD_BALANCE_WAKE) { /* XXX always ? */
+		/* Fast path */
+
+		new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
+
+		if (want_affine)
+			current->recent_used_cpu = cpu;
 	}
 	rcu_read_unlock();
 
-- 
2.15.0.194.g9af6a3dea062
