Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A42C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF166217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550509564;
	bh=jkjMWOOKX58tCXXccyGbW+1i57yN5F4kf0V2C6P2cVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tpsVxGfLahcnvACUlL+2RD/t6z6Fy7Zg9QdgQpmIM9KqV/qoHV/HDSaAA29Nwde+W
	 v33Cz0D7Klbdxl/GtLfW/THMjHroj4Q8t9EUkdy8pNA8nSbFI+kggNuNjT5kfEu5T2
	 uza0RA5FcztpahRmvspZ8gwgkcPCsrplGbWljFZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390977AbfBRRGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 12:06:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:56424 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387990AbfBRRGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 12:06:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7AA8EADD3;
        Mon, 18 Feb 2019 17:06:00 +0000 (UTC)
Date:   Mon, 18 Feb 2019 18:05:58 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Rong Chen <rong.a.chen@intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>, LKP <lkp@01.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [LKP] efad4e475c [ 40.308255] Oops: 0000 [#1] PREEMPT SMP PTI
Message-ID: <20190218170558.GV4525@dhcp22.suse.cz>
References: <20190218052823.GH29177@shao2-debian>
 <20190218070844.GC4525@dhcp22.suse.cz>
 <20190218085510.GC7251@dhcp22.suse.cz>
 <4c75d424-2c51-0d7d-5c28-78c15600e93c@intel.com>
 <20190218103013.GK4525@dhcp22.suse.cz>
 <20190218140515.GF25446@rapoport-lnx>
 <20190218152050.GS4525@dhcp22.suse.cz>
 <20190218152213.GT4525@dhcp22.suse.cz>
 <20190218164813.GG25446@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190218164813.GG25446@rapoport-lnx>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 18-02-19 18:48:14, Mike Rapoport wrote:
> On Mon, Feb 18, 2019 at 04:22:13PM +0100, Michal Hocko wrote:
[...]
> > Thinking about it some more, is it possible that we are overflowing by 1
> > here?
> 
> Looks like that, the end_pfn is actually the first pfn in the next section.

Thanks for the confirmation. I guess it also exaplains why nobody has
noticed this off-by-one. Most people seem to use VMEMMAP SPARSE model
and we are safe there.

> > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > index 124e794867c5..6618b9d3e53a 100644
> > --- a/mm/memory_hotplug.c
> > +++ b/mm/memory_hotplug.c
> > @@ -1234,10 +1234,10 @@ bool is_mem_section_removable(unsigned long start_pfn, unsigned long nr_pages)
> >  {
> >  	struct page *page = pfn_to_page(start_pfn);
> >  	unsigned long end_pfn = min(start_pfn + nr_pages, zone_end_pfn(page_zone(page)));
> > -	struct page *end_page = pfn_to_page(end_pfn);
> > +	struct page *end_page = pfn_to_page(end_pfn - 1);
> >  
> >  	/* Check the starting page of each pageblock within the range */
> > -	for (; page < end_page; page = next_active_pageblock(page)) {
> > +	for (; page <= end_page; page = next_active_pageblock(page)) {
> >  		if (!is_pageblock_removable_nolock(page))
> >  			return false;
> >  		cond_resched();
> 
> Works with your fix, but I think mine is more intuitive ;-)

I would rather go and rework this to pfns. What about this instead.
Slightly larger but arguably cleared code?

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 124e794867c5..a799a0bdbf34 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1188,11 +1188,13 @@ static inline int pageblock_free(struct page *page)
 	return PageBuddy(page) && page_order(page) >= pageblock_order;
 }
 
-/* Return the start of the next active pageblock after a given page */
-static struct page *next_active_pageblock(struct page *page)
+/* Return the pfn of the start of the next active pageblock after a given pfn */
+static unsigned long next_active_pageblock(unsigned long pfn)
 {
+	struct page *page = pfn_to_page(pfn);
+
 	/* Ensure the starting page is pageblock-aligned */
-	BUG_ON(page_to_pfn(page) & (pageblock_nr_pages - 1));
+	BUG_ON(pfn & (pageblock_nr_pages - 1));
 
 	/* If the entire pageblock is free, move to the end of free page */
 	if (pageblock_free(page)) {
@@ -1200,16 +1202,16 @@ static struct page *next_active_pageblock(struct page *page)
 		/* be careful. we don't have locks, page_order can be changed.*/
 		order = page_order(page);
 		if ((order < MAX_ORDER) && (order >= pageblock_order))
-			return page + (1 << order);
+			return pfn + (1 << order);
 	}
 
-	return page + pageblock_nr_pages;
+	return pfn + pageblock_nr_pages;
 }
 
-static bool is_pageblock_removable_nolock(struct page *page)
+static bool is_pageblock_removable_nolock(unsigned long pfn)
 {
+	struct page *page = pfn_to_page(pfn);
 	struct zone *zone;
-	unsigned long pfn;
 
 	/*
 	 * We have to be careful here because we are iterating over memory
@@ -1232,13 +1234,14 @@ static bool is_pageblock_removable_nolock(struct page *page)
 /* Checks if this range of memory is likely to be hot-removable. */
 bool is_mem_section_removable(unsigned long start_pfn, unsigned long nr_pages)
 {
-	struct page *page = pfn_to_page(start_pfn);
-	unsigned long end_pfn = min(start_pfn + nr_pages, zone_end_pfn(page_zone(page)));
-	struct page *end_page = pfn_to_page(end_pfn);
+	unsigned long end_pfn;
+
+	end_pfn = min(start_pfn + nr_pages,
+			zone_end_pfn(page_zone(pfn_to_page(start_pfn))));
 
 	/* Check the starting page of each pageblock within the range */
-	for (; page < end_page; page = next_active_pageblock(page)) {
-		if (!is_pageblock_removable_nolock(page))
+	for (; start_pfn < end_pfn; start_pfn = next_active_pageblock(start_pfn)) {
+		if (!is_pageblock_removable_nolock(start_pfn))
 			return false;
 		cond_resched();
 	}
-- 
Michal Hocko
SUSE Labs
