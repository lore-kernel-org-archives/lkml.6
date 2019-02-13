Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C739CC282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 00:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD85222BA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 00:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732824AbfBMA2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 19:28:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50818 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727343AbfBMA2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 19:28:18 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C557910F90;
        Wed, 13 Feb 2019 00:28:17 +0000 (UTC)
Received: from llong.com (ovpn-121-56.rdu2.redhat.com [10.10.121.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B505C5C223;
        Wed, 13 Feb 2019 00:28:12 +0000 (UTC)
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
Subject: [PATCH 05/10] locking/rwsem: Add debug check for __down_read*()
Date:   Tue, 12 Feb 2019 19:27:02 -0500
Message-Id: <1550017627-14504-6-git-send-email-longman@redhat.com>
In-Reply-To: <1550017627-14504-1-git-send-email-longman@redhat.com>
References: <1550017627-14504-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 13 Feb 2019 00:28:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When rwsem_down_read_failed*() return, the read lock is acquired
indirectly by others. So debug checks are added in __down_read() and
__down_read_killable() to make sure the rwsem is really reader-owned.

The other debug check calls in kernel/locking/rwsem.c except the
one in up_read_non_owner() are also moved over to rwsem-xadd.h.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rwsem-xadd.h | 12 ++++++++++--
 kernel/locking/rwsem.c      |  3 ---
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/locking/rwsem-xadd.h b/kernel/locking/rwsem-xadd.h
index fac363b..12cbb80 100644
--- a/kernel/locking/rwsem-xadd.h
+++ b/kernel/locking/rwsem-xadd.h
@@ -165,10 +165,13 @@ static inline void rwsem_clear_reader_owned(struct rw_semaphore *sem)
  */
 static inline void __down_read(struct rw_semaphore *sem)
 {
-	if (unlikely(atomic_long_inc_return_acquire(&sem->count) <= 0))
+	if (unlikely(atomic_long_inc_return_acquire(&sem->count) <= 0)) {
 		rwsem_down_read_failed(sem);
-	else
+		DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner &
+					RWSEM_READER_OWNED));
+	} else {
 		rwsem_set_reader_owned(sem);
+	}
 }
 
 static inline int __down_read_killable(struct rw_semaphore *sem)
@@ -176,6 +179,8 @@ static inline int __down_read_killable(struct rw_semaphore *sem)
 	if (unlikely(atomic_long_inc_return_acquire(&sem->count) <= 0)) {
 		if (IS_ERR(rwsem_down_read_failed_killable(sem)))
 			return -EINTR;
+		DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner &
+					RWSEM_READER_OWNED));
 	} else {
 		rwsem_set_reader_owned(sem);
 	}
@@ -243,6 +248,7 @@ static inline void __up_read(struct rw_semaphore *sem)
 {
 	long tmp;
 
+	DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner & RWSEM_READER_OWNED));
 	rwsem_clear_reader_owned(sem);
 	tmp = atomic_long_dec_return_release(&sem->count);
 	if (unlikely(tmp < -1 && (tmp & RWSEM_ACTIVE_MASK) == 0))
@@ -254,6 +260,7 @@ static inline void __up_read(struct rw_semaphore *sem)
  */
 static inline void __up_write(struct rw_semaphore *sem)
 {
+	DEBUG_RWSEMS_WARN_ON(sem->owner != current);
 	rwsem_clear_owner(sem);
 	if (unlikely(atomic_long_sub_return_release(RWSEM_ACTIVE_WRITE_BIAS,
 						    &sem->count) < 0))
@@ -274,6 +281,7 @@ static inline void __downgrade_write(struct rw_semaphore *sem)
 	 * read-locked region is ok to be re-ordered into the
 	 * write side. As such, rely on RELEASE semantics.
 	 */
+	DEBUG_RWSEMS_WARN_ON(sem->owner != current);
 	tmp = atomic_long_add_return_release(-RWSEM_WAITING_BIAS, &sem->count);
 	rwsem_set_reader_owned(sem);
 	if (tmp < 0)
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index b3b4582..598fc7c 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -114,7 +114,6 @@ int down_write_trylock(struct rw_semaphore *sem)
 void up_read(struct rw_semaphore *sem)
 {
 	rwsem_release(&sem->dep_map, 1, _RET_IP_);
-	DEBUG_RWSEMS_WARN_ON(!((unsigned long)sem->owner & RWSEM_READER_OWNED));
 
 	__up_read(sem);
 }
@@ -127,7 +126,6 @@ void up_read(struct rw_semaphore *sem)
 void up_write(struct rw_semaphore *sem)
 {
 	rwsem_release(&sem->dep_map, 1, _RET_IP_);
-	DEBUG_RWSEMS_WARN_ON(sem->owner != current);
 
 	__up_write(sem);
 }
@@ -140,7 +138,6 @@ void up_write(struct rw_semaphore *sem)
 void downgrade_write(struct rw_semaphore *sem)
 {
 	lock_downgrade(&sem->dep_map, _RET_IP_);
-	DEBUG_RWSEMS_WARN_ON(sem->owner != current);
 
 	__downgrade_write(sem);
 }
-- 
1.8.3.1

