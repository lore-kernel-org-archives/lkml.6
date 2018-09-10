Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3931FC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1BA020865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:55:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1BA020865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbeIJPs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 11:48:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56259 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbeIJPs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 11:48:59 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8AAss7Q1818911
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 10 Sep 2018 03:54:54 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8AAsrJM1818907;
        Mon, 10 Sep 2018 03:54:53 -0700
Date:   Mon, 10 Sep 2018 03:54:53 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-925b9cd1b89a94b7124d128c80dfc48f78a63098@git.kernel.org>
Cc:     peterz@infradead.org, torvalds@linux-foundation.org,
        a.p.zijlstra@chello.nl, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, longman@redhat.com,
        mingo@kernel.org, dave@stgolabs.net, tglx@linutronix.de
Reply-To: will.deacon@arm.com, peterz@infradead.org,
          torvalds@linux-foundation.org, a.p.zijlstra@chello.nl,
          tglx@linutronix.de, mingo@kernel.org, dave@stgolabs.net,
          longman@redhat.com, hpa@zytor.com, linux-kernel@vger.kernel.org
In-Reply-To: <1536265114-10842-1-git-send-email-longman@redhat.com>
References: <1536265114-10842-1-git-send-email-longman@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/rwsem: Make owner store task pointer of
 last owning reader
Git-Commit-ID: 925b9cd1b89a94b7124d128c80dfc48f78a63098
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  925b9cd1b89a94b7124d128c80dfc48f78a63098
Gitweb:     https://git.kernel.org/tip/925b9cd1b89a94b7124d128c80dfc48f78a63098
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Thu, 6 Sep 2018 16:18:34 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 10 Sep 2018 12:04:07 +0200

locking/rwsem: Make owner store task pointer of last owning reader

Currently, when a reader acquires a lock, it only sets the
RWSEM_READER_OWNED bit in the owner field. The other bits are simply
not used. When debugging hanging cases involving rwsems and readers,
the owner value does not provide much useful information at all.

This patch modifies the current behavior to always store the task_struct
pointer of the last rwsem-acquiring reader in a reader-owned rwsem. This
may be useful in debugging rwsem hanging cases especially if only one
reader is involved. However, the task in the owner field may not the
real owner or one of the real owners at all when the owner value is
examined, for example, in a crash dump. So it is just an additional
hint about the past history.

If CONFIG_DEBUG_RWSEMS=y is enabled, the owner field will be checked at
unlock time too to make sure the task pointer value is valid. That does
have a slight performance cost and so is only enabled as part of that
debug option.

From the performance point of view, it is expected that the changes
shouldn't have any noticeable performance impact. A rwsem microbenchmark
(with 48 worker threads and 1:1 reader/writer ratio) was ran on a
2-socket 24-core 48-thread Haswell system.  The locking rates on a
4.19-rc1 based kernel were as follows:

  1) Unpatched kernel:				543.3 kops/s
  2) Patched kernel:				549.2 kops/s
  3) Patched kernel (CONFIG_DEBUG_RWSEMS on):	546.6 kops/s

There was actually a slight increase in performance (1.1%) in this
particular case. Maybe it was caused by the elimination of a branch or
just a testing noise. Turning on the CONFIG_DEBUG_RWSEMS option also
had less than the expected impact on performance.

The least significant 2 bits of the owner value are now used to designate
the rwsem is readers owned and the owners are anonymous.

Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Link: http://lkml.kernel.org/r/1536265114-10842-1-git-send-email-longman@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/rwsem.h       |  4 +-
 kernel/locking/rwsem-xadd.c |  2 +-
 kernel/locking/rwsem.c      |  7 ++--
 kernel/locking/rwsem.h      | 95 +++++++++++++++++++++++++++++++++------------
 4 files changed, 78 insertions(+), 30 deletions(-)

diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index ab93b6eae696..67dbb57508b1 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -45,10 +45,10 @@ struct rw_semaphore {
 };
 
 /*
- * Setting bit 0 of the owner field with other non-zero bits will indicate
+ * Setting bit 1 of the owner field but not bit 0 will indicate
  * that the rwsem is writer-owned with an unknown owner.
  */
