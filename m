Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5185EC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F4F24C34
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:49:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15F4F24C34
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754519AbeGCHtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:49:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58345 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753831AbeGCHtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:49:52 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w637nVVI201722
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 3 Jul 2018 00:49:31 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w637nV93201719;
        Tue, 3 Jul 2018 00:49:31 -0700
Date:   Tue, 3 Jul 2018 00:49:31 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vincent Guittot <tipbot@zytor.com>
Message-ID: <tip-296b2ffe7fa9ed756c41415c6b1512bc4ad687b1@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org,
        torvalds@linux-foundation.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org
Reply-To: hpa@zytor.com, peterz@infradead.org,
          linux-kernel@vger.kernel.org, vincent.guittot@linaro.org,
          tglx@linutronix.de, mingo@kernel.org,
          torvalds@linux-foundation.org
In-Reply-To: <1530021202-21695-1-git-send-email-vincent.guittot@linaro.org>
References: <1530021202-21695-1-git-send-email-vincent.guittot@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/rt: Fix call to cpufreq_update_util()
Git-Commit-ID: 296b2ffe7fa9ed756c41415c6b1512bc4ad687b1
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

Commit-ID:  296b2ffe7fa9ed756c41415c6b1512bc4ad687b1
Gitweb:     https://git.kernel.org/tip/296b2ffe7fa9ed756c41415c6b1512bc4ad687b1
Author:     Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate: Tue, 26 Jun 2018 15:53:22 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 3 Jul 2018 09:17:28 +0200

sched/rt: Fix call to cpufreq_update_util()

With commit:

  8f111bc357aa ("cpufreq/schedutil: Rewrite CPUFREQ_RT support")

the schedutil governor uses rq->rt.rt_nr_running to detect whether an
RT task is currently running on the CPU and to set frequency to max
if necessary.

cpufreq_update_util() is called in enqueue/dequeue_top_rt_rq() but
rq->rt.rt_nr_running has not been updated yet when dequeue_top_rt_rq() is
called so schedutil still considers that an RT task is running when the
last task is dequeued. The update of rq->rt.rt_nr_running happens later
in dequeue_rt_stack().

In fact, we can take advantage of the sequence that the dequeue then
re-enqueue rt entities when a rt task is enqueued or dequeued;
As a result enqueue_top_rt_rq() is always called when a task is
enqueued or dequeued and also when groups are throttled or unthrottled.
The only place that not use enqueue_top_rt_rq() is when root rt_rq is
throttled.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: efault@gmx.de
Cc: juri.lelli@redhat.com
Cc: patrick.bellasi@arm.com
Cc: viresh.kumar@linaro.org
Fixes: 8f111bc357aa ('cpufreq/schedutil: Rewrite CPUFREQ_RT support')
Link: http://lkml.kernel.org/r/1530021202-21695-1-git-send-email-vincent.guittot@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/cpufreq_schedutil.c |  2 +-
 kernel/sched/rt.c                | 16 ++++++++++------
 kernel/sched/sched.h             |  5 +++++
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 3cde46483f0a..c907fde01eaa 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -192,7 +192,7 @@ static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
 {
 	struct rq *rq = cpu_rq(sg_cpu->cpu);
 
-	if (rq->rt.rt_nr_running)
+	if (rt_rq_is_runnable(&rq->rt))
 		return sg_cpu->max;
 
 	/*
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 47556b0c9a95..572567078b60 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -508,8 +508,11 @@ static void sched_rt_rq_dequeue(struct rt_rq *rt_rq)
 
 	rt_se = rt_rq->tg->rt_se[cpu];
 
-	if (!rt_se)
+	if (!rt_se) {
 		dequeue_top_rt_rq(rt_rq);
+		/* Kick cpufreq (see the comment in kernel/sched/sched.h). */
+		cpufreq_update_util(rq_of_rt_rq(rt_rq), 0);
+	}
 	else if (on_rt_rq(rt_se))
 		dequeue_rt_entity(rt_se, 0);
 }
@@ -1001,8 +1004,6 @@ dequeue_top_rt_rq(struct rt_rq *rt_rq)
 	sub_nr_running(rq, rt_rq->rt_nr_running);
 	rt_rq->rt_queued = 0;
 
-	/* Kick cpufreq (see the comment in kernel/sched/sched.h). */
-	cpufreq_update_util(rq, 0);
 }
 
 static void
@@ -1014,11 +1015,14 @@ enqueue_top_rt_rq(struct rt_rq *rt_rq)
 
 	if (rt_rq->rt_queued)
 		return;
-	if (rt_rq_throttled(rt_rq) || !rt_rq->rt_nr_running)
+
+	if (rt_rq_throttled(rt_rq))
 		return;
 
-	add_nr_running(rq, rt_rq->rt_nr_running);
-	rt_rq->rt_queued = 1;
+	if (rt_rq->rt_nr_running) {
+		add_nr_running(rq, rt_rq->rt_nr_running);
+		rt_rq->rt_queued = 1;
+	}
 
 	/* Kick cpufreq (see the comment in kernel/sched/sched.h). */
 	cpufreq_update_util(rq, 0);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 6601baf2361c..27ddec334601 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -609,6 +609,11 @@ struct rt_rq {
 #endif
 };
 
+static inline bool rt_rq_is_runnable(struct rt_rq *rt_rq)
+{
+	return rt_rq->rt_queued && rt_rq->rt_nr_running;
+}
+
 /* Deadline class' related fields in a runqueue */
 struct dl_rq {
 	/* runqueue is an rbtree, ordered by deadline */
