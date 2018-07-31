Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED799C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A48C820857
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:13:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A48C820857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732590AbeGaVzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 17:55:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58387 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbeGaVzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 17:55:46 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6VKDSXd2840000
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 31 Jul 2018 13:13:29 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6VKDSUZ2839997;
        Tue, 31 Jul 2018 13:13:28 -0700
Date:   Tue, 31 Jul 2018 13:13:28 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Anna-Maria Gleixner <tipbot@zytor.com>
Message-ID: <tip-80d20d35af1edd632a5e7a3b9c0ab7ceff92769e@git.kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        anna-maria@linutronix.de, hpa@zytor.com,
        paulmck@linux.vnet.ibm.com, frederic@kernel.org, mingo@kernel.org,
        bristot@redhat.com
Reply-To: tglx@linutronix.de, linux-kernel@vger.kernel.org,
          anna-maria@linutronix.de, hpa@zytor.com,
          paulmck@linux.vnet.ibm.com, frederic@kernel.org,
          mingo@kernel.org, bristot@redhat.com
In-Reply-To: <20180731161358.29472-1-anna-maria@linutronix.de>
References: <20180731161358.29472-1-anna-maria@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/urgent] nohz: Fix local_timer_softirq_pending()
Git-Commit-ID: 80d20d35af1edd632a5e7a3b9c0ab7ceff92769e
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  80d20d35af1edd632a5e7a3b9c0ab7ceff92769e
Gitweb:     https://git.kernel.org/tip/80d20d35af1edd632a5e7a3b9c0ab7ceff92769e
Author:     Anna-Maria Gleixner <anna-maria@linutronix.de>
AuthorDate: Tue, 31 Jul 2018 18:13:58 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 31 Jul 2018 22:08:44 +0200

nohz: Fix local_timer_softirq_pending()

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
