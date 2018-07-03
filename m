Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64DDC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 614C6248C5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:05:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 614C6248C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753349AbeGCUFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 16:05:01 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45338 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753107AbeGCUCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 16:02:06 -0400
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1faRUw-0001tM-G5; Tue, 03 Jul 2018 22:02:02 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 6/6] userns: Use irqsave variant of refcount_dec_and_lock()
Date:   Tue,  3 Jul 2018 22:01:41 +0200
Message-Id: <20180703200141.28415-7-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180703200141.28415-1-bigeasy@linutronix.de>
References: <20180703200141.28415-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anna-Maria Gleixner <anna-maria@linutronix.de>

The irqsave variant of refcount_dec_and_lock handles irqsave/restore when
taking/releasing the spin lock. With this variant the call of
local_irq_save/restore is no longer required.

Cc: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
[bigeasy: s@atomic_dec_and_lock@refcount_dec_and_lock@g ]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/user.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/user.c b/kernel/user.c
index 5f65ef195259..0df9b1640b2a 100644
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -169,11 +169,8 @@ void free_uid(struct user_struct *up)
 	if (!up)
 		return;
=20
-	local_irq_save(flags);
-	if (refcount_dec_and_lock(&up->__count, &uidhash_lock))
+	if (refcount_dec_and_lock_irqsave(&up->__count, &uidhash_lock, &flags))
 		free_user(up, flags);
-	else
-		local_irq_restore(flags);
 }
=20
 struct user_struct *alloc_uid(kuid_t uid)
--=20
2.18.0

