Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B8EC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D227B206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="aztKxL2z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D227B206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbeK2Krr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 05:47:47 -0500
Received: from out002.mailprotect.be ([83.217.72.86]:40373 "EHLO
        out002.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbeK2Krq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 05:47:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=hXd0kbFfJyt0Kbpia2Egs/dweMGiLNGUvCtBWgrO1W8=; b=aztKxL2zRZqs
        rFdB2vYCuO2ZFnqgiuTWekEjSxbv4EgRyvoOYvA0dTex4es0+qHXYHBbTlH3VqHkZobo/PlR0mI64
        EditK7WOCKrQKToFbCVn4X0cbxZQ5P7DtUoaOZ80Fiy32ylsH8ZTwLICJMKVPl3lPehA+D4GC3LlY
        pbdie/fbixCS1pgCG5kJTAjIMhtnswD/bOdKwCREeqbSTtbqeKi90AGTPSuimjQjaLpzqpKYz2Zij
        B86Wug4BDRt/U607DqzlEPnhfEqOEM2GK7UarrMH1aAl+LFUxy26C7JXOVzZpt2bDswz6vwKGBJBC
        Rat4WsWm4eWXERslAa/h/Q==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out002.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1gS9V8-000Fm0-AC; Thu, 29 Nov 2018 00:44:15 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 025F2C11D1;
        Thu, 29 Nov 2018 00:44:11 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, tj@kernel.org, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 20/27] locking/lockdep: Free lock classes that are no longer in use
Date:   Wed, 28 Nov 2018 15:43:18 -0800
Message-Id: <20181128234325.110011-21-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
In-Reply-To: <20181128234325.110011-1-bvanassche@acm.org>
References: <20181128234325.110011-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.159
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00175857180245)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5unEq4bRLFfRsWntU9GiTcB602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTb/+zriNZuqQk0xRpGwjn+MTR8dtByWYYhgj25jR+mEA3YO
 AtfhCcV13BpIh8lqRXSSiFVwqwU9VgKUrYQ0lqWyB41b1wEpWO6ik9HITpMsqebHcXK5F5szpMR3
 ucwUCaulpCLw+Xb9GLNy0GASgpn9t8C9mOBdONdnsxgsk1D2p09kN7MM31r8n6t5T2S20aVP1m/j
 D6gcfbgK+GdokJZ3q2ydL+V39l/HBScm+SV6be+d9aVwS6cHCn1lU19HAi33Iz6Zvpm8cPQnANwk
 DQ5BNCNwpGn8jfSb3NCl2WUq09dCYgcgr835yVjKQZA6hJL1LiMHCxRezvZaFOrUVh8zaVyj66M1
 yz85ZZhpUrhTRbASVYnBhdKUnGmBdHG7BUn2dK6UtSEdwn3yFtfkzf2g6K04cY809V1JdCwiLdDQ
 Dow7RSjhmGOVelXQaHGaUkBvyMjbyNpr4xR6RL2C9+qlIny++hg9dJLqN5zmWqF/oNe6FVV7drXD
 mtOldfpWzeUCaRHvx+uLGHS3n3Y0pMd0ZyCgxZHINA6A5+7T9o6by6wCf9/ixXi9QE6xc2MJdJIs
 WkULIn/2FBvF31UHbsndehIqUczFWeS6sE8e1b5/UlaX0Ao5X99TlizdjWjXhcukjPvPb2ztUwUU
 F4ekbSpuNzlrea/7iuldgAMiBvdjMWUgS0WA6zujoEG+l7IAarwHmFDqewO9xyOqCYO8P1aHcsG0
 kWCiESR44kXyAcFBnvq0JaXhRWKyqy0OhbkmMxu2AdrcZPAiQvyjIZ4LQqnqqLEDUnB02oJPHAlf
 IubJYzA0XAoGECHs14pjPDDBgamvNiA5kjk+kUt44s0jst5f+KwaznUMONt4fBOE9tCt0E+XPwc0
 3R23rjnWZRtajWFuhWzfuvHd4y0L/HyfN5U858I8R2vIYlYbA7G/CY3eeSCFRiwDn8j3yWGHtM7w
 dRonBy/PpUxgSFRPcWxJF+/beJHmCfSNEcGdfFKs5M18F1x96tlonSt5Ig9mwLw4vXsdf68W0InH
 /+bTMKNm38MHV+diwrlXuxzeO2WnJyd7g8lLLKZgdBo3YHaSgbLEg7M4I+zZPnIX6k9TnzH5sZcr
 MS+4ayUpOtEhdxekWDmK9g==
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

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/lockdep.h  |   9 +-
 kernel/locking/lockdep.c | 233 +++++++++++++++++++++++++++++++--------
 2 files changed, 195 insertions(+), 47 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 9421f028c26c..02a1469c46e1 100644
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
+	 * when not in use. Instances that are being freed are briefly on
+	 * neither list.
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
index 4610f3c4f3db..53d8daa8d0dc 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -134,11 +134,14 @@ static struct lock_list list_entries[MAX_LOCKDEP_ENTRIES];
 /*
  * All data structures here are protected by the global debug_lock.
  *
- * Mutex key structs only get allocated, once during bootup, and never
- * get freed - this significantly simplifies the debugging code.
+ * nr_lock_classes is the number of elements of lock_classes[] that is in use.
+ * free_lock_classes points at the first free element. These elements are
+ * linked together by the lock_entry member in struct lock_class.
  */
 unsigned long nr_lock_classes;
 static struct lock_class lock_classes[MAX_LOCKDEP_KEYS];
