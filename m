Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1CCC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 785542087C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:55:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 785542087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbeH1Rrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 13:47:45 -0400
Received: from foss.arm.com ([217.140.101.70]:38662 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727284AbeH1Rq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 13:46:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D291168F;
        Tue, 28 Aug 2018 06:54:24 -0700 (PDT)
Received: from e110439-lin.Cambridge.arm.com (e110439-lin.emea.arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3BC6E3F5BD;
        Tue, 28 Aug 2018 06:54:21 -0700 (PDT)
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
Subject: [PATCH v4 08/16] sched/core: uclamp: propagate parent clamps
Date:   Tue, 28 Aug 2018 14:53:16 +0100
Message-Id: <20180828135324.21976-9-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180828135324.21976-1-patrick.bellasi@arm.com>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to properly support hierarchical resources control, the cgroup
delegation model requires that attribute writes from a child group never
fail but still are (potentially) constrained based on parent's assigned
resources. This requires to properly propagate and aggregate parent
attributes down to its descendants.

Let's implement this mechanism by adding a new "effective" clamp value
for each task group. The effective clamp value is defined as the smaller
value between the clamp value of a group and the effective clamp value
of its parent. This represent also the clamp value which is actually
used to clamp tasks in each task group.

Since it can be interesting for tasks in a cgroup to know exactly what
is the currently propagated/enforced configuration, the effective clamp
values are exposed to user-space by means of a new pair of read-only
attributes: cpu.util.{min,max}.effective.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Quentin Perret <quentin.perret@arm.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org

---
Changes in v4:
 Message-ID: <20180816140731.GD2960@e110439-lin>
 - add ".effective" attributes to the default hierarchy
 Others:
 - small documentation fixes
 - rebased on v4.19-rc1

Changes in v3:
 Message-ID: <20180409222417.GK3126663@devbig577.frc2.facebook.com>
 - new patch in v3, to implement a suggestion from v1 review
---
 Documentation/admin-guide/cgroup-v2.rst |  25 +++++-
 include/linux/sched.h                   |   8 ++
 kernel/sched/core.c                     | 112 +++++++++++++++++++++++-
 3 files changed, 139 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 80ef7bdc517b..72272f58d304 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -976,22 +976,43 @@ All time durations are in microseconds.
         A read-write single value file which exists on non-root cgroups.
         The default is "0", i.e. no bandwidth boosting.
 
-        The minimum utilization in the range [0, 1023].
+        The requested minimum utilization in the range [0, 1023].
 
         This interface allows reading and setting minimum utilization clamp
         values similar to the sched_setattr(2). This minimum utilization
         value is used to clamp the task specific minimum utilization clamp.
 
+  cpu.util.min.effective
+        A read-only single value file which exists on non-root cgroups and
+        reports minimum utilization clamp value currently enforced on a task
+        group.
+
+        The actual minimum utilization in the range [0, 1023].
+
+        This value can be lower then cpu.util.min in case a parent cgroup
+        is enforcing a more restrictive clamping on minimum utilization.
+
   cpu.util.max
         A read-write single value file which exists on non-root cgroups.
         The default is "1023". i.e. no bandwidth clamping
 
-        The maximum utilization in the range [0, 1023].
+        The requested maximum utilization in the range [0, 1023].
 
         This interface allows reading and setting maximum utilization clamp
         values similar to the sched_setattr(2). This maximum utilization
         value is used to clamp the task specific maximum utilization clamp.
 
+  cpu.util.max.effective
+        A read-only single value file which exists on non-root cgroups and
+        reports maximum utilization clamp value currently enforced on a task
+        group.
+
+        The actual maximum utilization in the range [0, 1023].
+
+        This value can be lower then cpu.util.max in case a parent cgroup
+        is enforcing a more restrictive clamping on max utilization.
+
+
 Memory
 ------
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index dc39b67a366a..2da130d17e70 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -591,6 +591,14 @@ struct sched_dl_entity {
 struct uclamp_se {
 	unsigned int value;
 	unsigned int group_id;
+	/*
+	 * Effective task (group) clamp value.
+	 * For task groups is the value (eventually) enforced by a parent task
+	 * group.
+	 */
+	struct {
+		unsigned int value;
+	} effective;
 };
 
 union rcu_special {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index dcbf22abd0bf..b2d438b6484b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1254,6 +1254,8 @@ static inline int alloc_uclamp_sched_group(struct task_group *tg,
 
 	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
 		uc_se = &tg->uclamp[clamp_id];
+		uc_se->effective.value =
+			parent->uclamp[clamp_id].effective.value;
 		uc_se->value = parent->uclamp[clamp_id].value;
 		uc_se->group_id = parent->uclamp[clamp_id].group_id;
 	}
@@ -1415,6 +1417,7 @@ static void __init init_uclamp(void)
 #ifdef CONFIG_UCLAMP_TASK_GROUP
 		/* Init root TG's clamp group */
 		uc_se = &root_task_group.uclamp[clamp_id];
+		uc_se->effective.value = uclamp_none(clamp_id);
 		uc_se->value = uclamp_none(clamp_id);
 		uc_se->group_id = 0;
 #endif
@@ -7226,6 +7229,68 @@ static void cpu_cgroup_attach(struct cgroup_taskset *tset)
 }
 
 #ifdef CONFIG_UCLAMP_TASK_GROUP
+/**
+ * cpu_util_update_hier: propagete effective clamp down the hierarchy
+ * @css: the task group to update
+ * @clamp_id: the clamp index to update
+ * @value: the new task group clamp value
+ *
+ * The effective clamp for a TG is expected to track the most restrictive
+ * value between the TG's clamp value and it's parent effective clamp value.
+ * This method achieve that:
+ * 1. updating the current TG effective value
+ * 2. walking all the descendant task group that needs an update
+ *
+ * A TG's effective clamp needs to be updated when its current value is not
+ * matching the TG's clamp value. In this case indeed either:
+ * a) the parent has got a more relaxed clamp value
+ *    thus potentially we can relax the effective value for this group
+ * b) the parent has got a more strict clamp value
+ *    thus potentially we have to restrict the effective value of this group
+ *
+ * Restriction and relaxation of current TG's effective clamp values needs to
+ * be propagated down to all the descendants. When a subgroup is found which
+ * has already its effective clamp value matching its clamp value, then we can
+ * safely skip all its descendants which are granted to be already in sync.
+ */
+static void cpu_util_update_hier(struct cgroup_subsys_state *css,
+				 int clamp_id, int value)
+{
+	struct cgroup_subsys_state *top_css = css;
+	struct uclamp_se *uc_se, *uc_parent;
+
+	css_for_each_descendant_pre(css, top_css) {
+		/*
+		 * The first visited task group is top_css, which clamp value
+		 * is the one passed as parameter. For descendent task
+		 * groups we consider their current value.
+		 */
+		uc_se = &css_tg(css)->uclamp[clamp_id];
+		if (css != top_css)
+			value = uc_se->value;
+		/*
+		 * Skip the whole subtrees if the current effective clamp is
+		 * alredy matching the TG's clamp value.
+		 * In this case, all the subtrees already have top_value, or a
+		 * more restrictive, as effective clamp.
+		 */
+		uc_parent = &css_tg(css)->parent->uclamp[clamp_id];
+		if (uc_se->effective.value == value &&
+		    uc_parent->effective.value >= value) {
+			css = css_rightmost_descendant(css);
+			continue;
+		}
+
+		/* Propagate the most restrictive effective value */
+		if (uc_parent->effective.value < value)
+			value = uc_parent->effective.value;
+		if (uc_se->effective.value == value)
+			continue;
+
+		uc_se->effective.value = value;
+	}
+}
+
 static int cpu_util_min_write_u64(struct cgroup_subsys_state *css,
 				  struct cftype *cftype, u64 min_value)
 {
@@ -7245,6 +7310,9 @@ static int cpu_util_min_write_u64(struct cgroup_subsys_state *css,
 	if (tg->uclamp[UCLAMP_MAX].value < min_value)
 		goto out;
 
+	/* Update effective clamps to track the most restrictive value */
+	cpu_util_update_hier(css, UCLAMP_MIN, min_value);
+
 out:
 	rcu_read_unlock();
 
@@ -7270,6 +7338,9 @@ static int cpu_util_max_write_u64(struct cgroup_subsys_state *css,
 	if (tg->uclamp[UCLAMP_MIN].value > max_value)
 		goto out;
 
+	/* Update effective clamps to track the most restrictive value */
+	cpu_util_update_hier(css, UCLAMP_MAX, max_value);
+
 out:
 	rcu_read_unlock();
 
@@ -7277,14 +7348,17 @@ static int cpu_util_max_write_u64(struct cgroup_subsys_state *css,
 }
 
 static inline u64 cpu_uclamp_read(struct cgroup_subsys_state *css,
-				  enum uclamp_id clamp_id)
+				  enum uclamp_id clamp_id,
+				  bool effective)
 {
 	struct task_group *tg;
 	u64 util_clamp;
 
 	rcu_read_lock();
 	tg = css_tg(css);
-	util_clamp = tg->uclamp[clamp_id].value;
+	util_clamp = effective
+		? tg->uclamp[clamp_id].effective.value
+		: tg->uclamp[clamp_id].value;
 	rcu_read_unlock();
 
 	return util_clamp;
@@ -7293,13 +7367,25 @@ static inline u64 cpu_uclamp_read(struct cgroup_subsys_state *css,
 static u64 cpu_util_min_read_u64(struct cgroup_subsys_state *css,
 				 struct cftype *cft)
 {
-	return cpu_uclamp_read(css, UCLAMP_MIN);
+	return cpu_uclamp_read(css, UCLAMP_MIN, false);
 }
 
 static u64 cpu_util_max_read_u64(struct cgroup_subsys_state *css,
 				 struct cftype *cft)
 {
-	return cpu_uclamp_read(css, UCLAMP_MAX);
+	return cpu_uclamp_read(css, UCLAMP_MAX, false);
+}
+
+static u64 cpu_util_min_effective_read_u64(struct cgroup_subsys_state *css,
+					   struct cftype *cft)
+{
+	return cpu_uclamp_read(css, UCLAMP_MIN, true);
+}
+
+static u64 cpu_util_max_effective_read_u64(struct cgroup_subsys_state *css,
+					   struct cftype *cft)
+{
+	return cpu_uclamp_read(css, UCLAMP_MAX, true);
 }
 #endif /* CONFIG_UCLAMP_TASK_GROUP */
 
@@ -7647,11 +7733,19 @@ static struct cftype cpu_legacy_files[] = {
 		.read_u64 = cpu_util_min_read_u64,
 		.write_u64 = cpu_util_min_write_u64,
 	},
+	{
+		.name = "util.min.effective",
+		.read_u64 = cpu_util_min_effective_read_u64,
+	},
 	{
 		.name = "util.max",
 		.read_u64 = cpu_util_max_read_u64,
 		.write_u64 = cpu_util_max_write_u64,
 	},
+	{
+		.name = "util.max.effective",
+		.read_u64 = cpu_util_max_effective_read_u64,
+	},
 #endif
 	{ }	/* Terminate */
 };
@@ -7827,12 +7921,22 @@ static struct cftype cpu_files[] = {
 		.read_u64 = cpu_util_min_read_u64,
 		.write_u64 = cpu_util_min_write_u64,
 	},
+	{
+		.name = "util.min.effective",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.read_u64 = cpu_util_min_effective_read_u64,
+	},
 	{
 		.name = "util_max",
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.read_u64 = cpu_util_max_read_u64,
 		.write_u64 = cpu_util_max_write_u64,
 	},
+	{
+		.name = "util.max.effective",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.read_u64 = cpu_util_max_effective_read_u64,
+	},
 #endif
 	{ }	/* terminate */
 };
-- 
2.18.0

