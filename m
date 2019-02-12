Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B16C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 982E0222BD
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549991764;
	bh=2cFSXGV0SxQOKPgYAd/PhZoB8p6TkUfYiu8QQH6JSjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NVu5/vNAn0+2dPk2/bRr6uJWn+ddPycyjFundwrRIoaJlJ8yLsGxItX4GaS2QQSAV
	 mgSK/CnAovmx3DmnNuAkFWCOjhh4iH7DQh5TFGzyRAtrY7IPY5By2dG3dkEbjkCYnz
	 BOchdj4CCsbGVUX2vzHr4zPwaXmHZc32heUkScZk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731682AbfBLRQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:16:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:58856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731650AbfBLRQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:16:01 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B3AF222B7;
        Tue, 12 Feb 2019 17:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549991760;
        bh=2cFSXGV0SxQOKPgYAd/PhZoB8p6TkUfYiu8QQH6JSjk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gY5NWxTfJV+0L+DJ8em0JbLXwayjBLeyeu2HB9rFxekNetKE4fBiPluCLbeNLvTXy
         Wh/SQWaLWY5JIMnVvCx42wiCQf8l39Szg+1/xjsxwOrKNBNcxCHzQ9T2WgV4VHjxkU
         n4CE+bCycg07BlmChk00cWxNQ+Bi2Gow67GUqJV0=
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
Subject: [PATCH 28/32] locking/lockdep: Update check_flags() according to new layout
Date:   Tue, 12 Feb 2019 18:14:19 +0100
Message-Id: <20190212171423.8308-29-frederic@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212171423.8308-1-frederic@kernel.org>
References: <20190212171423.8308-1-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

current->softirqs_enabled used to mean that either all or no softirqs
are enabled. Now things are getting a bit different with the new per
vector masking extension after which current->softirqs_enabled will
stay on as long as there is a single vector still enabled.

Let's adapt the check to the updated semantics. We can't deduce much
from softirq_count() alone anymore except when it's 0.

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
 kernel/locking/lockdep.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 9bb39677fd97..acd82145f6a6 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3909,13 +3909,8 @@ static void check_flags(unsigned long flags)
 	 * check if not in hardirq contexts:
 	 */
 	if (!hardirq_count()) {
-		if (softirq_count()) {
-			/* like the above, but with softirqs */
-			DEBUG_LOCKS_WARN_ON(current->softirqs_enabled);
-		} else {
-			/* lick the above, does it taste good? */
+		if (!softirq_count())
 			DEBUG_LOCKS_WARN_ON(!current->softirqs_enabled);
-		}
 	}
 
 	if (!debug_locks)
-- 
2.17.1

