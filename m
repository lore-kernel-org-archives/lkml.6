Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73411C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D94E20989
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298809;
	bh=4wBFu3iuro4VsXgYa69Np6MyHACuQzW9CMlxNlzNMV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DDSA4h4vjCG+mnaLsC5vrEFj4uBM4kcFzkrLy8UJjG0JIm6F6WHFWf0AwRxLG2zHw
	 OT21y5DACs3Zhuq6CzAFUndPKFri9aP+DAW8qVaPmoUpKVqN1BK6bxDXL0F0dWgNVw
	 3OZSaiOtTj5BRl15UrHHdP8ofDHs9LPLDniHnPcQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387401AbeLTJkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:40:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:40492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730182AbeLTJY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:24:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30DA221852;
        Thu, 20 Dec 2018 09:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297898;
        bh=4wBFu3iuro4VsXgYa69Np6MyHACuQzW9CMlxNlzNMV0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fXlZ5dvGu5Nb3+nbWpPqPc0fnOoo2bbmflpSvTOfFbwMF/rZWIkwr65NOm3HI/nBs
         eiD2+TCw60M194zySSPWUB977PBWTTRDObMRhJQqGm8FHiJaLTrSs8wyAo4La5EGFB
         6X1UMdc7Zyo5TvPfMvALuG40hSnl0yhabwj5e1yU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 21/61] locking/qspinlock: Ensure node is initialised before updating prev->next
Date:   Thu, 20 Dec 2018 10:18:21 +0100
Message-Id: <20181220085844.590865428@linuxfoundation.org>
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

commit 95bcade33a8af38755c9b0636e36a36ad3789fe6 upstream.

When a locker ends up queuing on the qspinlock locking slowpath, we
initialise the relevant mcs node and publish it indirectly by updating
the tail portion of the lock word using xchg_tail. If we find that there
was a pre-existing locker in the queue, we subsequently update their
->next field to point at our node so that we are notified when it's our
turn to take the lock.

This can be roughly illustrated as follows:

  /* Initialise the fields in node and encode a pointer to node in tail */
  tail = initialise_node(node);

  /*
   * Exchange tail into the lockword using an atomic read-modify-write
   * operation with release semantics
   */
  old = xchg_tail(lock, tail);

  /* If there was a pre-existing waiter ... */
  if (old & _Q_TAIL_MASK) {
	prev = decode_tail(old);
	smp_read_barrier_depends();

	/* ... then update their ->next field to point to node.
	WRITE_ONCE(prev->next, node);
  }

The conditional update of prev->next therefore relies on the address
dependency from the result of xchg_tail ensuring order against the
prior initialisation of node. However, since the release semantics of
the xchg_tail operation apply only to the write portion of the RmW,
then this ordering is not guaranteed and it is possible for the CPU
to return old before the writes to node have been published, consequently
allowing us to point prev->next to an uninitialised node.

This patch fixes the problem by making the update of prev->next a RELEASE
operation, which also removes the reliance on dependency ordering.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1518528177-19169-2-git-send-email-will.deacon@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/locking/qspinlock.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 8710fbe8d26c..6fce84401dba 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -532,14 +532,15 @@ queue:
 	 */
 	if (old & _Q_TAIL_MASK) {
 		prev = decode_tail(old);
+
 		/*
-		 * The above xchg_tail() is also a load of @lock which
-		 * generates, through decode_tail(), a pointer.  The address
-		 * dependency matches the RELEASE of xchg_tail() such that
-		 * the subsequent access to @prev happens after.
+		 * We must ensure that the stores to @node are observed before
+		 * the write to prev->next. The address dependency from
+		 * xchg_tail is not sufficient to ensure this because the read
+		 * component of xchg_tail is unordered with respect to the
+		 * initialisation of @node.
 		 */
-
-		WRITE_ONCE(prev->next, node);
+		smp_store_release(&prev->next, node);
 
 		pv_wait_node(node, prev);
 		arch_mcs_spin_lock_contended(&node->locked);
-- 
2.19.1



