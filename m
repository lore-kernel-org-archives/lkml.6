Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753562AbeDKNr6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 09:47:58 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:55653 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753353AbeDKNrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 09:47:53 -0400
X-Google-Smtp-Source: AIpwx48pkYbnhgnFMCiwgq4H6vrTxZAZNZDmQjkesa8behlRcu2BYHXjp4LgvLECnVxzxXAuwYpTlg==
X-ME-Sender: <xms:BRLOWhT6gpR_0QAyxmwa-3Fo-NIq5cirhjDl4Mr797K8222mgRJbjw>
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC tip/locking/lockdep v6 11/20] lockdep: Fix recursive read lock related safe->unsafe detection
Date: Wed, 11 Apr 2018 21:51:01 +0800
Message-Id: <20180411135110.9217-12-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180411135110.9217-1-boqun.feng@gmail.com>
References: <20180411135110.9217-1-boqun.feng@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

irq-safe -> irq-unsafe lock dependency is illegal, because it could
introduce the "irq inversion" problem, that is when a irq-unsafe lock
is held, some one else interrupts and tries to acquire irq-safe lock.
And that case adds a temporary from irq-unsafe to irq-safe, as a result,
deadlock.

There are four cases for irq inversion deadlocks:

(-(X..Y)-> means a strong dependency path starts with a --(X*)-->
dependency and ends with a --(*Y)-- dependency.)

1.	An irq-safe lock L1 has a dependency -> .. -> to an
	irq-unsafe lock L2.

2.	An irq-read-safe lock L1 has a dependency -(N*)-> .. -> to an
	irq-unsafe lock L2.

3.	An irq-safe lock L1 has a dependency -> .. -(*N)-> to an
	irq-read-unsafe lock L2.

4.	An irq-read-safe lock L1 has a dependency -(N*)-> .. -(*N)-> to
	an irq-read-unsafe lock L2.

The current check_usage() only checks 1) and 2), with the enhanced
__bfs(), we could combine all the four in find_usage_{back,for}wards(),
by using another match function. The idea is, if we are in dependency
path L1 -> .. -> L2, and the temporary irq inversion dependency for
unsafe to safe is L2 -> L1. We need a strong dependency path/circle for
L1 -> .. -> L2 -> L1 to prove it's a deadlock. So that we need either L2
-> L1 is *N or L1 -> .. -> L2 is N*, that means either L1 is
irq-(write-)safe lock or backwards BFS search finds the ->only_xr is
false for L1. Like wise for L2. usage_match() is updated for exactly
this logic.

Moveover, with the new find_usage_{back,for}wards(), mark_lock_irq() can
be simplified and since self inversion case is already covered, we can
further kill valid_state().

Another thing is that since we now find the inversion in one search, and
__bfs() only report whether a match is found or not, we are then lack of
the information for print_bad_irq_dependency(), so we introduce a new
function match_bit(), which returns the matched usage bit in __bfs(),
and it must be called after we find a match.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
Peter,

I went further than our discussion:

	https://marc.info/?l=linux-kernel&m=151938583827331

, I found we can actually only need one backwards BFS and one forwards
BFS for check_irq_usage(), there is no need for two check_usage()s
there, so I open-coded check_usage() into check_irq_usage() and cleaned
other things.

Given that I added quite a few lines of comments, so the diff actually
shows we save a few lines of code.

 kernel/locking/lockdep.c | 299 ++++++++++++++++++++++++++---------------------
 1 file changed, 163 insertions(+), 136 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 6135d1836ed3..18eb76189727 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -461,6 +461,26 @@ static const char *usage_str[] =
 	[LOCK_USED] = "INITIAL USE",
 };
 
