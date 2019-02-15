Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7D0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 20:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9B19222D9
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 20:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391633AbfBOUus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 15:50:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38524 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391527AbfBOUug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 15:50:36 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 29003325B0;
        Fri, 15 Feb 2019 20:50:36 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D18725BBB4;
        Fri, 15 Feb 2019 20:50:34 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH-tip v2 10/10] locking/rwsem: Enable lock event counting
Date:   Fri, 15 Feb 2019 15:50:10 -0500
Message-Id: <1550263810-31947-11-git-send-email-longman@redhat.com>
In-Reply-To: <1550263810-31947-1-git-send-email-longman@redhat.com>
References: <1550263810-31947-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 15 Feb 2019 20:50:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add lock event counting calls so that we can track the number of lock
events happening in the rwsem code.

With CONFIG_LOCK_EVENT_COUNTS on and booting a 4-socket 112-thread x86-64
system, the rwsem counts after system bootup were as follows:

  rwsem_opt_fail=261
  rwsem_opt_wlock=50636
  rwsem_rlock=445
  rwsem_rlock_fail=0
  rwsem_rlock_fast=22
  rwsem_rtrylock=810144
  rwsem_sleep_reader=441
  rwsem_sleep_writer=310
  rwsem_wake_reader=355
  rwsem_wake_writer=2335
  rwsem_wlock=261
  rwsem_wlock_fail=0
  rwsem_wtrylock=20583

It can be seen that most of the lock acquisitions in the slowpath were
write-locks in the optimistic spinning code path with no sleeping at
all. For this system, over 97% of the locks are acquired via optimistic
spinning. It illustrates the importance of optimistic spinning in
improving the performance of rwsem.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 arch/Kconfig                      |  1 -
 kernel/locking/lock_events_list.h | 17 +++++++++++++++++
 kernel/locking/rwsem-xadd.c       | 11 +++++++++++
 kernel/locking/rwsem.h            |  4 ++++
 4 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 5fccff4..f32eb7b 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -891,7 +891,6 @@ config ARCH_USE_MEMREMAP_PROT
 config LOCK_EVENT_COUNTS
 	bool "Locking event counts collection"
 	depends on DEBUG_FS
-	depends on QUEUED_SPINLOCKS
 	---help---
 	  Enable light-weight counting of various locking related events
 	  in the system with minimal performance impact. This reduces
diff --git a/kernel/locking/lock_events_list.h b/kernel/locking/lock_events_list.h
index 8b4d2e1..ad7668c 100644
--- a/kernel/locking/lock_events_list.h
+++ b/kernel/locking/lock_events_list.h
@@ -48,3 +48,20 @@
 LOCK_EVENT(lock_use_node4)	/* # of locking ops that use 4th percpu node */
 LOCK_EVENT(lock_no_node)	/* # of locking ops w/o using percpu node    */
 #endif /* CONFIG_QUEUED_SPINLOCKS */
+
+/*
+ * Locking events for rwsem
+ */
+LOCK_EVENT(rwsem_sleep_reader)	/* # of reader sleeps			*/
+LOCK_EVENT(rwsem_sleep_writer)	/* # of writer sleeps			*/
+LOCK_EVENT(rwsem_wake_reader)	/* # of reader wakeups			*/
+LOCK_EVENT(rwsem_wake_writer)	/* # of writer wakeups			*/
+LOCK_EVENT(rwsem_opt_wlock)	/* # of write locks opt-spin acquired	*/
+LOCK_EVENT(rwsem_opt_fail)	/* # of failed opt-spinnings		*/
+LOCK_EVENT(rwsem_rlock)		/* # of read locks acquired		*/
+LOCK_EVENT(rwsem_rlock_fast)	/* # of fast read locks acquired	*/
+LOCK_EVENT(rwsem_rlock_fail)	/* # of failed read lock acquisitions	*/
+LOCK_EVENT(rwsem_rtrylock)	/* # of read trylock calls		*/
+LOCK_EVENT(rwsem_wlock)		/* # of write locks acquired		*/
+LOCK_EVENT(rwsem_wlock_fail)	/* # of failed write lock acquisitions	*/
+LOCK_EVENT(rwsem_wtrylock)	/* # of write trylock calls		*/
diff --git a/kernel/locking/rwsem-xadd.c b/kernel/locking/rwsem-xadd.c
index f6198e1..6b3ee99 100644
--- a/kernel/locking/rwsem-xadd.c
+++ b/kernel/locking/rwsem-xadd.c
@@ -147,6 +147,7 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 			 * will notice the queued writer.
 			 */
 			wake_q_add(wake_q, waiter->task);
+			lockevent_inc(rwsem_wake_writer);
 		}
 
 		return;
