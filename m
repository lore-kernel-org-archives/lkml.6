Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D933AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84924218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="p0ov6Irb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbfBNXDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 18:03:11 -0500
Received: from com-out001.mailprotect.be ([83.217.72.83]:48777 "EHLO
        com-out001.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbfBNXBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 18:01:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=sTeZUfkOzRbXaGsycEHadEDYxDNVIaDInKHghnGt4kk=; b=p0ov6Irbdqbw
        30gGogpUPtJzdFV1PbXtUM6lihAffP0Dv66N5zO+Fs3aXIkzmMB87dqeMingK5pw/EWuEyeFqGXKh
        hliZBhNWLkgYFao5Uil3IKzVZ0aY/iEvX7yAcqrad8wT3B5eb/j/gYFwwZBwRNsfx/yBFM49jYBcu
        hGOj5P9yBQcx5SStxxTXqBdHY7fPh11kfEHMgU0OSJV52rbbG5e1Yly2SQR7LgOCcNKrO3xXWdST8
        uU1E+OzBOwTNppRpV5yWdbHNKnd3ttE/rNpc7u8sUDoSK+lRRjr8puMB5zAlv5hojtrrx6yJVXU49
        +TZ0hCkYVpjmF7i5bOwypA==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out001.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1guQ0d-000DOW-Sa; Fri, 15 Feb 2019 00:01:37 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 543A7C04D0;
        Fri, 15 Feb 2019 00:01:33 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, will.deacon@arm.com, tj@kernel.org,
        longman@redhat.com, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v7 11/23] locking/lockdep: Free lock classes that are no longer in use
Date:   Thu, 14 Feb 2019 15:00:46 -0800
Message-Id: <20190214230058.196511-12-bvanassche@acm.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <20190214230058.196511-1-bvanassche@acm.org>
References: <20190214230058.196511-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.159
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.000157312257343)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5sg2sia+D+QLfV7znZIrwXd602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTbXCyMe5v8y2H30acbVA7+CsLowAEMLnIs/c915wTAPANfX
 yKo+pvzCeHRww82sG/8HW2me2F11ZDpUG2A5Oiv0I5mALh2L1FvYZOvwUqXjvDk55wR+TsdsSUF6
 GKzdvFr/HXw7HB6/ASdSFy6HwS/kPXDwAtkmamZ68x0sIvfyXcDIKE+0kbt+hzad+8LmAP3D1N2U
 GbvmsuDbvpqB9SNial5u6w2P0n3AP5HxdAj+kw2FxVgE7SkvtWKxkgySOE3GN0ExaDjCWJE9qkQd
 cN59GIlDkkRMjwt0coVbpJziUP29Qy8IoARItCHyVyra3tty+28pF/HE/UXip0YpvmqSgtBtsvjK
 9mpXvZ581yfqNeeYAkx3ZcmLZYF56A5GPA+gQUA9iOUB9gXW15it62GvKaV7puimXuHjFEy4159w
 b450J4XCXsfFdbMPgtsajKwG2cpJ3lvOyWe43aQJV0FQAw4GDaNi9opIpCCZlwPhCSifQg48iasD
 JL+gSQdpc7Qjle0LcSTVPooEuo2QsxqqSZrgzSd/y/UPcC3OGqi0VJ9oPeZuzI4YvGloR1iXZcQ6
 rDn0tTOVcmJwqI8Ju2ne/wwIwzyV/WMPB6zTEWzEncEKJtZE3p7YZqOA3SmjVruGpS+C6BPAIEs8
 PiiVo3Eboi+cbnT5PTDQNVG9E6gOGiUCAW1FDxcZal9mohvTtVuaBo55LoXJ38umBncoBPaTGplH
 cpVCCoX989hgB8R+yBNKgbPqM+gWqiGtLl4stWokc9uykHalFfjbaRfu7LxQqrjVBMoPRYNfw0h9
 UPmuM3bBteMJzAkMC43e8+sp9ik9r/0RENuxoUHLfdnX97lYWfNCwcrS0aokqY9q7nrY3hEVniih
 uDwEGDcmr6e3OPRLa16pGRvAB1MNCAVzZzPG/W30w/zDcz636yEnTyvlnaXYc5sCGBmhSF08PTuw
 vsrbBLJJpccYzugkqznbRgtactgzcDoFd+96Xw4QUNtTnfzp6yaSzf/mBOxmctH1xJW7ZqDnEZyA
 /o9yCJs753i5Anc+dePvuOLndsGRtxRwqudKEy7bP5gIt23U7fpAnNNWb77i3eb3c6Xj53IToZwL
 VabjergYMIEHYgna2Grb/XBEn95eECKi3gxjzXac2CKNL6Ugwa8G8LUBaMaYDRNMLxoq67wPPyTr
 tPptswtkm3vs+M4bivZGPOywGIoCFD0=
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of leaving lock classes that are no longer in use in the
lock_classes array, reuse entries from that array that are no longer in
use. Maintain a linked list of free lock classes with list head
'free_lock_class'. Only add freed lock classes to the free_lock_classes
list after a grace period to avoid that a lock_classes[] element would
be reused while an RCU reader is accessing it. Since the lockdep
selftests run in a context where sleeping is not allowed and since the
selftests require that lock resetting/zapping works with debug_locks
off, make the behavior of lockdep_free_key_range() and
lockdep_reset_lock() depend on whether or not these are called from
the context of the lockdep selftests.

