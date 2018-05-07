Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753457AbeEGXmI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 19:42:08 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49694 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752954AbeEGXmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 19:42:07 -0400
From: Rohit Jain <rohit.k.jain@oracle.com>
To: matt@codeblueprint.co.uk, peterz@infradead.org
Cc: mingo@kernel.org, dhaval.giani@oracle.com, subhra.mazumdar@oracle.com,
        steven.sistare@oracle.com, linux-kernel@vger.kernel.org
Subject: [RFC] sched: Distinguish between idle_cpu calls based on desired effect
Date: Mon,  7 May 2018 16:41:17 -0700
Message-Id: <1525736477-8184-1-git-send-email-rohit.k.jain@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8886 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805070228
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 247f2f6f3c706b40b5f3886646f3eb53671258bf we distinguish
between idle_cpu when the vcpu is not running for scheduling threads.
However, idle_cpu function is used at other places for actually checking
whether the state of the CPU is idle or not. Hence splitting the use of
that function based on the desired return value.

Signed-off-by: Rohit Jain <rohit.k.jain@oracle.com>
---
 include/linux/sched.h |  1 +
 kernel/sched/core.c   | 14 ++++++++++++++
 kernel/sched/fair.c   | 20 ++++++++++----------
 3 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index c241370..959a858 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1504,6 +1504,7 @@ static inline int task_nice(const struct task_struct *p)
 extern int can_nice(const struct task_struct *p, const int nice);
 extern int task_curr(const struct task_struct *p);
 extern int idle_cpu(int cpu);
+extern int available_idle_cpu(int cpu);
 extern int sched_setscheduler(struct task_struct *, int, const struct sched_param *);
 extern int sched_setscheduler_nocheck(struct task_struct *, int, const struct sched_param *);
 extern int sched_setattr(struct task_struct *, const struct sched_attr *);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 71bdb86..171e160 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4028,6 +4028,20 @@ int idle_cpu(int cpu)
 		return 0;
 #endif
 
+	return 1;
+}
+
+/**
+ * idle_cpu - is a given CPU idle for enqueuing work.
+ * @cpu: the processor in question.
+ *
+ * Return: 1 if the CPU is currently idle. 0 otherwise.
+ */
+int available_idle_cpu(int cpu)
+{
+	if (!idle_cpu(cpu))
+		return 0;
+
 	if (vcpu_is_preempted(cpu))
 		return 0;
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1f6a23a..a0b0da4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5870,8 +5870,8 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
 	 * a cpufreq perspective, it's better to have higher utilisation
 	 * on one CPU.
 	 */
-	if (idle_cpu(this_cpu) && cpus_share_cache(this_cpu, prev_cpu))
-		return idle_cpu(prev_cpu) ? prev_cpu : this_cpu;
+	if (available_idle_cpu(this_cpu) && cpus_share_cache(this_cpu, prev_cpu))
+		return available_idle_cpu(prev_cpu) ? prev_cpu : this_cpu;
 
 	if (sync && cpu_rq(this_cpu)->nr_running == 1)
 		return this_cpu;
@@ -6157,7 +6157,7 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
 
 	/* Traverse only the allowed CPUs */
 	for_each_cpu_and(i, sched_group_span(group), &p->cpus_allowed) {
-		if (idle_cpu(i)) {
+		if (available_idle_cpu(i)) {
 			struct rq *rq = cpu_rq(i);
 			struct cpuidle_state *idle = idle_get_state(rq);
 			if (idle && idle->exit_latency < min_exit_latency) {
@@ -6286,7 +6286,7 @@ void __update_idle_core(struct rq *rq)
 		if (cpu == core)
 			continue;
 
-		if (!idle_cpu(cpu))
+		if (!available_idle_cpu(cpu))
 			goto unlock;
 	}
 
@@ -6318,7 +6318,7 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
 
 		for_each_cpu(cpu, cpu_smt_mask(core)) {
 			cpumask_clear_cpu(cpu, cpus);
-			if (!idle_cpu(cpu))
+			if (!available_idle_cpu(cpu))
 				idle = false;
 		}
 
@@ -6347,7 +6347,7 @@ static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int t
 	for_each_cpu(cpu, cpu_smt_mask(target)) {
 		if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
 			continue;
-		if (idle_cpu(cpu))
+		if (available_idle_cpu(cpu))
 			return cpu;
 	}
 
@@ -6410,7 +6410,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 			return -1;
 		if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
 			continue;
-		if (idle_cpu(cpu))
+		if (available_idle_cpu(cpu))
 			break;
 	}
 
@@ -6430,13 +6430,13 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	struct sched_domain *sd;
 	int i, recent_used_cpu;
 
-	if (idle_cpu(target))
+	if (available_idle_cpu(target))
 		return target;
 
 	/*
 	 * If the previous CPU is cache affine and idle, don't be stupid:
 	 */
-	if (prev != target && cpus_share_cache(prev, target) && idle_cpu(prev))
+	if (prev != target && cpus_share_cache(prev, target) && available_idle_cpu(prev))
 		return prev;
 
 	/* Check a recently used CPU as a potential idle candidate: */
@@ -6444,7 +6444,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	if (recent_used_cpu != prev &&
 	    recent_used_cpu != target &&
 	    cpus_share_cache(recent_used_cpu, target) &&
-	    idle_cpu(recent_used_cpu) &&
+	    available_idle_cpu(recent_used_cpu) &&
 	    cpumask_test_cpu(p->recent_used_cpu, &p->cpus_allowed)) {
 		/*
 		 * Replace recent_used_cpu with prev as it is a potential
-- 
2.7.4
