Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752726AbeBVHGf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 02:06:35 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33353 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752478AbeBVHGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 02:06:31 -0500
X-Google-Smtp-Source: AH8x225xu3ByqnLfiIPlBcipUoDHce5aNe0qU635f18ihjdP5uUUjv1N9YUN4JvOwfdGK2sftxOKGw==
X-ME-Sender: <xms:9GuOWihMLnakub2voxIqKS1EEKhfO_mMP0o9cYYKnw8sEHwoYbyujA>
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC tip/locking/lockdep v5 10/17] lockdep/selftest: Add a R-L/L-W test case specific to chain cache behavior
Date: Thu, 22 Feb 2018 15:08:57 +0800
Message-Id: <20180222070904.548-11-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180222070904.548-1-boqun.feng@gmail.com>
References: <20180222070904.548-1-boqun.feng@gmail.com>
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
2.16.1
