Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2595C28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 08:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77A1D2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 08:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lSMTgtZg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77A1D2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbeJOQTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 12:19:24 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57158 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbeJOQTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 12:19:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KAQMG3TAPiKKrIORE6lRzu0XUDiibetv0f30TGiPYbk=; b=lSMTgtZg2H95NyN78jCOuVx6r
        x40i/5XJTeQgcAFItWlP2bSK2fR00vUIfEHFZpdUrhjnVyOMIYkOL/H0pYizAdMe10mCEJr1WLhDz
        l31yyiNDs3vhUs5DrW534HbyAr30QhNXKaFcYBlW4VhEUxlpRmgrndSLjM8j3ZSKQ2Jkg8zFITOil
        OXo2fjatYNzZ9Upx2ZE5Jm8yezTIlk3dkNg2NkX3sWT4iigA6RkLw4Ped1KF0XI+6/x1FL7agWVbZ
        GjBbHT3Km95FwOhc6ggpVS7fh/nGj+MtQYXcrkYGeoqy7om/golsccrGVsej8ZZWQGc0dZ8yXfwPy
        wc5NB1DAw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gByKx-0006SS-Cs; Mon, 15 Oct 2018 08:34:51 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E2E8920158F79; Mon, 15 Oct 2018 10:34:48 +0200 (CEST)
Date:   Mon, 15 Oct 2018 10:34:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        songliubraving@fb.com, eranian@google.com, tglx@linutronix.de,
        mark.rutland@arm.com, megha.dey@intel.com, frederic@kernel.org
Subject: Re: [RFC][PATCH] perf: Rewrite core context handling
Message-ID: <20181015083448.GN9867@hirez.programming.kicks-ass.net>
References: <20181010104559.GO5728@hirez.programming.kicks-ass.net>
 <3a738a08-2295-a4e9-dce7-a3e2b2ad794e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a738a08-2295-a4e9-dce7-a3e2b2ad794e@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 10:26:06AM +0300, Alexey Budankov wrote:
> Hi,
> 
> On 10.10.2018 13:45, Peter Zijlstra wrote:
> > Hi all,
> > 
> > There have been various issues and limitations with the way perf uses
> > (task) contexts to track events. Most notable is the single hardware PMU
> > task context, which has resulted in a number of yucky things (both
> > proposed and merged).
> > 
> > Notably:
> > 
> >  - HW breakpoint PMU
> >  - ARM big.little PMU
> >  - Intel Branch Monitoring PMU
> > 
> > Since we now track the events in RB trees, we can 'simply' add a pmu
> > order to them and have them grouped that way, reducing to a single
> > context. Of course, reality never quite works out that simple, and below
> > ends up adding an intermediate data structure to bridge the context ->
> > pmu mapping.
> > 
> > Something a little like:
> > 
> >               ,------------------------[1:n]---------------------.
> >               V                                                  V
> >     perf_event_context <-[1:n]-> perf_event_pmu_context <--- perf_event
> >               ^                      ^     |                     |
> >               `--------[1:n]---------'     `-[n:1]-> pmu <-[1:n]-'
> > 
> > This patch builds (provided you disable CGROUP_PERF), boots and survives
> > perf-top without the machine catching fire.
> > 
> > There's still a fair bit of loose ends (look for XXX), but I think this
> > is the direction we should be going.
> > 
> > Comments?
> > 
> > Not-Quite-Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  arch/powerpc/perf/core-book3s.c |    4 
> >  arch/x86/events/core.c          |    4 
> >  arch/x86/events/intel/core.c    |    6 
> >  arch/x86/events/intel/ds.c      |    6 
> >  arch/x86/events/intel/lbr.c     |   16 
> >  arch/x86/events/perf_event.h    |    6 
> >  include/linux/perf_event.h      |   80 +-
> >  include/linux/sched.h           |    2 
> >  kernel/events/core.c            | 1412 ++++++++++++++++++++--------------------
> >  9 files changed, 815 insertions(+), 721 deletions(-)
> 
> Rewrite is impressive however it doesn't result in code base reduction as it is.

Yeah.. that seems to be nature of these things ..

> Nonetheless there is a clear demand for per pmu events groups tracking and rotation 
> in single cpu context (HW breakpoints, ARM big.little, Intel LBRs) and there is 
> a supply thru groups ordering on RB-tree.
> 
> This might be driven into the kernel by some new Perf features that would base on 
> that RB-tree groups ordering or by refactoring of existing code but in the way it 
> would result in overall code base reduction thus lowering support cost.

If you have a concrete suggestion on how to reduce complexity? I tried,
but couldn't find any (without breaking something).

The active lists and pmu_ctx_list could arguably be replaced with
(slower) iteratons over the RB tree, but you'll still need the per pmu
nr_events/nr_active counts to determine if rotation is required at all.

And like you know, performance is quite important here too. I'd love to
reduce complexity while maintaining or improve performance, but that
rarely if ever happens :/
