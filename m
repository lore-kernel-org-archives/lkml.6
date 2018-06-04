Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752740AbeFDKB2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 06:01:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43080 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752680AbeFDKBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 06:01:25 -0400
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 12/19] sched:numa Remove numa_has_capacity
Date: Mon,  4 Jun 2018 15:30:21 +0530
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
References: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18060410-0016-0000-0000-000001D7739B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060410-0017-0000-0000-0000322A0352
Message-Id: <1528106428-19992-13-git-send-email-srikar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-04_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806040123
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

task_numa_find_cpu helps to find the cpu to swap/move the task.
Its guarded by numa_has_capacity(). However node not having capacity
shouldn't deter a task swapping if it helps numa placement.

Further load_too_imbalanced, which evaluates possibilities of move/swap,
provides similar checks as numa_has_capacity.

Hence remove numa_has_capacity() to enhance possibilities of task
swapping even if load is imbalanced.

Testcase       Time:         Min         Max         Avg      StdDev
numa01.sh      Real:      674.61      997.71      785.01      115.95
numa01.sh       Sys:      180.87      318.88      270.13       51.32
numa01.sh      User:    54001.30    71936.50    60495.48     6237.55
numa02.sh      Real:       60.62       62.30       61.46        0.62
numa02.sh       Sys:       15.01       33.63       24.38        6.81
numa02.sh      User:     5234.20     5325.60     5276.23       38.85
numa03.sh      Real:      827.62      946.85      914.48       44.58
numa03.sh       Sys:      135.55      172.40      158.46       12.75
numa03.sh      User:    64839.42    73195.44    70805.96     3061.20
numa04.sh      Real:      481.01      608.76      521.14       47.28
numa04.sh       Sys:      329.59      373.15      353.20       14.20
numa04.sh      User:    37649.09    40722.94    38806.32     1072.32
numa05.sh      Real:      399.21      415.38      409.88        5.54
numa05.sh       Sys:      319.46      418.57      363.31       37.62
numa05.sh      User:    33727.77    34732.68    34127.41      447.11

Testcase       Time:         Min         Max         Avg      StdDev 	 %Change
numa01.sh      Real:      435.67      707.28      527.49       97.85 	 48.81%
numa01.sh       Sys:       76.41      231.19      162.49       56.13 	 66.24%
numa01.sh      User:    38247.36    59033.52    45129.31     7642.69 	 34.04%
numa02.sh      Real:       60.35       62.09       61.09        0.69 	 0.605%
numa02.sh       Sys:       15.01       30.20       20.64        5.56 	 18.12%
numa02.sh      User:     5195.93     5294.82     5240.99       40.55 	 0.672%
numa03.sh      Real:      752.04      919.89      836.81       63.29 	 9.281%
numa03.sh       Sys:      115.10      133.35      125.46        7.78 	 26.30%
numa03.sh      User:    58736.44    70084.26    65103.67     4416.10 	 8.758%
numa04.sh      Real:      418.43      709.69      512.53      104.17 	 1.679%
numa04.sh       Sys:      242.99      370.47      297.39       42.20 	 18.76%
numa04.sh      User:    34916.14    48429.54    38955.65     4928.05 	 -0.38%
numa05.sh      Real:      379.27      434.05      403.70       17.79 	 1.530%
numa05.sh       Sys:      145.94      344.50      268.72       68.53 	 35.20%
numa05.sh      User:    32679.32    35449.75    33989.10      913.19 	 0.406%

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 kernel/sched/fair.c | 37 +++----------------------------------
 1 file changed, 3 insertions(+), 34 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 259c343..709c77c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1417,7 +1417,6 @@ struct numa_stats {
 	unsigned long compute_capacity;
 
 	unsigned int nr_running;
-	int has_free_capacity;
 };
 
 /*
@@ -1444,8 +1443,7 @@ static void update_numa_stats(struct numa_stats *ns, int nid)
 	 * the @ns structure is NULL'ed and task_numa_compare() will
 	 * not find this node attractive.
 	 *
-	 * We'll either bail at !has_free_capacity, or we'll detect a huge
-	 * imbalance and bail there.
+	 * We'll detect a huge imbalance and bail there.
 	 */
 	if (!cpus)
 		return;
@@ -1456,7 +1454,6 @@ static void update_numa_stats(struct numa_stats *ns, int nid)
 
 	capacity = min_t(unsigned, capacity,
 		DIV_ROUND_CLOSEST(ns->compute_capacity, SCHED_CAPACITY_SCALE));
-	ns->has_free_capacity = (ns->nr_running < capacity);
 }
 
 struct task_numa_env {
@@ -1672,7 +1669,6 @@ static void task_numa_find_cpu(struct task_numa_env *env,
 	 * than swapping tasks around, check if a move is possible.
 	 */
 	move = !load_too_imbalanced(src_load, dst_load, env);
-
 	for_each_cpu(cpu, cpumask_of_node(env->dst_nid)) {
 		/* Skip this CPU if the source task cannot migrate */
 		if (!cpumask_test_cpu(cpu, &env->p->cpus_allowed))
@@ -1683,31 +1679,6 @@ static void task_numa_find_cpu(struct task_numa_env *env,
 	}
 }
 
-/* Only move tasks to a NUMA node less busy than the current node. */
-static bool numa_has_capacity(struct task_numa_env *env)
-{
-	struct numa_stats *src = &env->src_stats;
-	struct numa_stats *dst = &env->dst_stats;
-
-	if (src->has_free_capacity && !dst->has_free_capacity)
-		return false;
-
-	/*
-	 * Only consider a task move if the source has a higher load
-	 * than the destination, corrected for CPU capacity on each node.
-	 *
-	 *      src->load                dst->load
-	 * --------------------- vs ---------------------
-	 * src->compute_capacity    dst->compute_capacity
-	 */
-	if (src->load * dst->compute_capacity * env->imbalance_pct >
-
-	    dst->load * src->compute_capacity * 100)
-		return true;
-
-	return false;
-}
-
 static int task_numa_migrate(struct task_struct *p)
 {
 	struct task_numa_env env = {
@@ -1764,8 +1735,7 @@ static int task_numa_migrate(struct task_struct *p)
 	update_numa_stats(&env.dst_stats, env.dst_nid);
 
 	/* Try to find a spot on the preferred nid. */
-	if (numa_has_capacity(&env))
-		task_numa_find_cpu(&env, taskimp, groupimp);
+	task_numa_find_cpu(&env, taskimp, groupimp);
 
 	/*
 	 * Look at other nodes in these cases:
@@ -1795,8 +1765,7 @@ static int task_numa_migrate(struct task_struct *p)
 			env.dist = dist;
 			env.dst_nid = nid;
 			update_numa_stats(&env.dst_stats, env.dst_nid);
-			if (numa_has_capacity(&env))
-				task_numa_find_cpu(&env, taskimp, groupimp);
+			task_numa_find_cpu(&env, taskimp, groupimp);
 		}
 	}
 
-- 
1.8.3.1