+static LIST_HEAD(free_lock_classes);
+static bool initialization_happened;
 
 static inline struct lock_class *hlock_class(struct held_lock *hlock)
 {
@@ -274,9 +277,8 @@ static inline void lock_release_holdtime(struct held_lock *hlock)
 #endif
 
 /*
- * We keep a global list of all lock classes. The list only grows,
- * never shrinks. The list is only accessed with the lockdep
- * spinlock lock held.
+ * We keep a global list of all lock classes. The list is only accessed with
+ * the lockdep spinlock lock held.
  */
 LIST_HEAD(all_lock_classes);
 
@@ -732,6 +734,17 @@ static bool assign_lock_key(struct lockdep_map *lock)
 	return true;
 }
 
+static void init_lists(void)
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
@@ -748,8 +761,10 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 	DEBUG_LOCKS_WARN_ON(!irqs_disabled());
 
 	class = look_up_lock_class(lock, subclass);
-	if (likely(class))
+	if (likely(class)) {
+		WARN_ON_ONCE(!class->hash_entry.pprev);
 		goto out_set_class_cache;
+	}
 
 	if (!lock->key) {
 		if (!assign_lock_key(lock))
@@ -773,11 +788,14 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
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
+		init_lists();
+	}
+	class = list_first_entry_or_null(&free_lock_classes, typeof(*class),
+					 lock_entry);
+	if (!class) {
 		if (!debug_locks_off_graph_unlock()) {
 			return NULL;
 		}
@@ -786,13 +804,14 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 		dump_stack();
 		return NULL;
 	}
-	class = lock_classes + nr_lock_classes++;
+	list_del(&class->lock_entry);
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
@@ -1843,6 +1862,13 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
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
@@ -2234,17 +2260,14 @@ static inline int add_chain_cache(struct task_struct *curr,
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
@@ -3225,6 +3248,9 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 		class = register_lock_class(lock, subclass, 0);
 		if (!class)
 			return 0;
+		WARN_ON_ONCE(!class->hash_entry.pprev);
+	} else {
+		WARN_ON_ONCE(!class->hash_entry.pprev);
 	}
 
 	debug_class_ops_inc(class);
@@ -3336,6 +3362,9 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	if (nest_lock && !__lock_is_held(nest_lock, -1))
 		return print_lock_nested_lock_not_held(curr, hlock, ip);
 
+	WARN_ON_ONCE(depth && !hlock_class(hlock - 1)->hash_entry.pprev);
+	WARN_ON_ONCE(!hlock_class(hlock)->hash_entry.pprev);
+
 	if (!validate_chain(curr, lock, hlock, chain_head, chain_key))
 		return 0;
 
@@ -4124,11 +4153,87 @@ void lockdep_reset(void)
 	raw_local_irq_restore(flags);
 }
 
