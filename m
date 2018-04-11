Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753392AbeDKNrn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 09:47:43 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53379 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753317AbeDKNrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 09:47:40 -0400
X-Google-Smtp-Source: AIpwx4/oNxtVJbJG2UnWQUJEXaw5AP78cGkM+4y0xa00GfKcbdFhleuDtufmW0WxAMtWczIHmb2lYA==
X-ME-Sender: <xms:-BHOWuVj_XWyr9T7oqH21lz4OcD8F4oQnhRzxQAcnFy9CHKzui76Qg>
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC tip/locking/lockdep v6 07/20] lockdep: Extend __bfs() to work with multiple types of dependencies
Date: Wed, 11 Apr 2018 21:50:57 +0800
Message-Id: <20180411135110.9217-8-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180411135110.9217-1-boqun.feng@gmail.com>
References: <20180411135110.9217-1-boqun.feng@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now we have four types of dependencies in the dependency graph, and not
all the pathes carry real dependencies (the dependencies that may cause
a deadlock), for example:

	Given lock A and B, if we have:

	CPU1			CPU2
	=============		==============
	write_lock(A);		read_lock(B);
	read_lock(B);		write_lock(A);

	then we have dependencies A -(NR)-> B, and B -(RN)-> A, and a
	dependency path A -(NR)-> B -(RN)-> A.

	In lockdep w/o recursive locks, a dependency path from A to A
	means a deadlock. However, the above case is obviously not a
	deadlock, because no one holds B exclusively, therefore no one
	waits for the other to release B, so who get A first in CPU1 and
	CPU2 will run non-blockingly.

	As a result, dependency path A -(NR)-> B -(RN)-> A is not a
	real/strong dependency that could cause a deadlock.

>From the observation above, we know that for a dependency path to be
real/strong, we need at least one exclusive holder for each lock in the
dependency path, otherwise, one could get the resource from the shared
holder and get progress.

Therefore we have the definition: If a path of dependencies doesn't have
two adjacent dependencies as -(*R)-> L -(R*)->, where L is some lock, it
is a strong dependency path, otherwise it's not.

Now our mission is to make __bfs() traverse only the strong dependency
paths, which is simple: we record whether we only have -(*R)-> for the
previous lock_list of the path in lock_list::only_xr, and when we pick a
dependency in the traverse, we 1) filter out -(R*)-> dependency if the
previous lock_list only has -(*R)-> dependency (i.e. ->only_xr is true)
and 2) set the next lock_list::only_xr to true if we only have -(*R)->
left after we filter out dependencies based on 1), otherwise, set it to
false.

