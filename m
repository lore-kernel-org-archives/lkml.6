Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568C7C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0808920850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:40:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0808920850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbeLEUkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 15:40:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41220 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727592AbeLEUkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 15:40:39 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 584E430001EF;
        Wed,  5 Dec 2018 20:40:38 +0000 (UTC)
Received: from sky.random (ovpn-122-73.rdu2.redhat.com [10.10.122.73])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F1F61001F50;
        Wed,  5 Dec 2018 20:40:35 +0000 (UTC)
Date:   Wed, 5 Dec 2018 15:40:34 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        mhocko@kernel.org, ying.huang@intel.com, s.priebe@profihost.ag,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org,
        David Rientjes <rientjes@google.com>, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu
Subject: Re: [LKP] [mm] ac5b2c1891: vm-scalability.throughput -61.3%
 regression
Message-ID: <20181205204034.GB11899@redhat.com>
References: <CAHk-=whrfDw4yV4h2ijbX3vpXf5m4hzJ5pGX7_v6pU31RGib-g@mail.gmail.com>
 <20181203183050.GL31738@dhcp22.suse.cz>
 <CAHk-=wgVL_sxXSbjYTiGhxp6+9wLQ9ZmSN+0R5PCF6_a9pQgWw@mail.gmail.com>
 <20181203185954.GM31738@dhcp22.suse.cz>
 <CAHk-=wiNKLH2Pbnr9z2SvmDhf7XT==U6NPRkQNX13Sg-FRk0Yw@mail.gmail.com>
 <20181203201214.GB3540@redhat.com>
 <CAHk-=wg=6uxAJMbvGJC-5CSikC8OdqsjE1vw+DsCMj=2SNSnZg@mail.gmail.com>
 <CAHk-=whDg5+e2-eXYo-jwC1spt2r7JjLQSaLm4OyfGMQHLTrdw@mail.gmail.com>
 <64a4aec6-3275-a716-8345-f021f6186d9b@suse.cz>
 <20181204104558.GV23260@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204104558.GV23260@techsingularity.net>
