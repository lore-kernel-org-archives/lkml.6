Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89187C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4192220672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Rp8SngUn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4192220672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbeLJPXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 10:23:14 -0500
Received: from merlin.infradead.org ([205.233.59.134]:59494 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbeLJPXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 10:23:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kXpq786DztAemNMUfzVL7pdbgH5/KMDjLmlT63VZR8A=; b=Rp8SngUnXrLLMWj55QSshqhQZ
        YnPRNHhDVqirkuRFj8KSO2DoUN2YscIcxVy21Q7qusM9ZXQKeV7h/eW/tjGe6o4KnmIs9NGaTaUrF
        2X2r5aHwyE0wZ9ayZD/VoX3iZx+x6VAVJwAuRi7iNQPjwrL3zFLtChsgfIX/vnlZbCYuU7LGd0qNf
        UgsG8x9uBlEoDP9FZAZ5k9lNDKHpIE8daB7EPN/yXJO9UtuDvjX3pjsrjWvxlscLZCOXr2gfaUnNg
        snTW3JhHG+9+uY/L5T6lK66309icxV4EwmBNzgRKGl77jUIOJ/nPQgedHSY1UO+F8882u7C81c8ga
        DL4TmCasA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gWNOa-0004cu-Im; Mon, 10 Dec 2018 15:22:57 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F31422075BD0C; Mon, 10 Dec 2018 16:22:53 +0100 (CET)
Date:   Mon, 10 Dec 2018 16:22:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 2/4] kernel.h: Add non_block_start/end()
Message-ID: <20181210152253.GP5289@hirez.programming.kicks-ass.net>
References: <20181210103641.31259-1-daniel.vetter@ffwll.ch>
 <20181210103641.31259-3-daniel.vetter@ffwll.ch>
 <20181210141337.GQ1286@dhcp22.suse.cz>
 <20181210144711.GN5289@hirez.programming.kicks-ass.net>
 <20181210150159.GR1286@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210150159.GR1286@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 04:01:59PM +0100, Michal Hocko wrote:
> On Mon 10-12-18 15:47:11, Peter Zijlstra wrote:
> > On Mon, Dec 10, 2018 at 03:13:37PM +0100, Michal Hocko wrote:
> > > I do not see any scheduler guys Cced and it would be really great to get
> > > their opinion here.
> > > 
> > > On Mon 10-12-18 11:36:39, Daniel Vetter wrote:
> > > > In some special cases we must not block, but there's not a
> > > > spinlock, preempt-off, irqs-off or similar critical section already
> > > > that arms the might_sleep() debug checks. Add a non_block_start/end()
> > > > pair to annotate these.
> > > > 
> > > > This will be used in the oom paths of mmu-notifiers, where blocking is
> > > > not allowed to make sure there's forward progress.
> > > 
> > > Considering the only alternative would be to abuse
> > > preempt_{disable,enable}, and that really has a different semantic, I
> > > think this makes some sense. The cotext is preemptible but we do not
> > > want notifier to sleep on any locks, WQ etc.
> > 
> > I'm confused... what is this supposed to do?
> > 
> > And what does 'block' mean here? Without preempt_disable/IRQ-off we're
> > subject to regular preemption and execution can stall for arbitrary
> > amounts of time.
> 
> The notifier is called from quite a restricted context - oom_reaper - 
> which shouldn't depend on any locks or sleepable conditionals. 

You want to exclude spinlocks too? We could maybe frob something with
lockdep if you need that?

> The code
> should be swift as well but we mostly do care about it to make a forward
> progress. Checking for sleepable context is the best thing we could come
> up with that would describe these demands at least partially.

OK, no real objections to the thing.  Just so long we're all on the same
page as to what it does and doesn't do ;-)

I suppose you could extend the check to include schedule_debug() as
well, maybe something like:

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f66920173370..b1aaa278f1af 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3278,13 +3278,18 @@ static noinline void __schedule_bug(struct task_struct *prev)
 /*
  * Various schedule()-time debugging checks and statistics:
  */
-static inline void schedule_debug(struct task_struct *prev)
+static inline void schedule_debug(struct task_struct *prev, bool preempt)
 {
 #ifdef CONFIG_SCHED_STACK_END_CHECK
 	if (task_stack_end_corrupted(prev))
 		panic("corrupted stack end detected inside scheduler\n");
 #endif
 
+#ifdef CONFIG_DEBUG_ATOMIC_SLEEP
+	if (!preempt && prev->state && prev->non_block_count)
+		// splat
+#endif
+
 	if (unlikely(in_atomic_preempt_off())) {
 		__schedule_bug(prev);
 		preempt_count_set(PREEMPT_DISABLED);
@@ -3391,7 +3396,7 @@ static void __sched notrace __schedule(bool preempt)
 	rq = cpu_rq(cpu);
 	prev = rq->curr;
 
-	schedule_debug(prev);
+	schedule_debug(prev, preempt);
 
 	if (sched_feat(HRTICK))
 		hrtick_clear(rq);

