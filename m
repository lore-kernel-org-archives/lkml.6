Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753658AbeDKNsG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 09:48:06 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:39753 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753596AbeDKNsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 09:48:03 -0400
X-Google-Smtp-Source: AIpwx49ISAmKp9wB4LLMnrjgBWKowH96SiA4DC02OBlq/6fyZsgOQhy8Gx3F1UZNqHvCHm3pqE3b8w==
X-ME-Sender: <xms:DxLOWjbYYUViSmxLHJWoKZR0R5mE8E6TnjfODJUd3U9iAzgcKfi7vw>
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC tip/locking/lockdep v6 14/20] lockdep: Take read/write status in consideration when generate chainkey
Date: Wed, 11 Apr 2018 21:51:04 +0800
Message-Id: <20180411135110.9217-15-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180411135110.9217-1-boqun.feng@gmail.com>
References: <20180411135110.9217-1-boqun.feng@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the chainkey of a lock chain is a hash sum of the class_idx
of all the held locks, the read/write status are not taken in to
consideration while generating the chainkey. This could result into a
problem, if we have:

	P1()
	{
		read_lock(B);
		lock(A);
	}

	P2()
	{
		lock(A);
		read_lock(B);
	}

	P3()
	{
		lock(A);
		write_lock(B);
	}

, and P1(), P2(), P3() run one by one. And when running P2(), lockdep
detects such a lock chain A -> B is not a deadlock, then it's added in
the chain cache, and then when running P3(), even if it's a deadlock, we
could miss it because of the hit of chain cache. This could be confirmed
by self testcase "chain cached mixed R-L/L-W ".

To resolve this, we use concept "hlock_id" to generate the chainkey, the
hlock_id is a tuple (hlock->class_idx, hlock->read), which fits in a u16
type. With this, the chainkeys are different is the lock sequences have
the same locks but different read/write status.

Besides, since we use "hlock_id" to generate chainkeys, the chain_hlocks
array now store the "hlock_id"s rather than lock_class indexes.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/locking/lockdep.c | 56 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 20 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 45a370438add..d88fded8b339 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -307,6 +307,21 @@ static struct hlist_head classhash_table[CLASSHASH_SIZE];
 
 static struct hlist_head chainhash_table[CHAINHASH_SIZE];
 
+/*
+ * the id of held_lock
+ */
+static inline u16 hlock_id(struct held_lock *hlock)
+{
+	BUILD_BUG_ON(MAX_LOCKDEP_KEYS_BITS + 2 > 16);
+
+	return (hlock->class_idx | (hlock->read << MAX_LOCKDEP_KEYS_BITS));
+}
+
+static inline unsigned int chain_hlock_class_idx(u16 hlock_id)
+{
+	return hlock_id & MAX_LOCKDEP_KEYS;
+}
+
 /*
  * The hash key of the lock dependency chains is a hash itself too:
  * it's a hash of all locks taken up to that lock, including that lock.
@@ -2283,7 +2298,10 @@ static u16 chain_hlocks[MAX_LOCKDEP_CHAIN_HLOCKS];
 
 struct lock_class *lock_chain_get_class(struct lock_chain *chain, int i)
 {
-	return lock_classes + chain_hlocks[chain->base + i];
+	u16 chain_hlock = chain_hlocks[chain->base + i];
+	unsigned int class_idx = chain_hlock_class_idx(chain_hlock);
+
+	return lock_classes + class_idx - 1;
 }
 
 /*
@@ -2309,12 +2327,12 @@ static inline int get_first_held_lock(struct task_struct *curr,
 /*
  * Returns the next chain_key iteration
  */
