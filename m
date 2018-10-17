Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD85ECDE39
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E902B2087A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RZgERVS7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E902B2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbeJRBQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 21:16:53 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55928 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeJRBQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 21:16:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=W+bNAcoMLhzFF1rLVlWulHAXli+vuTOhhmNtecljJNw=; b=RZgERVS7DRePYm6syMPzL5nYb
        wDb/B3Vy0+aTh6FCrtV/4r8aTSAxk0qdMmimrk55SMhc5H8kMt0CnIoteXvZwvaIlZAjvJv4vgVQq
        0VjmeOaCIxUEEDAvn0YM3hQiHoGkm3438ap/t7OuR2eGIcpu3Ns9Jg2tn0V74A8s+SnYI6c4wi0he
        mPDU0qU2+9WtQkKj8LZV8n4LjYZM/fuuehI3Jhwl+SJPsYs7/Y4RHq+9NSNbgmnCelFEAaSIgoUYH
        2Z1ESUs3Kdw/tDXPjwgdt+UtNg8BqwPpaC8TQBLI4TvsIJK2/6jHVXaIwebiGyn+Oj4sWCTYrtCKq
        fCEP0Lmbw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gCpUD-0003ER-Uj; Wed, 17 Oct 2018 17:19:58 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7E2E420297B7B; Wed, 17 Oct 2018 19:19:55 +0200 (CEST)
Date:   Wed, 17 Oct 2018 19:19:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "megha.dey@intel.com" <megha.dey@intel.com>,
        "frederic@kernel.org" <frederic@kernel.org>
Subject: Re: [RFC][PATCH] perf: Rewrite core context handling
Message-ID: <20181017171955.GQ3121@hirez.programming.kicks-ass.net>
References: <20181010104559.GO5728@hirez.programming.kicks-ass.net>
 <3a738a08-2295-a4e9-dce7-a3e2b2ad794e@linux.intel.com>
 <20181015083448.GN9867@hirez.programming.kicks-ass.net>
 <AF0FCD08-E014-4D29-B023-EA780056DBB5@fb.com>
 <FE66AE20-9785-4CF7-8D8D-CF2A9C696923@fb.com>
 <20181017110651.GI3121@hirez.programming.kicks-ass.net>
 <82000D4A-0A1B-4A8B-904C-24640215D2BD@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82000D4A-0A1B-4A8B-904C-24640215D2BD@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 04:43:27PM +0000, Song Liu wrote:

> > That makes task and cpu contexts wildly different, which will complicate
> > matters I feel.
> > 
> 
> I think we only need different logic when adding events to the task/cpu 
> contexts. The ctx_sched_in() and ctx_sched_out() will need some extra
> logic to filter out events that are not being scheduled (don't schedule
> events on PMU-a when rotating PMU-b). This logic will be the same for 
> task and cpu context. The difference is, the CPU context will not have
> such events, because we never added such event to CPU context. 
> 
> Does this make sense? I could try draft a RFC to see how difficult it is. 

I'm not sure it saves much, if we have multiple per-cpu contexts we get
to re-introduce the active_ctx_list and loose the simplification for the
online status.

Plus that fundamental assymetry -- which would bother my OCD forever
more :-)


