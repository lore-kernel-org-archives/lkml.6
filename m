Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B354C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E43E62087E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oEDSOGHs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbfAHJGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:06:33 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46378 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbfAHJGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:06:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ryh1lPF7s9cjCauzgCbtcNSiQDTUySQZy1OBSikJmzY=; b=oEDSOGHstqhLc5IbX2mpa5Bnq
        89+v8ZJ1zd84ucp2d5qs3TBCKbgDlMpHnUvmoCfGOcE3V7ktvGvav0ak99DrKSwRtNgFjYFbw7KHI
        wpiWQgowdPEZ9D0pLbV8IMkIF+ZY1KxLTtmBNlTl2piprev/CcoXT1H0mwyUJoBeMDSKZzE3/ZLHW
        AUn3TAkxMa84IsXXGp1XCtIYobnaXqSAZ9+E0XYrqVTeiL9r+x+djgHt0pdVov5jDKqR82gYDnVNf
        NbnF+VRROJM7AKwtwYjR1lauywwC1WHsfg18rsnHE21syxzz7bnrsdJaT0ViBX8GhN8S0tWD9xXQg
        54+prWGEw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ggnL9-0003e5-0Y; Tue, 08 Jan 2019 09:06:27 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 318CB20074A04; Tue,  8 Jan 2019 10:06:25 +0100 (CET)
Date:   Tue, 8 Jan 2019 10:06:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Tom Putzeys <tom.putzeys@be.atlascopco.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: CFS scheduler: spin_lock usage causes dead lock when
 smp_apic_timer_interrupt occurs
Message-ID: <20190108090625.GN15430@hirez.programming.kicks-ass.net>
References: <AM0PR03MB480425D5999E0D08DAB30204BB8E0@AM0PR03MB4804.eurprd03.prod.outlook.com>
 <AM0PR03MB4804FA468B7A006AEEA8592ABB8E0@AM0PR03MB4804.eurprd03.prod.outlook.com>
 <20190107102613.GC2861@worktop.programming.kicks-ass.net>
 <1546864114.26963.5.camel@gmx.de>
 <20190107125231.GE14122@hirez.programming.kicks-ass.net>
 <1546925459.17252.2.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546925459.17252.2.camel@gmx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 06:30:59AM +0100, Mike Galbraith wrote:
> On Mon, 2019-01-07 at 13:52 +0100, Peter Zijlstra wrote:
> > On Mon, Jan 07, 2019 at 01:28:34PM +0100, Mike Galbraith wrote:
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 960ad0ce77d7..420624c49f38 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -5007,9 +5007,9 @@ void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
> > >  	cfs_b->period = ns_to_ktime(default_cfs_period());
> > >  
> > >  	INIT_LIST_HEAD(&cfs_b->throttled_cfs_rq);
> > > -	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED);
> > > +	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
> > >  	cfs_b->period_timer.function = sched_cfs_period_timer;
> > > -	hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> > > +	hrtimer_init(&cfs_b->slack_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
> > >  	cfs_b->slack_timer.function = sched_cfs_slack_timer;
> > >  }
> > 
> > Right, that should sort it. But I'm not sure this is the best solution
> > though. That cfs-runtime crud can (IIRC) iterate lists etc.. so running
> > it from the softirq isn't a bad idea. We just need to fix that locking
> > up a bit.
> > 
> > Something a wee bit like so perhaps..
> 
> I plugged that into 4.19-rt along with revert of hard irq context, and
> it (as expected) does the trick.

Much appreciated; I queued it as the below.

---
Subject: sched/fair: Robustify CFS-bandwidth timer locking
From: Peter Zijlstra <peterz@infradead.org>
Date: Mon, 7 Jan 2019 13:52:31 +0100

Traditionally hrtimer callbacks were run with IRQs disabled, but with
the introduction of HRTIMER_MODE_SOFT it is possible they run from
SoftIRQ context, which does _NOT_ have IRQs disabled.

Allow for the CFS bandwidth timers (period_timer and slack_timer) to
be ran from SoftIRQ context; this entails removing the assumption that
IRQs are already disabled from the locking.

