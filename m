Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50248C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F0725475
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 09:37:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14F0725475
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965248AbeGBJhV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 05:37:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42461 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964858AbeGBJhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 05:37:17 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w629aqbq4024317
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 2 Jul 2018 02:36:52 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w629aq5Y4024314;
        Mon, 2 Jul 2018 02:36:52 -0700
Date:   Mon, 2 Jul 2018 02:36:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-6fec64e1c92d5c715c6d0f50786daa7708266bde@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, icytxw@gmail.com, mingo@kernel.org,
        john.stultz@linaro.org, hpa@zytor.com, tglx@linutronix.de,
        peterz@infradead.org, mtk.manpages@gmail.com
Reply-To: icytxw@gmail.com, mingo@kernel.org, john.stultz@linaro.org,
          linux-kernel@vger.kernel.org, mtk.manpages@gmail.com,
          peterz@infradead.org, tglx@linutronix.de, hpa@zytor.com
In-Reply-To: <20180626132704.922098090@linutronix.de>
References: <20180626132704.922098090@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] posix-timers: Make forward callback return s64
Git-Commit-ID: 6fec64e1c92d5c715c6d0f50786daa7708266bde
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

Commit-ID:  6fec64e1c92d5c715c6d0f50786daa7708266bde
Gitweb:     https://git.kernel.org/tip/6fec64e1c92d5c715c6d0f50786daa7708266bde
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Tue, 26 Jun 2018 15:21:31 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 2 Jul 2018 11:33:25 +0200

posix-timers: Make forward callback return s64

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

---
 kernel/time/alarmtimer.c   | 4 ++--
 kernel/time/posix-timers.c | 6 +++---
 kernel/time/posix-timers.h | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 639321bf2e39..78a3cc555823 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -581,11 +581,11 @@ static void alarm_timer_rearm(struct k_itimer *timr)
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
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 80d59333c76e..db1d65963a57 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -645,11 +645,11 @@ static ktime_t common_hrtimer_remaining(struct k_itimer *timr, ktime_t now)
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
@@ -702,7 +702,7 @@ void common_timer_get(struct k_itimer *timr, struct itimerspec64 *cur_setting)
 	 * expiry time forward by intervals, so expiry is > now.
 	 */
 	if (iv && (timr->it_requeue_pending & REQUEUE_PENDING || sig_none))
-		timr->it_overrun += kc->timer_forward(timr, now);
+		timr->it_overrun += (int)kc->timer_forward(timr, now);
 
 	remaining = kc->timer_remaining(timr, now);
 	/* Return 0 only, when the timer is expired and not pending */
diff --git a/kernel/time/posix-timers.h b/kernel/time/posix-timers.h
index 151e28f5bf30..ddb21145211a 100644
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
