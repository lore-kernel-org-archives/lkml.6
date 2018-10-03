Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC91C64EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C385A2089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 13:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Co4aRI5e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C385A2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbeJCUCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 16:02:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36440 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbeJCUBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 16:01:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Q2Sc6aaA7TCELZm9kJnGTjWB4ZtntpX64apnEsbw1u4=; b=Co4aRI5eogLI/FnRfe68IyU8gy
        NryUqbqiFb0bwxjaKyyUegrV/GIwKWpkrgkcCcuqym6SUFzWNxSEK7cQZw1ocdf7CWxaYVhHJa34V
        GB5fiTE+cms47zSQmBmWtLQgbMkrbWV3EmObhipUW5ZF9tq2MPXPoBDXII+C79UK9JS1PEYNDGxCX
        m8ZB+OS1fKcrnmFZISKt0ItDjgbhT9ao9H6IpUQYMC4xiMxsxDtx70aMrQo5NvgQ4bHm7AymQ0HiD
        AQonfhRz+AQfSXo/UH5AKLd71IHy+d5yih5JNoHSHw2qxh0m7zv3D7iMJW57l7z48Q9+AUzyNledY
        sbw5+AYQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g7gxu-0003Ar-IE; Wed, 03 Oct 2018 13:13:23 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1A8742025A339; Wed,  3 Oct 2018 15:13:15 +0200 (CEST)
Message-ID: <20181003130957.031086404@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 03 Oct 2018 15:02:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     will.deacon@arm.com, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, longman@redhat.com,
        andrea.parri@amarulasolutions.com, tglx@linutronix.de,
        bigeasy@linutronix.de, Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 2/4] locking/qspinlock: Rework some comments
References: <20181003130257.156322446@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While working my way through the code again; I felt the comments could
use help.

Cc: mingo@kernel.org
Cc: will.deacon@arm.com
Cc: tglx@linutronix.de
Cc: longman@redhat.com
Cc: andrea.parri@amarulasolutions.com
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/locking/qspinlock.c |   38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

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
+	 * If we observe contention, there is a concurrent locker.
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


