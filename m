Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753577AbeDKNxQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 09:53:16 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:45068 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751983AbeDKNxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 09:53:14 -0400
X-Google-Smtp-Source: AIpwx4+LlXWVkQCz9wLbqdz0UY783joBRO4nJOFdCQ5ILZFI9yKZu/KqUQXP+8A+FpGXM8hCcfsbbg==
X-ME-Sender: <xms:SBPOWglZvhP7DHvgkHibvVbJmnEFiAHeR7UqkBSdHx6iTcC-IP0Wkg>
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC tip/locking/lockdep v6 20/20] lockdep/selftest: Add a test case for SRCU
Date: Wed, 11 Apr 2018 21:57:18 +0800
Message-Id: <20180411135721.22723-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180411135110.9217-1-boqun.feng@gmail.com>
References: <20180411135110.9217-1-boqun.feng@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we now could detect deadlock cases for sleepable RCU, a self test
case is added. More other complex scenarios may be added later to
srcu_tests().

Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 lib/locking-selftest.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 79270288fa28..5756ca1827e2 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -49,6 +49,7 @@ __setup("debug_locks_verbose=", setup_debug_locks_verbose);
 #define LOCKTYPE_RWSEM	0x8
 #define LOCKTYPE_WW	0x10
 #define LOCKTYPE_RTMUTEX 0x20
+#define LOCKTYPE_SRCU	0x40
 
 static struct ww_acquire_ctx t, t2;
 static struct ww_mutex o, o2, o3;
@@ -86,6 +87,11 @@ static DEFINE_RT_MUTEX(rtmutex_D);
 
 #endif
 
+#ifdef CONFIG_SRCU
+static struct srcu_struct srcu_A;
+static struct srcu_struct srcu_B;
+#endif
+
 /*
  * Locks that we initialize dynamically as well so that
  * e.g. X1 and X2 becomes two instances of the same class,
@@ -163,6 +169,11 @@ static void init_shared_classes(void)
 	__rt_mutex_init(&rtmutex_Z2, __func__, &rt_Z);
 #endif
 
+#ifdef CONFIG_SRCU
+	init_srcu_struct(&srcu_A);
+	init_srcu_struct(&srcu_B);
+#endif
+
 	init_class_X(&lock_X1, &rwlock_X1, &mutex_X1, &rwsem_X1);
 	init_class_X(&lock_X2, &rwlock_X2, &mutex_X2, &rwsem_X2);
 
@@ -2200,6 +2211,30 @@ static void ww_tests(void)
 	pr_cont("\n");
 }
 
+static void srcu_ABBA(void)
+{
+	int ia, ib;
+
+	ia = srcu_read_lock(&srcu_A);
+	synchronize_srcu(&srcu_B);
+	srcu_read_unlock(&srcu_A, ia);
+
+	ib = srcu_read_lock(&srcu_B);
+	synchronize_srcu(&srcu_A);
+	srcu_read_unlock(&srcu_B, ib); // should fail
+}
+
+static void srcu_tests(void)
+{
+	printk("  --------------------------------------------------------------------------\n");
+	printk("  | SRCU tests |\n");
+	printk("  ---------------\n");
+	print_testname("ABBA read-sync/read-sync");
+	dotest(srcu_ABBA, FAILURE, LOCKTYPE_SRCU);
+	pr_cont("\n");
+}
+
+
 void locking_selftest(void)
 {
 	/*
@@ -2306,6 +2341,7 @@ void locking_selftest(void)
 	DO_TESTCASE_6x2x2RW("irq read-recursion #2", irq_read_recursion2);
 
 	ww_tests();
+	srcu_tests();
 
 	if (unexpected_testcase_failures) {
 		printk("-----------------------------------------------------------------\n");
-- 
2.16.2