User-Agent: Mutt/1.11.0 (2018-11-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 05 Dec 2018 20:40:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Sorry, it has been challenging to keep up with all fast replies, so
I'll start by answering to the critical result below:

On Tue, Dec 04, 2018 at 10:45:58AM +0000, Mel Gorman wrote:
> thpscale Percentage Faults Huge
>                                4.20.0-rc4             4.20.0-rc4
>                            mmots-20181130       gfpthisnode-v1r1
> Percentage huge-3        95.14 (   0.00%)        7.94 ( -91.65%)
> Percentage huge-5        91.28 (   0.00%)        5.00 ( -94.52%)
> Percentage huge-7        86.87 (   0.00%)        9.36 ( -89.22%)
> Percentage huge-12       83.36 (   0.00%)       21.03 ( -74.78%)
> Percentage huge-18       83.04 (   0.00%)       30.73 ( -63.00%)
> Percentage huge-24       83.74 (   0.00%)       27.47 ( -67.20%)
> Percentage huge-30       83.66 (   0.00%)       31.85 ( -61.93%)
> Percentage huge-32       83.89 (   0.00%)       29.09 ( -65.32%)
> 
> They're down the toilet. 3 threads are able to get 95% of the requested
> THP pages with Andrews tree as of Nov 30th. David's patch drops that to
> 8% success rate.

This is the downside of David's patch very well exposed above. And
this will make non-NUMA system regress like above too despite they
have no issue to begin with (which is probably why nobody noticed the
trouble with __GFP_THISNODE reclaim until recently, combined with the
fact most workloads can fit in a single NUMA node).

So we're effectively crippling down MADV_HUGEPAGE effectiveness on
non-NUMA (where it cannot help to do so) and on NUMA (as a workaround
for the false positive swapout storms) because in some workload and
system THP improvements are less significant than NUMA improvements.

The higher fault latency is generally the higher cost you pay to get
the good initial THP utilization for apps that do long lived
allocations and in turn can use MADV_HUGEPAGE without downsides. The
cost of compaction pays off over time.

Short lived allocations sensitive to the allocation latency should not
use MADV_HUGEPAGE in the first place. If you don't want high latency
you shouldn't use MADV_HUGEPAGE and khugepaged already uses
__GFP_THISNODE but it replaces memory so it has a neutral memory
footprint at it, so it's ok with regard to reclaim.

In my view David's workload is the outlier that uses MADV_HUGEPAGE but
pretends a low latency and NUMA local behavior as first priority. If
your workload fits in the per-socket CPU cache it doesn't matter which
node it is but it totally matters if you've 2M or 4k tlb. I'm not even
talking about KVM where THP has a multipler effect with EPT.

Even if you make the __GFP_NORETRY change for the HPAGE_PMD_ORDER to
skip reclaim in David's patch conditional NUMA being enabled in the
host (so that it won't cripple THP utilization also on non-NUMA
systems), imagine that you go in the bios, turn off interleaving to
enable host NUMA and THP utilization unexpectedly drops significantly
for your VM.

Rome ryzen architecture has been mentioned several times by David but
in my threadripper (not-Rome, as it's supposed to be available in 2019
only AFIK) enabling THP made a measurable difference for me for some
workloads. As opposed if I turn off NUMA by setting up the
interleaving in the dimm I get a barely measurable slowdown. So I'm
surprised in Rome there's such a radical difference in behavior.

Like Mel said we need to work towards a more complete solution than
putting __GFP_THISNODE from the outside and then turning off reclaim
from the inside. Mel made examples of things that should
happen, that won't increase allocation latency and that can't happen
with __GFP_THISNODE.

I'll try to describe again what's going on:

1: The allocator is being asked through __GFP_THISNODE "ignore all
remote nodes for all reclaim and compaction" from the
outside. Compaction then returns COMPACT_SKIPPED and tells the
allocator "I can generate many more huge pages if you reclaim/swapout
2M of anon memory in this node, the only reason I failed to compact
memory is because there aren't enough 4k fragmented pages free in this
zone". The allocator then goes ahead and swaps 2M and invokes
compaction again that succeeds the order 9 allocation fine. Goto 1;

The above keeps running in a loop at every additional page fault of
the app using MADV_HUGEPAGE until all RAM of the node is swapped out
and replaced by THP and all others nodes had 100% free memory,
potentially 100% order 9, but the allocator completely ignored all
other nodes. That is the thing that we're fixing here, because such
swap storms caused massive slowdowns. If the workload can't fit in a
single node, it's like running with only a fraction of the RAM.

So David's patch (and __GFP_COMPACT_ONLY) to fix the above swap storm,
inside the allocator skips reclaim entirely when compaction tells "I
can generate one more HPAGE_PMD_ORDER compound page if you
reclaim/swap 2M", if __GFP_NORETRY is set (and makes sure
__GFP_NORETRY is always set for THP). And that however prevents to
generate any more THP globally the moment any node is full of
filesystem cache.

NOTE: the filesystem cache will still be shrunk but it'll be shrunk by
4k allocations only. So we just artificially cripple compaction with
David's patch as shown in the quoted results above. This applied to
__GFP_COMPACT_ONLY too and that's I always said there's lots of margin
for improvement there and even __GFP_COMPACT_ONLY was also a stop-gap
measure.

So ultimately we decided that the saner behavior that gives the least
risk of regression for the short term, until we can do something
better, was the one that is already applied upstream.

Of course David's workload regressed, but that's because it gets a
minuscle improvement from THP, maybe it's seeking across all RAM and
it's very RAM heavy bandwidth-heavy workload so 4k or 2m tlb don't
matter at all for his workload and probably he's running it on bare
metal only.

I think the challenge here is to get David's workload optimally
without creating the above regression but we don't have a way to do it
right now in an automatic way. It's trivial however to add a mbind new
MPOL_THISNODE or MPOL_THISNODE_THP policy to force THP to set
__GFP_THISNODE and return to the swap storm behavior that needle to
say may have worked best by practically partioning the system, in fact
you may want to use __GFP_THISNODE for 4k allocations too so you
invoke reclaim from the local node before allocating RAM from the
remote nodes.

To me it doesn't seem the requirements of David's workload are the
same as for other MADV_HUGEPAGE users, I can't image other
MADV_HUGEPAGE users not to care at all if the THP utilization drops,
for David it seems THP is a nice thing to have only, and it seems to
care about allocation latency too (which normal apps using
MADV_HUGEPAGE must not).

In any case David's patch is better than reverting the revert, as the
swap storms are a showstopper compared to crippling down compaction
ability to compact memory when all nodes are full of cache.

Thanks,
Andrea
