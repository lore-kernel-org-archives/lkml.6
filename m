Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CA6ECE560
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B58B6214DD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nJqhSSBm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B58B6214DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbeIZRme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 13:42:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45660 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbeIZRme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 13:42:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=T6e8Om/B3WpLPyGrb5BiF+h/jYkzaZA2yvRe3mCw3rQ=; b=nJqhSSBmnX1BYOubbi93PqgutE
        KV2rV5PtAzgrJK36Z7O7sZaeIA8MGQ8mSw+Hjk/yFk/f/VIHGkvXoZwlWowoQeOe/BCDGUUE50FI7
        1KMWM9bY4HzPlZ+1qrBKm8wm7IrZUPUP6ZzErU70qabcPl+yYmb4Q275iqn7Ve3AHmfjK+h7VvOYE
        GGVwh2e0YSzI/YPCQkDA7H92uEMDSVOVQ6ak3eixyghzZix3O6WNHY3kVj//EKAkSSUj0oFlETDcW
        fsGNvNK7be2spY28irdfrP3yo5gYP73yKPUhxLHX2HZhkLMsl2b3GQDYz6s8XfHBvAic4GmxiZuAr
        P9MDxuJA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g580X-00055e-KO; Wed, 26 Sep 2018 11:29:49 +0000
Received: by worktop (Postfix, from userid 0)
        id BD9AC6E0AA0; Wed, 26 Sep 2018 13:29:27 +0200 (CEST)
Message-Id: <20180926111307.401531130@infradead.org>
User-Agent: quilt/0.61-1
Date:   Wed, 26 Sep 2018 13:01:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     will.deacon@arm.com, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, longman@redhat.com,
        andrea.parri@amarulasolutions.com, tglx@linutronix.de,
        Peter Zijlstra <peterz@infradead.org>
Subject: [RFC][PATCH 1/3] locking/qspinlock: Re-order code
References: <20180926110117.405325143@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-qspinlock-opt-2.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Flip the branch condition after atomic_fetch_or_acquire(_Q_PENDING_VAL)
such that we loose the indent. This also result in a more natural code
flow IMO.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/locking/qspinlock.c |   56 +++++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 29 deletions(-)

--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -330,39 +330,37 @@ void queued_spin_lock_slowpath(struct qs
 	 * 0,0,1 -> 0,1,1 ; pending
 	 */
 	val = atomic_fetch_or_acquire(_Q_PENDING_VAL, &lock->val);
-	if (!(val & ~_Q_LOCKED_MASK)) {
-		/*
-		 * We're pending, wait for the owner to go away.
-		 *
-		 * *,1,1 -> *,1,0
-		 *
-		 * this wait loop must be a load-acquire such that we match the
-		 * store-release that clears the locked bit and create lock
-		 * sequentiality; this is because not all
-		 * clear_pending_set_locked() implementations imply full
-		 * barriers.
-		 */
-		if (val & _Q_LOCKED_MASK) {
-			atomic_cond_read_acquire(&lock->val,
-						 !(VAL & _Q_LOCKED_MASK));
-		}
-
-		/*
-		 * take ownership and clear the pending bit.
-		 *
-		 * *,1,0 -> *,0,1
-		 */
-		clear_pending_set_locked(lock);
-		qstat_inc(qstat_lock_pending, true);
-		return;
+	/*
+	 * If we observe any contention; undo and queue.
+	 */
+	if (unlikely(val & ~_Q_LOCKED_MASK)) {
+		if (!(val & _Q_PENDING_MASK))
+			clear_pending(lock);
+		goto queue;
 	}
 
 	/*
-	 * If pending was clear but there are waiters in the queue, then
-	 * we need to undo our setting of pending before we queue ourselves.
+	 * We're pending, wait for the owner to go away.
+	 *
+	 * 0,1,1 -> 0,1,0
+	 *
+	 * this wait loop must be a load-acquire such that we match the
+	 * store-release that clears the locked bit and create lock
+	 * sequentiality; this is because not all
+	 * clear_pending_set_locked() implementations imply full
+	 * barriers.
+	 */
+	if (val & _Q_LOCKED_MASK)
+		atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_MASK));
+
+	/*
+	 * take ownership and clear the pending bit.
+	 *
+	 * 0,1,0 -> 0,0,1
 	 */
-	if (!(val & _Q_PENDING_MASK))
-		clear_pending(lock);
+	clear_pending_set_locked(lock);
+	qstat_inc(qstat_lock_pending, true);
+	return;
 
 	/*
 	 * End of pending bit optimistic spinning and beginning of MCS


