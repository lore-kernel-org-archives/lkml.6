Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0A1C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C0AA21B25
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549991710;
	bh=RhuWnXAn0EdfeCviTh0t+yOoxSaf7+q2SmT7Tj0Yr04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ogE3/Kq7tUNSdaXgjhDZ6xw5mes8jRP10/6bTN89Y5Ysx/qcxsdVKV6I8TzFyS1gR
	 03u2ekw3MqgPeMXE9+00AZX92awYFZ9rDJK4PFdXT4w3CKHv2pxsoUIMDkCdgWaKDu
	 piAZwHpoag2DF1qP7fdmpYLk9LQtYOK1Hmid7edw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731476AbfBLRPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:15:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:57656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731452AbfBLRPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:15:06 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54D38218FE;
        Tue, 12 Feb 2019 17:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549991706;
        bh=RhuWnXAn0EdfeCviTh0t+yOoxSaf7+q2SmT7Tj0Yr04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Etu0IPeOA8+dzqBm+PgNXSXkc9Lgr85bFc3AWpbcvsz4xMg5YPfvse7ux5frtUnbL
         aEsFh1GFtzpp4dUYlJ+sZNzSMnUMM749dmVa2t3ObozYElqsi6q0o6EAGd9GYcEZ8Y
         2xozLFl7JfOx6YjvxPx854GKBELjHtUipfrvWswc=
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
Subject: [PATCH 11/32] softirq: Macrofy softirq vectors
Date:   Tue, 12 Feb 2019 18:14:02 +0100
Message-Id: <20190212171423.8308-12-frederic@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212171423.8308-1-frederic@kernel.org>
References: <20190212171423.8308-1-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define the softirq vectors through macros so that we can later include
them in the automated definition of lockdep usage states.

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
 include/linux/interrupt.h      | 17 ++++-------------
 include/linux/softirq_vector.h | 10 ++++++++++
 2 files changed, 14 insertions(+), 13 deletions(-)
 create mode 100644 include/linux/softirq_vector.h

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index c672f34235e7..e871f361f1f1 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -474,21 +474,12 @@ extern bool force_irqthreads;
    tasklets are more than enough. F.e. all serial device BHs et
    al. should be converted to tasklets, not to softirqs.
  */
-
 enum
 {
-	HI_SOFTIRQ=0,
-	TIMER_SOFTIRQ,
-	NET_TX_SOFTIRQ,
-	NET_RX_SOFTIRQ,
-	BLOCK_SOFTIRQ,
-	IRQ_POLL_SOFTIRQ,
-	TASKLET_SOFTIRQ,
-	SCHED_SOFTIRQ,
-	HRTIMER_SOFTIRQ, /* Unused, but kept as tools rely on the
-			    numbering. Sigh! */
-	RCU_SOFTIRQ,    /* Preferable RCU should always be the last softirq */
-
+#define SOFTIRQ_VECTOR(__SVEC) \
+	__SVEC##_SOFTIRQ,
+#include <linux/softirq_vector.h>
+#undef SOFTIRQ_VECTOR
 	NR_SOFTIRQS
 };
 
diff --git a/include/linux/softirq_vector.h b/include/linux/softirq_vector.h
new file mode 100644
index 000000000000..949720c866fd
--- /dev/null
+++ b/include/linux/softirq_vector.h
@@ -0,0 +1,10 @@
+SOFTIRQ_VECTOR(HI)
+SOFTIRQ_VECTOR(TIMER)
+SOFTIRQ_VECTOR(NET_TX)
+SOFTIRQ_VECTOR(NET_RX)
+SOFTIRQ_VECTOR(BLOCK)
+SOFTIRQ_VECTOR(IRQ_POLL)
+SOFTIRQ_VECTOR(TASKLET)
+SOFTIRQ_VECTOR(SCHED)
+SOFTIRQ_VECTOR(HRTIMER)
+SOFTIRQ_VECTOR(RCU)    /* Preferable RCU should always be the last softirq */
-- 
2.17.1

