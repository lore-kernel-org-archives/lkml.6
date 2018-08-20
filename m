Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4866FC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1649208AC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uEZRE/To"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1649208AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbeHTTm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 15:42:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45662 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbeHTTm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 15:42:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=k0YEL81+3/1PoaiU/oE2xrep49yl6Z5ZGNHbwbc2FyY=; b=uEZRE/TokLKXTH0m9QIizOyoX
        GM+bLMdIMFUOz7woAoJGJ4yxVBQnEp8xxar/pEoci2/b2nBd7iZ29pGZD7TyPkWniZ4MV2eXTf8l7
        xNRdtzjWBDkdPsmwglguVbqn9igxDvCPOZKaN6f8Tn/s2G4sDlUo7CW+UhBdEufcAE05BZ79Wntog
        6oNCyKIAoRYIUYGLGNJcgld49WziB6bvblEIVwTPrSW4KSpw9vRemBknjCp+tomYVP8u9eHFYRTum
        51aObklnfjzLiN5EghyTzfw85ZO4CcL8rAGbyCDPj8x/EB3Ps1uOi7RM/PkDFiio0pXdsRqhlKkQx
        KaR6TBylw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1frn0p-0006QN-75; Mon, 20 Aug 2018 16:26:39 +0000
Date:   Mon, 20 Aug 2018 09:26:39 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Waiman Long <longman@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] locking: Remove an insn from spin and write locks
Message-ID: <20180820162639.GC25153@bombadil.infradead.org>
References: <20180820150652.29482-1-willy@infradead.org>
 <f24a32be-6a4f-0df8-4289-14adc1046f50@redhat.com>
 <20180820155002.GB25153@bombadil.infradead.org>
 <20180820155650.GG24082@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180820155650.GG24082@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 05:56:50PM +0200, Peter Zijlstra wrote:
> Yeah, _acquire should be retained; sorry about loosing that. I'm neck
> deep into tlb invalidate stuff and wrote this without much thinking
> involved.

NP.  Here's the current version I've got, with some updated likely()
hints.

From 337298a88266f7b21492f893c2bf05409a5392c8 Mon Sep 17 00:00:00 2001
From: Matthew Wilcox <willy@infradead.org>
Date: Mon, 20 Aug 2018 10:19:14 -0400
Subject: [PATCH] locking: Remove an insn from spin and write locks

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
---
 include/asm-generic/qrwlock.h   |  7 ++++---
 include/asm-generic/qspinlock.h | 17 ++++++++++-------
 2 files changed, 14 insertions(+), 10 deletions(-)

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
index 95263e943fcc..24e7915eee56 100644
--- a/include/asm-generic/qspinlock.h
+++ b/include/asm-generic/qspinlock.h
@@ -68,10 +68,14 @@ int queued_spin_is_contended(const struct qspinlock *lock)
  */
 static __always_inline int queued_spin_trylock(struct qspinlock *lock)
 {
-	if (!atomic_read(&lock->val) &&
-	   (atomic_cmpxchg_acquire(&lock->val, 0, _Q_LOCKED_VAL) == 0))
-		return 1;
-	return 0;
+	u32 val;
+
+	val = atomic_read(&lock->val);
+	if (unlikely(val))
+		return 0;
+
+	return likely(atomic_try_cmpxchg_acquire(&lock->val, &val,
+				_Q_LOCKED_VAL));
 }
 
 extern void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
@@ -82,10 +86,9 @@ extern void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
  */
 static __always_inline void queued_spin_lock(struct qspinlock *lock)
 {
-	u32 val;
+	u32 val = 0;
 
-	val = atomic_cmpxchg_acquire(&lock->val, 0, _Q_LOCKED_VAL);
-	if (likely(val == 0))
+	if (likely(atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LOCKED_VAL)))
 		return;
 	queued_spin_lock_slowpath(lock, val);
 }
-- 
2.18.0

