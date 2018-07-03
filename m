Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB055C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1ED7248C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:05:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1ED7248C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753281AbeGCUFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 16:05:00 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45342 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753111AbeGCUCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 16:02:08 -0400
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1faRUt-0001tM-Q6; Tue, 03 Jul 2018 22:01:59 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Shaohua Li <shli@kernel.org>, linux-raid@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/6] drivers/md/raid5: Do not disable irq on release_inactive_stripe_list() call
Date:   Tue,  3 Jul 2018 22:01:37 +0200
Message-Id: <20180703200141.28415-3-bigeasy@linutronix.de>
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

There is no need to invoke release_inactive_stripe_list() with interrupts
disabled. All call sites, except raid5_release_stripe(), unlock
->device_lock and enable interrupts before invoking the function.

Make it consistent.

Cc: Shaohua Li <shli@kernel.org>
Cc: linux-raid@vger.kernel.org
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/md/raid5.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index e933bff9459e..ca1dd0cb04c5 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -414,9 +414,8 @@ void raid5_release_stripe(struct stripe_head *sh)
 		INIT_LIST_HEAD(&list);
 		hash =3D sh->hash_lock_index;
 		do_release_stripe(conf, sh, &list);
-		spin_unlock(&conf->device_lock);
+		spin_unlock_irqrestore(&conf->device_lock, flags);
 		release_inactive_stripe_list(conf, &list, hash);
-		local_irq_restore(flags);
 	}
 }
=20
--=20
2.18.0

