Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7DCC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B546218D3
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfBGTKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 14:10:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60284 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727122AbfBGTJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 14:09:56 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ED98F7AE81;
        Thu,  7 Feb 2019 19:09:55 +0000 (UTC)
Received: from llong.com (dhcp-17-35.bos.redhat.com [10.18.17.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BF6A560FDF;
        Thu,  7 Feb 2019 19:09:53 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH-tip 16/22] locking/rwsem: Remove redundant computation of writer lock word
Date:   Thu,  7 Feb 2019 14:07:20 -0500
Message-Id: <1549566446-27967-17-git-send-email-longman@redhat.com>
In-Reply-To: <1549566446-27967-1-git-send-email-longman@redhat.com>
References: <1549566446-27967-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 07 Feb 2019 19:09:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 64-bit architectures, each rwsem writer will have its unique lock
word for acquiring the lock. Right now, the writer code recomputes the
lock word every time it tries to acquire the lock. This is a waste of
time. The lock word is now cached and reused when it is needed.

On 32-bit architectures, the extra constant argument to
rwsem_try_write_lock() and rwsem_try_write_lock_unqueued() should be
optimized out by the compiler.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem-xadd.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index 0869fbf..16dc7a1 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -216,8 +216,8 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
  * race conditions between checking the rwsem wait list and setting the
  * sem->count accordingly.
  */
-static inline bool
-rwsem_try_write_lock(long count, struct rw_semaphore *sem, bool first)
+static inline bool rwsem_try_write_lock(long count, struct rw_semaphore *sem,
+					const long wlock, bool first)
 {
 	long new;
 
@@ -227,7 +227,7 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 	if (!first && RWSEM_COUNT_HANDOFF(count))
 		return false;
 
-	new = (count & ~RWSEM_FLAG_HANDOFF) + RWSEM_WRITER_LOCKED -
+	new = (count & ~RWSEM_FLAG_HANDOFF) + wlock -
 	      (list_is_singular(&sem->wait_list) ? RWSEM_FLAG_WAITERS : 0);
 
 	if (atomic_long_cmpxchg_acquire(&sem->count, count, new) == count) {
@@ -242,7 +242,8 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 /*
  * Try to acquire write lock before the writer has been put on wait queue.
  */
-static inline bool rwsem_try_write_lock_unqueued(struct rw_semaphore *sem)
+static inline bool rwsem_try_write_lock_unqueued(struct rw_semaphore *sem,
+						 const long wlock)
 {
 	long old, count = atomic_long_read(&sem->count);
 
@@ -251,7 +252,7 @@ static inline bool rwsem_try_write_lock_unqueued(struct rw_semaphore *sem)
 			return false;
 
 		old = atomic_long_cmpxchg_acquire(&sem->count, count,
-				count + RWSEM_WRITER_LOCKED);
+				count + wlock);
 		if (old == count) {
 			rwsem_set_owner(sem);
 			lockevent_inc(rwsem_opt_wlock);
@@ -338,7 +339,7 @@ static noinline bool rwsem_spin_on_owner(struct rw_semaphore *sem)
 	return is_rwsem_owner_spinnable(rwsem_get_owner(sem));
 }
 
-static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
+static bool rwsem_optimistic_spin(struct rw_semaphore *sem, const long wlock)
 {
 	bool taken = false;
 
@@ -362,7 +363,7 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
 		/*
 		 * Try to acquire the lock
 		 */
-		if (rwsem_try_write_lock_unqueued(sem)) {
+		if (rwsem_try_write_lock_unqueued(sem, wlock)) {
 			taken = true;
 			break;
 		}
@@ -392,7 +393,7 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
 	return taken;
 }
 #else
-static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
+static bool rwsem_optimistic_spin(struct rw_semaphore *sem, const long wlock)
 {
 	return false;
 }
@@ -514,9 +515,10 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
 	struct rwsem_waiter waiter;
 	struct rw_semaphore *ret = sem;
 	DEFINE_WAKE_Q(wake_q);
+	const long wlock = RWSEM_WRITER_LOCKED;
 
 	/* do optimistic spinning and steal lock if possible */
-	if (rwsem_optimistic_spin(sem))
+	if (rwsem_optimistic_spin(sem, wlock))
 		return sem;
 
 	/*
@@ -569,7 +571,7 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
 	/* wait until we successfully acquire the lock */
 	set_current_state(state);
 	while (true) {
-		if (rwsem_try_write_lock(count, sem, first))
+		if (rwsem_try_write_lock(count, sem, wlock, first))
 			break;
 
 		raw_spin_unlock_irq(&sem->wait_lock);
-- 
1.8.3.1

