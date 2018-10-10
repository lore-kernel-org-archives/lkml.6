Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E44C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 440B32087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOAVb9W5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 440B32087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbeJKGiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 02:38:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:36478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727691AbeJKGiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 02:38:14 -0400
Received: from lerouge.suse.de (LFbn-NCY-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B9ED2150C;
        Wed, 10 Oct 2018 23:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539213232;
        bh=mREl0F64l1DcezjL7CWP/q16Hm49wIRPeAkvn0EubGc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IOAVb9W51zmMM6HgXwkgY5xO3a2TIJMhL8D19ruWleRJ8jd4U7apn92Tldmc1LWnS
         U4Tq8aVj75vk+6PIBAT8lB+NoFnCNe28e5tyKi3H3sZKIQ4fpDcCK7xSCRSAA4qymH
         6Dw1DgEoM/zCTEfuV8vlrjdtkN1fFOWB10fjHHn8=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [RFC PATCH 26/30] softirq: Increment the softirq offset on top of enabled bits
Date:   Thu, 11 Oct 2018 01:12:13 +0200
Message-Id: <1539213137-13953-27-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539213137-13953-1-git-send-email-frederic@kernel.org>
References: <1539213137-13953-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now we can rely on the vector enabled bits to know if some vector is
disabled. Hence we can also now drive the softirq offset on top of it.

As a result, the softirq offset don't need to nest anymore as the vector
enable mask does it on the stack on its behalf:

	// Start with local_bh_disabled() == SOFTIRQ_ALL_MASK
	...
	bh = local_bh_disable(BIT(NET_RX_SOFTIRQ)) {
		bh = local_bh_disabled();
		local_bh_disabled() &= ~BIT(NET_RX_SOFTIRQ);
		// First vector disabled, inc preempt count
		preempt_count += SOFTIRQ_DISABLE_OFFSET;
		return bh;
	}
	....
		bh2 = local_bh_disable(BIT(BLOCK_SOFTIRQ)) {
			bh2 = local_bh_disabled();
			local_bh_disabled() &= ~BIT(NET_RX_SOFTIRQ);
			// No need to inc preempt count
			return bh2;
		}
		...
		local_bh_enable(bh2) {
			local_bh_disabled() = bh2;
			// No need to dec preempt count
		}
		...
	local_bh_enable(bh1) {
		local_bh_disabled() = bh;
		preempt_count -= SOFTIRQ_DISABLE_OFFSET;
	}

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/softirq.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index e2435b0..84da16c 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -117,6 +117,10 @@ unsigned int __local_bh_disable_ip(unsigned long ip, unsigned int cnt,
 
 	raw_local_irq_save(flags);
 
+	enabled = local_softirq_enabled();
+	if (enabled != SOFTIRQ_ALL_MASK)
+		cnt &= ~SOFTIRQ_MASK;
+
 	/*
 	 * The preempt tracer hooks into preempt_count_add and will break
 	 * lockdep because it calls back into lockdep after SOFTIRQ_OFFSET
@@ -131,7 +135,6 @@ unsigned int __local_bh_disable_ip(unsigned long ip, unsigned int cnt,
 	if (softirq_count() == (cnt & SOFTIRQ_MASK))
 		trace_softirqs_off(ip);
 
-	enabled = local_softirq_enabled();
 	softirq_enabled_nand(mask);
 	raw_local_irq_restore(flags);
 
@@ -157,6 +160,9 @@ void local_bh_enable_no_softirq(unsigned int bh)
 
 	softirq_enabled_set(bh);
 
+	if (bh != SOFTIRQ_ALL_MASK)
+		return;
+			
 	if (preempt_count() == SOFTIRQ_DISABLE_OFFSET)
 		trace_preempt_on(CALLER_ADDR0, get_lock_parent_ip());
 
@@ -175,18 +181,18 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt, unsigned int bh)
 	local_irq_disable();
 #endif
 	softirq_enabled_set(bh);
-
-	/*
-	 * Are softirqs going to be turned on now:
-	 */
-	if (softirq_count() == SOFTIRQ_DISABLE_OFFSET)
+	if (bh != SOFTIRQ_ALL_MASK) {
+		cnt &= ~SOFTIRQ_MASK;
+	} else if (!(softirq_count() & SOFTIRQ_OFFSET)) {
+		/* Are softirqs going to be turned on now: */
 		trace_softirqs_on(ip);
+	}
 	/*
 	 * Keep preemption disabled until we are done with
 	 * softirq processing:
 	 */
-	preempt_count_sub(cnt - 1);
-
+	if (cnt)
+		preempt_count_sub(cnt - 1);
 
 	if (unlikely(!in_interrupt() && local_softirq_pending())) {
 		/*
@@ -196,7 +202,8 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt, unsigned int bh)
 		do_softirq();
 	}
 
-	preempt_count_dec();
+	if (cnt)
+		preempt_count_dec();
 #ifdef CONFIG_TRACE_IRQFLAGS
 	local_irq_enable();
 #endif
-- 
2.7.4

