Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751982AbeCJJNh (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 04:13:37 -0500
Received: from terminus.zytor.com ([198.137.202.136]:47999 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751483AbeCJJNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 04:13:35 -0500
Date: Sat, 10 Mar 2018 01:12:56 -0800
From: tip-bot for Miroslav Lichvar <tipbot@zytor.com>
Message-ID: <tip-c2cda2a5bda9f1369c9d1ab54a20571c13cf2743@git.kernel.org>
Cc: prarit@redhat.com, hpa@zytor.com, stephen.boyd@linaro.org,
        torvalds@linux-foundation.org, richardcochran@gmail.com,
        mlichvar@redhat.com, tglx@linutronix.de, peterz@infradead.org,
        john.stultz@linaro.org, linux-kernel@vger.kernel.org, mingo@kernel.org
Reply-To: richardcochran@gmail.com, torvalds@linux-foundation.org,
        hpa@zytor.com, stephen.boyd@linaro.org, prarit@redhat.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        peterz@infradead.org, tglx@linutronix.de, mlichvar@redhat.com
In-Reply-To: <1520620971-9567-2-git-send-email-john.stultz@linaro.org>
References: <1520620971-9567-2-git-send-email-john.stultz@linaro.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] timekeeping/ntp: Don't align NTP frequency
 adjustments to ticks
Git-Commit-ID: c2cda2a5bda9f1369c9d1ab54a20571c13cf2743
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

Commit-ID:  c2cda2a5bda9f1369c9d1ab54a20571c13cf2743
Gitweb:     https://git.kernel.org/tip/c2cda2a5bda9f1369c9d1ab54a20571c13cf2743
Author:     Miroslav Lichvar <mlichvar@redhat.com>
AuthorDate: Fri, 9 Mar 2018 10:42:47 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 10 Mar 2018 09:12:41 +0100

timekeeping/ntp: Don't align NTP frequency adjustments to ticks

When the timekeeping multiplier is changed, the NTP error is updated to
correct the clock for the delay between the tick and the update of the
clock. This error is corrected in later updates and the clock appears as
if the frequency was changed exactly on the tick.

Remove this correction to keep the point where the frequency is
effectively changed at the time of the update. This removes a major
source of the NTP error.

Signed-off-by: Miroslav Lichvar <mlichvar@redhat.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Stephen Boyd <stephen.boyd@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1520620971-9567-2-git-send-email-john.stultz@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/time/timekeeping.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index cd03317e7b57..c1a0ac17336e 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1860,8 +1860,6 @@ static __always_inline void timekeeping_apply_adjustment(struct timekeeper *tk,
 	 *	xtime_nsec_2 = xtime_nsec_1 - offset
 	 * Which simplfies to:
 	 *	xtime_nsec -= offset
-	 *
-	 * XXX - TODO: Doc ntp_error calculation.
 	 */
 	if ((mult_adj > 0) && (tk->tkr_mono.mult + mult_adj < mult_adj)) {
 		/* NTP adjustment caused clocksource mult overflow */
@@ -1872,7 +1870,6 @@ static __always_inline void timekeeping_apply_adjustment(struct timekeeper *tk,
 	tk->tkr_mono.mult += mult_adj;
 	tk->xtime_interval += interval;
 	tk->tkr_mono.xtime_nsec -= offset;
-	tk->ntp_error -= (interval - offset) << tk->ntp_error_shift;
 }
 
 /*
