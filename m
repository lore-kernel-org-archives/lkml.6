Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCF0C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F4D208E7
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:29:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7F4D208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966714AbeFRI27 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:28:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33290 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965150AbeFRI2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:28:55 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6D88CC3C;
        Mon, 18 Jun 2018 08:28:54 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>, Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        "Theodore Y. Tso" <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        linux-fsdevel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 267/279] locking/rwsem: Add a new RWSEM_ANONYMOUSLY_OWNED flag
Date:   Mon, 18 Jun 2018 10:14:12 +0200
Message-Id: <20180618080619.738367697@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Waiman Long <longman@redhat.com>

[ Upstream commit d7d760efad70c7a030725499bf9f342f04af24dd ]

There are use cases where a rwsem can be acquired by one task, but
released by another task. In thess cases, optimistic spinning may need
to be disabled.  One example will be the filesystem freeze/thaw code
where the task that freezes the filesystem will acquire a write lock
on a rwsem and then un-owns it before returning to userspace. Later on,
another task will come along, acquire the ownership, thaw the filesystem
and release the rwsem.

Bit 0 of the owner field was used to designate that it is a reader
owned rwsem. It is now repurposed to mean that the owner of the rwsem
is not known. If only bit 0 is set, the rwsem is reader owned. If bit
0 and other bits are set, it is writer owned with an unknown owner.
One such value for the latter case is (-1L). So we can set owner to 1 for
reader-owned, -1 for writer-owned. The owner is unknown in both cases.

To handle transfer of rwsem ownership, the higher level code should
set the owner field to -1 to indicate a write-locked rwsem with unknown
owner.  Optimistic spinning will be disabled in this case.

Once the higher level code figures who the new owner is, it can then
set the owner field accordingly.

Tested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jan Kara <jack@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Theodore Y. Ts'o <tytso@mit.edu>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-fsdevel@vger.kernel.org
Link: http://lkml.kernel.org/r/1526420991-21213-2-git-send-email-longman@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/locking/rwsem-xadd.c |   17 +++++++----------
 kernel/locking/rwsem.c      |    2 --
 kernel/locking/rwsem.h      |   30 +++++++++++++++++++++---------
 3 files changed, 28 insertions(+), 21 deletions(-)

--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -357,11 +357,8 @@ static inline bool rwsem_can_spin_on_own
 
 	rcu_read_lock();
 	owner = READ_ONCE(sem->owner);
-	if (!rwsem_owner_is_writer(owner)) {
-		/*
-		 * Don't spin if the rwsem is readers owned.
-		 */
-		ret = !rwsem_owner_is_reader(owner);
+	if (!owner || !is_rwsem_owner_spinnable(owner)) {
+		ret = !owner;	/* !owner is spinnable */
 		goto done;
 	}
 
@@ -382,11 +379,11 @@ static noinline bool rwsem_spin_on_owner
 {
 	struct task_struct *owner = READ_ONCE(sem->owner);
 
-	if (!rwsem_owner_is_writer(owner))
-		goto out;
+	if (!is_rwsem_owner_spinnable(owner))
+		return false;
 
 	rcu_read_lock();
-	while (sem->owner == owner) {
+	while (owner && (READ_ONCE(sem->owner) == owner)) {
 		/*
 		 * Ensure we emit the owner->on_cpu, dereference _after_
 		 * checking sem->owner still matches owner, if that fails,
@@ -408,12 +405,12 @@ static noinline bool rwsem_spin_on_owner
 		cpu_relax();
 	}
 	rcu_read_unlock();
-out:
+
 	/*
 	 * If there is a new owner or the owner is not set, we continue
 	 * spinning.
 	 */
-	return !rwsem_owner_is_reader(READ_ONCE(sem->owner));
+	return is_rwsem_owner_spinnable(READ_ONCE(sem->owner));
 }
 
 static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -217,5 +217,3 @@ void up_read_non_owner(struct rw_semapho
 EXPORT_SYMBOL(up_read_non_owner);
 
 #endif
-
-
--- a/kernel/locking/rwsem.h
+++ b/kernel/locking/rwsem.h
@@ -1,20 +1,24 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
  * The owner field of the rw_semaphore structure will be set to
- * RWSEM_READ_OWNED when a reader grabs the lock. A writer will clear
+ * RWSEM_READER_OWNED when a reader grabs the lock. A writer will clear
  * the owner field when it unlocks. A reader, on the other hand, will
  * not touch the owner field when it unlocks.
  *
- * In essence, the owner field now has the following 3 states:
+ * In essence, the owner field now has the following 4 states:
  *  1) 0
  *     - lock is free or the owner hasn't set the field yet
  *  2) RWSEM_READER_OWNED
  *     - lock is currently or previously owned by readers (lock is free
  *       or not set by owner yet)
- *  3) Other non-zero value
- *     - a writer owns the lock
+ *  3) RWSEM_ANONYMOUSLY_OWNED bit set with some other bits set as well
+ *     - lock is owned by an anonymous writer, so spinning on the lock
+ *       owner should be disabled.
+ *  4) Other non-zero value
+ *     - a writer owns the lock and other writers can spin on the lock owner.
  */
-#define RWSEM_READER_OWNED	((struct task_struct *)1UL)
+#define RWSEM_ANONYMOUSLY_OWNED	(1UL << 0)
+#define RWSEM_READER_OWNED	((struct task_struct *)RWSEM_ANONYMOUSLY_OWNED)
 
 #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
 /*
@@ -45,14 +49,22 @@ static inline void rwsem_set_reader_owne
 		WRITE_ONCE(sem->owner, RWSEM_READER_OWNED);
 }
 
-static inline bool rwsem_owner_is_writer(struct task_struct *owner)
+/*
+ * Return true if the a rwsem waiter can spin on the rwsem's owner
+ * and steal the lock, i.e. the lock is not anonymously owned.
+ * N.B. !owner is considered spinnable.
+ */
+static inline bool is_rwsem_owner_spinnable(struct task_struct *owner)
 {
-	return owner && owner != RWSEM_READER_OWNED;
+	return !((unsigned long)owner & RWSEM_ANONYMOUSLY_OWNED);
 }
 
-static inline bool rwsem_owner_is_reader(struct task_struct *owner)
+/*
+ * Return true if rwsem is owned by an anonymous writer or readers.
+ */
+static inline bool rwsem_has_anonymous_owner(struct task_struct *owner)
 {
-	return owner == RWSEM_READER_OWNED;
+	return (unsigned long)owner & RWSEM_ANONYMOUSLY_OWNED;
 }
 #else
 static inline void rwsem_set_owner(struct rw_semaphore *sem)


