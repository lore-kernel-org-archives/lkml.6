Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6F6C43444
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5026E217D9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731075AbfACK5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 05:57:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:54524 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727909AbfACK5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 05:57:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6F173AC3D;
        Thu,  3 Jan 2019 10:57:20 +0000 (UTC)
Date:   Thu, 3 Jan 2019 10:57:17 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Fengguang Wu <fengguang.wu@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kvm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Fan Du <fan.du@intel.com>, Yao Yuan <yuan.yao@intel.com>,
        Peng Dong <dongx.peng@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Liu Jingqi <jingqi.liu@intel.com>,
        Dong Eddie <eddie.dong@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Zhang Yi <yi.z.zhang@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [RFC][PATCH v2 00/21] PMEM NUMA node and hotness
 accounting/migration
Message-ID: <20190103105717.GI28934@suse.de>
References: <20181226131446.330864849@intel.com>
 <20181227203158.GO16738@dhcp22.suse.cz>
 <20181228050806.ewpxtwo3fpw7h3lq@wfg-t540p.sh.intel.com>
 <20181228084105.GQ16738@dhcp22.suse.cz>
 <20181228094208.7lgxhha34zpqu4db@wfg-t540p.sh.intel.com>
 <20181228121515.GS16738@dhcp22.suse.cz>
 <20181228133111.zromvopkfcg3m5oy@wfg-t540p.sh.intel.com>
 <20181228195224.GY16738@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20181228195224.GY16738@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 08:52:24PM +0100, Michal Hocko wrote:
> [Ccing Mel and Andrea]
> 
> On Fri 28-12-18 21:31:11, Wu Fengguang wrote:
> > > > > I haven't looked at the implementation yet but if you are proposing a
> > > > > special cased zone lists then this is something CDM (Coherent Device
> > > > > Memory) was trying to do two years ago and there was quite some
> > > > > skepticism in the approach.
> > > > 
> > > > It looks we are pretty different than CDM. :)
> > > > We creating new NUMA nodes rather than CDM's new ZONE.
> > > > The zonelists modification is just to make PMEM nodes more separated.
> > > 
> > > Yes, this is exactly what CDM was after. Have a zone which is not
> > > reachable without explicit request AFAIR. So no, I do not think you are
> > > too different, you just use a different terminology ;)
> > 
> > Got it. OK.. The fall back zonelists patch does need more thoughts.
> > 
> > In long term POV, Linux should be prepared for multi-level memory.
> > Then there will arise the need to "allocate from this level memory".
> > So it looks good to have separated zonelists for each level of memory.
> 
> Well, I do not have a good answer for you here. We do not have good
> experiences with those systems, I am afraid. NUMA is with us for more
> than a decade yet our APIs are coarse to say the least and broken at so
> many times as well. Starting a new API just based on PMEM sounds like a
> ticket to another disaster to me.
> 
> I would like to see solid arguments why the current model of numa nodes
> with fallback in distances order cannot be used for those new
> technologies in the beginning and develop something better based on our
> experiences that we gain on the way.
> 
> I would be especially interested about a possibility of the memory
> migration idea during a memory pressure and relying on numa balancing to
> resort the locality on demand rather than hiding certain NUMA nodes or
> zones from the allocator and expose them only to the userspace.
> 

I didn't read the thread as I'm backlogged as I imagine a lot of people
are. However, I would agree that zonelists are not a good fit for something
like PMEM-based being available via a zonelist with a fake distance combined
with NUMA balancing moving pages in and out DRAM and PMEM. The same applies
to a much lesser extent for something like a special higher-speed memory
that is faster than RAM.

The fundamental problem encountered will be a hot-page-inversion issue.
In the PMEM case, DRAM fills, then PMEM starts filling except now we
know that the most recently allocated page which is potentially the most
important in terms of hotness is allocated on slower "remote" memory.
Reclaim kicks in for the DRAM node and then there is interleaving of
hotness between DRAM and PMEM with NUMA balancing then getting involved
with non-deterministic performance.

I recognise that the same problem happens for remote NUMA nodes and it
also has an inversion issue once reclaim gets involved, but it also has a
clearly defined API for dealing with that problem if applications encounter
it. It's also relatively well known given the age of the problem and how
to cope with it. It's less clear whether applications could be able to
cope of it's a more distant PMEM instead of a remote DRAM and how that
should be advertised.

This has been brought up repeatedly over the last few years since high
speed memory was first mentioned but I think long-term what we should
be thinking of is "age-based-migration" where cold pages from DRAM
get migrated to PMEM when DRAM fills and use NUMA balancing to promote
hot pages from PMEM to DRAM. It should also be workable for remote DRAM
although that *might* violate the principal of least surprise given that
applications exist that are remote NUMA aware. It might be safer overall
if such age-based-migration is specific to local-but-different-speed
memory with the main DRAM only being in the zonelists. NUMA balancing
could still optionally promote from DRAM->faster memory while aging
moves pages from fast->slow as memory pressure dictates.

There still would need to be thought on exactly how this is advertised
to userspace because while "distance" is reasonably well understood,
it's not as clear to me whether distance is appropriate to describe
"local-but-different-speed" memory given that accessing a remote
NUMA node can saturate a single link where as the same may not
be true of local-but-different-speed memory which probably has
dedicated channels. In an ideal world, application developers
interested in higher-speed-memory-reserved-for-important-use and
cheaper-lower-speed-memory could describe what sort of application
modifications they'd be willing to do but that might be unlikely.

-- 
Mel Gorman
SUSE Labs
