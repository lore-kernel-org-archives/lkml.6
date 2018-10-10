Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4595CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF84F214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rzm/HOCQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF84F214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbeJKGhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 02:37:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:35550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727181AbeJKGhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 02:37:23 -0400
Received: from lerouge.suse.de (LFbn-NCY-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6A8E21528;
        Wed, 10 Oct 2018 23:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539213182;
        bh=PAxRwkEKHEF+hqaxVhR+NiJSRGpcJz+aaMYh0mFiQAQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rzm/HOCQiHfw2EZlq3Ipp0F18UjaNvH8NRYNSHFg5Skn2anuOd3/TD4+6Cl/nhzGS
         frT7aAgtlofemNODjYIkVxUV6qmkLZwaqImvBRFbvhuw6Zf+EdXp0lDp5LGP6pjvxn
         Tfk1EwHJY2Qr13Lcimd8BrQTjHdWY4Bmat3/Cjw4=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [RFC PATCH 10/30] softirq: Check enabled bits on the softirq loop
Date:   Thu, 11 Oct 2018 01:11:57 +0200
Message-Id: <1539213137-13953-11-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539213137-13953-1-git-send-email-frederic@kernel.org>
References: <1539213137-13953-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Weisbecker <fweisbec@gmail.com>

Check the enabled vector bits on softirq processing. Those that are
pending but disabled will be ignored and handled by the interrupted code
that disabled those vectors.

No effective change yet as the core isn't yet ready for softirq
re-entrancy. All softirqs should be enabled all the time for now and
driven through preempt_count().

Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/softirq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index fdb2574..75aab25 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -263,7 +263,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 	 */
 	current->flags &= ~PF_MEMALLOC;
 
-	pending = local_softirq_pending();
+	pending = local_softirq_pending() & local_softirq_enabled();
 	account_irq_enter_time(current);
 
 	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
@@ -271,7 +271,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 
 restart:
 	/* Reset the pending bitmask before enabling irqs */
-	softirq_pending_nand(SOFTIRQ_ALL_MASK);
+	softirq_pending_nand(pending);
 
 	local_irq_enable();
 
@@ -304,7 +304,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 	rcu_bh_qs();
 	local_irq_disable();
 
-	pending = local_softirq_pending();
+	pending = local_softirq_pending() & local_softirq_enabled();
 	if (pending) {
 		if (time_before(jiffies, end) && !need_resched() &&
 		    --max_restart)
-- 
2.7.4