While mainline doesn't strictly need this, -RT forces all timers not
explicitly marked with MODE_HARD into MODE_SOFT and trips over this.
And marking these timers as MODE_HARD doesn't make sense as they're
not required for RT operation and can potentially be quite expensive.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reported-by: Tom Putzeys <tom.putzeys@be.atlascopco.com>
Tested-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190107125231.GE14122@hirez.programming.kicks-ass.net
---
 kernel/sched/fair.c |   30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4566,7 +4566,7 @@ static u64 distribute_cfs_runtime(struct
 		struct rq *rq = rq_of(cfs_rq);
 		struct rq_flags rf;
 
-		rq_lock(rq, &rf);
+		rq_lock_irqsave(rq, &rf);
 		if (!cfs_rq_throttled(cfs_rq))
 			goto next;
 
@@ -4583,7 +4583,7 @@ static u64 distribute_cfs_runtime(struct
 			unthrottle_cfs_rq(cfs_rq);
 
 next:
-		rq_unlock(rq, &rf);
+		rq_unlock_irqrestore(rq, &rf);
 
 		if (!remaining)
 			break;
@@ -4599,7 +4599,7 @@ static u64 distribute_cfs_runtime(struct
  * period the timer is deactivated until scheduling resumes; cfs_b->idle is
  * used to track this state.
  */
-static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun)
+static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun, unsigned long flags)
 {
 	u64 runtime, runtime_expires;
 	int throttled;
@@ -4641,11 +4641,11 @@ static int do_sched_cfs_period_timer(str
 	while (throttled && cfs_b->runtime > 0 && !cfs_b->distribute_running) {
 		runtime = cfs_b->runtime;
 		cfs_b->distribute_running = 1;
-		raw_spin_unlock(&cfs_b->lock);
+		raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
 		/* we can't nest cfs_b->lock while distributing bandwidth */
 		runtime = distribute_cfs_runtime(cfs_b, runtime,
 						 runtime_expires);
-		raw_spin_lock(&cfs_b->lock);
+		raw_spin_lock_irqsave(&cfs_b->lock, flags);
 
 		cfs_b->distribute_running = 0;
 		throttled = !list_empty(&cfs_b->throttled_cfs_rq);
@@ -4754,17 +4754,18 @@ static __always_inline void return_cfs_r
 static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
 {
 	u64 runtime = 0, slice = sched_cfs_bandwidth_slice();
+	unsigned long flags;
 	u64 expires;
 
 	/* confirm we're still not at a refresh boundary */
-	raw_spin_lock(&cfs_b->lock);
+	raw_spin_lock_irqsave(&cfs_b->lock, flags);
 	if (cfs_b->distribute_running) {
-		raw_spin_unlock(&cfs_b->lock);
+		raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
 		return;
 	}
 
 	if (runtime_refresh_within(cfs_b, min_bandwidth_expiration)) {
-		raw_spin_unlock(&cfs_b->lock);
+		raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
 		return;
 	}
 
@@ -4775,18 +4776,18 @@ static void do_sched_cfs_slack_timer(str
 	if (runtime)
 		cfs_b->distribute_running = 1;
 
-	raw_spin_unlock(&cfs_b->lock);
+	raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
 
 	if (!runtime)
 		return;
 
 	runtime = distribute_cfs_runtime(cfs_b, runtime, expires);
 
-	raw_spin_lock(&cfs_b->lock);
+	raw_spin_lock_irqsave(&cfs_b->lock, flags);
 	if (expires == cfs_b->runtime_expires)
 		lsub_positive(&cfs_b->runtime, runtime);
 	cfs_b->distribute_running = 0;
-	raw_spin_unlock(&cfs_b->lock);
+	raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
 }
 
 /*
@@ -4864,20 +4865,21 @@ static enum hrtimer_restart sched_cfs_pe
 {
 	struct cfs_bandwidth *cfs_b =
 		container_of(timer, struct cfs_bandwidth, period_timer);
+	unsigned long flags;
 	int overrun;
 	int idle = 0;
 
-	raw_spin_lock(&cfs_b->lock);
+	raw_spin_lock_irqsave(&cfs_b->lock, flags);
 	for (;;) {
 		overrun = hrtimer_forward_now(timer, cfs_b->period);
 		if (!overrun)
 			break;
 
-		idle = do_sched_cfs_period_timer(cfs_b, overrun);
+		idle = do_sched_cfs_period_timer(cfs_b, overrun, flags);
 	}
 	if (idle)
 		cfs_b->period_active = 0;
-	raw_spin_unlock(&cfs_b->lock);
+	raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
 
 	return idle ? HRTIMER_NORESTART : HRTIMER_RESTART;
 }
