Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49031C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFA9D2064D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t/7KFJ7n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFA9D2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbeIENLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 09:11:33 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58300 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbeIENLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 09:11:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EV5mjUDfDqZzsNbmaiaPxT8o+PyQBvvsBSCq0GJQao8=; b=t/7KFJ7nGMeYnleKhtJ+C4UFi
        FfFibzkaUGdbHfeuhq3FlKwk0Rlsg8PA4dU0xvKNKht5KQ1dNplvV3UEt/Ygysj2wOiUBu+YP8jpn
        50a1f9qz91Hfzgbx26LyO+s+xZwYZ5rzM++mwXxQNYnErIwLv/976WKqNFxgeiG5MYcKqPaWqSv+g
        hulKivgi7dPui6IxQ8BCU7P2tB2tZRZb/d0RcvltavteBTyyX8PX8g4FNwvrG6RVE8TUO481+EACZ
        q63BGR9XXWRynJW2qm4Jh5Kaq+dODEOdb0lc+oeB6O6AK+bG4nq1OK2oufWJ8MsZSGhMelg+oMZke
        pQ2EJ7T7g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fxTNw-0003z9-Cx; Wed, 05 Sep 2018 08:42:00 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BF31C20191BFD; Wed,  5 Sep 2018 10:41:58 +0200 (CEST)
Date:   Wed, 5 Sep 2018 10:41:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kevin Shanahan <kevin@shanahan.id.au>,
        Siegfried Metz <frame@mailbox.org>,
        linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com,
        len.brown@intel.com, rjw@rjwysocki.net, diego.viola@gmail.com,
        rui.zhang@intel.com, viktor_jaegerskuepper@freenet.de,
        niklas.cassel@linaro.org, bjorn.andersson@linaro.org
Subject: [PATCH] clocksource: Revert "Remove kthread"
Message-ID: <20180905084158.GR24124@hirez.programming.kicks-ass.net>
References: <74c5abc8-7430-5bc9-2f8a-a2205608bee7@mailbox.org>
 <20180830130439.GM24082@hirez.programming.kicks-ass.net>
 <20180901022125.GO4941@tuon.disenchant.local>
 <20180903072506.GS24124@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1809030937230.1349@nanos.tec.linutronix.de>
 <20180903085423.GU24124@hirez.programming.kicks-ass.net>
 <20180903093305.GC24142@hirez.programming.kicks-ass.net>
 <20180904134450.GA10572@centauri.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180904134450.GA10572@centauri.lan>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 03:44:50PM +0200, Niklas Cassel wrote:
> watchdog_worker is only defined if CONFIG_CLOCKSOURCE_WATCHDOG is set,
> so you might want to wrap it with an ifdef to avoid build errors.

Yes, so I wrote a version that only spawned the kthread_worker when a
MUST_VERIFY clocksource was registered -- which turned out to be a lot
harder than it sounds, because clocksource registration happens _waaay_
before kthreadd gets spawned.

But after I finished that I realized that this work only ever runs once
or twice during the lifetime of the kernel. So spawning a permanent
thread is quite pointless.

So lets just revert the patch and add a wee comment there explaining why
we spawn the kthread.

---
Subject: clocksource: Revert "Remove kthread"

It turns out that the silly spawn kthread from worker was actually
needed, revert the patch but add a comment that explain why we jump
through such apparently silly hoops.

Fixes: 7197e77abcb6 ("clocksource: Remove kthread")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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
