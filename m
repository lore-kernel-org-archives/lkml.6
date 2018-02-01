Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752960AbeBAQxZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 11:53:25 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:38559 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752772AbeBAQvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 11:51:18 -0500
X-Google-Smtp-Source: AH8x225hB1GbjJ9fCsSlk2Is+JKp8ojOK3h750PcHV8mwuRSEbXgZDMkVpch8FJa0ld8nG5iizlhBQ==
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: peterz@infradead.org
Cc: lizefan@huawei.com, mingo@redhat.com, rostedt@goodmis.org,
        claudio@evidence.eu.com, bristot@redhat.com,
        tommaso.cucinotta@santannapisa.it, juri.lelli@redhat.com,
        luca.abeni@santannapisa.it, linux-kernel@vger.kernel.org
Subject: [PATCH V2 3/7] sched/deadline: Keep new DL task within root domain's boundary
Date: Thu,  1 Feb 2018 09:51:05 -0700
Message-Id: <1517503869-3179-4-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517503869-3179-1-git-send-email-mathieu.poirier@linaro.org>
References: <1517503869-3179-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When considering to move a task to the DL policy we need to make sure
the CPUs it is allowed to run on matches the CPUs of the root domains of
the runqueue it is currently assigned to.  Otherwise the task will be
allowed to roam on CPUs outside of this root domain, something that will
skew system deadline statistics and potentially lead to over selling DL
bandwidth.

For example say we have a 4 core system split in 2 cpuset: set1 has CPU 0
and 1 while set2 has CPU 2 and 3.  This results in 3 cpuset - the default
set that has all 4 CPUs along with set1 and set2 as just depicted.  We also
have task A that hasn't been assigned to any CPUset and as such, is part of
the default CPUset.

At the time we want to move task A to a DL policy it has been assigned to
CPU1.  Since CPU1 is part of set1 the root domain will have 2 CPUs in it
and the bandwidth constraint checked against the current DL bandwidth
allotment of those 2 CPUs.

If task A is promoted to a DL policy it's 'cpus_allowed' mask is still
equal to the CPUs in the default CPUset, making it possible for the
scheduler to move it to CPU2 and CPU3, which could also be running DL tasks
of their own.

This patch makes sure that a task's cpus_allowed mask matches the CPUs
in the root domain associated to the runqueue it has been assigned to.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 include/linux/cpuset.h |  6 ++++++
 kernel/cgroup/cpuset.c | 23 +++++++++++++++++++++++
 kernel/sched/core.c    | 22 ++++++++++++++++++++++
 3 files changed, 51 insertions(+)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 1b8e41597ef5..61a405ffc3b1 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -57,6 +57,7 @@ extern void cpuset_update_active_cpus(void);
 extern void cpuset_wait_for_hotplug(void);
 extern void cpuset_cpus_allowed(struct task_struct *p, struct cpumask *mask);
 extern void cpuset_cpus_allowed_fallback(struct task_struct *p);
+extern bool cpuset_cpus_match_task(struct task_struct *tsk);
 extern nodemask_t cpuset_mems_allowed(struct task_struct *p);
 #define cpuset_current_mems_allowed (current->mems_allowed)
 void cpuset_init_current_mems_allowed(void);
@@ -186,6 +187,11 @@ static inline void cpuset_cpus_allowed_fallback(struct task_struct *p)
 {
 }
 
+bool cpuset_cpus_match_task(struct task_struct *tsk)
+{
+	return true;
+}
+
 static inline nodemask_t cpuset_mems_allowed(struct task_struct *p)
 {
 	return node_possible_map;
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index fc5c709f99cf..6942c4652f31 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2517,6 +2517,29 @@ void cpuset_cpus_allowed_fallback(struct task_struct *tsk)
 	 */
 }
 
+/**
+ * cpuset_cpus_match_task - return whether a task's cpus_allowed mask matches
+ * that of the cpuset it is assigned to.
+ * @tsk: pointer to the task_struct from which tsk->cpus_allowd is obtained.
+ *
+ * Description: Returns 'true' if the cpus_allowed mask of a task is the same
+ * as the cpus_allowed of the cpuset the task belongs to.  This is useful in
+ * situation where both cpuset and DL tasks are used.
+ */
+bool cpuset_cpus_match_task(struct task_struct *tsk)
+{
+	bool ret;
+	unsigned long flags;
+
+	spin_lock_irqsave(&callback_lock, flags);
+	rcu_read_lock();
+	ret = cpumask_equal((task_cs(tsk))->cpus_allowed, &tsk->cpus_allowed);
+	rcu_read_unlock();
+	spin_unlock_irqrestore(&callback_lock, flags);
+
+	return ret;
+}
+
 void __init cpuset_init_current_mems_allowed(void)
 {
 	nodes_setall(current->mems_allowed);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a7bf32aabfda..1a64aad1b9dc 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4188,6 +4188,28 @@ static int __sched_setscheduler(struct task_struct *p,
 	}
 
 	/*
+	 * If setscheduling to SCHED_DEADLINE we need to make sure the task
+	 * is constrained to run within the root domain it is associated with,
+	 * something that isn't guaranteed when using cpusets.
+	 *
+	 * Speaking of cpusets, we also need to assert that a task's
+	 * cpus_allowed mask equals its cpuset's cpus_allowed mask. Otherwise
+	 * a DL task could be assigned to a cpuset that has more CPUs than the
+	 * root domain it is associated with, a situation that yields no
+	 * benefits and greatly complicate the management of DL task when
+	 * cpusets are present.
+	 */
+	if (dl_policy(policy)) {
+		struct root_domain *rd = cpu_rq(task_cpu(p))->rd;
+
+		if (!cpumask_equal(&p->cpus_allowed, rd->span) ||
+		    !cpuset_cpus_match_task(p)) {
+			task_rq_unlock(rq, p, &rf);
+			return -EBUSY;
+		}
+	}
+
+	/*
 	 * If setscheduling to SCHED_DEADLINE (or changing the parameters
 	 * of a SCHED_DEADLINE task) we need to check if enough bandwidth
 	 * is available.
-- 
2.7.4