Thanks to Peter for having shown how to modify get_pending_free()
such that that function does not have to sleep.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/lockdep.h  |   9 +-
 kernel/locking/lockdep.c | 396 ++++++++++++++++++++++++++++++++++-----
 2 files changed, 354 insertions(+), 51 deletions(-)

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
index 4bab8ecb88be..6920f406ee91 100644
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
@@ -278,11 +279,39 @@ static inline void lock_release_holdtime(struct held_lock *hlock)
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
+
+/**
+ * struct pending_free - information about data structures about to be freed
+ * @zapped: Head of a list with struct lock_class elements.
+ */
+struct pending_free {
+	struct list_head zapped;
+};
+
+/**
+ * struct delayed_free - data structures used for delayed freeing
+ *
+ * A data structure for delayed freeing of data structures that may be
+ * accessed by RCU readers at the time these were freed.
+ *
+ * @rcu_head:  Used to schedule an RCU callback for freeing data structures.
+ * @index:     Index of @pf to which freed data structures are added.
+ * @scheduled: Whether or not an RCU callback has been scheduled.
+ * @pf:        Array with information about data structures about to be freed.
+ */
+static struct delayed_free {
+	struct rcu_head		rcu_head;
+	int			index;
+	bool			scheduled;
+	struct pending_free	pf[2];
+} delayed_free;
 
 /*
  * The lockdep classes are in a hash-table as well, for fast lookup:
@@ -742,7 +771,8 @@ static bool assign_lock_key(struct lockdep_map *lock)
 }
 
 /*
- * Initialize the lock_classes[] array elements.
+ * Initialize the lock_classes[] array elements, the free_lock_classes list
+ * and also the delayed_free structure.
  */
 static void init_data_structures_once(void)
 {
@@ -754,7 +784,12 @@ static void init_data_structures_once(void)
 
 	initialization_happened = true;
 
+	init_rcu_head(&delayed_free.rcu_head);
+	INIT_LIST_HEAD(&delayed_free.pf[0].zapped);
+	INIT_LIST_HEAD(&delayed_free.pf[1].zapped);
+
 	for (i = 0; i < ARRAY_SIZE(lock_classes); i++) {
+		list_add_tail(&lock_classes[i].lock_entry, &free_lock_classes);
 		INIT_LIST_HEAD(&lock_classes[i].locks_after);
 		INIT_LIST_HEAD(&lock_classes[i].locks_before);
 	}
@@ -802,11 +837,10 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 
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
@@ -815,7 +849,7 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 		dump_stack();
 		return NULL;
 	}
-	class = lock_classes + nr_lock_classes++;
+	nr_lock_classes++;
 	debug_atomic_inc(nr_unused_locks);
 	class->key = key;
 	class->name = lock->name;