+/* Must be called with the graph lock held. */
+static void remove_class_from_lock_chain(struct lock_chain *chain,
+					 struct lock_class *class)
+{
+	u64 chain_key;
+	int i;
+
+	for (i = chain->base; i < chain->base + chain->depth; i++) {
+		if (chain_hlocks[i] != class - lock_classes)
+			continue;
+		if (--chain->depth == 0)
+			break;
+		memmove(&chain_hlocks[i], &chain_hlocks[i + 1],
+			(chain->base + chain->depth - i) *
+			sizeof(chain_hlocks[0]));
+		/*
+		 * Each lock class occurs at most once in a
+		 * lock chain so once we found a match we can
+		 * break out of this loop.
+		 */
+		break;
+	}
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
+/* Must be called with the graph lock held. */
+static void check_free_class(struct list_head *zapped_classes,
+			     struct lock_class *class)
+{
+	/*
+	 * If the list_del_rcu(&entry->entry) call made both lock order lists
+	 * empty, remove @class from the all_lock_classes list and add it to
+	 * the zapped_classes list.
+	 */
+	if (class->hash_entry.pprev &&
+	    list_empty(&class->locks_after) &&
+	    list_empty(&class->locks_before)) {
+		list_move_tail(&class->lock_entry, zapped_classes);
+		hlist_del_rcu(&class->hash_entry);
+		class->hash_entry.pprev = NULL;
+	}
+}
+
 /*
  * Remove all references to a lock class. The caller must hold the graph lock.
  */
-static void zap_class(struct lock_class *class)
+static void zap_class(struct list_head *zapped_classes,
+		      struct lock_class *class)
 {
+	struct lock_class *links_to;
 	struct lock_list *entry;
 	int i;
 
@@ -4139,14 +4244,33 @@ static void zap_class(struct lock_class *class)
 	for (i = 0, entry = list_entries; i < nr_list_entries; i++, entry++) {
 		if (entry->class != class && entry->links_to != class)
 			continue;
+		links_to = entry->links_to;
+		WARN_ON_ONCE(entry->class == links_to);
 		list_del_rcu(&entry->entry);
+		entry->class = NULL;
+		entry->links_to = NULL;
+		check_free_class(zapped_classes, class);
 	}
-	/*
-	 * Unhash the class and remove it from the all_lock_classes list:
-	 */
-	hlist_del_rcu(&class->hash_entry);
-	class->hash_entry.pprev = NULL;
-	list_del(&class->lock_entry);
+	check_free_class(zapped_classes, class);
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
@@ -4154,6 +4278,34 @@ static inline int within(const void *addr, void *start, unsigned long size)
 	return addr >= start && addr < start + size;
 }
 
+static void free_zapped_classes(struct list_head *zapped_classes)
+{
+	struct lock_class *class;
+	unsigned long flags;
+	int locked;
+
+	if (list_empty(zapped_classes))
+		return;
+
+	/*
+	 * Wait until look_up_lock_class() has finished accessing the
+	 * list_entries[] elements we are about to free. sync_sched() is
+	 * sufficient because look_up_lock_class() is called with IRQs off.
+	 */
+	synchronize_sched();
+
+	raw_local_irq_save(flags);
+	locked = graph_lock();
+	list_for_each_entry(class, zapped_classes, lock_entry) {
+		reinit_class(class);
+		nr_lock_classes--;
+	}
+	list_splice(zapped_classes, &free_lock_classes);
+	if (locked)
+		graph_unlock();
+	raw_local_irq_restore(flags);
+}
+
 /*
  * Used in module.c to remove lock classes from memory that is going to be
  * freed; and possibly re-used by other modules.
@@ -4166,6 +4318,7 @@ void lockdep_free_key_range(void *start, unsigned long size)
 {
 	struct lock_class *class;
 	struct hlist_head *head;
+	LIST_HEAD(zapped_classes);
 	unsigned long flags;
 	int i;
 	int locked;
@@ -4179,10 +4332,11 @@ void lockdep_free_key_range(void *start, unsigned long size)
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
+			zap_class(&zapped_classes, class);
 		}
 	}
 
@@ -4190,19 +4344,7 @@ void lockdep_free_key_range(void *start, unsigned long size)
 		graph_unlock();
 	raw_local_irq_restore(flags);
 
-	/*
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
-	 */
+	free_zapped_classes(&zapped_classes);
 }
 
 /*
@@ -4230,6 +4372,7 @@ static bool lock_class_cache_is_registered(struct lockdep_map *lock)
 void lockdep_reset_lock(struct lockdep_map *lock)
 {
 	struct lock_class *class;
+	LIST_HEAD(zapped_classes);
 	unsigned long flags;
 	int j, locked;
 
@@ -4245,7 +4388,7 @@ void lockdep_reset_lock(struct lockdep_map *lock)
 		 */
 		class = look_up_lock_class(lock, j);
 		if (class)
-			zap_class(class);
+			zap_class(&zapped_classes, class);
 	}
 	/*
 	 * Debug check: in the end all mapped classes should
@@ -4265,6 +4408,8 @@ void lockdep_reset_lock(struct lockdep_map *lock)
 
 out_restore:
 	raw_local_irq_restore(flags);
+
+	free_zapped_classes(&zapped_classes);
 }
 
 void __init lockdep_init(void)
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

