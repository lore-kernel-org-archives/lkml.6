Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966176AbeEJPGS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 11:06:18 -0400
Received: from foss.arm.com ([217.140.101.70]:57338 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965537AbeEJPGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 11:06:13 -0400
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
Subject: [PATCH 2/3] sched/fair: util_est: update before schedutil
Date: Thu, 10 May 2018 16:05:52 +0100
Message-Id: <20180510150553.28122-3-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180510150553.28122-1-patrick.bellasi@arm.com>
References: <20180510150553.28122-1-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a task is enqueue the estimated utilization of a CPU is updated
to better support the selection of the required frequency.
However, schedutil is (implicitly) updated by update_load_avg() which
always happens before util_est_{en,de}queue(), thus potentially
introducing a latency between estimated utilization updates and
frequency selections.

Let's update util_est at the beginning of enqueue_task_fair(),
which will ensure that all schedutil updates will see the most
updated estimated utilization value for a CPU.

Reported-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
---
 kernel/sched/fair.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1f6a23a5b451..01dfc47541e6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5356,6 +5356,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &p->se;
 
+	/* Estimated utilization must be updated before schedutil */
+	util_est_enqueue(&rq->cfs, p);
+
 	/*
 	 * If in_iowait is set, the code below may not trigger any cpufreq
 	 * utilization updates, so do it here explicitly with the IOWAIT flag
@@ -5397,7 +5400,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	if (!se)
 		add_nr_running(rq, 1);
 
-	util_est_enqueue(&rq->cfs, p);
 	hrtick_update(rq);
 }
 
-- 
2.15.1
