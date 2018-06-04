Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751870AbeFDILf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 04:11:35 -0400
Received: from lgeamrelo13.lge.com ([156.147.23.53]:59260 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751427AbeFDILe (ORCPT
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
Subject: [PATCH v12 2/2] sched/rt: Add support for SD_PREFER_SIBLING on find_lowest_rq()
Date: Mon,  4 Jun 2018 17:10:06 +0900
Message-Id: <1528099806-30632-3-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1528099806-30632-1-git-send-email-byungchul.park@lge.com>
References: <1528099806-30632-1-git-send-email-byungchul.park@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Steven,

I've changed the code a little bit to avoid a compile warning caused by
'const' args of find_cpu(). Can I keep your Reviewed-by?

BEFORE:
static int find_cpu(const struct cpumask *mask,
		    const struct sched_domain *sd,
		    const struct sched_domain *prefer)

AFTER:
static int find_cpu(const struct cpumask *mask,
		    struct sched_domain *sd,
		    struct sched_domain *prefer)

(I temporarily removed the Reviewed-by you gave me.)
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-----8<-----
>From 205b197043085947ae30cd939bc12e436c328fe5 Mon Sep 17 00:00:00 2001
From: Byungchul Park <byungchul.park@lge.com>
Date: Mon, 4 Jun 2018 16:47:45 +0900
Subject: [PATCH v12 2/2] sched/rt: Add support for SD_PREFER_SIBLING on
 find_lowest_rq()

It would be better to try to check other siblings first if
SD_PREFER_SIBLING is flaged when pushing tasks - migration.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 kernel/sched/rt.c | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 75 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index ef3c4e6..b2aff1a 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1623,12 +1623,33 @@ static struct task_struct *pick_highest_pushable_task(struct rq *rq, int cpu)
 
 static DEFINE_PER_CPU(cpumask_var_t, local_cpu_mask);
 
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
 static int find_lowest_rq(struct task_struct *task)
 {
-	struct sched_domain *sd;
+	struct sched_domain *sd, *prefer = NULL;
 	struct cpumask *lowest_mask = this_cpu_cpumask_var_ptr(local_cpu_mask);
 	int this_cpu = smp_processor_id();
 	int cpu      = task_cpu(task);
+	int fallback_cpu = -1;
 
 	/* Make sure the mask is initialized first */
 	if (unlikely(!lowest_mask))
@@ -1673,9 +1694,37 @@ static int find_lowest_rq(struct task_struct *task)
 				return this_cpu;
 			}
 
-			best_cpu = cpumask_first_and(lowest_mask,
-						     sched_domain_span(sd));
+			/*
+			 * If a CPU exists that is in the lowest_mask and
+			 * the current sd span, but not in the prefer sd
+			 * span, then that becomes our choice.
+			 *
+			 * Of course, the lowest possible CPU is already
+			 * under consideration through lowest_mask.
+			 */
+			best_cpu = find_cpu(lowest_mask, sd, prefer);
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
@@ -1684,6 +1733,29 @@ static int find_lowest_rq(struct task_struct *task)
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
 	 * And finally, if there were no matches within the domains
 	 * just give the caller *something* to work with from the compatible
 	 * locations.
-- 
1.9.1
