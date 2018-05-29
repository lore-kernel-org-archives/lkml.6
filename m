Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933304AbeE2Kxt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 06:53:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48868 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932847AbeE2Kxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 06:53:46 -0400
From: Miroslav Lichvar <mlichvar@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Miroslav Lichvar <mlichvar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Prarit Bhargava <prarit@redhat.com>
Subject: [PATCHv1] timekeeping: Update multiplier when NTP frequency is set directly
Date: Tue, 29 May 2018 12:53:43 +0200
Message-Id: <20180529105343.26870-1-mlichvar@redhat.com>
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

Notes:
    RFC->v1:
    - added a new parameter to force the update of the timekeeper to the current
      NTP tick length only from adjtimex()
    - added timekeeping_advance() to keep the parameter local to timekeeping.c

 kernel/time/timekeeping.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 49cbceef5deb..5524c07d43e3 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2021,11 +2021,11 @@ static u64 logarithmic_accumulation(struct timekeeper *tk, u64 offset,
 	return offset;
 }
 
-/**
- * update_wall_time - Uses the current clocksource to increment the wall time
- *
+/*
+ * timekeeping_advance - Updates the timekeeper to the current time and
+ * current NTP tick length
  */
-void update_wall_time(void)
+static void timekeeping_advance(bool force_update)
 {
 	struct timekeeper *real_tk = &tk_core.timekeeper;
 	struct timekeeper *tk = &shadow_timekeeper;
@@ -2048,7 +2048,7 @@ void update_wall_time(void)
 #endif
 
 	/* Check if there's really nothing to do */
-	if (offset < real_tk->cycle_interval)
+	if (offset < real_tk->cycle_interval && !force_update)
 		goto out;
 
 	/* Do some additional sanity checking */
@@ -2105,6 +2105,15 @@ void update_wall_time(void)
 		clock_was_set_delayed();
 }
 
+/**
+ * update_wall_time - Uses the current clocksource to increment the wall time
+ *
+ */
+void update_wall_time(void)
+{
+	timekeeping_advance(false);
+}
+
 /**
  * getboottime64 - Return the real time of system boot.
  * @ts:		pointer to the timespec64 to be set
@@ -2332,6 +2341,10 @@ int do_adjtimex(struct timex *txc)
 	write_seqcount_end(&tk_core.seq);
 	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
 
+	/* Update the multiplier immediately if frequency was set directly */
+	if (txc->modes & (ADJ_FREQUENCY | ADJ_TICK))
+		timekeeping_advance(true);
+
 	if (tai != orig_tai)
 		clock_was_set();
 
-- 
2.14.3
