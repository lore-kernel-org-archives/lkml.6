Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752636AbeBVHGN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 02:06:13 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37261 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752581AbeBVHGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 02:06:11 -0500
X-Google-Smtp-Source: AH8x227xPwlyQ0IQumBDRzRNfg4sbgEd7/z3E24v30QF8auHNMmEnnYwnXEntk40Yv/Q9ozp6sqSqA==
X-ME-Sender: <xms:32uOWsBFa-MffT1xepSuoI1g3TZMKd4RSIN6cz7iecZ4hx7iAhy3Rg>
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC tip/locking/lockdep v5 05/17] lockdep: Extend __bfs() to work with multiple kinds of dependencies
Date: Thu, 22 Feb 2018 15:08:52 +0800
Message-Id: <20180222070904.548-6-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180222070904.548-1-boqun.feng@gmail.com>
References: <20180222070904.548-1-boqun.feng@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now we have four kinds of dependencies in the dependency graph, and not
all the pathes carry strong dependencies, for example:

	Given lock A, B, C, if we have:

	CPU1			CPU2
	=============		==============
	write_lock(A);		read_lock(B);
	read_lock(B);		write_lock(C);

	then we have dependencies A--(NR)-->B, and B--(RN)-->C, (NR and
	RN are to indicate the dependency kind), A actually doesn't have
	strong dependency to C(IOW, C doesn't depend on A), to see this,
	let's say we have a third CPU3 doing:

	CPU3:
	=============
	write_lock(C);
	write_lock(A);

	, this is not a deadlock. However if we change the read_lock()
	on CPU2 to a write_lock(), it's a deadlock then.

	So A --(NR)--> B --(RN)--> C is not a strong dependency path but
	A --(NR)--> B --(NN)-->C is a strong dependency path.

We can generalize this as: If a path of dependencies doesn't have two
adjacent dependencies as (*R)--L-->(R*), where L is some lock, it is a
strong dependency path, otherwise it's not.

Now our mission is to make __bfs() traverse only the strong dependency
paths, which is simple: we record whether we have -(*R)-> at the current
tail of the path in lock_list::is_rr, and whenever we pick a dependency
in the traverse, we 1) make sure we don't pick a -(R*)-> dependency if
our current tail is -(*R)-> and 2) greedily pick a -(*N)-> as hard as
possible.

