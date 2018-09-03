Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D30C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 09:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BFF320843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 09:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y5GqLK4R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BFF320843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbeICNwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 09:52:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51104 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbeICNwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 09:52:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=opsdBBcg4CJs9tFmxf8XaOeM/P3asWxXKo0fd0UudZ8=; b=Y5GqLK4Rd1v/XZ1u4GkWthb7g
        Z2D4vjatvUglBFpGigX0UW/O6Uof5PLR5t6uEvae0SuXX6EjFXvW6b9giPm3M+GcDKYKZM8JuvIkS
        fghsP28f1ZGDCYZpN0CholqlbQ3A/EnD63/Yev9IRkB4jrX4/R/zKhreK/yC64HE8pvgip0jp7uMU
        cojt3CvErVHF6x7sTnYmU2gB/JA1QH1syxkGzGK06c0wGY71oSOqvRpS5dkcZnBRCJnMwzqmWmZrT
        B17QcxAuG60OzTJ1jGUWY3C6bAfZ7oCRzesEl5TzHH5NDacYe36nz3siDgRRPtvvxXoTf5FCZP8+Q
        Ui113jLpw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fwlEK-0000z4-Li; Mon, 03 Sep 2018 09:33:09 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B0634202547F9; Mon,  3 Sep 2018 11:33:05 +0200 (CEST)
Date:   Mon, 3 Sep 2018 11:33:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kevin Shanahan <kevin@shanahan.id.au>,
        Siegfried Metz <frame@mailbox.org>,
        linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com,
        len.brown@intel.com, rjw@rjwysocki.net, diego.viola@gmail.com,
        rui.zhang@intel.com, viktor_jaegerskuepper@freenet.de
Subject: Re: REGRESSION: boot stalls on several old dual core Intel CPUs
Message-ID: <20180903093305.GC24142@hirez.programming.kicks-ass.net>
References: <74c5abc8-7430-5bc9-2f8a-a2205608bee7@mailbox.org>
 <20180830130439.GM24082@hirez.programming.kicks-ass.net>
 <20180901022125.GO4941@tuon.disenchant.local>
 <20180903072506.GS24124@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1809030937230.1349@nanos.tec.linutronix.de>
 <20180903085423.GU24124@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180903085423.GU24124@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 10:54:23AM +0200, Peter Zijlstra wrote:
> On Mon, Sep 03, 2018 at 09:38:15AM +0200, Thomas Gleixner wrote:
> > On Mon, 3 Sep 2018, Peter Zijlstra wrote:
> > > On Sat, Sep 01, 2018 at 11:51:26AM +0930, Kevin Shanahan wrote:
> > > > commit 01548f4d3e8e94caf323a4f664eb347fd34a34ab
> > > > Author: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > > > Date:   Tue Aug 18 17:09:42 2009 +0200
> > > > 
> > > >     clocksource: Avoid clocksource watchdog circular locking dependency
> > > > 
> > > >     stop_machine from a multithreaded workqueue is not allowed because
> > > >     of a circular locking dependency between cpu_down and the workqueue
> > > >     execution. Use a kernel thread to do the clocksource downgrade.
> > > 
> > > I cannot find stop_machine usage there; either it went away or I need to
> > > like wake up.
> > 
> > timekeeping_notify() which is involved in switching clock source uses stomp
> > machine.
> 
> ARGH... OK, lemme see if I can come up with something other than
> endlessly spawning that kthread.
> 
> A special purpose kthread_worker would make more sense than that.

Can someone test this?

---
 kernel/time/clocksource.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index f74fb00d8064..898976d0082a 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -112,13 +112,28 @@ static int finished_booting;
 static u64 suspend_start;
 
 #ifdef CONFIG_CLOCKSOURCE_WATCHDOG
-static void clocksource_watchdog_work(struct work_struct *work);
+static void clocksource_watchdog_work(struct kthread_work *work);
 static void clocksource_select(void);
 
 static LIST_HEAD(watchdog_list);
 static struct clocksource *watchdog;
 static struct timer_list watchdog_timer;
-static DECLARE_WORK(watchdog_work, clocksource_watchdog_work);
+
+/*
+ * We must use a kthread_worker here, because:
+ *
+ *   clocksource_watchdog_work()
+ *     clocksource_select()
+ *       __clocksource_select()
+ *         timekeeping_notify()
+ *           stop_machine()
+ *
+ * cannot be called from a reqular workqueue, because of deadlocks between
+ * workqueue and stopmachine.
+ */
+static struct kthread_worker *watchdog_worker;
+static DEFINE_KTHREAD_WORK(watchdog_work, clocksource_watchdog_work);
+
 static DEFINE_SPINLOCK(watchdog_lock);
 static int watchdog_running;
 static atomic_t watchdog_reset_pending;
@@ -158,7 +173,7 @@ static void __clocksource_unstable(struct clocksource *cs)
 
 	/* kick clocksource_watchdog_work() */
 	if (finished_booting)
-		schedule_work(&watchdog_work);
+		kthread_queue_work(watchdog_worker, &watchdog_work);
 }
 
 /**
@@ -199,7 +214,7 @@ static void clocksource_watchdog(struct timer_list *unused)
 		/* Clocksource already marked unstable? */
 		if (cs->flags & CLOCK_SOURCE_UNSTABLE) {
 			if (finished_booting)
-				schedule_work(&watchdog_work);
+				kthread_queue_work(watchdog_worker, &watchdog_work);
 			continue;
 		}
 
@@ -269,7 +284,7 @@ static void clocksource_watchdog(struct timer_list *unused)
 			 */
 			if (cs != curr_clocksource) {
 				cs->flags |= CLOCK_SOURCE_RESELECT;
-				schedule_work(&watchdog_work);
+				kthread_queue_work(watchdog_worker, &watchdog_work);
 			} else {
 				tick_clock_notify();
 			}
@@ -418,7 +433,7 @@ static int __clocksource_watchdog_work(void)
 	return select;
 }
 
-static void clocksource_watchdog_work(struct work_struct *work)
+static void clocksource_watchdog_work(struct kthread_work *work)
 {
 	mutex_lock(&clocksource_mutex);
 	if (__clocksource_watchdog_work())
@@ -806,6 +821,7 @@ static int __init clocksource_done_booting(void)
 {
 	mutex_lock(&clocksource_mutex);
 	curr_clocksource = clocksource_default_clock();
+	watchdog_worker = kthread_create_worker(0, "cs-watchdog");
 	finished_booting = 1;
 	/*
 	 * Run the watchdog first to eliminate unstable clock sources