@@ -829,9 +863,10 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
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
@@ -1871,6 +1906,24 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
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
@@ -2253,19 +2306,16 @@ static inline int add_chain_cache(struct task_struct *curr,
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
@@ -3355,6 +3405,11 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	if (nest_lock && !__lock_is_held(nest_lock, -1))
 		return print_lock_nested_lock_not_held(curr, hlock, ip);
 
+	if (!debug_locks_silent) {
+		WARN_ON_ONCE(depth && !hlock_class(hlock - 1)->key);
+		WARN_ON_ONCE(!hlock_class(hlock)->key);
+	}
+
 	if (!validate_chain(curr, lock, hlock, chain_head, chain_key))
 		return 0;
 
@@ -4143,14 +4198,92 @@ void lockdep_reset(void)
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
@@ -4163,14 +4296,33 @@ static void zap_class(struct lock_class *class)
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
+		list_move_tail(&class->lock_entry, &pf->zapped);
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
@@ -4178,7 +4330,87 @@ static inline int within(const void *addr, void *start, unsigned long size)
 	return addr >= start && addr < start + size;
 }
 
-static void __lockdep_free_key_range(void *start, unsigned long size)
+static bool inside_selftest(void)
+{
+	return current == lockdep_selftest_task_struct;
+}
+
+/* The caller must hold the graph lock. */
+static struct pending_free *get_pending_free(void)
+{
+	return delayed_free.pf + delayed_free.index;
+}
+
+static void free_zapped_rcu(struct rcu_head *cb);
+
+/*
+ * Schedule an RCU callback if no RCU callback is pending. Must be called with
+ * the graph lock held.
+ */
+static void call_rcu_zapped(struct pending_free *pf)
+{
+	WARN_ON_ONCE(inside_selftest());
+
+	if (list_empty(&pf->zapped))
+		return;
+
+	if (delayed_free.scheduled)
+		return;
+
+	delayed_free.scheduled = true;
+
+	WARN_ON_ONCE(delayed_free.pf + delayed_free.index != pf);
+	delayed_free.index ^= 1;
+
+	call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
+}
+
+/* The caller must hold the graph lock. May be called from RCU context. */
+static void __free_zapped_classes(struct pending_free *pf)
+{
+	struct lock_class *class;
+
+	list_for_each_entry(class, &pf->zapped, lock_entry)
+		reinit_class(class);
+
+	list_splice_init(&pf->zapped, &free_lock_classes);
+}
+
+static void free_zapped_rcu(struct rcu_head *ch)
+{
+	struct pending_free *pf;
+	unsigned long flags;
+
+	if (WARN_ON_ONCE(ch != &delayed_free.rcu_head))
+		return;
+
+	raw_local_irq_save(flags);
+	if (!graph_lock())
+		goto out_irq;
+
+	/* closed head */
+	pf = delayed_free.pf + (delayed_free.index ^ 1);
+	__free_zapped_classes(pf);
+	delayed_free.scheduled = false;
+
+	/*
+	 * If there's anything on the open list, close and start a new callback.
+	 */
+	call_rcu_zapped(delayed_free.pf + delayed_free.index);
+
+	graph_unlock();
+out_irq:
+	raw_local_irq_restore(flags);
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
@@ -4191,7 +4423,7 @@ static void __lockdep_free_key_range(void *start, unsigned long size)
 			if (!within(class->key, start, size) &&
 			    !within(class->name, start, size))
 				continue;
-			zap_class(class);
+			zap_class(pf, class);
 		}
 	}
 }
@@ -4204,8 +4436,9 @@ static void __lockdep_free_key_range(void *start, unsigned long size)
  * guaranteed nobody will look up these exact classes -- they're properly dead
  * but still allocated.
  */