With this extension for __bfs(), we now need to initialize the root of
__bfs() properly (with a correct ->only_xr), to do so, we introduce some
helper functions, which also cleans up a little bit for the __bfs() root
initialization code.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/lockdep.h  |   2 +
 kernel/locking/lockdep.c | 103 +++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 88 insertions(+), 17 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index cbd257f62877..6b661717a594 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -189,6 +189,8 @@ struct lock_list {
 	u16				distance;
 	/* bitmap of different dependencies from head to this */
 	u8				dep;
+	/* used by BFS to record whether "prev -> this" only has *R */
+	u8				only_xr;
 
 	/*
 	 * The parent field is used to implement breadth-first search, and the
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 0892855b6c57..53ce81e8a6a9 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1037,6 +1037,10 @@ static inline bool bfs_error(enum bfs_result res)
 #define DEP_RN_MASK (1U << (DEP_RN_BIT))
 #define DEP_NN_MASK (1U << (DEP_NN_BIT))
 
+/* dep masks for *N and N* */
+#define DEP_XN_MASK (DEP_RN_MASK | DEP_NN_MASK)
+#define DEP_NX_MASK (DEP_NR_MASK | DEP_NN_MASK)
+
 static inline unsigned int
 __calc_dep_bit(struct held_lock *prev, struct held_lock *next)
 {
@@ -1048,6 +1052,61 @@ static inline u8 calc_dep(struct held_lock *prev, struct held_lock *next)
 	return 1U << __calc_dep_bit(prev, next);
 }
 
+/*
+ * Initialize a lock_list entry @lock belonging to @class as the root for a BFS
+ * search.
+ */
+static inline void __bfs_init_root(struct lock_list *lock,
+				   struct lock_class *class)
+{
+	lock->class = class;
+	lock->parent = NULL;
+	lock->only_xr = 0;
+}
+
+/*
+ * Initialize a lock_list entry @lock based on a lock acquisition @hlock as the
+ * root for a BFS search.
+ *
+ * ->only of the initial lock node is set to @hlock->read == 2, to make sure
+ * that <prev> -> @hlock and @hlock -> <whatever __bfs() found> is not *R and
+ * R*.
+ */
+static inline void bfs_init_root(struct lock_list *lock,
+				 struct held_lock *hlock)
+{
+	__bfs_init_root(lock, hlock_class(hlock));
+	lock->only_xr = (hlock->read == 2);
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
+ * We may have multiple edges (considering different kinds of dependencies,
+ * e.g. NR and RN) between two nodes in the dependency graph. But
+ * only the strong dependency path in the graph is relevant to deadlocks. A
+ * strong dependency path is a dependency path that doesn't have two adjacent
+ * dependencies as *R -> R*, the reason why strong dependency path can be
+ * defined as this is:
+ *
+ *     In order to make tasks/CPUs to block one by one in a dependency path,
+ *     there must be at least one exclusive holder for each lock, i.e. two
+ *     adjacent dependencies can be *N -> N*, *R -> N* or *N -> R*, but not *R
+ *     -> R*.
+ *
+ * In __bfs(), we only traverse in the strong dependency path:
+ *
+ *     In lock_list::only_xr, we record whether the previous dependency only
+ *     has *R in the search, and if it does (prev only has *R), we filter out
+ *     any R* in the current dependency and after that, the ->only_xr is set
+ *     according to whether we only have *R left.
+ */
 static enum bfs_result __bfs(struct lock_list *source_entry,
 			     void *data,
 			     int (*match)(struct lock_list *entry, void *data),
@@ -1078,6 +1137,7 @@ static enum bfs_result __bfs(struct lock_list *source_entry,
 
 	while (!__cq_empty(cq)) {
 		struct lock_list *lock;
+		bool prev_only_xr;
 
 		__cq_dequeue(cq, (unsigned long *)&lock);
 
@@ -1103,10 +1163,28 @@ static enum bfs_result __bfs(struct lock_list *source_entry,
 		else
 			head = &lock->class->locks_before;
 
+		prev_only_xr = lock->only_xr;
+
 		DEBUG_LOCKS_WARN_ON(!irqs_disabled());
 
 		list_for_each_entry_rcu(entry, head, entry) {
 			unsigned int cq_depth;
+			u8 dep = entry->dep;
+
+			/*
+			 * Mask out all R* if we only have *R in previous
+			 * step, because *R -> R* don't make up a strong
+			 * dependency.
+			 */
+			if (prev_only_xr)
+				dep &= ~(DEP_RR_MASK | DEP_RN_MASK);
+
+			/* If nothing left, we skip */
+			if (!dep)
+				continue;
+
+			/* If there are only *R left, set that for the next step */
+			entry->only_xr = !(dep & (DEP_RN_MASK | DEP_NN_MASK));
 
 			visit_lock_entry(entry, lock);
 			if (match(entry, data)) {
@@ -1334,8 +1412,7 @@ unsigned long lockdep_count_forward_deps(struct lock_class *class)
 	unsigned long ret, flags;
 	struct lock_list this;
 
-	this.parent = NULL;
-	this.class = class;
+	__bfs_init_root(&this, class);
 
 	local_irq_save(flags);
 	arch_spin_lock(&lockdep_lock);
@@ -1361,8 +1438,7 @@ unsigned long lockdep_count_backward_deps(struct lock_class *class)
 	unsigned long ret, flags;
 	struct lock_list this;
 
-	this.parent = NULL;
-	this.class = class;
+	__bfs_init_root(&this, class);
 
 	local_irq_save(flags);
 	arch_spin_lock(&lockdep_lock);
@@ -1649,17 +1725,14 @@ check_usage(struct task_struct *curr, struct held_lock *prev,
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
@@ -1915,8 +1988,7 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 	 * We are using global variables to control the recursion, to
 	 * keep the stackframe size of the recursive functions low:
 	 */
-	this.class = hlock_class(next);
-	this.parent = NULL;
+	bfs_init_root(&this, next);
 	ret = check_noncircular(&this, hlock_class(prev), &target_entry);
 	if (unlikely(ret == BFS_RMATCH)) {
 		if (!trace->entries) {
@@ -1992,8 +2064,7 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 	/*
 	 * Is the <prev> -> <next> link redundant?
 	 */
-	this.class = hlock_class(prev);
-	this.parent = NULL;
+	bfs_init_root(&this, prev);
 	ret = check_redundant(&this, hlock_class(next), &target_entry);
 	if (ret == BFS_RMATCH) {
 		debug_atomic_inc(nr_redundant);
@@ -2736,8 +2807,7 @@ check_usage_forwards(struct task_struct *curr, struct held_lock *this,
 	struct lock_list root;
 	struct lock_list *uninitialized_var(target_entry);
 
-	root.parent = NULL;
-	root.class = hlock_class(this);
+	bfs_init_root(&root, this);
 	ret = find_usage_forwards(&root, bit, &target_entry);
 	if (bfs_error(ret))
 		return print_bfs_bug(ret);
@@ -2760,8 +2830,7 @@ check_usage_backwards(struct task_struct *curr, struct held_lock *this,
 	struct lock_list root;
 	struct lock_list *uninitialized_var(target_entry);
 
-	root.parent = NULL;
-	root.class = hlock_class(this);
+	bfs_init_root(&root, this);
 	ret = find_usage_backwards(&root, bit, &target_entry);
 	if (bfs_error(ret))
 		return print_bfs_bug(ret);
-- 
2.16.2
