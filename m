Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A57C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 274F220685
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 274F220685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732640AbeGaRzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 13:55:44 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60085 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729323AbeGaRzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 13:55:44 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=somnus.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <anna-maria@linutronix.de>)
        id 1fkXHi-0007Yb-Vx; Tue, 31 Jul 2018 18:14:08 +0200
From:   Anna-Maria Gleixner <anna-maria@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     bigeasy@linutronix.de, tglx@linutronix.de, frederic@kernel.org,
        bristot@redhat.com, paulmck@linux.vnet.ibm.com,
        peterz@infradead.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: [PATCH] nohz: Fix local_timer_softirq_pending()
Date:   Tue, 31 Jul 2018 18:13:58 +0200
Message-Id: <20180731161358.29472-1-anna-maria@linutronix.de>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

local_timer_softirq_pending() checks whether the timer softirq is
pending with: local_softirq_pending() & TIMER_SOFTIRQ.

This is wrong because TIMER_SOFTIRQ is the softirq number and not a
bitmask. So the test checks for the wrong bit.

Use BIT(TIMER_SOFTIRQ) instead.

Fixes: 5d62c183f9e9 ("nohz: Prevent a timer interrupt storm in tick_nohz_stop_sched_tick()")
Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
---
 kernel/time/tick-sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index da9455a6b42b..5b33e2f5c0ed 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -642,7 +642,7 @@ static void tick_nohz_restart(struct tick_sched *ts, ktime_t now)
 
 static inline bool local_timer_softirq_pending(void)
 {
-	return local_softirq_pending() & TIMER_SOFTIRQ;
+	return local_softirq_pending() & BIT(TIMER_SOFTIRQ);
 }
 
 static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
-- 
2.18.0

