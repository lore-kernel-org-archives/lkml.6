Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736D7C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 18:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5113420851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 18:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbfAQSFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 13:05:37 -0500
Received: from outbound-smtp16.blacknight.com ([46.22.139.233]:46679 "EHLO
        outbound-smtp16.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726883AbfAQSFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 13:05:37 -0500
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp16.blacknight.com (Postfix) with ESMTPS id D1F4D1C2EBD
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 18:05:33 +0000 (GMT)
Received: (qmail 606 invoked from network); 17 Jan 2019 18:05:33 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.229.96])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 17 Jan 2019 18:05:33 -0000
Date:   Thu, 17 Jan 2019 18:05:32 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Linux-MM <linux-mm@kvack.org>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>, ying.huang@intel.com,
        kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 19/25] mm, compaction: Do not consider a need to
 reschedule as contention
Message-ID: <20190117180532.GN27437@techsingularity.net>
References: <20190104125011.16071-1-mgorman@techsingularity.net>
 <20190104125011.16071-20-mgorman@techsingularity.net>
 <1aa220a6-5517-ee7b-0a16-e72c2ecceddb@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1aa220a6-5517-ee7b-0a16-e72c2ecceddb@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 06:33:37PM +0100, Vlastimil Babka wrote:
> On 1/4/19 1:50 PM, Mel Gorman wrote:
> > Scanning on large machines can take a considerable length of time and
> > eventually need to be rescheduled. This is treated as an abort event but
> > that's not appropriate as the attempt is likely to be retried after making
> > numerous checks and taking another cycle through the page allocator.
> > This patch will check the need to reschedule if necessary but continue
> > the scanning.
> > 
> > The main benefit is reduced scanning when compaction is taking a long time
> > or the machine is over-saturated. It also avoids an unnecessary exit of
> > compaction that ends up being retried by the page allocator in the outer
> > loop.
> > 
> >                                         4.20.0                 4.20.0
> >                               synccached-v2r15        noresched-v2r15
> > Amean     fault-both-3      2655.55 (   0.00%)     2736.50 (  -3.05%)
> > Amean     fault-both-5      4580.67 (   0.00%)     4133.70 (   9.76%)
> > Amean     fault-both-7      5740.50 (   0.00%)     5738.61 (   0.03%)
> > Amean     fault-both-12     9237.55 (   0.00%)     9392.82 (  -1.68%)
> > Amean     fault-both-18    12899.51 (   0.00%)    13257.15 (  -2.77%)
> > Amean     fault-both-24    16342.47 (   0.00%)    16859.44 (  -3.16%)
> > Amean     fault-both-30    20394.26 (   0.00%)    16249.30 *  20.32%*
> > Amean     fault-both-32    17450.76 (   0.00%)    14904.71 *  14.59%*
> 
> I always assumed that this was the main factor that (clumsily) limited THP fault
> latencies. Seems like it's (no longer?) the case, or the lock contention
> detection alone works as well.
> 

I didn't dig into the history but one motivating factor around all the
logic would have been reducing the time IRQs were disabled. With changes
like scanning COMPACT_CLUSTER_MAX and dropping locks, it's less of a
factor. Then again, the retry loops around in the page allocator would
also have changed the problem. Things just changed enough that the
original motivation no longer applies.

> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> 
> > ---
> >  mm/compaction.c | 12 ++----------
> >  1 file changed, 2 insertions(+), 10 deletions(-)
> > 
> > diff --git a/mm/compaction.c b/mm/compaction.c
> > index 1a41a2dbff24..75eb0d40d4d7 100644
> > --- a/mm/compaction.c
> > +++ b/mm/compaction.c
> > @@ -398,19 +398,11 @@ static bool compact_lock_irqsave(spinlock_t *lock, unsigned long *flags,
> >  	return true;
> >  }
> >  
> > -/*
> > - * Aside from avoiding lock contention, compaction also periodically checks
> > - * need_resched() and records async compaction as contended if necessary.
> > - */
> > +/* Avoid soft-lockups due to long scan times */
> >  static inline void compact_check_resched(struct compact_control *cc)
> >  {
> > -	/* async compaction aborts if contended */
> > -	if (need_resched()) {
> > -		if (cc->mode == MIGRATE_ASYNC)
> > -			cc->contended = true;
> > -
> > +	if (need_resched())
> >  		cond_resched();
> 
> Seems like plain "cond_resched()" is sufficient at this point, and probably
> doesn't need a wrapper anymore.
> 

I guess so. I liked having the helper to remind that the contention points
mattered at some point and wasn't a random sprinkling of cond_resched
but I'll remove it.

-- 
Mel Gorman
SUSE Labs