+static const char * const state_names[] = {
+#define LOCKDEP_STATE(__STATE) \
+	__stringify(__STATE),
+#include "lockdep_states.h"
+#undef LOCKDEP_STATE
+};
+
+static const char * const state_rnames[] = {
+#define LOCKDEP_STATE(__STATE) \
+	__stringify(__STATE)"-RR",
+#include "lockdep_states.h"
+#undef LOCKDEP_STATE
+};
+
+static inline const char *state_name(enum lock_usage_bit bit)
+{
+	return (bit & 1) ? state_rnames[bit >> 2] : state_names[bit >> 2];
+}
+
+
 const char * __get_key_name(struct lockdep_subclass_key *key, char *str)
 {
 	return kallsyms_lookup((unsigned long)key, NULL, NULL, NULL, str);
@@ -1542,11 +1562,44 @@ check_redundant(struct lock_list *root, struct held_lock *target,
  * Forwards and backwards subgraph searching, for the purposes of
  * proving that two subgraphs can be connected by a new dependency
  * without creating any illegal irq-safe -> irq-unsafe lock dependency.
+ *
+ * irq-safe -> irq-unsafe lock dependency is illegal, because it could happen
+ * that when irq-unsafe lock L2 is held, an interrupt happens and the
+ * corresponding handler tries to acquire irq-safe lock L1, and that creates
+ * a temporary dependency L2 -> L1, and since we already find a dependency from
+ * L1 to L2, which means we have a cirlce L2 -> L1 -> .. -> L2. But note that
+ * the circle has to be a strong path for a deadlock, so we need to rule out
+ * case where 1) L1 -> .. -> L2 is R* and L1 is only irq-read-safe lock and 2)
+ * L1 -> .. -> L2 is *R and L2 is only irq-read-unsafe lock.
  */
 
+/*
+ * The match function for usage checks.
+ *
+ * As above, if in the BFS, entry->only_xr is true (means L1 -> .. is R* in
+ * backwards searching or .. -> L2 is *R in forwards searching), then read
+ * usage of @entry doesn't count as strong. So we only test read usage if
+ * entry->only_xr is false.
+ *
+ * In other words, if we find a write usage (either irq-safe or irq-unsafe), we
+ * don't need to care about the type of the path (i.e. we need to care
+ * ->only_xr). Otherwise, ->only_xr has to be false, and we also need a read
+ * usage.
+ */
 static inline bool usage_match(struct lock_list *entry, void *bit)
 {
-	return entry->class->usage_mask & (1 << (enum lock_usage_bit)bit);
+	enum lock_usage_bit ub = (enum lock_usage_bit)bit;
+	unsigned long mask;
+	unsigned long read_mask;
+	unsigned long usage;
+
+	ub &= ~1; /* remove the read usage bit */
+	mask = 1UL << ub;
+	read_mask = 1UL << (ub + 1);
+	usage = entry->class->usage_mask;
+
+	return (usage & mask) || /* write usage works with any path */
+	       (!entry->only_xr && (usage & read_mask)); /* read usage only works with *N path */
 }
 
 
