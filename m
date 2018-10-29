Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348EEC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F344C2080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:33:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F344C2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbeJ3DXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 23:23:46 -0400
Received: from foss.arm.com ([217.140.101.70]:44630 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729275AbeJ3DXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 23:23:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB86C341;
        Mon, 29 Oct 2018 11:33:54 -0700 (PDT)
Received: from e110439-lin.cambridge.arm.com (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EA9BA3F6A8;
        Mon, 29 Oct 2018 11:33:51 -0700 (PDT)
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
Subject: [PATCH v5 07/15] sched/core: uclamp: add clamp group bucketing support
Date:   Mon, 29 Oct 2018 18:33:02 +0000
Message-Id: <20181029183311.29175-9-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181029183311.29175-1-patrick.bellasi@arm.com>
References: <20181029183311.29175-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The limited number of clamp groups is required to have an effective and
efficient run-time tracking of the clamp groups required by RUNNABLE
tasks. However, we must ensure we can always know which clamp group to
use in the fast path (task enqueue/dequeue time) to refcount each tasks,
whatever its clamp value is.

To this purpose we can trade-off CPU clamping precision for efficiency
by turning CPU's clamp groups into buckets, each one representing a
range of possible clamp values.

The number of clamp groups configured at compile time defines the range
of utilization clamp values tracked by each CPU clamp group.
For example, with the default configuration:
   CONFIG_UCLAMP_GROUPS_COUNT 5
we will have 5 clamp groups tracking 20% utilization each. In this case,
a task with util_min=25% will have group_id=1.

This bucketing mechanisms applies only on the fast-path, when tasks are
refcounted into a per-CPU clamp groups at enqueue/dequeue time, while
tasks keep tracking their task-specific clamp value requested from
user-space. This allows to track, within each bucket, the maximum
task-specific clamp value for tasks refcounted in that bucket.

In the example above, a 25% boosted tasks will be refcounted in the
[20..39]% bucket and will set the bucket clamp effective value to 25%.
If a second 30% boosted task should be co-scheduled on the same CPU,
that task will be refcounted in the same bucket of the first task and it
will boost the bucket clamp effective value to 30%.
The clamp effective value of a bucket will be reset to its nominal value
(named the "group_value", 20% in the example above) when there are
anymore tasks refcounted in that bucket.

On a real system we expect a limited number of sufficiently different
clamp values thus, this simple bucketing mechanism is still effective
to track tasks clamp effective values quite closely.
An additional boost/capping margin can be added to some tasks, in the
example above the 25% task will be boosted to 30% until it exits the
CPU.

If that should be considered not acceptable on certain systems, it's
always possible to reduce the margin by increasing the bucketing
resolution. Indeed, by properly setting the number of
CONFIG_UCLAMP_GROUPS_COUNT, we can trade off memory efficiency for
resolution.

The already existing mechanism to map "clamp values" into "clamp groups"
ensures to use only the minimal set of clamp groups actually required.
For example, if we have only 20% and 25% clamped tasks, by setting:
   CONFIG_UCLAMP_GROUPS_COUNT 20
we will allocate 20 5% resolution buckets, however we will use only 2
two of them in the fast-path, since their 5% resolution will be enough
to always distinguish them.

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
Changes in v5:
 Others:
 - renamed uclamp_round into uclamp_group_value to better represent
   what this function returns
 - rebased on v4.19

Changes in v4:
 Message-ID: <20180809152313.lewfhufidhxb2qrk@darkstar>
 - implements the idea discussed in this thread
 Others:
 - new patch added in this version
 - rebased on v4.19-rc1
---
 kernel/sched/core.c | 48 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b23f80c07be9..9b49062439f3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -783,6 +783,27 @@ union uclamp_map {
  */
 static union uclamp_map uclamp_maps[UCLAMP_CNT][UCLAMP_GROUPS];
 
+/*
+ * uclamp_group_value: get the "group value" for a given "clamp value"
+ * @value: the utiliation "clamp value" to translate
+ *
+ * The number of clamp group, which is defined at compile time, allows to
+ * track a finite number of different clamp values. Thus clamp values are
+ * grouped into bins each one representing a different "group value".
+ * This method returns the "group value" corresponding to the specified
+ * "clamp value".
+ */
+static inline unsigned int uclamp_group_value(unsigned int clamp_value)
+{
+#define UCLAMP_GROUP_DELTA (SCHED_CAPACITY_SCALE / CONFIG_UCLAMP_GROUPS_COUNT)
+#define UCLAMP_GROUP_UPPER (UCLAMP_GROUP_DELTA * CONFIG_UCLAMP_GROUPS_COUNT)
+
+	if (clamp_value >= UCLAMP_GROUP_UPPER)
+		return SCHED_CAPACITY_SCALE;
+
+	return UCLAMP_GROUP_DELTA * (clamp_value / UCLAMP_GROUP_DELTA);
+}
+
 /**
  * uclamp_cpu_update: updates the utilization clamp of a CPU
  * @rq: the CPU's rq which utilization clamp has to be updated
@@ -848,6 +869,7 @@ static inline void uclamp_cpu_update(struct rq *rq, unsigned int clamp_id,
 static inline void uclamp_cpu_get_id(struct task_struct *p, struct rq *rq,
 				     unsigned int clamp_id)
 {
+	unsigned int clamp_value;
 	unsigned int group_id;
 
 	if (unlikely(!p->uclamp[clamp_id].mapped))
@@ -870,6 +892,11 @@ static inline void uclamp_cpu_get_id(struct task_struct *p, struct rq *rq,
 		rq->uclamp.value[clamp_id] = p->uclamp[clamp_id].value;
 	}
 
+	/* CPU's clamp groups track the max effective clamp value */
+	clamp_value = p->uclamp[clamp_id].value;
+	if (clamp_value > rq->uclamp.group[clamp_id][group_id].value)
+		rq->uclamp.group[clamp_id][group_id].value = clamp_value;
+
 	if (rq->uclamp.value[clamp_id] < p->uclamp[clamp_id].value)
 		rq->uclamp.value[clamp_id] = p->uclamp[clamp_id].value;
 }
@@ -917,8 +944,16 @@ static inline void uclamp_cpu_put_id(struct task_struct *p, struct rq *rq,
 		     cpu_of(rq), clamp_id, group_id);
 	}
 #endif
-	if (clamp_value >= rq->uclamp.value[clamp_id])
+	if (clamp_value >= rq->uclamp.value[clamp_id]) {
+		/*
+		 * Each CPU's clamp group value is reset to its nominal group
+		 * value whenever there are anymore RUNNABLE tasks refcounting
+		 * that clamp group.
+		 */
+		rq->uclamp.group[clamp_id][group_id].value =
+			uclamp_maps[clamp_id][group_id].value;
 		uclamp_cpu_update(rq, clamp_id, clamp_value);
+	}
 }
 
 /**
@@ -1065,10 +1100,13 @@ static void uclamp_group_get(struct task_struct *p, struct uclamp_se *uc_se,
 	unsigned int prev_group_id = uc_se->group_id;
 	union uclamp_map uc_map_old, uc_map_new;
 	unsigned int free_group_id;
+	unsigned int group_value;
 	unsigned int group_id;
 	unsigned long res;
 	int cpu;
 
+	group_value = uclamp_group_value(clamp_value);
+
 retry:
 
 	free_group_id = UCLAMP_GROUPS;
@@ -1076,7 +1114,7 @@ static void uclamp_group_get(struct task_struct *p, struct uclamp_se *uc_se,
 		uc_map_old.data = atomic_long_read(&uc_maps[group_id].adata);
 		if (free_group_id == UCLAMP_GROUPS && !uc_map_old.se_count)
 			free_group_id = group_id;
-		if (uc_map_old.value == clamp_value)
+		if (uc_map_old.value == group_value)
 			break;
 	}
 	if (group_id >= UCLAMP_GROUPS) {
@@ -1092,7 +1130,7 @@ static void uclamp_group_get(struct task_struct *p, struct uclamp_se *uc_se,
 	}
 
 	uc_map_new.se_count = uc_map_old.se_count + 1;
-	uc_map_new.value = clamp_value;
+	uc_map_new.value = group_value;
 	res = atomic_long_cmpxchg(&uc_maps[group_id].adata,
 				  uc_map_old.data, uc_map_new.data);
 	if (res != uc_map_old.data)
@@ -1113,9 +1151,9 @@ static void uclamp_group_get(struct task_struct *p, struct uclamp_se *uc_se,
 #endif
 		}
 
-		if (uc_cpu->group[clamp_id][group_id].value == clamp_value)
+		if (uc_cpu->group[clamp_id][group_id].value == group_value)
 			continue;
-		uc_cpu->group[clamp_id][group_id].value = clamp_value;
+		uc_cpu->group[clamp_id][group_id].value = group_value;
 	}
 
 done:
-- 
2.18.0

