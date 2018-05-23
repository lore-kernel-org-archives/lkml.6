Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932674AbeEWLdc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 07:33:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53580 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932529AbeEWLdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 07:33:31 -0400
From: Miroslav Lichvar <mlichvar@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Miroslav Lichvar <mlichvar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH RFC] timekeeping: Update multiplier when NTP frequency is set directly
Date: Wed, 23 May 2018 13:33:21 +0200
Message-Id: <20180523113321.20404-1-mlichvar@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the NTP frequency is set directly from userspace using the
ADJ_FREQUENCY or ADJ_TICK timex mode, immediately update the
timekeeper's multiplier instead of waiting for the next tick.

This removes a hidden non-deterministic delay in setting of the
frequency and allows an extremely tight control of the system clock
with update rates close to or even exceeding the kernel HZ.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Prarit Bhargava <prarit@redhat.com>
Signed-off-by: Miroslav Lichvar <mlichvar@redhat.com>
---
 kernel/time/timekeeping.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 49cbceef5deb..6922dae7317c 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2047,10 +2047,6 @@ void update_wall_time(void)
 				   tk->tkr_mono.cycle_last, tk->tkr_mono.mask);
 #endif
 
-	/* Check if there's really nothing to do */
-	if (offset < real_tk->cycle_interval)
-		goto out;
-
 	/* Do some additional sanity checking */
 	timekeeping_check_update(tk, offset);
 
@@ -2332,6 +2328,10 @@ int do_adjtimex(struct timex *txc)
 	write_seqcount_end(&tk_core.seq);
 	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
 
+	/* Update the multiplier immediately if frequency was set directly */
+	if (txc->modes & (ADJ_FREQUENCY | ADJ_TICK))
+		update_wall_time();
+
 	if (tai != orig_tai)
 		clock_was_set();
 
-- 
2.14.3
