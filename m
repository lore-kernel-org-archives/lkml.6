Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753101AbeDKNvQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 09:51:16 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39670 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751797AbeDKNrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 09:47:23 -0400
X-Google-Smtp-Source: AIpwx4+Q+5IpUpBbb+emdjxtJPYnfIECYfca3ZVpXa/rMH1G/9ZZD5WuNOvCcMk9XJCrRu237N1RyQ==
X-ME-Sender: <xms:5xHOWsdvdzqLVKtLvlkGCEuo0gDus2rpNIGfmDKmBb2Rayfg5t57zQ>
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC tip/locking/lockdep v6 02/20] lockdep: Demagic the return value of BFS
Date: Wed, 11 Apr 2018 21:50:52 +0800
Message-Id: <20180411135110.9217-3-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180411135110.9217-1-boqun.feng@gmail.com>
References: <20180411135110.9217-1-boqun.feng@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__bfs() could return four magic numbers:

	1: search succeeds, but none match.
	0: search succeeds, find one match.
	-1: search fails because of the cq is full.
	-2: search fails because a invalid node is found.

This patch cleans things up by using a enum type for the return value
of __bfs() and its friends, this improves the code readability of the
code, and further, could help if we want to extend the BFS.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/locking/lockdep.c | 136 ++++++++++++++++++++++++++++-------------------
 1 file changed, 80 insertions(+), 56 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 89b5f83f1969..2dbaff381778 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -984,21 +984,52 @@ static inline int get_lock_depth(struct lock_list *child)
 	}
 	return depth;
 }
+/*
+ * Return values of a bfs search:
+ *
+ * BFS_E* indicates an error
+ * BFS_R* indicates a result (match or not)
+ *
+ * BFS_EINVALIDNODE: Find a invalid node in the graph.
+ *
+ * BFS_EQUEUEFULL: The queue is full while doing the bfs.
+ *
+ * BFS_RMATCH: Find the matched node in the graph, and put that node * into
+ *            *@target_entry.
+ *
+ * BFS_RNOMATCH: Haven't found the matched node and keep *@target_entry
+ *              _unchanged_.
+ */
+enum bfs_result {
+	BFS_EINVALIDNODE = -2,
+	BFS_EQUEUEFULL = -1,
+	BFS_RMATCH = 0,
+	BFS_RNOMATCH = 1,
+};
 