-#define RWSEM_OWNER_UNKNOWN	((struct task_struct *)-1L)
+#define RWSEM_OWNER_UNKNOWN	((struct task_struct *)-2L)
 
 extern struct rw_semaphore *rwsem_down_read_failed(struct rw_semaphore *sem);
 extern struct rw_semaphore *rwsem_down_read_failed_killable(struct rw_semaphore *sem);
diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index 01fcb807598c..09b180063ee1 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -180,7 +180,7 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 		 * but it gives the spinners an early indication that the
 		 * readers now have the lock.
 		 */
-		rwsem_set_reader_owned(sem);
+		__rwsem_set_reader_owned(sem, waiter->task);
 	}
 
 	/*
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 776308d2fa9e..e586f0d03ad3 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -117,8 +117,9 @@ EXPORT_SYMBOL(down_write_trylock);
 void up_read(struct rw_semaphore *sem)
 {
 	rwsem_release(&sem->dep_map, 1, _RET_IP_);
-	DEBUG_RWSEMS_WARN_ON(sem->owner != RWSEM_READER_OWNED);
+	DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner & RWSEM_READER_OWNED));
 
+	rwsem_clear_reader_owned(sem);
 	__up_read(sem);
 }
 
@@ -181,7 +182,7 @@ void down_read_non_owner(struct rw_semaphore *sem)
 	might_sleep();
 
 	__down_read(sem);
-	rwsem_set_reader_owned(sem);
+	__rwsem_set_reader_owned(sem, NULL);
 }
 
 EXPORT_SYMBOL(down_read_non_owner);
@@ -215,7 +216,7 @@ EXPORT_SYMBOL(down_write_killable_nested);
 
 void up_read_non_owner(struct rw_semaphore *sem)
 {
-	DEBUG_RWSEMS_WARN_ON(sem->owner != RWSEM_READER_OWNED);
+	DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner & RWSEM_READER_OWNED));
 	__up_read(sem);
 }
 
diff --git a/kernel/locking/rwsem.h b/kernel/locking/rwsem.h
index b9d0e72aa80f..bad2bca0268b 100644
--- a/kernel/locking/rwsem.h
+++ b/kernel/locking/rwsem.h
@@ -1,24 +1,30 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * The owner field of the rw_semaphore structure will be set to
- * RWSEM_READER_OWNED when a reader grabs the lock. A writer will clear
- * the owner field when it unlocks. A reader, on the other hand, will
- * not touch the owner field when it unlocks.
+ * The least significant 2 bits of the owner value has the following
+ * meanings when set.
+ *  - RWSEM_READER_OWNED (bit 0): The rwsem is owned by readers
+ *  - RWSEM_ANONYMOUSLY_OWNED (bit 1): The rwsem is anonymously owned,
+ *    i.e. the owner(s) cannot be readily determined. It can be reader
+ *    owned or the owning writer is indeterminate.
  *
- * In essence, the owner field now has the following 4 states:
- *  1) 0
- *     - lock is free or the owner hasn't set the field yet
- *  2) RWSEM_READER_OWNED
- *     - lock is currently or previously owned by readers (lock is free
- *       or not set by owner yet)
- *  3) RWSEM_ANONYMOUSLY_OWNED bit set with some other bits set as well
- *     - lock is owned by an anonymous writer, so spinning on the lock
- *       owner should be disabled.
- *  4) Other non-zero value
- *     - a writer owns the lock and other writers can spin on the lock owner.
+ * When a writer acquires a rwsem, it puts its task_struct pointer
+ * into the owner field. It is cleared after an unlock.
+ *
+ * When a reader acquires a rwsem, it will also puts its task_struct
+ * pointer into the owner field with both the RWSEM_READER_OWNED and
+ * RWSEM_ANONYMOUSLY_OWNED bits set. On unlock, the owner field will
+ * largely be left untouched. So for a free or reader-owned rwsem,
+ * the owner value may contain information about the last reader that
+ * acquires the rwsem. The anonymous bit is set because that particular
+ * reader may or may not still own the lock.
+ *
+ * That information may be helpful in debugging cases where the system
+ * seems to hang on a reader owned rwsem especially if only one reader
+ * is involved. Ideally we would like to track all the readers that own
+ * a rwsem, but the overhead is simply too big.
  */
