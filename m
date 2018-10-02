Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6C6C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C1C22082A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:53:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C1C22082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731552AbeJBUQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:16:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34632 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731526AbeJBUQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:16:02 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0EF095AA;
        Tue,  2 Oct 2018 13:32:39 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Team OWL337 <icytxw@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 047/137] posix-timers: Make forward callback return s64
Date:   Tue,  2 Oct 2018 06:24:08 -0700
Message-Id: <20181002132501.767456416@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132458.446916963@linuxfoundation.org>
References: <20181002132458.446916963@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit 6fec64e1c92d5c715c6d0f50786daa7708266bde ]

The posix timer ti_overrun handling is broken because the forwarding
functions can return a huge number of overruns which does not fit in an
int. As a consequence timer_getoverrun(2) and siginfo::si_overrun can turn
into random number generators.

As a first step to address that let the timer_forward() callbacks return
the full 64 bit value.

Cast it to (int) temporarily until k_itimer::ti_overrun is converted to
64bit and the conversion to user space visible values is sanitized.

Reported-by: Team OWL337 <icytxw@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <john.stultz@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Link: https://lkml.kernel.org/r/20180626132704.922098090@linutronix.de
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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


