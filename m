Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751934AbeCMHJ1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 03:09:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43073 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751462AbeCMHJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 03:09:25 -0400
Date: Tue, 13 Mar 2018 00:08:41 -0700
From: tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-7250a4047aa6106006c2c9b5aff91d7d3fb77962@git.kernel.org>
Cc: dmitry.torokhov@gmail.com, mingo@kernel.org, tglx@linutronix.de,
        kevin@guarana.org, torvalds@linux-foundation.org, corbet@lwn.net,
        mtk.manpages@gmail.com, linux-kernel@vger.kernel.org,
        salyzyn@android.com, rostedt@goodmis.org, prarit@redhat.com,
        sergey.senozhatsky@gmail.com, john.stultz@linaro.org,
        peterz@infradead.org, pmladek@suse.com, hpa@zytor.com
Reply-To: mingo@kernel.org, dmitry.torokhov@gmail.com, tglx@linutronix.de,
        kevin@guarana.org, corbet@lwn.net, mtk.manpages@gmail.com,
        torvalds@linux-foundation.org, rostedt@goodmis.org,
        salyzyn@android.com, linux-kernel@vger.kernel.org, prarit@redhat.com,
        sergey.senozhatsky@gmail.com, peterz@infradead.org,
        john.stultz@linaro.org, hpa@zytor.com, pmladek@suse.com
In-Reply-To: <20180301165150.315745557@linutronix.de>
References: <20180301165150.315745557@linutronix.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] posix-timers: Unify MONOTONIC and BOOTTIME clock
 behavior
Git-Commit-ID: 7250a4047aa6106006c2c9b5aff91d7d3fb77962
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  7250a4047aa6106006c2c9b5aff91d7d3fb77962
Gitweb:     https://git.kernel.org/tip/7250a4047aa6106006c2c9b5aff91d7d3fb77962
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Thu, 1 Mar 2018 17:33:36 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 13 Mar 2018 07:34:22 +0100

posix-timers: Unify MONOTONIC and BOOTTIME clock behavior

Now that the MONOTONIC and BOOTTIME clocks are indentical remove all the special
casing.

The user space visible interfaces still support both clocks, but their behavior
is identical.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Kevin Easton <kevin@guarana.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Salyzyn <salyzyn@android.com>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Link: http://lkml.kernel.org/r/20180301165150.315745557@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/time/posix-timers.c | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 556fe02a47a4..8cf95bfee44f 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -251,12 +251,6 @@ static int posix_get_coarse_res(const clockid_t which_clock, struct timespec64 *
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
@@ -1322,21 +1316,6 @@ static const struct k_clock clock_tai = {
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
@@ -1350,7 +1329,7 @@ static const struct k_clock * const posix_clocks[] = {
 	[CLOCK_MONOTONIC_RAW]		= &clock_monotonic_raw,
 	[CLOCK_REALTIME_COARSE]		= &clock_realtime_coarse,
 	[CLOCK_MONOTONIC_COARSE]	= &clock_monotonic_coarse,
-	[CLOCK_BOOTTIME]		= &clock_boottime,
+	[CLOCK_BOOTTIME]		= &clock_monotonic,
 	[CLOCK_REALTIME_ALARM]		= &alarm_clock,
 	[CLOCK_BOOTTIME_ALARM]		= &alarm_clock,
 	[CLOCK_TAI]			= &clock_tai,
