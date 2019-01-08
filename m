Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EA8C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FD2620883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546977882;
	bh=jefd0SMZoClnZVEyGbhMRSDXSwZCy3m/IjA7jlRT7sE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iIHg5xCVJIQAgPS3A6oVi6yiEZli2xUZ+S9p4RMxTRP72J1nyTKUWSWcQHEbV0goT
	 DM6hby92nw/HxVfgXUHn4TYp4YsH/dF9oYpkjuW4yKI7nEiqw+EnbsnOT6jtWG4B7R
	 UHVtOzUMP39/xUwmgvJ2wfiF050X8b+zfoRvB+AA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730455AbfAHUEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 15:04:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:34722 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729043AbfAHUEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 15:04:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AF595AEE7;
        Tue,  8 Jan 2019 20:04:37 +0000 (UTC)
Date:   Tue, 8 Jan 2019 21:04:36 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     Arun KS <arunks@codeaurora.org>, arunks.linux@gmail.com,
        akpm@linux-foundation.org, vbabka@suse.cz, osalvador@suse.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        getarunks@gmail.com
Subject: Re: [PATCH v7] mm/page_alloc.c: memory_hotplug: free pages as higher
 order
Message-ID: <20190108200436.GK31793@dhcp22.suse.cz>
References: <1546578076-31716-1-git-send-email-arunks@codeaurora.org>
 <37498672d5b2345b1435477e78251282af42742b.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37498672d5b2345b1435477e78251282af42742b.camel@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 08-01-19 10:40:18, Alexander Duyck wrote:
> On Fri, 2019-01-04 at 10:31 +0530, Arun KS wrote:
> > When freeing pages are done with higher order, time spent on coalescing
> > pages by buddy allocator can be reduced.  With section size of 256MB, hot
> > add latency of a single section shows improvement from 50-60 ms to less
> > than 1 ms, hence improving the hot add latency by 60 times.  Modify
> > external providers of online callback to align with the change.
> > 
> > Signed-off-by: Arun KS <arunks@codeaurora.org>
> > Acked-by: Michal Hocko <mhocko@suse.com>
> > Reviewed-by: Oscar Salvador <osalvador@suse.de>
> 
> After running into my initial issue I actually had a few more questions
> about this patch.
> 
> > [...]
> > +static int online_pages_blocks(unsigned long start, unsigned long nr_pages)
> > +{
> > +	unsigned long end = start + nr_pages;
> > +	int order, ret, onlined_pages = 0;
> > +
> > +	while (start < end) {
> > +		order = min(MAX_ORDER - 1,
> > +			get_order(PFN_PHYS(end) - PFN_PHYS(start)));
> > +
> > +		ret = (*online_page_callback)(pfn_to_page(start), order);
> > +		if (!ret)
> > +			onlined_pages += (1UL << order);
> > +		else if (ret > 0)
> > +			onlined_pages += ret;
> > +
> > +		start += (1UL << order);
> > +	}
> > +	return onlined_pages;
> >  }
> >  
> 
> Should the limit for this really be MAX_ORDER - 1 or should it be
> pageblock_order? In some cases this will be the same value, but I seem
> to recall that for x86 MAX_ORDER can be several times larger than
> pageblock_order.

Does it make any difference when we are in fact trying to onine nr_pages
and we clamp to it properly?

> >  static int online_pages_range(unsigned long start_pfn, unsigned long nr_pages,
> >  			void *arg)
> >  {
> > -	unsigned long i;
> >  	unsigned long onlined_pages = *(unsigned long *)arg;
> > -	struct page *page;
> >  
> >  	if (PageReserved(pfn_to_page(start_pfn)))
> 
> I'm not sure we even really need this check. Getting back to the
> discussion I have been having with Michal in regards to the need for
> the DAX pages to not have the reserved bit cleared I was originally
> wondering if we could replace this check with a call to
> online_section_nr since the section shouldn't be online until we set
> the bit below in online_mem_sections.
> 
> However after doing some further digging it looks like this could
> probably be dropped entirely since we only call this function from
> online_pages and that function is only called by memory_block_action if
> pages_correctly_probed returns true. However pages_correctly_probed
> should return false if any of the sections contained in the page range
> is already online.

Yes you are right but I guess it would be better to address in a
separate patch that deals with PageReserved manipulation in general.
I do not think we want to remove the check silently. People who might be
interested in backporting this for whatever reason might screatch their
head why the test is not needed anymore.
-- 
Michal Hocko
SUSE Labs
