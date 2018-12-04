Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495F0C04EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F174420850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="hH/nLAXX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F174420850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbeLDAaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 19:30:01 -0500
Received: from com-out001.mailprotect.be ([83.217.72.83]:58535 "EHLO
        com-out001.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbeLDA3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 19:29:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=biEwLbpZeavufso+8OqS3TDte+yqI5j1YPsGQJ0rehk=; b=hH/nLAXXV3qZ
        GaD6VjYFVYpbDiU+9M9u4qQoEPcgyupqIPN0kLx5p/1IqBIHu1D5uKAqe4MZlGyan7K+hlxS+Qrp9
        HAYnT9zpSqdE9wWpAA7LWSKZPrwldBMxspQZRDmqHJeU5PEAW582Or9LRpfPDknTBHNEZCThwA99K
        zCVuLOLsp8rQZoEoFrJUUonuzIjk16L3AjbG84IECvBrq5zxKzB9uWR7NfQXbuf8u+u0KDMqby9Sp
        DljfPNwb1YQs8OI/C3AjOHJFMOcpCfw+rYBsFLJZve66KP+iQUHlYzsaNzayww5Om+A7dK4XvNL/z
        RJEXt+lTSRWB14mrMyuLEA==;
Received: from smtp-auth.mailprotect.be ([178.208.39.155])
        by com-mpt-out001.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1gTyah-0008BO-5P; Tue, 04 Dec 2018 01:29:31 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 898D7C077C;
        Tue,  4 Dec 2018 01:29:28 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v2 22/24] locking/lockdep: Add support for dynamic keys
Date:   Mon,  3 Dec 2018 16:28:31 -0800
Message-Id: <20181204002833.55452-23-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
In-Reply-To: <20181204002833.55452-1-bvanassche@acm.org>
References: <20181204002833.55452-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.155
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00656908445526)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5gpHuq8yrgbCOc8Evxe/VX1602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTb/+zriNZuqQk0xRpGwjn+MTR8dtByWYYhgj25jR+mEA3YO
 AtfhCcV13BpIh8lqRXSSiFVwqwU9VgKUrYQ0lqWyFDaym8oavoPYsm7m1mVEGf0/5ST3nkt5XYDK
 YAuRpmF7E2F3eqKXiTd2ECUghryWXlqwG31yUGf3t09vBVYS71V1Pk0aHudBU1wyWVTA5OYS1waI
 XXCBiQFDV0yen8nGcSeERs4TOTnIH1kc1IWc5eLazqbUYkjl7F1LyK0RORoBuQz976gFG7Ct5sfk
 lgjFSNgvEAWLFiDAlQR6Wu0I/iWDegq4fQ11AxLVlrI7DVFg5Rj2g0fgHrO2rAGaVRcnzDg6HYuT
 CyYgL61SIkBTYXPEvhymCNb22qmKERGbL1SqvGGff0htQqhQf0/aDrhpLM4xnCPpmyyS7jgD9Nen
 VVoB/PLX+rmdznc91veCJAwpCI+5VHpzDqRcT2+GtIE8SRAgmLDKAcp9i+Q+BEiSUj07SNjVkl0P
 Pj+OUYZX3/3Z86X+I1ED1LLv7p/g4HOOdbYb9IXfYGRpVS/0hA4Mwp9kB6JZdl+SJy+nWImyKEy/
 zJE11ZjKQFiKV8EwnkodMjMm/D2rEPnNAuCCnt9B91Ax/uigYcgpQGDKFCrOdd8gr/U0flMcy2Vi
 /IcBgY4aVBKUAPQbBk8nfWT8Lcjyyn9ZSA9YgSwQmLSJwsFnO3lUxpF8dVvwCXY/4mE1q/c/lcBJ
 DmoxYxZqr5EVgTOQJM8lWcZ1ej5xHRqMLmb1G0IpH4M42uqHhBD4/y0bNc3rX1KrFIDnIhhlHDLh
 vRwgYpikjrjEsQHYqzPksYepQjQSeP/rn+UB/EmrduGPxHj/dKsQ+WcgzL7pTOYRE2yEvlBrMyfp
 YuyanAZpMXssfrVwLrD8rqLg0SqQCDr4y/2a/hEe1tUXEDGHrWaNb3LuOWZPtanZ0WzvMdzIkBWJ
 5tnYhBKQrXFod+WvUUP1Uys1EcG7yIy1/E3Wa9/NTnLEueuO5TcDeKjrEmYPn2IVWRtfdRHps2br
 TOkutpvyrdmtvbYO9ASW9x0dzW2b+IEXgSV5FVT0nNNOs1IDBtijAxf8XG910biZEcomWehz4u8s
 zDg6HYuTCyYgL61SIkBTYSiCBqrB4vMmHpjmx6wTDBzk2EPy497nssgnoMkIb3rMdj8luXC7km26
 QtXP9s02LA==
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A shortcoming of the current lockdep implementation is that it requires
lock keys to be allocated statically. That forces certain lock objects
to share lock keys. Since lock dependency analysis groups lock objects
per key sharing lock keys can cause false positive lockdep reports.
Make it possible to avoid such false positive reports by allowing lock
keys to be allocated dynamically. Require that dynamically allocated
lock keys are registered before use by calling lockdep_register_key().
Complain about attempts to register the same lock key pointer twice
without calling lockdep_unregister_key() between successive
registration calls.

