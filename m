Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7934C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C2FF2083C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UrDHjrqH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C2FF2083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbeJPRkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 13:40:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52676 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbeJPRkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 13:40:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZZRDi0AjdzF8tHWmAMnIdoX7YoLwRyOdaRpRaARwdhY=; b=UrDHjrqHqKdPan/fLM572EdPB
        sqsEEhVS/D/vwEGl4kTNx52qHjwAuA6mAfJjLuvo/6wJHsJb9ao2i9+hMS0uZgU8QsXQLu4YdhsSh
        GEl2mGND0KpY7NkDBfbJxkKZB9VskdR8sPLRhNXxjaep/MgSkLhtmCWcVX1b5bVOgcsTiTSauvj5F
        yvmjNwFillwAwTnYFOLiXrkNUvRgCRm32rdqS/H6DC77q9PqSuzpZ0wdoH3A5bzi9005DalI9556q
        2LU5KHKnSGLCrMijE06UBpa926OuM/hcABsk9mUDStVWouGAY0yGInT+bnU3Mu34dRILG7TzggJqP
        107t7Cjsg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gCM0B-0002NE-J1; Tue, 16 Oct 2018 09:50:59 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E752520295866; Tue, 16 Oct 2018 11:50:56 +0200 (CEST)
Date:   Tue, 16 Oct 2018 11:50:56 +0200
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
Message-ID: <20181016095056.GE4030@hirez.programming.kicks-ass.net>
References: <20181010104559.GO5728@hirez.programming.kicks-ass.net>
 <D2014055-9B25-4152-A582-7AD42A3837AB@fb.com>
 <20181011092913.GA9848@hirez.programming.kicks-ass.net>
 <70079805-1CAE-4CAA-813A-F8DDB929F22B@fb.com>
 <20181012095001.GG9867@hirez.programming.kicks-ass.net>
 <E4F81A5E-C371-429D-AFEC-6F4B32971F09@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E4F81A5E-C371-429D-AFEC-6F4B32971F09@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2018 at 08:31:37AM +0000, Song Liu wrote:

> The only suggestion I have right now is on which struct owns which
> data:
> 
> 1. perf_cpu_context owns two perf_event_context: ctx and *task_ctx. 
>    This is the same as right now. 

> 2. perf_event_context owns multiple perf_event_pmu_context: 
>    One perf_event_pmu_context for software groups;
>    One perf_event_pmu_context for each hardware PMU.

It does now already, right? Through the pmu_ctx_list we can, given an
perf_event_context, find all associated perf_event_pmu_context's.

> 3. perf_event_pmu_context owns RB tree of events. Since we don't 
>    need rotation across multiple hardware PMUs, the rotation is 
>    within same perf_event_pmu_context.  

By keeping the RB trees in perf_event_context, we get bigger trees,
which is more efficient (log(n+m) < log(n) + log(m))

Also, specifically, it means we only need a single merge sort /
iteration to schedule in a full context, instead of (again) doing 'n' of
them.

Also, given a context and a pmu, it is cheaper for finding the relevant
events; this is needed for big.little for instance. Something the
proposed patch doesn't fully flesh out.

> 4. perf_cpu_context owns multiple perf_cpu_pmu_context:
>    One perf_cpu_pmu_context for each hardware PMU.

What would we need that relation for?

>    perf_cpu_pmu_context is tot needed for software only groups(?).

Yes, that is a very good question; it mostly centers around what we want
to do with perf_event_attr::exclusive for software events -- which is
currently dodgy at best.

Also, allocating the structure and keeping it around is probably less
code than explicitly not doing it.

> 5. perf_cpu_pmu_context has two pointers of perf_event_pmu_context.

Instead of embedding the thing? Yeah, not sure. Either way around we'd
not want to free the CPU perf_event_pmu_context that is associated with
the perf_cpu_pmu_context, and embedding it saves a pointer chase.

Not sure it actually makes a lot of difference either way around.
