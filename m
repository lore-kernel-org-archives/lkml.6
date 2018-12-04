Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF14C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65A092087F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:46:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65A092087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbeLDKqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:46:03 -0500
Received: from outbound-smtp27.blacknight.com ([81.17.249.195]:37351 "EHLO
        outbound-smtp27.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725764AbeLDKqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:46:02 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp27.blacknight.com (Postfix) with ESMTPS id ED504B83A8
        for <linux-kernel@vger.kernel.org>; Tue,  4 Dec 2018 10:45:59 +0000 (GMT)
Received: (qmail 5318 invoked from network); 4 Dec 2018 10:45:59 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.245.71])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 4 Dec 2018 10:45:59 -0000
Date:   Tue, 4 Dec 2018 10:45:58 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>, mhocko@kernel.org,
        ying.huang@intel.com, s.priebe@profihost.ag,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org,
        David Rientjes <rientjes@google.com>, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu
Subject: Re: [LKP] [mm] ac5b2c1891: vm-scalability.throughput -61.3%
 regression
Message-ID: <20181204104558.GV23260@techsingularity.net>
References: <20181203181456.GK31738@dhcp22.suse.cz>
 <CAHk-=whrfDw4yV4h2ijbX3vpXf5m4hzJ5pGX7_v6pU31RGib-g@mail.gmail.com>
 <20181203183050.GL31738@dhcp22.suse.cz>
 <CAHk-=wgVL_sxXSbjYTiGhxp6+9wLQ9ZmSN+0R5PCF6_a9pQgWw@mail.gmail.com>
 <20181203185954.GM31738@dhcp22.suse.cz>
 <CAHk-=wiNKLH2Pbnr9z2SvmDhf7XT==U6NPRkQNX13Sg-FRk0Yw@mail.gmail.com>
 <20181203201214.GB3540@redhat.com>
 <CAHk-=wg=6uxAJMbvGJC-5CSikC8OdqsjE1vw+DsCMj=2SNSnZg@mail.gmail.com>
 <CAHk-=whDg5+e2-eXYo-jwC1spt2r7JjLQSaLm4OyfGMQHLTrdw@mail.gmail.com>
 <64a4aec6-3275-a716-8345-f021f6186d9b@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <64a4aec6-3275-a716-8345-f021f6186d9b@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Much of this thread is a rehash of previous discussions so as a result,
I glossed over parts of it so there will be a degree of error. Very
preliminary results from David's approach are below and the bottom line
is that it might fix some latency issues and locality issues at the cost
of a high degree of THP allocation failure.

On Tue, Dec 04, 2018 at 10:22:26AM +0100, Vlastimil Babka wrote:
> > +                       if (order == pageblock_order &&
> > +                                       !(current->flags & PF_KTHREAD))
> > +                               goto nopage;
> > 
> > and just goes "Eww".
> > 
> > But I think the real problem is that it's the "goto nopage" thing that
> > makes _sense_, and the current cases for "let's try compaction" that
> 
> More precisely it's "let's try reclaim + compaction".
> 

The original intent has been muddied and special cased but the general idea
was that compaction needs space to work with to both succeed and avoid
excessive scanning -- particularly in direct context that is visible to
the application. Before compaction, linear-reclaim (aka lumpy reclaim)
was used but this caused both page age inversion issues and excessive
thrasing. In Andrew's tree, there are patches that also do small amounts
of reclaim in response to fragmentation which in some cases alleviates
the need for the reclaim + compaction step as the reclaim has sometimes
already happened.  This has reduced latencies and increased THP allocation
success rates but not by enough which needs further work.

Parts of compaction are in need of a revisit. I'm in the process of doing
but it's time consuming to do this because of the level of testing required
at every step. The prototype currently is 12 patches and growing and I'm
not sure what the final series will look like or how far it'll go.

At this point, I believe that even when it's finished that the concept of
"do some reclaim and try compaction" will remain. I'm focused primarily
on the compaction core at the moment rather than the outer part in the
page allocator.

