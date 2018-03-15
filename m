Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752669AbeCOOre (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 10:47:34 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40036 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752108AbeCOOrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 10:47:31 -0400
From: Morten Rasmussen <morten.rasmussen@arm.com>
To: peterz@infradead.org, mingo@redhat.com
Cc: valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, gaku.inami.xh@renesas.com,
        linux-kernel@vger.kernel.org,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [PATCHv2 4/7] sched/fair: Kick nohz balance if rq->misfit_task
Date: Thu, 15 Mar 2018 14:47:01 +0000
Message-Id: <1521125224-15434-5-git-send-email-morten.rasmussen@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521125224-15434-1-git-send-email-morten.rasmussen@arm.com>
References: <1521125224-15434-1-git-send-email-morten.rasmussen@arm.com>
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
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 496062860733..c791dd7ac9a8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9291,7 +9291,7 @@ static void nohz_balancer_kick(struct rq *rq)
 	if (time_before(now, nohz.next_balance))
 		goto out;
 
-	if (rq->nr_running >= 2) {
+	if (rq->nr_running >= 2 || rq->misfit_task_load) {
 		flags = NOHZ_KICK_MASK;
 		goto out;
 	}
-- 
2.7.4
