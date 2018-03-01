Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033275AbeCAQwJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 11:52:09 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:51707 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033036AbeCAQwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 11:52:03 -0500
Message-Id: <20180301165150.315745557@linutronix.de>
User-Agent: quilt/0.63-1
Date: Thu, 01 Mar 2018 17:33:36 +0100
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Stultz <john.stultz@linaro.org>, Petr Mladek <pmladek@suse.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kevin Easton <kevin@guarana.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [RFC/RFT patch 5/7] posix-timers: Conflate clock MONOTONIC and
 BOOTTIME
References: <20180301163331.987775783@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline;
 filename=posix-timers--Conflate-clock-MONOTONIC-and-BOOTTIME.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that clock MONOTONIC and BOOTTIME are indentical remove all the special
casing. The user space visible interfaces still support both clocks.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-timers.c |   23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -251,12 +251,6 @@ static int posix_get_coarse_res(const cl
 	return 0;
 }
 
-static int posix_get_boottime(const clockid_t which_clock, struct timespec64 *tp)
-{
-	get_monotonic_boottime64(tp);
-	return 0;
-}
-
 static int posix_get_tai(clockid_t which_clock, struct timespec64 *tp)
 {
 	timekeeping_clocktai64(tp);
@@ -1322,21 +1316,6 @@ static const struct k_clock clock_tai =
 	.timer_arm		= common_hrtimer_arm,
 };
 
-static const struct k_clock clock_boottime = {
-	.clock_getres		= posix_get_hrtimer_res,
-	.clock_get		= posix_get_boottime,
-	.nsleep			= common_nsleep,
-	.timer_create		= common_timer_create,
-	.timer_set		= common_timer_set,
-	.timer_get		= common_timer_get,
-	.timer_del		= common_timer_del,
-	.timer_rearm		= common_hrtimer_rearm,
-	.timer_forward		= common_hrtimer_forward,
-	.timer_remaining	= common_hrtimer_remaining,
-	.timer_try_to_cancel	= common_hrtimer_try_to_cancel,
-	.timer_arm		= common_hrtimer_arm,
-};
-
 static const struct k_clock clock_monotonic_active = {
 	.clock_getres		= posix_get_hrtimer_res,
 	.clock_get		= posix_get_monotonic_active,
@@ -1350,7 +1329,7 @@ static const struct k_clock * const posi
 	[CLOCK_MONOTONIC_RAW]		= &clock_monotonic_raw,
 	[CLOCK_REALTIME_COARSE]		= &clock_realtime_coarse,
 	[CLOCK_MONOTONIC_COARSE]	= &clock_monotonic_coarse,
-	[CLOCK_BOOTTIME]		= &clock_boottime,
+	[CLOCK_BOOTTIME]		= &clock_monotonic,
 	[CLOCK_REALTIME_ALARM]		= &alarm_clock,
 	[CLOCK_BOOTTIME_ALARM]		= &alarm_clock,
 	[CLOCK_TAI]			= &clock_tai,
