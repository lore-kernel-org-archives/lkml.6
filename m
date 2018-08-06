Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC4FC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C27C21A18
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:40:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C27C21A18
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733302AbeHFSuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 14:50:24 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41724 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727561AbeHFSuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 14:50:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F7B615A2;
        Mon,  6 Aug 2018 09:40:30 -0700 (PDT)
Received: from e110439-lin.Cambridge.Arm.com (e110439-lin.emea.arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A28D23F5D0;
        Mon,  6 Aug 2018 09:40:27 -0700 (PDT)
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH v3 01/14] sched/core: uclamp: extend sched_setattr to support utilization clamping
Date:   Mon,  6 Aug 2018 17:39:33 +0100
Message-Id: <20180806163946.28380-2-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180806163946.28380-1-patrick.bellasi@arm.com>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SCHED_DEADLINE scheduling class provides an advanced and formal
model to define tasks requirements which can be translated into proper
decisions for both task placements and frequencies selections.
Other classes have a more simplified model which is essentially based on
the relatively simple concept of POSIX priorities.

Such a simple priority based model however does not allow to exploit
some of the most advanced features of the Linux scheduler like, for
example, driving frequencies selection via the schedutil cpufreq
governor. However, also for non SCHED_DEADLINE tasks, it's still
interesting to define tasks properties which can be used to better
support certain scheduler decisions.

Utilization clamping aims at exposing to user-space a new set of
per-task attributes which can be used to provide the scheduler with some
hints about the expected/required utilization for a task.
This will allow to implement a more advanced per-task frequency control
mechanism which is not based just on a "passive" measured task
utilization but on a more "active" approach. For example, it could be
possible to boost interactive tasks, thus getting better performance, or
cap background tasks, thus being more energy efficient.
Ultimately, such a mechanism can be considered similar to the cpufreq's
powersave, performance and userspace governor but with a much fine
grained and per-task control.

Let's introduce a new API to set utilization clamping values for a
specified task by extending sched_setattr, a syscall which already
allows to define task specific properties for different scheduling
classes.
Specifically, a new pair of attributes allows to specify a minimum and
maximum utilization which the scheduler should consider for a task.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Paul Turner <pjt@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Steve Muckle <smuckle@google.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org

---
Changes in v3:
 Message-ID: <CAJuCfpF6=L=0LrmNnJrTNPazT4dWKqNv+thhN0dwpKCgUzs9sg@mail.gmail.com>
 - removed UCLAMP_NONE not used by this patch
 Others:
 - rebased on tip/sched/core

Changes in v2:
 - rebased on v4.18-rc4
 - move at the head of the series

As discussed at OSPM, using a [0..SCHED_CAPACITY_SCALE] range seems to
be acceptable. However, an additional patch has been added at the end of
the series which introduces a simple abstraction to use a more
generic [0..100] range.

At OSPM we also discarded the idea to "recycle" the usage of
sched_runtime and sched_period which would have made the API too
much complex for limited benefits.
---
 include/linux/sched.h            | 13 +++++++
 include/uapi/linux/sched.h       |  4 +-
 include/uapi/linux/sched/types.h | 64 +++++++++++++++++++++++++++-----
 init/Kconfig                     | 19 ++++++++++
 kernel/sched/core.c              | 39 +++++++++++++++++++
 5 files changed, 129 insertions(+), 10 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index e0f4f56c9310..42f6439378e1 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -279,6 +279,14 @@ struct vtime {
 	u64			gtime;
 };
 
+enum uclamp_id {
+	UCLAMP_MIN = 0, /* Minimum utilization */
+	UCLAMP_MAX,     /* Maximum utilization */
+
+	/* Utilization clamping constraints count */
+	UCLAMP_CNT
+};
+
 struct sched_info {
 #ifdef CONFIG_SCHED_INFO
 	/* Cumulative counters: */
@@ -649,6 +657,11 @@ struct task_struct {
 #endif
 	struct sched_dl_entity		dl;
 
+#ifdef CONFIG_UCLAMP_TASK
+	/* Utlization clamp values for this task */
+	int				uclamp[UCLAMP_CNT];
+#endif
+
 #ifdef CONFIG_PREEMPT_NOTIFIERS
 	/* List of struct preempt_notifier: */
 	struct hlist_head		preempt_notifiers;
diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 22627f80063e..c27d6e81517b 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -50,9 +50,11 @@
 #define SCHED_FLAG_RESET_ON_FORK	0x01
 #define SCHED_FLAG_RECLAIM		0x02
 #define SCHED_FLAG_DL_OVERRUN		0x04
+#define SCHED_FLAG_UTIL_CLAMP		0x08
 
 #define SCHED_FLAG_ALL	(SCHED_FLAG_RESET_ON_FORK	| \
 			 SCHED_FLAG_RECLAIM		| \
-			 SCHED_FLAG_DL_OVERRUN)
+			 SCHED_FLAG_DL_OVERRUN		| \
+			 SCHED_FLAG_UTIL_CLAMP)
 
 #endif /* _UAPI_LINUX_SCHED_H */
