Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752051AbeFDILh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 04:11:37 -0400
Received: from lgeamrelo13.lge.com ([156.147.23.53]:59257 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751412AbeFDILe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 04:11:34 -0400
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: byungchul.park@lge.com
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
From: Byungchul Park <byungchul.park@lge.com>
To: peterz@infradead.org, mingo@kernel.org, rostedt@goodmis.org
Cc: tglx@linutronix.de, raistlin@linux.it, linux-kernel@vger.kernel.org,
        juri.lelli@gmail.com, bristot@redhat.com, kernel-team@lge.com,
        joel@joelfernandes.org
Subject: [PATCH v12 1/2] sched/deadline: Add support for SD_PREFER_SIBLING on find_later_rq()
Date: Mon,  4 Jun 2018 17:10:05 +0900
Message-Id: <1528099806-30632-2-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1528099806-30632-1-git-send-email-byungchul.park@lge.com>
References: <1528099806-30632-1-git-send-email-byungchul.park@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Juri,

I've changed the code a little bit to avoid a compile warning caused by
'const' args of find_cpu(). Can I keep your Acked-by?

BEFORE:
static int find_cpu(const struct cpumask *mask,
		    const struct sched_domain *sd,
		    const struct sched_domain *prefer)

AFTER:
static int find_cpu(const struct cpumask *mask,
		    struct sched_domain *sd,
		    struct sched_domain *prefer)

(I temporarily removed the Acked-by you gave me.)
Acked-by: Juri Lelli <juri.lelli@arm.com>

-----8<-----
>From 5a4753e8c15369420a16fa04026f74ae5c9d377c Mon Sep 17 00:00:00 2001
From: Byungchul Park <byungchul.park@lge.com>
Date: Mon, 4 Jun 2018 16:46:56 +0900
Subject: [PATCH v12 1/2] sched/deadline: Add support for SD_PREFER_SIBLING on
 find_later_rq()

It would be better to try to check other siblings first if
SD_PREFER_SIBLING is flaged when pushing tasks - migration.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 kernel/sched/deadline.c | 80 ++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 73 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 1356afd..6130d40 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1853,12 +1853,33 @@ static struct task_struct *pick_earliest_pushable_dl_task(struct rq *rq, int cpu
 
 static DEFINE_PER_CPU(cpumask_var_t, local_cpu_mask_dl);
 
+/*
+ * Find the first CPU in: mask & sd & ~prefer
+ */
+static int find_cpu(const struct cpumask *mask,
+		    struct sched_domain *sd,
+		    struct sched_domain *prefer)
+{
+	int cpu;
+
+	for_each_cpu(cpu, mask) {
+		if (!cpumask_test_cpu(cpu, sched_domain_span(sd)))
+			continue;
+		if (prefer && cpumask_test_cpu(cpu, sched_domain_span(prefer)))
+			continue;
+		break;
+	}
+
+	return cpu;
+}
+
 static int find_later_rq(struct task_struct *task)
 {
-	struct sched_domain *sd;
+	struct sched_domain *sd, *prefer = NULL;
 	struct cpumask *later_mask = this_cpu_cpumask_var_ptr(local_cpu_mask_dl);
 	int this_cpu = smp_processor_id();
 	int cpu = task_cpu(task);
+	int fallback_cpu = -1;
 
 	/* Make sure the mask is initialized first */
 	if (unlikely(!later_mask))
@@ -1910,15 +1931,37 @@ static int find_later_rq(struct task_struct *task)
 				return this_cpu;
 			}
 
-			best_cpu = cpumask_first_and(later_mask,
-							sched_domain_span(sd));
 			/*
-			 * Last chance: if a CPU being in both later_mask
-			 * and current sd span is valid, that becomes our
-			 * choice. Of course, the latest possible CPU is
-			 * already under consideration through later_mask.
+			 * If a CPU exists that is in the later_mask and
+			 * the current sd span, but not in the prefer sd
+			 * span, then that becomes our choice.
+			 *
+			 * Of course, the latest possible CPU is already
+			 * under consideration through later_mask.
 			 */
+			best_cpu = find_cpu(later_mask, sd, prefer);
+
 			if (best_cpu < nr_cpu_ids) {
+				/*
+				 * If current domain is SD_PREFER_SIBLING
+				 * flaged, we have to try to check other
+				 * siblings first.
+				 */
+				if (sd->flags & SD_PREFER_SIBLING) {
+					prefer = sd;
+
+					/*
+					 * fallback_cpu should be one
+					 * in the closest domain among
+					 * SD_PREFER_SIBLING domains,
+					 * in case that more than one
+					 * SD_PREFER_SIBLING domains
+					 * exist in the hierachy.
+					 */
+					if (fallback_cpu == -1)
+						fallback_cpu = best_cpu;
+					continue;
+				}
 				rcu_read_unlock();
 				return best_cpu;
 			}
@@ -1927,6 +1970,29 @@ static int find_later_rq(struct task_struct *task)
 	rcu_read_unlock();
 
 	/*
+	 * If fallback_cpu is valid, all our guesses failed *except* for
+	 * SD_PREFER_SIBLING domain. Now, we can return the fallback CPU.
+	 *
+	 * XXX: Consider the following example, 4 cores SMT2 system:
+	 *
+	 *    LLC [0       -        7]
+	 *    SMT [0 1][2 3][4 5][6 7]
+	 *         o x  o x  x x  x x
+	 *
+	 *    where 'o': occupied and 'x': empty.
+	 *
+	 * A wakeup on CPU0 will exclude CPU1 and choose CPU3, since
+	 * CPU1 is in a SD_PREFER_SIBLING sd and CPU3 is not. However,
+	 * in this case, CPU4 would have been a better choice, since
+	 * CPU3 is a (SMT) thread of an already loaded core.
+	 *
+	 * Doing it 'right' is difficult and expensive. The current
+	 * solution is an acceptable approximation.
+	 */
+	if (fallback_cpu != -1)
+		return fallback_cpu;
+
+	/*
 	 * At this point, all our guesses failed, we just return
 	 * 'something', and let the caller sort the things out.
 	 */
-- 
1.9.1
