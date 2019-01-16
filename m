Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED707C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C87B120657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394219AbfAPPoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:44:03 -0500
Received: from outbound-smtp11.blacknight.com ([46.22.139.106]:42106 "EHLO
        outbound-smtp11.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2394207AbfAPPoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 10:44:02 -0500
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp11.blacknight.com (Postfix) with ESMTPS id 812D71C2611
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 15:44:00 +0000 (GMT)
Received: (qmail 4602 invoked from network); 16 Jan 2019 15:44:00 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.229.96])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 16 Jan 2019 15:44:00 -0000
Date:   Wed, 16 Jan 2019 15:43:58 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Linux-MM <linux-mm@kvack.org>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>, ying.huang@intel.com,
        kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 11/25] mm, compaction: Use free lists to quickly locate a
 migration source
Message-ID: <20190116154358.GF27437@techsingularity.net>
References: <20190104125011.16071-1-mgorman@techsingularity.net>
 <20190104125011.16071-12-mgorman@techsingularity.net>
 <f1e0e977-d901-776d-9a6a-799735ebd3bf@suse.cz>
 <20190116143308.GE27437@techsingularity.net>
 <d232eb5a-065f-742f-35e3-b06cfdfbeb69@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <d232eb5a-065f-742f-35e3-b06cfdfbeb69@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 04:00:22PM +0100, Vlastimil Babka wrote:
> On 1/16/19 3:33 PM, Mel Gorman wrote:
> >>> +				break;
> >>> +			}
> >>> +
> >>> +			/*
> >>> +			 * If low PFNs are being found and discarded then
> >>> +			 * limit the scan as fast searching is finding
> >>> +			 * poor candidates.
> >>> +			 */
> >>
> >> I wonder about the "low PFNs are being found and discarded" part. Maybe
> >> I'm missing it, but I don't see them being discarded above, this seems
> >> to be the first check against cc->migrate_pfn. With the min() part in
> >> update_fast_start_pfn(), does it mean we can actually go back and rescan
> >> (or skip thanks to skip bits, anyway) again pageblocks that we already
> >> scanned?
> >>
> > 
> > Extremely poor phrasing. My mind was thinking in terms of discarding
> > unsuitable candidates as they were below the migration scanner and it
> > did not translate properly.
> > 
> > Based on your feedback, how does the following untested diff look?
> 
> IMHO better. Meanwhile I noticed that the next patch removes the
> set_pageblock_skip() so maybe it's needless churn to introduce the
> fast_find_block, but I'll check more closely.
> 

Indeed but the patches should standalone and preserve bisection as best
as possible so while it's weird looking, I'll add the logic and just take
it back out again in the next patch. Merging the patches together would
be lead to a tricky review!

> The new comment about pfns below cc->migrate_pfn is better but I still
> wonder if it would be better to really skip over those candidates (they
> are still called unsuitable) and not go backwards with cc->migrate_pfn.
> But if you think the pageblock skip bits and halving of limit minimizes
> pointless rescan sufficiently, then fine.

I'll check if it works out better to ensure they are really skipped.

-- 
Mel Gorman
SUSE Labs
