Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425737AbeBOQVj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 11:21:39 -0500
Received: from foss.arm.com ([217.140.101.70]:57122 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1425690AbeBOQVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 11:21:32 -0500
From: Morten Rasmussen <morten.rasmussen@arm.com>
To: peterz@infradead.org, mingo@redhat.com
Cc: valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [PATCH 5/7] sched/fair: Kick nohz balance if rq->misfit_task
Date: Thu, 15 Feb 2018 16:20:52 +0000
Message-Id: <1518711654-23503-6-git-send-email-morten.rasmussen@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518711654-23503-1-git-send-email-morten.rasmussen@arm.com>
References: <1518711654-23503-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Valentin Schneider <valentin.schneider@arm.com>

There already are a few conditions in nohz_kick_needed() to ensure
a nohz kick is triggered, but they are not enough for some misfit
task scenarios. Excluding asym packing, those are:

* rq->nr_running >=2: Not relevant here because we are running a
misfit task, it needs to be migrated regardless and potentially through
active balance.
* sds->nr_busy_cpus > 1: If there is only the misfit task being run
on a group of low capacity cpus, this will be evaluated to False.
* rq->cfs.h_nr_running >=1 && check_cpu_capacity(): Not relevant here,
misfit task needs to be migrated regardless of rt/IRQ pressure

As such, this commit adds an rq->misfit_task condition to trigger a
nohz kick.

The idea to kick a nohz balance for misfit tasks originally came from
Leo Yan <leo.yan@linaro.org>, and a similar patch was submitted for
the Android Common Kernel - see [1].

[1]: https://lists.linaro.org/pipermail/eas-dev/2016-September/000551.html

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 kernel/sched/fair.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e036aef3f10a..1439b784b1f0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9411,6 +9411,9 @@ static inline bool nohz_kick_needed(struct rq *rq)
 	if (rq->nr_running >= 2)
 		return true;
 
+	if (rq->misfit_task_load)
+		return true;
+
 	rcu_read_lock();
 	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
 	if (sds) {
-- 
2.7.4
