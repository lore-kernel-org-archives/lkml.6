Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B320C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8A0420859
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="ih5WiLBU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbfAIVEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:04:00 -0500
Received: from com-out001.mailprotect.be ([83.217.72.83]:58127 "EHLO
        com-out001.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbfAIVC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:02:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=fFWGKbyEOpIaCgVNueN2YI3tPLsYWvQJYrPStqrnRcY=; b=ih5WiLBUZt27
        L3EhD1mGnILSi/DVXG4aLT/cTDdsdcBDgvnbzrinY0RQB+QE8n9enOzt0ZPAIaujSjv0uS0itsgFA
        8KOQXaoqwV2tF8h8WzGiF8C76NBDE6JQYiIMqm84yWQrTcT1VDBYBRM3UStePEbAso9PFKurZWDqM
        WyAE5080IWoSO0jMf9zBNIlU0OJkmnDODn13wG455QPFr6zfzdxW0Hc1rizQIvVdRPF0IxCLLoNoy
        efOEcJgH73GV+ThU28D6GPmKKYFupKeZpvDJLhseOmEL92Y2f0S4TtiqjgGMcbnfCgEAzK+ckcPGw
        42OgoNtm8GcxBJVFv3tt3w==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out001.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1ghKzn-0009GI-5A; Wed, 09 Jan 2019 22:02:40 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 866A2C16CC;
        Wed,  9 Jan 2019 22:02:33 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v6 08/16] locking/lockdep: Free lock classes that are no longer in use
