Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FB1C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F7B620883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfAROKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 09:10:51 -0500
Received: from outbound-smtp12.blacknight.com ([46.22.139.17]:52688 "EHLO
        outbound-smtp12.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726881AbfAROKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 09:10:50 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp12.blacknight.com (Postfix) with ESMTPS id 64D1B1C352E
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 14:10:47 +0000 (GMT)
Received: (qmail 18577 invoked from network); 18 Jan 2019 14:10:47 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.229.96])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 18 Jan 2019 14:10:47 -0000
Date:   Fri, 18 Jan 2019 14:10:45 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Linux-MM <linux-mm@kvack.org>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>, ying.huang@intel.com,
        kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 23/25] mm, compaction: Be selective about what pageblocks
 to clear skip hints
Message-ID: <20190118141045.GQ27437@techsingularity.net>
References: <20190104125011.16071-1-mgorman@techsingularity.net>
 <20190104125011.16071-24-mgorman@techsingularity.net>
 <73c2705a-ead3-614a-0364-458d919d8e13@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <73c2705a-ead3-614a-0364-458d919d8e13@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 01:55:24PM +0100, Vlastimil Babka wrote:
> > +static bool
> > +__reset_isolation_pfn(struct zone *zone, unsigned long pfn, bool check_source,
> > +							bool check_target)
> > +{
> > +	struct page *page = pfn_to_online_page(pfn);
> > +	struct page *end_page;
> > +
> > +	if (!page)
> > +		return false;
> > +	if (zone != page_zone(page))
> > +		return false;
> > +	if (pageblock_skip_persistent(page))
> > +		return false;
> > +
> > +	/*
> > +	 * If skip is already cleared do no further checking once the
> > +	 * restart points have been set.
> > +	 */
> > +	if (check_source && check_target && !get_pageblock_skip(page))
> > +		return true;
> > +
> > +	/*
> > +	 * If clearing skip for the target scanner, do not select a
> > +	 * non-movable pageblock as the starting point.
> > +	 */
> > +	if (!check_source && check_target &&
> > +	    get_pageblock_migratetype(page) != MIGRATE_MOVABLE)
> > +		return false;
> > +
> > +	/*
> > +	 * Only clear the hint if a sample indicates there is either a
> > +	 * free page or an LRU page in the block. One or other condition
> > +	 * is necessary for the block to be a migration source/target.
> > +	 */
> > +	page = pfn_to_page(pageblock_start_pfn(pfn));
> > +	if (zone != page_zone(page))
> > +		return false;
> > +	end_page = page + pageblock_nr_pages;
> 
> Watch out for start pfn being invalid, and end_page being invalid or after zone end?
> 

Yeah, it is possible there is no alignment on pageblock_nr_pages.

> > +
> > +	do {
> > +		if (check_source && PageLRU(page)) {
> > +			clear_pageblock_skip(page);
> > +			return true;
> > +		}
> > +
> > +		if (check_target && PageBuddy(page)) {
> > +			clear_pageblock_skip(page);
> > +			return true;
> > +		}
> > +
> > +		page += (1 << PAGE_ALLOC_COSTLY_ORDER);
> 
> Also probably check pfn_valid_within() and page_zone?
> 

Again yes. Holes could have been punched.

I've an updated version but I'll shove it through tests just to be sure.

> > +	} while (page < end_page);
> > +
> > +	return false;
> > +}
> > +
> >  /*
> >   * This function is called to clear all cached information on pageblocks that
> >   * should be skipped for page isolation when the migrate and free page scanner
> 
> ...
> 
> > @@ -1193,7 +1273,7 @@ fast_isolate_freepages(struct compact_control *cc)
> >  	 * If starting the scan, use a deeper search and use the highest
> >  	 * PFN found if a suitable one is not found.
> >  	 */
> > -	if (cc->free_pfn == pageblock_start_pfn(zone_end_pfn(cc->zone) - 1)) {
> > +	if (cc->free_pfn >= cc->zone->compact_init_free_pfn) {
> >  		limit = pageblock_nr_pages >> 1;
> >  		scan_start = true;
> >  	}
> > @@ -1338,7 +1418,6 @@ static void isolate_freepages(struct compact_control *cc)
> >  	unsigned long isolate_start_pfn; /* exact pfn we start at */
> >  	unsigned long block_end_pfn;	/* end of current pageblock */
> >  	unsigned long low_pfn;	     /* lowest pfn scanner is able to scan */
> > -	unsigned long nr_isolated;
> >  	struct list_head *freelist = &cc->freepages;
> >  	unsigned int stride;
> >  
> > @@ -1374,6 +1453,8 @@ static void isolate_freepages(struct compact_control *cc)
> >  				block_end_pfn = block_start_pfn,
> >  				block_start_pfn -= pageblock_nr_pages,
> >  				isolate_start_pfn = block_start_pfn) {
> > +		unsigned long nr_isolated;
> 
> Unrelated cleanup? Nevermind.
> 

I'll move the hunks to "mm, compaction: Sample pageblocks for free
pages" where they belong

-- 
Mel Gorman
SUSE Labs
