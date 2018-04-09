Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753861AbeDIQ4v (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 12:56:51 -0400
Received: from foss.arm.com ([217.140.101.70]:58578 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753746AbeDIQ4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 12:56:45 -0400
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>
Subject: [PATCH 5/7] sched/core: uclamp: use TG clamps to restrict TASK clamps
Date: Mon,  9 Apr 2018 17:56:13 +0100
Message-Id: <20180409165615.2326-6-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180409165615.2326-1-patrick.bellasi@arm.com>
References: <20180409165615.2326-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a task's util_clamp value is configured via sched_setattr, this
value has to be properly accounted in the corresponding clamp group
every time the task is enqueue and dequeued. When cgroups are also in
use, per-task clamp values have to be aggregated to those of the CPU's
controller's CGroup in which the task is currently living.

Let's update uclamp_cpu_get() to provide an aggregation between the task
and the TG clamp values. Every time a task is enqueued, it will be
accounted in the clamp_group which defines the smaller clamp value
between the task and the TG's ones. This mimics what already happen for
a task's CPU affinity mask when the task is also living in a cpuset.
The overall idea is that: CGroups attributes are always used to restrict
the per-task attributes.

For consistency purposes, as well as to properly inform userspace, the
sched_getattr call is updated to always return the properly aggregated
constrains as described above. This will also make sched_getattr a
convenient userpace API to know the utilization constraints enforced on
a task by the CGroups's CPU controller.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Paul Turner <pjt@google.com>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Steve Muckle <smuckle@google.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
---
 kernel/sched/core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b8299a4f03e7..592de8d32427 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -966,9 +966,18 @@ static inline void uclamp_cpu_get(struct task_struct *p, int cpu, int clamp_id)
 	clamp_value = p->uclamp[clamp_id].value;
 	group_id = p->uclamp[clamp_id].group_id;
 
+#ifdef CONFIG_UCLAMP_TASK_GROUP
+	/* Use TG's clamp value to limit task specific values */
+	if (group_id == UCLAMP_NONE ||
+	    clamp_value >= task_group(p)->uclamp[clamp_id].value) {
+		clamp_value = task_group(p)->uclamp[clamp_id].value;
+		group_id = task_group(p)->uclamp[clamp_id].group_id;
+	}
+#else
 	/* No task specific clamp values: nothing to do */
 	if (group_id == UCLAMP_NONE)
 		return;
+#endif
 
 	/* Increment the current group_id */
 	uc_cpu->group[group_id].tasks += 1;
@@ -5401,6 +5410,12 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
 #ifdef CONFIG_UCLAMP_TASK
 	attr.sched_util_min = p->uclamp[UCLAMP_MIN].value;
 	attr.sched_util_max = p->uclamp[UCLAMP_MAX].value;
+#ifdef CONFIG_UCLAMP_TASK_GROUP
+	if (task_group(p)->uclamp[UCLAMP_MIN].value < attr.sched_util_min)
+		attr.sched_util_min = task_group(p)->uclamp[UCLAMP_MIN].value;
+	if (task_group(p)->uclamp[UCLAMP_MAX].value < attr.sched_util_max)
+		attr.sched_util_max = task_group(p)->uclamp[UCLAMP_MAX].value;
+#endif
 #endif
 
 	rcu_read_unlock();
-- 
2.15.1