With this extension for __bfs(), we now need to initialize the root of
__bfs() properly(with a correct ->is_rr), to do so, we introduce some
helper functions, which also cleans up a little bit for the __bfs() root
initialization code.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/lockdep.h  |   2 +
 kernel/locking/lockdep.c | 116 ++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 101 insertions(+), 17 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index ab1e5a7d8864..a1f91f8680bd 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -189,6 +189,8 @@ struct lock_list {
 	int				distance;
 	/* bitmap of different dependencies from head to this */
 	u16				dep;
+	/* used by BFS to record whether this is picked as a recursive read */
+	u16				is_rr;
 
 	/*
 	 * The parent field is used to implement breadth-first search, and the
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index acd25bfc336d..07bcfaac6fe2 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1040,6 +1040,89 @@ static inline unsigned int calc_dep(int prev, int next)
 	return 1U << __calc_dep_bit(prev, next);
 }
 
+/*
+ * return -1 if no proper dependency could be picked
+ * return 0 if a -(*N)-> dependency could be picked
+ * return 1 if only a -(*R)-> dependency could be picked
+ *
+ * N: non-recursive lock
+ * R: recursive read lock
+ */
+static inline int pick_dep(u16 is_rr, u16 cap_dep)
+{
+	if (is_rr) { /* could only pick -(N*)-> */
+		if (cap_dep & DEP_NN_MASK)
+			return 0;
+		else if (cap_dep & DEP_NR_MASK)
+			return 1;
+		else
+			return -1;
+	} else {
+		if (cap_dep & DEP_NN_MASK || cap_dep & DEP_RN_MASK)
+			return 0;
+		else
+			return 1;
+	}
+}
+
+/*
+ * Initialize a lock_list entry @lock belonging to @class as the root for a BFS
+ * search.
+ */
+static inline void __bfs_init_root(struct lock_list *lock,
+				   struct lock_class *class)
+{
+	lock->class = class;
+	lock->parent = NULL;
+	lock->is_rr = 0;
+}
+
+/*
+ * Initialize a lock_list entry @lock based on a lock acquisition @hlock as the
+ * root for a BFS search.
+ */
+static inline void bfs_init_root(struct lock_list *lock,
+				 struct held_lock *hlock)
+{
+	__bfs_init_root(lock, hlock_class(hlock));
+	lock->is_rr = (hlock->read == 2);
+}
+
+/*
+ * Breadth-First Search to find a strong path in the dependency graph.
+ *
+ * @source_entry: the source of the path we are searching for.
+ * @data: data used for the second parameter of @match function
+ * @match: match function for the search
+ * @target_entry: pointer to the target of a matched path
+ * @forward: direction of path, the lockdep dependency forward or backward
+ *
+ * We may have multiple edges(considering different kinds of dependencies, e.g.
+ * -(NR)-> and -(RN)->) between two nodes in the dependency graph, which may
+ * undermine the normal BFS algorithm, however, we are lucky because: in the
+ * search, for each pair of adjacent nodes, we can pick the edge greedily:
+ *
+ * 	Say we have nodes L0, L1 and L2, and we already pick edge from L0 to
+ * 	L1, and we are going to pick the edge from L1 to L2, because we are
+ * 	picking edges to *strong* path, that means if we pick -(*R)-> for L0 to
+ * 	L1 (i.e. we pick L0 -(*R)-> L1), we can not pick any L1 -(R*)-> L2.
+ *
+ * 	And if we pick L0 -(NR)-> L1, and we have edge 1) L1-(NR)->L2 and 2)
+ * 	L1-(NN)->L2, we can greedily pick edge 2) for the path searching,
+ * 	because a) if ...->L0-(NR)->L1-(NR)->L2->... could cause a deadlock,
+ * 	then so does ...->L0->(NR)->L1-(NN)->L2->... and b) picking 2) means we
+ * 	can pick any kinds of edge for L2 to the next node, so we can search
+ * 	more deadlock cases then picking 1).
+ *
+ * So we have two rules of picking edges in BFS:
+ *
+ * "strong": if the previous edge we pick is -(*R)->, we must pick -(N*)->,
+ *           otherwise, we can pick any kind.
+ * "greedy": if we can pick -(*R)-> or -(*N)-> (if both of them satisfies the
+ *           "strong" rule), we always pick -(*N)-> ones.
+ *
+ * And that's how pick_dep() is implemeneted.
+ */
 static enum bfs_result __bfs(struct lock_list *source_entry,
 			     void *data,
 			     int (*match)(struct lock_list *entry, void *data),
@@ -1050,6 +1133,7 @@ static enum bfs_result __bfs(struct lock_list *source_entry,
 	struct list_head *head;
 	struct circular_queue *cq = &lock_cq;
 	enum bfs_result ret = BFS_RNOMATCH;
+	int is_rr, next_is_rr;
 
 	if (match(source_entry, data)) {
 		*target_entry = source_entry;
@@ -1095,11 +1179,18 @@ static enum bfs_result __bfs(struct lock_list *source_entry,
 		else
 			head = &lock->class->locks_before;
 
+		is_rr = lock->is_rr;
+
 		DEBUG_LOCKS_WARN_ON(!irqs_disabled());
 
 		list_for_each_entry_rcu(entry, head, entry) {
 			unsigned int cq_depth;
 
+			next_is_rr = pick_dep(is_rr, entry->dep);
+			if (next_is_rr < 0)
+				continue;
+			entry->is_rr = next_is_rr;
+
 			visit_lock_entry(entry, lock);
 			if (match(entry, data)) {
 				*target_entry = entry;
@@ -1326,8 +1417,7 @@ unsigned long lockdep_count_forward_deps(struct lock_class *class)
 	unsigned long ret, flags;
 	struct lock_list this;
 
-	this.parent = NULL;
-	this.class = class;
+	__bfs_init_root(&this, class);
 
 	local_irq_save(flags);
 	arch_spin_lock(&lockdep_lock);
@@ -1353,8 +1443,7 @@ unsigned long lockdep_count_backward_deps(struct lock_class *class)
 	unsigned long ret, flags;
 	struct lock_list this;
 
-	this.parent = NULL;
-	this.class = class;
+	__bfs_init_root(&this, class);
 
 	local_irq_save(flags);
 	arch_spin_lock(&lockdep_lock);
@@ -1641,17 +1730,14 @@ check_usage(struct task_struct *curr, struct held_lock *prev,
 	struct lock_list *uninitialized_var(target_entry);
 	struct lock_list *uninitialized_var(target_entry1);
 
-	this.parent = NULL;
-
-	this.class = hlock_class(prev);
+	bfs_init_root(&this, prev);
 	ret = find_usage_backwards(&this, bit_backwards, &target_entry);
 	if (bfs_error(ret))
 		return print_bfs_bug(ret);
 	if (ret == BFS_RNOMATCH)
 		return 1;
 
-	that.parent = NULL;
-	that.class = hlock_class(next);
+	bfs_init_root(&that, next);
 	ret = find_usage_forwards(&that, bit_forwards, &target_entry1);
 	if (bfs_error(ret))
 		return print_bfs_bug(ret);
@@ -1907,8 +1993,7 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 	 * We are using global variables to control the recursion, to
 	 * keep the stackframe size of the recursive functions low:
 	 */
-	this.class = hlock_class(next);
-	this.parent = NULL;
+	bfs_init_root(&this, next);
 	ret = check_noncircular(&this, hlock_class(prev), &target_entry);
 	if (unlikely(ret == BFS_RMATCH)) {
 		if (!trace->entries) {
@@ -1966,8 +2051,7 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 	/*
 	 * Is the <prev> -> <next> link redundant?
 	 */
-	this.class = hlock_class(prev);
-	this.parent = NULL;
+	bfs_init_root(&this, prev);
 	ret = check_redundant(&this, hlock_class(next), &target_entry);
 	if (ret == BFS_RMATCH) {
 		debug_atomic_inc(nr_redundant);
@@ -2710,8 +2794,7 @@ check_usage_forwards(struct task_struct *curr, struct held_lock *this,
 	struct lock_list root;
 	struct lock_list *uninitialized_var(target_entry);
 
-	root.parent = NULL;
-	root.class = hlock_class(this);
+	bfs_init_root(&root, this);
 	ret = find_usage_forwards(&root, bit, &target_entry);
 	if (bfs_error(ret))
 		return print_bfs_bug(ret);
@@ -2734,8 +2817,7 @@ check_usage_backwards(struct task_struct *curr, struct held_lock *this,
 	struct lock_list root;
 	struct lock_list *uninitialized_var(target_entry);
 
-	root.parent = NULL;
-	root.class = hlock_class(this);
+	bfs_init_root(&root, this);
 	ret = find_usage_backwards(&root, bit, &target_entry);
 	if (bfs_error(ret))
 		return print_bfs_bug(ret);
-- 
2.16.1