The purpose of the new lock_keys_hash[] data structure that keeps
track of all dynamic keys is twofold:
- Verify whether the lockdep_register_key() and  lockdep_unregister_key()
  functions are used correctly.
- Avoid that lockdep_init_map() complains when encountering a dynamically
  allocated key.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/lockdep.h  |  13 ++++-
 kernel/locking/lockdep.c | 120 ++++++++++++++++++++++++++++++++++++---
 2 files changed, 122 insertions(+), 11 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 02a1469c46e1..ea09048b6e1c 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -46,15 +46,19 @@ extern int lock_stat;
 #define NR_LOCKDEP_CACHING_CLASSES	2
 
 /*
- * Lock-classes are keyed via unique addresses, by embedding the
- * lockclass-key into the kernel (or module) .data section. (For
- * static locks we use the lock address itself as the key.)
+ * A lockdep key is associated with each lock object. For static locks we use
+ * the lock address itself as the key. Dynamically allocated lock objects can
+ * have a statically or dynamically allocated key. Dynamically allocated lock
+ * keys must be registered before being used and must be unregistered before
+ * the key memory is freed.
  */
 struct lockdep_subclass_key {
 	char __one_byte;
 } __attribute__ ((__packed__));
 
+/* hash_entry is used to keep track of dynamically allocated keys. */
 struct lock_class_key {
+	struct hlist_node		hash_entry;
 	struct lockdep_subclass_key	subkeys[MAX_LOCKDEP_SUBCLASSES];
 };
 
@@ -274,6 +278,9 @@ extern asmlinkage void lockdep_sys_exit(void);
 extern void lockdep_off(void);
 extern void lockdep_on(void);
 
+extern void lockdep_register_key(struct lock_class_key *key);
+extern void lockdep_unregister_key(struct lock_class_key *key);
+
 /*
  * These methods are used by specific locking variants (spinlocks,
  * rwlocks, mutexes and rwsems) to pass init/acquire/release events
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index b4772e5fc176..d8ceed4f2900 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -141,6 +141,9 @@ static DECLARE_BITMAP(list_entries_being_freed, MAX_LOCKDEP_ENTRIES);
  * nr_lock_classes is the number of elements of lock_classes[] that is
  * in use.
  */
+#define KEYHASH_BITS		(MAX_LOCKDEP_KEYS_BITS - 1)
+#define KEYHASH_SIZE		(1UL << KEYHASH_BITS)
+static struct hlist_head lock_keys_hash[KEYHASH_SIZE];
 unsigned long nr_lock_classes;
 #ifndef CONFIG_DEBUG_LOCKDEP
 static
@@ -610,7 +613,7 @@ static int very_verbose(struct lock_class *class)
  * Is this the address of a static object:
  */
 #ifdef __KERNEL__
-static int static_obj(void *obj)
+static int static_obj(const void *obj)
 {
 	unsigned long start = (unsigned long) &_stext,
 		      end   = (unsigned long) &_end,
@@ -912,6 +915,70 @@ static void init_data_structures(void)
 	}
 }
 