@@ -1708,8 +1761,7 @@ print_bad_irq_dependency(struct task_struct *curr,
 			 struct held_lock *prev,
 			 struct held_lock *next,
 			 enum lock_usage_bit bit1,
-			 enum lock_usage_bit bit2,
-			 const char *irqclass)
+			 enum lock_usage_bit bit2)
 {
 	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
 		return 0;
@@ -1717,7 +1769,7 @@ print_bad_irq_dependency(struct task_struct *curr,
 	pr_warn("\n");
 	pr_warn("=====================================================\n");
 	pr_warn("WARNING: %s-safe -> %s-unsafe lock order detected\n",
-		irqclass, irqclass);
+		state_name(bit1), state_name(bit2));
 	print_kernel_ident();
 	pr_warn("-----------------------------------------------------\n");
 	pr_warn("%s/%d [HC%u[%lu]:SC%u[%lu]:HE%u:SE%u] is trying to acquire:\n",
@@ -1737,15 +1789,15 @@ print_bad_irq_dependency(struct task_struct *curr,
 	pr_cont("\n");
 
 	pr_warn("\nbut this new dependency connects a %s-irq-safe lock:\n",
-		irqclass);
+		state_name(bit1));
 	print_lock_name(backwards_entry->class);
-	pr_warn("\n... which became %s-irq-safe at:\n", irqclass);
+	pr_warn("\n... which became %s-irq-safe at:\n", state_name(bit1));
 
 	print_stack_trace(backwards_entry->class->usage_traces + bit1, 1);
 
-	pr_warn("\nto a %s-irq-unsafe lock:\n", irqclass);
+	pr_warn("\nto a %s-irq-unsafe lock:\n", state_name(bit2));
 	print_lock_name(forwards_entry->class);
-	pr_warn("\n... which became %s-irq-unsafe at:\n", irqclass);
+	pr_warn("\n... which became %s-irq-unsafe at:\n", state_name(bit2));
 	pr_warn("...");
 
 	print_stack_trace(forwards_entry->class->usage_traces + bit2, 1);
@@ -1756,13 +1808,13 @@ print_bad_irq_dependency(struct task_struct *curr,
 
 	lockdep_print_held_locks(curr);
 
-	pr_warn("\nthe dependencies between %s-irq-safe lock and the holding lock:\n", irqclass);
+	pr_warn("\nthe dependencies between %s-irq-safe lock and the holding lock:\n", state_name(bit1));
 	if (!save_trace(&prev_root->trace))
 		return 0;
 	print_shortest_lock_dependencies(backwards_entry, prev_root);
 
 	pr_warn("\nthe dependencies between the lock to be acquired");
-	pr_warn(" and %s-irq-unsafe lock:\n", irqclass);
+	pr_warn(" and %s-irq-unsafe lock:\n", state_name(bit2));
 	if (!save_trace(&next_root->trace))
 		return 0;
 	print_shortest_lock_dependencies(forwards_entry, next_root);
@@ -1773,55 +1825,6 @@ print_bad_irq_dependency(struct task_struct *curr,
 	return 0;
 }
 
-static int
-check_usage(struct task_struct *curr, struct held_lock *prev,
-	    struct held_lock *next, enum lock_usage_bit bit_backwards,
-	    enum lock_usage_bit bit_forwards, const char *irqclass)
-{
-	int ret;
-	struct lock_list this, that;
-	struct lock_list *uninitialized_var(target_entry);
-	struct lock_list *uninitialized_var(target_entry1);
-
-	bfs_init_root(&this, prev);
-	ret = find_usage_backwards(&this, bit_backwards, &target_entry);
-	if (bfs_error(ret))
-		return print_bfs_bug(ret);
-	if (ret == BFS_RNOMATCH)
-		return 1;
-
-	bfs_init_root(&that, next);
-	ret = find_usage_forwards(&that, bit_forwards, &target_entry1);
-	if (bfs_error(ret))
-		return print_bfs_bug(ret);
-	if (ret == BFS_RNOMATCH)
-		return 1;
-
-	return print_bad_irq_dependency(curr, &this, &that,
-			target_entry, target_entry1,
-			prev, next,
-			bit_backwards, bit_forwards, irqclass);
-}
-
-static const char *state_names[] = {
-#define LOCKDEP_STATE(__STATE) \
-	__stringify(__STATE),
-#include "lockdep_states.h"
-#undef LOCKDEP_STATE
-};
-
-static const char *state_rnames[] = {
-#define LOCKDEP_STATE(__STATE) \
-	__stringify(__STATE)"-RR",
-#include "lockdep_states.h"
-#undef LOCKDEP_STATE
-};
-
-static inline const char *state_name(enum lock_usage_bit bit)
-{
-	return (bit & 1) ? state_rnames[bit >> 2] : state_names[bit >> 2];
-}
-
 static int exclusive_bit(int new_bit)
 {
 	/*
@@ -1844,32 +1847,66 @@ static int exclusive_bit(int new_bit)
 	return state | (dir ^ 2);
 }
 
+/*
+ * We found a lock L whose class is @entry->class and L has a usage matching
+ * @dir_bit with usage_match() in a BFS search. And we need to figure out which
+ * exact usage bit is matched by usage_match().
+ *
+ * This function must be called after find_usage_{for,back)wards() and we find
+ * a match.
+ *
+ * Since we already find a match, if the lock doesn't have write usage, that
+ * means the usage we matched was read usage, otherwise it was write usage
+ * (because we check write usage in usage_match() first).
+ */
+static enum lock_usage_bit match_bit(struct lock_list *entry,
+				     enum lock_usage_bit dir_bit)
+{
+	unsigned long mask = 1UL << dir_bit;
+	unsigned long usage = entry->class->usage_mask;
+
+	return dir_bit + !(usage & mask);
+}
+
 static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
-			   struct held_lock *next, enum lock_usage_bit bit)
+			   struct held_lock *next, enum lock_usage_bit dir_bit)
 {
-	/*
-	 * Prove that the new dependency does not connect a hardirq-safe
-	 * lock with a hardirq-unsafe lock - to achieve this we search
-	 * the backwards-subgraph starting at <prev>, and the
-	 * forwards-subgraph starting at <next>:
-	 */
-	if (!check_usage(curr, prev, next, bit,
-			   exclusive_bit(bit), state_name(bit)))
-		return 0;
+	int ret;
+	struct lock_list this, that;
+	struct lock_list *uninitialized_var(target_entry);
+	struct lock_list *uninitialized_var(target_entry1);
+	enum lock_usage_bit excl_bit;
 
-	bit++; /* _READ */
+	/* the read/write bit should be zero */
+	if (WARN_ON_ONCE(dir_bit & 1))
+		dir_bit &= ~1;
+
+	excl_bit = exclusive_bit(dir_bit);
 
 	/*
-	 * Prove that the new dependency does not connect a hardirq-safe-read
-	 * lock with a hardirq-unsafe lock - to achieve this we search
-	 * the backwards-subgraph starting at <prev>, and the
-	 * forwards-subgraph starting at <next>:
+	 * Prove that the new dependency does not connect a irq-safe lock with
+	 * a irq-unsafe lock - to achieve this we search the backwards-subgraph
+	 * starting at <prev>, and the forwards-subgraph starting at <next>:
 	 */
-	if (!check_usage(curr, prev, next, bit,
-			   exclusive_bit(bit), state_name(bit)))
-		return 0;
+	bfs_init_root(&this, prev);
+	ret = find_usage_backwards(&this, dir_bit, &target_entry);
+	if (bfs_error(ret))
+		return print_bfs_bug(ret);
+	if (ret == BFS_RNOMATCH)
+		return 1;
 
-	return 1;
+	bfs_init_root(&that, next);
+	ret = find_usage_forwards(&that, excl_bit, &target_entry1);
+	if (bfs_error(ret))
+		return print_bfs_bug(ret);
+	if (ret == BFS_RNOMATCH)
+		return 1;
+
+	return print_bad_irq_dependency(curr, &this, &that,
+			target_entry, target_entry1,
+			prev, next,
+			match_bit(target_entry, dir_bit),
+			match_bit(target_entry1, excl_bit));
 }
 
 static int
@@ -2782,18 +2819,6 @@ print_usage_bug(struct task_struct *curr, struct held_lock *this,
 	return 0;
 }
 
-/*
- * Print out an error if an invalid bit is set:
- */
-static inline int
-valid_state(struct task_struct *curr, struct held_lock *this,
-	    enum lock_usage_bit new_bit, enum lock_usage_bit bad_bit)
-{
-	if (unlikely(hlock_class(this)->usage_mask & (1 << bad_bit)))
-		return print_usage_bug(curr, this, bad_bit, new_bit);
-	return 1;
-}
-
 static int mark_lock(struct task_struct *curr, struct held_lock *this,
 		     enum lock_usage_bit new_bit);
 
@@ -2863,27 +2888,48 @@ print_irq_inversion_bug(struct task_struct *curr,
 	return 0;
 }
 
+/*
+ * Forwards and backwards subgraph searching, for the purposes of
+ * proving that a dependency path can become an illegal irq-safe ->
+ * irq-unsafe lock dependency because of the newly usage found.
+ *
+ * A special case other than what we describe in comments before usage_match()
+ * is, a lock L adds usage USED_IN while it already has ENABLED usage or vice
+ * versa, unless a lock only adds USED_IN_READ or ENABLED_READ usage to each
+ * other, which is not a deadlock.
+ *
+ * In the special case, find_usage_forwards() and find_usage_backwards() still
+ * work, because __bfs() will first try the root node. We just need to split
+ * this out for a different debug report (self irq inversion).
+ */
+
 /*
  * Prove that in the forwards-direction subgraph starting at <this>
  * there is no lock matching <mask>:
  */
 static int
 check_usage_forwards(struct task_struct *curr, struct held_lock *this,
-		     enum lock_usage_bit bit, const char *irqclass)
+		     enum lock_usage_bit bit, enum lock_usage_bit excl_bit)
 {
 	enum bfs_result ret;
 	struct lock_list root;
 	struct lock_list *uninitialized_var(target_entry);
 
 	bfs_init_root(&root, this);
-	ret = find_usage_forwards(&root, bit, &target_entry);
+	ret = find_usage_forwards(&root, excl_bit, &target_entry);
 	if (bfs_error(ret))
 		return print_bfs_bug(ret);
 	if (ret == BFS_RNOMATCH)
 		return ret;
 
-	return print_irq_inversion_bug(curr, &root, target_entry,
-					this, 1, irqclass);
+	/* self inversion */
+	if (target_entry->class == hlock_class(this))
+		return print_usage_bug(curr, this,
+				       match_bit(target_entry, excl_bit),
+				       bit);
+	else
+		return print_irq_inversion_bug(curr, &root, target_entry,
+					       this, 1, state_name(bit));
 }
 
 /*
@@ -2892,21 +2938,27 @@ check_usage_forwards(struct task_struct *curr, struct held_lock *this,
  */
 static int
 check_usage_backwards(struct task_struct *curr, struct held_lock *this,
-		      enum lock_usage_bit bit, const char *irqclass)
+		      enum lock_usage_bit bit, enum lock_usage_bit excl_bit)
 {
 	enum bfs_result ret;
 	struct lock_list root;
 	struct lock_list *uninitialized_var(target_entry);
 
 	bfs_init_root(&root, this);
-	ret = find_usage_backwards(&root, bit, &target_entry);
+	ret = find_usage_backwards(&root, excl_bit, &target_entry);
 	if (bfs_error(ret))
 		return print_bfs_bug(ret);
 	if (ret == BFS_RNOMATCH)
 		return 1;
 
-	return print_irq_inversion_bug(curr, &root, target_entry,
-					this, 0, irqclass);
+	/* self inversion */
+	if (target_entry->class == hlock_class(this))
+		return print_usage_bug(curr, this,
+				       match_bit(target_entry, excl_bit),
+				       bit);
+	else
+		return print_irq_inversion_bug(curr, &root, target_entry,
+					       this, 0, state_name(bit));
 }
 
 void print_irqtrace_events(struct task_struct *curr)
