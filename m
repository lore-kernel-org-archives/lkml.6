Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2918C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E0D520896
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbfARNoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 08:44:13 -0500
Received: from outbound-smtp26.blacknight.com ([81.17.249.194]:56262 "EHLO
        outbound-smtp26.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727518AbfARNoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 08:44:10 -0500
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp26.blacknight.com (Postfix) with ESMTPS id ED9DFB8ABA
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 13:44:08 +0000 (GMT)
Received: (qmail 1956 invoked from network); 18 Jan 2019 13:44:08 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.229.96])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 18 Jan 2019 13:44:08 -0000
Date:   Fri, 18 Jan 2019 13:44:07 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Linux-MM <linux-mm@kvack.org>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>, ying.huang@intel.com,
        kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 22/25] mm, compaction: Sample pageblocks for free pages
Message-ID: <20190118134407.GP27437@techsingularity.net>
References: <20190104125011.16071-1-mgorman@techsingularity.net>
 <20190104125011.16071-23-mgorman@techsingularity.net>
 <4e4529b5-c723-45cd-bdc9-068121d59859@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <4e4529b5-c723-45cd-bdc9-068121d59859@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 11:38:38AM +0100, Vlastimil Babka wrote:
> On 1/4/19 1:50 PM, Mel Gorman wrote:
> > Once fast searching finishes, there is a possibility that the linear
> > scanner is scanning full blocks found by the fast scanner earlier. This
> > patch uses an adaptive stride to sample pageblocks for free pages. The
> > more consecutive full pageblocks encountered, the larger the stride until
> > a pageblock with free pages is found. The scanners might meet slightly
> > sooner but it is an acceptable risk given that the search of the free
> > lists may still encounter the pages and adjust the cached PFN of the free
> > scanner accordingly.
> > 
> > In terms of latency and success rates, the impact is not obvious but the
> > free scan rate is reduced by 87% on a 1-socket machine and 92% on a
> > 2-socket machine. It's also the first time in the series where the number
> > of pages scanned by the migration scanner is greater than the free scanner
> > due to the increased search efficiency.
> > 
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> 
> OK, I admit this is quite counterintuitive to me. I would have expected
> this change to result in meeting scanners much more sooner, while
> missing many free pages (especially when starting with stride 32 for
> async compaction). I would have expected that pageblocks that we already
> depleted are marked for skipping, while freeing pages by reclaim
> scatters them randomly in the remaining ones, and this will then miss
> many. But you have benchmarking data so I won't object :)
> 

So, it comes down to probabilities to some extent which we cannot
really calculate because they are a function of the reference string
for allocations and frees in combination with compaction activity both
of which depend on the workload.

Fundamentally, the key is that compaction typically moves data from lower
addresses to higher addresses. The longer compaction is running, the more
packed the higher addresses become until there are no free pages. When
the fast search fails and the linear search starts, it has to proceed
through a large number of pageblocks that have been tightly packed one
page at a time. However, the location of the free pages doesn't change
very much so the locationwhere compaction finds a target and when the
scanners meet doesn't change by very much at all.

Now, with sampling, some candidates might be missed depending on the
size of the stride and the scanners meet fractionally sooner but the
difference is very marginal. The difference is that we skip over heavily
packed pageblocks much quicker.

Does that help the counterintuitive nature of the patch?

> > ---
> >  mm/compaction.c | 27 +++++++++++++++++++++------
> >  1 file changed, 21 insertions(+), 6 deletions(-)
> > 
> > diff --git a/mm/compaction.c b/mm/compaction.c
> > index 652e249168b1..cc532e81a7b7 100644
> > --- a/mm/compaction.c
> > +++ b/mm/compaction.c
> > @@ -441,6 +441,7 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
> >  				unsigned long *start_pfn,
> >  				unsigned long end_pfn,
> >  				struct list_head *freelist,
> > +				unsigned int stride,
> >  				bool strict)
> >  {
> >  	int nr_scanned = 0, total_isolated = 0;
> > @@ -450,10 +451,14 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
> >  	unsigned long blockpfn = *start_pfn;
> >  	unsigned int order;
> >  
> > +	/* Strict mode is for isolation, speed is secondary */
> > +	if (strict)
> > +		stride = 1;
> 
> Why not just call this from strict context with stride 1, instead of
> passing 0 and then changing it to 1.

No particular reason other than I wanted to make it clear that strict
mode shouldn't play games with stride. I can change it if you prefer.

> > @@ -1412,6 +1420,13 @@ static void isolate_freepages(struct compact_control *cc)
> >  			 */
> >  			break;
> >  		}
> > +
> > +		/* Adjust stride depending on isolation */
> > +		if (nr_isolated) {
> > +			stride = 1;
> > +			continue;
> > +		}
> 
> If we hit a free page with a large stride, wouldn't it make sense to
> reset it to 1 immediately in the same pageblock, and possibly also start
> over from its beginning, if the assumption is that free pages appear
> close together?
> 

I felt that the likely benefit would be marginal and without additional
complexity, we end up scanning the same pageblock twice. I didn't think
the marginal upside was worth it.

-- 
Mel Gorman
SUSE Labs
