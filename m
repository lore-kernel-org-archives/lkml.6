Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753020AbeFDKCZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 06:02:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34686 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752786AbeFDKBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 06:01:34 -0400
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 16/19] sched/numa: Detect if node actively handling migration
Date: Mon,  4 Jun 2018 15:30:25 +0530
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
References: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18060410-0016-0000-0000-000001D773A4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060410-0017-0000-0000-0000322A035C
Message-Id: <1528106428-19992-17-git-send-email-srikar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-04_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806040123
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a node is the destination for a task migration under numa balancing,
then any parallel movements to the node will be restricted. In such a
scenario, detect at the earliest and avoid evaluation for a task
movement.

While here, avoid task migration if the numa imbalance is very minimal.
Especially consider two tasks A and B racing with each other to find the
best cpu to swap. If task A already has found one task/cpu pair to
swap and trying to find a better cpu. Task B is yet to find a better
cpu/task to swap. Task A can race with task B and deprive it from
getting a task/cpu to swap.


Testcase       Time:         Min         Max         Avg      StdDev
numa01.sh      Real:      493.19      672.88      597.51       59.38
numa01.sh       Sys:      150.09      245.48      207.76       34.26
numa01.sh      User:    41928.51    53779.17    48747.06     3901.39
numa02.sh      Real:       60.63       62.87       61.22        0.83
numa02.sh       Sys:       16.64       27.97       20.25        4.06
numa02.sh      User:     5222.92     5309.60     5254.03       29.98
numa03.sh      Real:      821.52      902.15      863.60       32.41
numa03.sh       Sys:      112.04      130.66      118.35        7.08
numa03.sh      User:    62245.16    69165.14    66443.04     2450.32
numa04.sh      Real:      414.53      519.57      476.25       37.00
numa04.sh       Sys:      181.84      335.67      280.41       54.07
numa04.sh      User:    33924.50    39115.39    37343.78     1934.26
numa05.sh      Real:      408.30      441.45      417.90       12.05
numa05.sh       Sys:      233.41      381.60      295.58       57.37
numa05.sh      User:    33301.31    35972.50    34335.19      938.94

Testcase       Time:         Min         Max         Avg      StdDev 	 %Change
numa01.sh      Real:      428.48      837.17      700.45      162.77 	 -14.6%
numa01.sh       Sys:       78.64      247.70      164.45       58.32 	 26.33%
numa01.sh      User:    37487.25    63728.06    54399.27    10088.13 	 -10.3%
numa02.sh      Real:       60.07       62.65       61.41        0.85 	 -0.30%
numa02.sh       Sys:       15.83       29.36       21.04        4.48 	 -3.75%
numa02.sh      User:     5194.27     5280.60     5236.55       28.01 	 0.333%
numa03.sh      Real:      814.33      881.93      849.69       27.06 	 1.637%
numa03.sh       Sys:      111.45      134.02      125.28        7.69 	 -5.53%
numa03.sh      User:    63007.36    68013.46    65590.46     2023.37 	 1.299%
numa04.sh      Real:      412.19      438.75      424.43        9.28 	 12.20%
numa04.sh       Sys:      232.97      315.77      268.98       26.98 	 4.249%
numa04.sh      User:    33997.30    35292.88    34711.66      415.78 	 7.582%
numa05.sh      Real:      394.88      449.45      424.30       22.53 	 -1.50%
numa05.sh       Sys:      262.03      390.10      314.53       51.01 	 -6.02%
numa05.sh      User:    33389.03    35684.40    34561.34      942.34 	 -0.65%

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 kernel/sched/fair.c | 37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c388ecf..6851412 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1535,14 +1535,22 @@ static bool load_too_imbalanced(long src_load, long dst_load,
 }
 
 /*
+ * Maximum numa importance can be 1998 (2*999);
+ * SMALLIMP @ 30 would be close to 1998/64.
+ * Used to deter task migration.
+ */
+#define SMALLIMP	30
+
+/*
  * This checks if the overall compute and NUMA accesses of the system would
  * be improved if the source tasks was migrated to the target dst_cpu taking
  * into account that it might be best if task running on the dst_cpu should
  * be exchanged with the source task
  */
 static void task_numa_compare(struct task_numa_env *env,
-			      long taskimp, long groupimp, bool move)
+			      long taskimp, long groupimp, bool *move)
 {
+	pg_data_t *pgdat = NODE_DATA(cpu_to_node(env->dst_cpu));
 	struct rq *dst_rq = cpu_rq(env->dst_cpu);
 	struct task_struct *cur;
 	long src_load, dst_load;
@@ -1554,6 +1562,9 @@ static void task_numa_compare(struct task_numa_env *env,
 	if (READ_ONCE(dst_rq->numa_migrate_on))
 		return;
 
+	if (*move && READ_ONCE(pgdat->active_node_migrate))
+		*move = false;
+
 	rcu_read_lock();
 	cur = task_rcu_dereference(&dst_rq->curr);
 	if (cur && ((cur->flags & PF_EXITING) || is_idle_task(cur)))
@@ -1567,10 +1578,10 @@ static void task_numa_compare(struct task_numa_env *env,
 		goto unlock;
 
 	if (!cur) {
-		if (!move || imp <= env->best_imp)
-			goto unlock;
-		else
+		if (*move && moveimp >= env->best_imp)
 			goto assign;
+		else
+			goto unlock;
 	}
 
 	/*
@@ -1610,16 +1621,22 @@ static void task_numa_compare(struct task_numa_env *env,
 			       task_weight(cur, env->dst_nid, dist);
 	}
 
-	if (imp <= env->best_imp)
-		goto unlock;
-
-	if (move && moveimp > imp && moveimp > env->best_imp) {
-		imp = moveimp - 1;
+	if (*move && moveimp > imp && moveimp > env->best_imp) {
+		imp = moveimp;
 		cur = NULL;
 		goto assign;
 	}
 
 	/*
+	 * If the numa importance is less than SMALLIMP,
+	 * task migration might only result in ping pong
+	 * of tasks and also hurt performance due to cache
+	 * misses.
+	 */
+	if (imp < SMALLIMP || imp <= env->best_imp + SMALLIMP / 2)
+		goto unlock;
+
+	/*
 	 * In the overloaded case, try and keep the load balanced.
 	 */
 	load = task_h_load(env->p) - task_h_load(cur);
@@ -1675,7 +1692,7 @@ static void task_numa_find_cpu(struct task_numa_env *env,
 			continue;
 
 		env->dst_cpu = cpu;
-		task_numa_compare(env, taskimp, groupimp, move);
+		task_numa_compare(env, taskimp, groupimp, &move);
 	}
 }
 
-- 
1.8.3.1
