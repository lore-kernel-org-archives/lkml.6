Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756088AbeEIGpZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 02:45:25 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:42183 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753339AbeEIGpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 02:45:24 -0400
X-Original-SENDERIP: 156.147.1.127
X-Original-MAILFROM: byungchul.park@lge.com
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
From: Byungchul Park <byungchul.park@lge.com>
To: peterz@infradead.org, mingo@kernel.org, rostedt@goodmis.org
Cc: tglx@linutronix.de, raistlin@linux.it, linux-kernel@vger.kernel.org,
        juri.lelli@gmail.com, bristot@redhat.com, kernel-team@lge.com
Subject: [RESEND PATCH v11 1/2] sched/deadline: Add support for SD_PREFER_SIBLING on find_later_rq()
Date: Wed,  9 May 2018 15:44:22 +0900
Message-Id: <1525848263-10958-2-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525848263-10958-1-git-send-email-byungchul.park@lge.com>
References: <1525848263-10958-1-git-send-email-byungchul.park@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It would be better to try to check other siblings first if
SD_PREFER_SIBLING is flaged when pushing tasks - migration.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Byungchul Park <byungchul.park@lge.com>
Acked-by: Juri Lelli <juri.lelli@arm.com>
---
 kernel/sched/deadline.c | 82 ++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 75 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 0223694..d619c07 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1319,12 +1319,35 @@ static struct task_struct *pick_earliest_pushable_dl_task(struct rq *rq, int cpu
 
 static DEFINE_PER_CPU(cpumask_var_t, local_cpu_mask_dl);
 
+/*
+ * Find the first cpu in: mask & sd & ~prefer
+ */
+static int find_cpu(const struct cpumask *mask,
+		    const struct sched_domain *sd,
+		    const struct sched_domain *prefer)
+{
+	const struct cpumask *sds = sched_domain_span(sd);
+	const struct cpumask *ps  = prefer ? sched_domain_span(prefer) : NULL;
+	int cpu;
+
+	for_each_cpu(cpu, mask) {
+		if (!cpumask_test_cpu(cpu, sds))
+			continue;
+		if (ps && cpumask_test_cpu(cpu, ps))
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
@@ -1376,15 +1399,37 @@ static int find_later_rq(struct task_struct *task)
 				return this_cpu;
 			}
 
-			best_cpu = cpumask_first_and(later_mask,
-							sched_domain_span(sd));
 			/*
-			 * Last chance: if a cpu being in both later_mask
-			 * and current sd span is valid, that becomes our
-			 * choice. Of course, the latest possible cpu is
-			 * already under consideration through later_mask.
+			 * If a cpu exists that is in the later_mask and
+			 * the current sd span, but not in the prefer sd
+			 * span, then that becomes our choice.
+			 *
+			 * Of course, the latest possible cpu is already
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
@@ -1393,6 +1438,29 @@ static int find_later_rq(struct task_struct *task)
 	rcu_read_unlock();
 
 	/*
+	 * If fallback_cpu is valid, all our guesses failed *except* for
+	 * SD_PREFER_SIBLING domain. Now, we can return the fallback cpu.
+	 *
+	 * XXX: Consider the following example, 4 cores SMT2 system:
+	 *
+	 *    LLC [0       -        7]
+	 *    SMT [0 1][2 3][4 5][6 7]
+	 *         o x  o x  x x  x x
+	 *
+	 *    where 'o': occupied and 'x': empty.
+	 *
+	 * A wakeup on cpu0 will exclude cpu1 and choose cpu3, since
+	 * cpu1 is in a SD_PREFER_SIBLING sd and cpu3 is not. However,
+	 * in this case, cpu4 would have been a better choice, since
+	 * cpu3 is a (SMT) thread of an already loaded core.
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
