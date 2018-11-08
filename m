Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CF1ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B680206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:35:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B680206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727288AbeKIGMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 01:12:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37652 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbeKIGMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 01:12:37 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 201B930A5A59;
        Thu,  8 Nov 2018 20:35:28 +0000 (UTC)
Received: from llong.com (dhcp-17-55.bos.redhat.com [10.18.17.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DB9C11001F4C;
        Thu,  8 Nov 2018 20:35:26 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>
Subject: [RFC PATCH 01/12] locking/lockdep: Rework lockdep_set_novalidate_class()
Date:   Thu,  8 Nov 2018 15:34:17 -0500
Message-Id: <1541709268-3766-2-git-send-email-longman@redhat.com>
In-Reply-To: <1541709268-3766-1-git-send-email-longman@redhat.com>
References: <1541709268-3766-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 08 Nov 2018 20:35:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current lockdep_set_novalidate_class() implementation is like
a hack. It assigns a special class key for that lock and calls
lockdep_init_map() twice.

This patch changes the implementation to make it more general so that
it can be used by other special lock class types. A new "type" field
is added to both the lockdep_map and lock_class structures.

The new field can now be used to designate a lock and a class object
as novalidate. The lockdep_set_novalidate_class() call, however, should
be called before lock initialization which calls lockdep_init_map().

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/lockdep.h  | 14 +++++++++++---
 kernel/locking/lockdep.c | 14 +++++++-------
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 1fd82ff..18f9607 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -58,8 +58,6 @@ struct lock_class_key {
 	struct lockdep_subclass_key	subkeys[MAX_LOCKDEP_SUBCLASSES];
 };
 
-extern struct lock_class_key __lockdep_no_validate__;
-
 #define LOCKSTAT_POINTS		4
 
 /*
@@ -102,6 +100,8 @@ struct lock_class {
 	int				name_version;
 	const char			*name;
 
+	unsigned int			flags;
+
 #ifdef CONFIG_LOCK_STAT
 	unsigned long			contention_point[LOCKSTAT_POINTS];
 	unsigned long			contending_point[LOCKSTAT_POINTS];
@@ -142,6 +142,12 @@ struct lock_class_stats {
 #endif
 
 /*
+ * Lockdep class flags
+ * 1) LOCKDEP_FLAG_NOVALIDATE: No full validation, just simple checks.
+ */
+#define LOCKDEP_FLAG_NOVALIDATE 	(1 << 0)
+
+/*
  * Map the lock object (the lock instance) to the lock-class object.
  * This is embedded into specific lock instances:
  */
@@ -149,6 +155,7 @@ struct lockdep_map {
 	struct lock_class_key		*key;
 	struct lock_class		*class_cache[NR_LOCKDEP_CACHING_CLASSES];
 	const char			*name;
+	unsigned int			flags;
 #ifdef CONFIG_LOCK_STAT
 	int				cpu;
 	unsigned long			ip;
@@ -296,7 +303,8 @@ extern void lockdep_init_map(struct lockdep_map *lock, const char *name,
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

