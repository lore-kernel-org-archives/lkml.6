Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DA4C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBD1020869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tyej7czQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBD1020869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbeJPRWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 13:22:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38786 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbeJPRWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 13:22:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jyzZiCCNvpS/s8C/w/jAP1Z86vePcFBHR/zxl3boWHc=; b=tyej7czQha1Ni35wyiqPwhse3
        hSuyw3m0KTEK3dPP5PBDZLUbpNVEKqVrDBcb2M4FGE080+ZRR94gQsmUuGy3uJUSzwwtxNzIPYoPX
        hWCZqH47OACyAyOzRxuQv1HKI1SkxoYjnio+gdMLxFiJJsMdvH2/HALdsCySpyTZRi4HLSEqlRUYn
        jhULKQEJrp8ggAexyKFvPE2SyZO53dtDIWdlfJPYa117l7iIch6ivSUO1d1YH4YezKjmqKMeSdxDY
        nXEtGktiB7p+Eha2iMaVQr4cGhp8nqU+8CyhmZh+dHXKN7nPtQEWPjJeGsrTbl9BZpTzdv6BjYanY
        jldJTuezA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gCLii-0002DQ-2g; Tue, 16 Oct 2018 09:32:56 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 662C22029586E; Tue, 16 Oct 2018 11:32:53 +0200 (CEST)
Date:   Tue, 16 Oct 2018 11:32:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, songliubraving@fb.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>, megha.dey@intel.com,
        frederic@kernel.org
Subject: Re: [RFC][PATCH] perf: Rewrite core context handling
Message-ID: <20181016093253.GD4030@hirez.programming.kicks-ass.net>
References: <20181010104559.GO5728@hirez.programming.kicks-ass.net>
 <3a738a08-2295-a4e9-dce7-a3e2b2ad794e@linux.intel.com>
 <20181015083448.GN9867@hirez.programming.kicks-ass.net>
 <a7cd88d6-a379-2d3b-7fde-e313328a3381@linux.intel.com>
 <CABPqkBQ48dM0bTFr_o3pSpAP8e_aH5gHeqXEdkPS0LY3bxBtLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBQ48dM0bTFr_o3pSpAP8e_aH5gHeqXEdkPS0LY3bxBtLw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 11:31:24AM -0700, Stephane Eranian wrote:

> I have always had a hard time understanding the role of all these
> structs in the generic code. This is still very confusing and very
> hard to follow.
> 
> In my mind, you have per-task and per-cpu perf_events contexts.  And
> for each you can have multiple PMUs, some hw some sw.  Each PMU has
> its own list of events maintained in RB tree. There is never any
> interactions between PMUs.

That is more or less how it was. We have per PMU task or CPU contexts:


  task_struct::perf_events_ctxp[] <-> perf_event_context <-> perf_cpu_context
       ^                                 |    ^     |           ^
       `---------------------------------'    |     `--> pmu <--'
                                              v           ^
                                         perf_event ------'


Each task has an array of pointers to a perf_event_context. Each
perf_event_context has a direct relation to a PMU and a group of events
for that PMU. The task related perf_event_context's have a pointer back
to that task.

Each PMU has a per-cpu pointer to a per-cpu perf_cpu_context, which
includes a perf_event_context, which again has a direct relation to that
PMU, and a group of events for that PMU.

The perf_cpu_context also tracks which task context is currently
associated with that CPU and includes a few other things like the
hrtimer for rotation etc..

Each perf_event is then associated with its PMU and one
perf_event_context.

> Maybe this is how this is done or proposed by your patches, but it
> certainly is not obvious.

No, my patch somewhat completely wrecks the above; and reduces to a
single task context and a single CPU context.

There were a number of problems with the above. One is that task-array
of pointer, which limited the number of task contexts we could have.

Now, we could've easily changed that to a list and called it a day.
That is not in fact a horribly difficult patch. If you combine that with
a patch that actually freed task context's when they go empty, that
might actually work.

But there are a number of other considerations that resulted in the
patch as presented:

 - there is a bunch of per context state that is simply duplicated
   between contexts, like for instance the time keeping. There is no
   point in tracking the time for 'n' per task/cpu contexts when in fact
   they're all the same.

 - on context switch we have to iterate all these 'n' contexts and
   switch them one by one. Instead of just switching one context and
   calling it a day.

 - for big.little we'd end up with 2 per-task contexts and only ever use
   1 at any one time, which increases 'n' in the above cases for no
   purpose.

 - the actual per-pmu-per-context state is very small (as I think Alexey
   already implied).

 - a single context simplifies a bunch of things; including the
   move_group case (we no longer have to adjust perf_event::ctx) and the
   cpu-online tests and the ctx locking and it removes a bunch of
   context lists (like active_ctx_list).

So a single context is what I went with. That all results in:


  task_struct::perf_event_ctxp -> perf_event_context <- perf_cpu_context
       ^                                 |    ^ ^
       `---------------------------------'    | |
                                              | `--> perf_event_pmu_context
                                              |       ^   ^
                                              |       |   |
                                              | ,-----'   v
                                              | |      perf_cpu_pmu_context
                                              | |         ^
                                              | |         |
                                              v v         v
                                         perf_event ---> pmu


Because while the per-pmu-per-context state is small, it does exists,
this gives rise to perf_event_pmu_context. It tracks nr_events and
nr_active, which is used to (quickly) tell if rotation is required (it
is possible to reduce this state I think, but I've not yet gotten it
down to 0). It also tracks which events are actually active; iterating a
list is cheaper than finding them all in the RB-tree.

It also contains the task_ctx_data thing for LBR, which is a PMU
specific extra data thingy.

We then also keep a list of (active) perf_event_pmu_context in
perf_event_context, such that we can quickly find which PMUs are in fact
involved with the context. This simplifies context scheduling a little.

We then also need per-pmu-per-cpu state, which gives rise to
perf_cpu_pmu_context, and that mostly includes bits to drive the event
rotation, which per ABI is per PMU, but it also includes bits to do
perf_event_attr::exclusive scheduling, which is also naturally
per-pmu-per-cpu.

And yes, the above looks more complicated, but at the same time, a bunch
of things did get simplified. Maybe once the dust settles someone can
turn this here email into a sensible comment or something ;-)

> Also the Intel LBR is not a PMU on is own. Maybe you are talking about
> the BTS in arch/x86/even/sintel/bts.c.

This thing:

  https://lkml.kernel.org/r/1510970046-25387-1-git-send-email-megha.dey@linux.intel.com
