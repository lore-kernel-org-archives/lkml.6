Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51628C4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 13:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F065820865
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 13:13:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F065820865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbeIISDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 14:03:02 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:37958 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbeIISDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 14:03:02 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fyzWi-0007v5-Bt; Sun, 09 Sep 2018 15:13:20 +0200
Date:   Sun, 9 Sep 2018 15:13:19 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] timekeeping fixes for 4.19
Message-ID: <alpine.DEB.2.21.1809091512450.1402@nanos.tec.linutronix.de>
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

Two fixes for timekeeping:

 - Revert to the previous kthread based update, which is unfortunately
   required due to lock ordering issues. The removal caused boot failures
   on old Core2 machines. Add a proper comment why the thread needs to stay
   to prevent accidental removal in the future.

 - Fix a silly typo in a function declaration

Thanks,

	tglx

------------------>
Christian Borntraeger (1):
      timekeeping: Fix declaration of read_persistent_wall_and_boot_offset()

Peter Zijlstra (1):
      clocksource: Revert "Remove kthread"


 include/linux/timekeeping.h |  4 ++--
 kernel/time/clocksource.c   | 40 ++++++++++++++++++++++++++++++----------
 2 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index 5d738804e3d6..a5a3cfc3c2fa 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -258,8 +258,8 @@ extern void ktime_get_snapshot(struct system_time_snapshot *systime_snapshot);
 extern int persistent_clock_is_local;
 
 extern void read_persistent_clock64(struct timespec64 *ts);
-void read_persistent_clock_and_boot_offset(struct timespec64 *wall_clock,
-					   struct timespec64 *boot_offset);
+void read_persistent_wall_and_boot_offset(struct timespec64 *wall_clock,
+					  struct timespec64 *boot_offset);
 extern int update_persistent_clock64(struct timespec64 now);
 
 /*
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index f74fb00d8064..0e6e97a01942 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -133,19 +133,40 @@ static void inline clocksource_watchdog_unlock(unsigned long *flags)
 	spin_unlock_irqrestore(&watchdog_lock, *flags);
 }
 
+static int clocksource_watchdog_kthread(void *data);
+static void __clocksource_change_rating(struct clocksource *cs, int rating);
+
 /*
  * Interval: 0.5sec Threshold: 0.0625s
  */
 #define WATCHDOG_INTERVAL (HZ >> 1)
 #define WATCHDOG_THRESHOLD (NSEC_PER_SEC >> 4)
 
+static void clocksource_watchdog_work(struct work_struct *work)
+{
+	/*
+	 * We cannot directly run clocksource_watchdog_kthread() here, because
+	 * clocksource_select() calls timekeeping_notify() which uses
+	 * stop_machine(). One cannot use stop_machine() from a workqueue() due
+	 * lock inversions wrt CPU hotplug.
+	 *
+	 * Also, we only ever run this work once or twice during the lifetime
+	 * of the kernel, so there is no point in creating a more permanent
+	 * kthread for this.
+	 *
+	 * If kthread_run fails the next watchdog scan over the
+	 * watchdog_list will find the unstable clock again.
+	 */
+	kthread_run(clocksource_watchdog_kthread, NULL, "kwatchdog");
+}
+
 static void __clocksource_unstable(struct clocksource *cs)
 {
 	cs->flags &= ~(CLOCK_SOURCE_VALID_FOR_HRES | CLOCK_SOURCE_WATCHDOG);
 	cs->flags |= CLOCK_SOURCE_UNSTABLE;
 
 	/*
-	 * If the clocksource is registered clocksource_watchdog_work() will
+	 * If the clocksource is registered clocksource_watchdog_kthread() will
 	 * re-rate and re-select.
 	 */
 	if (list_empty(&cs->list)) {
@@ -156,7 +177,7 @@ static void __clocksource_unstable(struct clocksource *cs)
 	if (cs->mark_unstable)
 		cs->mark_unstable(cs);
 
-	/* kick clocksource_watchdog_work() */
+	/* kick clocksource_watchdog_kthread() */
 	if (finished_booting)
 		schedule_work(&watchdog_work);
 }
@@ -166,7 +187,7 @@ static void __clocksource_unstable(struct clocksource *cs)
  * @cs:		clocksource to be marked unstable
  *
  * This function is called by the x86 TSC code to mark clocksources as unstable;
- * it defers demotion and re-selection to a work.
+ * it defers demotion and re-selection to a kthread.
  */
 void clocksource_mark_unstable(struct clocksource *cs)
 {
@@ -391,9 +412,7 @@ static void clocksource_dequeue_watchdog(struct clocksource *cs)
 	}
 }
 
-static void __clocksource_change_rating(struct clocksource *cs, int rating);
-
-static int __clocksource_watchdog_work(void)
+static int __clocksource_watchdog_kthread(void)
 {
 	struct clocksource *cs, *tmp;
 	unsigned long flags;
@@ -418,12 +437,13 @@ static int __clocksource_watchdog_work(void)
 	return select;
 }
 
-static void clocksource_watchdog_work(struct work_struct *work)
+static int clocksource_watchdog_kthread(void *data)
 {
 	mutex_lock(&clocksource_mutex);
-	if (__clocksource_watchdog_work())
+	if (__clocksource_watchdog_kthread())
 		clocksource_select();
 	mutex_unlock(&clocksource_mutex);
+	return 0;
 }
 
 static bool clocksource_is_watchdog(struct clocksource *cs)
@@ -442,7 +462,7 @@ static void clocksource_enqueue_watchdog(struct clocksource *cs)
 static void clocksource_select_watchdog(bool fallback) { }
 static inline void clocksource_dequeue_watchdog(struct clocksource *cs) { }
 static inline void clocksource_resume_watchdog(void) { }
-static inline int __clocksource_watchdog_work(void) { return 0; }
+static inline int __clocksource_watchdog_kthread(void) { return 0; }
 static bool clocksource_is_watchdog(struct clocksource *cs) { return false; }
 void clocksource_mark_unstable(struct clocksource *cs) { }
 
@@ -810,7 +830,7 @@ static int __init clocksource_done_booting(void)
 	/*
 	 * Run the watchdog first to eliminate unstable clock sources
 	 */
-	__clocksource_watchdog_work();
+	__clocksource_watchdog_kthread();
 	clocksource_select();
 	mutex_unlock(&clocksource_mutex);
 	return 0;
