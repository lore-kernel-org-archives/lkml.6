Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271F1C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7635206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 21:43:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7635206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbeIGCVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 22:21:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57005 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbeIGCVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 22:21:02 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86Lgr1s446385
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 14:42:53 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86LgpAo446377;
        Thu, 6 Sep 2018 14:42:51 -0700
Date:   Thu, 6 Sep 2018 14:42:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-e2c631ba75a7e727e8db0a9d30a06bfd434adb3a@git.kernel.org>
Cc:     hpa@zytor.com, peterz@infradead.org, frame@mailbox.org,
        tglx@linutronix.de, kevin@shanahan.id.au, mingo@kernel.org,
        linux-kernel@vger.kernel.org, niklas.cassel@linaro.org
Reply-To: niklas.cassel@linaro.org, mingo@kernel.org,
          linux-kernel@vger.kernel.org, kevin@shanahan.id.au,
          frame@mailbox.org, tglx@linutronix.de, peterz@infradead.org,
          hpa@zytor.com
In-Reply-To: <20180905084158.GR24124@hirez.programming.kicks-ass.net>
References: <20180905084158.GR24124@hirez.programming.kicks-ass.net>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/urgent] clocksource: Revert "Remove kthread"
Git-Commit-ID: e2c631ba75a7e727e8db0a9d30a06bfd434adb3a
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

Commit-ID:  e2c631ba75a7e727e8db0a9d30a06bfd434adb3a
Gitweb:     https://git.kernel.org/tip/e2c631ba75a7e727e8db0a9d30a06bfd434adb3a
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Wed, 5 Sep 2018 10:41:58 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 6 Sep 2018 23:38:35 +0200

clocksource: Revert "Remove kthread"

I turns out that the silly spawn kthread from worker was actually needed.

clocksource_watchdog_kthread() cannot be called directly from
clocksource_watchdog_work(), because clocksource_select() calls
timekeeping_notify() which uses stop_machine(). One cannot use
stop_machine() from a workqueue() due lock inversions wrt CPU hotplug.

Revert the patch but add a comment that explain why we jump through such
apparently silly hoops.

Fixes: 7197e77abcb6 ("clocksource: Remove kthread")
Reported-by: Siegfried Metz <frame@mailbox.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Niklas Cassel <niklas.cassel@linaro.org>
Tested-by: Kevin Shanahan <kevin@shanahan.id.au>
Tested-by: viktor_jaegerskuepper@freenet.de
Tested-by: Siegfried Metz <frame@mailbox.org>
Cc: rafael.j.wysocki@intel.com
Cc: len.brown@intel.com
Cc: diego.viola@gmail.com
Cc: rui.zhang@intel.com
Cc: bjorn.andersson@linaro.org
Link: https://lkml.kernel.org/r/20180905084158.GR24124@hirez.programming.kicks-ass.net
---
 kernel/time/clocksource.c | 40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

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
