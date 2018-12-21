Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAC8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A16321939
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545405704;
	bh=+GUFcob1zAnoT5TEMD1SMg3L8/OrWZJKRXajWl2SOUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=sGxbz4GeujIjT10pZ+JUyLnw3ellTYDuLVYJ4cWIjbWJ1Rt0zjleyAv5IQ1ps6ehF
	 pZFuk2lGA2B46L4ANXL2c7yJx/i8GWFaiduot/JJaHm4oLAztefoOKzxfG8nzCgP2R
	 bk9QCALBnsPkFu9yGpYuSzq0IRi5pVvAju3lI5RE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404191AbeLUPVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 10:21:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:57128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404164AbeLUPVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 10:21:37 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D731321929;
        Fri, 21 Dec 2018 15:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545405696;
        bh=+GUFcob1zAnoT5TEMD1SMg3L8/OrWZJKRXajWl2SOUM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=Z1aLoUcikioTJvMG7l1oqdQC3NoU0rQ7SWulJZQCV3D4dkKiANGL1Uy1el0q4z6wS
         pIsceTZ/0RK385w4YEhDMj9kW7f1h6I9q+xAPRIZo0/4kRNGtNFFCHv11AI0ngjlmU
         Nd9E/QxTleKfiC0DnnzhFCZxHkVgolYknibGLfHw=
From:   Tom Zanussi <zanussi@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     rostedt@goodmis.org, tglx@linutronix.de, C.Emde@osadl.org,
        jkacur@redhat.com, bigeasy@linutronix.de,
        daniel.wagner@siemens.com, julia@ni.com
Subject: [PATCH RT 4/9] sched/core: Avoid __schedule() being called twice in a row
Date:   Fri, 21 Dec 2018 09:21:16 -0600
Message-Id: <f627dfe1a81b884fbe95dc0591722331e343f0bb.1545347029.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1545347029.git.tom.zanussi@linux.intel.com>
References: <cover.1545347029.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1545347029.git.tom.zanussi@linux.intel.com>
References: <cover.1545347029.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3.18.129-rt111 rt-stable review patch.  If anyone has any objections,
please let me know.

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
[bigeasy: rewrite changelog]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/sched/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d5534f439b4a..500c319fcfc5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3114,10 +3114,15 @@ static inline void sched_submit_work(struct task_struct *tsk)
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
2.14.1

