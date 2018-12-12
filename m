Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53A8C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7158C2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="hxVifcbT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7158C2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbeLLK1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:27:02 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42286 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbeLLK1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 05:27:01 -0500
Received: by mail-ed1-f67.google.com with SMTP id j6so15071545edp.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 02:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=oLSNPA3/9UENkYRpSsrZU42VVYNLtub/x8vrizd4AO4=;
        b=hxVifcbTokxv1Bl8kF/YFZYictX03q0l//sF4rxf2dmnXhHoWKPO0KaA55lVY/PBF0
         eJcDumzMW7Ea4x1UZ8gmoB9Y6xLKcMqUNae8qFxnKjAYxcoeR+sOoailpflUUR7+vHTN
         4nDcRixEIQhJEYkmyPPcDfGrCEqirqi6zHqUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=oLSNPA3/9UENkYRpSsrZU42VVYNLtub/x8vrizd4AO4=;
        b=afkO08aH9jnXqzWc3FygCvXw8D8P/hAODvOhHHGMDXJ5I09iADKo1ArM9iolgnwIbf
         7LwVuBR/zsNLJ6LXIqJ78vxAdHwsrYnfdvyNdIpjgEwRFSl6kWXjhOg95osBWZ/BSvY4
         vAN5SFRIZXc4/aDBDq95mCRNGlzsorYRhA8Nim9Es06MWzep/BmmqlAuPpVm0va+BcN0
         lhZ75W2h8yzjJudDLSa+uevrtyn8a5C+3IbQBooETxlRIcHqkxGHhmjit8jLGl1lnQBZ
         MzjWqXTjhkReoqxdj4nxodLWygp9MRVy+vZJ68HZWRAW9G5YAqxrGkvAPbjaxOX0rqG/
         2vBg==
X-Gm-Message-State: AA+aEWabj8S4RJ2x7vOwTvrynmm4Cc7C7E2NM6zjiXk0dUVoI1ce9yxl
        XNikfHP+DJLAD6fAJ8DZiyLWvg==
X-Google-Smtp-Source: AFSGD/WBtwskrBbq2AwQLWJazWmiI3n7wTvxjHAyjBBFBpovd8Y/OsrWSiZ9m6DFCXUgKoZNcMqIXA==
X-Received: by 2002:a05:6402:8d2:: with SMTP id d18mr9769490edz.119.1544610419782;
        Wed, 12 Dec 2018 02:26:59 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id f4sm4829230edb.21.2018.12.12.02.26.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 02:26:58 -0800 (PST)
Date:   Wed, 12 Dec 2018 11:26:56 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 2/4] kernel.h: Add non_block_start/end()
Message-ID: <20181212102656.GS21184@phenom.ffwll.local>
Mail-Followup-To: Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>
References: <20181210103641.31259-1-daniel.vetter@ffwll.ch>
 <20181210103641.31259-3-daniel.vetter@ffwll.ch>
 <20181210141337.GQ1286@dhcp22.suse.cz>
 <20181210144711.GN5289@hirez.programming.kicks-ass.net>
 <20181210150159.GR1286@dhcp22.suse.cz>
 <20181210152253.GP5289@hirez.programming.kicks-ass.net>
 <20181210162010.GS1286@dhcp22.suse.cz>
 <20181210163009.GR5289@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210163009.GR5289@hirez.programming.kicks-ass.net>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 05:30:09PM +0100, Peter Zijlstra wrote:
> On Mon, Dec 10, 2018 at 05:20:10PM +0100, Michal Hocko wrote:
> > > OK, no real objections to the thing.  Just so long we're all on the same
> > > page as to what it does and doesn't do ;-)
> > 
> > I am not really sure whether there are other potential users besides
> > this one and whether the check as such is justified.
> 
> It's a debug option...
> 
> > > I suppose you could extend the check to include schedule_debug() as
> > > well, maybe something like:
> > 
> > Do you mean to make the check cheaper?
> 
> Nah, so the patch only touched might_sleep(), the below touches
> schedule().
> 
> If there were a patch that hits schedule() without going through a
> might_sleep() (rare in practise I think, but entirely possible) then you
> won't get a splat without something like the below on top.

We have a bunch of schedule() calls in i915, for e.g. waiting for multiple
events at the same time (when we want to unblock if any of them fire). And
there's no might_sleep in these cases afaict. Adding the check in
schedule() sounds useful, I'll include your snippet in v2. Plus try a bit
better to explain in the commit message why Michal suggested these.

Thanks, Daniel

> 
> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > index f66920173370..b1aaa278f1af 100644
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -3278,13 +3278,18 @@ static noinline void __schedule_bug(struct task_struct *prev)
> > >  /*
> > >   * Various schedule()-time debugging checks and statistics:
> > >   */
> > > -static inline void schedule_debug(struct task_struct *prev)
> > > +static inline void schedule_debug(struct task_struct *prev, bool preempt)
> > >  {
> > >  #ifdef CONFIG_SCHED_STACK_END_CHECK
> > >  	if (task_stack_end_corrupted(prev))
> > >  		panic("corrupted stack end detected inside scheduler\n");
> > >  #endif
> > >  
> > > +#ifdef CONFIG_DEBUG_ATOMIC_SLEEP
> > > +	if (!preempt && prev->state && prev->non_block_count)
> > > +		// splat
> > > +#endif
> > > +
> > >  	if (unlikely(in_atomic_preempt_off())) {
> > >  		__schedule_bug(prev);
> > >  		preempt_count_set(PREEMPT_DISABLED);
> > > @@ -3391,7 +3396,7 @@ static void __sched notrace __schedule(bool preempt)
> > >  	rq = cpu_rq(cpu);
> > >  	prev = rq->curr;
> > >  
> > > -	schedule_debug(prev);
> > > +	schedule_debug(prev, preempt);
> > >  
> > >  	if (sched_feat(HRTICK))
> > >  		hrtick_clear(rq);
> > 
> > -- 
> > Michal Hocko
> > SUSE Labs

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
