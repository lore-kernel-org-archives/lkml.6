Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD74C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E146206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="toSmlJhM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbfAIVDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:03:05 -0500
Received: from out002.mailprotect.be ([83.217.72.86]:40743 "EHLO
        out002.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727620AbfAIVDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:03:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=jk3w6wB9x+CLsgyDLQR8q+HdqeEUjJLZismq2ivxEpg=; b=toSmlJhM+/rz
        HmQFzWhgB7g4Wp3zgVC/PEraEe4iBcuBZicBI4XFJ91GD9xo7o42SWg/cNhI0oU2wpB+58kFVjJps
        sWaBorLiETjCm2nGZE9A1oy+ceq18rmLV77ap0kosSZDGIqHalmTL+bpjxha1tJfC0hoaZW8qmk3j
        SCy6NjFQxOJC4lki4KYJYuRW9s4+MAXogbimqPcsf6bCi00gcuJHOMxqo4XDmECWLrWBMk4Clg9i+
        c1OGT0vsrVQSHyRE+Ptq0ZEqJpcKGz4+JGpOSjvXtfYPSQ61NBpI0fG35BDk6nzMS0y0BJMLwxSGI
        gWMOzqdOUuKtzxCPXDhnHw==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out002.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1ghL00-0009LM-Da; Wed, 09 Jan 2019 22:02:53 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 35AE6C0690;
        Wed,  9 Jan 2019 22:02:45 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v6 14/16] locking/lockdep: Add support for dynamic keys
Date:   Wed,  9 Jan 2019 13:02:02 -0800
Message-Id: <20190109210204.192109-15-bvanassche@acm.org>
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
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00744946434714)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5tcXgEx+SPD38KfGVnt22XF602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTb/+zriNZuqQk0xRpGwjn+MTR8dtByWYYhgj25jR+mEA3YO
 AtfhCcV13BpIh8lqRXSSiFVwqwU9VgKUrYQ0lqWyFDaym8oavoPYsm7m1mVEGf0/5ST3nkt5XYDK
 YAuRpmF7E2F3eqKXiTd2ECUghryWXlqwG31yUGf3t09vBVYS71V1Pk0aHudBU1wyWVTA5OYS1waI
 XXCBiQFDV0yen8nGcSeERs4TOTnIH1kc1IWc5eLazqbUYkjl7F1LyK0RORoof4jg2yC2rSY+dtl+
 wuQsSNgvEAWLFiDAlQR6Wu0I/iWDegq4fQ11AxLVlrI7DVH6GzPz+r852EXXeYX4ImMyzDg6HYuT
 CyYgL61SIkBTYXPEvhymCNb22qmKERGbL1SqvGGff0htQqhQf0/aDrhpLM4xnCPpmyyS7jgD9Nen
 VVoB/PLX+rmdznc91veCJAwpCI+5VHpzDqRcT2+GtIE8SRAgmLDKAcp9i+Q+BEiSUj07SNjVkl0P
 Pj+OUYZX3/3Z86X+I1ED1LLv7p/g4HOOdbYb9IXfYGRpVS/0hA4Mwp9kB6JZdl+SJy+nWImyKEy/
 zJE11ZjKQFiKV8EwnkodMjMm/D2rEPnNAuCCnt9B91Ax/uigYcgpQGDKFCrOdd8gr/U0flMcy2Vi
 /IcBgY4aVBKUAPQbBk8nfWT8Lcjyyn9ZSA9YgSwQmLSJwsFnO3lUxpF8dVvwCXY/4mE1q/c/E53d
 gi3vLmcjfrrMypRHn2jUDug2R2OyJdxOnw8xJDFYN6bAG2ebyj0PD5CH7EFzX1KrFIDnIhhlHDLh
 vRwgYpikjrjEsQHYqzPksYepQjQSeP/rn+UB/EmrduGPxHj/dKsQ+WcgzL7pTOYRE2yEvlBrMyfp
 YuyanAZpMXssfrVwLrD8rqLg0SqQCDr4y/2avMLTzQ2xVOWdIXtYusGBqgDUkoDdA0YzaVaKsJ+C
 JqXYhBKQrXFod+WvUUP1Uys1SCu8wQmWlqgUhZKbKdwa/OuO5TcDeKjrEmYPn2IVWRtfdRHps2br
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
- Verify whether the lockdep_register_key() and lockdep_unregister_key()
  functions are used correctly.
- Avoid that lockdep_init_map() complains when encountering a dynamically
  allocated key.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/lockdep.h  |  13 ++++-
 kernel/locking/lockdep.c | 123 ++++++++++++++++++++++++++++++++++++---
 2 files changed, 125 insertions(+), 11 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 619ec3f26cdc..3fd4172e9d1e 100644
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
 
@@ -273,6 +277,9 @@ extern void lockdep_set_selftest_task(struct task_struct *task);
 extern void lockdep_off(void);
 extern void lockdep_on(void);
 