-static int __bfs(struct lock_list *source_entry,
-		 void *data,
-		 int (*match)(struct lock_list *entry, void *data),
-		 struct lock_list **target_entry,
-		 int forward)
+/*
+ * bfs_result < 0 means error
+ */
+
+static inline bool bfs_error(enum bfs_result res)
+{
+	return res < 0;
+}
+
+static enum bfs_result __bfs(struct lock_list *source_entry,
+			     void *data,
+			     int (*match)(struct lock_list *entry, void *data),
+			     struct lock_list **target_entry,
+			     int forward)
 {
 	struct lock_list *entry;
 	struct list_head *head;
 	struct circular_queue *cq = &lock_cq;
-	int ret = 1;
+	enum bfs_result ret = BFS_RNOMATCH;
 
 	if (match(source_entry, data)) {
 		*target_entry = source_entry;
-		ret = 0;
+		ret = BFS_RMATCH;
 		goto exit;
 	}
 
@@ -1019,7 +1050,7 @@ static int __bfs(struct lock_list *source_entry,
 		__cq_dequeue(cq, (unsigned long *)&lock);
 
 		if (!lock->class) {
-			ret = -2;
+			ret = BFS_EINVALIDNODE;
 			goto exit;
 		}
 
@@ -1036,12 +1067,12 @@ static int __bfs(struct lock_list *source_entry,
 				mark_lock_accessed(entry, lock);
 				if (match(entry, data)) {
 					*target_entry = entry;
-					ret = 0;
+					ret = BFS_RMATCH;
 					goto exit;
 				}
 
 				if (__cq_enqueue(cq, (unsigned long)entry)) {
-					ret = -1;
+					ret = BFS_EQUEUEFULL;
 					goto exit;
 				}
 				cq_depth = __cq_get_elem_count(cq);
@@ -1054,19 +1085,21 @@ static int __bfs(struct lock_list *source_entry,
 	return ret;
 }
 
-static inline int __bfs_forwards(struct lock_list *src_entry,
-			void *data,
-			int (*match)(struct lock_list *entry, void *data),
-			struct lock_list **target_entry)
+static inline enum bfs_result
+__bfs_forwards(struct lock_list *src_entry,
+	       void *data,
+	       int (*match)(struct lock_list *entry, void *data),
+	       struct lock_list **target_entry)
 {
 	return __bfs(src_entry, data, match, target_entry, 1);
 
 }
 
-static inline int __bfs_backwards(struct lock_list *src_entry,
-			void *data,
-			int (*match)(struct lock_list *entry, void *data),
-			struct lock_list **target_entry)
+static inline enum bfs_result
+__bfs_backwards(struct lock_list *src_entry,
+		void *data,
+		int (*match)(struct lock_list *entry, void *data),
+		struct lock_list **target_entry)
 {
 	return __bfs(src_entry, data, match, target_entry, 0);
 
@@ -1299,13 +1332,13 @@ unsigned long lockdep_count_backward_deps(struct lock_class *class)
 
 /*
  * Prove that the dependency graph starting at <entry> can not
- * lead to <target>. Print an error and return 0 if it does.
+ * lead to <target>. Print an error and return BFS_RMATCH if it does.
  */
-static noinline int
+static noinline enum bfs_result
 check_noncircular(struct lock_list *root, struct lock_class *target,
-		struct lock_list **target_entry)
+		  struct lock_list **target_entry)
 {
-	int result;
+	enum bfs_result result;
 
 	debug_atomic_inc(nr_cyclic_checks);
 
@@ -1314,11 +1347,11 @@ check_noncircular(struct lock_list *root, struct lock_class *target,
 	return result;
 }
 
-static noinline int
+static noinline enum bfs_result
 check_redundant(struct lock_list *root, struct lock_class *target,
 		struct lock_list **target_entry)
 {
-	int result;
+	enum bfs_result result;
 
 	debug_atomic_inc(nr_redundant_checks);
 
@@ -1347,15 +1380,12 @@ static inline int usage_match(struct lock_list *entry, void *bit)
  *
  * Return 0 if such a node exists in the subgraph, and put that node
  * into *@target_entry.
- *
- * Return 1 otherwise and keep *@target_entry unchanged.
- * Return <0 on error.
  */
-static int
+static enum bfs_result
 find_usage_forwards(struct lock_list *root, enum lock_usage_bit bit,
 			struct lock_list **target_entry)
 {
-	int result;
+	enum bfs_result result;
 
 	debug_atomic_inc(nr_find_usage_forwards_checks);
 
@@ -1367,18 +1397,12 @@ find_usage_forwards(struct lock_list *root, enum lock_usage_bit bit,
 /*
  * Find a node in the backwards-direction dependency sub-graph starting
  * at @root->class that matches @bit.
- *
- * Return 0 if such a node exists in the subgraph, and put that node
- * into *@target_entry.
- *
- * Return 1 otherwise and keep *@target_entry unchanged.
- * Return <0 on error.
  */
-static int
+static enum bfs_result
 find_usage_backwards(struct lock_list *root, enum lock_usage_bit bit,
 			struct lock_list **target_entry)
 {
-	int result;
+	enum bfs_result result;
 
 	debug_atomic_inc(nr_find_usage_backwards_checks);
 
@@ -1586,18 +1610,18 @@ check_usage(struct task_struct *curr, struct held_lock *prev,
 
 	this.class = hlock_class(prev);
 	ret = find_usage_backwards(&this, bit_backwards, &target_entry);
-	if (ret < 0)
+	if (bfs_error(ret))
 		return print_bfs_bug(ret);
-	if (ret == 1)
-		return ret;
+	if (ret == BFS_RNOMATCH)
+		return 1;
 
 	that.parent = NULL;
 	that.class = hlock_class(next);
 	ret = find_usage_forwards(&that, bit_forwards, &target_entry1);
-	if (ret < 0)
+	if (bfs_error(ret))
 		return print_bfs_bug(ret);
-	if (ret == 1)
-		return ret;
+	if (ret == BFS_RNOMATCH)
+		return 1;
 
 	return print_bad_irq_dependency(curr, &this, &that,
 			target_entry, target_entry1,
@@ -1834,10 +1858,10 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 	       struct held_lock *next, int distance, struct stack_trace *trace,
 	       int (*save)(struct stack_trace *trace))
 {
-	struct lock_list *uninitialized_var(target_entry);
 	struct lock_list *entry;
+	enum bfs_result ret;
 	struct lock_list this;
-	int ret;
+	struct lock_list *uninitialized_var(target_entry);
 
 	/*
 	 * Prove that the new <prev> -> <next> dependency would not
@@ -1851,7 +1875,7 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 	this.class = hlock_class(next);
 	this.parent = NULL;
 	ret = check_noncircular(&this, hlock_class(prev), &target_entry);
-	if (unlikely(!ret)) {
+	if (unlikely(ret == BFS_RMATCH)) {
 		if (!trace->entries) {
 			/*
 			 * If @save fails here, the printing might trigger
@@ -1862,7 +1886,7 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 		}
 		return print_circular_bug(&this, target_entry, next, prev, trace);
 	}
-	else if (unlikely(ret < 0))
+	else if (unlikely(bfs_error(ret)))
 		return print_bfs_bug(ret);
 
 	if (!check_prev_add_irq(curr, prev, next))
@@ -1900,11 +1924,11 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 	this.class = hlock_class(prev);
 	this.parent = NULL;
 	ret = check_redundant(&this, hlock_class(next), &target_entry);
-	if (!ret) {
+	if (ret == BFS_RMATCH) {
 		debug_atomic_inc(nr_redundant);
 		return 2;
 	}
-	if (ret < 0)
+	if (bfs_error(ret))
 		return print_bfs_bug(ret);
 
 
@@ -2633,16 +2657,16 @@ static int
 check_usage_forwards(struct task_struct *curr, struct held_lock *this,
 		     enum lock_usage_bit bit, const char *irqclass)
 {
-	int ret;
+	enum bfs_result ret;
 	struct lock_list root;
 	struct lock_list *uninitialized_var(target_entry);
 
 	root.parent = NULL;
 	root.class = hlock_class(this);
 	ret = find_usage_forwards(&root, bit, &target_entry);
-	if (ret < 0)
+	if (bfs_error(ret))
 		return print_bfs_bug(ret);
-	if (ret == 1)
+	if (ret == BFS_RNOMATCH)
 		return ret;
 
 	return print_irq_inversion_bug(curr, &root, target_entry,
@@ -2657,17 +2681,17 @@ static int
 check_usage_backwards(struct task_struct *curr, struct held_lock *this,
 		      enum lock_usage_bit bit, const char *irqclass)
 {
-	int ret;
+	enum bfs_result ret;
 	struct lock_list root;
 	struct lock_list *uninitialized_var(target_entry);
 
 	root.parent = NULL;
 	root.class = hlock_class(this);
 	ret = find_usage_backwards(&root, bit, &target_entry);
-	if (ret < 0)
+	if (bfs_error(ret))
 		return print_bfs_bug(ret);
-	if (ret == 1)
-		return ret;
+	if (ret == BFS_RNOMATCH)
+		return 1;
 
 	return print_irq_inversion_bug(curr, &root, target_entry,
 					this, 0, irqclass);
-- 
2.16.2
