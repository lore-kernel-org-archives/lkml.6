Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD21C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C9EE217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549991684;
	bh=xAGDWFj/dFtqmjHBltcCceZ3Na1fBQDdFhsry6DV938=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PiqlComTH8Wuzger7bKnMfueRzvk7SaIY/I1ypnpz1zOnqsBdR9356oKsl5VQXocA
	 ucJIJnaB/e4PXlW02SeUckqZVj4Mf579nzbNO7nIGnjrGtFgck7DceifZpNLxcxRdO
	 fciqOBwpTNwfwG3vmuegEwdt8XB+zMVxbb/Pkyco=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731378AbfBLROm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:14:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:57048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728686AbfBLROk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:14:40 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58FCA2184E;
        Tue, 12 Feb 2019 17:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549991680;
        bh=xAGDWFj/dFtqmjHBltcCceZ3Na1fBQDdFhsry6DV938=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S6rGNbOXepWJDi0MhD+2bqPZlRfdFDvoD9izzfPobjPt+holP0Pv9iBn9c/9rgfX9
         lDck+D696xTN51q5fQPUENhCejNIeJ3dMzSOype6iZ60gSdCz9O9KYMm+Jy/b4+E7M
         j1GzTUZAZGfzU+3180AkEszmYYqK0/OGILRGUSfU=
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
Subject: [PATCH 03/32] locking/lockdep: Convert usage_mask to u64
Date:   Tue, 12 Feb 2019 18:13:54 +0100
Message-Id: <20190212171423.8308-4-frederic@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212171423.8308-1-frederic@kernel.org>
References: <20190212171423.8308-1-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The usage mask is going to expand to validate softirq related usages in
a per-vector finegrained way.

The current bitmap layout is:

                  LOCK_USED        HARDIRQ bits
                        \            /
                         \          /
                          0  0000  0000
                               |
                               |
                          SOFTIRQ bits

The new one will be:

                                  TIMER_SOFTIRQ
                 LOCK_USED            bits       HARDIRQ bits
                     \                  |            |
                      \                 |            |
                      0   0000  [...]  0000  0000  0000
                            |                  |
                            |                  |
                       RCU_SOFTIRQ        HI_SOFTIRQ bits
                          bits

So we have 4 hardirq bits + NR_SOFTIRQS * 4 + 1 bit (LOCK_USED) = 45
bits. Therefore we need a 64 bits mask.

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
 include/linux/lockdep.h  | 2 +-
 kernel/locking/lockdep.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index c5335df2372f..06669f20a30a 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -83,7 +83,7 @@ struct lock_class {
 	/*
 	 * IRQ/softirq usage tracking bits:
 	 */
-	unsigned long			usage_mask;
+	u64				usage_mask;
 	struct stack_trace		usage_traces[XXX_LOCK_USAGE_STATES];
 
 	/*
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 1bb955d22eae..a977aa5976b7 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -463,9 +463,9 @@ const char * __get_key_name(struct lockdep_subclass_key *key, char *str)
 	return kallsyms_lookup((unsigned long)key, NULL, NULL, NULL, str);
 }
 
-static inline unsigned long lock_flag(enum lock_usage_bit bit)
+static inline u64 lock_flag(enum lock_usage_bit bit)
 {
-	return 1UL << bit;
+	return BIT_ULL(bit);
 }
 
 static char get_usage_char(struct lock_class *class, enum lock_usage_bit bit)
@@ -1400,7 +1400,7 @@ static void print_lock_class_header(struct lock_class *class, int depth)
 	printk(KERN_CONT " {\n");
 
 	for (bit = 0; bit < LOCK_USAGE_STATES; bit++) {
-		if (class->usage_mask & (1 << bit)) {
+		if (class->usage_mask & lock_flag(bit)) {
 			int len = depth;
 
 			len += printk("%*s   %s", depth, "", usage_str[bit]);
@@ -2478,7 +2478,7 @@ static inline int
 valid_state(struct task_struct *curr, struct held_lock *this,
 	    enum lock_usage_bit new_bit, enum lock_usage_bit bad_bit)
 {
-	if (unlikely(hlock_class(this)->usage_mask & (1 << bad_bit)))
+	if (unlikely(hlock_class(this)->usage_mask & lock_flag(bad_bit)))
 		return print_usage_bug(curr, this, bad_bit, new_bit);
 	return 1;
 }
-- 
2.17.1

