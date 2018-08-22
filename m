Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6522C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 980A52150C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BBBLrIeN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 980A52150C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbeHVMkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 08:40:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57732 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727396AbeHVMkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 08:40:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LuOvCEgwGsH/kKcIW3uG3WLfnGS0BKIJoNEFGYBxAkM=; b=BBBLrIeNjL/Amptv3C8Ba5ejf
        DkRnXMvX2eB8hXqJbRmMyXfyfp/ScG+mBVmW2GWsyAo5ErX+yI74gNtk46+DHabAEtEhetYt2ygH9
        DtZOuQZft2gQ35kw1wRZqkRZ1u+mCJhTUcn4qEucHgy4KdV+5gxGEbuL0LAcxixY2n6X6Tmm5FfYV
        WhRQ/aRbxiMxeSDb/Br65EgSCoT91HW0YLMiJqaehk2/anwJDxLBmMXoM60MFkd2esPuUUDq1GFBM
        iOYxF9vWoivleKz5jv0HjDBwm4pgafWlXTCsnj2cwQ9l33F/9TCiHbo016mrrhbI3mtm1+4JEM/nw
        t2f8xzXLw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fsPFq-0005Td-FF; Wed, 22 Aug 2018 09:16:42 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F262C2025D75D; Wed, 22 Aug 2018 11:16:40 +0200 (CEST)
Date:   Wed, 22 Aug 2018 11:16:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Drake <drake@endlessm.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Mike Galbraith <efault@gmx.de>,
        Shakeel Butt <shakeelb@google.com>,
        Peter Enderborg <peter.enderborg@sony.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 8/9] psi: pressure stall information for CPU, memory, and
 IO
Message-ID: <20180822091640.GV24124@hirez.programming.kicks-ass.net>
References: <20180801151958.32590-1-hannes@cmpxchg.org>
 <20180801151958.32590-9-hannes@cmpxchg.org>
 <20180803165641.GA2476@hirez.programming.kicks-ass.net>
 <20180821194413.GA24538@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180821194413.GA24538@cmpxchg.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 03:44:13PM -0400, Johannes Weiner wrote:

> > > +		for (s = PSI_NONIDLE; s >= 0; s--) {
> > > +			u32 time, delta;
> > > +
> > > +			time = READ_ONCE(groupc->times[s]);
> > > +			/*
> > > +			 * In addition to already concluded states, we
> > > +			 * also incorporate currently active states on
> > > +			 * the CPU, since states may last for many
> > > +			 * sampling periods.
> > > +			 *
> > > +			 * This way we keep our delta sampling buckets
> > > +			 * small (u32) and our reported pressure close
> > > +			 * to what's actually happening.
> > > +			 */
> > > +			if (test_state(groupc->tasks, cpu, s)) {
> > > +				/*
> > > +				 * We can race with a state change and
> > > +				 * need to make sure the state_start
> > > +				 * update is ordered against the
> > > +				 * updates to the live state and the
> > > +				 * time buckets (groupc->times).
> > > +				 *
> > > +				 * 1. If we observe task state that
> > > +				 * needs to be recorded, make sure we
> > > +				 * see state_start from when that
> > > +				 * state went into effect or we'll
> > > +				 * count time from the previous state.
> > > +				 *
> > > +				 * 2. If the time delta has already
> > > +				 * been added to the bucket, make sure
> > > +				 * we don't see it in state_start or
> > > +				 * we'll count it twice.
> > > +				 *
> > > +				 * If the time delta is out of
> > > +				 * state_start but not in the time
> > > +				 * bucket yet, we'll miss it entirely
> > > +				 * and handle it in the next period.
> > > +				 */
> > > +				smp_rmb();
> > > +				time += cpu_clock(cpu) - groupc->state_start;
> > > +			}
> > 
> > The alternative is adding an update to scheduler_tick(), that would
> > ensure you're never more than nr_cpu_ids * TICK_NSEC behind.
> 
> I wasn't able to convert *all* states to tick updates like this.
> 
> The reason is that, while testing rq->curr for PF_MEMSTALL is cheap,
> other tasks associated with the rq could be from any cgroup in the
> system. That means we'd have to do for_each_cgroup() on every tick to
> keep the groupc->times that closely uptodate, and that wouldn't scale.
> We tend to have hundreds of them, some setups have thousands.
> 
> Since we don't need to be *that* current, I left the on-demand update
> inside the aggregator for now. It's a bit trickier, but much cheaper.

ARGH indeed; I was thinking we only need to update current. But because
we're tracking blocked state that doesn't work.

Sorry for that :/
