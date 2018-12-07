Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10C6C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 01:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55FBF20850
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 01:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="B7rm44Nt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55FBF20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbeLGBOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 20:14:23 -0500
Received: from out002.mailprotect.be ([83.217.72.86]:42239 "EHLO
        out002.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbeLGBN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 20:13:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=xhhwBbmgibRmWK19SzaQXeguUzbtQSFMMt/3y9U6Occ=; b=B7rm44Nt35i2
        mZ1m6wOj5M2p0PB4OYuJpZfCTooHhJSVSu6aadAHPlOua76vv1LDzRuQhuFUlhVqaHPiFCoHtp5qK
        TdmKxWbXn99+HIAr/Wptl07n3pgu9h/QciDi2fxMPTnd364yUlGZRMKY6cJdbTnl4zXFI41gpsEX7
        z0e8O9YHVnASgWJ/9EbUR7mualPksRaV6W0AlNqlU0J9Qx2X/9QV0Fbtk51Z2kgNtwuDeidDNpN9K
        E5dA2H2jJJ6U/jyakgrhXTSdQyY94IB9235opPj8oGkb4Y4yxyFfKQ2ZbY1ICTPiGOx+OSHETUbkR
        dVAdXn51dA4L3anUXJZUDw==;
Received: from smtp-auth.mailprotect.be ([178.208.39.155])
        by com-mpt-out002.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1gV4hb-000C89-1s; Fri, 07 Dec 2018 02:13:11 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 33718C0D81;
        Fri,  7 Dec 2018 02:13:08 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v3 17/24] locking/lockdep: Free lock classes that are no longer in use
Date:   Thu,  6 Dec 2018 17:11:41 -0800
Message-Id: <20181207011148.251812-18-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
In-Reply-To: <20181207011148.251812-1-bvanassche@acm.org>
References: <20181207011148.251812-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.155
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00315275240301)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5sW3rKDaOoRsJ3SHsH5pEIV602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTb/+zriNZuqQk0xRpGwjn+MTR8dtByWYYhgj25jR+mEA3YO
 AtfhCcV13BpIh8lqRXSSiFVwqwU9VgKUrYQ0lqWyFDaym8oavoPYsm7m1mVEGf0/5ST3nkt5XYDK
 YAuRpmF7E2F3eqKXiTd2ECUghryWXlqwG31yUGf3t09vBVYS71V1Pk0aHudBU1wyWVTA5OYS1waI
 XXCBiQFDV0yen8nGcSeERs4TOTnIH1kc1IWc5eLazqbUYkjl7F1LyK0RORrzhZOlSiptyzsethBi
 xxxfSNgvEAWLFiDAlQR6Wu0I/iWDegq4fQ11AxLVlrI7DVH6GzPz+r852EXXeYX4ImMyzDg6HYuT
 CyYgL61SIkBTYXPEvhymCNb22qmKERGbL1SqvGGff0htQqhQf0/aDrhpLM4xnCPpmyyS7jgD9Nen
 VVoB/PLX+rmdznc91veCJAwpCI+5VHpzDqRcT2+GtIE8SRAgmLDKAcp9i+Q+BEiSUj07SNjVkl0P
 Pj+OUYZX3/3Z86X+I1ED1LLv7p/g4HOOdbYb9IXfYGRpVS/0hA4Mwp9kB6JZdl+SJy+nWImyKEy/
 zJE11ZjKQFiKV8EwnkodMjMm/D2rEPnNAuCCnt9B91Ax/uigYcgpQGDKFCrOdd8gr/U0flMcy2Vi
 /IcBgY4aVBKUAPQbBk8nfWT8Lcjyyn9ZSA9YgSwQmLSJwsFnO3lUxpF8dVvwCXY/4mE1q/c/E53d
 gi3vLmcjfrrMypRHn63D6wJ0G3dAGqTMy1gFVzccEHuX93FS4h2/zDJNFeX5X1KrFIDnIhhlHDLh
 vRwgYpikjrjEsQHYqzPksYepQjQSeP/rn+UB/EmrduGPxHj/dKsQ+WcgzL7pTOYRE2yEvlBrMyfp
 YuyanAZpMXssfrVwLrD8rqLg0SqQCDr4y/2a4ErnbLaYB3hAzdROEMst5sLEb9McgnPq1sY5GeOX
 A3LYhBKQrXFod+WvUUP1Uys1EcG7yIy1/E3Wa9/NTnLEueuO5TcDeKjrEmYPn2IVWRtfdRHps2br
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
accessing it.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/lockdep.h  |   9 +-
 kernel/locking/lockdep.c | 242 ++++++++++++++++++++++++++++++++-------
 2 files changed, 208 insertions(+), 43 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 9421f028c26c..72b4d5bb409f 100644
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
+	 * when not in use. Instances that are being freed are on the
+	 * zapped_classes list.
 	 */
 	struct list_head		lock_entry;
 
