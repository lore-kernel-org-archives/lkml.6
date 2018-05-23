Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754176AbeEWGjR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 02:39:17 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:40206 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753902AbeEWGif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 02:38:35 -0400
X-Google-Smtp-Source: AB8JxZoHRx/3mE2XIsSXX/H0+uuUl63jD14yLJIWDRjhA9PDAK6gqFspD6Y4wWBk0FSyelbkWC5xnA==
From: Joel Fernandes <joelaf@google.com>
X-Google-Original-From: Joel Fernandes <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>, byungchul.park@lge.com,
        Ingo Molnar <mingo@redhat.com>, Josh Triplett <josh@joshtriplett.org>,
        kernel-team@android.com, Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zilstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 2/4] rcu: Add comment documenting how rcu_seq_snap works
Date: Tue, 22 May 2018 23:38:13 -0700
Message-Id: <20180523063815.198302-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180523063815.198302-1-joel@joelfernandes.org>
References: <20180523063815.198302-1-joel@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

rcu_seq_snap may be tricky to decipher. Lets document how it works with
an example to make it easier.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/rcu.h | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 0453a7d12b3f..5819a37f19fb 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -91,7 +91,39 @@ static inline void rcu_seq_end(unsigned long *sp)
 	WRITE_ONCE(*sp, rcu_seq_endval(sp));
 }
 
-/* Take a snapshot of the update side's sequence number. */
+/*
+ * rcu_seq_snap - Take a snapshot of the update side's sequence number.
+ *
+ * This function returns the earliest value of the grace-period sequence number
+ * that will indicate that a full grace period has elapsed since the current
+ * time.  Once the grace-period sequence number has reached this value, it will
+ * be safe to invoke all callbacks that have been registered prior to the
+ * current time. This value is the current grace-period number plus two to the
+ * power of the number of low-order bits reserved for state, then rounded up to
+ * the next value in which the state bits are all zero.
+ *
+ * In the current design, RCU_SEQ_STATE_MASK=3 and the least significant bit of
+ * the seq is used to track if a GP is in progress or not. Given this, it is
+ * sufficient if we add (6+1) and mask with ~3 to get the next GP. Let's see
+ * why with an example:
+ *
+ * Say the current seq is 12 which is 0b1100 (GP is 3 and state bits are 0b00).
+ * To get to the next GP number of 4, we have to add 0b100 to this (0x1 << 2)
+ * to account for the shift due to 2 state bits. Now, if the current seq is
+ * 13 (GP is 3 and state bits are 0b01), then it means the current grace period
+ * is already in progress so the next GP that a future call back will be queued
+ * to run at is GP+2 = 5, not 4. To account for the extra +1, we just overflow
+ * the 2 lower bits by adding 0b11. In case the lower bit was set, the overflow
+ * will cause the extra +1 to the GP, along with the usual +1 explained before.
+ * This gives us GP+2. Finally we mask the lower to bits by ~0x3 in case the
+ * overflow didn't occur. This masking is needed because in case RCU was idle
+ * (no GP in progress so lower 2 bits are 0b00), then the overflow of the lower
+ * 2 state bits wouldn't occur, so we mask to zero out those lower 2 bits.
+ *
+ * In other words, the next seq can be obtained by (0b11 + 0b100) & (~0b11)
+ * which can be generalized to:
+ * seq + (RCU_SEQ_STATE_MASK + (RCU_SEQ_STATE_MASK + 1)) & (~RCU_SEQ_STATE_MASK)
+ */
 static inline unsigned long rcu_seq_snap(unsigned long *sp)
 {
 	unsigned long s;
-- 
2.17.0.441.gb46fe60e1d-goog
