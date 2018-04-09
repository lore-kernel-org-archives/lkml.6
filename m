Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753901AbeDIQ4y (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 12:56:54 -0400
Received: from foss.arm.com ([217.140.101.70]:58608 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753746AbeDIQ4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 12:56:52 -0400
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
Subject: [PATCH 7/7] sched/cpufreq: uclamp: add utilization clamping for RT tasks
Date: Mon,  9 Apr 2018 17:56:15 +0100
Message-Id: <20180409165615.2326-8-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180409165615.2326-1-patrick.bellasi@arm.com>
References: <20180409165615.2326-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently schedutil enforces a maximum frequency when RT tasks are
RUNNABLE.  Such a mandatory policy can be made more tunable from
userspace thus allowing for example to define a max frequency which is
still reasonable for the execution of a specific RT workload. This
will contribute to make the RT class more friendly for power/energy
sensitive use-cases.

This patch extends the usage of util_{min,max} to the RT scheduling
class.  Whenever a task in this class is RUNNABLE, the util required is
defined by the constraints of the CPU control group the task belongs to.

The IO wait boost value is thus subject to clamping for RT tasks too.
This is to ensure that RT tasks as well as CFS ones are always subject
to the set of current utilization clampinig constraints.
It's worth to notice that, by default, clamp values are
    min_util, max_util = (0, SCHED_CAPACITY_SCALE)
and thus, RT tasks always run at the maximum OPP if not otherwise
constrained by userspace.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
---
 kernel/sched/cpufreq_schedutil.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index fe53984d06a0..1c80ad65065a 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -182,16 +182,21 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu)
 
 static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
 {
+	unsigned long util = sg_cpu->util_dl;
 	struct rq *rq = cpu_rq(sg_cpu->cpu);
-	unsigned long util;
 
-	if (rq->rt.rt_nr_running) {
-		util = sg_cpu->max;
-	} else {
-		util = sg_cpu->util_dl;
-		if (rq->cfs.h_nr_running)
-			util += uclamp_util(sg_cpu->cpu, sg_cpu->util_cfs);
-	}
+	/*
+	 * RT and CFS utilization are clamped, according to the current CPU
+	 * constrains, only when they have RUNNABLE tasks.
+	 * Their utilization are individually clamped to ensure fairness across
+	 * classes, meaning that CFS always get (if possible) the (minimum)
+	 * required bandwidth on top of that required by higher priority
+	 * classes.
+	 */
+	if (rq->rt.rt_nr_running)
+		util += uclamp_util(sg_cpu->cpu, sg_cpu->max);
+	if (rq->cfs.h_nr_running)
+		util += uclamp_util(sg_cpu->cpu, sg_cpu->util_cfs);
 
 	/*
 	 * Ideally we would like to set util_dl as min/guaranteed freq and
@@ -235,12 +240,10 @@ static void sugov_set_iowait_boost(struct sugov_cpu *sg_cpu, unsigned int flags)
 	 *
 	 * Since DL tasks have a much more advanced bandwidth control, it's
 	 * safe to assume that IO boost does not apply to those tasks.
-	 * Instead, since for RT tasks we are going to max, we don't want to
-	 * clamp the IO boost max value.
+	 * Instead, for CFS and RT tasks we clamp the IO boost max value
+	 * considering the current constraints for the CPU.
 	 */
-	max_boost = sg_cpu->iowait_boost_max;
-	if (!cpu_rq(sg_cpu->cpu)->rt.rt_nr_running)
-		max_boost = uclamp_util(sg_cpu->cpu, max_boost);
+	max_boost = uclamp_util(sg_cpu->cpu, sg_cpu->iowait_boost_max);
 
 	/* Double the IO boost at each frequency increase */
 	sg_cpu->iowait_boost <<= 1;
-- 
2.15.1
