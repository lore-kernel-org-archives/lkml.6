Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753488AbeDKNrw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 09:47:52 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52427 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753353AbeDKNrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 09:47:49 -0400
X-Google-Smtp-Source: AIpwx4+7fBKRsg3+TlEFIvxnIToibCyJPH/Eimz2sMJGiiEO9k7z/PR2v5zS5fqb9EZ9mqcAR0o3UQ==
X-ME-Sender: <xms:AhLOWiS2sBgAwds9tbK__Yl9mbz8SLpBw7sz8aBtqlJ7PX0dC5svvw>
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC tip/locking/lockdep v6 10/20] lockdep: Adjust check_redundant() for recursive read change
Date: Wed, 11 Apr 2018 21:51:00 +0800
Message-Id: <20180411135110.9217-11-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180411135110.9217-1-boqun.feng@gmail.com>
References: <20180411135110.9217-1-boqun.feng@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

check_redundant() will report redundancy if it finds a path could
replace the about-to-add dependency in the BFS search. With recursive
read lock changes, we certainly need to change the match function for
the check_redundant(), because the path needs to match not only the lock
class but also the dependency kinds. For example, if the about-to-add
dependency @prev -> @next is A -(RN)-> B, and we find a path A -(R*)->
.. -(*R)->B in the dependency graph with __bfs() (for simplicity, we can
also say we find an RR path from A to B), we can not replace the
dependency with that path in the BFS search. Because the RN dependency
can make a strong path with an RN dependency, however an RR path cannot.

Further, we can also replace an RN dependency with a NN path, that means
if we find a path which is stronger than or equal to the about-to-add
dependency, we can report the redundancy. By "stronger", it means both
the start and the end of the path are not weaker than the start and the
end of the dependency, so that we can replace the dependency with that
path.

To make sure we find a path whose start point is not weaker than the
about-to-add dependency, we use a trick: the ->only_xr of the root
(start point) of __bfs() is initialized as @prev-> !=2, therefore if
@prev is N, __bfs() will pick N* for the first dependency, otherwise,
__bfs() can pick N* or R* for the first dependency.

To make sure we find a path whose end point is not weaker than the
about-to-add dependency, we replace the match function for __bfs()
check_redundant(), we check for the case that either @next is R
(anything is not weaker than it) or the end point of the path is N
(which is not weaker than anything).

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/locking/lockdep.c | 53 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 47 insertions(+), 6 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 6b5d43687c3b..6135d1836ed3 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1333,9 +1333,40 @@ print_circular_bug_header(struct lock_list *entry, unsigned int depth,
 	return 0;
 }
 
-static inline bool class_equal(struct lock_list *entry, void *data)
+/*
+ * We are about to add A -> B into the dependency graph, and in __bfs() a
+ * strong dependency path A -> .. -> B is found: hlock_class equals
+ * entry->class.
+ *
+ * If A -> .. -> B can replace A -> B in any __bfs() search (means the former
+ * is _stronger_ than or equal to the latter), we consider A -> B as redundant.
+ * For example if A -> .. -> B is NN (i.e. A -(N*)-> .. -(*N)-> B), and A -> B
+ * is NR or NN, then we don't need to add A -> B into the dependency graph, as
+ * any strong path ..-> A -> B ->.. we can get with having dependency A -> B,
+ * we could already get a equivalent path ..-> A -> .. -> B -> .. with A -> ..
+ * -> B. Therefore A -> B is reduntant.
+ *
+ * We need to make sure both the start and the end of A -> .. -> B is not
+ * weaker than A -> B. For the start part, please see the comment before
+ * call-site of check_redundant() in check_prev_add(). For the end part, we
+ * need:
+ *
+ * Either
+ *
+ *     a) A -> B is *R (everything is not weaker than that)
+ *
+ * or
+ *
+ *     b) A -> .. -> B is *N (nothing is stronger than this)
+ *
+ */
+static inline bool hlock_equal(struct lock_list *entry, void *data)
 {
-	return entry->class == data;
+	struct held_lock *hlock = (struct held_lock *)data;
+
+	return hlock_class(hlock) == entry->class && /* Found A -> .. -> B */
+	       (hlock->read == 2 ||  /* A -> B is *R */
+		!entry->only_xr); /* A -> .. -> B is *N */
 }
 
 /*
@@ -1494,14 +1525,14 @@ check_noncircular(struct lock_list *root, struct held_lock *target,
 }
 
 static noinline enum bfs_result
-check_redundant(struct lock_list *root, struct lock_class *target,
+check_redundant(struct lock_list *root, struct held_lock *target,
 		struct lock_list **target_entry)
 {
 	enum bfs_result result;
 
 	debug_atomic_inc(nr_redundant_checks);
 
-	result = __bfs_forwards(root, target, class_equal, target_entry);
+	result = __bfs_forwards(root, target, hlock_equal, target_entry);
 
 	return result;
 }
@@ -2090,9 +2121,19 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 
 	/*
 	 * Is the <prev> -> <next> link redundant?
+	 *
+	 * Special setup for check_redundant().
+	 *
+	 * To report redundant, we need to find a strong dependency path that
+	 * is equal to or stronger than <prev> -> <next>. So if <prev> is N,
+	 * we need to let __bfs() only search for a path starting at a N*, we
+	 * achieve this by setting the initial node's ->only_xr to true in
+	 * that case. And if <prev> is R, we set initial ->only_xr to false
+	 * because both R* (equal) and N* (stronger) are redundant.
 	 */
-	bfs_init_root(&this, prev);
-	ret = check_redundant(&this, hlock_class(next), &target_entry);
+	__bfs_init_root(&this, hlock_class(prev));
+	this.only_xr = prev->read != 2;
+	ret = check_redundant(&this, next, &target_entry);
 	if (ret == BFS_RMATCH) {
 		debug_atomic_inc(nr_redundant);
 		return 2;
-- 
2.16.2
