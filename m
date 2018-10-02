Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07846C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBD3720878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:08:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBD3720878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbeJBQuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:50:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60343 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbeJBQuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 12:50:55 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w92A7uve1915805
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 2 Oct 2018 03:07:56 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w92A7u1Q1915802;
        Tue, 2 Oct 2018 03:07:56 -0700
Date:   Tue, 2 Oct 2018 03:07:56 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Matthew Wilcox <tipbot@zytor.com>
Message-ID: <tip-27df89689e257cccb604fdf56c91a75a25aa554a@git.kernel.org>
Cc:     peterz@infradead.org, will.deacon@arm.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, longman@redhat.com,
        torvalds@linux-foundation.org, mingo@kernel.org, hpa@zytor.com,
        willy@infradead.org, arnd@arndb.de
Reply-To: tglx@linutronix.de, longman@redhat.com,
          linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
          peterz@infradead.org, will.deacon@arm.com, arnd@arndb.de,
          hpa@zytor.com, mingo@kernel.org, willy@infradead.org
In-Reply-To: <20180820162639.GC25153@bombadil.infradead.org>
References: <20180820162639.GC25153@bombadil.infradead.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/spinlocks: Remove an instruction from
 spin and write locks
Git-Commit-ID: 27df89689e257cccb604fdf56c91a75a25aa554a
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

Commit-ID:  27df89689e257cccb604fdf56c91a75a25aa554a
Gitweb:     https://git.kernel.org/tip/27df89689e257cccb604fdf56c91a75a25aa554a
Author:     Matthew Wilcox <willy@infradead.org>
AuthorDate: Mon, 20 Aug 2018 10:19:14 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 2 Oct 2018 09:49:42 +0200

locking/spinlocks: Remove an instruction from spin and write locks

Both spin locks and write locks currently do:

 f0 0f b1 17             lock cmpxchg %edx,(%rdi)
 85 c0                   test   %eax,%eax
 75 05                   jne    [slowpath]

This 'test' insn is superfluous; the cmpxchg insn sets the Z flag
appropriately.  Peter pointed out that using atomic_try_cmpxchg_acquire()
will let the compiler know this is true.  Comparing before/after
disassemblies show the only effect is to remove this insn.

Take this opportunity to make the spin & write lock code resemble each
other more closely and have similar likely() hints.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Waiman Long <longman@redhat.com>
Link: http://lkml.kernel.org/r/20180820162639.GC25153@bombadil.infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/asm-generic/qrwlock.h   |  7 ++++---
 include/asm-generic/qspinlock.h | 16 +++++++++-------
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/include/asm-generic/qrwlock.h b/include/asm-generic/qrwlock.h
index 0f7062bd55e5..36254d2da8e0 100644
--- a/include/asm-generic/qrwlock.h
+++ b/include/asm-generic/qrwlock.h
@@ -71,8 +71,8 @@ static inline int queued_write_trylock(struct qrwlock *lock)
 	if (unlikely(cnts))
 		return 0;
 
-	return likely(atomic_cmpxchg_acquire(&lock->cnts,
-					     cnts, cnts | _QW_LOCKED) == cnts);
+	return likely(atomic_try_cmpxchg_acquire(&lock->cnts, &cnts,
+				_QW_LOCKED));
 }
 /**
  * queued_read_lock - acquire read lock of a queue rwlock
@@ -96,8 +96,9 @@ static inline void queued_read_lock(struct qrwlock *lock)
  */
 static inline void queued_write_lock(struct qrwlock *lock)
 {
+	u32 cnts = 0;
 	/* Optimize for the unfair lock case where the fair flag is 0. */
-	if (atomic_cmpxchg_acquire(&lock->cnts, 0, _QW_LOCKED) == 0)
+	if (likely(atomic_try_cmpxchg_acquire(&lock->cnts, &cnts, _QW_LOCKED)))
 		return;
 
 	queued_write_lock_slowpath(lock);
diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspinlock.h
index 9cc457597ddf..7541fa707f5b 100644
--- a/include/asm-generic/qspinlock.h
+++ b/include/asm-generic/qspinlock.h
@@ -66,10 +66,12 @@ static __always_inline int queued_spin_is_contended(struct qspinlock *lock)
  */
 static __always_inline int queued_spin_trylock(struct qspinlock *lock)
 {
-	if (!atomic_read(&lock->val) &&
-	   (atomic_cmpxchg_acquire(&lock->val, 0, _Q_LOCKED_VAL) == 0))
-		return 1;
-	return 0;
+	u32 val = atomic_read(&lock->val);
+
+	if (unlikely(val))
+		return 0;
+
+	return likely(atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LOCKED_VAL));
 }
 
 extern void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
@@ -80,11 +82,11 @@ extern void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
  */
 static __always_inline void queued_spin_lock(struct qspinlock *lock)
 {
-	u32 val;
+	u32 val = 0;
 
-	val = atomic_cmpxchg_acquire(&lock->val, 0, _Q_LOCKED_VAL);
-	if (likely(val == 0))
+	if (likely(atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LOCKED_VAL)))
 		return;
+
 	queued_spin_lock_slowpath(lock, val);
 }
 
