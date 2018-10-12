Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D1BC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB83920835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hw5i/1q+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB83920835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbeJLV64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 17:58:56 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34470 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728577AbeJLV64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 17:58:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ilD/+Ok8DR5OqHlla8+QaoA1uVEBgcr1s9j5B/Oxq08=; b=hw5i/1q+YmVQrH6SNapiHgCiV
        suwWC+sCWsdxjgSKhA2xV/wRtUHxhV+855puvmH0pTqQB5iOCDrQUOxQJXs6yAQwsLoDauWGFQipz
        553exRj5gVgN2p6Fyh+lVDyuyXWM/2N4PG/DBR79ii6HTyGxKF+g6otAHhyUSCitPVFDnxiVNxjrt
        WL76U6VKLRLKA7dzmO8PqwJ/WGuEfS4Kt2EpOonDkWf2yvev00sTTLpiCKcafE3tqCBU2MbPw0/Mo
        4sOlS4FLPsM98SeFqFzgc2DkLQVH4kK1bzTA4S6TA33RKm0S57ifanbcQEDa+LqjHp64vKtZX9U/9
        kmBLMOCaw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gAyO6-0001Lq-Ut; Fri, 12 Oct 2018 14:25:59 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5D1F32029856B; Fri, 12 Oct 2018 16:25:56 +0200 (CEST)
Date:   Fri, 12 Oct 2018 16:25:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "eranian@google.com" <eranian@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "alexey.budankov@linux.intel.com" <alexey.budankov@linux.intel.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "megha.dey@intel.com" <megha.dey@intel.com>,
        "frederic@kernel.org" <frederic@kernel.org>
Subject: Re: [RFC][PATCH] perf: Rewrite core context handling
Message-ID: <20181012142556.GD9885@hirez.programming.kicks-ass.net>
References: <20181010104559.GO5728@hirez.programming.kicks-ass.net>
 <D2014055-9B25-4152-A582-7AD42A3837AB@fb.com>
 <20181011092913.GA9848@hirez.programming.kicks-ass.net>
 <70079805-1CAE-4CAA-813A-F8DDB929F22B@fb.com>
 <20181012095001.GG9867@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012095001.GG9867@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 11:50:01AM +0200, Peter Zijlstra wrote:
> 
> Can we please not top-post?
> 
> On Thu, Oct 11, 2018 at 10:37:14PM +0000, Song Liu wrote:
> > Thanks Peter! These are really really helpful. 
> > 
> > I am trying to think through the case of a group of two events on two 
> > separate hardware PMUs. In current implementation, this will not trigger
> > move_group,
> 
> Right, currently this is disallowed (or should be, I'll need to double
> check the code).
> 
> > so they will not be able to rotate together? And actually, 
> > they may not be able to run at all? Maybe this case is never supported? 
> 
> Indeed, we do not allow mixing events of different PMUs, with the
> explicit exception of software events. Since software events must always
> schedule, they're allowed to be fitted into any group.
> 
> > On the other hand, would something like this work:
> > 
> >     perf_cpu_context <-[1:2]-> perf_event_context <-[1:n]-> perf_event 
> >               |                                                |
> >               `----[1:n]---->     pmu    <----- [1:n]----------' 
> > 
> > 1. Every cpu has only one perf_cpu_context. No perf_cpu_pmu_context. 
> 
> The perf_event_pmu_context is currently needed to efficiently track
> which events are active. And to determine if rotation is needed at all.
> 
> And the perf_cpu_pmu_context is needed because the rotation is per PMU
> in ABI.
> 
> > 2. perf_cpu_context has two perf_event_context, one for the cpu, the 
> >    other for the task. 
> 
> That doesn't work (or I'm not understanding), tasks come and go on CPUs,
> at best it has a reference to the current active task's context. But it
> already had that, and it still does, see perf_cpu_context::task_ctx.
> 
> > 3. Each perf_event_context has 3 perf_event_groups, pinned_groups, 
> >    flexible_groups, and software_groups (for sw event only groups). 
> 
> So I'm thinking you want to split off the software groups because they
> don't need rotation?
> 
> While doing this patch I noticed that we need to ignore attr.exclusive
> for software events. Not sure that was intentional or not, but certainly
> inconsistent.

That sentence is confused; what I meant to say was that I noticed that
attr.exclusive for software events is currently confused.

> > 4. All flexible_groups of the same cpu rotate a the same time. If 
> >    there are two hardware PMUs on the cpu, the rotation will look 
> >    like: 1) stop both PMUs; 2) rotate events; 3) start both PMUs. 
> 
> ABI precludes that currently, we have per PMU rotation intervals exposed
> in sysfs.
> 
> > I feel this will make the implementation simpler. Is it too broken in 
> > some cases? Or did I miss anything obvious? One thing I noticed is 
> > that we need to drop per PMU config perf_event_mux_interval_ms. 
> 
> Right that. People added that for a reason (although it eludes me atm).
> I don't think we can drop that easily.
