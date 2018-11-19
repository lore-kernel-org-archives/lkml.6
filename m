Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C9EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70EF220851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:57:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70EF220851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730769AbeKTFWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 00:22:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54872 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbeKTFWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 00:22:42 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6DF963082E4C;
        Mon, 19 Nov 2018 18:57:48 +0000 (UTC)
Received: from llong.com (dhcp-17-55.bos.redhat.com [10.18.17.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F1BB5608E7;
        Mon, 19 Nov 2018 18:57:46 +0000 (UTC)
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
Subject: [PATCH v2 17/17] locking/lockdep: Check raw/non-raw locking conflicts
Date:   Mon, 19 Nov 2018 13:55:26 -0500
Message-Id: <1542653726-5655-18-git-send-email-longman@redhat.com>
In-Reply-To: <1542653726-5655-1-git-send-email-longman@redhat.com>
References: <1542653726-5655-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 19 Nov 2018 18:57:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A task holding a raw spinlock should not acquire a non-raw lock as that
will break PREEMPT_RT kernel. Checking is now added and a lockdep warning
will be printed if that happens.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/lockdep.h         |  6 ++++++
 include/linux/spinlock_types.h  |  4 ++--
 kernel/locking/lockdep.c        | 15 +++++++++++++--
 kernel/locking/spinlock_debug.c |  1 +
 4 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index b9435fb..9a6fe0e 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -150,12 +150,15 @@ struct lock_class_stats {
  *    another lock within its critical section is not allowed.
  * 3) LOCKDEP_FLAG_TERMINAL_NESTABLE: This is a terminal lock that can
  *    allow one more regular terminal lock to be nested underneath it.
+ * 4) LOCKDEP_FLAG_RAW: This is a raw spinlock. A task holding a raw
+ *    spinlock should not acquire a non-raw lock.
  *
  * Only the least significant 4 bits of the flags will be copied to the
  * held_lock structure.
  */
 #define LOCKDEP_FLAG_TERMINAL		(1 << 0)
 #define LOCKDEP_FLAG_TERMINAL_NESTABLE	(1 << 1)
+#define LOCKDEP_FLAG_RAW		(1 << 2)
 #define LOCKDEP_FLAG_NOVALIDATE 	(1 << 4)
 
 #define LOCKDEP_HLOCK_FLAGS_MASK	0x0f
@@ -333,6 +336,8 @@ extern void lockdep_init_map(struct lockdep_map *lock, const char *name,
 	do { (lock)->dep_map.flags |= LOCKDEP_FLAG_TERMINAL; } while (0)
 #define lockdep_set_terminal_nestable_class(lock) \
 	do { (lock)->dep_map.flags |= LOCKDEP_FLAG_TERMINAL_NESTABLE; } while (0)
+#define lockdep_set_raw_class(lock) \
+	do { (lock)->dep_map.flags |= LOCKDEP_FLAG_RAW; } while (0)
 
 /*
  * Compare locking classes
@@ -448,6 +453,7 @@ static inline void lockdep_on(void)
 		do { (void)(key); } while (0)
 #define lockdep_set_subclass(lock, sub)		do { } while (0)
 
+#define lockdep_set_raw_class(lock)		do { } while (0)
 #define lockdep_set_novalidate_class(lock)	do { } while (0)
 #define lockdep_set_terminal_class(lock)	do { } while (0)
 #define lockdep_set_terminal_nestable_class(lock)	do { } while (0)
diff --git a/include/linux/spinlock_types.h b/include/linux/spinlock_types.h
index 6a8086e..1d2114b 100644
--- a/include/linux/spinlock_types.h
+++ b/include/linux/spinlock_types.h
@@ -55,11 +55,11 @@
 	SPIN_DEP_MAP_INIT(lockname, f) }
 
 #define __RAW_SPIN_LOCK_UNLOCKED(lockname)	\
-	(raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname, 0)
+	(raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname, LOCKDEP_FLAG_RAW)
 
 #define __RAW_TERMINAL_SPIN_LOCK_UNLOCKED(lockname)	\
 	(raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname, \
-						     LOCKDEP_FLAG_TERMINAL)
+					LOCKDEP_FLAG_TERMINAL|LOCKDEP_FLAG_RAW)
 
 #define DEFINE_RAW_SPINLOCK(x)	raw_spinlock_t x = __RAW_SPIN_LOCK_UNLOCKED(x)
 #define DEFINE_RAW_TERMINAL_SPINLOCK(x)	\
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 5a853a6..efafd2d 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3273,8 +3273,8 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 		 * one isn't a regular terminal lock.
 		 */
 		prev_type = hlock_is_terminal(hlock);
-		if (DEBUG_LOCKS_WARN_ON((prev_type == LOCKDEP_FLAG_TERMINAL) ||
-			((prev_type == LOCKDEP_FLAG_TERMINAL_NESTABLE) &&
+		if (DEBUG_LOCKS_WARN_ON((prev_type & LOCKDEP_FLAG_TERMINAL) ||
+			((prev_type & LOCKDEP_FLAG_TERMINAL_NESTABLE) &&
 			 (flags_is_terminal(class->flags) !=
 				LOCKDEP_FLAG_TERMINAL)))) {
 			pr_warn("Terminal lock error: prev lock = %s, curr lock = %s\n",
@@ -3282,6 +3282,17 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 			return 0;
 		}
 
+		/*
+		 * A task holding a raw spinlock should not acquire another
+		 * non-raw lock.
+		 */
+		if (DEBUG_LOCKS_WARN_ON((prev_type & LOCKDEP_FLAG_RAW) &&
+					!(class->flags & LOCKDEP_FLAG_RAW))) {
+			pr_warn("Raw lock error: prev lock = %s, curr lock = %s\n",
+				hlock->instance->name, class->name);
+			return 0;
+		}
+
 		if (hlock->class_idx == class_idx && nest_lock) {
 			if (hlock->references) {
 				/*
diff --git a/kernel/locking/spinlock_debug.c b/kernel/locking/spinlock_debug.c
index 9aa0fcc..1794d47 100644
--- a/kernel/locking/spinlock_debug.c
+++ b/kernel/locking/spinlock_debug.c
@@ -22,6 +22,7 @@ void __raw_spin_lock_init(raw_spinlock_t *lock, const char *name,
 	 */
 	debug_check_no_locks_freed((void *)lock, sizeof(*lock));
 	lockdep_init_map(&lock->dep_map, name, key, 0);
+	lockdep_set_raw_class(lock);
 #endif
 	lock->raw_lock = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
 	lock->magic = SPINLOCK_MAGIC;
-- 
1.8.3.1

