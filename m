Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752608AbeBAMqf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 07:46:35 -0500
Received: from sinrega.org ([188.166.23.170]:33957 "EHLO sinrega.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752450AbeBAMqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 07:46:33 -0500
From: Sergio Lopez <slp@sinrega.org>
To: linux-kernel@vger.kernel.org
Cc: mingo@redhat.com, peterz@infradead.org, Sergio Lopez <slp@sinrega.org>
Subject: [RFC PATCH] sched/fair: Optionally restrict SMT scheduling ("restrict_smt")
Date: Thu,  1 Feb 2018 13:37:48 +0100
Message-Id: <20180201123748.32596-1-slp@sinrega.org>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"restrict_smt" is an optional security feature that, when enabled,
automatically adjusts the cpus_allowed mask of user tasks with CFS
policies, forcing them to run on the first SMT thread of each core.

This security feature prevents user tasks from running on SMT sibling
threads, difficulting the abuse of shared physical resources to
construct covert side-channels or spying on other tasks. "restrict_smt"
also helps in the mitigation of some HT-based Spectre v2 attack
scenarios.

Users with CAP_SYS_NICE are still able to schedule tasks on secondary
SMT threads by exclusively pinning to the latter, so "restrict_smt"
won't interfere with resource planification strategies depending on
that, like vCPU pinning for KVM Guests.

Compared against disabling SMT at a hardware level, "restrict_smt"
presents the following advantages:
 - Secondary SMT threads can still be used by kthreads, or by user
tasks exclusively pinned to them.

Compared against "isolcpus", "restrict_smt" presents the following
advantages:
 - Doesn't require prior knowledge of the CPU topology, making it more
friendly to both end users and automation tools.
 - Load balancing is still active for tasks pinned to multiple secondary
SMT threads.

Signed-off-by: Sergio Lopez <slp@sinrega.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  5 +++
 include/linux/sched/sysctl.h                    |  1 +
 kernel/sched/core.c                             | 30 +++++++++++++++
 kernel/sched/fair.c                             | 49 ++++++++++++++++++++++++-
 kernel/sysctl.c                                 |  7 ++++
 5 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b98048b56..82cc2aeef 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3711,6 +3711,11 @@
 	reset_devices	[KNL] Force drivers to reset the underlying device
 			during initialization.
 
+	restrict_smt	[KNL,SMP] Restrict user tasks to run on the first SMT
+			thread of each core. Secondary SMT threads can still
+			be used by kernel tasks and by user tasks exclusively
+			pinned to them by a user with CAP_SYS_NICE.
+
 	resume=		[SWSUSP]
 			Specify the partition device for software suspend
 			Format:
diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 1c1a1512e..b735b9288 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -23,6 +23,7 @@ extern unsigned int sysctl_sched_latency;
 extern unsigned int sysctl_sched_min_granularity;
 extern unsigned int sysctl_sched_wakeup_granularity;
 extern unsigned int sysctl_sched_child_runs_first;
+extern unsigned int sysctl_sched_restrict_smt;
 
 enum sched_tunable_scaling {
 	SCHED_TUNABLESCALING_NONE,
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3da7a2444..0e7c6b26f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4677,10 +4677,29 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
 	return retval;
 }
 
+static void cpumask_restrict_smt(struct cpumask *new_mask)
+{
+	int cpu;
+
+	for_each_cpu(cpu, new_mask) {
+		const struct cpumask *smt_mask = cpu_smt_mask(cpu);
+		int first_thread = cpumask_first(smt_mask);
+		int last_thread = cpumask_last(smt_mask);
+
+		if (cpu != first_thread) {
+			if (!cpumask_test_cpu(first_thread, new_mask)) {
+				cpumask_set_cpu(first_thread, new_mask);
+				cpu = last_thread;
+			}
+		}
+	}
+}
+
 long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 {
 	cpumask_var_t cpus_allowed, new_mask;
 	struct task_struct *p;
+	int cap_sys_nice = false;
 	int retval;
 
 	rcu_read_lock();
@@ -4714,6 +4733,7 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 			rcu_read_unlock();
 			goto out_free_new_mask;
 		}
+		cap_sys_nice = true;
 		rcu_read_unlock();
 	}
 
