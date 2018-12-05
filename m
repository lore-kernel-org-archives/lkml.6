Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F49C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBB5F20659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:43:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBB5F20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbeLEKnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:43:47 -0500
Received: from outbound-smtp13.blacknight.com ([46.22.139.230]:59759 "EHLO
        outbound-smtp13.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726171AbeLEKnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 05:43:47 -0500
Received: from mail.blacknight.com (unknown [81.17.254.17])
        by outbound-smtp13.blacknight.com (Postfix) with ESMTPS id B90F91C22A8
        for <linux-kernel@vger.kernel.org>; Wed,  5 Dec 2018 10:43:44 +0000 (GMT)
Received: (qmail 2932 invoked from network); 5 Dec 2018 10:43:44 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.245.71])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 5 Dec 2018 10:43:44 -0000
Date:   Wed, 5 Dec 2018 10:43:43 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     David Rientjes <rientjes@google.com>,
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
Message-ID: <20181205104343.GZ23260@techsingularity.net>
References: <CAHk-=wgVL_sxXSbjYTiGhxp6+9wLQ9ZmSN+0R5PCF6_a9pQgWw@mail.gmail.com>
 <20181203185954.GM31738@dhcp22.suse.cz>
 <CAHk-=wiNKLH2Pbnr9z2SvmDhf7XT==U6NPRkQNX13Sg-FRk0Yw@mail.gmail.com>
 <20181203201214.GB3540@redhat.com>
 <CAHk-=wg=6uxAJMbvGJC-5CSikC8OdqsjE1vw+DsCMj=2SNSnZg@mail.gmail.com>
 <CAHk-=whDg5+e2-eXYo-jwC1spt2r7JjLQSaLm4OyfGMQHLTrdw@mail.gmail.com>
 <64a4aec6-3275-a716-8345-f021f6186d9b@suse.cz>
 <20181204104558.GV23260@techsingularity.net>
 <alpine.DEB.2.21.1812041609160.213718@chino.kir.corp.google.com>
 <20181205090856.GY1286@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20181205090856.GY1286@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 10:08:56AM +0100, Michal Hocko wrote:
> On Tue 04-12-18 16:47:23, David Rientjes wrote:
> > On Tue, 4 Dec 2018, Mel Gorman wrote:
> > 
> > > What should also be kept in mind is that we should avoid conflating
> > > locality preferences with THP preferences which is separate from THP
> > > allocation latencies. The whole __GFP_THISNODE approach is pushing too
> > > hard on locality versus huge pages when MADV_HUGEPAGE or always-defrag
> > > are used which is very unfortunate given that MADV_HUGEPAGE in itself says
> > > nothing about locality -- that is the business of other madvise flags or
> > > a specific policy.
> > 
> > We currently lack those other madvise modes or mempolicies: mbind() is not 
> > a viable alternative because we do not want to oom kill when local memory 
> > is depleted, we want to fallback to remote memory.
> 
> Yes, there was a clear agreement that there is no suitable mempolicy
> right now and there were proposals to introduce MPOL_NODE_RECLAIM to
> introduce that behavior. This would be an improvement regardless of THP
> because global node-reclaim policy was simply a disaster we had to turn
> off by default and the global semantic was a reason people just gave up
> using it completely.
> 

The alternative is to define a clear semantic for THP allocation
requests that are considered "light" regardless of whether that needs a
GFP flag or not. A sensible default might be

o Allocate THP local if the amount of work is light or non-existant.
o Allocate THP remote if one is freely available with no additional work
  (maybe kick remote kcompactd)
o Allocate base page local if the amount of work is light or non-existant
o Allocate base page remote if the amount of work is light or non-existant
o Do heavy work in zonelist order until a base page is allocated somewhere

It's not something could be clearly expressed with either NORETRY or
THISNODE but longer-term might be saner than chopping and changing on
which flags are more important and which workload is most relevant. That
runs the risk of a revert-loop where each person targetting one workload
reverts one patch to insert another until someone throws up their hands
in frustration and just carries patches out-of-tree long-term.

I'm not going to prototype something along these lines for now as
fundamentally a better compaction could cut out part of the root cause
of pain.

-- 
Mel Gorman
SUSE Labs
