Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752706AbeC1K2R convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 06:28:17 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50245 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752125AbeC1K2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 06:28:15 -0400
Date: Wed, 28 Mar 2018 12:28:13 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-rt-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>, stable-rt@vger.kernel.org
Subject: [PATCH RT 2/3 v2] posix-timers: user proper timer while waiting for
 alarmtimer
Message-ID: <20180328102813.gaf25zu7lajidwyy@linutronix.de>
References: <20180328100746.18668-1-bigeasy@linutronix.de>
 <20180328100746.18668-2-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180328100746.18668-2-bigeasy@linutronix.de>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On RT the timer can be preempted while running and therefore we wait
with timer_wait_for_callback() for the timer to complete (instead of
busy looping).
The POSIX timer has an hrtimer underneath and this hrtimer is used to
wait for its completion. The alartimer has also an hrtimer but at a
different location.

Instead of checking for ->timer_set which is the same for the alarmtimer
and the "posix-timers" I instead check for ->arm which is only used by
the "posix-timers". To match the alarmtimer I check for the alarm_clock
struct.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v1…v2: move timer_wait_for_callback() so that it actually compiles.

 kernel/time/posix-timers.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 0b568087bd64..3abd449a926f 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -796,20 +796,6 @@ SYSCALL_DEFINE1(timer_getoverrun, timer_t, timer_id)
 	return overrun;
 }
 
-/*
- * Protected by RCU!
- */
-static void timer_wait_for_callback(const struct k_clock *kc, struct k_itimer *timr)
-{
-#ifdef CONFIG_PREEMPT_RT_FULL
-	if (kc->timer_set == common_timer_set)
-		hrtimer_wait_for_timer(&timr->it.real.timer);
-	else
-		/* FIXME: Whacky hack for posix-cpu-timers */
-		schedule_timeout(1);
-#endif
-}
-
 static void common_hrtimer_arm(struct k_itimer *timr, ktime_t expires,
 			       bool absolute, bool sigev_none)
 {
@@ -840,6 +826,22 @@ static void common_hrtimer_arm(struct k_itimer *timr, ktime_t expires,
 		hrtimer_start_expires(timer, HRTIMER_MODE_ABS);
 }
 
+/*
+ * Protected by RCU!
+ */
+static void timer_wait_for_callback(const struct k_clock *kc, struct k_itimer *timr)
+{
+#ifdef CONFIG_PREEMPT_RT_FULL
+	if (kc->timer_arm == common_hrtimer_arm)
+		hrtimer_wait_for_timer(&timr->it.real.timer);
+	else if (kc == &alarm_clock)
+		hrtimer_wait_for_timer(&timr->it.alarm.alarmtimer.timer);
+	else
+		/* FIXME: Whacky hack for posix-cpu-timers */
+		schedule_timeout(1);
+#endif
+}
+
 static int common_hrtimer_try_to_cancel(struct k_itimer *timr)
 {
 	return hrtimer_try_to_cancel(&timr->it.real.timer);
-- 
2.16.3
