Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17168C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0AF3214C5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rlhsC7ef"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0AF3214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbeIZRmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 13:42:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45656 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbeIZRma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 13:42:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ecn3DlDg9hb760OCK0+63k27z9Yb7CyA+vfOt6Ec+dc=; b=rlhsC7efMCve/X+KTJ3yv36XSc
        ULr306G5HtVfIuEEclhIH0p+elo2MP4eT6FYDntq0IeCSm9cDbTFQ+f0s5mjAZxG8czKs+a5CIunO
        UyEGK1uFI5deragAKIj1IOU7fZnfEWOGH6Sn8qQjr/Xrfni/HbdfVJWQPRPv68b+3oFhny9O9kaqA
        PcW/imkbA8hFBusyvJuvtxykI6U7SJtjvAKSgv54VZAJQH3gnUmkw7erwlkbJCRlG0yX73RFF7DFp
        vT7KF+3tUQhyfMx2eCzif84TNTx6kSPrk5bY2XqZID6m3IrC9abNA7//UQGP+vyFkxBBgPpkCDCId
        GVZst4fQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g580X-00055d-Kg; Wed, 26 Sep 2018 11:29:49 +0000
Received: by worktop (Postfix, from userid 0)
        id BB5B06E05EA; Wed, 26 Sep 2018 13:29:27 +0200 (CEST)
Message-Id: <20180926111307.457488877@infradead.org>
User-Agent: quilt/0.61-1
Date:   Wed, 26 Sep 2018 13:01:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     will.deacon@arm.com, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, longman@redhat.com,
        andrea.parri@amarulasolutions.com, tglx@linutronix.de,
        Peter Zijlstra <peterz@infradead.org>
Subject: [RFC][PATCH 2/3] locking/qspinlock: Rework some comments
References: <20180926110117.405325143@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-qspinlock-opt-1.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While working my way through the code again; I felt the comments could
use help.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/locking/qspinlock.c |   40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -326,16 +326,23 @@ void queued_spin_lock_slowpath(struct qs
 	/*
 	 * trylock || pending
 	 *
-	 * 0,0,0 -> 0,0,1 ; trylock
-	 * 0,0,1 -> 0,1,1 ; pending
+	 * 0,0,* -> 0,1,* -> 0,0,1 pending, trylock
 	 */
 	val = atomic_fetch_or_acquire(_Q_PENDING_VAL, &lock->val);
+
 	/*
-	 * If we observe any contention; undo and queue.
+	 * If we observe contention, there was a concurrent lock.
+	 *
+	 * Undo and queue; our setting of PENDING might have made the
+	 * n,0,0 -> 0,0,0 transition fail and it will now be waiting
+	 * on @next to become !NULL.
 	 */
 	if (unlikely(val & ~_Q_LOCKED_MASK)) {
+
+		/* Undo PENDING if we set it. */
 		if (!(val & _Q_PENDING_MASK))
 			clear_pending(lock);
+
 		goto queue;
 	}
 
@@ -466,7 +473,7 @@ void queued_spin_lock_slowpath(struct qs
 	 * claim the lock:
 	 *
 	 * n,0,0 -> 0,0,1 : lock, uncontended
-	 * *,*,0 -> *,*,1 : lock, contended
+	 * *,0,0 -> *,0,1 : lock, contended
 	 *
 	 * If the queue head is the only one in the queue (lock value == tail)
 	 * and nobody is pending, clear the tail code and grab the lock.
@@ -474,16 +481,25 @@ void queued_spin_lock_slowpath(struct qs
 	 */
 
 	/*
-	 * In the PV case we might already have _Q_LOCKED_VAL set.
+	 * In the PV case we might already have _Q_LOCKED_VAL set, because
+	 * of lock stealing; therefore we must also allow:
 	 *
-	 * The atomic_cond_read_acquire() call above has provided the
-	 * necessary acquire semantics required for locking.
-	 */
-	if (((val & _Q_TAIL_MASK) == tail) &&
-	    atomic_try_cmpxchg_relaxed(&lock->val, &val, _Q_LOCKED_VAL))
-		goto release; /* No contention */
+	 * n,0,1 -> 0,0,1
+	 *
+	 * Note: at this point: (val & _Q_PENDING_MASK) == 0, because of the
+	 *       above wait condition, therefore any concurrent setting of
+	 *       PENDING will make the uncontended transition fail.
+	 */
+	if ((val & _Q_TAIL_MASK) == tail) {
+		if (atomic_try_cmpxchg_relaxed(&lock->val, &val, _Q_LOCKED_VAL))
+			goto release; /* No contention */
+	}
 
-	/* Either somebody is queued behind us or _Q_PENDING_VAL is set */
+	/*
+	 * Either somebody is queued behind us or _Q_PENDING_VAL got set
+	 * which will then detect the remaining tail and queue behind us
+	 * ensuring we'll see a @next.
+	 */
 	set_locked(lock);
 
 	/*


