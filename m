Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0BDC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3617620675
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298933;
	bh=QfACRMOmEdnfOACigeihy5dfwEWiyhsa9IcRjQQxRJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d77NLWVVZmwUQnml1r0OdT4/yTHFGqt0RCS8Fb/xYmRU87E7JAvAuPtttRtSzMVnj
	 e4g34ZpqsDr285fJZtDH+APYI++hlbMnw57TdoeuYw+ypLKd+g2KZCIBeaiH/2F5bn
	 qTtCVH5EpDnHX/p3VRWt3LoRUmO4I9KSMjG6DlTM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731642AbeLTJXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:23:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:54952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731616AbeLTJXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:23:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45610217D7;
        Thu, 20 Dec 2018 09:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297814;
        bh=QfACRMOmEdnfOACigeihy5dfwEWiyhsa9IcRjQQxRJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dx0EQbor00PDjidY9hNM1vlXs1Gpk8zDmYwRKHNlTKvqbWOLbF0odglCdQQ95IxBI
         GLzIgc1idRvXqqR+Lj4oga6EDn6RYEA+NbpmyHBEANmZNrcUl8Ugq/Nm8tnW7yzErD
         6cGpdW5CxUgZ8efaHlvbFNpESY/QEOabTRBj5RWs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        andrea.parri@amarulasolutions.com, longman@redhat.com,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 27/61] locking/qspinlock: Re-order code
Date:   Thu, 20 Dec 2018 10:18:27 +0100
Message-Id: <20181220085844.822874542@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085843.743900603@linuxfoundation.org>
References: <20181220085843.743900603@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

commit 53bf57fab7321fb42b703056a4c80fc9d986d170 upstream.

Flip the branch condition after atomic_fetch_or_acquire(_Q_PENDING_VAL)
such that we loose the indent. This also result in a more natural code
flow IMO.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: andrea.parri@amarulasolutions.com
Cc: longman@redhat.com
Link: https://lkml.kernel.org/r/20181003130257.156322446@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/locking/qspinlock.c | 54 ++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index ba5dc86a4d83..f493a4fce624 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -440,38 +440,36 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
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
-			smp_cond_load_acquire(&lock->val.counter,
-					      !(VAL & _Q_LOCKED_MASK));
-		}
-
-		/*
-		 * take ownership and clear the pending bit.
-		 *
-		 * *,1,0 -> *,0,1
-		 */
-		clear_pending_set_locked(lock);
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
+		smp_cond_load_acquire(&lock->val.counter, !(VAL & _Q_LOCKED_MASK));
+
+	/*
+	 * take ownership and clear the pending bit.
+	 *
+	 * 0,1,0 -> 0,0,1
 	 */
-	if (!(val & _Q_PENDING_MASK))
-		clear_pending(lock);
+	clear_pending_set_locked(lock);
+	return;
 
 	/*
 	 * End of pending bit optimistic spinning and beginning of MCS
-- 
2.19.1



