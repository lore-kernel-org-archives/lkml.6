Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752393AbeENHyc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 03:54:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44843 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751498AbeENHw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 03:52:56 -0400
Date: Mon, 14 May 2018 00:52:31 -0700
From: tip-bot for Rohit Jain <tipbot@zytor.com>
Message-ID: <tip-943d355d7feef380e15a95892be3dff1095ef54b@git.kernel.org>
Cc: torvalds@linux-foundation.org, mingo@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, peterz@infradead.org, rohit.k.jain@oracle.com,
        efault@gmx.de, linux-kernel@vger.kernel.org
Reply-To: torvalds@linux-foundation.org, efault@gmx.de,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        rohit.k.jain@oracle.com, peterz@infradead.org, mingo@kernel.org,
        hpa@zytor.com
In-Reply-To: <1525883988-10356-1-git-send-email-rohit.k.jain@oracle.com>
References: <1525883988-10356-1-git-send-email-rohit.k.jain@oracle.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/core: Distinguish between idle_cpu() calls
 based on desired effect, introduce available_idle_cpu()
Git-Commit-ID: 943d355d7feef380e15a95892be3dff1095ef54b
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

Commit-ID:  943d355d7feef380e15a95892be3dff1095ef54b
Gitweb:     https://git.kernel.org/tip/943d355d7feef380e15a95892be3dff1095ef54b
Author:     Rohit Jain <rohit.k.jain@oracle.com>
AuthorDate: Wed, 9 May 2018 09:39:48 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 14 May 2018 09:12:26 +0200

sched/core: Distinguish between idle_cpu() calls based on desired effect, introduce available_idle_cpu()

In the following commit:

  247f2f6f3c70 ("sched/core: Don't schedule threads on pre-empted vCPUs")

... we distinguish between idle_cpu() when the vCPU is not running for
scheduling threads.

However, the idle_cpu() function is used in other places for
actually checking whether the state of the CPU is idle or not.

Hence split the use of that function based on the desired return value,
by introducing the available_idle_cpu() function.

This fixes a (slight) regression in that initial vCPU commit, because
some code paths (like the load-balancer) don't care and shouldn't care
if the vCPU is preempted or not, they just want to know if there's any
tasks on the CPU.

Signed-off-by: Rohit Jain <rohit.k.jain@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: dhaval.giani@oracle.com
Cc: linux-kernel@vger.kernel.org
Cc: matt@codeblueprint.co.uk
Cc: steven.sistare@oracle.com
Cc: subhra.mazumdar@oracle.com
Link: http://lkml.kernel.org/r/1525883988-10356-1-git-send-email-rohit.k.jain@oracle.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/sched.h |  1 +
 kernel/sched/core.c   | 14 ++++++++++++++
 kernel/sched/fair.c   | 20 ++++++++++----------
 3 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index c2413703f45d..959a8588e365 100644
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
index 102c36c317dc..d1555185c054 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4009,6 +4009,20 @@ int idle_cpu(int cpu)
 		return 0;
 #endif
 
+	return 1;
+}
+
+/**
+ * available_idle_cpu - is a given CPU idle for enqueuing work.
+ * @cpu: the CPU in question.
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
index f32b97d4c63b..748cb054fefd 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5899,8 +5899,8 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
 	 * a cpufreq perspective, it's better to have higher utilisation
 	 * on one CPU.
 	 */
-	if (idle_cpu(this_cpu) && cpus_share_cache(this_cpu, prev_cpu))
-		return idle_cpu(prev_cpu) ? prev_cpu : this_cpu;
+	if (available_idle_cpu(this_cpu) && cpus_share_cache(this_cpu, prev_cpu))
+		return available_idle_cpu(prev_cpu) ? prev_cpu : this_cpu;
 
 	if (sync && cpu_rq(this_cpu)->nr_running == 1)
 		return this_cpu;
@@ -6143,7 +6143,7 @@ find_idlest_group_cpu(struct sched_group *group, struct task_struct *p, int this
 
 	/* Traverse only the allowed CPUs */
 	for_each_cpu_and(i, sched_group_span(group), &p->cpus_allowed) {
-		if (idle_cpu(i)) {
+		if (available_idle_cpu(i)) {
 			struct rq *rq = cpu_rq(i);
 			struct cpuidle_state *idle = idle_get_state(rq);
 			if (idle && idle->exit_latency < min_exit_latency) {
@@ -6272,7 +6272,7 @@ void __update_idle_core(struct rq *rq)
 		if (cpu == core)
 			continue;
 
-		if (!idle_cpu(cpu))
+		if (!available_idle_cpu(cpu))
 			goto unlock;
 	}
 
@@ -6304,7 +6304,7 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
 
 		for_each_cpu(cpu, cpu_smt_mask(core)) {
 			cpumask_clear_cpu(cpu, cpus);
-			if (!idle_cpu(cpu))
+			if (!available_idle_cpu(cpu))
 				idle = false;
 		}
 
@@ -6333,7 +6333,7 @@ static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int t
 	for_each_cpu(cpu, cpu_smt_mask(target)) {
 		if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
 			continue;
-		if (idle_cpu(cpu))
+		if (available_idle_cpu(cpu))
 			return cpu;
 	}
 
@@ -6396,7 +6396,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 			return -1;
 		if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
 			continue;
-		if (idle_cpu(cpu))
+		if (available_idle_cpu(cpu))
 			break;
 	}
 
@@ -6416,13 +6416,13 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
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
@@ -6430,7 +6430,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	if (recent_used_cpu != prev &&
 	    recent_used_cpu != target &&
 	    cpus_share_cache(recent_used_cpu, target) &&
-	    idle_cpu(recent_used_cpu) &&
+	    available_idle_cpu(recent_used_cpu) &&
 	    cpumask_test_cpu(p->recent_used_cpu, &p->cpus_allowed)) {
 		/*
 		 * Replace recent_used_cpu with prev as it is a potential
