Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755432AbeDZKbP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 06:31:15 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:39691 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755158AbeDZKbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 06:31:07 -0400
X-Google-Smtp-Source: AIpwx4+x6TQ/MJ/Y/wSxG9QBIHO4awpdoliY7TWFsS9Kpe1GkgRCt9oGh+iMqQj04ovBO8JHx6F+/w==
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] sched/fair: Avoid calling sync_entity_load_avg() unnecessarily
Date: Thu, 26 Apr 2018 16:00:51 +0530
Message-Id: <cd019d1753824c81130eae7b43e2bbcec47cc1ad.1524738578.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.15.0.194.g9af6a3dea062
In-Reply-To: <20831b8d237bf3a20e4e328286f678b425ff04c9.1524738578.git.viresh.kumar@linaro.org>
References: <20831b8d237bf3a20e4e328286f678b425ff04c9.1524738578.git.viresh.kumar@linaro.org>
In-Reply-To: <20831b8d237bf3a20e4e328286f678b425ff04c9.1524738578.git.viresh.kumar@linaro.org>
References: <20831b8d237bf3a20e4e328286f678b425ff04c9.1524738578.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call sync_entity_load_avg() directly from find_idlest_cpu() instead of
select_task_rq_fair(), as that's where we need to use task's utilization
value. And call sync_entity_load_avg() only after making sure sched
domain spans over one of the allowed CPUs for the task.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 kernel/sched/fair.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 84fc74ddbd4b..5b1b4f91f132 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6199,6 +6199,13 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
 	if (!cpumask_intersects(sched_domain_span(sd), &p->cpus_allowed))
 		return prev_cpu;
 
+	/*
+	 * We need task's util for capacity_spare_wake, sync it up to prev_cpu's
+	 * last_update_time.
+	 */
+	if (!(sd_flag & SD_BALANCE_FORK))
+		sync_entity_load_avg(&p->se);
+
 	while (sd) {
 		struct sched_group *group;
 		struct sched_domain *tmp;
@@ -6651,15 +6658,6 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
 
 	if (unlikely(sd)) {
 		/* Slow path */
-
-		/*
-		 * We're going to need the task's util for capacity_spare_wake
-		 * in find_idlest_group. Sync it up to prev_cpu's
-		 * last_update_time.
-		 */
-		if (!(sd_flag & SD_BALANCE_FORK))
-			sync_entity_load_avg(&p->se);
-
 		new_cpu = find_idlest_cpu(sd, p, cpu, prev_cpu, sd_flag);
 	} else if (sd_flag & SD_BALANCE_WAKE) { /* XXX always ? */
 		/* Fast path */
-- 
2.15.0.194.g9af6a3dea062
