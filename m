Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751755AbeEDJhb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 05:37:31 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39325 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751205AbeEDJh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 05:37:29 -0400
Date: Fri, 4 May 2018 02:36:53 -0700
From: tip-bot for Viresh Kumar <tipbot@zytor.com>
Message-ID: <tip-f1d88b4468188ddcd2620b8d612068faf6662a62@git.kernel.org>
Cc: peterz@infradead.org, mingo@kernel.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        tglx@linutronix.de, rohit.k.jain@oracle.com, hpa@zytor.com,
        valentin.schneider@arm.com, viresh.kumar@linaro.org
Reply-To: mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, hpa@zytor.com, rohit.k.jain@oracle.com,
        valentin.schneider@arm.com, viresh.kumar@linaro.org
In-Reply-To: <20831b8d237bf3a20e4e328286f678b425ff04c9.1524738578.git.viresh.kumar@linaro.org>
References: <20831b8d237bf3a20e4e328286f678b425ff04c9.1524738578.git.viresh.kumar@linaro.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Rearrange select_task_rq_fair() to
 optimize it
Git-Commit-ID: f1d88b4468188ddcd2620b8d612068faf6662a62
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

Commit-ID:  f1d88b4468188ddcd2620b8d612068faf6662a62
Gitweb:     https://git.kernel.org/tip/f1d88b4468188ddcd2620b8d612068faf6662a62
Author:     Viresh Kumar <viresh.kumar@linaro.org>
AuthorDate: Thu, 26 Apr 2018 16:00:50 +0530
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 4 May 2018 10:00:07 +0200

sched/fair: Rearrange select_task_rq_fair() to optimize it

Rearrange select_task_rq_fair() a bit to avoid executing some
conditional statements in few specific code-paths. That gets rid of the
goto as well.

This shouldn't result in any functional changes.

Tested-by: Rohit Jain <rohit.k.jain@oracle.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Link: http://lkml.kernel.org/r/20831b8d237bf3a20e4e328286f678b425ff04c9.1524738578.git.viresh.kumar@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e3002e5ada31..4b346f358005 100644
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
 
