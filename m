Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133F0C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC8E420BEC
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:19:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC8E420BEC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934598AbeGDKSa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 06:18:30 -0400
Received: from foss.arm.com ([217.140.101.70]:35080 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934329AbeGDKS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 06:18:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3D0118A;
        Wed,  4 Jul 2018 03:18:26 -0700 (PDT)
Received: from e105550-lin.cambridge.arm.com (e105550-lin.cambridge.arm.com [10.1.211.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3C6D63F5AD;
        Wed,  4 Jul 2018 03:18:25 -0700 (PDT)
From:   Morten Rasmussen <morten.rasmussen@arm.com>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, gaku.inami.xh@renesas.com,
        linux-kernel@vger.kernel.org,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [PATCHv4 09/12] sched/fair: Set rq->rd->overload when misfit
Date:   Wed,  4 Jul 2018 11:17:47 +0100
Message-Id: <1530699470-29808-10-git-send-email-morten.rasmussen@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530699470-29808-1-git-send-email-morten.rasmussen@arm.com>
References: <1530699470-29808-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Valentin Schneider <valentin.schneider@arm.com>

Idle balance is a great opportunity to pull a misfit task. However,
there are scenarios where misfit tasks are present but idle balance is
prevented by the overload flag.

A good example of this is a workload of n identical tasks. Let's suppose
we have a 2+2 Arm big.LITTLE system. We then spawn 4 fairly
CPU-intensive tasks - for the sake of simplicity let's say they are just
CPU hogs, even when running on big CPUs.

They are identical tasks, so on an SMP system they should all end at
(roughly) the same time. However, in our case the LITTLE CPUs are less
performing than the big CPUs, so tasks running on the LITTLEs will have
a longer completion time.

This means that the big CPUs will complete their work earlier, at which
point they should pull the tasks from the LITTLEs. What we want to
happen is summarized as follows:

a,b,c,d are our CPU-hogging tasks
_ signifies idling

LITTLE_0 | a a a a _ _
LITTLE_1 | b b b b _ _
---------|-------------
  big_0  | c c c c a a
  big_1  | d d d d b b
		  ^
		  ^
    Tasks end on the big CPUs, idle balance happens
    and the misfit tasks are pulled straight away

This however won't happen, because currently the overload flag is only
set when there is any CPU that has more than one runnable task - which
may very well not be the case here if our CPU-hogging workload is all
there is to run.

As such, this commit sets the overload flag in update_sg_lb_stats when
a group is flagged as having a misfit task.

cc: Ingo Molnar <mingo@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 kernel/sched/fair.c  | 6 ++++--
 kernel/sched/sched.h | 6 +++++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d0641ba7bea1..de84f5a9a65a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8163,7 +8163,7 @@ static bool update_nohz_stats(struct rq *rq, bool force)
  * @load_idx: Load index of sched_domain of this_cpu for load calc.
  * @local_group: Does group contain this_cpu.
  * @sgs: variable to hold the statistics for this group.
- * @overload: Indicate more than one runnable task for any CPU.
+ * @overload: Indicate pullable load (e.g. >1 runnable task).
  */
 static inline void update_sg_lb_stats(struct lb_env *env,
 			struct sched_group *group, int load_idx,
@@ -8207,8 +8207,10 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 			sgs->idle_cpus++;
 
 		if (env->sd->flags & SD_ASYM_CPUCAPACITY &&
-		    sgs->group_misfit_task_load < rq->misfit_task_load)
+		    sgs->group_misfit_task_load < rq->misfit_task_load) {
 			sgs->group_misfit_task_load = rq->misfit_task_load;
+			*overload = 1;
+		}
 	}
 
 	/* Adjust by relative CPU capacity of the group */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e1dc85d1bfdd..377545b5aa15 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -695,7 +695,11 @@ struct root_domain {
 	cpumask_var_t		span;
 	cpumask_var_t		online;
 
-	/* Indicate more than one runnable task for any CPU */
+	/*
+	 * Indicate pullable load on at least one CPU, e.g:
+	 * - More than one runnable task
+	 * - Running task is misfit
+	 */
 	int			overload;
 
 	/*
-- 
2.7.4