@@ -2942,8 +2994,6 @@ static int SOFTIRQ_verbose(struct lock_class *class)
 	return 0;
 }
 
-#define STRICT_READ_CHECKS	1
-
 static int (*state_verbose_f[])(struct lock_class *class) = {
 #define LOCKDEP_STATE(__STATE) \
 	__STATE##_verbose,
@@ -2965,44 +3015,21 @@ mark_lock_irq(struct task_struct *curr, struct held_lock *this,
 		enum lock_usage_bit new_bit)
 {
 	int excl_bit = exclusive_bit(new_bit);
-	int read = new_bit & 1;
-	int dir = new_bit & 2;
-
-	/*
-	 * mark USED_IN has to look forwards -- to ensure no dependency
-	 * has ENABLED state, which would allow recursion deadlocks.
-	 *
-	 * mark ENABLED has to look backwards -- to ensure no dependee
-	 * has USED_IN state, which, again, would allow  recursion deadlocks.
-	 */
-	check_usage_f usage = dir ?
-		check_usage_backwards : check_usage_forwards;
 
-	/*
-	 * Validate that this particular lock does not have conflicting
-	 * usage states.
-	 */
-	if (!valid_state(curr, this, new_bit, excl_bit))
-		return 0;
-
-	/*
-	 * Validate that the lock dependencies don't have conflicting usage
-	 * states.
-	 */
-	if ((!read || !dir || STRICT_READ_CHECKS) &&
-			!usage(curr, this, excl_bit, state_name(new_bit & ~1)))
-		return 0;
-
-	/*
-	 * Check for read in write conflicts
-	 */
-	if (!read) {
-		if (!valid_state(curr, this, new_bit, excl_bit + 1))
+	if (new_bit & 2) {
+		/*
+		 * mark ENABLED has to look backwards -- to ensure no dependee
+		 * has USED_IN state, which, again, would allow recursion
+		 * deadlocks.
+		 */
+		if (!check_usage_backwards(curr, this, new_bit, excl_bit))
 			return 0;
-
-		if (STRICT_READ_CHECKS &&
-			!usage(curr, this, excl_bit + 1,
-				state_name(new_bit + 1)))
+	} else {
+		/*
+		 * mark USED_IN has to look forwards -- to ensure no dependency
+		 * has ENABLED state, which would allow recursion deadlocks.
+		 */
+		if (!check_usage_forwards(curr, this, new_bit, excl_bit))
 			return 0;
 	}
 
-- 
2.16.2
