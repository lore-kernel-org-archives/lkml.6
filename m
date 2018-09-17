Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D198AECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80BC6214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:15:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80BC6214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733188AbeIREos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:44:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51348 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732814AbeIREoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:44:46 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 577E8CAC;
        Mon, 17 Sep 2018 23:15:13 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Siegfried Metz <frame@mailbox.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Kevin Shanahan <kevin@shanahan.id.au>,
        viktor_jaegerskuepper@freenet.de, rafael.j.wysocki@intel.com,
        len.brown@intel.com, diego.viola@gmail.com, rui.zhang@intel.com,
        bjorn.andersson@linaro.org
Subject: [PATCH 4.18 156/158] clocksource: Revert "Remove kthread"
Date:   Tue, 18 Sep 2018 00:43:06 +0200
Message-Id: <20180917211718.317570418@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit e2c631ba75a7e727e8db0a9d30a06bfd434adb3a upstream.

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
Cc: Siegfried Metz <frame@mailbox.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/time/clocksource.c |   40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -129,19 +129,40 @@ static void inline clocksource_watchdog_
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
@@ -152,7 +173,7 @@ static void __clocksource_unstable(struc
 	if (cs->mark_unstable)
 		cs->mark_unstable(cs);
 
-	/* kick clocksource_watchdog_work() */
+	/* kick clocksource_watchdog_kthread() */
 	if (finished_booting)
 		schedule_work(&watchdog_work);
 }
@@ -162,7 +183,7 @@ static void __clocksource_unstable(struc
  * @cs:		clocksource to be marked unstable
  *
  * This function is called by the x86 TSC code to mark clocksources as unstable;
- * it defers demotion and re-selection to a work.
+ * it defers demotion and re-selection to a kthread.
  */
 void clocksource_mark_unstable(struct clocksource *cs)
 {
@@ -387,9 +408,7 @@ static void clocksource_dequeue_watchdog
 	}
 }
 
-static void __clocksource_change_rating(struct clocksource *cs, int rating);
-
-static int __clocksource_watchdog_work(void)
+static int __clocksource_watchdog_kthread(void)
 {
 	struct clocksource *cs, *tmp;
 	unsigned long flags;
@@ -414,12 +433,13 @@ static int __clocksource_watchdog_work(v
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
@@ -438,7 +458,7 @@ static void clocksource_enqueue_watchdog
 static void clocksource_select_watchdog(bool fallback) { }
 static inline void clocksource_dequeue_watchdog(struct clocksource *cs) { }
 static inline void clocksource_resume_watchdog(void) { }
-static inline int __clocksource_watchdog_work(void) { return 0; }
+static inline int __clocksource_watchdog_kthread(void) { return 0; }
 static bool clocksource_is_watchdog(struct clocksource *cs) { return false; }
 void clocksource_mark_unstable(struct clocksource *cs) { }
 
@@ -672,7 +692,7 @@ static int __init clocksource_done_booti
 	/*
 	 * Run the watchdog first to eliminate unstable clock sources
 	 */
-	__clocksource_watchdog_work();
+	__clocksource_watchdog_kthread();
 	clocksource_select();
 	mutex_unlock(&clocksource_mutex);
 	return 0;


