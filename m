Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461ACECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 029A42084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YPYzioMC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 029A42084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731801AbeGSOmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:42:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40168 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731105AbeGSOmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YbZEhod6+oCuO/XJF2r6OBkvvUCmqgWhGVTmfRqzeHs=; b=YPYzioMCKH4PSfBh4+LL2AHDL
        j6HIpqdFgyPpOJOPtr3hPi9Z3+LfFKSXLuAzdwEJwu7i9h3JakG3tfdsK7cx7et62hiH4y1/mBGXJ
        Xfm6eqoEBk5rh92v8+z0iECUZotqY6LDAoU1sWhVLChd2JH3LdkxGe8Sfmz3GGbm5ZIqGEp7yfWUt
        Xd3c98GuMyzhsg/RNUme9fceOhhhfrsl0uUtDehgVgyOUFFMX/wWj8kBRo2cJqbf/Ozvv9+s1+yul
        erSJY+tTJQdl6FBjVRTZeQW97mMJMe5Nt+dgyRCBHtqqpQLN10KU5UuVOKEcisA79z3OAV9GMrPKD
        6WiFz8iQw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fg9SC-0001wY-ER; Thu, 19 Jul 2018 13:58:48 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E64DA20277352; Thu, 19 Jul 2018 15:58:46 +0200 (CEST)
Date:   Thu, 19 Jul 2018 15:58:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Mike Galbraith <efault@gmx.de>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 08/10] psi: pressure stall information for CPU, memory,
 and IO
Message-ID: <20180719135846.GH2494@hirez.programming.kicks-ass.net>
References: <20180712172942.10094-1-hannes@cmpxchg.org>
 <20180712172942.10094-9-hannes@cmpxchg.org>
 <20180718120318.GC2476@hirez.programming.kicks-ass.net>
 <20180718223644.GH2838@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718223644.GH2838@cmpxchg.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 06:36:44PM -0400, Johannes Weiner wrote:
> On Wed, Jul 18, 2018 at 02:03:18PM +0200, Peter Zijlstra wrote:
> > On Thu, Jul 12, 2018 at 01:29:40PM -0400, Johannes Weiner wrote:
> > > +	/* Time in which tasks wait for the CPU */
> > > +	state = PSI_NONE;
> > > +	if (tasks[NR_RUNNING] > 1)
> > > +		state = PSI_SOME;
> > > +	time_state(&groupc->res[PSI_CPU], state, now);
> > > +
> > > +	/* Time in which tasks wait for memory */
> > > +	state = PSI_NONE;
> > > +	if (tasks[NR_MEMSTALL]) {
> > > +		if (!tasks[NR_RUNNING] ||
> > > +		    (cpu_curr(cpu)->flags & PF_MEMSTALL))
> > 
> > I'm confused, why do we care if the current tasks is MEMSTALL or not?
> 
> We want to know whether we're losing CPU potential because of a lack
> of memory. That can happen when the task waits for refaults and the
> CPU goes idle, but it can also happen when the CPU is performing
> reclaim.
> 
> If the task waits for refaults and something else is runnable, we're
> not losing CPU potential. But if the task performs reclaim and uses
> the CPU, nothing else can do productive work on that CPU.

Right, this is because MEMSTALL is not just blocking (as per that other
sub-thread).

This is really unfortunate, because it means the state is not a simple
function of the task counts.
