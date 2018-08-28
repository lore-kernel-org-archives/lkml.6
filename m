Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A07C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 009A72087C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:55:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 009A72087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbeH1RrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 13:47:00 -0400
Received: from foss.arm.com ([217.140.101.70]:38674 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727725AbeH1Rq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 13:46:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D2131BB2;
        Tue, 28 Aug 2018 06:54:46 -0700 (PDT)
Received: from e110439-lin.Cambridge.arm.com (e110439-lin.emea.arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ABBE53F5BD;
        Tue, 28 Aug 2018 06:54:43 -0700 (PDT)
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
Subject: [PATCH v4 15/16] sched/core: uclamp: add clamp group discretization support
Date:   Tue, 28 Aug 2018 14:53:23 +0100
Message-Id: <20180828135324.21976-16-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180828135324.21976-1-patrick.bellasi@arm.com>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The limited number of clamp groups is required to have both an effective
and efficient run-time tracking of the clamp groups required by RUNNABLE
tasks. However, being a limited number imposes some constraints on its
usage at run-time. Specifically, a System Management Software should
"reserve" all the possible clamp values required at run-time to ensure
there will always be a clamp group to track them whenever required.

To fix this problem we can trade-off CPU clamping precision for
efficiency by transforming CPU's clamp groups into buckets of a
predefined range.

The number of clamp groups configured at compile time defines the range
of utilization clamp values tracked by each CPU clamp group. Thus, for
example, with the default:
   CONFIG_UCLAMP_GROUPS_COUNT 5
we will have 5 clamp groups tracking 20% utilization each and a task
with util_min=25% will have group_id=1.

Scheduling entities keep tracking the specific value defined from
user-space, which can still be used for task placement biasing
decisions. However, at enqueue time tasks will be refcounted in the
clamp group which range includes the task specific clamp value.

Each CPU's clamp value will also be updated to aggregate and represent
at run-time the most restrictive value among those of the RUNNABLE tasks
refcounted by that group. Each time a CPU clamp group becomes empty we
reset its clamp value to the minimum value of the range it tracks.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
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
 Message-ID: <20180809152313.lewfhufidhxb2qrk@darkstar>
 - implements the idea discussed in this thread
 Others:
 - new patch added in this version
 - rebased on v4.19-rc1
---
 include/linux/sched.h   | 13 ++++-----
 kernel/sched/core.c     | 59 ++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/features.h |  5 ++++
 3 files changed, 70 insertions(+), 7 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index ca0a80881fa9..752fcd5d2cea 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -608,17 +608,18 @@ struct sched_dl_entity {
  * either tasks or task groups, to enforce the same clamp "value" for a given
  * clamp index.
  *
- * Scheduling entity's specific clamp group index can be different
- * from the effective clamp group index used at enqueue time since
- * task groups's clamps can be restricted by their parent task group.
+ * Scheduling entity's specific clamp value and group index can be different
+ * from the effective value and group index used at enqueue time. Indeed:
+ * - task's clamps can be restricted by their task group calmps
+ * - task groups's clamps can be restricted by their parent task group
  */
 struct uclamp_se {
 	unsigned int value;
 	unsigned int group_id;
 	/*
-	 * Effective task (group) clamp value and group index.
-	 * For task groups it's the value (eventually) enforced by a parent
-	 * task group.
+	 * Effective task (group) clamp value and group index:
+	 * for tasks: those used at enqueue time
+	 * for task groups: those (eventually) enforced by a parent task group
 	 */
 	struct {
 		unsigned int value;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8341ce580a9a..f71e15eaf152 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -807,6 +807,34 @@ static struct uclamp_map uclamp_maps[UCLAMP_CNT]
 #define UCLAMP_ENOSPC_FMT "Cannot allocate more than " \
 	__stringify(CONFIG_UCLAMP_GROUPS_COUNT) " UTIL_%s clamp groups\n"
 
+/*
+ * uclamp_round: round a clamp value to the closest trackable value
+ *
+ * The number of clamp group, which is defined at compile time, allows to
+ * track a finete number of different clamp values. This makes sense from both
+ * a practical standpoint, since we do not expect many different values at on
+ * a real system, as well as for run-time efficiency.
+ *
+ * To ensure a clamp group is always available, this methd allows to
+ * discretize a required value into one of the possible available clamp
+ * groups.
+ */
+static inline int uclamp_round(int value)
+{
+#define UCLAMP_GROUP_DELTA (SCHED_CAPACITY_SCALE / CONFIG_UCLAMP_GROUPS_COUNT)
+#define UCLAMP_GROUP_UPPER (UCLAMP_GROUP_DELTA * CONFIG_UCLAMP_GROUPS_COUNT)
+
+	if (unlikely(!sched_feat(UCLAMP_ROUNDING)))
+		return value;
+
+	if (value <= 0)
+		return value;
+	if (value >= UCLAMP_GROUP_UPPER)
+		return SCHED_CAPACITY_SCALE;
+
+	return UCLAMP_GROUP_DELTA * (value / UCLAMP_GROUP_DELTA);
+}
+
 /**
  * uclamp_group_available: checks if a clamp group is available
  * @clamp_id: the utilization clamp index (i.e. min or max clamp)
@@ -846,6 +874,9 @@ static inline void uclamp_group_init(int clamp_id, int group_id,
 	struct uclamp_cpu *uc_cpu;
 	int cpu;
 
+	/* Clamp groups are always initialized to the rounded clamp value */
+	clamp_value = uclamp_round(clamp_value);
+
 	/* Set clamp group map */
 	uc_map[group_id].value = clamp_value;
 	uc_map[group_id].se_count = 0;
@@ -892,6 +923,7 @@ uclamp_group_find(int clamp_id, unsigned int clamp_value)
 	int free_group_id = UCLAMP_NOT_VALID;
 	unsigned int group_id = 0;
 
+	clamp_value = uclamp_round(clamp_value);
 	for ( ; group_id <= CONFIG_UCLAMP_GROUPS_COUNT; ++group_id) {
 		/* Keep track of first free clamp group */
 		if (uclamp_group_available(clamp_id, group_id)) {
@@ -979,6 +1011,22 @@ static inline void uclamp_cpu_update(struct rq *rq, int clamp_id,
  *    task_struct::uclamp::effective::value
  * is updated to represent the clamp value corresponding to the taks effective
  * group index.
+ *
+ * Thus, the effective clamp value for a task is granted to be in the range of
+ * the rounded clamp values of its effective clamp group. For example:
+ *  - CONFIG_UCLAMP_GROUPS_COUNT=5 => UCLAMP_GROUP_DELTA=20%
+ *  - TaskA:      util_min=25%     => clamp_group1: range [20-39]%
+ *  - TaskB:      util_min=35%     => clamp_group1: range [20-39]%
+ *  - TaskGroupA: util_min=10%     => clamp_group0: range [ 0-19]%
+ * Then, when TaskA is part of TaskGroupA, it will be:
+ *  - allocated in clamp_group1
+ *  - clamp_group1.value=25
+ *    while TaskA is running alone
+ *  - clamp_group1.value=35
+ *    since TaskB was RUNNABLE and until TaskA is RUNNABLE
+ *  - clamp_group1.value=20
+ *    i.e. CPU's clamp group value is reset to the nominal rounded value,
+ *    while TaskA and TaskB are not RUNNABLE
  */
 static inline int uclamp_task_group_id(struct task_struct *p, int clamp_id)
 {
@@ -1106,6 +1154,10 @@ static inline void uclamp_cpu_get_id(struct task_struct *p,
 		uc_cpu->value[clamp_id] = clamp_value;
 	}
 
+	/* Track the max effective clamp value for each CPU's clamp group */
+	if (clamp_value > uc_cpu->group[clamp_id][group_id].value)
+		uc_cpu->group[clamp_id][group_id].value = clamp_value;
+
 	/*
 	 * If this is the new max utilization clamp value, then we can update
 	 * straight away the CPU clamp value. Otherwise, the current CPU clamp
@@ -1170,8 +1222,13 @@ static inline void uclamp_cpu_put_id(struct task_struct *p,
 		     cpu_of(rq), clamp_id, group_id);
 	}
 #endif
-	if (clamp_value >= uc_cpu->value[clamp_id])
+	if (clamp_value >= uc_cpu->value[clamp_id]) {
+		/* Reset CPU's clamp value to rounded clamp group value */
+		clamp_value = uclamp_group_value(clamp_id, group_id);
+		uc_cpu->group[clamp_id][group_id].value = clamp_value;
+
 		uclamp_cpu_update(rq, clamp_id, clamp_value);
+	}
 }
 
 /**
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index aad826aa55f8..5b7d0965b090 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -95,3 +95,8 @@ SCHED_FEAT(UTIL_EST, true)
  * Utilization clamping lazy update.
  */
 SCHED_FEAT(UCLAMP_LAZY_UPDATE, false)
+
+/*
+ * Utilization clamping discretization.
+ */
+SCHED_FEAT(UCLAMP_ROUNDING, true)
-- 
2.18.0

