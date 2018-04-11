Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753611AbeDKNsD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 09:48:03 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34195 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753353AbeDKNr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 09:47:59 -0400
X-Google-Smtp-Source: AIpwx4/neTG67MwI+5dgYIMDB8DUbKlGCgoUiJ7xcMrH6pOKsz3eYqg9s5ot9sIrtIYMbN3Wc4fePA==
X-ME-Sender: <xms:DBLOWthAGArPTJ6ZttbkHe3f91aXUofWpwoC7WDKnRbIXfz2X7ndqg>
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC tip/locking/lockdep v6 13/20] lockdep/selftest: Add a R-L/L-W test case specific to chain cache behavior
Date: Wed, 11 Apr 2018 21:51:03 +0800
Message-Id: <20180411135110.9217-14-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180411135110.9217-1-boqun.feng@gmail.com>
References: <20180411135110.9217-1-boqun.feng@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As our chain cache doesn't differ read/write locks, so even we can
detect a read-lock/lock-write deadlock in check_noncircular(), we can
still be fooled if a read-lock/lock-read case(which is not a deadlock)
comes first.

So introduce this test case to test specific to the chain cache behavior
on detecting recursive read lock related deadlocks.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 lib/locking-selftest.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index b5c1293ce147..700f9aa19db6 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -395,6 +395,49 @@ static void rwsem_ABBA1(void)
 	MU(Y1); // should fail
 }
 
+/*
+ * read_lock(A)
+ * spin_lock(B)
+ *		spin_lock(B)
+ *		write_lock(A)
+ *
+ * This test case is aimed at poking whether the chain cache prevents us from
+ * detecting a read-lock/lock-write deadlock: if the chain cache doesn't differ
+ * read/write locks, the following case may happen
+ *
+ * 	{ read_lock(A)->lock(B) dependency exists }
+ *
+ * 	P0:
+ * 	lock(B);
+ * 	read_lock(A);
+ *
+ *	{ Not a deadlock, B -> A is added in the chain cache }
+ *
+ *	P1:
+ *	lock(B);
+ *	write_lock(A);
+ *
+ *	{ B->A found in chain cache, not reported as a deadlock }
+ *
+ */
+static void rlock_chaincache_ABBA1(void)
+{
+	RL(X1);
+	L(Y1);
+	U(Y1);
+	RU(X1);
+
+	L(Y1);
+	RL(X1);
+	RU(X1);
+	U(Y1);
+
+	L(Y1);
+	WL(X1);
+	WU(X1);
+	U(Y1); // should fail
+}
+
 /*
  * read_lock(A)
  * spin_lock(B)
@@ -2055,6 +2098,10 @@ void locking_selftest(void)
 	pr_cont("             |");
 	dotest(rwsem_ABBA3, FAILURE, LOCKTYPE_RWSEM);
 
+	print_testname("chain cached mixed R-L/L-W ABBA");
+	pr_cont("             |");
+	dotest(rlock_chaincache_ABBA1, FAILURE, LOCKTYPE_RWLOCK);
+
 	printk("  --------------------------------------------------------------------------\n");
 
 	/*
-- 
2.16.2
