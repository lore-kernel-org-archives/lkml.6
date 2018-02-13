Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965851AbeBMUdE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 15:33:04 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:41848 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965789AbeBMUdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 15:33:01 -0500
X-Google-Smtp-Source: AH8x225dDjtT9d+lXGqIWN6etryjq//FY6Xr+WPdOh74SegX0/jwaityU9LN//6pT3E1IkjmVLs+Sw==
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: peterz@infradead.org
Cc: lizefan@huawei.com, mingo@redhat.com, rostedt@goodmis.org,
        claudio@evidence.eu.com, bristot@redhat.com,
        tommaso.cucinotta@santannapisa.it, juri.lelli@redhat.com,
        luca.abeni@santannapisa.it, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 06/10] sched/deadline: Keep new DL task within root domain's boundary
Date: Tue, 13 Feb 2018 13:32:43 -0700
Message-Id: <1518553967-20656-7-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518553967-20656-1-git-send-email-mathieu.poirier@linaro.org>
References: <1518553967-20656-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When considering to move a task to the DL policy we need to make sure
the CPUs it is allowed to run on matches the CPUs of the root domain of
the runqueue it is currently assigned to.  Otherwise the task will be
allowed to roam on CPUs outside of this root domain, something that will
skew system deadline statistics and potentially lead to over selling DL
bandwidth.

For example we have a system where the cpuset.sched_load_balance flag of
the root cpuset has been set to 0 and the 4 core system split in 2 cpuset:
set1 has CPU 0 and 1 while set2 has CPU 2 and 3.  This results in 3 cpuset,
i.e, the default set that has all 4 CPUs along with set1 and set2 as just
depicted.  We also have task A that hasn't been assigned to any CPUset and
as such, is part of the default (root) CPUset.

At the time we want to move task A to a DL policy it has been assigned to
CPU1.  Since CPU1 is part of set1 the root domain will have 2 CPUs in it
and the bandwidth constraint checked against the current DL bandwidth
allotment of those 2 CPUs.

If task A is promoted to a DL policy it's 'cpus_allowed' mask is still
equal to the CPUs in the default CPUset, making it possible for the
scheduler to move it to CPU2 and CPU3, which could also be running DL tasks
of their own.

This patch makes sure that a task's cpus_allowed mask matches the CPUs
of the root domain associated to the runqueue it has been assigned to.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 include/linux/cpuset.h |  6 ++++++
 kernel/cgroup/cpuset.c | 23 +++++++++++++++++++++++
 kernel/sched/core.c    | 20 ++++++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 4bbb3f5a3020..f6a9051de907 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -57,6 +57,7 @@ extern void cpuset_update_active_cpus(void);
 extern void cpuset_wait_for_hotplug(void);
 extern void cpuset_lock(void);
 extern void cpuset_unlock(void);
+extern bool cpuset_cpus_match_task(struct task_struct *tsk);
 extern void cpuset_cpus_allowed(struct task_struct *p, struct cpumask *mask);
 extern void cpuset_cpus_allowed_fallback(struct task_struct *p);
 extern nodemask_t cpuset_mems_allowed(struct task_struct *p);
@@ -182,6 +183,11 @@ static inline void cpuset_lock(void) { }
 
 static inline void cpuset_unlock(void) { }
 
+static inline bool cpuset_cpus_match_task(struct task_struct *tsk)
+{
+	return true;
+}
+
 static inline void cpuset_cpus_allowed(struct task_struct *p,
 				       struct cpumask *mask)
 {
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index d8108030b754..45a5035ae601 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2487,6 +2487,29 @@ void cpuset_unlock(void)
 }
 
 /**
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
+/**
  * cpuset_cpus_allowed - return cpus_allowed mask from a tasks cpuset.
  * @tsk: pointer to task_struct from which to obtain cpuset->cpus_allowed.
  * @pmask: pointer to struct cpumask variable to receive cpus_allowed set.
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0d8badcf1f0f..b930857f4d14 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4237,6 +4237,26 @@ static int __sched_setscheduler(struct task_struct *p,
 			cpumask_t *span = rq->rd->span;
 
 			/*
+			 * If setscheduling to SCHED_DEADLINE we need to make
+			 * sure the task is constrained to run within the root
+			 * domain it is associated with, something that isn't
+			 * guaranteed when using cpusets.
+			 *
+			 * Speaking of cpusets, we also need to assert that a
+			 * task's cpus_allowed mask equals its cpuset's
+			 * cpus_allowed mask. Otherwise a DL task could be
+			 * assigned to a cpuset that has more CPUs than the root
+			 * domain it is associated with, a situation that yields
+			 * no benefits and greatly complicate the management of
+			 * DL task when cpusets are present.
+			 */
+			if (!cpumask_equal(&p->cpus_allowed, span) ||
+			    !cpuset_cpus_match_task(p)) {
+				retval = -EPERM;
+				goto unlock;
+			}
+
+			/*
 			 * Don't allow tasks with an affinity mask smaller than
 			 * the entire root_domain to become SCHED_DEADLINE. We
 			 * will also fail if there's no bandwidth available.
-- 
2.7.4