-static u64 print_chain_key_iteration(int class_idx, u64 chain_key)
+static u64 print_chain_key_iteration(u16 hlock_id, u64 chain_key)
 {
-	u64 new_chain_key = iterate_chain_key(chain_key, class_idx);
+	u64 new_chain_key = iterate_chain_key(chain_key, hlock_id);
 
-	printk(" class_idx:%d -> chain_key:%016Lx",
-		class_idx,
+	printk(" hlock_id:%d -> chain_key:%016Lx",
+		(unsigned int)hlock_id,
 		(unsigned long long)new_chain_key);
 	return new_chain_key;
 }
@@ -2330,12 +2348,12 @@ print_chain_keys_held_locks(struct task_struct *curr, struct held_lock *hlock_ne
 	printk("depth: %u\n", depth + 1);
 	for (i = get_first_held_lock(curr, hlock_next); i < depth; i++) {
 		hlock = curr->held_locks + i;
-		chain_key = print_chain_key_iteration(hlock->class_idx, chain_key);
+		chain_key = print_chain_key_iteration(hlock_id(hlock), chain_key);
 
 		print_lock(hlock);
 	}
 
-	print_chain_key_iteration(hlock_next->class_idx, chain_key);
+	print_chain_key_iteration(hlock_id(hlock_next), chain_key);
 	print_lock(hlock_next);
 }
 
@@ -2343,14 +2361,14 @@ static void print_chain_keys_chain(struct lock_chain *chain)
 {
 	int i;
 	u64 chain_key = 0;
-	int class_id;
+	u16 hlock_id;
 
 	printk("depth: %u\n", chain->depth);
 	for (i = 0; i < chain->depth; i++) {
-		class_id = chain_hlocks[chain->base + i];
-		chain_key = print_chain_key_iteration(class_id + 1, chain_key);
+		hlock_id = chain_hlocks[chain->base + i];
+		chain_key = print_chain_key_iteration(hlock_id, chain_key);
 
-		print_lock_name(lock_classes + class_id);
+		print_lock_name(lock_classes + chain_hlock_class_idx(hlock_id) - 1);
 		printk("\n");
 	}
 }
@@ -2399,7 +2417,7 @@ static int check_no_collision(struct task_struct *curr,
 	}
 
 	for (j = 0; j < chain->depth - 1; j++, i++) {
-		id = curr->held_locks[i].class_idx - 1;
+		id = hlock_id(&curr->held_locks[i]);
 
 		if (DEBUG_LOCKS_WARN_ON(chain_hlocks[chain->base + j] != id)) {
 			print_collision(curr, hlock, chain);
@@ -2456,8 +2474,8 @@ static inline int add_chain_cache_classes(unsigned int prev,
 	if (likely(nr_chain_hlocks + chain->depth <= MAX_LOCKDEP_CHAIN_HLOCKS)) {
 		chain->base = nr_chain_hlocks;
 		nr_chain_hlocks += chain->depth;
-		chain_hlocks[chain->base] = prev - 1;
-		chain_hlocks[chain->base + 1] = next -1;
+		chain_hlocks[chain->base] = prev;
+		chain_hlocks[chain->base + 1] = next;
 	}
 #ifdef CONFIG_DEBUG_LOCKDEP
 	/*
@@ -2491,7 +2509,6 @@ static inline int add_chain_cache(struct task_struct *curr,
 				  struct held_lock *hlock,
 				  u64 chain_key)
 {
-	struct lock_class *class = hlock_class(hlock);
 	struct hlist_head *hash_head = chainhashentry(chain_key);
 	struct lock_chain *chain;
 	int i, j;
@@ -2530,10 +2547,9 @@ static inline int add_chain_cache(struct task_struct *curr,
 	if (likely(nr_chain_hlocks + chain->depth <= MAX_LOCKDEP_CHAIN_HLOCKS)) {
 		chain->base = nr_chain_hlocks;
 		for (j = 0; j < chain->depth - 1; j++, i++) {
-			int lock_id = curr->held_locks[i].class_idx - 1;
-			chain_hlocks[chain->base + j] = lock_id;
+			chain_hlocks[chain->base + j] = hlock_id(&curr->held_locks[i]);
 		}
-		chain_hlocks[chain->base + j] = class - lock_classes;
+		chain_hlocks[chain->base + j] = hlock_id(hlock);
 	}
 
 	if (nr_chain_hlocks < MAX_LOCKDEP_CHAIN_HLOCKS)
@@ -2731,7 +2747,7 @@ static void check_chain_key(struct task_struct *curr)
 		if (prev_hlock && (prev_hlock->irq_context !=
 							hlock->irq_context))
 			chain_key = 0;
-		chain_key = iterate_chain_key(chain_key, hlock->class_idx);
+		chain_key = iterate_chain_key(chain_key, hlock_id(hlock));
 		prev_hlock = hlock;
 	}
 	if (chain_key != curr->curr_chain_key) {
@@ -3672,7 +3688,7 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 		chain_key = 0;
 		chain_head = 1;
 	}
-	chain_key = iterate_chain_key(chain_key, class_idx);
+	chain_key = iterate_chain_key(chain_key, hlock_id(hlock));
 
 	if (nest_lock && !__lock_is_held(nest_lock, -1))
 		return print_lock_nested_lock_not_held(curr, hlock, ip);
-- 
2.16.2
