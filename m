Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C540FC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98C50205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:04:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98C50205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbeJPXz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 19:55:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58363 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbeJPXzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 19:55:55 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9GG4Qlr4158628
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 16 Oct 2018 09:04:26 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9GG4PQZ4158625;
        Tue, 16 Oct 2018 09:04:25 -0700
Date:   Tue, 16 Oct 2018 09:04:25 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-53bf57fab7321fb42b703056a4c80fc9d986d170@git.kernel.org>
Cc:     mingo@kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org, hpa@zytor.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, will.deacon@arm.com
Reply-To: linux-kernel@vger.kernel.org, will.deacon@arm.com,
          tglx@linutronix.de, mingo@kernel.org, peterz@infradead.org,
          hpa@zytor.com, torvalds@linux-foundation.org
In-Reply-To: <20181003130257.156322446@infradead.org>
References: <20181003130257.156322446@infradead.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/qspinlock: Re-order code
Git-Commit-ID: 53bf57fab7321fb42b703056a4c80fc9d986d170
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

Commit-ID:  53bf57fab7321fb42b703056a4c80fc9d986d170
Gitweb:     https://git.kernel.org/tip/53bf57fab7321fb42b703056a4c80fc9d986d170
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Wed, 26 Sep 2018 13:01:18 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 16 Oct 2018 17:33:53 +0200

locking/qspinlock: Re-order code

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
---
 kernel/locking/qspinlock.c | 56 ++++++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 29 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index bfaeb05123ff..ec343276f975 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -330,39 +330,37 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
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
