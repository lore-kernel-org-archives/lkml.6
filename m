Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752686AbeFDKBZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 06:01:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39102 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752087AbeFDKBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 06:01:23 -0400
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 11/19] sched/numa: Restrict migrating in parallel to the same node.
Date: Mon,  4 Jun 2018 15:30:20 +0530
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
References: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18060410-4275-0000-0000-000002895C9F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060410-4276-0000-0000-0000379070FC
Message-Id: <1528106428-19992-12-git-send-email-srikar@linux.vnet.ibm.com>
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

Since task migration under numa balancing can happen in parallel, more
than one task might choose to move to the same node at the same time.
This can cause load imbalances at the node level.

The problem is more likely if there are more cores per node or more
nodes in system.

Use a per-node variable to indicate if task migration
to the node under numa balance is currently active.
This per-node variable will not track swapping of tasks.

Testcase       Time:         Min         Max         Avg      StdDev
numa01.sh      Real:      434.84      676.90      550.53      106.24
numa01.sh       Sys:      125.98      217.34      179.41       30.35
numa01.sh      User:    38318.48    53789.56    45864.17     6620.80
numa02.sh      Real:       60.06       61.27       60.59        0.45
numa02.sh       Sys:       14.25       17.86       16.09        1.28
numa02.sh      User:     5190.13     5225.67     5209.24       13.19
numa03.sh      Real:      748.21      960.25      823.15       73.51
numa03.sh       Sys:       96.68      122.10      110.42       11.29
numa03.sh      User:    58222.16    72595.27    63552.22     5048.87
numa04.sh      Real:      433.08      630.55      499.30       68.15
numa04.sh       Sys:      245.22      386.75      306.09       63.32
numa04.sh      User:    35014.68    46151.72    38530.26     3924.65
numa05.sh      Real:      394.77      410.07      401.41        5.99
numa05.sh       Sys:      212.40      301.82      256.23       35.41
numa05.sh      User:    33224.86    34201.40    33665.61      313.40

Testcase       Time:         Min         Max         Avg      StdDev 	 %Change
numa01.sh      Real:      674.61      997.71      785.01      115.95 	 -29.86%
numa01.sh       Sys:      180.87      318.88      270.13       51.32 	 -33.58%
numa01.sh      User:    54001.30    71936.50    60495.48     6237.55 	 -24.18%
numa02.sh      Real:       60.62       62.30       61.46        0.62 	 -1.415%
numa02.sh       Sys:       15.01       33.63       24.38        6.81 	 -34.00%
numa02.sh      User:     5234.20     5325.60     5276.23       38.85 	 -1.269%
numa03.sh      Real:      827.62      946.85      914.48       44.58 	 -9.987%
numa03.sh       Sys:      135.55      172.40      158.46       12.75 	 -30.31%
numa03.sh      User:    64839.42    73195.44    70805.96     3061.20 	 -10.24%
numa04.sh      Real:      481.01      608.76      521.14       47.28 	 -4.190%
numa04.sh       Sys:      329.59      373.15      353.20       14.20 	 -13.33%
numa04.sh      User:    37649.09    40722.94    38806.32     1072.32 	 -0.711%
numa05.sh      Real:      399.21      415.38      409.88        5.54 	 -2.066%
numa05.sh       Sys:      319.46      418.57      363.31       37.62 	 -29.47%
numa05.sh      User:    33727.77    34732.68    34127.41      447.11 	 -1.353%


The commit does cause some performance regression but is needed from
a fairness/correctness perspective.

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 include/linux/mmzone.h |  1 +
 kernel/sched/fair.c    | 14 ++++++++++++++
 mm/page_alloc.c        |  1 +
 3 files changed, 16 insertions(+)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 32699b2..b0767703 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -677,6 +677,7 @@ struct zonelist {
 
 	/* Number of pages migrated during the rate limiting time interval */
 	unsigned long numabalancing_migrate_nr_pages;
+	int active_node_migrate;
 #endif
 	/*
 	 * This is a per-node reserve of pages that are not available
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3e19e32..259c343 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1478,11 +1478,22 @@ struct task_numa_env {
 static void task_numa_assign(struct task_numa_env *env,
 			     struct task_struct *p, long imp)
 {
+	pg_data_t *pgdat = NODE_DATA(cpu_to_node(env->dst_cpu));
 	struct rq *rq = cpu_rq(env->dst_cpu);
 
 	if (xchg(&rq->numa_migrate_on, 1))
 		return;
 
+	if (!env->best_task && env->best_cpu != -1)
+		WRITE_ONCE(pgdat->active_node_migrate, 0);
+
+	if (!p) {
+		if (xchg(&pgdat->active_node_migrate, 1)) {
+			WRITE_ONCE(rq->numa_migrate_on, 0);
+			return;
+		}
+	}
+
 	if (env->best_cpu != -1) {
 		rq = cpu_rq(env->best_cpu);
 		WRITE_ONCE(rq->numa_migrate_on, 0);
@@ -1819,8 +1830,11 @@ static int task_numa_migrate(struct task_struct *p)
 
 	best_rq = cpu_rq(env.best_cpu);
 	if (env.best_task == NULL) {
+		pg_data_t *pgdat = NODE_DATA(cpu_to_node(env.dst_cpu));
+
 		ret = migrate_task_to(p, env.best_cpu);
 		WRITE_ONCE(best_rq->numa_migrate_on, 0);
+		WRITE_ONCE(pgdat->active_node_migrate, 0);
 		if (ret != 0)
 			trace_sched_stick_numa(p, env.src_cpu, env.best_cpu);
 		return ret;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 905db9d..4526643 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6210,6 +6210,7 @@ static void __paginginit free_area_init_core(struct pglist_data *pgdat)
 #ifdef CONFIG_NUMA_BALANCING
 	spin_lock_init(&pgdat->numabalancing_migrate_lock);
 	pgdat->numabalancing_migrate_nr_pages = 0;
+	pgdat->active_node_migrate = 0;
 	pgdat->numabalancing_migrate_next_window = jiffies;
 #endif
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-- 
1.8.3.1