diff --git a/include/uapi/linux/sched/types.h b/include/uapi/linux/sched/types.h
index 10fbb8031930..7421cd25354d 100644
--- a/include/uapi/linux/sched/types.h
+++ b/include/uapi/linux/sched/types.h
@@ -21,8 +21,33 @@ struct sched_param {
  * the tasks may be useful for a wide variety of application fields, e.g.,
  * multimedia, streaming, automation and control, and many others.
  *
- * This variant (sched_attr) is meant at describing a so-called
- * sporadic time-constrained task. In such model a task is specified by:
+ * This variant (sched_attr) allows to define additional attributes to
+ * improve the scheduler knowledge about task requirements.
+ *
+ * Scheduling Class Attributes
+ * ===========================
+ *
+ * A subset of sched_attr attributes specifies the
+ * scheduling policy and relative POSIX attributes:
+ *
+ *  @size		size of the structure, for fwd/bwd compat.
+ *
+ *  @sched_policy	task's scheduling policy
+ *  @sched_nice		task's nice value      (SCHED_NORMAL/BATCH)
+ *  @sched_priority	task's static priority (SCHED_FIFO/RR)
+ *
+ * Certain more advanced scheduling features can be controlled by a
+ * predefined set of flags via the attribute:
+ *
+ *  @sched_flags	for customizing the scheduler behaviour
+ *
+ * Sporadic Time-Constrained Tasks Attributes
+ * ==========================================
+ *
+ * A subset of sched_attr attributes allows to describe a so-called
+ * sporadic time-constrained task.
+ *
+ * In such model a task is specified by:
  *  - the activation period or minimum instance inter-arrival time;
  *  - the maximum (or average, depending on the actual scheduling
  *    discipline) computation time of all instances, a.k.a. runtime;
@@ -34,14 +59,8 @@ struct sched_param {
  * than the runtime and must be completed by time instant t equal to
  * the instance activation time + the deadline.
  *
- * This is reflected by the actual fields of the sched_attr structure:
+ * This is reflected by the following fields of the sched_attr structure:
  *
- *  @size		size of the structure, for fwd/bwd compat.
- *
- *  @sched_policy	task's scheduling policy
- *  @sched_flags	for customizing the scheduler behaviour
- *  @sched_nice		task's nice value      (SCHED_NORMAL/BATCH)
- *  @sched_priority	task's static priority (SCHED_FIFO/RR)
  *  @sched_deadline	representative of the task's deadline
  *  @sched_runtime	representative of the task's runtime
  *  @sched_period	representative of the task's period
@@ -53,6 +72,28 @@ struct sched_param {
  * As of now, the SCHED_DEADLINE policy (sched_dl scheduling class) is the
  * only user of this new interface. More information about the algorithm
  * available in the scheduling class file or in Documentation/.
+ *
+ * Task Utilization Attributes
+ * ===========================
+ *
+ * A subset of sched_attr attributes allows to specify the utilization which
+ * should be expected by a task. These attributes allows to inform the
+ * scheduler about the utilization boundaries within which is safe to schedule
+ * the task. These utilization boundaries are valuable information to support
+ * scheduler decisions on both task placement and frequencies selection.
+ *
+ *  @sched_util_min	represents the minimum utilization
+ *  @sched_util_max	represents the maximum utilization
+ *
+ * Utilization is a value in the range [0..SCHED_CAPACITY_SCALE] which
+ * represents the percentage of CPU time used by a task when running at the
+ * maximum frequency on the highest capacity CPU of the system. Thus, for
+ * example, a 20% utilization task is a task running for 2ms every 10ms.
+ *
+ * A task with a min utilization value bigger then 0 is more likely to be
+ * scheduled on a CPU which can provide that bandwidth.
+ * A task with a max utilization value smaller then 1024 is more likely to be
+ * scheduled on a CPU which do not provide more then the required bandwidth.
  */
 struct sched_attr {
 	__u32 size;
@@ -70,6 +111,11 @@ struct sched_attr {
 	__u64 sched_runtime;
 	__u64 sched_deadline;
 	__u64 sched_period;
+
+	/* Utilization hints */
+	__u32 sched_util_min;
+	__u32 sched_util_max;
+
 };
 
 #endif /* _UAPI_LINUX_SCHED_TYPES_H */
diff --git a/init/Kconfig b/init/Kconfig
index 041f3a022122..1d45a6877d6f 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -583,6 +583,25 @@ config HAVE_UNSTABLE_SCHED_CLOCK
 config GENERIC_SCHED_CLOCK
 	bool
 
+menu "Scheduler features"
+
+config UCLAMP_TASK
+	bool "Enable utilization clamping for RT/FAIR tasks"
+	depends on CPU_FREQ_GOV_SCHEDUTIL
+	default false
+	help
+	  This feature enables the scheduler to track the clamped utilization
+	  of each CPU based on RUNNABLE tasks currently scheduled on that CPU.
+
+	  When this option is enabled, the user can specify a min and max CPU
+          bandwidth which is allowed for a task.
+	  The max bandwidth allows to clamp the maximum frequency a task can
+	  use, while the min bandwidth allows to define a minimum frequency a
+          task will always use.
+
+	  If in doubt, say N.
+
+endmenu
 #
 # For architectures that want to enable the support for NUMA-affine scheduler
 # balancing logic:
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index deafa9fe602b..2cabbbcaa447 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -716,6 +716,28 @@ static void set_load_weight(struct task_struct *p, bool update_load)
 	}
 }
 
+#ifdef CONFIG_UCLAMP_TASK
+static inline int __setscheduler_uclamp(struct task_struct *p,
+					const struct sched_attr *attr)
+{
+	if (attr->sched_util_min > attr->sched_util_max)
+		return -EINVAL;
+	if (attr->sched_util_max > SCHED_CAPACITY_SCALE)
+		return -EINVAL;
+
+	p->uclamp[UCLAMP_MIN] = attr->sched_util_min;
+	p->uclamp[UCLAMP_MAX] = attr->sched_util_max;
+
+	return 0;
+}
+#else /* CONFIG_UCLAMP_TASK */
+static inline int __setscheduler_uclamp(struct task_struct *p,
+					const struct sched_attr *attr)
+{
+	return -EINVAL;
+}
+#endif /* CONFIG_UCLAMP_TASK */
+
 static inline void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 {
 	if (!(flags & ENQUEUE_NOCLOCK))
@@ -2156,6 +2178,11 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	p->se.cfs_rq			= NULL;
 #endif
 
+#ifdef CONFIG_UCLAMP_TASK
+	p->uclamp[UCLAMP_MIN] = 0;
+	p->uclamp[UCLAMP_MAX] = SCHED_CAPACITY_SCALE;
+#endif
+
 #ifdef CONFIG_SCHEDSTATS
 	/* Even if schedstat is disabled, there should not be garbage */
 	memset(&p->se.statistics, 0, sizeof(p->se.statistics));
@@ -4218,6 +4245,13 @@ static int __sched_setscheduler(struct task_struct *p,
 			return retval;
 	}
 
+	/* Configure utilization clamps for the task */
+	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP) {
+		retval = __setscheduler_uclamp(p, attr);
+		if (retval)
+			return retval;
+	}
+
 	/*
 	 * Make sure no PI-waiters arrive (or leave) while we are
 	 * changing the priority of the task:
@@ -4724,6 +4758,11 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
 	else
 		attr.sched_nice = task_nice(p);
 
+#ifdef CONFIG_UCLAMP_TASK
+	attr.sched_util_min = p->uclamp[UCLAMP_MIN];
+	attr.sched_util_max = p->uclamp[UCLAMP_MAX];
+#endif
+
 	rcu_read_unlock();
 
 	retval = sched_read_attr(uattr, &attr, size);
-- 
2.18.0

