Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D154C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1539020865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:18:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1539020865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbeIJPLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 11:11:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39513 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728210AbeIJPLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 11:11:20 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8AAHcBE1808381
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 10 Sep 2018 03:17:38 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8AAHcEE1808378;
        Mon, 10 Sep 2018 03:17:38 -0700
Date:   Mon, 10 Sep 2018 03:17:38 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Valentin Schneider <tipbot@zytor.com>
Message-ID: <tip-757ffdd705ee942fc8150b17942d968601d2a15b@git.kernel.org>
Cc:     valentin.schneider@arm.com, hpa@zytor.com, peterz@infradead.org,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        morten.rasmussen@arm.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org,
          morten.rasmussen@arm.com, tglx@linutronix.de,
          torvalds@linux-foundation.org, peterz@infradead.org,
          hpa@zytor.com, valentin.schneider@arm.com
In-Reply-To: <1530699470-29808-10-git-send-email-morten.rasmussen@arm.com>
References: <1530699470-29808-10-git-send-email-morten.rasmussen@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Set rq->rd->overload when misfit
Git-Commit-ID: 757ffdd705ee942fc8150b17942d968601d2a15b
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  757ffdd705ee942fc8150b17942d968601d2a15b
Gitweb:     https://git.kernel.org/tip/757ffdd705ee942fc8150b17942d968601d2a15b
Author:     Valentin Schneider <valentin.schneider@arm.com>
AuthorDate: Wed, 4 Jul 2018 11:17:47 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 10 Sep 2018 11:05:53 +0200

sched/fair: Set rq->rd->overload when misfit

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

a,b,c,d are our CPU-hogging tasks _ signifies idling

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

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: dietmar.eggemann@arm.com
Cc: gaku.inami.xh@renesas.com
Cc: vincent.guittot@linaro.org
Link: http://lkml.kernel.org/r/1530699470-29808-10-git-send-email-morten.rasmussen@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c  | 6 ++++--
 kernel/sched/sched.h | 6 +++++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d9c4e97bfebd..8b228c5b3eb4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7793,7 +7793,7 @@ static bool update_nohz_stats(struct rq *rq, bool force)
  * @load_idx: Load index of sched_domain of this_cpu for load calc.
  * @local_group: Does group contain this_cpu.
  * @sgs: variable to hold the statistics for this group.
- * @overload: Indicate more than one runnable task for any CPU.
+ * @overload: Indicate pullable load (e.g. >1 runnable task).
  */
 static inline void update_sg_lb_stats(struct lb_env *env,
 			struct sched_group *group, int load_idx,
@@ -7837,8 +7837,10 @@ static inline void update_sg_lb_stats(struct lb_env *env,
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
index 938063639793..85b3a2bf6c2b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -715,7 +715,11 @@ struct root_domain {
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