> > are the odd ones, and then David adds one new special case for the
> > sensible behavior.
> > 
> > For example, why would COMPACT_DEFERRED mean "don't bother", but not
> > all the other reasons it didn't really make sense?
> 
> COMPACT_DEFERRED means that compaction was failing recently, even with
> sufficient free pages (e.g. freed by direct reclaim), so it doesn't make
> sense to continue.

Yes, the intent is that recent failures should not incur more useless
scanning and stalls. As it is, the latencies are too high and too often
it's useless work. Historically, this was put into place as the time
spent in compaction was too high and the THP allocation latencies were so
bad that it was preferred to disable THP entirely. This has improved in
recent years with general improvements and changes to defaults but there
is room to improve. Again, it's something I'm looking into but it's slow.

> > <SNIP>
> > So does it really make sense to fall through AT ALL to that "retry"
> > case, when we explicitly already had (gfp_mask & __GFP_NORETRY)?
> 
> Well if there was no free memory to begin with, and thus compaction
> returned COMPACT_SKIPPED, then we didn't really "try" anything yet, so
> there's nothing to "not retry".
> 

What should also be kept in mind is that we should avoid conflating
locality preferences with THP preferences which is separate from THP
allocation latencies. The whole __GFP_THISNODE approach is pushing too
hard on locality versus huge pages when MADV_HUGEPAGE or always-defrag
are used which is very unfortunate given that MADV_HUGEPAGE in itself says
nothing about locality -- that is the business of other madvise flags or
a specific policy.  Using remote nodes is bad but reclaiming excessively
and pushing data out of memory is worse as the latency to fault data back
from disk is higher than a remote access.

Andrea already pointed it out -- workloads that fit within a node are happy
to reclaim local memory, particularly in the case where the existing data
is old which is the ideal for David. Workloads that do not fit within a
node will often prefer using remote memory -- either THP or base pages
in the general case and THP for definite in the KVM case. While KVM
might not like remote memory, using THP at least reduces the page table
access overhead even if the access is remote and eventually automatic
NUMA balancing might intervene.

> > Maybe the real fix is to instead of adding yet another special case
> > for "goto nopage", it should just be unconditional: simply don't try
> > to compact large-pages if __GFP_NORETRY was set.
> 
> I think that would destroy THP success rates too much, in situations
> where reclaim and compaction would succeed, because there's enough
> easily reclaimable and migratable memory.
> 

Tests are in progress but yes, this is the primary risk of abandoning
the allocation request too early. I've already found during developing
the prototype series that it's very easy to "fix" latencies by simply
failing THP allocation very quickly. This is not the desired outcome and
has occupied the bulk of my attention.

I have *one* result of the series on a 1-socket machine running
"thpscale". It creates a file, punches holes in it to create a
very light form of fragmentation and then tries THP allocations
using madvise measuring latency and success rates. It's the
global-dhp__workload_thpscale-madvhugepage in mmtests using XFS as the
filesystem.

thpscale Fault Latencies
                                    4.20.0-rc4             4.20.0-rc4
                                mmots-20181130       gfpthisnode-v1r1
Amean     fault-base-3      5358.54 (   0.00%)     2408.93 *  55.04%*
Amean     fault-base-5      9742.30 (   0.00%)     3035.25 *  68.84%*
Amean     fault-base-7     13069.18 (   0.00%)     4362.22 *  66.62%*
Amean     fault-base-12    14882.53 (   0.00%)     9424.38 *  36.67%*
Amean     fault-base-18    15692.75 (   0.00%)    16280.03 (  -3.74%)
Amean     fault-base-24    28775.11 (   0.00%)    18374.84 *  36.14%*
Amean     fault-base-30    42056.32 (   0.00%)    21984.55 *  47.73%*
Amean     fault-base-32    38634.26 (   0.00%)    22199.49 *  42.54%*
Amean     fault-huge-1         0.00 (   0.00%)        0.00 (   0.00%)
Amean     fault-huge-3      3628.86 (   0.00%)      963.45 *  73.45%*
Amean     fault-huge-5      4926.42 (   0.00%)     2959.85 *  39.92%*
Amean     fault-huge-7      6717.15 (   0.00%)     3828.68 *  43.00%*
Amean     fault-huge-12    11393.47 (   0.00%)     5772.92 *  49.33%*
Amean     fault-huge-18    16979.38 (   0.00%)     4435.95 *  73.87%*
Amean     fault-huge-24    16558.00 (   0.00%)     4416.46 *  73.33%*
Amean     fault-huge-30    20351.46 (   0.00%)     5099.73 *  74.94%*
Amean     fault-huge-32    23332.54 (   0.00%)     6524.73 *  72.04%*

