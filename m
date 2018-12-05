Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED01C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C74420659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:18:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C74420659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbeLEKSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:18:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:47118 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726909AbeLEKSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 05:18:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DA46EAD6F;
        Wed,  5 Dec 2018 10:18:37 +0000 (UTC)
Date:   Wed, 5 Dec 2018 11:18:36 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ying.huang@intel.com, Andrea Arcangeli <aarcange@redhat.com>,
        s.priebe@profihost.ag, mgorman@techsingularity.net,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [LKP] [mm] ac5b2c1891: vm-scalability.throughput -61.3%
 regression
Message-ID: <20181205101836.GF1286@dhcp22.suse.cz>
References: <20181203181456.GK31738@dhcp22.suse.cz>
 <CAHk-=whrfDw4yV4h2ijbX3vpXf5m4hzJ5pGX7_v6pU31RGib-g@mail.gmail.com>
 <20181203183050.GL31738@dhcp22.suse.cz>
 <CAHk-=wgVL_sxXSbjYTiGhxp6+9wLQ9ZmSN+0R5PCF6_a9pQgWw@mail.gmail.com>
 <20181203185954.GM31738@dhcp22.suse.cz>
 <alpine.DEB.2.21.1812031237340.192288@chino.kir.corp.google.com>
 <20181203212539.GR31738@dhcp22.suse.cz>
 <alpine.DEB.2.21.1812031345180.224765@chino.kir.corp.google.com>
 <20181204084821.GB1286@dhcp22.suse.cz>
 <alpine.DEB.2.21.1812041551170.213718@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1812041551170.213718@chino.kir.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 04-12-18 16:07:27, David Rientjes wrote:
> On Tue, 4 Dec 2018, Michal Hocko wrote:
> 
> > The thing I am really up to here is that reintroduction of
> > __GFP_THISNODE, which you are pushing for, will conflate madvise mode
> > resp. defrag=always with a numa placement policy because the allocation
> > doesn't fallback to a remote node.
> > 
> 
> It isn't specific to MADV_HUGEPAGE, it is the policy for all transparent 
> hugepage allocations, including defrag=always.  We agree that 
> MADV_HUGEPAGE is not exactly defined: does it mean try harder to allocate 
> a hugepage locally, try compaction synchronous to the fault, allow remote 
> fallback?  It's undefined.

Yeah, it is certainly underdefined. One thing is clear though. Using
MADV_HUGEPAGE implies that the specific mapping benefits from THPs and
is willing to pay associated init cost. This doesn't imply anything
regarding NUMA locality and as we have NUMA API it shouldn't even
attempt to do so because it would be conflating two things.
[...]

> > And that is a fundamental problem and the antipattern I am talking
> > about. Look at it this way. All normal allocations are utilizing all the
> > available memory even though they might hit a remote latency penalty. If
> > you do care about NUMA placement you have an API to enforce a specific
> > placement.  What is so different about THP to behave differently. Do
> > we really want to later invent an API to actually allow to utilize all
> > the memory? There are certainly usecases (that triggered the discussion
> > previously) that do not mind the remote latency because all other
> > benefits simply outweight it?
> > 
> 
> What is different about THP is that on every platform I have measured, 
> NUMA matters more than hugepages.  Obviously if on Broadwell, Haswell, and 
> Rome, remote hugepages were a performance win over local pages, this 
> discussion would not be happening.  Faulting local pages rather than 
> local hugepages, if possible, is easy and doesn't require reclaim.  
> Faulting remote pages rather than reclaiming local pages is easy in your 
> scenario, it's non-disruptive.

You keep ignoring all other usecases mentioned before and that is not
really helpful. Access cost can be amortized by other savings. Not to
mention NUMA balancing moving around hot THPs with remote accesses.

> So to answer "what is so different about THP?", it's the performance data.  
> The NUMA locality matters more than whether the pages are huge or not.  We 
> also have the added benefit of khugepaged being able to collapse pages 
> locally if fragmentation improves rather than being stuck accessing a 
> remote hugepage forever.

Please back your claims by a variety of workloads. Including mentioned
KVMs one. You keep hand waving about access latency completely ignoring
all other aspects and that makes my suspicious that you do not really
appreciate all the complexity here even stronger.

If there was a general consensus we want to make THP very special wrt.
numa locality, I could live with that. It would be inconsistency in the
API and as such something that will kick us sooner or later. But it
seems that _you_ are the only one to push that direction and you keep
ignoring all other usecases consistently throughout all the discussions
we have had so far. Several people keeps pointing out that this is a
wrong direction but that seems to be completely ignored.

I believe that the only way forward is back your claims by numbers
covering a larger set of THP users and prove that remote THP is
a wrong default behavior. But you cannot really push that through based
on a single usecase of yours which you refuse to describe beyond a
simple access latency metric.
-- 
Michal Hocko
SUSE Labs