@@ -4725,6 +4745,16 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 	cpuset_cpus_allowed(p, cpus_allowed);
 	cpumask_and(new_mask, in_mask, cpus_allowed);
 
+	if (sysctl_sched_restrict_smt && p->sched_class == &fair_sched_class) {
+		if (!cap_sys_nice) {
+			rcu_read_lock();
+			if (!ns_capable(__task_cred(p)->user_ns, CAP_SYS_NICE)) {
+				cpumask_restrict_smt(new_mask);
+			}
+			rcu_read_unlock();
+		}
+	}
+
 	/*
 	 * Since bandwidth control happens on root_domain basis,
 	 * if admission test is enabled, we only admit -deadline
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7b6535987..3c805cb9a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -101,6 +101,13 @@ unsigned int normalized_sysctl_sched_wakeup_granularity	= 1000000UL;
 
 const_debug unsigned int sysctl_sched_migration_cost	= 500000UL;
 
+/*
+ * Control SMT restricted mode. If set to 1 (default is 0),
+ * and multiple sibling SMT threads are present in a new cpu mask for
+ * task->cpus_allowed, only the first thread per core will be admited.
+ */
+unsigned int sysctl_sched_restrict_smt __read_mostly;
+
 #ifdef CONFIG_SMP
 /*
  * For asym packing, by default the lower numbered cpu has higher priority.
@@ -6449,6 +6456,32 @@ static void task_dead_fair(struct task_struct *p)
 {
 	remove_entity_load_avg(&p->se);
 }
+
+static void set_cpus_allowed_fair(struct task_struct *p, const struct cpumask *new_mask)
+{
+	cpumask_var_t tmp_mask;
+	int cpu, thread;
+
+	if (p->flags & PF_KTHREAD ||
+	    !static_branch_likely(&sched_smt_present) ||
+	    !sysctl_sched_restrict_smt ||
+	    !alloc_cpumask_var(&tmp_mask, GFP_KERNEL)) {
+	    /* Fallback to common function */
+	    return set_cpus_allowed_common(p, new_mask);
+	}
+
+	cpumask_copy(tmp_mask, new_mask);
+	for_each_cpu(cpu, tmp_mask) {
+		for_each_cpu(thread, cpu_smt_mask(cpu)) {
+			if (thread != cpu)
+				cpumask_clear_cpu(thread, tmp_mask);
+		}
+	}
+	cpumask_copy(&p->cpus_allowed, tmp_mask);
+	p->nr_cpus_allowed = cpumask_weight(tmp_mask);
+
+	free_cpumask_var(tmp_mask);
+}
 #endif /* CONFIG_SMP */
 
 static unsigned long wakeup_gran(struct sched_entity *se)
@@ -9447,6 +9480,11 @@ static void task_fork_fair(struct task_struct *p)
 	struct rq *rq = this_rq();
 	struct rq_flags rf;
 
+	if (sysctl_sched_restrict_smt) {
+		/* Reset restricted SMT policy */
+		set_cpus_allowed_fair(p, &p->cpus_allowed);
+	}
+
 	rq_lock(rq, &rf);
 	update_rq_clock(rq);
 
@@ -9913,7 +9951,7 @@ const struct sched_class fair_sched_class = {
 	.rq_offline		= rq_offline_fair,
 
 	.task_dead		= task_dead_fair,
-	.set_cpus_allowed	= set_cpus_allowed_common,
+	.set_cpus_allowed	= set_cpus_allowed_fair,
 #endif
 
 	.set_curr_task          = set_curr_task_fair,
@@ -9933,6 +9971,15 @@ const struct sched_class fair_sched_class = {
 #endif
 };
 
+static int __init setup_restrict_smt(char *str)
+{
+	sysctl_sched_restrict_smt = 1;
+
+	return 1;
+}
+
+__setup("restrict_smt", setup_restrict_smt);
+
 #ifdef CONFIG_SCHED_DEBUG
 void print_cfs_stats(struct seq_file *m, int cpu)
 {
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 557d46728..f52c1ddcc 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -310,6 +310,13 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
+	{
+		.procname	= "sched_restrict_smt",
+		.data		= &sysctl_sched_restrict_smt,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
 #ifdef CONFIG_SCHED_DEBUG
 	{
 		.procname	= "sched_min_granularity_ns",
-- 
2.14.3
