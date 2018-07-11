Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDD0C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A422075E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:37:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79A422075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388704AbeGKOmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 10:42:11 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:40472 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388075AbeGKOmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 10:42:10 -0400
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fdGFE-0002q5-TF; Wed, 11 Jul 2018 16:37:29 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        tglx@linutronix.de, Ingo Molnar <mingo@kernel.org>,
        Ingo Molnar <mingo@elte.hu>, "Theodore Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] random: Remove preempt disabled region
Date:   Wed, 11 Jul 2018 16:37:21 +0200
Message-Id: <20180711143721.18378-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

No need to keep preemption disabled across the whole function.

mix_pool_bytes() uses a spin_lock() to protect the pool and there are
other places like write_pool() whhich invoke mix_pool_bytes() without
disabling preemption.
credit_entropy_bits() is invoked from other places like
add_hwgenerator_randomness() without disabling preemption.

Before commit 95b709b6be49 ("random: drop trickle mode") the function
used __this_cpu_inc_return() which would require disabled preemption.
The preempt_disable() section was added in commit 43d5d3018c37 ("[PATCH]
random driver preempt robustness", history tree).  It was claimed that
the code relied on "vt_ioctl() being called under BKL".

Cc: "Theodore Ts'o" <tytso@mit.edu>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[bigeasy: enhance the commit message]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/char/random.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index cd888d4ee605..e43690977b29 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1122,8 +1122,6 @@ static void add_timer_randomness(struct timer_rand_st=
ate *state, unsigned num)
 	} sample;
 	long delta, delta2, delta3;
=20
-	preempt_disable();
-
 	sample.jiffies =3D jiffies;
 	sample.cycles =3D random_get_entropy();
 	sample.num =3D num;
@@ -1161,8 +1159,6 @@ static void add_timer_randomness(struct timer_rand_st=
ate *state, unsigned num)
 	 * and limit entropy entimate to 12 bits.
 	 */
 	credit_entropy_bits(r, min_t(int, fls(delta>>1), 11));
-
-	preempt_enable();
 }
=20
 void add_input_randomness(unsigned int type, unsigned int code,
--=20
2.18.0

