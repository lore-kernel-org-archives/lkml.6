Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A27EC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DCA9218E0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549991701;
	bh=2k/PHe0sRFupc18IxW/qX+jTa9cOEu6GhbvXkM+zjG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S4E6AKyVQ08cgdo6uGg4pxFd9jRBasqDJZnrFSeawqA4GWf6tmZ5wXzBXtVSnPG6e
	 Wj/M2R8mbovViOQusxKYZtnHFDPaiVY8Iw4pUQiaSYuA3pGSOxsHhyIWkiJs1fbNKG
	 ca19tr0ZeYktT0tyf9HOpbee2TUoenDnQ/ZZJYIQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731442AbfBLRO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:14:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:57412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731425AbfBLRO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:14:56 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 595FF218B0;
        Tue, 12 Feb 2019 17:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549991696;
        bh=2k/PHe0sRFupc18IxW/qX+jTa9cOEu6GhbvXkM+zjG4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N9PGXfKnlzm9z9Gqyqd8vi5w6M5c1zS1wWeW2+Zznbj3NjM9D09lrCJdedLlawzmF
         YD5SY0K7UV3y9bUxRlKycHdIGi2HWv0o4J05+imqLIK3jaILwTyj47I3/MoS3Ek81T
         yyV2Q7Vh0o2TDNQmuhN/Z6DNWS1Owx23XbdzPrU0=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 08/32] locking/lockdep: Make mark_lock() fastpath to work with multiple usage at once
Date:   Tue, 12 Feb 2019 18:13:59 +0100
Message-Id: <20190212171423.8308-9-frederic@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212171423.8308-1-frederic@kernel.org>
References: <20190212171423.8308-1-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that mark_lock() is going to handle multiple softirq vectors at
once for a given lock usage, the current fast path optimization that
simply check if the new bit usage is already present won't work anymore.

Indeed if the new usage is only partially present, such as for some
softirq vectors and not for others, we may spuriously ignore all the
verifications for the new vectors.

What we must check instead is a bit different: we have to make sure that
the new usage with all its vectors are entirely present in the current
usage mask before ignoring further checks.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Pavan Kondeti <pkondeti@codeaurora.org>
Cc: Paul E . McKenney <paulmck@linux.vnet.ibm.com>
Cc: David S . Miller <davem@davemloft.net>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/locking/lockdep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index baba291f2cab..9194f11d3dfb 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3157,7 +3157,7 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 	 * If already set then do not dirty the cacheline,
 	 * nor do any checks:
 	 */
-	if (likely(hlock_class(this)->usage_mask & new_mask))
+	if (likely(!(new_mask & ~hlock_class(this)->usage_mask)))
 		return 1;
 
 	if (!graph_lock())
@@ -3165,7 +3165,7 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 	/*
 	 * Make sure we didn't race:
 	 */
-	if (unlikely(hlock_class(this)->usage_mask & new_mask)) {
+	if (unlikely(!(new_mask & ~hlock_class(this)->usage_mask))) {
 		graph_unlock();
 		return 1;
 	}
-- 
2.17.1

