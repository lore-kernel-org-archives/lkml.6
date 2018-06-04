Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752668AbeFDKBR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 06:01:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34396 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752416AbeFDKBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 06:01:14 -0400
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 09/19] sched/numa: Modify migrate_swap to accept additional params
Date: Mon,  4 Jun 2018 15:30:18 +0530
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
References: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18060410-0008-0000-0000-000002437372
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060410-0009-0000-0000-000021A93244
Message-Id: <1528106428-19992-10-git-send-email-srikar@linux.vnet.ibm.com>
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

There are checks in migrate_swap_stop that check if the task/cpu
combination is as per migrate_swap_arg before migrating.

However atleast one of the two tasks to be swapped by migrate_swap could
have migrated to a completely different cpu before updating the
migrate_swap_arg. The new cpu where the task is currently running could
be a different node too. If the task has migrated, numa balancer might
end up placing a task in a wrong node.  Instead of achieving node
consolidation, it may end up spreading the load across nodes.

To avoid that pass the cpus as additional parameters.

While here, place migrate_swap under CONFIG_NUMA_BALANCING.

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 kernel/sched/core.c  | 9 ++++++---
 kernel/sched/fair.c  | 3 ++-
 kernel/sched/sched.h | 3 ++-
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 092f7c4..68849c2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1178,6 +1178,7 @@ void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
 	__set_task_cpu(p, new_cpu);
 }
 
+#ifdef CONFIG_NUMA_BALANCING
 static void __migrate_swap_task(struct task_struct *p, int cpu)
 {
 	if (task_on_rq_queued(p)) {
@@ -1259,16 +1260,17 @@ static int migrate_swap_stop(void *data)
 /*
  * Cross migrate two tasks
  */
-int migrate_swap(struct task_struct *cur, struct task_struct *p)
+int migrate_swap(struct task_struct *cur, struct task_struct *p,
+		int target_cpu, int curr_cpu)
 {
 	struct migration_swap_arg arg;
 	int ret = -EINVAL;
 
 	arg = (struct migration_swap_arg){
 		.src_task = cur,
-		.src_cpu = task_cpu(cur),
+		.src_cpu = curr_cpu,
 		.dst_task = p,
-		.dst_cpu = task_cpu(p),
+		.dst_cpu = target_cpu,
 	};
 
 	if (arg.src_cpu == arg.dst_cpu)
@@ -1293,6 +1295,7 @@ int migrate_swap(struct task_struct *cur, struct task_struct *p)
 out:
 	return ret;
 }
+#endif /* CONFIG_NUMA_BALANCING */
 
 /*
  * wait_task_inactive - wait for a thread to unschedule.
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 35c4a75..46d773c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1810,7 +1810,8 @@ static int task_numa_migrate(struct task_struct *p)
 		return ret;
 	}
 
-	ret = migrate_swap(p, env.best_task);
+	ret = migrate_swap(p, env.best_task, env.best_cpu, env.src_cpu);
+
 	if (ret != 0)
 		trace_sched_stick_numa(p, env.src_cpu, task_cpu(env.best_task));
 	put_task_struct(env.best_task);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 15750c2..211841e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1068,7 +1068,8 @@ enum numa_faults_stats {
 };
 extern void sched_setnuma(struct task_struct *p, int node);
 extern int migrate_task_to(struct task_struct *p, int cpu);
-extern int migrate_swap(struct task_struct *, struct task_struct *);
+extern int migrate_swap(struct task_struct *p, struct task_struct *t,
+			int cpu, int scpu);
 #endif /* CONFIG_NUMA_BALANCING */
 
 #ifdef CONFIG_SMP
-- 
1.8.3.1
