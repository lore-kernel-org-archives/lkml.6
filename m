Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EE1C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC562151D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:55:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDC562151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404316AbeHGVLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:11:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33658 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390351AbeHGVK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:10:59 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 93503D07;
        Tue,  7 Aug 2018 18:55:16 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        bigeasy@linutronix.de, peterz@infradead.org
Subject: [PATCH 4.9 04/17] nohz: Fix local_timer_softirq_pending()
Date:   Tue,  7 Aug 2018 20:51:40 +0200
Message-Id: <20180807172342.420516148@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807172342.071526922@linuxfoundation.org>
References: <20180807172342.071526922@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anna-Maria Gleixner <anna-maria@linutronix.de>

commit 80d20d35af1edd632a5e7a3b9c0ab7ceff92769e upstream.

local_timer_softirq_pending() checks whether the timer softirq is
pending with: local_softirq_pending() & TIMER_SOFTIRQ.

This is wrong because TIMER_SOFTIRQ is the softirq number and not a
bitmask. So the test checks for the wrong bit.

Use BIT(TIMER_SOFTIRQ) instead.

Fixes: 5d62c183f9e9 ("nohz: Prevent a timer interrupt storm in tick_nohz_stop_sched_tick()")
Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Cc: bigeasy@linutronix.de
Cc: peterz@infradead.org
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20180731161358.29472-1-anna-maria@linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/time/tick-sched.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -665,7 +665,7 @@ static void tick_nohz_restart(struct tic
 
 static inline bool local_timer_softirq_pending(void)
 {
-	return local_softirq_pending() & TIMER_SOFTIRQ;
+	return local_softirq_pending() & BIT(TIMER_SOFTIRQ);
 }
 
 static ktime_t tick_nohz_stop_sched_tick(struct tick_sched *ts,