+static inline struct hlist_head *keyhashentry(const struct lock_class_key *key)
+{
+	unsigned long hash = hash_long((uintptr_t)key, KEYHASH_BITS);
+
+	return lock_keys_hash + hash;
+}
+
+/*
+ * Register a dynamically allocated key.
+ */
+void lockdep_register_key(struct lock_class_key *key)
+{
+	struct hlist_head *hash_head;
+	struct lock_class_key *k;
+	unsigned long flags;
+
+	if (WARN_ON_ONCE(static_obj(key)))
+		return;
+	hash_head = keyhashentry(key);
+	raw_local_irq_save(flags);
+	if (!graph_lock())
+		goto restore_irqs;
+	hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
+		if (WARN_ON_ONCE(k == key))
+			goto out_unlock;
+	}
+	hlist_add_head_rcu(&key->hash_entry, hash_head);
+out_unlock:
+	graph_unlock();
+restore_irqs:
+	raw_local_irq_restore(flags);
+}
+EXPORT_SYMBOL_GPL(lockdep_register_key);
+
+/*
+ * Check whether a key has been registered as a dynamic key. Must not be called
+ * from interrupt context.
+ */
+static bool is_dynamic_key(const struct lock_class_key *key)
+{
+	struct hlist_head *hash_head;
+	struct lock_class_key *k;
+	unsigned long flags;
+	bool found = false;
+
+	if (WARN_ON_ONCE(static_obj(key)))
+		return false;
+	hash_head = keyhashentry(key);
+	raw_local_irq_save(flags);
+	if (!graph_lock())
+		goto restore_irqs;
+	hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
+		if (k == key) {
+			found = true;
+			break;
+		}
+	}
+	graph_unlock();
+restore_irqs:
+	raw_local_irq_restore(flags);
+
+	return found;
+}
+
 /*
  * Register a lock's class in the hash-table, if the class is not present
  * yet. Otherwise we look it up. We cache the result in the lock object
@@ -933,7 +1000,7 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 	if (!lock->key) {
 		if (!assign_lock_key(lock))
 			return NULL;
-	} else if (!static_obj(lock->key)) {
+	} else if (!static_obj(lock->key) && !is_dynamic_key(lock->key)) {
 		return NULL;
 	}
 
@@ -3311,13 +3378,13 @@ void lockdep_init_map(struct lockdep_map *lock, const char *name,
 	if (DEBUG_LOCKS_WARN_ON(!key))
 		return;
 	/*
-	 * Sanity check, the lock-class key must be persistent:
+	 * Sanity check, the lock-class key must either have been allocated
+	 * statically or must have been registered as a dynamic key.
 	 */
-	if (!static_obj(key)) {
-		printk("BUG: key %px not in .data!\n", key);
-		/*
-		 * What it says above ^^^^^, I suggest you read it.
-		 */
+	if (!static_obj(key) && !is_dynamic_key(key)) {
+		if (debug_locks)
+			printk(KERN_INFO "BUG: key %px has not been registered!\n",
+			       key);
 		DEBUG_LOCKS_WARN_ON(1);
 		return;
 	}
@@ -4541,6 +4608,43 @@ void lockdep_free_key_range(void *start, unsigned long size)
 	schedule_free_zapped_classes();
 }
 
+
+/*
+ * Unregister a dynamically allocated key. Must not be called from interrupt
+ * context. The caller must ensure that freeing @key only happens after an RCU
+ * grace period.
+ */
+void lockdep_unregister_key(struct lock_class_key *key)
+{
+	struct hlist_head *hash_head = keyhashentry(key);
+	struct lock_class_key *k;
+	unsigned long flags;
+	bool found = false;
+
+	if (WARN_ON_ONCE(static_obj(key)))
+		return;
+
+	__lockdep_free_key_range(key, 1);
+
+	raw_local_irq_save(flags);
+	if (!graph_lock())
+		goto restore_irqs;
+	hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
+		if (k == key) {
+			hlist_del_rcu(&k->hash_entry);
+			found = true;
+			break;
+		}
+	}
+	WARN_ON_ONCE(!found);
+	graph_unlock();
+restore_irqs:
+	raw_local_irq_restore(flags);
+
+	schedule_free_zapped_classes();
+}
+EXPORT_SYMBOL_GPL(lockdep_unregister_key);
+
 /*
  * Check whether any element of the @lock->class_cache[] array refers to a
  * registered lock class. The caller must hold either the graph lock or the
-- 
2.20.0.rc1.387.gf8505762e3-goog

