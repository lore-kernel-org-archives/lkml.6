Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781ADC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 15:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11A19216FC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 15:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D7ld23jy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11A19216FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbeHTSW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 14:22:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38244 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbeHTSW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 14:22:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=R9UYtUfG4TiUN2JcGWFK0knDG94XZodrpJZATk7qUrY=; b=D7ld23jyiO1UzzdsAwaPLl4tW
        4Op8lbLQu0bHUAk5y1CZSQaS0g6/hwg6H8goP6HquB//bFist3iN1pM2fJd/Wq8SpTb+AOnhNZtp5
        RCxbgtsuPnByJHgOuXnZpuSbFK0LsrPqtMdMLvmJqiZsq46nLUwt7KKQ64QTVD5NNgyFHIyh8yBYD
        0GNFuXh02etzWrIHGdb7SQ2fWzWIIMOlZeqAnCooquY53RCCm7qHNNlQfmr5xm0c21/zBcxHuSdt5
        dXrD3vCLdVIhWpGwLRhR+oA4iv1c5ckX6w3jXwvHndmCeVdrmHN7aumS1uUGcMDyES+23W0AmsNrg
        PVrK5s2OQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1frlle-0000dd-NS; Mon, 20 Aug 2018 15:06:54 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] locking: Remove an insn from spin and write locks
Date:   Mon, 20 Aug 2018 08:06:52 -0700
Message-Id: <20180820150652.29482-1-willy@infradead.org>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both spin locks and write locks currently do:

 f0 0f b1 17             lock cmpxchg %edx,(%rdi)
 85 c0                   test   %eax,%eax
 75 05                   jne    [slowpath]

This 'test' insn is superfluous; the cmpxchg insn sets the Z flag
appropriately.  Peter pointed out that using atomic_try_cmpxchg()
will let the compiler know this is true.  Comparing before/after
disassemblies show the only effect is to remove this insn.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 include/asm-generic/qrwlock.h   | 6 +++---
 include/asm-generic/qspinlock.h | 9 +++++----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/asm-generic/qrwlock.h b/include/asm-generic/qrwlock.h
index 0f7062bd55e5..9a1beb7ad0de 100644
--- a/include/asm-generic/qrwlock.h
+++ b/include/asm-generic/qrwlock.h
@@ -71,8 +71,7 @@ static inline int queued_write_trylock(struct qrwlock *lock)
 	if (unlikely(cnts))
 		return 0;
 
-	return likely(atomic_cmpxchg_acquire(&lock->cnts,
-					     cnts, cnts | _QW_LOCKED) == cnts);
+	return likely(atomic_try_cmpxchg(&lock->cnts, &cnts, _QW_LOCKED));
 }
 /**
  * queued_read_lock - acquire read lock of a queue rwlock
@@ -96,8 +95,9 @@ static inline void queued_read_lock(struct qrwlock *lock)
  */
 static inline void queued_write_lock(struct qrwlock *lock)
 {
+	u32 cnts = 0;
 	/* Optimize for the unfair lock case where the fair flag is 0. */
-	if (atomic_cmpxchg_acquire(&lock->cnts, 0, _QW_LOCKED) == 0)
+	if (atomic_try_cmpxchg_acquire(&lock->cnts, &cnts, _QW_LOCKED))
 		return;
 
 	queued_write_lock_slowpath(lock);
diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspinlock.h
index 95263e943fcc..d125f0c0b3d9 100644
--- a/include/asm-generic/qspinlock.h
+++ b/include/asm-generic/qspinlock.h
@@ -68,8 +68,10 @@ int queued_spin_is_contended(const struct qspinlock *lock)
  */
 static __always_inline int queued_spin_trylock(struct qspinlock *lock)
 {
+	u32 val = 0;
+
 	if (!atomic_read(&lock->val) &&
-	   (atomic_cmpxchg_acquire(&lock->val, 0, _Q_LOCKED_VAL) == 0))
+	    (atomic_try_cmpxchg(&lock->val, &val, _Q_LOCKED_VAL)))
 		return 1;
 	return 0;
 }
@@ -82,10 +84,9 @@ extern void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
  */
 static __always_inline void queued_spin_lock(struct qspinlock *lock)
 {
-	u32 val;
+	u32 val = 0;
 
-	val = atomic_cmpxchg_acquire(&lock->val, 0, _Q_LOCKED_VAL);
-	if (likely(val == 0))
+	if (likely(atomic_try_cmpxchg(&lock->val, &val, _Q_LOCKED_VAL)))
 		return;
 	queued_spin_lock_slowpath(lock, val);
 }
-- 
2.18.0