@@ -106,7 +109,7 @@ struct lock_class {
 	unsigned long			contention_point[LOCKSTAT_POINTS];
 	unsigned long			contending_point[LOCKSTAT_POINTS];
 #endif
-};
+} __no_randomize_layout;
 
 #ifdef CONFIG_LOCK_STAT
 struct lock_time {
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 92bdb187987f..ce8abd268727 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -134,8 +134,8 @@ static struct lock_list list_entries[MAX_LOCKDEP_ENTRIES];
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
@@ -277,11 +277,18 @@ static inline void lock_release_holdtime(struct held_lock *hlock)
 #endif
 
 /*
- * We keep a global list of all lock classes. The list only grows,
- * never shrinks. The list is only accessed with the lockdep
- * spinlock lock held.
+ * We keep a global list of all lock classes. The list is only accessed with
+ * the lockdep spinlock lock held. The zapped_classes list contains lock
+ * classes that are about to be freed but that may still be accessed by an RCU
+ * reader. free_lock_classes is a list with free elements. These elements are
+ * linked together by the lock_entry member in struct lock_class.
  */
 LIST_HEAD(all_lock_classes);
+static LIST_HEAD(zapped_classes);
+static LIST_HEAD(free_lock_classes);
+static bool initialization_happened;
+static bool rcu_callback_scheduled;
+static struct rcu_head free_zapped_classes_rcu_head;
 
 /*
  * The lockdep classes are in a hash-table as well, for fast lookup:
@@ -735,6 +742,21 @@ static bool assign_lock_key(struct lockdep_map *lock)
 	return true;
 }
 
+/*
+ * Initialize the lock_classes[] array elements and also the free_lock_classes
+ * list.
+ */
+static void init_data_structures(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(lock_classes); i++) {
+		list_add_tail(&lock_classes[i].lock_entry, &free_lock_classes);
+		INIT_LIST_HEAD(&lock_classes[i].locks_after);
+		INIT_LIST_HEAD(&lock_classes[i].locks_before);
+	}
+}
+
 /*
  * Register a lock's class in the hash-table, if the class is not present
  * yet. Otherwise we look it up. We cache the result in the lock object
@@ -775,11 +797,14 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 			goto out_unlock_set;
 	}
 
-	/*
-	 * Allocate a new key from the static array, and add it to
-	 * the hash:
-	 */
-	if (nr_lock_classes >= MAX_LOCKDEP_KEYS) {
+	/* Allocate a new lock class and add it to the hash. */
+	if (unlikely(!initialization_happened)) {
+		initialization_happened = true;
+		init_data_structures();
+	}
+	class = list_first_entry_or_null(&free_lock_classes, typeof(*class),
+					 lock_entry);
+	if (!class) {
 		if (!debug_locks_off_graph_unlock()) {
 			return NULL;
 		}
@@ -788,13 +813,13 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 		dump_stack();
 		return NULL;
 	}
-	class = lock_classes + nr_lock_classes++;
+	nr_lock_classes++;
 	debug_atomic_inc(nr_unused_locks);
 	class->key = key;
 	class->name = lock->name;
 	class->subclass = subclass;
-	INIT_LIST_HEAD(&class->locks_before);
-	INIT_LIST_HEAD(&class->locks_after);
+	WARN_ON_ONCE(!list_empty(&class->locks_before));
+	WARN_ON_ONCE(!list_empty(&class->locks_after));
 	class->name_version = count_matching_names(class);
 	/*
 	 * We use RCU's safe list-add method to make
@@ -804,7 +829,7 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 	/*
 	 * Add it to the global list of classes:
 	 */
-	list_add_tail(&class->lock_entry, &all_lock_classes);
+	list_move_tail(&class->lock_entry, &all_lock_classes);
 
 	if (verbose(class)) {
 		graph_unlock();
@@ -1845,6 +1870,13 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 	struct lock_list this;
 	int ret;
 
+	if (WARN_ON_ONCE(!hlock_class(prev)->hash_entry.pprev) ||
+	    WARN_ONCE(!hlock_class(next)->hash_entry.pprev,
+		      KERN_INFO "Detected use-after-free of lock class %s\n",
+		      hlock_class(next)->name)) {
+		return 2;
+	}
+
 	/*
 	 * Prove that the new <prev> -> <next> dependency would not
 	 * create a circular dependency in the graph. (We do this by
@@ -2236,17 +2268,14 @@ static inline int add_chain_cache(struct task_struct *curr,
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
 		if (chain->chain_key == chain_key) {
 			debug_atomic_inc(chain_lookup_hits);
@@ -3338,6 +3367,9 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	if (nest_lock && !__lock_is_held(nest_lock, -1))
 		return print_lock_nested_lock_not_held(curr, hlock, ip);
 
+	WARN_ON_ONCE(depth && !hlock_class(hlock - 1)->hash_entry.pprev);
+	WARN_ON_ONCE(!hlock_class(hlock)->hash_entry.pprev);
+
 	if (!validate_chain(curr, lock, hlock, chain_head, chain_key))
 		return 0;
 
@@ -4126,11 +4158,93 @@ void lockdep_reset(void)
 	raw_local_irq_restore(flags);
 }
 
+/* Must be called with the graph lock held. */
+static void remove_class_from_lock_chain(struct lock_chain *chain,
+					 struct lock_class *class)
+{
+	u64 chain_key;
+	int i;
+
+#ifdef CONFIG_PROVE_LOCKING
+	for (i = chain->base; i < chain->base + chain->depth; i++) {
+		if (chain_hlocks[i] != class - lock_classes)
+			continue;
+		if (--chain->depth > 0)
+			memmove(&chain_hlocks[i], &chain_hlocks[i + 1],
+				(chain->base + chain->depth - i) *
+				sizeof(chain_hlocks[0]));
+		/*
+		 * Each lock class occurs at most once in a
+		 * lock chain so once we found a match we can
+		 * break out of this loop.
+		 */
+		goto recalc;
+	}
+	/* Since the chain has not been modified, return. */
+	return;
+
+recalc:
+	/*
+	 * Note: calling hlist_del_rcu() from inside a
+	 * hlist_for_each_entry_rcu() loop is safe.
+	 */
+	if (chain->depth == 0) {
+		/* To do: decrease chain count. See also inc_chains(). */
+		hlist_del_rcu(&chain->entry);
+		return;
+	}
+	chain_key = 0;
+	for (i = chain->base; i < chain->base + chain->depth; i++)
+		chain_key = iterate_chain_key(chain_key, chain_hlocks[i] + 1);
+	if (chain->chain_key == chain_key)
+		return;
+	hlist_del_rcu(&chain->entry);
+	chain->chain_key = chain_key;
+	hlist_add_head_rcu(&chain->entry, chainhashentry(chain_key));
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
+/*
+ * Move a class to the zapped_classes list if it is no longer in use. Must be
+ * called with the graph lock held.
+ */
+static void check_free_class(struct lock_class *class)
+{
+	/*
+	 * If the list_del_rcu(&entry->entry) call made both lock order lists
+	 * empty, remove @class from the all_lock_classes list and add it to
+	 * the zapped_classes list.
+	 */
+	if (class->hash_entry.pprev &&
+	    list_empty(&class->locks_after) &&
+	    list_empty(&class->locks_before)) {
+		list_move_tail(&class->lock_entry, &zapped_classes);
+		hlist_del_rcu(&class->hash_entry);
+		class->hash_entry.pprev = NULL;
+	}
+}
+
 /*
  * Remove all references to a lock class. The caller must hold the graph lock.
  */
 static void zap_class(struct lock_class *class)
 {
+	struct lock_class *links_to;
 	struct lock_list *entry;
 	int i;
 
@@ -4141,14 +4255,30 @@ static void zap_class(struct lock_class *class)
 	for (i = 0, entry = list_entries; i < nr_list_entries; i++, entry++) {
 		if (entry->class != class && entry->links_to != class)
 			continue;
+		links_to = entry->links_to;
+		WARN_ON_ONCE(entry->class == links_to);
 		list_del_rcu(&entry->entry);
 	}
-	/*
-	 * Unhash the class and remove it from the all_lock_classes list:
-	 */
-	hlist_del_rcu(&class->hash_entry);
-	class->hash_entry.pprev = NULL;
-	list_del(&class->lock_entry);
+	check_free_class(class);
+	WARN_ONCE(class->hash_entry.pprev,
+		  KERN_INFO "%s() failed for class %s\n", __func__,
+		  class->name);
+
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
@@ -4156,6 +4286,38 @@ static inline int within(const void *addr, void *start, unsigned long size)
 	return addr >= start && addr < start + size;
 }
 
+/*
+ * Free all lock classes that are on the zapped_classes list. Called as an
+ * RCU callback function.
+ */
+static void free_zapped_classes(struct callback_head *ch)
+{
+	struct lock_class *class;
+	unsigned long flags;
+	int locked;
+
+	raw_local_irq_save(flags);
+	locked = graph_lock();
+	rcu_callback_scheduled = false;
+	list_for_each_entry(class, &zapped_classes, lock_entry) {
+		reinit_class(class);
+		nr_lock_classes--;
+	}
+	list_splice_init(&zapped_classes, &free_lock_classes);
+	if (locked)
+		graph_unlock();
+	raw_local_irq_restore(flags);
+}
+
+/* Must be called with the graph lock held. */
+static void schedule_free_zapped_classes(void)
+{
+	if (rcu_callback_scheduled)
+		return;
+	rcu_callback_scheduled = true;
+	call_rcu(&free_zapped_classes_rcu_head, free_zapped_classes);
+}
+
 /*
  * Used in module.c to remove lock classes from memory that is going to be
  * freed; and possibly re-used by other modules.
@@ -4181,29 +4343,26 @@ void lockdep_free_key_range(void *start, unsigned long size)
 	for (i = 0; i < CLASSHASH_SIZE; i++) {
 		head = classhash_table + i;
 		hlist_for_each_entry_rcu(class, head, hash_entry) {
-			if (within(class->key, start, size))
-				zap_class(class);
-			else if (within(class->name, start, size))
-				zap_class(class);
+			if (!class->hash_entry.pprev ||
+			    (!within(class->key, start, size) &&
+			     !within(class->name, start, size)))
+				continue;
+			zap_class(class);
 		}
 	}
 
+	schedule_free_zapped_classes();
+
 	if (locked)
 		graph_unlock();
 	raw_local_irq_restore(flags);
 
 	/*
-	 * Wait for any possible iterators from look_up_lock_class() to pass
-	 * before continuing to free the memory they refer to.
-	 *
-	 * sync_sched() is sufficient because the read-side is IRQ disable.
-	 */
-	synchronize_sched();
-
-	/*
-	 * XXX at this point we could return the resources to the pool;
-	 * instead we leak them. We would need to change to bitmap allocators
-	 * instead of the linear allocators we have now.
+	 * Do not wait for concurrent look_up_lock_class() calls. If any such
+	 * concurrent call would return a pointer to one of the lock classes
+	 * freed by this function then that means that there is a race in the
+	 * code that calls look_up_lock_class(), namely concurrently accessing
+	 * and freeing a synchronization object.
 	 */
 }
 
@@ -4249,6 +4408,9 @@ void lockdep_reset_lock(struct lockdep_map *lock)
 		if (class)
 			zap_class(class);
 	}
+
+	schedule_free_zapped_classes();
+
 	/*
 	 * Debug check: in the end all mapped classes should
 	 * be gone.
-- 
2.20.0.rc2.403.gdbc3b29805-goog

