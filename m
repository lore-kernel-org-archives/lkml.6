Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69A9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B176B218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545297816;
	bh=nsZCC066HsfUR6heUfkJZaSGv2Vx60T0A5qY5oweNzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=keN+LIwO86K+tXqdfXOCTzJ/sx4GJwCsmvvxJ5MNTdiRd/9vCUroQmh08zunHVV3C
	 7nQGEXKoW+fBNAVB/jn7iswIq5W+j34T91QgsNrlTqXQQfGOeJqgNehC5ndmbkRK3/
	 SFipEg8YfzNm+0Oa5dxlcgSBV4dag0I88LWXGSTY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731622AbeLTJXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:23:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:54474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731601AbeLTJXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:23:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F35F20656;
        Thu, 20 Dec 2018 09:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297812;
        bh=nsZCC066HsfUR6heUfkJZaSGv2Vx60T0A5qY5oweNzQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UJYOpMOUNEhd3NyncOMzFm5HKsmli+e4UXdcYYsqUsxO9wQgkuJoz+UJaPZvqjxUd
         WXct4uUA1vvlEF/nyjrh80jSh0VK8q/ttOyJ6WTkyDN8umhcnGS0RPPRGGM/GOpAjJ
         8RUbdEJhbyrZCUQ1fT2oRg+yvfYHXOg7yN+5aOyk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, boqun.feng@gmail.com,
        linux-arm-kernel@lists.infradead.org, paulmck@linux.vnet.ibm.com,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 26/61] locking/qspinlock: Kill cmpxchg() loop when claiming lock from head of queue
Date:   Thu, 20 Dec 2018 10:18:26 +0100
Message-Id: <20181220085844.783297892@linuxfoundation.org>
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

commit c61da58d8a9ba9238250a548f00826eaf44af0f7 upstream.

When a queued locker reaches the head of the queue, it claims the lock
by setting _Q_LOCKED_VAL in the lockword. If there isn't contention, it
must also clear the tail as part of this operation so that subsequent
lockers can avoid taking the slowpath altogether.

Currently this is expressed as a cmpxchg() loop that practically only
runs up to two iterations. This is confusing to the reader and unhelpful
to the compiler. Rewrite the cmpxchg() loop without the loop, so that a
failed cmpxchg() implies that there is contention and we just need to
write to _Q_LOCKED_VAL without considering the rest of the lockword.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Waiman Long <longman@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: boqun.feng@gmail.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: paulmck@linux.vnet.ibm.com
Link: http://lkml.kernel.org/r/1524738868-31318-7-git-send-email-will.deacon@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/locking/qspinlock.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index e7ab99a1f438..ba5dc86a4d83 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -581,24 +581,21 @@ locked:
 	 * and nobody is pending, clear the tail code and grab the lock.
 	 * Otherwise, we only need to grab the lock.
 	 */
-	for (;;) {
-		/* In the PV case we might already have _Q_LOCKED_VAL set */
-		if ((val & _Q_TAIL_MASK) != tail || (val & _Q_PENDING_MASK)) {
-			set_locked(lock);
-			break;
-		}
+
+	/* In the PV case we might already have _Q_LOCKED_VAL set */
+	if ((val & _Q_TAIL_MASK) == tail) {
 		/*
 		 * The smp_cond_load_acquire() call above has provided the
-		 * necessary acquire semantics required for locking. At most
-		 * two iterations of this loop may be ran.
+		 * necessary acquire semantics required for locking.
 		 */
 		old = atomic_cmpxchg_relaxed(&lock->val, val, _Q_LOCKED_VAL);
 		if (old == val)
-			goto release;	/* No contention */
-
-		val = old;
+			goto release; /* No contention */
 	}
 
+	/* Either somebody is queued behind us or _Q_PENDING_VAL is set */
+	set_locked(lock);
+
 	/*
 	 * contended path; wait for next if not observed yet, release.
 	 */
-- 
2.19.1



