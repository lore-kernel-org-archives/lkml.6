Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751823AbeEDJhs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 05:37:48 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45581 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751774AbeEDJhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 05:37:47 -0400
Date: Fri, 4 May 2018 02:37:26 -0700
From: tip-bot for Viresh Kumar <tipbot@zytor.com>
Message-ID: <tip-c976a862ba4869c1e75c39b9b8f1e9ebfe90cdfc@git.kernel.org>
Cc: viresh.kumar@linaro.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de,
        peterz@infradead.org, vincent.guittot@linaro.org
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, hpa@zytor.com, viresh.kumar@linaro.org,
        peterz@infradead.org, vincent.guittot@linaro.org, tglx@linutronix.de
In-Reply-To: <cd019d1753824c81130eae7b43e2bbcec47cc1ad.1524738578.git.viresh.kumar@linaro.org>
References: <cd019d1753824c81130eae7b43e2bbcec47cc1ad.1524738578.git.viresh.kumar@linaro.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Avoid calling sync_entity_load_avg()
 unnecessarily
Git-Commit-ID: c976a862ba4869c1e75c39b9b8f1e9ebfe90cdfc
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

Commit-ID:  c976a862ba4869c1e75c39b9b8f1e9ebfe90cdfc
Gitweb:     https://git.kernel.org/tip/c976a862ba4869c1e75c39b9b8f1e9ebfe90cdfc
Author:     Viresh Kumar <viresh.kumar@linaro.org>
AuthorDate: Thu, 26 Apr 2018 16:00:51 +0530
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 4 May 2018 10:00:08 +0200

sched/fair: Avoid calling sync_entity_load_avg() unnecessarily

Call sync_entity_load_avg() directly from find_idlest_cpu() instead of
select_task_rq_fair(), as that's where we need to use task's utilization
value. And call sync_entity_load_avg() only after making sure sched
domain spans over one of the allowed CPUs for the task.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Link: http://lkml.kernel.org/r/cd019d1753824c81130eae7b43e2bbcec47cc1ad.1524738578.git.viresh.kumar@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4b346f358005..1f6a23a5b451 100644
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