Date:   Wed,  9 Jan 2019 13:01:56 -0800
Message-Id: <20190109210204.192109-9-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
In-Reply-To: <20190109210204.192109-1-bvanassche@acm.org>
References: <20190109210204.192109-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.159
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.000156895090224)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5iY8b2cn65l9EC/bV7Ix3Xp602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTb/+zriNZuqQk0xRpGwjn+MTR8dtByWYYhgj25jR+mEA3YO
 AtfhCcV13BpIh8lqRXSSiFVwqwU9VgKUrYQ0lqWyFDaym8oavoPYsm7m1mVEGf0/5ST3nkt5XYDK
 YAuRpmF7E2F3eqKXiTd2ECUghryWXlqwG31yUGf3t09vBVYS71V1Pk0aHudBU1wyWVTA5OYS1waI
 XXCBiQFDV0yen8nGcSeERs4TOTnIH1kc1IWc5eLazqbUYkjl7F1LyK0RORrdMXPGqLfOiZ4TdB0w
 uo3CSNgvEAWLFiDAlQR6Wu0I/iWDegq4fQ11AxLVlrI7DVFg5Rj2g0fgHrO2rAGaVRcnzDg6HYuT
 CyYgL61SIkBTYXPEvhymCNb22qmKERGbL1SqvGGff0htQqhQf0/aDrhpLM4xnCPpmyyS7jgD9Nen
 VVoB/PLX+rmdznc91veCJAwpCI+5VHpzDqRcT2+GtIE8SRAgmLDKAcp9i+Q+BEiSUj07SNjVkl0P
 Pj+OUYZX3/3Z86X+I1ED1LLv7p/g4HOOdbYb9IXfYGRpVS/0hA4Mwp9kB6JZdl+SJy+nWImyKEy/
 zJE11ZjKQFiKV8EwnkodMjMm/D2rEPnNAuCCnt9B91Ax/uigYcgpQGDKFCrOdd8gr/U0flMcy2Vi
 /IcBgY4aVBKUAPQbBk8nfWT8Lcjyyn9ZSA9YgSwQmLSJwsFnO3lUxpF8dVvwCXY/4mE1q/c/lcBJ
 DmoxYxZqr5EVgTOQJIReCVVSIHe/oUqzWQIU6rX79QypMr8dGmZdMzAY/ZjlX1KrFIDnIhhlHDLh
 vRwgYpikjrjEsQHYqzPksYepQjQSeP/rn+UB/EmrduGPxHj/dKsQ+WcgzL7pTOYRE2yEvlBrMyfp
 YuyanAZpMXssfrVwLrD8rqLg0SqQCDr4y/2aC8ww5eazzjRVtQFeHJ7hVjcwtdnaeUBdv4ES1amK
 6MjYhBKQrXFod+WvUUP1Uys1SCu8wQmWlqgUhZKbKdwa/OuO5TcDeKjrEmYPn2IVWRtfdRHps2br
 TOkutpvyrdmtvbYO9ASW9x0dzW2b+IEXgSV5FVT0nNNOs1IDBtijAxf8XG910biZEcomWehz4u8s
 zDg6HYuTCyYgL61SIkBTYSiCBqrB4vMmHpjmx6wTDBzk2EPy497nssgnoMkIb3rMdj8luXC7km26
 QtXP9s02LA==
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of leaving lock classes that are no longer in use in the
lock_classes array, reuse entries from that array that are no longer
in use. Maintain a linked list of free lock classes with list head
'free_lock_class'. Initialize that list from inside register_lock_class()
instead of from inside lockdep_init() because register_lock_class() can
be called before lockdep_init() has been called. Only add freed lock
classes to the free_lock_classes list after a grace period to avoid that
a lock_classes[] element would be reused while an RCU reader is
accessing it. Since the lockdep selftests run in a context where
sleeping is not allowed and since the selftests require that lock
resetting/zapping works with debug_locks = 0, make the behavior of
lockdep_free_key_range() and lockdep_reset_lock() depend on whether
or not these are called from the context of the lockdep selftests.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/lockdep.h  |   9 +-
 kernel/locking/lockdep.c | 434 +++++++++++++++++++++++++++++++++------
 2 files changed, 381 insertions(+), 62 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 66eee1ba0f2a..619ec3f26cdc 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -63,7 +63,8 @@ extern struct lock_class_key __lockdep_no_validate__;
 #define LOCKSTAT_POINTS		4
 
 /*
- * The lock-class itself:
+ * The lock-class itself. The order of the structure members matters.
+ * reinit_class() zeroes the key member and all subsequent members.
  */
 struct lock_class {
 	/*
@@ -72,7 +73,9 @@ struct lock_class {
 	struct hlist_node		hash_entry;
 
 	/*
-	 * global list of all lock-classes:
+	 * Entry in all_lock_classes when in use. Entry in free_lock_classes
+	 * when not in use. Instances that are being freed are on one of the
+	 * zapped_classes lists.
 	 */
 	struct list_head		lock_entry;
 
@@ -104,7 +107,7 @@ struct lock_class {
 	unsigned long			contention_point[LOCKSTAT_POINTS];
 	unsigned long			contending_point[LOCKSTAT_POINTS];
 #endif
-};
+} __no_randomize_layout;
 
 #ifdef CONFIG_LOCK_STAT
 struct lock_time {
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 1e82ca4982b3..5b142f699503 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -50,6 +50,7 @@
 #include <linux/random.h>
 #include <linux/jhash.h>
 #include <linux/nmi.h>
+#include <linux/rcupdate.h>
 
 #include <asm/sections.h>
 
@@ -135,8 +136,8 @@ static struct lock_list list_entries[MAX_LOCKDEP_ENTRIES];
 /*
  * All data structures here are protected by the global debug_lock.
  *
- * Mutex key structs only get allocated, once during bootup, and never
- * get freed - this significantly simplifies the debugging code.
+ * nr_lock_classes is the number of elements of lock_classes[] that is
+ * in use.
  */
 unsigned long nr_lock_classes;
 #ifndef CONFIG_DEBUG_LOCKDEP
@@ -278,11 +279,25 @@ static inline void lock_release_holdtime(struct held_lock *hlock)
 #endif
 
 /*
- * We keep a global list of all lock classes. The list only grows,
- * never shrinks. The list is only accessed with the lockdep
- * spinlock lock held.
+ * We keep a global list of all lock classes. The list is only accessed with
+ * the lockdep spinlock lock held. free_lock_classes is a list with free
+ * elements. These elements are linked together by the lock_entry member in
+ * struct lock_class.
  */
 LIST_HEAD(all_lock_classes);
+static LIST_HEAD(free_lock_classes);
+/*
+ * A data structure for delayed freeing of data structures that may be
+ * accessed by RCU readers at the time these were freed. The size of the array
+ * is a compromise between minimizing the amount of memory used by this array
+ * and minimizing the number of wait_event() calls by get_pending_free_lock().
+ */
+static struct pending_free {
+	struct list_head zapped_classes;
+	struct rcu_head	 rcu_head;
+	bool		 scheduled;
+} pending_free[2];
+static DECLARE_WAIT_QUEUE_HEAD(rcu_cb);
 
 /*
  * The lockdep classes are in a hash-table as well, for fast lookup:
@@ -742,11 +757,13 @@ static bool assign_lock_key(struct lockdep_map *lock)
 }
 
 /*
- * Initialize the lock_classes[] array elements.
+ * Initialize the lock_classes[] array elements, the free_lock_classes list
+ * and also the pending_free[] array.
  */
 static void init_data_structures_once(void)
 {
 	static bool initialization_happened;
+	struct pending_free *pf;
 	int i;
 
 	if (likely(initialization_happened))
@@ -754,7 +771,14 @@ static void init_data_structures_once(void)
 
 	initialization_happened = true;
 
+	for (i = 0, pf = pending_free; i < ARRAY_SIZE(pending_free);
+	     i++, pf++) {
+		INIT_LIST_HEAD(&pf->zapped_classes);
+		init_rcu_head(&pf->rcu_head);
+	}
+
 	for (i = 0; i < ARRAY_SIZE(lock_classes); i++) {
+		list_add_tail(&lock_classes[i].lock_entry, &free_lock_classes);
 		INIT_LIST_HEAD(&lock_classes[i].locks_after);
 		INIT_LIST_HEAD(&lock_classes[i].locks_before);
 	}
@@ -802,11 +826,10 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 
 	init_data_structures_once();
 
-	/*
-	 * Allocate a new key from the static array, and add it to
-	 * the hash:
-	 */
-	if (nr_lock_classes >= MAX_LOCKDEP_KEYS) {
+	/* Allocate a new lock class and add it to the hash. */
+	class = list_first_entry_or_null(&free_lock_classes, typeof(*class),
+					 lock_entry);
+	if (!class) {
 		if (!debug_locks_off_graph_unlock()) {
 			return NULL;
 		}
@@ -815,7 +838,7 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 		dump_stack();
 		return NULL;
 	}
-	class = lock_classes + nr_lock_classes++;
+	nr_lock_classes++;
 	debug_atomic_inc(nr_unused_locks);
 	class->key = key;
 	class->name = lock->name;
@@ -829,9 +852,10 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 	 */
 	hlist_add_head_rcu(&class->hash_entry, hash_head);
 	/*
-	 * Add it to the global list of classes:
+	 * Remove the class from the free list and add it to the global list
+	 * of classes.
 	 */
-	list_add_tail(&class->lock_entry, &all_lock_classes);
+	list_move_tail(&class->lock_entry, &all_lock_classes);
 
 	if (verbose(class)) {
 		graph_unlock();
@@ -1871,6 +1895,24 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 	struct lock_list this;
 	int ret;
 
+	if (!hlock_class(prev)->key || !hlock_class(next)->key) {
+		/*
+		 * The warning statements below may trigger a use-after-free
+		 * of the class name. It is better to trigger a use-after free
+		 * and to have the class name most of the time instead of not
+		 * having the class name available.
+		 */
+		WARN_ONCE(!debug_locks_silent && !hlock_class(prev)->key,
+			  "Detected use-after-free of lock class %px/%s\n",
+			  hlock_class(prev),
+			  hlock_class(prev)->name);
+		WARN_ONCE(!debug_locks_silent && !hlock_class(next)->key,
+			  "Detected use-after-free of lock class %px/%s\n",
+			  hlock_class(next),
+			  hlock_class(next)->name);
+		return 2;
+	}
+
 	/*
 	 * Prove that the new <prev> -> <next> dependency would not
 	 * create a circular dependency in the graph. (We do this by
@@ -2253,19 +2295,16 @@ static inline int add_chain_cache(struct task_struct *curr,
 }
 
 /*
- * Look up a dependency chain.
+ * Look up a dependency chain. Must be called with either the graph lock or
+ * the RCU read lock held.
  */
 static inline struct lock_chain *lookup_chain_cache(u64 chain_key)
 {
 	struct hlist_head *hash_head = chainhashentry(chain_key);
 	struct lock_chain *chain;
 
-	/*
-	 * We can walk it lock-free, because entries only get added
-	 * to the hash:
-	 */
 	hlist_for_each_entry_rcu(chain, hash_head, entry) {
-		if (chain->chain_key == chain_key) {
+		if (READ_ONCE(chain->chain_key) == chain_key) {
 			debug_atomic_inc(chain_lookup_hits);
 			return chain;
 		}
@@ -3355,6 +3394,11 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	if (nest_lock && !__lock_is_held(nest_lock, -1))
 		return print_lock_nested_lock_not_held(curr, hlock, ip);
 
+	if (!debug_locks_silent) {
+		WARN_ON_ONCE(depth && !hlock_class(hlock - 1)->key);
+		WARN_ON_ONCE(!hlock_class(hlock)->key);
+	}
+
 	if (!validate_chain(curr, lock, hlock, chain_head, chain_key))
 		return 0;
 
@@ -4143,14 +4187,92 @@ void lockdep_reset(void)
 	raw_local_irq_restore(flags);
 }
 
+/* Remove a class from a lock chain. Must be called with the graph lock held. */
+static void remove_class_from_lock_chain(struct lock_chain *chain,
+					 struct lock_class *class)
+{
+#ifdef CONFIG_PROVE_LOCKING
+	struct lock_chain *new_chain;
+	u64 chain_key;
+	int i;
+
+	for (i = chain->base; i < chain->base + chain->depth; i++) {
+		if (chain_hlocks[i] != class - lock_classes)
+			continue;
+		/* The code below leaks one chain_hlock[] entry. */
+		if (--chain->depth > 0)
+			memmove(&chain_hlocks[i], &chain_hlocks[i + 1],
+				(chain->base + chain->depth - i) *
+				sizeof(chain_hlocks[0]));
+		/*
+		 * Each lock class occurs at most once in a lock chain so once
+		 * we found a match we can break out of this loop.
+		 */
+		goto recalc;
+	}
+	/* Since the chain has not been modified, return. */
+	return;
+
+recalc:
+	chain_key = 0;
+	for (i = chain->base; i < chain->base + chain->depth; i++)
+		chain_key = iterate_chain_key(chain_key, chain_hlocks[i] + 1);
+	if (chain->depth && chain->chain_key == chain_key)
+		return;
+	/* Overwrite the chain key for concurrent RCU readers. */
+	WRITE_ONCE(chain->chain_key, chain_key);
+	/*
+	 * Note: calling hlist_del_rcu() from inside a
+	 * hlist_for_each_entry_rcu() loop is safe.
+	 */
+	hlist_del_rcu(&chain->entry);
+	if (chain->depth == 0)
+		return;
+	/*
+	 * If the modified lock chain matches an existing lock chain, drop
+	 * the modified lock chain.
+	 */
+	if (lookup_chain_cache(chain_key))
+		return;
+	if (WARN_ON_ONCE(nr_lock_chains >= MAX_LOCKDEP_CHAINS)) {
+		debug_locks_off();
+		return;
+	}
+	/*
+	 * Leak *chain because it is not safe to reinsert it before an RCU
+	 * grace period has expired.
+	 */
+	new_chain = lock_chains + nr_lock_chains++;
+	*new_chain = *chain;
+	hlist_add_head_rcu(&new_chain->entry, chainhashentry(chain_key));
+#endif
+}
+
+/* Must be called with the graph lock held. */
+static void remove_class_from_lock_chains(struct lock_class *class)
+{
+	struct lock_chain *chain;
+	struct hlist_head *head;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(chainhash_table); i++) {
+		head = chainhash_table + i;
+		hlist_for_each_entry_rcu(chain, head, entry) {
+			remove_class_from_lock_chain(chain, class);
+		}
+	}
+}
+
 /*
  * Remove all references to a lock class. The caller must hold the graph lock.
  */
-static void zap_class(struct lock_class *class)
+static void zap_class(struct pending_free *pf, struct lock_class *class)
 {
 	struct lock_list *entry;
 	int i;
 
+	WARN_ON_ONCE(!class->key);
+
 	/*
 	 * Remove all dependencies this lock is
 	 * involved in:
@@ -4163,14 +4285,33 @@ static void zap_class(struct lock_class *class)
 		WRITE_ONCE(entry->class, NULL);
 		WRITE_ONCE(entry->links_to, NULL);
 	}
-	/*
-	 * Unhash the class and remove it from the all_lock_classes list:
-	 */
-	hlist_del_rcu(&class->hash_entry);
-	list_del(&class->lock_entry);
+	if (list_empty(&class->locks_after) &&
+	    list_empty(&class->locks_before)) {
+		list_move_tail(&class->lock_entry, &pf->zapped_classes);
+		hlist_del_rcu(&class->hash_entry);
+		WRITE_ONCE(class->key, NULL);
+		WRITE_ONCE(class->name, NULL);
+		nr_lock_classes--;
+	} else {
+		WARN_ONCE(true, "%s() failed for class %s\n", __func__,
+			  class->name);
+	}
 
-	RCU_INIT_POINTER(class->key, NULL);
-	RCU_INIT_POINTER(class->name, NULL);
+	remove_class_from_lock_chains(class);
+}
+
+static void reinit_class(struct lock_class *class)
+{
+	void *const p = class;
+	const unsigned int offset = offsetof(struct lock_class, key);
+
+	WARN_ON_ONCE(!class->lock_entry.next);
+	WARN_ON_ONCE(!list_empty(&class->locks_after));
+	WARN_ON_ONCE(!list_empty(&class->locks_before));
+	memset(p + offset, 0, sizeof(*class) - offset);
+	WARN_ON_ONCE(!class->lock_entry.next);
+	WARN_ON_ONCE(!list_empty(&class->locks_after));
+	WARN_ON_ONCE(!list_empty(&class->locks_before));
 }
 
 static inline int within(const void *addr, void *start, unsigned long size)
@@ -4178,7 +4319,118 @@ static inline int within(const void *addr, void *start, unsigned long size)
 	return addr >= start && addr < start + size;
 }
 
-static void __lockdep_free_key_range(void *start, unsigned long size)
+static bool inside_selftest(void)
+{
+	return current == lockdep_selftest_task_struct;
+}
+
+/*
+ * Free all lock classes that are on the pf->zapped_classes list. May be called
+ * from RCU callback context.
+ */
+static void free_zapped_classes(struct rcu_head *ch)
+{
+	struct pending_free *pf = container_of(ch, typeof(*pf), rcu_head);
+	struct lock_class *class;
+	unsigned long flags;
+
+	raw_local_irq_save(flags);
+	if (!graph_lock())
+		goto restore_irqs;
+	pf->scheduled = false;
+	list_for_each_entry(class, &pf->zapped_classes, lock_entry) {
+		reinit_class(class);
+	}
+	list_splice_init(&pf->zapped_classes, &free_lock_classes);
+	graph_unlock();
+restore_irqs:
+	raw_local_irq_restore(flags);
+
+	wake_up(&rcu_cb);
+}
+
+/* Schedule an RCU callback. Must be called with the graph lock held. */
+static void schedule_free_zapped_classes(struct pending_free *pf)
+{
+	WARN_ON_ONCE(inside_selftest());
+	pf->scheduled = true;
+	call_rcu(&pf->rcu_head, free_zapped_classes);
+}
+
+/*
+ * Find an element in the pending_free[] array for which no RCU callback is
+ * pending.
+ */
+static struct pending_free *get_pending_free(void)
+{
+	struct pending_free *pf;
+	int i;
+
+	for (i = 0, pf = pending_free; i < ARRAY_SIZE(pending_free);
+	     i++, pf++)
+		if (!pf->scheduled)
+			return pf;
+
+	return NULL;
+}
+
+/*
+ * Find an element in the pending_free[] array for which no RCU callback is
+ * pending and obtain the graph lock. May sleep.
+ */
+static struct pending_free *get_pending_free_lock(unsigned long *flags)
+{
+	struct pending_free *pf;
+
+	WARN_ON_ONCE(inside_selftest());
+
+	while (true) {
+		raw_local_irq_save(*flags);
+		if (!graph_lock()) {
+			raw_local_irq_restore(*flags);
+			return NULL;
+		}
+		pf = get_pending_free();
+		if (pf)
+			break;
+		graph_unlock();
+		raw_local_irq_restore(*flags);
+
+		wait_event(rcu_cb, get_pending_free() != NULL);
+	}
+
+	return pf;
+}
+
+/*
+ * Find an element in the pending_free[] array for which no RCU callback is
+ * pending and obtain the graph lock. Ignores debug_locks. Does not sleep.
+ */
+static struct pending_free *get_pending_free_lock_imm(unsigned long *flags)
+{
+	struct pending_free *pf;
+
+	WARN_ON_ONCE(!inside_selftest());
+
+	raw_local_irq_save(*flags);
+	arch_spin_lock(&lockdep_lock);
+	pf = get_pending_free();
+	if (!pf) {
+		arch_spin_unlock(&lockdep_lock);
+		raw_local_irq_restore(*flags);
+	}
+
+	return pf;
+}
+
+/*
+ * Remove all lock classes from the class hash table and from the
+ * all_lock_classes list whose key or name is in the address range [start,
+ * start + size). Move these lock classes to the zapped_classes list. Must
+ * be called with the graph lock held.
+ */
+static void __lockdep_free_key_range(struct pending_free *pf, void *start,
+				     unsigned long size)
 {
 	struct lock_class *class;
 	struct hlist_head *head;
@@ -4193,7 +4445,7 @@ static void __lockdep_free_key_range(void *start, unsigned long size)
 			if (!within(class->key, start, size) &&
 			    !within(class->name, start, size))
 				continue;
-			zap_class(class);
+			zap_class(pf, class);
 		}
 	}
 }
@@ -4206,40 +4458,68 @@ static void __lockdep_free_key_range(void *start, unsigned long size)
  * nobody will look up these exact classes -- they're properly dead but still
  * allocated.
  */
-void lockdep_free_key_range(void *start, unsigned long size)
+static void lockdep_free_key_range_reg(void *start, unsigned long size)
 {
+	struct pending_free *pf;
 	unsigned long flags;
-	int locked;
+
+	might_sleep();
 
 	init_data_structures_once();
 
-	raw_local_irq_save(flags);
-	locked = graph_lock();
-	__lockdep_free_key_range(start, size);
-	if (locked)
-		graph_unlock();
+	pf = get_pending_free_lock(&flags);
+	if (!pf)
+		return;
+	__lockdep_free_key_range(pf, start, size);
+	schedule_free_zapped_classes(pf);
+	graph_unlock();
 	raw_local_irq_restore(flags);
 
 	/*
-	 * Wait for any possible iterators from look_up_lock_class() to pass
-	 * before continuing to free the memory they refer to.
-	 *
-	 * sync_sched() is sufficient because the read-side is IRQ disable.
+	 * Do not wait for concurrent look_up_lock_class() calls. If any such
+	 * concurrent call would return a pointer to one of the lock classes
+	 * freed by this function then that means that there is a race in the
+	 * code that calls look_up_lock_class(), namely concurrently accessing
+	 * and freeing a synchronization object.
 	 */
-	synchronize_rcu();
+}
 
-	/*
-	 * XXX at this point we could return the resources to the pool;
-	 * instead we leak them. We would need to change to bitmap allocators
-	 * instead of the linear allocators we have now.
-	 */
+/*
+ * Free all lockdep keys in the range [start, start+size). Does not sleep.
+ * Ignores debug_locks. Must only be used by the lockdep selftests.
+ */
+static void lockdep_free_key_range_imm(void *start, unsigned long size)
+{
+	struct pending_free *pf;
+	unsigned long flags;
+
+	init_data_structures_once();
+
+	pf = get_pending_free_lock_imm(&flags);
+	if (!pf)
+		return;
+	__lockdep_free_key_range(pf, start, size);
+	arch_spin_unlock(&lockdep_lock);
+	raw_local_irq_restore(flags);
+
+	free_zapped_classes(&pf->rcu_head);
+}
+
+void lockdep_free_key_range(void *start, unsigned long size)
+{
+	init_data_structures_once();
+
+	if (inside_selftest())
+		lockdep_free_key_range_imm(start, size);
+	else
+		lockdep_free_key_range_reg(start, size);
 }
 
 /*
  * Check whether any element of the @lock->class_cache[] array refers to a
  * registered lock class. The caller must hold either the graph lock or the
  * RCU read lock.
- */
+  */
 static bool lock_class_cache_is_registered(struct lockdep_map *lock)
 {
 	struct lock_class *class;
@@ -4258,7 +4538,8 @@ static bool lock_class_cache_is_registered(struct lockdep_map *lock)
 }
 
 /* The caller must hold the graph lock. Does not sleep. */
-static void __lockdep_reset_lock(struct lockdep_map *lock)
+static void __lockdep_reset_lock(struct pending_free *pf,
+				 struct lockdep_map *lock)
 {
 	struct lock_class *class;
 	int j;
@@ -4272,7 +4553,7 @@ static void __lockdep_reset_lock(struct lockdep_map *lock)
 		 */
 		class = look_up_lock_class(lock, j);
 		if (class)
-			zap_class(class);
+			zap_class(pf, class);
 	}
 	/*
 	 * Debug check: in the end all mapped classes should
@@ -4282,21 +4563,55 @@ static void __lockdep_reset_lock(struct lockdep_map *lock)
 		debug_locks_off();
 }
 
-void lockdep_reset_lock(struct lockdep_map *lock)
+/*
+ * Reset a lock if debug_locks == 1. Free released data structures from RCU
+ * context.
+ */
+static void lockdep_reset_lock_reg(struct lockdep_map *lock)
 {
+	struct pending_free *pf;
 	unsigned long flags;
-	int locked;
 
-	init_data_structures_once();
+	might_sleep();
 
-	raw_local_irq_save(flags);
-	locked = graph_lock();
-	__lockdep_reset_lock(lock);
-	if (locked)
-		graph_unlock();
+	pf = get_pending_free_lock(&flags);
+	if (!pf)
+		return;
+	__lockdep_reset_lock(pf, lock);
+	schedule_free_zapped_classes(pf);
+	graph_unlock();
 	raw_local_irq_restore(flags);
 }
 
+/*
+ * Reset a lock. Does not sleep. Ignores debug_locks. Must only be used by the
+ * lockdep selftests.
+ */
+static void lockdep_reset_lock_imm(struct lockdep_map *lock)
+{
+	struct pending_free *pf;
+	unsigned long flags;
+
+	pf = get_pending_free_lock_imm(&flags);
+	if (!pf)
+		return;
+	__lockdep_reset_lock(pf, lock);
+	arch_spin_unlock(&lockdep_lock);
+	raw_local_irq_restore(flags);
+
+	free_zapped_classes(&pf->rcu_head);
+}
+
+void lockdep_reset_lock(struct lockdep_map *lock)
+{
+	init_data_structures_once();
+
+	if (inside_selftest())
+		lockdep_reset_lock_imm(lock);
+	else
+		lockdep_reset_lock_reg(lock);
+}
+
 void __init lockdep_init(void)
 {
 	printk("Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar\n");
@@ -4313,7 +4628,8 @@ void __init lockdep_init(void)
 	       (sizeof(list_entries) +
 		sizeof(lock_classes) +
 		sizeof(classhash_table) +
-		sizeof(chainhash_table)
+		sizeof(chainhash_table) +
+		sizeof(pending_free)
 #ifdef CONFIG_PROVE_LOCKING
 		+ sizeof(lock_cq)
 		+ sizeof(lock_chains)
-- 
2.20.1.97.g81188d93c3-goog

