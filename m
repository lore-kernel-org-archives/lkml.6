Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEBCC67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 09:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 008E42150F
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 09:00:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 008E42150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbeJTRJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 13:09:50 -0400
Received: from mga03.intel.com ([134.134.136.65]:27767 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727178AbeJTRJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 13:09:49 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Oct 2018 02:00:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,403,1534834800"; 
   d="scan'208";a="96889587"
Received: from aaronlu.sh.intel.com (HELO intel.com) ([10.239.159.44])
  by fmsmga002.fm.intel.com with ESMTP; 20 Oct 2018 02:00:03 -0700
Date:   Sat, 20 Oct 2018 17:00:02 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kemi Wang <kemi.wang@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Tariq Toukan <tariqt@mellanox.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [RFC v4 PATCH 2/5] mm/__free_one_page: skip merge for order-0
 page unless compaction failed
Message-ID: <20181020090002.GA13858@intel.com>
References: <20181017063330.15384-1-aaron.lu@intel.com>
 <20181017063330.15384-3-aaron.lu@intel.com>
 <20181017104427.GJ5819@techsingularity.net>
 <20181017131059.GA9167@intel.com>
 <20181017135807.GL5819@techsingularity.net>
 <20181017145904.GC9167@intel.com>
 <20181018111632.GM5819@techsingularity.net>
 <20181019055703.GA2401@intel.com>
 <20181019085435.GR5819@techsingularity.net>
 <20181019150053.iaubsdtcsi64mqb7@ca-dmjordan1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181019150053.iaubsdtcsi64mqb7@ca-dmjordan1.us.oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 08:00:53AM -0700, Daniel Jordan wrote:
> On Fri, Oct 19, 2018 at 09:54:35AM +0100, Mel Gorman wrote:
> > On Fri, Oct 19, 2018 at 01:57:03PM +0800, Aaron Lu wrote:
> > > > 
> > > > I don't think this is the right way of thinking about it because it's
> > > > possible to have the system split in such a way so that the migration
> > > > scanner only encounters unmovable pages before it meets the free scanner
> > > > where unmerged buddies were in the higher portion of the address space.
> > > 
> > > Yes it is possible unmerged pages are in the higher portion.
> > > 
> > > My understanding is, when the two scanners meet, all unmerged pages will
> > > be either used by the free scanner as migrate targets or sent to merge
> > > by the migration scanner.
> > > 
> > 
> > It's not guaranteed if the lower portion of the address space consisted
> > entirely of pages that cannot migrate (because they are unmovable or because
> > migration failed due to pins). It's actually a fundamental limitation
> > of compaction that it can miss migration and compaction opportunities
> > due to how the scanners are implemented. It was designed that way to
> > avoid pageblocks being migrated unnecessarily back and forth but the
> > downside is missed opportunities.
> > 
> > > > You either need to keep unmerged buddies on a separate list or search
> > > > the order-0 free list for merge candidates prior to compaction.
> > > > 
> > > > > > It's needed to form them efficiently but excessive reclaim or writing 3
> > > > > > to drop_caches can also do it. Be careful of tying lazy buddy too
> > > > > > closely to compaction.
> > > > > 
> > > > > That's the current design of this patchset, do you see any immediate
> > > > > problem of this? Is it that you are worried about high-order allocation
> > > > > success rate using this design?
> > > > 
> > > > I've pointed out what I see are the design flaws but yes, in general, I'm
> > > > worried about the high order allocation success rate using this design,
> > > > the reliance on compaction and the fact that the primary motivation is
> > > > when THP is disabled.
> > > 
> > > When THP is in use, zone lock contention is pretty much nowhere :-)
> > > 
> > > I'll see what I can get with 'address space range' lock first and will
> > > come back to 'lazy buddy' if it doesn't work out.
> 
> With the address space range idea, wouldn't the zone free_area require changes
> too?  I can't see how locking by address range could synchronize it as it
> exists now otherwise, with per order/mt list heads.
> 
> One idea is to further subdivide the free area according to how the locking
> works and find some reasonable way to handle having to search for pages of a
> given order/mt in multiple places.

I plan to create one free_are per 'address space range'. The challenge
will be how to quickly locate a free_area that has the required free
page on allocation path. Other details like how big the address space
range should be etc. will need to be explored with testing.

I think this approach is worth a try because it wouldn't cause
fragmentation.
