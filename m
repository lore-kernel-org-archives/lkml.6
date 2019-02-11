Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76357C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 511FC21B18
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732505AbfBKSAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 13:00:21 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55138 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730124AbfBKSAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 13:00:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46CBC15AD;
        Mon, 11 Feb 2019 10:00:19 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E57663F675;
        Mon, 11 Feb 2019 10:00:17 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        morten.rasmussen@arm.com, Dietmar.Eggemann@arm.com
Subject: [PATCH v2 2/3] sched/fair: Tune down misfit nohz kicks
Date:   Mon, 11 Feb 2019 17:59:45 +0000
Message-Id: <20190211175946.4961-3-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211175946.4961-1-valentin.schneider@arm.com>
References: <20190211175946.4961-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In

  commmit 3b1baa6496e6 ("sched/fair: Add 'group_misfit_task' load-balance type")

we set rq->misfit_task_load whenever the current running task has a
utilization greater than 80% of rq->cpu_capacity. A non-zero value in
this field enables misfit load balancing.

However, if the task being looked at is already running on a CPU of
highest capacity, there's nothing more we can do for it. We can
currently spot this in update_sd_pick_busiest(), which prevents us
from selecting a sched_group of group_type == group_misfit_task as the
busiest group, but we don't do any of that in nohz_balancer_kick().

This means that we could repeatedly kick nohz CPUs when there's no
improvements in terms of load balance to be done.

Introduce a check_misfit_status() helper that returns true iff there
is a CPU in the system that could give more CPU capacity to a rq's
misfit task - IOW, there exists a CPU of higher capacity_orig or the
rq's CPU is severely pressured by rt/IRQ.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/fair.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0f32e9830ec3..f9f11e140ba3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8058,6 +8058,18 @@ check_cpu_capacity(struct rq *rq, struct sched_domain *sd)
 				(rq->cpu_capacity_orig * 100));
 }
 
+/*
+ * Check whether a rq has a misfit task and if it looks like we can actually
+ * help that task: we can migrate the task to a CPU of higher capacity, or
+ * the task's current CPU is heavily pressured.
+ */
+static inline int check_misfit_status(struct rq *rq, struct sched_domain *sd)
+{
+	return rq->misfit_task_load &&
+		(rq->cpu_capacity_orig < rq->rd->max_cpu_capacity ||
+		 check_cpu_capacity(rq, sd));
+}
+
 /*
  * Group imbalance indicates (and tries to solve) the problem where balancing
  * groups is inadequate due to ->cpus_allowed constraints.
@@ -9585,7 +9597,7 @@ static noinline void nohz_balancer_kick(struct rq *rq)
 	if (time_before(now, nohz.next_balance))
 		goto out;
 
-	if (rq->nr_running >= 2 || rq->misfit_task_load) {
+	if (rq->nr_running >= 2) {
 		flags = NOHZ_KICK_MASK;
 		goto out;
 	}
@@ -9623,6 +9635,18 @@ static noinline void nohz_balancer_kick(struct rq *rq)
 		}
 	}
 
+	sd = rcu_dereference(per_cpu(sd_asym_cpucapacity, cpu));
+	if (sd) {
+		/*
+		 * When ASYM_CPUCAPACITY; see if there's a higher capacity CPU
+		 * to run the misfit task on.
+		 */
+		if (check_misfit_status(rq, sd)) {
+			flags = NOHZ_KICK_MASK;
+			goto unlock;
+		}
+	}
+
 	sd = rcu_dereference(per_cpu(sd_asym_packing, cpu));
 	if (sd) {
 		/*
-- 
2.20.1