-#define RWSEM_ANONYMOUSLY_OWNED	(1UL << 0)
-#define RWSEM_READER_OWNED	((struct task_struct *)RWSEM_ANONYMOUSLY_OWNED)
+#define RWSEM_READER_OWNED	(1UL << 0)
+#define RWSEM_ANONYMOUSLY_OWNED	(1UL << 1)
 
 #ifdef CONFIG_DEBUG_RWSEMS
 # define DEBUG_RWSEMS_WARN_ON(c)	DEBUG_LOCKS_WARN_ON(c)
@@ -44,15 +50,26 @@ static inline void rwsem_clear_owner(struct rw_semaphore *sem)
 	WRITE_ONCE(sem->owner, NULL);
 }
 
+/*
+ * The task_struct pointer of the last owning reader will be left in
+ * the owner field.
+ *
+ * Note that the owner value just indicates the task has owned the rwsem
+ * previously, it may not be the real owner or one of the real owners
+ * anymore when that field is examined, so take it with a grain of salt.
+ */
+static inline void __rwsem_set_reader_owned(struct rw_semaphore *sem,
+					    struct task_struct *owner)
+{
+	unsigned long val = (unsigned long)owner | RWSEM_READER_OWNED
+						 | RWSEM_ANONYMOUSLY_OWNED;
+
+	WRITE_ONCE(sem->owner, (struct task_struct *)val);
+}
+
 static inline void rwsem_set_reader_owned(struct rw_semaphore *sem)
 {
-	/*
-	 * We check the owner value first to make sure that we will only
-	 * do a write to the rwsem cacheline when it is really necessary
-	 * to minimize cacheline contention.
-	 */
-	if (READ_ONCE(sem->owner) != RWSEM_READER_OWNED)
-		WRITE_ONCE(sem->owner, RWSEM_READER_OWNED);
+	__rwsem_set_reader_owned(sem, current);
 }
 
 /*
@@ -72,6 +89,25 @@ static inline bool rwsem_has_anonymous_owner(struct task_struct *owner)
 {
 	return (unsigned long)owner & RWSEM_ANONYMOUSLY_OWNED;
 }
+
+#ifdef CONFIG_DEBUG_RWSEMS
+/*
+ * With CONFIG_DEBUG_RWSEMS configured, it will make sure that if there
+ * is a task pointer in owner of a reader-owned rwsem, it will be the
+ * real owner or one of the real owners. The only exception is when the
+ * unlock is done by up_read_non_owner().
+ */
+#define rwsem_clear_reader_owned rwsem_clear_reader_owned
+static inline void rwsem_clear_reader_owned(struct rw_semaphore *sem)
+{
+	unsigned long val = (unsigned long)current | RWSEM_READER_OWNED
+						   | RWSEM_ANONYMOUSLY_OWNED;
+	if (READ_ONCE(sem->owner) == (struct task_struct *)val)
+		cmpxchg_relaxed((unsigned long *)&sem->owner, val,
+				RWSEM_READER_OWNED | RWSEM_ANONYMOUSLY_OWNED);
+}
+#endif
+
 #else
 static inline void rwsem_set_owner(struct rw_semaphore *sem)
 {
@@ -81,7 +117,18 @@ static inline void rwsem_clear_owner(struct rw_semaphore *sem)
 {
 }
 
+static inline void __rwsem_set_reader_owned(struct rw_semaphore *sem,
+					   struct task_struct *owner)
+{
+}
+
 static inline void rwsem_set_reader_owned(struct rw_semaphore *sem)
 {
 }
 #endif
+
+#ifndef rwsem_clear_reader_owned
+static inline void rwsem_clear_reader_owned(struct rw_semaphore *sem)
+{
+}
+#endif
