Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C27BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39B8B218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545297907;
	bh=KJTvWwurMytiRrfbh9OFBxmiTAVX8krWqZn9bCGQhzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qyRa7ZRdASnvMf0NWyZsxlSR+zKC6ouEJjS+yRE1hHHAxEzNzE/7mWJ+Y9rupnDI3
	 n/mpa/3ObPAGt+VLzCmDDIU99K0RuXX8d7PHILEA6x0tjh+LxIcUv4+YTtTpTm99ES
	 TAtMGMPhDNM/LIvL81dkxORYK2DTdu5Uqq5sJBb0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731919AbeLTJZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:25:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:40954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730837AbeLTJZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:25:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDE91217D7;
        Thu, 20 Dec 2018 09:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297901;
        bh=KJTvWwurMytiRrfbh9OFBxmiTAVX8krWqZn9bCGQhzY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yo6m7vb1KSP3OBpqO7O/hQIVLZZap1xr9zYMki9+v6OEuMMhhRkOpUEAcXS8L2ibe
         ZQ4vchJTv3y+jA4Jf1bUiyX0Vhp4qekFtZ8LginJEiLBnLzKIZUrt4ez+3RoU5CO3k
         pcIC4c5NuSw/5ddEVdFGELP28r/1DCiQRgDaqraY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Waiman Long <longman@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, boqun.feng@gmail.com,
        linux-arm-kernel@lists.infradead.org, paulmck@linux.vnet.ibm.com,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 22/61] locking/qspinlock: Bound spinning on pending->locked transition in slowpath
Date:   Thu, 20 Dec 2018 10:18:22 +0100
Message-Id: <20181220085844.630619490@linuxfoundation.org>
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

commit 6512276d97b160d90b53285bd06f7f201459a7e3 upstream.

If a locker taking the qspinlock slowpath reads a lock value indicating
that only the pending bit is set, then it will spin whilst the
concurrent pending->locked transition takes effect.

Unfortunately, there is no guarantee that such a transition will ever be
observed since concurrent lockers could continuously set pending and
hand over the lock amongst themselves, leading to starvation. Whilst
this would probably resolve in practice, it means that it is not
possible to prove liveness properties about the lock and means that lock
acquisition time is unbounded.

Rather than removing the pending->locked spinning from the slowpath
altogether (which has been shown to heavily penalise a 2-threaded
locking stress test on x86), this patch replaces the explicit spinning
with a call to atomic_cond_read_relaxed and allows the architecture to
provide a bound on the number of spins. For architectures that can
respond to changes in cacheline state in their smp_cond_load implementation,
it should be sufficient to use the default bound of 1.

Suggested-by: Waiman Long <longman@redhat.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Waiman Long <longman@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: boqun.feng@gmail.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: paulmck@linux.vnet.ibm.com
Link: http://lkml.kernel.org/r/1524738868-31318-4-git-send-email-will.deacon@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/locking/qspinlock.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 6fce84401dba..a8da1fc5222e 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -75,6 +75,18 @@
 #define MAX_NODES	4
 #endif
 
+/*
+ * The pending bit spinning loop count.
+ * This heuristic is used to limit the number of lockword accesses
+ * made by atomic_cond_read_relaxed when waiting for the lock to
+ * transition out of the "== _Q_PENDING_VAL" state. We don't spin
+ * indefinitely because there's no guarantee that we'll make forward
+ * progress.
+ */
+#ifndef _Q_PENDING_LOOPS
+#define _Q_PENDING_LOOPS	1
+#endif
+
 /*
  * Per-CPU queue node structures; we can never have more than 4 nested
  * contexts: task, softirq, hardirq, nmi.
@@ -422,13 +434,15 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 		return;
 
 	/*
-	 * wait for in-progress pending->locked hand-overs
+	 * Wait for in-progress pending->locked hand-overs with a bounded
+	 * number of spins so that we guarantee forward progress.
 	 *
 	 * 0,1,0 -> 0,0,1
 	 */
 	if (val == _Q_PENDING_VAL) {
-		while ((val = atomic_read(&lock->val)) == _Q_PENDING_VAL)
-			cpu_relax();
+		int cnt = _Q_PENDING_LOOPS;
+		val = smp_cond_load_acquire(&lock->val.counter,
+					       (VAL != _Q_PENDING_VAL) || !cnt--);
 	}
 
 	/*
-- 
2.19.1



