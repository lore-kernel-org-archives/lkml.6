Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A2CC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 08:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1151D208A3
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 08:11:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1151D208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbeKKR7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 12:59:00 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:49411 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbeKKR7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 12:59:00 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gLkpn-00072q-1F; Sun, 11 Nov 2018 09:11:07 +0100
Subject: [GIT pull] locking fixes for 4.20
Message-ID: <154192381794.5458.12653407758988530367.tglx@nanos.tec.linutronix.de>
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
References: <154192381794.5458.5498732290895334242.tglx@nanos.tec.linutronix.de>
Date:   Sun, 11 Nov 2018 09:11:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest locking-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-for-linus


A single fix for a build fail with CONFIG_PROFILE_ALL_BRANCHES=y in the
qspinlock code.

Thanks,

	tglx

------------------>
Peter Zijlstra (1):
      x86/qspinlock: Fix compile error


 arch/x86/include/asm/qspinlock.h | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
index 87623c6b13db..bd5ac6cc37db 100644
--- a/arch/x86/include/asm/qspinlock.h
+++ b/arch/x86/include/asm/qspinlock.h
@@ -13,12 +13,15 @@
 #define queued_fetch_set_pending_acquire queued_fetch_set_pending_acquire
 static __always_inline u32 queued_fetch_set_pending_acquire(struct qspinlock *lock)
 {
-	u32 val = 0;
-
-	if (GEN_BINARY_RMWcc(LOCK_PREFIX "btsl", lock->val.counter, c,
-			     "I", _Q_PENDING_OFFSET))
-		val |= _Q_PENDING_VAL;
+	u32 val;
 
+	/*
+	 * We can't use GEN_BINARY_RMWcc() inside an if() stmt because asm goto
+	 * and CONFIG_PROFILE_ALL_BRANCHES=y results in a label inside a
+	 * statement expression, which GCC doesn't like.
+	 */
+	val = GEN_BINARY_RMWcc(LOCK_PREFIX "btsl", lock->val.counter, c,
+			       "I", _Q_PENDING_OFFSET) * _Q_PENDING_VAL;
 	val |= atomic_read(&lock->val) & ~_Q_PENDING_MASK;
 
 	return val;

