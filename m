Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDB6C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73C6320659
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:54:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73C6320659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730656AbeKTFSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 00:18:51 -0500
Received: from mga06.intel.com ([134.134.136.31]:32124 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726425AbeKTFSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 00:18:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2018 10:53:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,253,1539673200"; 
   d="scan'208";a="93283070"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga008.jf.intel.com with ESMTP; 19 Nov 2018 10:53:58 -0800
Message-ID: <5815470723f5e97bc26bad42da219598e2775837.camel@linux.intel.com>
Subject: Re: [mm PATCH v5 4/7] mm: Initialize MAX_ORDER_NR_PAGES at a time
 instead of doing larger sections
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, davem@davemloft.net,
        pavel.tatashin@microsoft.com, mhocko@suse.com, mingo@kernel.org,
        kirill.shutemov@linux.intel.com, dan.j.williams@intel.com,
        dave.jiang@intel.com, rppt@linux.vnet.ibm.com, willy@infradead.org,
        vbabka@suse.cz, khalid.aziz@oracle.com, ldufour@linux.vnet.ibm.com,
        mgorman@techsingularity.net, yi.z.zhang@linux.intel.com
Date:   Mon, 19 Nov 2018 10:53:58 -0800
In-Reply-To: <20181110010238.jnabddtfpr5kjhdz@xakep.localdomain>
References: <154145268025.30046.11742652345962594283.stgit@ahduyck-desk1.jf.intel.com>
         <154145278583.30046.4918131143612801028.stgit@ahduyck-desk1.jf.intel.com>
         <20181110010238.jnabddtfpr5kjhdz@xakep.localdomain>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-11-09 at 20:02 -0500, Pavel Tatashin wrote:
> On 18-11-05 13:19:45, Alexander Duyck wrote:
> >  	}
> > -	first_init_pfn = max(zone->zone_start_pfn, first_init_pfn);
> > +
> > +	/* If the zone is empty somebody else may have cleared out the zone */
> > +	if (!deferred_init_mem_pfn_range_in_zone(&i, zone, &spfn, &epfn,
> > +						 first_init_pfn)) {
> > +		pgdat_resize_unlock(pgdat, &flags);
> > +		pgdat_init_report_one_done();
> > +		return 0;
> 
> It would make more sense to add goto to the end of this function and report
> that in Node X had 0 pages initialized. Otherwise, it will be confusing
> why some nodes are not initialized during boot. It is simply because
> they do not have deferred pages left to be initialized.

This part makes sense and will be implemented for v6.

> 
> > +	}
> >  
> >  	/*
> > -	 * Initialize and free pages. We do it in two loops: first we initialize
> > -	 * struct page, than free to buddy allocator, because while we are
> > -	 * freeing pages we can access pages that are ahead (computing buddy
> > -	 * page in __free_one_page()).
> > +	 * Initialize and free pages in MAX_ORDER sized increments so
> > +	 * that we can avoid introducing any issues with the buddy
> > +	 * allocator.
> >  	 */
> > -	for_each_free_mem_pfn_range_in_zone(i, zone, &spfn, &epfn) {
> > -		spfn = max_t(unsigned long, first_init_pfn, spfn);
> > -		nr_pages += deferred_init_pages(zone, spfn, epfn);
> > -	}
> > -	for_each_free_mem_pfn_range_in_zone(i, zone, &spfn, &epfn) {
> > -		spfn = max_t(unsigned long, first_init_pfn, spfn);
> > -		deferred_free_pages(spfn, epfn);
> > -	}
> > +	while (spfn < epfn)
> > +		nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
> > +
> >  	pgdat_resize_unlock(pgdat, &flags);
> >  
> >  	/* Sanity check that the next zone really is unpopulated */
> > @@ -1602,9 +1689,9 @@ deferred_grow_zone(struct zone *zone, unsigned int order)
> >  {
> 
> How about order = max(order, max_order)?

I'm not sure what you are getting at here? The "order" variable passed
is only really used to get the nr_pages_needed, and that value is
rounded up to PAGES_PER_SECTION which should always be equal to or
greater than MAX_ORDER pages.

If order is greater than MAX_ORDER we would want to process some number
of MAX_ORDER sized blocks until we get to the size specified by order.
If we process it all as one large block it will perform worse as we
risk pushing page structs out of the cache.

> >  	unsigned long nr_pages_needed = ALIGN(1 << order, PAGES_PER_SECTION);
> 
> 
> > -	first_init_pfn = max(zone->zone_start_pfn, first_deferred_pfn);
> > -
> > -	if (first_init_pfn >= pgdat_end_pfn(pgdat)) {
> > +	/* If the zone is empty somebody else may have cleared out the zone */
> > +	if (!deferred_init_mem_pfn_range_in_zone(&i, zone, &spfn, &epfn,
> > +						 first_deferred_pfn)) {
> >  		pgdat_resize_unlock(pgdat, &flags);
> > -		return false;
> > +		return true;
> 
> I am OK to change to true here, please also set
> pgdat->first_deferred_pfn to ULONG_MAX to indicate that there are no
> more deferred pages in this node.

Done for v6 of the patch set.

> 
> Overall, I like this patch, makes things a lot easier, assuming the
> above is addressed:
> 
> Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> 
> Thank you,
> Pasha

