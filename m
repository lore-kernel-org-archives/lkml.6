Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F04EC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 271F621A72
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:41:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 271F621A72
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387786AbeHFSvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 14:51:00 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41932 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387750AbeHFSvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 14:51:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70D6B15B2;
        Mon,  6 Aug 2018 09:41:06 -0700 (PDT)
Received: from e110439-lin.Cambridge.Arm.com (e110439-lin.emea.arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A3D1D3F5D0;
        Mon,  6 Aug 2018 09:41:03 -0700 (PDT)
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
Subject: [PATCH v3 12/14] sched/core: uclamp: add system default clamps
Date:   Mon,  6 Aug 2018 17:39:44 +0100
Message-Id: <20180806163946.28380-13-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180806163946.28380-1-patrick.bellasi@arm.com>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clamp values cannot be tuned at the root cgroup level. Moreover, because
of the delegation model requirements and how the parent clamps
propagation works, if we want to enable subgroups to set a non null
util.min, we need to be able to configure the root group util.min to the
allow the maximum utilization (SCHED_CAPACITY_SCALE = 1024).

Unfortunately this setup will also mean that all tasks running in the
root group, will always get a maximum util.min clamp, unless they have a
lower task specific clamp which is definitively not a desirable default
configuration.

Let's fix this by explicitly adding a system default configuration
(sysctl_sched_uclamp_util_{min,max}) which works as a restrictive clamp
for all tasks running on the root group.

This interface is available independently from cgroups, thus providing a
complete solution for system wide utilization clamping configuration.

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
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
---
 include/linux/sched/sysctl.h |  11 ++++
 kernel/sched/core.c          | 102 +++++++++++++++++++++++++++++++++--
 kernel/sysctl.c              |  16 ++++++
 3 files changed, 126 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 913488d828cb..c46346d3cc69 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -55,6 +55,11 @@ int sched_proc_update_handler(struct ctl_table *table, int write,
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
@@ -74,6 +79,12 @@ extern int sched_rt_handler(struct ctl_table *table, int write,
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
index f54fd9bda9a7..48458fea2d5e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -728,6 +728,20 @@ static void set_load_weight(struct task_struct *p, bool update_load)
  */
 static DEFINE_MUTEX(uclamp_mutex);
 
+/*
+ * Minimum utilization for tasks in the root cgroup
+ * default: 0
+ */
+unsigned int sysctl_sched_uclamp_util_min;
+
+/*
+ * Maximum utilization for tasks in the root cgroup
+ * default: 1024
+ */
+unsigned int sysctl_sched_uclamp_util_max = 1024;
+
+static struct uclamp_se uclamp_default[UCLAMP_CNT];
+
 /**
  * uclamp_map: reference counts a utilization "clamp value"
  * @value:    the utilization "clamp value" required
@@ -957,12 +971,25 @@ static inline int uclamp_task_group_id(struct task_struct *p, int clamp_id)
 	group_id = uc_se->group_id;
 
 #ifdef CONFIG_UCLAMP_TASK_GROUP
+	/*
+	 * Tasks in the root group, which do not have a task specific clamp
+	 * value, get the system default calmp value.
+	 */
+	if (group_id == UCLAMP_NOT_VALID &&
+	    task_group(p) == &root_task_group) {
+		return uclamp_default[clamp_id].group_id;
+	}
+
 	/* Use TG's clamp value to limit task specific values */
 	uc_se = &task_group(p)->uclamp[clamp_id];
 	if (group_id == UCLAMP_NOT_VALID ||
 	    clamp_value > uc_se->effective.value) {
 		group_id = uc_se->effective.group_id;
 	}
+#else
+	/* By default, all tasks get the system default clamp value */
+	if (group_id == UCLAMP_NOT_VALID)
+		return uclamp_default[clamp_id].group_id;
 #endif
 
 	return group_id;
@@ -1269,6 +1296,75 @@ static inline void uclamp_group_get(struct task_struct *p,
 	uclamp_group_put(clamp_id, prev_group_id);
 }
 
+int sched_uclamp_handler(struct ctl_table *table, int write,
+			 void __user *buffer, size_t *lenp,
+			 loff_t *ppos)
+{
+	int group_id[UCLAMP_CNT] = { UCLAMP_NOT_VALID };
+	struct uclamp_se *uc_se;
+	int old_min, old_max;
+	int result;
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
+	if (sysctl_sched_uclamp_util_min > sysctl_sched_uclamp_util_max)
+		goto undo;
+	if (sysctl_sched_uclamp_util_max > 1024)
+		goto undo;
+
+	/* Find a valid group_id for each required clamp value */
+	if (old_min != sysctl_sched_uclamp_util_min) {
+		result = uclamp_group_find(UCLAMP_MIN, sysctl_sched_uclamp_util_min);
+		if (result == -ENOSPC) {
+			pr_err("Cannot allocate more than %d UTIL_MIN clamp groups\n",
+			       CONFIG_UCLAMP_GROUPS_COUNT);
+			goto undo;
+		}
+		group_id[UCLAMP_MIN] = result;
+	}
+	if (old_max != sysctl_sched_uclamp_util_max) {
+		result = uclamp_group_find(UCLAMP_MAX, sysctl_sched_uclamp_util_max);
+		if (result == -ENOSPC) {
+			pr_err("Cannot allocate more than %d UTIL_MAX clamp groups\n",
+			       CONFIG_UCLAMP_GROUPS_COUNT);
+			goto undo;
+		}
+		group_id[UCLAMP_MAX] = result;
+	}
+
+	/* Update each required clamp group */
+	if (old_min != sysctl_sched_uclamp_util_min) {
+		uc_se = &uclamp_default[UCLAMP_MIN];
+		uclamp_group_get(NULL, UCLAMP_MIN, group_id[UCLAMP_MIN],
+				 uc_se, sysctl_sched_uclamp_util_min);
+	}
+	if (old_max != sysctl_sched_uclamp_util_max) {
+		uc_se = &uclamp_default[UCLAMP_MAX];
+		uclamp_group_get(NULL, UCLAMP_MAX, group_id[UCLAMP_MAX],
+				 uc_se, sysctl_sched_uclamp_util_max);
+	}
+
+	if (result) {
+undo:
+		sysctl_sched_uclamp_util_min = old_min;
+		sysctl_sched_uclamp_util_max = old_max;
+	}
+
+done:
+	mutex_unlock(&uclamp_mutex);
+
+	return result;
+}
+
 #ifdef CONFIG_UCLAMP_TASK_GROUP
 /**
  * init_uclamp_sched_group: initialize data structures required for TG's
@@ -1291,11 +1387,11 @@ static inline void init_uclamp_sched_group(void)
 		/* Map root TG's clamp value */
 		uclamp_group_init(clamp_id, group_id, uclamp_none(clamp_id));
 
-		/* Init root TG's clamp group */
+		/* Init root TG's clamp group: max values always enabled */
 		uc_se = &root_task_group.uclamp[clamp_id];
-		uc_se->value = uclamp_none(clamp_id);
+		uc_se->value = uclamp_none(UCLAMP_MAX);
 		uc_se->group_id = group_id;
-		uc_se->effective.value = uclamp_none(clamp_id);
+		uc_se->effective.value = uclamp_none(UCLAMP_MAX);
 		uc_se->effective.group_id = group_id;
 
 		/* Attach root TG's clamp group */
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index f22f76b7a138..051d6da237e0 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -442,6 +442,22 @@ static struct ctl_table kern_table[] = {
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

