Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CC8C46470
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 11:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDBD9217C7
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 11:31:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDBD9217C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbeHENf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 09:35:29 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42649 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbeHENf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 09:35:29 -0400
Received: from p4fea5a5a.dip0.t-ipconnect.de ([79.234.90.90] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fmHFf-0001An-6X; Sun, 05 Aug 2018 13:31:11 +0200
Date:   Sun, 5 Aug 2018 13:31:10 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] timer fixes for 4.18
Message-ID: <alpine.DEB.2.21.1808051325370.17359@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-for-linus

Two oneliners addressing NOHZ failures:

  - Use a bitmask to check for the pending timer softirq and not the bit
    number. The existing code using the bit number checked for the wrong
    bit, which caused timers to either expire late or stop completely.

  - Make the nohz evaluation on interrupt exit more robust. The existing
    code did not rearm the hardware when interrupting a running softirq in
    task context (ksoftirqd or tail of local_bh_enable()), which caused
    timers to either expire late or stop completely.

Thanks,

	tglx

------------------>
Anna-Maria Gleixner (1):
      nohz: Fix local_timer_softirq_pending()

Frederic Weisbecker (1):
      nohz: Fix missing tick reprogram when interrupting an inline softirq


 kernel/softirq.c         | 2 +-
 kernel/time/tick-sched.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 75ffc1d1a2e0..6f584861d329 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -390,7 +390,7 @@ static inline void tick_irq_exit(void)
 
 	/* Make sure that timer wheel updates are propagated */
 	if ((idle_cpu(cpu) && !need_resched()) || tick_nohz_full_cpu(cpu)) {
-		if (!in_interrupt())
+		if (!in_irq())
 			tick_nohz_irq_exit();
 	}
 #endif
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
