Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965918AbeBMUe5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 15:34:57 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33687 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965795AbeBMUc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 15:32:57 -0500
X-Google-Smtp-Source: AH8x225J4cXK9g754aUYoS14hprrd5VSeNPQgr4FMQ5I86ld/lCm//ryLUa8RS3iLWOWOMYj3L4cIg==
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: peterz@infradead.org
Cc: lizefan@huawei.com, mingo@redhat.com, rostedt@goodmis.org,
        claudio@evidence.eu.com, bristot@redhat.com,
        tommaso.cucinotta@santannapisa.it, juri.lelli@redhat.com,
        luca.abeni@santannapisa.it, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 04/10] sched/core: Prevent race condition between cpuset and __sched_setscheduler()
Date: Tue, 13 Feb 2018 13:32:41 -0700
Message-Id: <1518553967-20656-5-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518553967-20656-1-git-send-email-mathieu.poirier@linaro.org>
References: <1518553967-20656-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No synchronisation mechanism exist between the cpuset subsystem and calls
to function __sched_setscheduler().  As such it is possible that new root
domains are created on the cpuset side while a deadline acceptance test
is carried out in __sched_setscheduler(), leading to a potential oversell
of CPU bandwidth.

By making available the cpuset_mutex to the core scheduler it is possible
to prevent situations such as the one described above from happening.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 include/linux/cpuset.h |  6 ++++++
 kernel/cgroup/cpuset.c | 16 ++++++++++++++++
 kernel/sched/core.c    |  9 +++++++++
 3 files changed, 31 insertions(+)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 934633a05d20..4bbb3f5a3020 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -55,6 +55,8 @@ extern void cpuset_init_smp(void);
 extern void cpuset_force_rebuild(void);
 extern void cpuset_update_active_cpus(void);
 extern void cpuset_wait_for_hotplug(void);
+extern void cpuset_lock(void);
+extern void cpuset_unlock(void);
 extern void cpuset_cpus_allowed(struct task_struct *p, struct cpumask *mask);
 extern void cpuset_cpus_allowed_fallback(struct task_struct *p);
 extern nodemask_t cpuset_mems_allowed(struct task_struct *p);
@@ -176,6 +178,10 @@ static inline void cpuset_update_active_cpus(void)
 
 static inline void cpuset_wait_for_hotplug(void) { }
 
+static inline void cpuset_lock(void) { }
+
+static inline void cpuset_unlock(void) { }
+
 static inline void cpuset_cpus_allowed(struct task_struct *p,
 				       struct cpumask *mask)
 {
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index d18c72e83de4..41f8391640e6 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2410,6 +2410,22 @@ void __init cpuset_init_smp(void)
 }
 
 /**
+ * cpuset_lock - Grab the cpuset_mutex from another subsysytem
+ */
+void cpuset_lock(void)
+{
+	mutex_lock(&cpuset_mutex);
+}
+
+/**
+ * cpuset_unlock - Release the cpuset_mutex from another subsysytem
+ */
+void cpuset_unlock(void)
+{
+	mutex_unlock(&cpuset_mutex);
+}
+
+/**
  * cpuset_cpus_allowed - return cpus_allowed mask from a tasks cpuset.
  * @tsk: pointer to task_struct from which to obtain cpuset->cpus_allowed.
  * @pmask: pointer to struct cpumask variable to receive cpus_allowed set.
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f727c3d0064c..0d8badcf1f0f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4176,6 +4176,13 @@ static int __sched_setscheduler(struct task_struct *p,
 	}
 
 	/*
+	 * Make sure we don't race with the cpuset subsystem where root
+	 * domains can be rebuilt or modified while operations like DL
+	 * admission checks are carried out.
+	 */
+	cpuset_lock();
+
+	/*
 	 * Make sure no PI-waiters arrive (or leave) while we are
 	 * changing the priority of the task:
 	 *
@@ -4247,6 +4254,7 @@ static int __sched_setscheduler(struct task_struct *p,
 	if (unlikely(oldpolicy != -1 && oldpolicy != p->policy)) {
 		policy = oldpolicy = -1;
 		task_rq_unlock(rq, p, &rf);
+		cpuset_unlock();
 		goto recheck;
 	}
 
@@ -4316,6 +4324,7 @@ static int __sched_setscheduler(struct task_struct *p,
 
 unlock:
 	task_rq_unlock(rq, p, &rf);
+	cpuset_unlock();
 	return retval;
 }
 
-- 
2.7.4