-void lockdep_free_key_range(void *start, unsigned long size)
+static void lockdep_free_key_range_reg(void *start, unsigned long size)
 {
+	struct pending_free *pf;
 	unsigned long flags;
 	int locked;
 
@@ -4213,9 +4446,15 @@ void lockdep_free_key_range(void *start, unsigned long size)
 
 	raw_local_irq_save(flags);
 	locked = graph_lock();
-	__lockdep_free_key_range(start, size);
-	if (locked)
-		graph_unlock();
+	if (!locked)
+		goto out_irq;
+
+	pf = get_pending_free();
+	__lockdep_free_key_range(pf, start, size);
+	call_rcu_zapped(pf);
+
+	graph_unlock();
+out_irq:
 	raw_local_irq_restore(flags);
 
 	/*
@@ -4223,12 +4462,35 @@ void lockdep_free_key_range(void *start, unsigned long size)
 	 * before continuing to free the memory they refer to.
 	 */
 	synchronize_rcu();
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
+	struct pending_free *pf = delayed_free.pf;
+	unsigned long flags;
+
+	init_data_structures_once();
+
+	raw_local_irq_save(flags);
+	arch_spin_lock(&lockdep_lock);
+	__lockdep_free_key_range(pf, start, size);
+	__free_zapped_classes(pf);
+	arch_spin_unlock(&lockdep_lock);
+	raw_local_irq_restore(flags);
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
@@ -4254,7 +4516,8 @@ static bool lock_class_cache_is_registered(struct lockdep_map *lock)
 }
 
 /* The caller must hold the graph lock. Does not sleep. */
-static void __lockdep_reset_lock(struct lockdep_map *lock)
+static void __lockdep_reset_lock(struct pending_free *pf,
+				 struct lockdep_map *lock)
 {
 	struct lock_class *class;
 	int j;
@@ -4268,7 +4531,7 @@ static void __lockdep_reset_lock(struct lockdep_map *lock)
 		 */
 		class = look_up_lock_class(lock, j);
 		if (class)
-			zap_class(class);
+			zap_class(pf, class);
 	}
 	/*
 	 * Debug check: in the end all mapped classes should
@@ -4278,21 +4541,57 @@ static void __lockdep_reset_lock(struct lockdep_map *lock)
 		debug_locks_off();
 }
 
-void lockdep_reset_lock(struct lockdep_map *lock)
+/*
+ * Remove all information lockdep has about a lock if debug_locks == 1. Free
+ * released data structures from RCU context.
+ */
+static void lockdep_reset_lock_reg(struct lockdep_map *lock)
 {
+	struct pending_free *pf;
 	unsigned long flags;
 	int locked;
 
-	init_data_structures_once();
-
 	raw_local_irq_save(flags);
 	locked = graph_lock();
-	__lockdep_reset_lock(lock);
-	if (locked)
-		graph_unlock();
+	if (!locked)
+		goto out_irq;
+
+	pf = get_pending_free();
+	__lockdep_reset_lock(pf, lock);
+	call_rcu_zapped(pf);
+
+	graph_unlock();
+out_irq:
+	raw_local_irq_restore(flags);
+}
+
+/*
+ * Reset a lock. Does not sleep. Ignores debug_locks. Must only be used by the
+ * lockdep selftests.
+ */
+static void lockdep_reset_lock_imm(struct lockdep_map *lock)
+{
+	struct pending_free *pf = delayed_free.pf;
+	unsigned long flags;
+
+	raw_local_irq_save(flags);
+	arch_spin_lock(&lockdep_lock);
+	__lockdep_reset_lock(pf, lock);
+	__free_zapped_classes(pf);
+	arch_spin_unlock(&lockdep_lock);
 	raw_local_irq_restore(flags);
 }
 
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
@@ -4309,7 +4608,8 @@ void __init lockdep_init(void)
 	       (sizeof(lock_classes) +
 		sizeof(classhash_table) +
 		sizeof(list_entries) +
-		sizeof(chainhash_table)
+		sizeof(chainhash_table) +
+		sizeof(delayed_free)
 #ifdef CONFIG_PROVE_LOCKING
 		+ sizeof(lock_cq)
 		+ sizeof(lock_chains)
-- 
2.21.0.rc0.258.g878e2cd30e-goog

