Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9CAC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A33214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jSiz0SUq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5A33214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbeHVMef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 08:34:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54436 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728208AbeHVMee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 08:34:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YbdDDn0LmMntOvsDynUtkB+mSIAFRIE4RGQzJvC3h5Q=; b=jSiz0SUqgjqtYAL67S8Lqar0i
        p0b7Y7CW10WpXS0NNVGlBubKM8EeCLv1Jaaou8dQCVTcElzguUN/Qs0+SlAHfcnF/mIHfVGmqsyLT
        s93/sZxhQwWIwqwVs7MNBaOsFZm5hyd6ROK5gaL2lOBo982Ww+U0YqRMmdSV9UarpPQfzV6XNWn6m
        0Nqq20kfiGNXzjtfK3hvjtA3dUXVqMMne8QJ4AijNqnL2KzK8YneUDZ8Yi9wiC2eZE6cOJYRs+rgo
        SMdhHO15+3XIi073bSguMNAihmCZ709twxhLzv26WYHo5bMKi3vPi+YOwbljVTFkyYzXRxRTHssL2
        Q7dTgWu/g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fsP9l-0003D6-Ss; Wed, 22 Aug 2018 09:10:26 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 25FD42025D75D; Wed, 22 Aug 2018 11:10:24 +0200 (CEST)
Date:   Wed, 22 Aug 2018 11:10:24 +0200
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
Message-ID: <20180822091024.GU24124@hirez.programming.kicks-ass.net>
References: <20180801151958.32590-1-hannes@cmpxchg.org>
 <20180801151958.32590-9-hannes@cmpxchg.org>
 <20180803172139.GE2494@hirez.programming.kicks-ass.net>
 <20180821201115.GB24538@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180821201115.GB24538@cmpxchg.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 04:11:15PM -0400, Johannes Weiner wrote:
> On Fri, Aug 03, 2018 at 07:21:39PM +0200, Peter Zijlstra wrote:
> > On Wed, Aug 01, 2018 at 11:19:57AM -0400, Johannes Weiner wrote:
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
> > As is, groupc->state_start needs a READ_ONCE() above and a WRITE_ONCE()
> > below. But like stated earlier, doing an update in scheduler_tick() is
> > probably easier.
> 
> I've wrapped these in READ_ONCE/WRITE_ONCE.

I just realized, these are u64, so READ_ONCE/WRITE_ONCE will not work
correct on 32bit.
