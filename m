Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C31C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 955FA217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545297903;
	bh=yyXULGRlhTzJdhKLPigTEyhtgXt3q9ggu2+5lriaqPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zz470icCYnY2w2kTKJ+HwrF3CbeyMR32a3SSGgWpvYX312JHM8lWBWzpg9JxKe/NY
	 1IjFONG9nON8oqepS6rUI76g8wKpAmPSWcvNYIFBAotnq4PfpbBGrNB/UIvrJS+PEj
	 xNYcQT7y5sj55K097WoXKPEBstKeHC8PqVSiIgyo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731906AbeLTJZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:25:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:40066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730752AbeLTJY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:24:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EA8120656;
        Thu, 20 Dec 2018 09:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297896;
        bh=yyXULGRlhTzJdhKLPigTEyhtgXt3q9ggu2+5lriaqPM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0a7DYIRjzt5E6PjNwiqmLQiqVxoSHEEk8l4uYUrSs5E2o+ufX8tLJ5yXAlbzOuB2n
         froK+l1cSn3y3SOb9OBEZeFmswb79rzI6G7+8hpjgawY/9xDe46N2zPgDb/nF7eqkC
         rGOWE8FzHFyeNeSdvxJujlajJTYagntfyIdryBP0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 20/61] locking: Remove smp_read_barrier_depends() from queued_spin_lock_slowpath()
Date:   Thu, 20 Dec 2018 10:18:20 +0100
Message-Id: <20181220085844.551067341@linuxfoundation.org>
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

commit 548095dea63ffc016d39c35b32c628d033638aca upstream.

Queued spinlocks are not used by DEC Alpha, and furthermore operations
such as READ_ONCE() and release/relaxed RMW atomics are being changed
to imply smp_read_barrier_depends().  This commit therefore removes the
now-redundant smp_read_barrier_depends() from queued_spin_lock_slowpath(),
and adjusts the comments accordingly.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/locking/qspinlock.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index a72f5df643f8..8710fbe8d26c 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -169,7 +169,7 @@ static __always_inline void clear_pending_set_locked(struct qspinlock *lock)
  * @tail : The new queue tail code word
  * Return: The previous queue tail code word
  *
- * xchg(lock, tail)
+ * xchg(lock, tail), which heads an address dependency
  *
  * p,*,* -> n,*,* ; prev = xchg(lock, node)
  */
@@ -533,13 +533,11 @@ queue:
 	if (old & _Q_TAIL_MASK) {
 		prev = decode_tail(old);
 		/*
-		 * The above xchg_tail() is also a load of @lock which generates,
-		 * through decode_tail(), a pointer.
-		 *
-		 * The address dependency matches the RELEASE of xchg_tail()
-		 * such that the access to @prev must happen after.
+		 * The above xchg_tail() is also a load of @lock which
+		 * generates, through decode_tail(), a pointer.  The address
+		 * dependency matches the RELEASE of xchg_tail() such that
+		 * the subsequent access to @prev happens after.
 		 */
-		smp_read_barrier_depends();
 
 		WRITE_ONCE(prev->next, node);
 
-- 
2.19.1



