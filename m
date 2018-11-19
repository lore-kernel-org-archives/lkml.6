Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9244EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A0D220851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:56:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A0D220851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbeKTFVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 00:21:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36722 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbeKTFVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 00:21:47 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4D11573A85;
        Mon, 19 Nov 2018 18:56:53 +0000 (UTC)
Received: from llong.com (dhcp-17-55.bos.redhat.com [10.18.17.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 73CCE608E7;
        Mon, 19 Nov 2018 18:56:51 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2 02/17] locking/lockdep: Rework lockdep_set_novalidate_class()
Date:   Mon, 19 Nov 2018 13:55:11 -0500
Message-Id: <1542653726-5655-3-git-send-email-longman@redhat.com>
In-Reply-To: <1542653726-5655-1-git-send-email-longman@redhat.com>
References: <1542653726-5655-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 19 Nov 2018 18:56:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current lockdep_set_novalidate_class() implementation is like
a hack. It assigns a special class key for that lock and calls
lockdep_init_map() twice.

This patch changes the implementation to make it as a flag bit instead.
This will allow other special locking class types to be defined and
used in the lockdep code.  A new "type" field is added to both the
lockdep_map and lock_class structures.

The new field can now be used to designate a lock and a class object
as novalidate. The lockdep_set_novalidate_class() call, however, should
be called only after lock initialization which calls lockdep_init_map().

For 64-bit architectures, the new type field won't increase the size
of the lock_class structure. The lockdep_map structure won't change as
well for 64-bit architectures with CONFIG_LOCK_STAT configured.

Please note that lockdep_set_novalidate_class() should not be used at
all unless there is overwhelming reason to do so.  Hopefully we can
retired it in the near future.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/lockdep.h  | 17 ++++++++++++++---
 kernel/locking/lockdep.c | 14 +++++++-------
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index c5335df..8fe5b4f 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -58,8 +58,6 @@ struct lock_class_key {
 	struct lockdep_subclass_key	subkeys[MAX_LOCKDEP_SUBCLASSES];
 };
 
-extern struct lock_class_key __lockdep_no_validate__;
-
 #define LOCKSTAT_POINTS		4
 
 /*
@@ -94,6 +92,11 @@ struct lock_class {
 	struct list_head		locks_after, locks_before;
 
 	/*
+	 * Lock class type flags
+	 */
+	unsigned int			flags;
+
+	/*
 	 * Generation counter, when doing certain classes of graph walking,
 	 * to ensure that we check one node only once:
 	 */
@@ -140,6 +143,12 @@ struct lock_class_stats {
 #endif
 
 /*
+ * Lockdep class type flags
+ * 1) LOCKDEP_FLAG_NOVALIDATE: No full validation, just simple checks.
+ */
+#define LOCKDEP_FLAG_NOVALIDATE 	(1 << 0)
+
+/*
  * Map the lock object (the lock instance) to the lock-class object.
  * This is embedded into specific lock instances:
  */
@@ -147,6 +156,7 @@ struct lockdep_map {
 	struct lock_class_key		*key;
 	struct lock_class		*class_cache[NR_LOCKDEP_CACHING_CLASSES];
 	const char			*name;
+	unsigned int			flags;
 #ifdef CONFIG_LOCK_STAT
 	int				cpu;
 	unsigned long			ip;
@@ -294,7 +304,8 @@ extern void lockdep_init_map(struct lockdep_map *lock, const char *name,
 				 (lock)->dep_map.key, sub)
 
 #define lockdep_set_novalidate_class(lock) \
-	lockdep_set_class_and_name(lock, &__lockdep_no_validate__, #lock)
+	do { (lock)->dep_map.flags |= LOCKDEP_FLAG_NOVALIDATE; } while (0)
+
 /*
  * Compare locking classes
  */
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 1efada2..493b567 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -692,10 +692,11 @@ static int count_matching_names(struct lock_class *new_class)
 	hlist_for_each_entry_rcu(class, hash_head, hash_entry) {
 		if (class->key == key) {
 			/*
-			 * Huh! same key, different name? Did someone trample
-			 * on some memory? We're most confused.
+			 * Huh! same key, different name or flags? Did someone
+			 * trample on some memory? We're most confused.
 			 */
-			WARN_ON_ONCE(class->name != lock->name);
+			WARN_ON_ONCE((class->name  != lock->name) ||
+				     (class->flags != lock->flags));
 			return class;
 		}
 	}
@@ -788,6 +789,7 @@ static bool assign_lock_key(struct lockdep_map *lock)
 	debug_atomic_inc(nr_unused_locks);
 	class->key = key;
 	class->name = lock->name;
+	class->flags = lock->flags;
 	class->subclass = subclass;
 	INIT_LIST_HEAD(&class->lock_entry);
 	INIT_LIST_HEAD(&class->locks_before);
@@ -3108,6 +3110,7 @@ static void __lockdep_init_map(struct lockdep_map *lock, const char *name,
 		return;
 	}
 
+	lock->flags = 0;
 	lock->name = name;
 
 	/*
@@ -3152,9 +3155,6 @@ void lockdep_init_map(struct lockdep_map *lock, const char *name,
 }
 EXPORT_SYMBOL_GPL(lockdep_init_map);
 
-struct lock_class_key __lockdep_no_validate__;
-EXPORT_SYMBOL_GPL(__lockdep_no_validate__);
-
 static int
 print_lock_nested_lock_not_held(struct task_struct *curr,
 				struct held_lock *hlock,
@@ -3215,7 +3215,7 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	if (unlikely(!debug_locks))
 		return 0;
 
-	if (!prove_locking || lock->key == &__lockdep_no_validate__)
+	if (!prove_locking || (lock->flags & LOCKDEP_FLAG_NOVALIDATE))
 		check = 0;
 
 	if (subclass < NR_LOCKDEP_CACHING_CLASSES)
-- 
1.8.3.1

