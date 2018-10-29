Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C24C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A389F2080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:34:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A389F2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729565AbeJ3DXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 23:23:49 -0400
Received: from foss.arm.com ([217.140.101.70]:44652 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729275AbeJ3DXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 23:23:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1929E341;
        Mon, 29 Oct 2018 11:33:58 -0700 (PDT)
Received: from e110439-lin.cambridge.arm.com (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 27DE13F6A8;
        Mon, 29 Oct 2018 11:33:55 -0700 (PDT)
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH v5 08/15] sched/core: uclamp: add system default clamps
Date:   Mon, 29 Oct 2018 18:33:03 +0000
Message-Id: <20181029183311.29175-10-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181029183311.29175-1-patrick.bellasi@arm.com>
References: <20181029183311.29175-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tasks without a user-defined clamp value are considered not clamped
and by default their utilization can be any value in the
[0..SCHED_CAPACITY_SCALE] range. Tasks with a user-defined clamp value
are allowed to request any value in that range, and we currently
unconditionally enforce the required clamps.
However, a "System Management Software" could be interested in
unconditionally limiting the range of clamp values allowed for all
tasks.

Let's fix this by explicitly adding a privileged interface to define a
system default configuration via:

  /proc/sys/kernel/sched_uclamp_util_{min,max}

which works as an unconditional clamp range restriction for all tasks.

If a task specific value is not compliant with the system default range,
it will be forced to the corresponding system default value.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Paul Turner <pjt@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Steve Muckle <smuckle@google.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Quentin Perret <quentin.perret@arm.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org

---
The current restriction could be too aggressive since, for example if a
task has a util_min which is higher then the system default max, it
will be forced to the system default min unconditionally.

We should probably better restrict util_min to the maximum system
default value, but that whould make the code more complex and we keep it
for a future update.

Changes in v5:
 Other:
 - rebased on v4.19

Changes in v4:
 Message-ID: <20180820122728.GM2960@e110439-lin>
 - fix unwanted reset of clamp values on refcount success
 Others:
 - by default all tasks have a UCLAMP_NOT_VALID task specific clamp
 - always use:
      p->uclamp[clamp_id].effective.value
   to track the actual clamp value the task has been refcounted into.
   This matches with the usage of
      p->uclamp[clamp_id].effective.group_id
 - rebased on v4.19-rc1
---
 include/linux/sched.h        |   5 ++
 include/linux/sched/sysctl.h |  11 +++
 kernel/sched/core.c          | 131 ++++++++++++++++++++++++++++++++---
 kernel/sysctl.c              |  16 +++++
 4 files changed, 154 insertions(+), 9 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 3ab1cbd4e3b1..ec6783ea4e7d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -614,6 +614,11 @@ struct uclamp_se {
 	unsigned int group_id		: order_base_2(UCLAMP_GROUPS);
 	unsigned int mapped		: 1;
 	unsigned int active		: 1;
+	/* Clamp group and value actually used by a RUNNABLE task */
+	struct {
+		unsigned int value	: SCHED_CAPACITY_SHIFT + 1;
+		unsigned int group_id	: order_base_2(UCLAMP_GROUPS);
+	} effective;
 };
 #endif /* CONFIG_UCLAMP_TASK */
 
diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index a9c32daeb9d8..445fb54eaeff 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -56,6 +56,11 @@ int sched_proc_update_handler(struct ctl_table *table, int write,
 extern unsigned int sysctl_sched_rt_period;
 extern int sysctl_sched_rt_runtime;
 
+#ifdef CONFIG_UCLAMP_TASK
+extern unsigned int sysctl_sched_uclamp_util_min;
+extern unsigned int sysctl_sched_uclamp_util_max;
+#endif
+
 #ifdef CONFIG_CFS_BANDWIDTH
 extern unsigned int sysctl_sched_cfs_bandwidth_slice;
 #endif
@@ -75,6 +80,12 @@ extern int sched_rt_handler(struct ctl_table *table, int write,
 		void __user *buffer, size_t *lenp,
 		loff_t *ppos);
 
+#ifdef CONFIG_UCLAMP_TASK
+extern int sched_uclamp_handler(struct ctl_table *table, int write,
+				void __user *buffer, size_t *lenp,
+				loff_t *ppos);
+#endif
+
 extern int sysctl_numa_balancing(struct ctl_table *table, int write,
 				 void __user *buffer, size_t *lenp,
 				 loff_t *ppos);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9b49062439f3..8421ef96ec97 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -729,6 +729,23 @@ static void set_load_weight(struct task_struct *p, bool update_load)
  */
 static DEFINE_MUTEX(uclamp_mutex);
 
+/*
+ * Minimum utilization for all tasks
+ * default: 0
+ */
+unsigned int sysctl_sched_uclamp_util_min;
+
+/*
+ * Maximum utilization for all tasks
+ * default: 1024
+ */
+unsigned int sysctl_sched_uclamp_util_max = SCHED_CAPACITY_SCALE;
+
+/*
+ * Tasks's clamp values are required to be within this range
+ */
+static struct uclamp_se uclamp_default[UCLAMP_CNT];
+
 /**
  * uclamp_map: reference count utilization clamp groups
  * @value:    the utilization "clamp value" tracked by this clamp group
@@ -857,6 +874,55 @@ static inline void uclamp_cpu_update(struct rq *rq, unsigned int clamp_id,
 	rq->uclamp.value[clamp_id] = max_value;
 }
 
+/**
+ * uclamp_effective_group_id: get the effective clamp group index of a task
+ * @p: the task to get the effective clamp value for
+ * @clamp_id: the clamp index to consider
+ *
+ * The effective clamp group index of a task depends on:
+ * - the task specific clamp value, explicitly requested from userspace
+ * - the system default clamp value, defined by the sysadmin
+ * and tasks specific's clamp values are always restricted by system
+ * defaults clamp values.
+ *
+ * This method returns the effective group index for a task, depending on its
+ * status and a proper aggregation of the clamp values listed above.
+ * Moreover, it ensures that the task's effective value:
+ *    task_struct::uclamp::effective::value
+ * is updated to represent the clamp value corresponding to the taks effective
+ * group index.
+ */
+static inline unsigned int uclamp_effective_group_id(struct task_struct *p,
+						     unsigned int clamp_id)
+{
+	unsigned int clamp_value;
+	unsigned int group_id;
+
+	/* Task currently refcounted into a CPU clamp group */
+	if (p->uclamp[clamp_id].active)
+		return p->uclamp[clamp_id].effective.group_id;
+
+	/* Task specific clamp value */
+	clamp_value = p->uclamp[clamp_id].value;
+	group_id = p->uclamp[clamp_id].group_id;
+
+	/* System default restriction */
+	if (unlikely(clamp_value < uclamp_default[UCLAMP_MIN].value ||
+		     clamp_value > uclamp_default[UCLAMP_MAX].value)) {
+		/*
+		 * Unconditionally enforce system defaults, which is a simpler
+		 * solution compared to a proper clamping.
+		 */
+		clamp_value = uclamp_default[clamp_id].value;
+		group_id = uclamp_default[clamp_id].group_id;
+	}
+
+	p->uclamp[clamp_id].effective.value = clamp_value;
+	p->uclamp[clamp_id].effective.group_id = group_id;
+
+	return group_id;
+}
+
 /**
  * uclamp_cpu_get_id(): increase reference count for a clamp group on a CPU
  * @p: the task being enqueued on a CPU
@@ -869,16 +935,17 @@ static inline void uclamp_cpu_update(struct rq *rq, unsigned int clamp_id,
 static inline void uclamp_cpu_get_id(struct task_struct *p, struct rq *rq,
 				     unsigned int clamp_id)
 {
-	unsigned int clamp_value;
+	unsigned int effective;
 	unsigned int group_id;
 
 	if (unlikely(!p->uclamp[clamp_id].mapped))
 		return;
 
-	group_id = p->uclamp[clamp_id].group_id;
+	group_id = uclamp_effective_group_id(p, clamp_id);
 	p->uclamp[clamp_id].active = true;
 
 	rq->uclamp.group[clamp_id][group_id].tasks += 1;
+	effective = p->uclamp[clamp_id].effective.value;
 
 	if (unlikely(rq->uclamp.flags & UCLAMP_FLAG_IDLE)) {
 		/*
@@ -889,16 +956,15 @@ static inline void uclamp_cpu_get_id(struct task_struct *p, struct rq *rq,
 		 */
 		if (clamp_id == UCLAMP_MAX)
 			rq->uclamp.flags &= ~UCLAMP_FLAG_IDLE;
-		rq->uclamp.value[clamp_id] = p->uclamp[clamp_id].value;
+		rq->uclamp.value[clamp_id] = effective;
 	}
 
 	/* CPU's clamp groups track the max effective clamp value */
-	clamp_value = p->uclamp[clamp_id].value;
-	if (clamp_value > rq->uclamp.group[clamp_id][group_id].value)
-		rq->uclamp.group[clamp_id][group_id].value = clamp_value;
+	if (effective > rq->uclamp.group[clamp_id][group_id].value)
+		rq->uclamp.group[clamp_id][group_id].value = effective;
 
-	if (rq->uclamp.value[clamp_id] < p->uclamp[clamp_id].value)
-		rq->uclamp.value[clamp_id] = p->uclamp[clamp_id].value;
+	if (rq->uclamp.value[clamp_id] < effective)
+		rq->uclamp.value[clamp_id] = effective;
 }
 
 /**
@@ -922,7 +988,7 @@ static inline void uclamp_cpu_put_id(struct task_struct *p, struct rq *rq,
 	if (unlikely(!p->uclamp[clamp_id].mapped))
 		return;
 
-	group_id = p->uclamp[clamp_id].group_id;
+	group_id = uclamp_effective_group_id(p, clamp_id);
 	p->uclamp[clamp_id].active = false;
 
 	if (likely(rq->uclamp.group[clamp_id][group_id].tasks))
@@ -1172,6 +1238,50 @@ static void uclamp_group_get(struct task_struct *p, struct uclamp_se *uc_se,
 	uc_se->mapped = true;
 }
 
+int sched_uclamp_handler(struct ctl_table *table, int write,
+			 void __user *buffer, size_t *lenp,
+			 loff_t *ppos)
+{
+	int old_min, old_max;
+	int result = 0;
+
+	mutex_lock(&uclamp_mutex);
+
+	old_min = sysctl_sched_uclamp_util_min;
+	old_max = sysctl_sched_uclamp_util_max;
+
+	result = proc_dointvec(table, write, buffer, lenp, ppos);
+	if (result)
+		goto undo;
+	if (!write)
+		goto done;
+
+	if (sysctl_sched_uclamp_util_min > sysctl_sched_uclamp_util_max ||
+	    sysctl_sched_uclamp_util_max > SCHED_CAPACITY_SCALE) {
+		result = -EINVAL;
+		goto undo;
+	}
+
+	if (old_min != sysctl_sched_uclamp_util_min) {
+		uclamp_group_get(NULL, &uclamp_default[UCLAMP_MIN],
+				 UCLAMP_MIN, sysctl_sched_uclamp_util_min);
+	}
+	if (old_max != sysctl_sched_uclamp_util_max) {
+		uclamp_group_get(NULL, &uclamp_default[UCLAMP_MAX],
+				 UCLAMP_MAX, sysctl_sched_uclamp_util_max);
+	}
+	goto done;
+
+undo:
+	sysctl_sched_uclamp_util_min = old_min;
+	sysctl_sched_uclamp_util_max = old_max;
+
+done:
+	mutex_unlock(&uclamp_mutex);
+
+	return result;
+}
+
 static int __setscheduler_uclamp(struct task_struct *p,
 				 const struct sched_attr *attr)
 {
@@ -1268,6 +1378,9 @@ static void __init init_uclamp(void)
 	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
 		uc_se = &init_task.uclamp[clamp_id];
 		uclamp_group_get(NULL, uc_se, clamp_id, uclamp_none(clamp_id));
+
+		uc_se = &uclamp_default[clamp_id];
+		uclamp_group_get(NULL, uc_se, clamp_id, uclamp_none(clamp_id));
 	}
 }
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index cc02050fd0c4..378ea57e5fc5 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -445,6 +445,22 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= sched_rr_handler,
 	},
+#ifdef CONFIG_UCLAMP_TASK
+	{
+		.procname	= "sched_uclamp_util_min",
+		.data		= &sysctl_sched_uclamp_util_min,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= sched_uclamp_handler,
+	},
+	{
+		.procname	= "sched_uclamp_util_max",
+		.data		= &sysctl_sched_uclamp_util_max,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= sched_uclamp_handler,
+	},
+#endif
 #ifdef CONFIG_SCHED_AUTOGROUP
 	{
 		.procname	= "sched_autogroup_enabled",
-- 
2.18.0

