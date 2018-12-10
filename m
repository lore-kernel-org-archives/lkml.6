Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EDCC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3425820870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PnMRjqZl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3425820870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbeLJQaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:30:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36242 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728363AbeLJQaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:30:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zEsOiUzkbEW8saZNsMSivBg6BdsTy4R+5g/ZTmLpSgg=; b=PnMRjqZleQwDHG5nYauUuOaIC
        s7cheZD42BFjMIg2W0DR3cYKGiUJP/gXgO1OZEMTYWKPWm3Z//9mE7jX+nlX5vd7Ur5IcVYAL/J5F
        GaucJwMOsXhUgDO8/vgEZLIl/nK8NRNmtrkhcIGwS6oQevanwWvhKyi85UVdm++8MMdjFrlb3UYR4
        /nakFjPfS87rtNRxV+0xRe1mtPd3vM4Mn7k6r+JY0R8BWB4MC3u59cBOWw8i7YWIUkDRH2nQ8k9wB
        oB1OwarPG8XcKNC/eS6VwuJkqe4l5enZeldadJjb9w6AQ4jg7XaEXrb5v4K2osx+wpeDqGYUpbJRy
        smFMLb3eQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gWORf-0001fB-D8; Mon, 10 Dec 2018 16:30:11 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 109CD2075BD14; Mon, 10 Dec 2018 17:30:09 +0100 (CET)
Date:   Mon, 10 Dec 2018 17:30:09 +0100
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
Message-ID: <20181210163009.GR5289@hirez.programming.kicks-ass.net>
References: <20181210103641.31259-1-daniel.vetter@ffwll.ch>
 <20181210103641.31259-3-daniel.vetter@ffwll.ch>
 <20181210141337.GQ1286@dhcp22.suse.cz>
 <20181210144711.GN5289@hirez.programming.kicks-ass.net>
 <20181210150159.GR1286@dhcp22.suse.cz>
 <20181210152253.GP5289@hirez.programming.kicks-ass.net>
 <20181210162010.GS1286@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210162010.GS1286@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 05:20:10PM +0100, Michal Hocko wrote:
> > OK, no real objections to the thing.  Just so long we're all on the same
> > page as to what it does and doesn't do ;-)
> 
> I am not really sure whether there are other potential users besides
> this one and whether the check as such is justified.

It's a debug option...

> > I suppose you could extend the check to include schedule_debug() as
> > well, maybe something like:
> 
> Do you mean to make the check cheaper?

Nah, so the patch only touched might_sleep(), the below touches
schedule().

If there were a patch that hits schedule() without going through a
might_sleep() (rare in practise I think, but entirely possible) then you
won't get a splat without something like the below on top.

> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index f66920173370..b1aaa278f1af 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -3278,13 +3278,18 @@ static noinline void __schedule_bug(struct task_struct *prev)
> >  /*
> >   * Various schedule()-time debugging checks and statistics:
> >   */
> > -static inline void schedule_debug(struct task_struct *prev)
> > +static inline void schedule_debug(struct task_struct *prev, bool preempt)
> >  {
> >  #ifdef CONFIG_SCHED_STACK_END_CHECK
> >  	if (task_stack_end_corrupted(prev))
> >  		panic("corrupted stack end detected inside scheduler\n");
> >  #endif
> >  
> > +#ifdef CONFIG_DEBUG_ATOMIC_SLEEP
> > +	if (!preempt && prev->state && prev->non_block_count)
> > +		// splat
> > +#endif
> > +
> >  	if (unlikely(in_atomic_preempt_off())) {
> >  		__schedule_bug(prev);
> >  		preempt_count_set(PREEMPT_DISABLED);
> > @@ -3391,7 +3396,7 @@ static void __sched notrace __schedule(bool preempt)
> >  	rq = cpu_rq(cpu);
> >  	prev = rq->curr;
> >  
> > -	schedule_debug(prev);
> > +	schedule_debug(prev, preempt);
> >  
> >  	if (sched_feat(HRTICK))
> >  		hrtick_clear(rq);
> 
> -- 
> Michal Hocko
> SUSE Labs
