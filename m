Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7DDC282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA343218E0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549991690;
	bh=/x/1sz2wxImFM5bKOuDzYPoZZ75Qq6dvHF5a0d3G03A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aSzEU1mfhYwzMQD0vjKj/Gy+Ju18r69VLEvVSJFsG0Uz3n71GdcsTIMT2V1zdCtvr
	 DxJhK4o3JPfwhilQHryeGPyoayQ4zD1+/bB1VLpYNMIh4vEj7IoU2D3dUCdzNMP1PK
	 JpBQARwpTgvqcxvWMQYeNQqedEhkhKeEObr/4zgk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731401AbfBLROt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:14:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:57204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731386AbfBLROr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:14:47 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6AD62186A;
        Tue, 12 Feb 2019 17:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549991686;
        bh=/x/1sz2wxImFM5bKOuDzYPoZZ75Qq6dvHF5a0d3G03A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Olh1m1j5eTEjOdRHy1ficjOAiVLcl5CzixTDTRL5oTH8v4rgVwl3pQnSZ4gmyZarO
         td7aAfiKyKzOF86kCL4OUpB5F+IiXoHIep0+aiGvtI1AhB/6sVjiImmx4AvdCqL1e9
         Di6roNJXaL1vkG1sJ96cnazSHz6it+8YUlPfzeCk=
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
Subject: [PATCH 05/32] locking/lockdep: Prepare valid_state() to handle plain masks
Date:   Tue, 12 Feb 2019 18:13:56 +0100
Message-Id: <20190212171423.8308-6-frederic@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212171423.8308-1-frederic@kernel.org>
References: <20190212171423.8308-1-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mark_lock_irq() is going to deal with lock usages that gather multiple
softirq vectors at once. Therefore the validation through valid_state()
will need to handle expanded usage masks.

So enhance valid_state() to that purpose.

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
 kernel/locking/lockdep.c | 44 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 578dd57f70d3..6b625b70598a 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2538,7 +2538,26 @@ print_usage_bug(struct task_struct *curr, struct held_lock *this,
 
 static u64 lock_usage_mask(struct lock_usage *usage)
 {
-	return BIT(usage->bit);
+	int nr = 0;
+	u64 vectors = usage->vector;
+	u64 mask = 0ULL;
+
+	if (!vectors)
+		return lock_flag(usage->bit);
+
+	/* Only softirqs can have non-zero vectors */
+	WARN_ON_ONCE(usage->bit < LOCK_USED_IN_SOFTIRQ ||
+		     usage->bit > LOCK_ENABLED_SOFTIRQ_READ);
+
+	while (vectors) {
+		long fs = __ffs64(vectors) + 1;
+
+		vectors >>= fs;
+		nr += fs;
+		mask |= lock_flag(usage->bit) << (4 * (nr - 1));
+	}
+
+	return mask;
 }
 
 /*
@@ -2546,10 +2565,23 @@ static u64 lock_usage_mask(struct lock_usage *usage)
  */
 static inline int
 valid_state(struct task_struct *curr, struct held_lock *this,
-	    enum lock_usage_bit new_bit, enum lock_usage_bit bad_bit)
+	    u64 new_mask, u64 bad_mask)
 {
-	if (unlikely(hlock_class(this)->usage_mask & lock_flag(bad_bit)))
+	u64 bad_intersec;
+
+	bad_intersec = hlock_class(this)->usage_mask & bad_mask;
+
+	if (unlikely(bad_intersec)) {
+		enum lock_usage_bit new_bit, bad_bit;
+		int err;
+
+		err = find_exclusive_match(new_mask,
+					   bad_intersec, &new_bit, &bad_bit);
+		if (WARN_ON_ONCE(err < 0))
+			return err;
+
 		return print_usage_bug(curr, this, bad_bit, new_bit);
+	}
 	return 1;
 }
 
@@ -2746,7 +2778,8 @@ mark_lock_irq(struct task_struct *curr, struct held_lock *this,
 	 * Validate that this particular lock does not have conflicting
 	 * usage states.
 	 */
-	if (!valid_state(curr, this, new_usage->bit, excl_usage.bit))
+	if (!valid_state(curr, this, lock_usage_mask(new_usage),
+			 lock_usage_mask(&excl_usage)))
 		return 0;
 
 	/*
@@ -2762,7 +2795,8 @@ mark_lock_irq(struct task_struct *curr, struct held_lock *this,
 	 */
 	if (!read) {
 		excl_usage.bit += LOCK_USAGE_READ_MASK;
-		if (!valid_state(curr, this, new_usage->bit, excl_usage.bit))
+		if (!valid_state(curr, this, lock_usage_mask(new_usage),
+				 lock_usage_mask(&excl_usage)))
 			return 0;
 
 		if (STRICT_READ_CHECKS &&
-- 
2.17.1

