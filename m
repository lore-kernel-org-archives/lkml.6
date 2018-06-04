Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752714AbeFDKB0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 06:01:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39730 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752656AbeFDKBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 06:01:17 -0400
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 10/19] sched/numa: Stop multiple tasks from moving to the cpu at the same time
Date: Mon,  4 Jun 2018 15:30:19 +0530
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
References: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18060410-4275-0000-0000-000002895C9E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060410-4276-0000-0000-0000379070FB
Message-Id: <1528106428-19992-11-git-send-email-srikar@linux.vnet.ibm.com>
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

Task migration under numa balancing can happen in parallel. More than
one task might choose to migrate to the same cpu at the same time. This
can result in
- During task swap, choosing a task that was not part of the evaluation.
- During task swap, task which just got moved into its preferred node,
  moving to a completely different node.
- During task swap, task failing to move to the preferred node, will have
  to wait an extra interval for the next migrate opportunity.
- During task movement, multiple task movements can cause load imbalance.

This problem is more likely if there are more cores per node or more
nodes in the system.

Use a per run-queue variable to check if numa-balance is active on the
run-queue.

Testcase       Time:         Min         Max         Avg      StdDev
numa01.sh      Real:      414.64      819.20      556.08      147.70
numa01.sh       Sys:       77.52      205.04      139.40       52.05
numa01.sh      User:    37043.24    61757.88    45517.48     9290.38
numa02.sh      Real:       60.80       63.32       61.63        0.88
numa02.sh       Sys:       17.35       39.37       25.71        7.33
numa02.sh      User:     5213.79     5374.73     5268.90       55.09
numa03.sh      Real:      780.09      948.64      831.43       63.02
numa03.sh       Sys:      104.96      136.92      116.31       11.34
numa03.sh      User:    60465.42    73339.78    64368.03     4700.14
numa04.sh      Real:      412.60      681.92      521.29       96.64
numa04.sh       Sys:      210.32      314.10      251.77       37.71
numa04.sh      User:    34026.38    45581.20    38534.49     4198.53
numa05.sh      Real:      394.79      439.63      411.35       16.87
numa05.sh       Sys:      238.32      330.09      292.31       38.32
numa05.sh      User:    33456.45    34876.07    34138.62      609.45

Testcase       Time:         Min         Max         Avg      StdDev 	 %Change
numa01.sh      Real:      434.84      676.90      550.53      106.24 	 1.008%
numa01.sh       Sys:      125.98      217.34      179.41       30.35 	 -22.3%
numa01.sh      User:    38318.48    53789.56    45864.17     6620.80 	 -0.75%
numa02.sh      Real:       60.06       61.27       60.59        0.45 	 1.716%
numa02.sh       Sys:       14.25       17.86       16.09        1.28 	 59.78%
numa02.sh      User:     5190.13     5225.67     5209.24       13.19 	 1.145%
numa03.sh      Real:      748.21      960.25      823.15       73.51 	 1.005%
numa03.sh       Sys:       96.68      122.10      110.42       11.29 	 5.334%
numa03.sh      User:    58222.16    72595.27    63552.22     5048.87 	 1.283%
numa04.sh      Real:      433.08      630.55      499.30       68.15 	 4.404%
numa04.sh       Sys:      245.22      386.75      306.09       63.32 	 -17.7%
numa04.sh      User:    35014.68    46151.72    38530.26     3924.65 	 0.010%
numa05.sh      Real:      394.77      410.07      401.41        5.99 	 2.476%
numa05.sh       Sys:      212.40      301.82      256.23       35.41 	 14.08%
numa05.sh      User:    33224.86    34201.40    33665.61      313.40 	 1.405%

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 kernel/sched/fair.c  | 17 +++++++++++++++++
 kernel/sched/sched.h |  1 +
 2 files changed, 18 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 46d773c..3e19e32 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1478,6 +1478,16 @@ struct task_numa_env {
 static void task_numa_assign(struct task_numa_env *env,
 			     struct task_struct *p, long imp)
 {
+	struct rq *rq = cpu_rq(env->dst_cpu);
+
+	if (xchg(&rq->numa_migrate_on, 1))
+		return;
+
+	if (env->best_cpu != -1) {
+		rq = cpu_rq(env->best_cpu);
+		WRITE_ONCE(rq->numa_migrate_on, 0);
+	}
+
 	if (env->best_task)
 		put_task_struct(env->best_task);
 	if (p)
@@ -1533,6 +1543,9 @@ static void task_numa_compare(struct task_numa_env *env,
 	long moveimp = imp;
 	int dist = env->dist;
 
+	if (READ_ONCE(dst_rq->numa_migrate_on))
+		return;
+
 	rcu_read_lock();
 	cur = task_rcu_dereference(&dst_rq->curr);
 	if (cur && ((cur->flags & PF_EXITING) || is_idle_task(cur)))
@@ -1699,6 +1712,7 @@ static int task_numa_migrate(struct task_struct *p)
 		.best_cpu = -1,
 	};
 	struct sched_domain *sd;
+	struct rq *best_rq;
 	unsigned long taskweight, groupweight;
 	int nid, ret, dist;
 	long taskimp, groupimp;
@@ -1803,14 +1817,17 @@ static int task_numa_migrate(struct task_struct *p)
 	 */
 	p->numa_scan_period = task_scan_start(p);
 
+	best_rq = cpu_rq(env.best_cpu);
 	if (env.best_task == NULL) {
 		ret = migrate_task_to(p, env.best_cpu);
+		WRITE_ONCE(best_rq->numa_migrate_on, 0);
 		if (ret != 0)
 			trace_sched_stick_numa(p, env.src_cpu, env.best_cpu);
 		return ret;
 	}
 
 	ret = migrate_swap(p, env.best_task, env.best_cpu, env.src_cpu);
+	WRITE_ONCE(best_rq->numa_migrate_on, 0);
 
 	if (ret != 0)
 		trace_sched_stick_numa(p, env.src_cpu, task_cpu(env.best_task));
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 211841e..55bc6e1 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -756,6 +756,7 @@ struct rq {
 #ifdef CONFIG_NUMA_BALANCING
 	unsigned int		nr_numa_running;
 	unsigned int		nr_preferred_running;
+	unsigned int		numa_migrate_on;
 #endif
 	#define CPU_LOAD_IDX_MAX 5
 	unsigned long		cpu_load[CPU_LOAD_IDX_MAX];
-- 
1.8.3.1
