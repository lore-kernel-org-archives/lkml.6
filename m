Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01833C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6D562086E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:07:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6D562086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbeJRTIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 15:08:14 -0400
Received: from mga07.intel.com ([134.134.136.100]:32513 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbeJRTIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 15:08:13 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Oct 2018 04:07:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,396,1534834800"; 
   d="scan'208";a="272358086"
Received: from aaronlu.sh.intel.com (HELO intel.com) ([10.239.159.44])
  by fmsmga005.fm.intel.com with ESMTP; 18 Oct 2018 04:07:41 -0700
Date:   Thu, 18 Oct 2018 19:07:40 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kemi Wang <kemi.wang@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [RFC v4 PATCH 2/5] mm/__free_one_page: skip merge for order-0
 page unless compaction failed
Message-ID: <20181018110740.GB6468@intel.com>
References: <20181017063330.15384-1-aaron.lu@intel.com>
 <20181017063330.15384-3-aaron.lu@intel.com>
 <20181017104427.GJ5819@techsingularity.net>
 <20181017131059.GA9167@intel.com>
 <20181017135807.GL5819@techsingularity.net>
 <6d4d1a59-bb70-d4c9-bd18-8c398a09f25f@suse.cz>
 <20181018064839.GA6468@intel.com>
 <620e624e-04ab-5c7b-c971-6377baad919a@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <620e624e-04ab-5c7b-c971-6377baad919a@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 10:23:22AM +0200, Vlastimil Babka wrote:
> On 10/18/18 8:48 AM, Aaron Lu wrote:
> > On Wed, Oct 17, 2018 at 07:03:30PM +0200, Vlastimil Babka wrote:
> >> On 10/17/18 3:58 PM, Mel Gorman wrote:
> >>> Again, as compaction is not guaranteed to find the pageblocks, it would
> >>> be important to consider whether a) that matters or b) find an
> >>> alternative way of keeping unmerged buddies on separate lists so they
> >>> can be quickly discovered when a high-order allocation fails.
> >>
> >> Agree, unmerged buddies could be on separate freelist from regular
> >> order-0 freelist. That list could be also preferred to allocations
> >> before the regular one. Then one could e.g. try "direct merging" via
> >> this list when compaction fails, or prefer direct merging to compaction
> >> for non-costly-order allocations, do direct merging when allocation
> >> context doesn't even allow compaction (atomic etc).
> > 
> > One concern regarding "direct merging" these unmerged pages via this
> > separate freelist(let's call it unmerged_free_list) is: adjacent
> > unmerged pages on the unmerged_free_list could be far away from each
> > other regarding their physical positions, so during the process of
> > merging them, the needed high order page may not be able to be formed
> > in a short time. Actually, the time could be unbound in a bad condition
> > when:
> > 1 unmerged pages adjacent on the unmerged_free_list happen to be far
> >   away from each other regarding their physical positions; and
> 
> I'm not sure I understand. Why should it matter for merging if pages are
> adjacent on the unmerged_free_list? The buddy for merging is found the
> usual way, no?

Yes it's found the usual way. I probably didn't state clear, let me try
again.

Consider a pageblock, initially as an free order9 page. Let's assume
this order9 page is expand()ed into 512 order0 pages during different
allocation requests and they go to different applications running on
different CPUs. After some time, all of them are freed back, but each
of them is freed back at different times, so they are not adjacent on
unmerged_free_list(they could be far away from each other).

In the above scenerio, merging pages on unmerged_free_list one by one
may not be an efficent way to form a high-order page, but scanning a
pageblock PFN wise could be.

Of course, the above scenerio is imagined by me as a worst case, normal
case could be much better.

> 
> > 2 there are a lot of unmerged pages on unmerged_free_list.
> 
> That will affect allocation latency, yeah. Still might be faster than
> direct compaction. And possible to do in GFP_ATOMIC context, unlike
> direct compaction.

I see, but I'm not sure if it is OK to do 'direct merging' in GFP_ATOMIC
context - it is better for cases where failure to have the high-order
page allocated is very bad, but it might not be a good idea if the caller
has a fallback mechanism, i.e. if high order page allocation failed, they
can work with order0.

> 
> > That's the reason I hooked the merging of unmerged pages in compaction
> > when isolate_migratepages_block() is scanning every page of a pageblock
> > in PFN order.
> > 
> > OTOH, if there is a kernel thread trying to reduce fragmentation by
> > doing merges for these unmerged pages, I think it's perfect fine to let
> > it iterate all unmerged pages of that list and do_merge() for all of
> > them.
> > 
> > So what about this: if kcompactd is running, let it handle these
> > unmerged pages on the list and after that, do its usual job of
> > compaction. If direct compaction is running, do not handle unmerged
> > pages on that list but rely on isolate_migratepages_block() to do the
> > merging as is done in this patchset.
> > 
> > This of course has the effect of tying compaction with 'lazy merging'.
> > If it is not desirable, what about creating a new kernel thread to do
> > the merging of unmerged pages on the list while keeping the behaviour of
> > isolate_migratepages_block() in this patchset to improve compaction
> > success rate.
> 
> Note that anything based on daemons will seem like reducing latency for
> allocations, but if we delay merging and then later do it from a daemon,
> the overall zone lock times will be essentially the same, right? The
> reduced zone lock benefits only happen when the unmerged pages get
> reallocated.

Agree.
 
> Also I would definitely consider always merging pages freed to
> >> non-MOVABLE pageblocks. We really don't want to increase the
> >> fragmentation in those. However that means it probably won't help the
> >> netperf case?
> > 
> > Yes, that would be unfortunate for all in-kernel users of page
> > allocator...
> 
> In that case there should definitely be a direct merging possibility
> IMHO, even if only as a last resort before stealing from another pageblock.
