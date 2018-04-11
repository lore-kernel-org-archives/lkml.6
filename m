Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753896AbeDKNt4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 09:49:56 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52411 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753317AbeDKNrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 09:47:46 -0400
X-Google-Smtp-Source: AIpwx4/U5up4/egqmIuBq6C9nmA5mu6nXcBVpvhnoq/FGctpywWhRdFT5LA1bQzr0gkBarYRUL/VWA==
X-ME-Sender: <xms:_hHOWm1FPI4qrLhEdLKuSyVKn9VYGuBfq3k-bdTc30_TQDXvQ0TZog>
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC tip/locking/lockdep v6 09/20] lockdep: Support deadlock detection for recursive read locks in check_noncircular()
Date: Wed, 11 Apr 2018 21:50:59 +0800
Message-Id: <20180411135110.9217-10-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180411135110.9217-1-boqun.feng@gmail.com>
References: <20180411135110.9217-1-boqun.feng@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, lockdep only has limit support for deadlock detection for
recursive read locks.

This patch support deadlock detection for recursive read locks. The
basic idea is:

We are about to add dependency B -> A in to the dependency graph, we use
check_noncircular() to find whether we have a strong dependency path
A -> .. -> B so that we have a strong dependency circle:

	 A -> .. -> B -> A

, which doesn't have two adjacent dependencies as -(*R)-> L -(R*)->.
Because similar to the definition of strong dependency paths, if there
are two adjacent dependencies like that, there is at least one lock
which doesn't have an exclusive holder, so no deadlock.

Since A -> .. -> B is already a strong dependency path, so if either
B -> A is N* or A -> .. -> B is *N, the circle A -> .. -> B -> A is
strong, otherwise not. So we introduce a new match function
hlock_conflict() to replace the class_equal() for the deadlock check in
check_noncircular().

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/locking/lockdep.c | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index df1637db923a..6b5d43687c3b 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1338,6 +1338,33 @@ static inline bool class_equal(struct lock_list *entry, void *data)
 	return entry->class == data;
 }
 
+/*
+ * We are about to add B -> A into the dependency graph, and in __bfs() a
+ * strong dependency path A -> .. -> B is found: hlock_class equals
+ * entry->class.
+ *
+ * We will have a deadlock case (conflict) if A -> .. -> B -> A is a strong
+ * dependency cycle, that means:
+ *
+ * Either
+ *
+ *     a) B -> A is N*
+ *
+ * or
+ *
+ *     b) A -> .. -> B is *N (i.e. A -> .. -(*N)-> B)
+ *
+ * as then we don't have *R -> R* in the cycle.
+ */
+static inline bool hlock_conflict(struct lock_list *entry, void *data)
+{
+	struct held_lock *hlock = (struct held_lock *)data;
+
+	return hlock_class(hlock) == entry->class && /* Found A -> .. -> B */
+	       (hlock->read != 2 || /* B -> A is N* */
+		!entry->only_xr); /* A -> .. -> B is *N */
+}
+
 static noinline int print_circular_bug(struct lock_list *this,
 				struct lock_list *target,
 				struct held_lock *check_src,
@@ -1450,18 +1477,18 @@ unsigned long lockdep_count_backward_deps(struct lock_class *class)
 }
 
 /*
- * Prove that the dependency graph starting at <entry> can not
+ * Prove that the dependency graph starting at <root> can not
  * lead to <target>. Print an error and return BFS_RMATCH if it does.
  */
 static noinline enum bfs_result
-check_noncircular(struct lock_list *root, struct lock_class *target,
+check_noncircular(struct lock_list *root, struct held_lock *target,
 		  struct lock_list **target_entry)
 {
 	enum bfs_result result;
 
 	debug_atomic_inc(nr_cyclic_checks);
 
-	result = __bfs_forwards(root, target, class_equal, target_entry);
+	result = __bfs_forwards(root, target, hlock_conflict, target_entry);
 
 	return result;
 }
@@ -1989,7 +2016,7 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 	 * keep the stackframe size of the recursive functions low:
 	 */
 	bfs_init_root(&this, next);
-	ret = check_noncircular(&this, hlock_class(prev), &target_entry);
+	ret = check_noncircular(&this, prev, &target_entry);
 	if (unlikely(ret == BFS_RMATCH)) {
 		if (!trace->entries) {
 			/*
-- 
2.16.2
