Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F95C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F6F9222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549991773;
	bh=UFCbeZo2r+dho6yHKoPmCWqDxwqle5g1L1z6Kqo3xAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MOH/fnZUzIPhHOVMDoR4twpzo6YCKnkg9+Yj0XFvfGGZVGKJyVoO/Mdbr0f9fVtfe
	 T/0vSItMGSRe3pm5TY/07WfMjYWc6QJVX3TinF8N7hxfZQgrOS6CKScE/VBNBOOnnX
	 07SVhyUN7wQk5ZFDUqaomKZ161aDu6C+mTCy8zes=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731706AbfBLRQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:16:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:59008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731694AbfBLRQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:16:08 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 785A7222BC;
        Tue, 12 Feb 2019 17:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549991767;
        bh=UFCbeZo2r+dho6yHKoPmCWqDxwqle5g1L1z6Kqo3xAQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T8cO4oknKckHEAtIXoCQBWwWmXSR7u+jRZEAaiBg5WwwhWFjeRj/fbsILchAzFiOr
         iYg3xNxYnlD1I4/wgY8nkoJEEtdj4GohuVnN3dfmTHDbD2cfgJd2OVJeB24DAr0aSf
         88x9CogtvS83BCDaielZuQ/nkghA+nDwfVfiQM+c=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 30/32] softirq: Allow to soft interrupt vector-specific masked contexts
Date:   Tue, 12 Feb 2019 18:14:21 +0100
Message-Id: <20190212171423.8308-31-frederic@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212171423.8308-1-frederic@kernel.org>
References: <20190212171423.8308-1-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the old protections that prevented softirqs from interrupting any
softirq-disabled context. Now that we can disable specific vectors on
a given piece of code, we want to be able to soft-interrupt those places
with other vectors.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Pavan Kondeti <pkondeti@codeaurora.org>
Cc: Paul E . McKenney <paulmck@linux.vnet.ibm.com>
Cc: David S . Miller <davem@davemloft.net>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/softirq.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 4a32effbb1fc..42dfcdfa423b 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -238,7 +238,7 @@ static void local_bh_enable_ip_mask(unsigned long ip, unsigned int cnt,
 	 */
 	preempt_count_sub(cnt - 1);
 
-	if (unlikely(!in_interrupt() && softirq_pending_enabled())) {
+	if (unlikely(softirq_pending_enabled())) {
 		/*
 		 * Run softirq if any pending. And do it in its own stack
 		 * as we may be calling this deep in a task call stack already.
@@ -388,7 +388,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 	lockdep_softirq_end(in_hardirq);
 	account_irq_exit_time(current);
 	__local_bh_enable_no_softirq(SOFTIRQ_OFFSET);
-	WARN_ON_ONCE(in_interrupt());
+	WARN_ON_ONCE(in_irq());
 	current_restore_flags(old_flags, PF_MEMALLOC);
 }
 
@@ -397,7 +397,7 @@ asmlinkage __visible void do_softirq(void)
 	__u32 pending;
 	unsigned long flags;
 
-	if (in_interrupt())
+	if (in_irq())
 		return;
 
 	local_irq_save(flags);
@@ -480,7 +480,7 @@ void irq_exit(void)
 #endif
 	account_irq_exit_time(current);
 	preempt_count_sub(HARDIRQ_OFFSET);
-	if (!in_interrupt() && softirq_pending_enabled())
+	if (!in_irq() && softirq_pending_enabled())
 		invoke_softirq();
 
 	tick_irq_exit();
@@ -504,7 +504,7 @@ inline void raise_softirq_irqoff(unsigned int nr)
 	 * Otherwise we wake up ksoftirqd to make sure we
 	 * schedule the softirq soon.
 	 */
-	if (!in_interrupt())
+	if (!in_irq())
 		wakeup_softirqd();
 }
 
-- 
2.17.1

