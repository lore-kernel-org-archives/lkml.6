Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1352BC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C45C120881
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:50:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C45C120881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730663AbeIMS7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:59:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33086 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729686AbeIMS7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:59:33 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A79B8D1A;
        Thu, 13 Sep 2018 13:49:58 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, luca abeni <luca.abeni@santannapisa.it>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Juri Lelli <juri.lelli@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Galbraith <efault@gmx.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.14 097/115] sched/deadline: Fix switching to -deadline
Date:   Thu, 13 Sep 2018 15:31:57 +0200
Message-Id: <20180913131829.395953899@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131823.327472833@linuxfoundation.org>
References: <20180913131823.327472833@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luca Abeni <luca.abeni@santannapisa.it>

commit 295d6d5e373607729bcc8182c25afe964655714f upstream.

Fix a bug introduced in:

  72f9f3fdc928 ("sched/deadline: Remove dl_new from struct sched_dl_entity")

After that commit, when switching to -deadline if the scheduling
deadline of a task is in the past then switched_to_dl() calls
setup_new_entity() to properly initialize the scheduling deadline
and runtime.

The problem is that the task is enqueued _before_ having its parameters
initialized by setup_new_entity(), and this can cause problems.
For example, a task with its out-of-date deadline in the past will
potentially be enqueued as the highest priority one; however, its
adjusted deadline may not be the earliest one.

This patch fixes the problem by initializing the task's parameters before
enqueuing it.

Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Juri Lelli <juri.lelli@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1504778971-13573-3-git-send-email-luca.abeni@santannapisa.it
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/sched/deadline.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1365,6 +1365,10 @@ enqueue_dl_entity(struct sched_dl_entity
 		update_dl_entity(dl_se, pi_se);
 	} else if (flags & ENQUEUE_REPLENISH) {
 		replenish_dl_entity(dl_se, pi_se);
+	} else if ((flags & ENQUEUE_RESTORE) &&
+		  dl_time_before(dl_se->deadline,
+				 rq_clock(rq_of_dl_rq(dl_rq_of_se(dl_se))))) {
+		setup_new_dl_entity(dl_se);
 	}
 
 	__enqueue_dl_entity(dl_se);
@@ -2256,13 +2260,6 @@ static void switched_to_dl(struct rq *rq
 
 		return;
 	}
-	/*
-	 * If p is boosted we already updated its params in
-	 * rt_mutex_setprio()->enqueue_task(..., ENQUEUE_REPLENISH),
-	 * p's deadline being now already after rq_clock(rq).
-	 */
-	if (dl_time_before(p->dl.deadline, rq_clock(rq)))
-		setup_new_dl_entity(&p->dl);
 
 	if (rq->curr != p) {
 #ifdef CONFIG_SMP


