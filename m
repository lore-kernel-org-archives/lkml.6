Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CD5C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B09C20839
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:52:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B09C20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387590AbeHWMVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:21:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51816 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733155AbeHWMVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:21:25 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D392FC7B;
        Thu, 23 Aug 2018 08:52:44 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 170/324] sched/util_est: Fix util_est_dequeue() for throttled cfs_rq
Date:   Thu, 23 Aug 2018 09:53:56 +0200
Message-Id: <20180823075004.696753053@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vincent Guittot <vincent.guittot@linaro.org>

[ Upstream commit 3482d98bbc730758b63a5d1cf41d05ea17481412 ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/sched/fair.c |   16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3941,18 +3941,10 @@ util_est_dequeue(struct cfs_rq *cfs_rq,
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