@@ -214,6 +215,7 @@ static void __rwsem_mark_wake(struct rw_semaphore *sem,
 	}
 
 	adjustment = woken * RWSEM_ACTIVE_READ_BIAS - adjustment;
+	lockevent_cond_inc(rwsem_wake_reader, woken);
 	if (list_empty(&sem->wait_list)) {
 		/* hit end of list above */
 		adjustment -= RWSEM_WAITING_BIAS;
@@ -265,6 +267,7 @@ static inline bool rwsem_try_write_lock_unqueued(struct rw_semaphore *sem)
 		if (atomic_long_try_cmpxchg_acquire(&sem->count, &count,
 					count + RWSEM_ACTIVE_WRITE_BIAS)) {
 			rwsem_set_owner(sem);
+			lockevent_inc(rwsem_opt_wlock);
 			return true;
 		}
 	}
@@ -389,6 +392,7 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
 	osq_unlock(&sem->osq);
 done:
 	preempt_enable();
+	lockevent_cond_inc(rwsem_opt_fail, !taken);
 	return taken;
 }
 
@@ -436,6 +440,7 @@ static inline bool rwsem_has_spinner(struct rw_semaphore *sem)
 		if (atomic_long_read(&sem->count) >= 0) {
 			raw_spin_unlock_irq(&sem->wait_lock);
 			rwsem_set_reader_owned(sem);
+			lockevent_inc(rwsem_rlock_fast);
 			return sem;
 		}
 		adjustment += RWSEM_WAITING_BIAS;
@@ -472,9 +477,11 @@ static inline bool rwsem_has_spinner(struct rw_semaphore *sem)
 			break;
 		}
 		schedule();
+		lockevent_inc(rwsem_sleep_reader);
 	}
 
 	__set_current_state(TASK_RUNNING);
+	lockevent_inc(rwsem_rlock);
 	return sem;
 out_nolock:
 	list_del(&waiter.list);
@@ -482,6 +489,7 @@ static inline bool rwsem_has_spinner(struct rw_semaphore *sem)
 		atomic_long_add(-RWSEM_WAITING_BIAS, &sem->count);
 	raw_spin_unlock_irq(&sem->wait_lock);
 	__set_current_state(TASK_RUNNING);
+	lockevent_inc(rwsem_rlock_fail);
 	return ERR_PTR(-EINTR);
 }
 
@@ -575,6 +583,7 @@ static inline bool rwsem_has_spinner(struct rw_semaphore *sem)
 				goto out_nolock;
 
 			schedule();
+			lockevent_inc(rwsem_sleep_writer);
 			set_current_state(state);
 		} while ((count = atomic_long_read(&sem->count)) & RWSEM_ACTIVE_MASK);
 
@@ -583,6 +592,7 @@ static inline bool rwsem_has_spinner(struct rw_semaphore *sem)
 	__set_current_state(TASK_RUNNING);
 	list_del(&waiter.list);
 	raw_spin_unlock_irq(&sem->wait_lock);
+	lockevent_inc(rwsem_wlock);
 
 	return ret;
 
@@ -596,6 +606,7 @@ static inline bool rwsem_has_spinner(struct rw_semaphore *sem)
 		__rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
 	raw_spin_unlock_irq(&sem->wait_lock);
 	wake_up_q(&wake_q);
+	lockevent_inc(rwsem_wlock_fail);
 
 	return ERR_PTR(-EINTR);
 }
diff --git a/kernel/locking/rwsem.h b/kernel/locking/rwsem.h
index c8fd3f1..6479ecd 100644
--- a/kernel/locking/rwsem.h
+++ b/kernel/locking/rwsem.h
@@ -23,6 +23,8 @@
  * is involved. Ideally we would like to track all the readers that own
  * a rwsem, but the overhead is simply too big.
  */
+#include "lock_events.h"
+
 #define RWSEM_READER_OWNED	(1UL << 0)
 #define RWSEM_ANONYMOUSLY_OWNED	(1UL << 1)
 
@@ -198,6 +200,7 @@ static inline int __down_read_trylock(struct rw_semaphore *sem)
 	 */
 	long tmp = RWSEM_UNLOCKED_VALUE;
 
+	lockevent_inc(rwsem_rtrylock);
 	do {
 		if (atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
 					tmp + RWSEM_ACTIVE_READ_BIAS)) {
@@ -239,6 +242,7 @@ static inline int __down_write_trylock(struct rw_semaphore *sem)
 {
 	long tmp;
 
+	lockevent_inc(rwsem_wtrylock);
 	tmp = atomic_long_cmpxchg_acquire(&sem->count, RWSEM_UNLOCKED_VALUE,
 		      RWSEM_ACTIVE_WRITE_BIAS);
 	if (tmp == RWSEM_UNLOCKED_VALUE) {
-- 
1.8.3.1

