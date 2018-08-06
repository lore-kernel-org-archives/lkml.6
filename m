Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52B6C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 591E821A67
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:42:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 591E821A67
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732079AbeHFSwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 14:52:37 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41868 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732424AbeHFSuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 14:50:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44AE980D;
        Mon,  6 Aug 2018 09:40:57 -0700 (PDT)
Received: from e110439-lin.Cambridge.Arm.com (e110439-lin.emea.arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 779A03F5D0;
        Mon,  6 Aug 2018 09:40:54 -0700 (PDT)
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
Subject: [PATCH v3 09/14] sched/core: uclamp: propagate parent clamps
Date:   Mon,  6 Aug 2018 17:39:41 +0100
Message-Id: <20180806163946.28380-10-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180806163946.28380-1-patrick.bellasi@arm.com>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
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
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org

---
Changes in v3:
 Message-ID: <20180409222417.GK3126663@devbig577.frc2.facebook.com>
 - new patch in v3, to implement a suggestion from v1 review
---
 Documentation/admin-guide/cgroup-v2.rst | 25 +++++++-
 include/linux/sched.h                   |  5 ++
 kernel/sched/core.c                     | 81 +++++++++++++++++++++++--
 3 files changed, 105 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 71244b55d901..c73ceaf496b2 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -973,22 +973,43 @@ All time durations are in microseconds.
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
index 8f48e64fb8a6..3fac2d098084 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -589,6 +589,11 @@ struct uclamp_se {
 	unsigned int value;
 	/* Utilization clamp group for this constraint */
 	unsigned int group_id;
+	/* Effective clamp  for tasks in this group */
+	struct {
+		unsigned int value;
+		unsigned int group_id;
+	} effective;
 };
 
 union rcu_special {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2ba55a4afffb..f692df3787bd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1237,6 +1237,8 @@ static inline void init_uclamp_sched_group(void)
 		uc_se = &root_task_group.uclamp[clamp_id];
 		uc_se->value = uclamp_none(clamp_id);
 		uc_se->group_id = group_id;
+		uc_se->effective.value = uclamp_none(clamp_id);
+		uc_se->effective.group_id = group_id;
 
 		/* Attach root TG's clamp group */
 		uc_map[group_id].se_count = 1;
@@ -1266,6 +1268,10 @@ static inline int alloc_uclamp_sched_group(struct task_group *tg,
 
 		uc_se->value = parent->uclamp[clamp_id].value;
 		uc_se->group_id = UCLAMP_NOT_VALID;
+		uc_se->effective.value =
+			parent->uclamp[clamp_id].effective.value;
+		uc_se->effective.group_id =
+			parent->uclamp[clamp_id].effective.group_id;
 	}
 
 	return 1;
@@ -7197,6 +7203,44 @@ static void cpu_cgroup_attach(struct cgroup_taskset *tset)
 }
 
 #ifdef CONFIG_UCLAMP_TASK_GROUP
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
@@ -7217,6 +7261,9 @@ static int cpu_util_min_write_u64(struct cgroup_subsys_state *css,
 	if (tg->uclamp[UCLAMP_MAX].value < min_value)
 		goto out;
 
+	/* Update effective clamps to track the most restrictive value */
+	cpu_util_update_hier(css, UCLAMP_MIN, min_value);
+
 out:
 	rcu_read_unlock();
 	mutex_unlock(&uclamp_mutex);
@@ -7244,6 +7291,9 @@ static int cpu_util_max_write_u64(struct cgroup_subsys_state *css,
 	if (tg->uclamp[UCLAMP_MIN].value > max_value)
 		goto out;
 
+	/* Update effective clamps to track the most restrictive value */
+	cpu_util_update_hier(css, UCLAMP_MAX, max_value);
+
 out:
 	rcu_read_unlock();
 	mutex_unlock(&uclamp_mutex);
@@ -7252,14 +7302,17 @@ static int cpu_util_max_write_u64(struct cgroup_subsys_state *css,
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
@@ -7268,13 +7321,25 @@ static inline u64 cpu_uclamp_read(struct cgroup_subsys_state *css,
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
 
@@ -7622,11 +7687,19 @@ static struct cftype cpu_legacy_files[] = {
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
-- 
2.18.0

