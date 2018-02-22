Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752853AbeBVHHt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 02:07:49 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37985 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752747AbeBVHGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 02:06:45 -0500
X-Google-Smtp-Source: AH8x224cl+DDxP4acHXMRfTCj/PXF2DMNw2Rs+xVpfjqDMIGR5ntxS6DnOVzIauVYqELlmO+GChiUA==
X-ME-Sender: <xms:AmyOWi0nsoeD2nj2UqX8u8xyvLKJ9q5Ry70wCKvKnp9PiXuf9yew-w>
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC tip/locking/lockdep v5 13/17] lockdep/selftest: Add more recursive read related test cases
Date: Thu, 22 Feb 2018 15:09:00 +0800
Message-Id: <20180222070904.548-14-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180222070904.548-1-boqun.feng@gmail.com>
References: <20180222070904.548-1-boqun.feng@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add those four test cases:

1.	X --(NR)--> Y --(NR)--> Z --(NR)--> X is deadlock.

2.	X --(NN)--> Y --(RR)--> Z --(NR)--> X is deadlock.

3.	X --(NN)--> Y --(RR)--> Z --(RN)--> X is not deadlock.

4.	X --(NR)--> Y --(RR)--> Z --(NN)--> X is not deadlock.

Those self testcases are valuable for the development of supporting
recursive read related deadlock detection.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 lib/locking-selftest.c | 161 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 161 insertions(+)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index c2f06b423da8..6b7a28d84fc4 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -1033,6 +1033,133 @@ GENERATE_PERMUTATIONS_3_EVENTS(irq_inversion_soft_wlock)
 #undef E2
 #undef E3
 
+/*
+ * write-read / write-read / write-read deadlock even if read is recursive
+ */
+
+#define E1()				\
+					\
+	WL(X1);				\
+	RL(Y1);				\
+	RU(Y1);				\
+	WU(X1);
+
+#define E2()				\
+					\
+	WL(Y1);				\
+	RL(Z1);				\
+	RU(Z1);				\
+	WU(Y1);
+
+#define E3()				\
+					\
+	WL(Z1);				\
+	RL(X1);				\
+	RU(X1);				\
+	WU(Z1);
+
+#include "locking-selftest-rlock.h"
+GENERATE_PERMUTATIONS_3_EVENTS(W1R2_W2R3_W3R1)
+
+#undef E1
+#undef E2
+#undef E3
+
+/*
+ * write-write / read-read / write-read deadlock even if read is recursive
+ */
+
+#define E1()				\
+					\
+	WL(X1);				\
+	WL(Y1);				\
+	WU(Y1);				\
+	WU(X1);
+
+#define E2()				\
+					\
+	RL(Y1);				\
+	RL(Z1);				\
+	RU(Z1);				\
+	RU(Y1);
+
+#define E3()				\
+					\
+	WL(Z1);				\
+	RL(X1);				\
+	RU(X1);				\
+	WU(Z1);
+
+#include "locking-selftest-rlock.h"
+GENERATE_PERMUTATIONS_3_EVENTS(W1W2_R2R3_W3R1)
+
+#undef E1
+#undef E2
+#undef E3
+
+/*
+ * write-write / read-read / read-write is not deadlock when read is recursive
+ */
+
+#define E1()				\
+					\
+	WL(X1);				\
+	WL(Y1);				\
+	WU(Y1);				\
+	WU(X1);
+
+#define E2()				\
+					\
+	RL(Y1);				\
+	RL(Z1);				\
+	RU(Z1);				\
+	RU(Y1);
+
+#define E3()				\
+					\
+	RL(Z1);				\
+	WL(X1);				\
+	WU(X1);				\
+	RU(Z1);
+
+#include "locking-selftest-rlock.h"
+GENERATE_PERMUTATIONS_3_EVENTS(W1R2_R2R3_W3W1)
+
+#undef E1
+#undef E2
+#undef E3
+
+/*
+ * write-read / read-read / write-write is not deadlock when read is recursive
+ */
+
+#define E1()				\
+					\
+	WL(X1);				\
+	RL(Y1);				\
+	RU(Y1);				\
+	WU(X1);
+
+#define E2()				\
+					\
+	RL(Y1);				\
+	RL(Z1);				\
+	RU(Z1);				\
+	RU(Y1);
+
+#define E3()				\
+					\
+	WL(Z1);				\
+	WL(X1);				\
+	WU(X1);				\
+	WU(Z1);
+
+#include "locking-selftest-rlock.h"
+GENERATE_PERMUTATIONS_3_EVENTS(W1W2_R2R3_R3W1)
+
+#undef E1
+#undef E2
+#undef E3
 /*
  * read-lock / write-lock recursion that is actually safe.
  */
