Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754655AbeDWKmC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 06:42:02 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:42887 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754643AbeDWKmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 06:42:00 -0400
X-Google-Smtp-Source: AIpwx4+x4NTl5tkFiCesf7CqrBQCiCzMyJ6e71WW59WkjI4s8Tm+S95KqIiuEAC+Iw48clVXImz/gw==
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sched/fair: Rearrange select_task_rq_fair() to optimize it
Date: Mon, 23 Apr 2018 16:08:26 +0530
Message-Id: <8a34a16da90b9f83ffe60316a074a5e4d05b59b0.1524479666.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.15.0.194.g9af6a3dea062
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rearrange select_task_rq_fair() a bit to avoid executing some
conditional statements in few specific code-paths. That gets rid of the
goto as well.

This shouldn't result in any functional changes.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 kernel/sched/fair.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 54dc31e7ab9b..cacee15076a4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6636,6 +6636,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
 		 */
 		if (want_affine && (tmp->flags & SD_WAKE_AFFINE) &&
 		    cpumask_test_cpu(prev_cpu, sched_domain_span(tmp))) {
+			sd = NULL; /* Prefer wake_affine over balance flags */
 			affine_sd = tmp;
 			break;
 		}
@@ -6646,33 +6647,26 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
 			break;
 	}
 
-	if (affine_sd) {
-		sd = NULL; /* Prefer wake_affine over balance flags */
-		if (cpu == prev_cpu)
-			goto pick_cpu;
-
-		new_cpu = wake_affine(affine_sd, p, cpu, prev_cpu, sync);
-	}
-
-	if (sd && !(sd_flag & SD_BALANCE_FORK)) {
+	if (sd) {
 		/*
 		 * We're going to need the task's util for capacity_spare_wake
 		 * in find_idlest_group. Sync it up to prev_cpu's
 		 * last_update_time.
 		 */
-		sync_entity_load_avg(&p->se);
-	}
+		if (!(sd_flag & SD_BALANCE_FORK))
+			sync_entity_load_avg(&p->se);
+
+		new_cpu = find_idlest_cpu(sd, p, cpu, prev_cpu, sd_flag);
+	} else {
+		if (affine_sd && cpu != prev_cpu)
+			new_cpu = wake_affine(affine_sd, p, cpu, prev_cpu, sync);
 
-	if (!sd) {
-pick_cpu:
 		if (sd_flag & SD_BALANCE_WAKE) { /* XXX always ? */
 			new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
 
 			if (want_affine)
 				current->recent_used_cpu = cpu;
 		}
-	} else {
-		new_cpu = find_idlest_cpu(sd, p, cpu, prev_cpu, sd_flag);
 	}
 	rcu_read_unlock();
 
-- 
2.15.0.194.g9af6a3dea062
