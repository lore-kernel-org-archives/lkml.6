Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46724C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAA402087C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:55:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAA402087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbeH1RrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 13:47:05 -0400
Received: from foss.arm.com ([217.140.101.70]:38671 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727463AbeH1Rq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 13:46:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38B171BB0;
        Tue, 28 Aug 2018 06:54:40 -0700 (PDT)
Received: from e110439-lin.Cambridge.arm.com (e110439-lin.emea.arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 479003F5BD;
        Tue, 28 Aug 2018 06:54:37 -0700 (PDT)
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH v4 13/16] sched/core: uclamp: use percentage clamp values
Date:   Tue, 28 Aug 2018 14:53:21 +0100
Message-Id: <20180828135324.21976-14-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180828135324.21976-1-patrick.bellasi@arm.com>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The utilization is a well defined property of tasks and CPUs with an
in-kernel representation based on power-of-two values.
The current representation, in the [0..SCHED_CAPACITY_SCALE] range,
allows efficient computations in hot-paths and a sufficient fixed point
arithmetic precision.
However, the utilization values range is still an implementation detail
which is also possibly subject to changes in the future.

Since we don't want to commit new user-space APIs to any in-kernel
implementation detail, let's add an abstraction layer on top of the APIs
used by util_clamp, i.e. sched_{set,get}attr syscalls and the cgroup's
cpu.util_{min,max} attributes.

We do that by adding a couple of conversion functions which can be used
to conveniently transform utilization/capacity values from/to the internal
SCHED_FIXEDPOINT_SCALE representation to/from a more generic percentage
in the standard [0..100] range.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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
Changes in v4:
 Others:
 - rebased on v4.19-rc1

Changes in v3:
 - rebased on tip/sched/core
Changes in v2:
- none: this is a new patch
---
 Documentation/admin-guide/cgroup-v2.rst | 10 +++----
 include/linux/sched.h                   | 20 +++++++++++++
 include/uapi/linux/sched/types.h        | 14 +++++----
 kernel/sched/core.c                     | 38 ++++++++++++++-----------
 4 files changed, 55 insertions(+), 27 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 72272f58d304..4b236390273b 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -976,7 +976,7 @@ All time durations are in microseconds.
         A read-write single value file which exists on non-root cgroups.
         The default is "0", i.e. no bandwidth boosting.
 
-        The requested minimum utilization in the range [0, 1023].
+        The requested minimum percentage of utilization in the range [0, 100].
 
         This interface allows reading and setting minimum utilization clamp
         values similar to the sched_setattr(2). This minimum utilization
@@ -987,16 +987,16 @@ All time durations are in microseconds.
         reports minimum utilization clamp value currently enforced on a task
         group.
 
-        The actual minimum utilization in the range [0, 1023].
+        The actual minimum percentage of utilization in the range [0, 100].
 
         This value can be lower then cpu.util.min in case a parent cgroup
         is enforcing a more restrictive clamping on minimum utilization.
 
   cpu.util.max
         A read-write single value file which exists on non-root cgroups.
-        The default is "1023". i.e. no bandwidth clamping
+        The default is "100". i.e. no bandwidth clamping
 
-        The requested maximum utilization in the range [0, 1023].
+        The requested maximum percentage of utilization in the range [0, 100].
 
         This interface allows reading and setting maximum utilization clamp
         values similar to the sched_setattr(2). This maximum utilization
@@ -1007,7 +1007,7 @@ All time durations are in microseconds.
         reports maximum utilization clamp value currently enforced on a task
         group.
 
-        The actual maximum utilization in the range [0, 1023].
+        The actual maximum percentage of utilization in the range [0, 100].
 
         This value can be lower then cpu.util.max in case a parent cgroup
         is enforcing a more restrictive clamping on max utilization.
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4e5522ed57e0..ca0a80881fa9 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -321,6 +321,26 @@ struct sched_info {
 # define SCHED_FIXEDPOINT_SHIFT		10
 # define SCHED_FIXEDPOINT_SCALE		(1L << SCHED_FIXEDPOINT_SHIFT)
 
+static inline unsigned int util_from_pct(unsigned int pct)
+{
+	WARN_ON(pct > 100);
+
+	return ((SCHED_FIXEDPOINT_SCALE * pct) / 100);
+}
+
+static inline unsigned int util_to_pct(unsigned int value)
+{
+	unsigned int rounding = 0;
+
+	WARN_ON(value > SCHED_FIXEDPOINT_SCALE);
+
+	/* Compensate rounding errors for: 0, 256, 512, 768, 1024 */
+	if (likely((value & 0xFF) && ~(value & 0x700)))
+		rounding = 1;
+
+	return (rounding + ((100 * value) / SCHED_FIXEDPOINT_SCALE));
+}
+
 struct load_weight {
 	unsigned long			weight;
 	u32				inv_weight;
diff --git a/include/uapi/linux/sched/types.h b/include/uapi/linux/sched/types.h
index 7512b5934013..b0fe00939fb3 100644
--- a/include/uapi/linux/sched/types.h
+++ b/include/uapi/linux/sched/types.h
@@ -84,16 +84,18 @@ struct sched_param {
  *
  *  @sched_util_min	represents the minimum utilization
  *  @sched_util_max	represents the maximum utilization
+ *  @sched_util_min	represents the minimum utilization percentage
+ *  @sched_util_max	represents the maximum utilization percentage
  *
- * Utilization is a value in the range [0..SCHED_CAPACITY_SCALE] which
- * represents the percentage of CPU time used by a task when running at the
- * maximum frequency on the highest capacity CPU of the system. Thus, for
- * example, a 20% utilization task is a task running for 2ms every 10ms.
+ * Utilization is a value in the range [0..100] which represents the
+ * percentage of CPU time used by a task when running at the maximum frequency
+ * on the highest capacity CPU of the system. Thus, for example, a 20%
+ * utilization task is a task running for 2ms every 10ms.
  *
- * A task with a min utilization value bigger then 0 is more likely to be
+ * A task with a min utilization value bigger then 0% is more likely to be
  * scheduled on a CPU which has a capacity big enough to fit the specified
  * minimum utilization value.
- * A task with a max utilization value smaller then 1024 is more likely to be
+ * A task with a max utilization value smaller then 100% is more likely to be
  * scheduled on a CPU which do not necessarily have more capacity then the
  * specified max utilization value.
  */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9ca881d1ff9e..222397edb8a7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -730,15 +730,15 @@ static DEFINE_MUTEX(uclamp_mutex);
 
 /*
  * Minimum utilization for tasks in the root cgroup
- * default: 0
+ * default: 0%
  */
 unsigned int sysctl_sched_uclamp_util_min;
 
 /*
  * Maximum utilization for tasks in the root cgroup
- * default: 1024
+ * default: 100%
  */
-unsigned int sysctl_sched_uclamp_util_max = SCHED_CAPACITY_SCALE;
+unsigned int sysctl_sched_uclamp_util_max = 100;
 
 static struct uclamp_se uclamp_default[UCLAMP_CNT];
 
@@ -940,7 +940,7 @@ static inline void uclamp_cpu_update(struct rq *rq, int clamp_id,
 		max_value = max(max_value, uc_grp[group_id].value);
 
 		/* Stop if we reach the max possible clamp */
-		if (max_value >= SCHED_CAPACITY_SCALE)
+		if (max_value >= 100)
 			break;
 	}
 
@@ -1397,7 +1397,7 @@ int sched_uclamp_handler(struct ctl_table *table, int write,
 	result = -EINVAL;
 	if (sysctl_sched_uclamp_util_min > sysctl_sched_uclamp_util_max)
 		goto undo;
-	if (sysctl_sched_uclamp_util_max > SCHED_CAPACITY_SCALE)
+	if (sysctl_sched_uclamp_util_max > 100)
 		goto undo;
 
 	/* Find a valid group_id for each required clamp value */
@@ -1424,13 +1424,15 @@ int sched_uclamp_handler(struct ctl_table *table, int write,
 	/* Update each required clamp group */
 	if (old_min != sysctl_sched_uclamp_util_min) {
 		uc_se = &uclamp_default[UCLAMP_MIN];
+		value = util_from_pct(sysctl_sched_uclamp_util_min);
 		uclamp_group_get(NULL, NULL, UCLAMP_MIN, group_id[UCLAMP_MIN],
-				 uc_se, sysctl_sched_uclamp_util_min);
+				 uc_se, value);
 	}
 	if (old_max != sysctl_sched_uclamp_util_max) {
 		uc_se = &uclamp_default[UCLAMP_MAX];
+		value = util_from_pct(sysctl_sched_uclamp_util_max);
 		uclamp_group_get(NULL, NULL, UCLAMP_MAX, group_id[UCLAMP_MAX],
-				 uc_se, sysctl_sched_uclamp_util_max);
+				 uc_se, value);
 	}
 	goto done;
 
@@ -1525,7 +1527,7 @@ static inline int __setscheduler_uclamp(struct task_struct *p,
 			: p->uclamp[UCLAMP_MAX].value;
 
 		if (upper_bound == UCLAMP_NOT_VALID)
-			upper_bound = SCHED_CAPACITY_SCALE;
+			upper_bound = 100;
 		if (attr->sched_util_min > upper_bound) {
 			result = -EINVAL;
 			goto done;
@@ -1546,7 +1548,7 @@ static inline int __setscheduler_uclamp(struct task_struct *p,
 		if (lower_bound == UCLAMP_NOT_VALID)
 			lower_bound = 0;
 		if (attr->sched_util_max < lower_bound ||
-		    attr->sched_util_max > SCHED_CAPACITY_SCALE) {
+		    attr->sched_util_max > 100) {
 			result = -EINVAL;
 			goto done;
 		}
@@ -1563,12 +1565,12 @@ static inline int __setscheduler_uclamp(struct task_struct *p,
 	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
 		uc_se = &p->uclamp[UCLAMP_MIN];
 		uclamp_group_get(p, NULL, UCLAMP_MIN, group_id[UCLAMP_MIN],
-				 uc_se, attr->sched_util_min);
+				 uc_se, util_from_pct(attr->sched_util_min));
 	}
 	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
 		uc_se = &p->uclamp[UCLAMP_MAX];
 		uclamp_group_get(p, NULL, UCLAMP_MAX, group_id[UCLAMP_MAX],
-				 uc_se, attr->sched_util_max);
+				 uc_se, util_from_pct(attr->sched_util_max));
 	}
 
 done:
@@ -5727,8 +5729,8 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
 		attr.sched_nice = task_nice(p);
 
 #ifdef CONFIG_UCLAMP_TASK
-	attr.sched_util_min = uclamp_task_value(p, UCLAMP_MIN);
-	attr.sched_util_max = uclamp_task_value(p, UCLAMP_MAX);
+	attr.sched_util_min = util_to_pct(uclamp_task_value(p, UCLAMP_MIN));
+	attr.sched_util_max = util_to_pct(uclamp_task_value(p, UCLAMP_MAX));
 #endif
 
 	rcu_read_unlock();
@@ -7581,8 +7583,10 @@ static int cpu_util_min_write_u64(struct cgroup_subsys_state *css,
 	int ret = -EINVAL;
 	int group_id;
 
-	if (min_value > SCHED_CAPACITY_SCALE)
+	/* Check range and scale to internal representation */
+	if (min_value > 100)
 		return -ERANGE;
+	min_value = util_from_pct(min_value);
 
 	mutex_lock(&uclamp_mutex);
 	rcu_read_lock();
@@ -7626,8 +7630,10 @@ static int cpu_util_max_write_u64(struct cgroup_subsys_state *css,
 	int ret = -EINVAL;
 	int group_id;
 
-	if (max_value > SCHED_CAPACITY_SCALE)
+	/* Check range and scale to internal representation */
+	if (max_value > 100)
 		return -ERANGE;
+	max_value = util_from_pct(max_value);
 
 	mutex_lock(&uclamp_mutex);
 	rcu_read_lock();
@@ -7677,7 +7683,7 @@ static inline u64 cpu_uclamp_read(struct cgroup_subsys_state *css,
 		: tg->uclamp[clamp_id].value;
 	rcu_read_unlock();
 
-	return util_clamp;
+	return util_to_pct(util_clamp);
 }
 
 static u64 cpu_util_min_read_u64(struct cgroup_subsys_state *css,
-- 
2.18.0