@@ -1258,6 +1385,19 @@ static inline void print_testname(const char *testname)
 	dotest(name##_##nr, FAILURE, LOCKTYPE_RWLOCK);		\
 	pr_cont("\n");
 
+#define DO_TESTCASE_1RR(desc, name, nr)				\
+	print_testname(desc"/"#nr);				\
+	pr_cont("             |");				\
+	dotest(name##_##nr, SUCCESS, LOCKTYPE_RWLOCK);		\
+	pr_cont("\n");
+
+#define DO_TESTCASE_1RRB(desc, name, nr)			\
+	print_testname(desc"/"#nr);				\
+	pr_cont("             |");				\
+	dotest(name##_##nr, FAILURE, LOCKTYPE_RWLOCK);		\
+	pr_cont("\n");
+
+
 #define DO_TESTCASE_3(desc, name, nr)				\
 	print_testname(desc"/"#nr);				\
 	dotest(name##_spin_##nr, FAILURE, LOCKTYPE_SPIN);	\
@@ -1367,6 +1507,22 @@ static inline void print_testname(const char *testname)
 	DO_TESTCASE_2IB(desc, name, 312);			\
 	DO_TESTCASE_2IB(desc, name, 321);
 
+#define DO_TESTCASE_6x1RR(desc, name)				\
+	DO_TESTCASE_1RR(desc, name, 123);			\
+	DO_TESTCASE_1RR(desc, name, 132);			\
+	DO_TESTCASE_1RR(desc, name, 213);			\
+	DO_TESTCASE_1RR(desc, name, 231);			\
+	DO_TESTCASE_1RR(desc, name, 312);			\
+	DO_TESTCASE_1RR(desc, name, 321);
+
+#define DO_TESTCASE_6x1RRB(desc, name)				\
+	DO_TESTCASE_1RRB(desc, name, 123);			\
+	DO_TESTCASE_1RRB(desc, name, 132);			\
+	DO_TESTCASE_1RRB(desc, name, 213);			\
+	DO_TESTCASE_1RRB(desc, name, 231);			\
+	DO_TESTCASE_1RRB(desc, name, 312);			\
+	DO_TESTCASE_1RRB(desc, name, 321);
+
 #define DO_TESTCASE_6x6(desc, name)				\
 	DO_TESTCASE_6I(desc, name, 123);			\
 	DO_TESTCASE_6I(desc, name, 132);			\
@@ -2137,6 +2293,11 @@ void locking_selftest(void)
 	pr_cont("             |");
 	dotest(rlock_chaincache_ABBA1, FAILURE, LOCKTYPE_RWLOCK);
 
+	DO_TESTCASE_6x1RRB("rlock W1R2/W2R3/W3R1", W1R2_W2R3_W3R1);
+	DO_TESTCASE_6x1RRB("rlock W1W2/R2R3/W3R1", W1W2_R2R3_W3R1);
+	DO_TESTCASE_6x1RR("rlock W1W2/R2R3/R3W1", W1W2_R2R3_R3W1);
+	DO_TESTCASE_6x1RR("rlock W1R2/R2R3/W3W1", W1R2_R2R3_W3W1);
+
 	printk("  --------------------------------------------------------------------------\n");
 
 	/*
-- 
2.16.1
