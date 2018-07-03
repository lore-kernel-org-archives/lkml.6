Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD80C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8148224C47
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:51:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8148224C47
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933665AbeGCHvd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:51:33 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55443 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932142AbeGCHvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:51:31 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w637p8sa202062
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 3 Jul 2018 00:51:08 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w637p8s5202059;
        Tue, 3 Jul 2018 00:51:08 -0700
Date:   Tue, 3 Jul 2018 00:51:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vincent Guittot <tipbot@zytor.com>
Message-ID: <tip-3482d98bbc730758b63a5d1cf41d05ea17481412@git.kernel.org>
Cc:     patrick.bellasi@arm.com, torvalds@linux-foundation.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, hpa@zytor.com, tglx@linutronix.de,
        vincent.guittot@linaro.org
Reply-To: vincent.guittot@linaro.org, tglx@linutronix.de,
          peterz@infradead.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          patrick.bellasi@arm.com, torvalds@linux-foundation.org
In-Reply-To: <1528972380-16268-1-git-send-email-vincent.guittot@linaro.org>
References: <1528972380-16268-1-git-send-email-vincent.guittot@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/util_est: Fix util_est_dequeue() for
 throttled cfs_rq
Git-Commit-ID: 3482d98bbc730758b63a5d1cf41d05ea17481412
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

Commit-ID:  3482d98bbc730758b63a5d1cf41d05ea17481412
Gitweb:     https://git.kernel.org/tip/3482d98bbc730758b63a5d1cf41d05ea17481412
Author:     Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate: Thu, 14 Jun 2018 12:33:00 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 3 Jul 2018 09:17:30 +0200

sched/util_est: Fix util_est_dequeue() for throttled cfs_rq

When a cfs_rq is throttled, parent cfs_rq->nr_running is decreased and
everything happens at cfs_rq level. Currently util_est stays unchanged
in such case and it keeps accounting the utilization of throttled tasks.
This can somewhat make sense as we don't dequeue tasks but only throttled
cfs_rq.

If a task of another group is enqueued/dequeued and root cfs_rq becomes
idle during the dequeue, util_est will be cleared whereas it was
accounting util_est of throttled tasks before. So the behavior of util_est
is not always the same regarding throttled tasks and depends of side
activity. Furthermore, util_est will not be updated when the cfs_rq is
unthrottled as everything happens at cfs_rq level. Main results is that
util_est will stay null whereas we now have running tasks. We have to wait
for the next dequeue/enqueue of the previously throttled tasks to get an
up to date util_est.

Remove the assumption that cfs_rq's estimated utilization of a CPU is 0
if there is no running task so the util_est of a task remains until the
latter is dequeued even if its cfs_rq has been throttled.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 7f65ea42eb00 ("sched/fair: Add util_est on top of PELT")
Link: http://lkml.kernel.org/r/1528972380-16268-1-git-send-email-vincent.guittot@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 840b92ee6f89..2f0a0be4d344 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3982,18 +3982,10 @@ util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p, bool task_sleep)
 	if (!sched_feat(UTIL_EST))
 		return;
 
-	/*
-	 * Update root cfs_rq's estimated utilization
-	 *
-	 * If *p is the last task then the root cfs_rq's estimated utilization
-	 * of a CPU is 0 by definition.
-	 */
-	ue.enqueued = 0;
-	if (cfs_rq->nr_running) {
-		ue.enqueued  = cfs_rq->avg.util_est.enqueued;
-		ue.enqueued -= min_t(unsigned int, ue.enqueued,
-				     (_task_util_est(p) | UTIL_AVG_UNCHANGED));
-	}
+	/* Update root cfs_rq's estimated utilization */
+	ue.enqueued  = cfs_rq->avg.util_est.enqueued;
+	ue.enqueued -= min_t(unsigned int, ue.enqueued,
+			     (_task_util_est(p) | UTIL_AVG_UNCHANGED));
 	WRITE_ONCE(cfs_rq->avg.util_est.enqueued, ue.enqueued);
 
 	/*
