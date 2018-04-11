Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753692AbeDKNsL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 09:48:11 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:46461 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752178AbeDKNsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 09:48:06 -0400
X-Google-Smtp-Source: AIpwx4+KC8+H/JTIjlsX/4XxPcoIep3SXceLoTEr+jW4NKnjG8fCEtc8lXIM4/xHX1SG2GVubgj4Sg==
X-ME-Sender: <xms:EhLOWnA5ZNm6Qi5K5a0QRPSyP0FMqdwB5d18-dPg7V-QQSOJvXFpYg>
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC tip/locking/lockdep v6 15/20] lockdep/selftest: Unleash irq_read_recursion2 and add more
Date: Wed, 11 Apr 2018 21:51:05 +0800
Message-Id: <20180411135110.9217-16-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180411135110.9217-1-boqun.feng@gmail.com>
References: <20180411135110.9217-1-boqun.feng@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now since we can handle recursive read related irq inversion deadlocks
correctly, uncomment the irq_read_recursion2 and add more testcases.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 lib/locking-selftest.c | 59 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 47 insertions(+), 12 deletions(-)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 700f9aa19db6..c2f06b423da8 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -1052,20 +1052,28 @@ GENERATE_PERMUTATIONS_3_EVENTS(irq_inversion_soft_wlock)
 #define E3()				\
 					\
 	IRQ_ENTER();			\
-	RL(A);				\
+	LOCK(A);			\
 	L(B);				\
 	U(B);				\
-	RU(A);				\
+	UNLOCK(A);			\
 	IRQ_EXIT();
 
 /*
- * Generate 12 testcases:
+ * Generate 24 testcases:
  */
 #include "locking-selftest-hardirq.h"
-GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion_hard)
+#include "locking-selftest-rlock.h"
+GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion_hard_rlock)
+
+#include "locking-selftest-wlock.h"
+GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion_hard_wlock)
 
 #include "locking-selftest-softirq.h"
-GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion_soft)
+#include "locking-selftest-rlock.h"
+GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion_soft_rlock)
+
+#include "locking-selftest-wlock.h"
+GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion_soft_wlock)
 
 #undef E1
 #undef E2
@@ -1079,8 +1087,8 @@ GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion_soft)
 					\
 	IRQ_DISABLE();			\
 	L(B);				\
-	WL(A);				\
-	WU(A);				\
+	LOCK(A);			\
+	UNLOCK(A);			\
 	U(B);				\
 	IRQ_ENABLE();
 
@@ -1097,13 +1105,21 @@ GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion_soft)
 	IRQ_EXIT();
 
 /*
- * Generate 12 testcases:
+ * Generate 24 testcases:
  */
 #include "locking-selftest-hardirq.h"
-// GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion2_hard)
+#include "locking-selftest-rlock.h"
+GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion2_hard_rlock)
+
+#include "locking-selftest-wlock.h"
+GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion2_hard_wlock)
 
 #include "locking-selftest-softirq.h"
-// GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion2_soft)
+#include "locking-selftest-rlock.h"
+GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion2_soft_rlock)
+
+#include "locking-selftest-wlock.h"
+GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion2_soft_wlock)
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 # define I_SPINLOCK(x)	lockdep_reset_lock(&lock_##x.dep_map)
@@ -1256,6 +1272,25 @@ static inline void print_testname(const char *testname)
 	dotest(name##_rlock_##nr, SUCCESS, LOCKTYPE_RWLOCK);	\
 	pr_cont("\n");
 
+#define DO_TESTCASE_2RW(desc, name, nr)				\
+	print_testname(desc"/"#nr);				\
+	pr_cont("      |");					\
+	dotest(name##_wlock_##nr, FAILURE, LOCKTYPE_RWLOCK);	\
+	dotest(name##_rlock_##nr, SUCCESS, LOCKTYPE_RWLOCK);	\
+	pr_cont("\n");
+
+#define DO_TESTCASE_2x2RW(desc, name, nr)			\
+	DO_TESTCASE_2RW("hard-"desc, name##_hard, nr)		\
+	DO_TESTCASE_2RW("soft-"desc, name##_soft, nr)		\
+
+#define DO_TESTCASE_6x2x2RW(desc, name)				\
+	DO_TESTCASE_2x2RW(desc, name, 123);			\
+	DO_TESTCASE_2x2RW(desc, name, 132);			\
+	DO_TESTCASE_2x2RW(desc, name, 213);			\
+	DO_TESTCASE_2x2RW(desc, name, 231);			\
+	DO_TESTCASE_2x2RW(desc, name, 312);			\
+	DO_TESTCASE_2x2RW(desc, name, 321);
+
 #define DO_TESTCASE_6(desc, name)				\
 	print_testname(desc);					\
 	dotest(name##_spin, FAILURE, LOCKTYPE_SPIN);		\
@@ -2114,8 +2149,8 @@ void locking_selftest(void)
 	DO_TESTCASE_6x6("safe-A + unsafe-B #2", irqsafe4);
 	DO_TESTCASE_6x6RW("irq lock-inversion", irq_inversion);
 
-	DO_TESTCASE_6x2("irq read-recursion", irq_read_recursion);
-//	DO_TESTCASE_6x2B("irq read-recursion #2", irq_read_recursion2);
+	DO_TESTCASE_6x2x2RW("irq read-recursion", irq_read_recursion);
+	DO_TESTCASE_6x2x2RW("irq read-recursion #2", irq_read_recursion2);
 
 	ww_tests();
 
-- 
2.16.2
