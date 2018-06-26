Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20713C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9BC826B4F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:28:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9BC826B4F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965499AbeFZN2B (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 09:28:01 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49887 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965296AbeFZN2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 09:28:00 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fXo0k-0001PW-KY; Tue, 26 Jun 2018 15:27:58 +0200
Message-ID: <20180626132704.922098090@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 26 Jun 2018 15:21:31 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        air icy <icytxw@gmail.com>
Subject: [patch 1/2] posix-timers: Make forward callback return s64
References: <20180626132130.345959379@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The posix timer ti_overrun handling is broken because the forwarding
functions can return a huge number of overruns which does not fit in an
int. As a consequence timer_getoverrun(2) and siginfo::si_overrun can turn
into random number generators.

As a first step to address that let the timer_forward() callbacks return
the full 64 bit value.

Cast it to (int) temporarily until k_itimer::ti_overrun is converted to
64bit and the conversion to user space visible values is sanitized.

Reported-by: air icy <icytxw@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/alarmtimer.c   |    4 ++--
 kernel/time/posix-timers.c |    6 +++---
 kernel/time/posix-timers.h |    2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -581,11 +581,11 @@ static void alarm_timer_rearm(struct k_i
  * @timr:	Pointer to the posixtimer data struct
  * @now:	Current time to forward the timer against
  */
-static int alarm_timer_forward(struct k_itimer *timr, ktime_t now)
+static s64 alarm_timer_forward(struct k_itimer *timr, ktime_t now)
 {
 	struct alarm *alarm = &timr->it.alarm.alarmtimer;
 
-	return (int) alarm_forward(alarm, timr->it_interval, now);
+	return alarm_forward(alarm, timr->it_interval, now);
 }
 
 /**
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -645,11 +645,11 @@ static ktime_t common_hrtimer_remaining(
 	return __hrtimer_expires_remaining_adjusted(timer, now);
 }
 
-static int common_hrtimer_forward(struct k_itimer *timr, ktime_t now)
+static s64 common_hrtimer_forward(struct k_itimer *timr, ktime_t now)
 {
 	struct hrtimer *timer = &timr->it.real.timer;
 
-	return (int)hrtimer_forward(timer, now, timr->it_interval);
+	return hrtimer_forward(timer, now, timr->it_interval);
 }
 
 /*
@@ -702,7 +702,7 @@ void common_timer_get(struct k_itimer *t
 	 * expiry time forward by intervals, so expiry is > now.
 	 */
 	if (iv && (timr->it_requeue_pending & REQUEUE_PENDING || sig_none))
-		timr->it_overrun += kc->timer_forward(timr, now);
+		timr->it_overrun += (int)kc->timer_forward(timr, now);
 
 	remaining = kc->timer_remaining(timr, now);
 	/* Return 0 only, when the timer is expired and not pending */
--- a/kernel/time/posix-timers.h
+++ b/kernel/time/posix-timers.h
@@ -19,7 +19,7 @@ struct k_clock {
 	void	(*timer_get)(struct k_itimer *timr,
 			     struct itimerspec64 *cur_setting);
 	void	(*timer_rearm)(struct k_itimer *timr);
-	int	(*timer_forward)(struct k_itimer *timr, ktime_t now);
+	s64	(*timer_forward)(struct k_itimer *timr, ktime_t now);
 	ktime_t	(*timer_remaining)(struct k_itimer *timr, ktime_t now);
 	int	(*timer_try_to_cancel)(struct k_itimer *timr);
 	void	(*timer_arm)(struct k_itimer *timr, ktime_t expires,