+extern void lockdep_register_key(struct lock_class_key *key);
+extern void lockdep_unregister_key(struct lock_class_key *key);
+
 /*
  * These methods are used by specific locking variants (spinlocks,
  * rwlocks, mutexes and rwsems) to pass init/acquire/release events
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 72cff86829e6..a570be564be8 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -143,6 +143,9 @@ static DECLARE_BITMAP(list_entries_in_use, MAX_LOCKDEP_ENTRIES);
  * nr_lock_classes is the number of elements of lock_classes[] that is
  * in use.
  */
+#define KEYHASH_BITS		(MAX_LOCKDEP_KEYS_BITS - 1)
+#define KEYHASH_SIZE		(1UL << KEYHASH_BITS)
+static struct hlist_head lock_keys_hash[KEYHASH_SIZE];
 unsigned long nr_lock_classes;
 #ifndef CONFIG_DEBUG_LOCKDEP
 static
@@ -626,7 +629,7 @@ static int very_verbose(struct lock_class *class)
  * Is this the address of a static object:
  */
 #ifdef __KERNEL__
-static int static_obj(void *obj)
+static int static_obj(const void *obj)
 {
 	unsigned long start = (unsigned long) &_stext,
 		      end   = (unsigned long) &_end,
@@ -980,6 +983,71 @@ static void init_data_structures_once(void)
 	}
 }
 
+static inline struct hlist_head *keyhashentry(const struct lock_class_key *key)
+{
+	unsigned long hash = hash_long((uintptr_t)key, KEYHASH_BITS);
+
+	return lock_keys_hash + hash;
+}
+
+/* Register a dynamically allocated key. */
+void lockdep_register_key(struct lock_class_key *key)
+{
+	struct hlist_head *hash_head;
+	struct lock_class_key *k;
+	unsigned long flags;
+
+	if (WARN_ON_ONCE(static_obj(key)))
+		return;
+	hash_head = keyhashentry(key);
+
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
+/* Check whether a key has been registered as a dynamic key. */
+static bool is_dynamic_key(const struct lock_class_key *key)
+{
+	struct hlist_head *hash_head;
+	struct lock_class_key *k;
+	bool found = false;
+
+	if (WARN_ON_ONCE(static_obj(key)))
+		return false;
+
+	/*
+	 * If lock debugging is disabled lock_keys_hash[] may contain
+	 * pointers to memory that has already been freed. Avoid triggering
+	 * a use-after-free in that case by returning early.
+	 */
+	if (!debug_locks)
+		return true;
+
+	hash_head = keyhashentry(key);
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
+		if (k == key) {
+			found = true;
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	return found;
+}
+
 /*
  * Register a lock's class in the hash-table, if the class is not present
  * yet. Otherwise we look it up. We cache the result in the lock object
@@ -1001,7 +1069,7 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 	if (!lock->key) {
 		if (!assign_lock_key(lock))
 			return NULL;
-	} else if (!static_obj(lock->key)) {
+	} else if (!static_obj(lock->key) && !is_dynamic_key(lock->key)) {
 		return NULL;
 	}
 
@@ -3393,13 +3461,13 @@ void lockdep_init_map(struct lockdep_map *lock, const char *name,
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
+			printk(KERN_ERR "BUG: key %px has not been registered!\n",
+			       key);
 		DEBUG_LOCKS_WARN_ON(1);
 		return;
 	}
@@ -4839,6 +4907,45 @@ void lockdep_reset_lock(struct lockdep_map *lock)
 		lockdep_reset_lock_reg(lock);
 }
 
+/*
+ * Unregister a dynamically allocated key. Must not be called from interrupt
+ * context. The caller must ensure that freeing @key only happens after an RCU
+ * grace period.
+ */
+void lockdep_unregister_key(struct lock_class_key *key)
+{
+	struct hlist_head *hash_head = keyhashentry(key);
+	struct lock_class_key *k;
+	struct pending_free *pf;
+	unsigned long flags;
+	bool found = false;
+
+	might_sleep();
+
+	if (WARN_ON_ONCE(static_obj(key)))
+		return;
+
+	pf = get_pending_free_lock(&flags);
+	if (!pf)
+		return;
+	hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
+		if (k == key) {
+			hlist_del_rcu(&k->hash_entry);
+			found = true;
+			break;
+		}
+	}
+	WARN_ON_ONCE(!found);
+	__lockdep_free_key_range(pf, key, 1);
+	schedule_free_zapped_classes(pf);
+	graph_unlock();
+	raw_local_irq_restore(flags);
+
+	/* Wait until is_dynamic_key() has finished accessing k->hash_entry. */
+	synchronize_rcu();
+}
+EXPORT_SYMBOL_GPL(lockdep_unregister_key);
+
 void __init lockdep_init(void)
 {
 	printk("Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar\n");
-- 
2.20.1.97.g81188d93c3-goog

