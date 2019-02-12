Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5E4C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31FE62229E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549991714;
	bh=LxntLlQVAJRc7s0Gg6lA4uLEAq8+USz2njra66a+pRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=InhU/JfD5MTGLTsofKY+Fw0Hf061IjvRC9c0NRTPaf5PyFBrSwBwjx1IXeNU9X97e
	 uOVXkYcDeSx1thAf2WbysD5YWY50xvep8iWB+9tYOG81GtpngdhkUs7ZyFVxObF+Gg
	 HuCbC8f/VNRT1FqpQJBWco0YVq8s6nTu9w4ci5S4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731490AbfBLRPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:15:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:57726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731452AbfBLRPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:15:10 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87B56218E0;
        Tue, 12 Feb 2019 17:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549991709;
        bh=LxntLlQVAJRc7s0Gg6lA4uLEAq8+USz2njra66a+pRE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bc45kH8duBK48Kz6/eDoL42++wh4MbSS9mUata9L82EKVGOEZcq52IuBSfLCtHGoo
         gohnqhhhzjy684+9liAn/MtKf94harCmrga7HqgrLmaPkNsS1ugN8cyHY6EiO3Ku1E
         IowdPatCYqgTPEGnRbMO3JU3lniOsI7d29Z16zLQ=
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
Subject: [PATCH 12/32] locking/lockdep: Define per vector softirq lock usage states
Date:   Tue, 12 Feb 2019 18:14:03 +0100
Message-Id: <20190212171423.8308-13-frederic@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212171423.8308-1-frederic@kernel.org>
References: <20190212171423.8308-1-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the code is mostly ready to play at this finegrained level,
reuse the macrofied vector list to define the usual 4 lock usage states
for each softirq vectors. This way we can perform the validations
independently for each of them.

The new usage mask layout becomes:

                              TIMER_SOFTIRQ
            LOCK_USED             bits       HARDIRQ bits
                \                   |            |
                 \                  |            |
                  0   0000  [...]  0000  0000  0000
                        |                  |
                        |                  |
                   RCU_SOFTIRQ        HI_SOFTIRQ bits
                      bits

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
 kernel/locking/lockdep_internals.h | 43 +++++++++++++++++++++++++++---
 kernel/locking/lockdep_states.h    |  4 ++-
 2 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index e714c823f594..4b0c03f0f7ce 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -22,9 +22,15 @@ enum lock_usage_bit {
 	LOCK_USAGE_STATES
 };
 
