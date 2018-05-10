Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966200AbeEJPG5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 11:06:57 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57328 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965988AbeEJPGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 11:06:10 -0400
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>
Subject: [PATCH 1/3] sched/cpufreq: always consider blocked FAIR utilization
Date: Thu, 10 May 2018 16:05:51 +0100
Message-Id: <20180510150553.28122-2-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180510150553.28122-1-patrick.bellasi@arm.com>
References: <20180510150553.28122-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the refactoring introduced by:

   commit 8f111bc357aa ("cpufreq/schedutil: Rewrite CPUFREQ_RT support")

we aggregate FAIR utilization only if this class has runnable tasks.
This was mainly due to avoid the risk to stay on an high frequency just
because of the blocked utilization of a CPU not being properly decayed
while the CPU was idle.

However, since:

   commit 31e77c93e432 ("sched/fair: Update blocked load when newly idle")

the FAIR blocked utilization is properly decayed also for IDLE CPUs.

This allows us to use the FAIR blocked utilization as a safe mechanism
to gracefully reduce the frequency only if no FAIR tasks show up on a
CPU for a reasonable period of time.

Moreover, we also reduce the frequency drops of CPUs running periodic
tasks which, depending on the task periodicity and the time required
for a frequency switch, was increasing the chances to introduce some
undesirable performance variations.

Reported-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Joel Fernandes <joelaf@google.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
---
 kernel/sched/cpufreq_schedutil.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index d2c6083304b4..a74d05160e66 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -183,22 +183,21 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu)
 static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
 {
 	struct rq *rq = cpu_rq(sg_cpu->cpu);
-	unsigned long util;
 
-	if (rq->rt.rt_nr_running) {
-		util = sg_cpu->max;
-	} else {
-		util = sg_cpu->util_dl;
-		if (rq->cfs.h_nr_running)
-			util += sg_cpu->util_cfs;
-	}
+	if (rq->rt.rt_nr_running)
+		return sg_cpu->max;
 
 	/*
+	 * Utilization required by DEADLINE must always be granted while, for
+	 * FAIR, we use blocked utilization of IDLE CPUs as a mechanism to
+	 * gracefully reduce the frequency when no tasks show up for longer
+	 * periods of time.
+	 *
 	 * Ideally we would like to set util_dl as min/guaranteed freq and
 	 * util_cfs + util_dl as requested freq. However, cpufreq is not yet
 	 * ready for such an interface. So, we only do the latter for now.
 	 */
-	return min(util, sg_cpu->max);
+	return min(sg_cpu->max, (sg_cpu->util_dl + sg_cpu->util_cfs));
 }
 
 static void sugov_set_iowait_boost(struct sugov_cpu *sg_cpu, u64 time, unsigned int flags)
-- 
2.15.1
