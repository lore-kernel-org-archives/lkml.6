Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078AFC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 20:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B288A20892
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 20:59:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B288A20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbeIHBmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:42:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:39394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727756AbeIHBmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:42:15 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE76020881;
        Fri,  7 Sep 2018 20:59:33 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1fyNqn-0001sm-0S; Fri, 07 Sep 2018 16:59:33 -0400
Message-Id: <20180907205932.908152135@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 07 Sep 2018 16:59:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Tommaso Cucinotta <tommaso.cucinotta@sssup.it>,
        Romulo da Silva de Oliveira <romulo.deoliveira@ufsc.br>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH RT 19/24] sched/core: Avoid __schedule() being called twice in a row
References: <20180907205857.262840394@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14.63-rt41-rc2 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Daniel Bristot de Oliveira <bristot@redhat.com>

[ Upstream commit 2bb94c48b2ffaabf8c15a51e5cc1b4c541988cab ]

If a worker invokes schedule() then we may have the call chain:
 schedule()
 -> sched_submit_work()
    -> wq_worker_sleeping()
       -> wake_up_worker()
	  -> wake_up_process().

The last wakeup may cause a schedule which is unnecessary because we are
already in schedule() and do it anyway.

Add a preempt_disable() + preempt_enable_no_resched() around
wq_worker_sleeping() so the context switch could be delayed until
__schedule().

Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: Tommaso Cucinotta <tommaso.cucinotta@sssup.it>
Cc: Romulo da Silva de Oliveira <romulo.deoliveira@ufsc.br>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
[bigeasy: rewrite changelog]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/sched/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fa5b76255f8c..a5ce37b90fca 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3482,10 +3482,15 @@ static inline void sched_submit_work(struct task_struct *tsk)
 	/*
 	 * If a worker went to sleep, notify and ask workqueue whether
 	 * it wants to wake up a task to maintain concurrency.
+	 * As this function is called inside the schedule() context,
+	 * we disable preemption to avoid it calling schedule() again
+	 * in the possible wakeup of a kworker.
 	 */
-	if (tsk->flags & PF_WQ_WORKER)
+	if (tsk->flags & PF_WQ_WORKER) {
+		preempt_disable();
 		wq_worker_sleeping(tsk);
-
+		preempt_enable_no_resched();
+	}
 
 	if (tsk_is_pi_blocked(tsk))
 		return;
-- 
2.18.0


