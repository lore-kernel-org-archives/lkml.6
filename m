Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDD9C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D40820865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:07:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D40820865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbeIJPAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 11:00:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53545 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbeIJPAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 11:00:19 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8AA6gv71806911
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 10 Sep 2018 03:06:42 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8AA6g2W1806908;
        Mon, 10 Sep 2018 03:06:42 -0700
Date:   Mon, 10 Sep 2018 03:06:42 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vincent Guittot <tipbot@zytor.com>
Message-ID: <tip-12b04875d666e83d27511df25580de84505bc758@git.kernel.org>
Cc:     vincent.guittot@linaro.org, hpa@zytor.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@kernel.org, tglx@linutronix.de
Reply-To: hpa@zytor.com, torvalds@linux-foundation.org,
          vincent.guittot@linaro.org, tglx@linutronix.de, mingo@kernel.org,
          linux-kernel@vger.kernel.org, peterz@infradead.org
In-Reply-To: <1535728975-22799-1-git-send-email-vincent.guittot@linaro.org>
References: <1535728975-22799-1-git-send-email-vincent.guittot@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/pelt: Fix update_blocked_averages() for RT
 and DL classes
Git-Commit-ID: 12b04875d666e83d27511df25580de84505bc758
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

Commit-ID:  12b04875d666e83d27511df25580de84505bc758
Gitweb:     https://git.kernel.org/tip/12b04875d666e83d27511df25580de84505bc758
Author:     Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate: Fri, 31 Aug 2018 17:22:55 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 10 Sep 2018 10:13:46 +0200

sched/pelt: Fix update_blocked_averages() for RT and DL classes

update_blocked_averages() is called to periodiccally decay the stalled load
of idle CPUs and to sync all loads before running load balance.

When cfs rq is idle, it trigs a load balance during pick_next_task_fair()
in order to potentially pull tasks and to use this newly idle CPU. This
load balance happens whereas prev task from another class has not been put
and its utilization updated yet. This may lead to wrongly account running
time as idle time for RT or DL classes.

Test that no RT or DL task is running when updating their utilization in
update_blocked_averages().

We still update RT and DL utilization instead of simply skipping them to
make sure that all metrics are synced when used during load balance.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 371bf4273269 ("sched/rt: Add rt_rq utilization tracking")
Fixes: 3727e0e16340 ("sched/dl: Add dl_rq utilization tracking")
Link: http://lkml.kernel.org/r/1535728975-22799-1-git-send-email-vincent.guittot@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b39fb596f6c1..8cff8d55ee95 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7263,6 +7263,7 @@ static void update_blocked_averages(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
 	struct cfs_rq *cfs_rq, *pos;
+	const struct sched_class *curr_class;
 	struct rq_flags rf;
 	bool done = true;
 
@@ -7299,8 +7300,10 @@ static void update_blocked_averages(int cpu)
 		if (cfs_rq_has_blocked(cfs_rq))
 			done = false;
 	}
-	update_rt_rq_load_avg(rq_clock_task(rq), rq, 0);
-	update_dl_rq_load_avg(rq_clock_task(rq), rq, 0);
+
+	curr_class = rq->curr->sched_class;
+	update_rt_rq_load_avg(rq_clock_task(rq), rq, curr_class == &rt_sched_class);
+	update_dl_rq_load_avg(rq_clock_task(rq), rq, curr_class == &dl_sched_class);
 	update_irq_load_avg(rq, 0);
 	/* Don't need periodic decay once load/util_avg are null */
 	if (others_have_blocked(rq))
@@ -7365,13 +7368,16 @@ static inline void update_blocked_averages(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
 	struct cfs_rq *cfs_rq = &rq->cfs;
+	const struct sched_class *curr_class;
 	struct rq_flags rf;
 
 	rq_lock_irqsave(rq, &rf);
 	update_rq_clock(rq);
 	update_cfs_rq_load_avg(cfs_rq_clock_task(cfs_rq), cfs_rq);
-	update_rt_rq_load_avg(rq_clock_task(rq), rq, 0);
-	update_dl_rq_load_avg(rq_clock_task(rq), rq, 0);
+
+	curr_class = rq->curr->sched_class;
+	update_rt_rq_load_avg(rq_clock_task(rq), rq, curr_class == &rt_sched_class);
+	update_dl_rq_load_avg(rq_clock_task(rq), rq, curr_class == &dl_sched_class);
 	update_irq_load_avg(rq, 0);
 #ifdef CONFIG_NO_HZ_COMMON
 	rq->last_blocked_load_update_tick = jiffies;