So, looks like massive latency improvements but then the THP allocation
success rates

thpscale Percentage Faults Huge
                               4.20.0-rc4             4.20.0-rc4
                           mmots-20181130       gfpthisnode-v1r1
Percentage huge-3        95.14 (   0.00%)        7.94 ( -91.65%)
Percentage huge-5        91.28 (   0.00%)        5.00 ( -94.52%)
Percentage huge-7        86.87 (   0.00%)        9.36 ( -89.22%)
Percentage huge-12       83.36 (   0.00%)       21.03 ( -74.78%)
Percentage huge-18       83.04 (   0.00%)       30.73 ( -63.00%)
Percentage huge-24       83.74 (   0.00%)       27.47 ( -67.20%)
Percentage huge-30       83.66 (   0.00%)       31.85 ( -61.93%)
Percentage huge-32       83.89 (   0.00%)       29.09 ( -65.32%)

They're down the toilet. 3 threads are able to get 95% of the requested
THP pages with Andrews tree as of Nov 30th. David's patch drops that to
8% success rate.

"Compaction efficiency" which takes success vs failure rate into account
goes from 45% to 1%. Compaction scan efficiency, which is how many pages
for migration are scanned vs how many are scanned as free targets goes
from 21% to 1%.

I do not consider this to be a good outcome and hence will not be acking
the patches.

I would also re-emphasise that a major problem with addressing this
problem is that we do not have a general reproducible test case for
David's scenario where as we do have reproduction cases for the others.
They're not related to KVM but that doesn't matter because it's enough
to have a memory hog try allocating more memory than fits on a single node.

Remember too that while the headline regression reported by LKP looks
bad, they have mentioned themselves that the different threads in the
workload are being treated fairly. We've seen "regressions" like this in
the past. For example, way back we had a problem with a dbench regression
that was due to IO fairness giving each thread time to issue IO which
slowed overall throughput that benefitted from few threads making progress
while others starved.

> > Hmm? I dunno. Right now - for 4.20, I'd obviously want to keep changes
> > smallish, so a hacky added special case might be the right thing to
> > do. But the code does look odd, doesn't it?
> > 
> > I think part of it comes from the fact that we *used* to do the
> > compaction first, and then we did the reclaim, and then it was
> > re-orghanized to do reclaim first, but it tried to keep semantic
> > changes minimal and some of the above comes from that re-org.
> 
> IIRC the point of reorg was that in typical case we actually do want to
> try the reclaim first (or only), and the exception are those THP-ish
> allocations where typically the problem is fragmentation, and not number
> of free pages, so we check first if we can defragment the memory or
> whether it makes sense to free pages in case the defragmentation is
> expected to help afterwards. It seemed better to put this special case
> out of the main reclaim/compaction retry-with-increasing-priority loop
> for non-costly-order allocations that in general can't fail.
> 

Again, this is accurate. Scanning/compaction costs a lot. This has improved
over time, but minimally it's unmapping pages, copying data and a bunch
of TLB flushes. During migration, any access to the data being migrated
stalls. The harm of reclaiming a little first so that the compaction is
more likely to succeed incurred fewer stalls of small magnitude in
general -- or at least it was the case when that behaviour was
developed.

-- 
Mel Gorman
SUSE Labs
