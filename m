Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84348C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EA6C2082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:09:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EA6C2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbeLEJJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:09:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:45510 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726171AbeLEJI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:08:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2AFD3B60C;
        Wed,  5 Dec 2018 09:08:57 +0000 (UTC)
Date:   Wed, 5 Dec 2018 10:08:56 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>, ying.huang@intel.com,
        s.priebe@profihost.ag,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu
Subject: Re: [LKP] [mm] ac5b2c1891: vm-scalability.throughput -61.3%
 regression
Message-ID: <20181205090856.GY1286@dhcp22.suse.cz>
References: <20181203183050.GL31738@dhcp22.suse.cz>
 <CAHk-=wgVL_sxXSbjYTiGhxp6+9wLQ9ZmSN+0R5PCF6_a9pQgWw@mail.gmail.com>
 <20181203185954.GM31738@dhcp22.suse.cz>
 <CAHk-=wiNKLH2Pbnr9z2SvmDhf7XT==U6NPRkQNX13Sg-FRk0Yw@mail.gmail.com>
 <20181203201214.GB3540@redhat.com>
 <CAHk-=wg=6uxAJMbvGJC-5CSikC8OdqsjE1vw+DsCMj=2SNSnZg@mail.gmail.com>
 <CAHk-=whDg5+e2-eXYo-jwC1spt2r7JjLQSaLm4OyfGMQHLTrdw@mail.gmail.com>
 <64a4aec6-3275-a716-8345-f021f6186d9b@suse.cz>
 <20181204104558.GV23260@techsingularity.net>
 <alpine.DEB.2.21.1812041609160.213718@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1812041609160.213718@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 04-12-18 16:47:23, David Rientjes wrote:
> On Tue, 4 Dec 2018, Mel Gorman wrote:
> 
> > What should also be kept in mind is that we should avoid conflating
> > locality preferences with THP preferences which is separate from THP
> > allocation latencies. The whole __GFP_THISNODE approach is pushing too
> > hard on locality versus huge pages when MADV_HUGEPAGE or always-defrag
> > are used which is very unfortunate given that MADV_HUGEPAGE in itself says
> > nothing about locality -- that is the business of other madvise flags or
> > a specific policy.
> 
> We currently lack those other madvise modes or mempolicies: mbind() is not 
> a viable alternative because we do not want to oom kill when local memory 
> is depleted, we want to fallback to remote memory.

Yes, there was a clear agreement that there is no suitable mempolicy
right now and there were proposals to introduce MPOL_NODE_RECLAIM to
introduce that behavior. This would be an improvement regardless of THP
because global node-reclaim policy was simply a disaster we had to turn
off by default and the global semantic was a reason people just gave up
using it completely.

[...]

> Sure, but not at the cost of regressing real-world workloads; what is 
> being asked for here is legitimate and worthy of an extension, but since 
> the long-standing behavior has been to use __GFP_THISNODE and people 
> depend on that for NUMA locality,

Well, your patch has altered the semantic and has introduced a subtle
and _undocumented_ NUMA policy into MADV_HUGEPAGE. All that without any
workload numbers. It would be preferable to have a simulator of those
real world workloads of course but even getting some more detailed
metric - e.g. without the patch we have X THP utilization and the
runtime characteristics Y but without X1 and Y1).

> can we not fix the swap storm and look 
> to extending the API to include workloads that span multiple nodes?

Yes, we definitely want to address swap storms. No question about that.
But our established approach for NUMA policy has been to fallback to
other nodes and everybody focused on NUMA latency should use NUMA API to
achive that. Not vice versa.

As I've said in other thread, I am OK with restoring __GFP_THISNODE for
now but we should really have a very good plan for further steps. And
that involves an agreed NUMA behavior. I haven't seen any widespread
agreement on that yet though.

[...]
> > I would also re-emphasise that a major problem with addressing this
> > problem is that we do not have a general reproducible test case for
> > David's scenario where as we do have reproduction cases for the others.
> > They're not related to KVM but that doesn't matter because it's enough
> > to have a memory hog try allocating more memory than fits on a single node.
> > 
> 
> It's trivial to reproduce this issue: fragment all local memory that 
> compaction cannot resolve, do posix_memalign() for hugepage aligned 
> memory, and measure the access latency.  To fragment all local memory, you 
> can simply insert a kernel module and allocate high-order memory (just do 
> kmem_cache_alloc_node() or get_page() to pin it so compaction fails or 
> punch holes in the file as you did above).  You can do this for all memory 
> rather than the local node to measure the even more severe allocation 
> latency regression that not setting __GFP_THISNODE introduces.

Sure, but can we get some numbers from a real workload rather than an
artificial worst case? The utilization issue Mel pointed out before and
here again is a real concern IMHO. We we definitely need a better
picture to make an educated decision.
-- 
Michal Hocko
SUSE Labs