-#define LOCK_USAGE_READ_MASK 1
-#define LOCK_USAGE_DIR_MASK  2
-#define LOCK_USAGE_STATE_MASK (~(LOCK_USAGE_READ_MASK | LOCK_USAGE_DIR_MASK))
+#define LOCK_USAGE_READ_MASK		1
+#define LOCK_USAGE_DIR_MASK 		2
+#define LOCK_USAGE_STATE_MASK		(~(LOCK_USAGE_READ_MASK | LOCK_USAGE_DIR_MASK))
+
+/* Base softirq bits that get shifted by the index in stuct lock_usage::vector */
+#define LOCK_USED_IN_SOFTIRQ		LOCK_USED_IN_HI_SOFTIRQ
+#define LOCK_USED_IN_SOFTIRQ_READ	LOCK_USED_IN_HI_SOFTIRQ_READ
+#define LOCK_ENABLED_SOFTIRQ		LOCK_ENABLED_HI_SOFTIRQ
+#define LOCK_ENABLED_SOFTIRQ_READ	LOCK_ENABLED_HI_SOFTIRQ_READ
 
 struct lock_usage {
 	enum lock_usage_bit bit;
@@ -35,7 +41,7 @@ struct lock_usage {
 /*
  * Usage-state bitmasks:
  */
-#define __LOCKF(__STATE)	LOCKF_##__STATE = (1 << LOCK_##__STATE),
+#define __LOCKF(__STATE)	LOCKF_##__STATE = (1ULL << LOCK_##__STATE),
 
 enum {
 #define LOCKDEP_STATE(__STATE)						\
@@ -48,11 +54,40 @@ enum {
 	__LOCKF(USED)
 };
 
+#define LOCKF_ENABLED_SOFTIRQ \
+	(LOCKF_ENABLED_HI_SOFTIRQ | LOCKF_ENABLED_TIMER_SOFTIRQ | \
+	LOCKF_ENABLED_NET_TX_SOFTIRQ | LOCKF_ENABLED_NET_RX_SOFTIRQ | \
+	LOCKF_ENABLED_BLOCK_SOFTIRQ | LOCKF_ENABLED_IRQ_POLL_SOFTIRQ | \
+	LOCKF_ENABLED_TASKLET_SOFTIRQ | LOCKF_ENABLED_SCHED_SOFTIRQ | \
+	 LOCKF_ENABLED_HRTIMER_SOFTIRQ | LOCKF_ENABLED_RCU_SOFTIRQ)
 #define LOCKF_ENABLED_IRQ (LOCKF_ENABLED_HARDIRQ | LOCKF_ENABLED_SOFTIRQ)
+
+
+#define LOCKF_USED_IN_SOFTIRQ \
+	(LOCKF_USED_IN_HI_SOFTIRQ | LOCKF_USED_IN_TIMER_SOFTIRQ | \
+	LOCKF_USED_IN_NET_TX_SOFTIRQ | LOCKF_USED_IN_NET_RX_SOFTIRQ | \
+	LOCKF_USED_IN_BLOCK_SOFTIRQ | LOCKF_USED_IN_IRQ_POLL_SOFTIRQ | \
+	LOCKF_USED_IN_TASKLET_SOFTIRQ | LOCKF_USED_IN_SCHED_SOFTIRQ | \
+	 LOCKF_USED_IN_HRTIMER_SOFTIRQ | LOCKF_USED_IN_RCU_SOFTIRQ)
 #define LOCKF_USED_IN_IRQ (LOCKF_USED_IN_HARDIRQ | LOCKF_USED_IN_SOFTIRQ)
 
+
+#define LOCKF_ENABLED_SOFTIRQ_READ \
+	(LOCKF_ENABLED_HI_SOFTIRQ_READ | LOCKF_ENABLED_TIMER_SOFTIRQ_READ | \
+	LOCKF_ENABLED_NET_TX_SOFTIRQ_READ | LOCKF_ENABLED_NET_RX_SOFTIRQ_READ | \
+	LOCKF_ENABLED_BLOCK_SOFTIRQ_READ | LOCKF_ENABLED_IRQ_POLL_SOFTIRQ_READ | \
+	LOCKF_ENABLED_TASKLET_SOFTIRQ_READ | LOCKF_ENABLED_SCHED_SOFTIRQ_READ | \
+	 LOCKF_ENABLED_HRTIMER_SOFTIRQ_READ | LOCKF_ENABLED_RCU_SOFTIRQ_READ)
 #define LOCKF_ENABLED_IRQ_READ \
 		(LOCKF_ENABLED_HARDIRQ_READ | LOCKF_ENABLED_SOFTIRQ_READ)
+
+
+#define LOCKF_USED_IN_SOFTIRQ_READ \
+	(LOCKF_USED_IN_HI_SOFTIRQ_READ | LOCKF_USED_IN_TIMER_SOFTIRQ_READ | \
+	LOCKF_USED_IN_NET_TX_SOFTIRQ_READ | LOCKF_USED_IN_NET_RX_SOFTIRQ_READ | \
+	LOCKF_USED_IN_BLOCK_SOFTIRQ_READ | LOCKF_USED_IN_IRQ_POLL_SOFTIRQ_READ | \
+	LOCKF_USED_IN_TASKLET_SOFTIRQ_READ | LOCKF_USED_IN_SCHED_SOFTIRQ_READ | \
+	 LOCKF_USED_IN_HRTIMER_SOFTIRQ_READ | LOCKF_USED_IN_RCU_SOFTIRQ_READ)
 #define LOCKF_USED_IN_IRQ_READ \
 		(LOCKF_USED_IN_HARDIRQ_READ | LOCKF_USED_IN_SOFTIRQ_READ)
 
diff --git a/kernel/locking/lockdep_states.h b/kernel/locking/lockdep_states.h
index 35ca09f2ed0b..34ff569d2024 100644
--- a/kernel/locking/lockdep_states.h
+++ b/kernel/locking/lockdep_states.h
@@ -5,4 +5,6 @@
  * you add one, or come up with a nice dynamic solution.
  */
 LOCKDEP_STATE(HARDIRQ)
-LOCKDEP_STATE(SOFTIRQ)
+#define SOFTIRQ_VECTOR(__SVEC) LOCKDEP_STATE(__SVEC##_SOFTIRQ)
+#include <linux/softirq_vector.h>
+#undef SOFTIRQ_VECTOR
-- 
2.17.1

