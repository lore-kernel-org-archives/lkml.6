Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F390DC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C80CC20660
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbfAHVxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 16:53:05 -0500
Received: from mga09.intel.com ([134.134.136.24]:7912 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729838AbfAHVxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 16:53:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2019 13:53:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,455,1539673200"; 
   d="scan'208";a="105029250"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga007.jf.intel.com with ESMTP; 08 Jan 2019 13:53:03 -0800
Message-ID: <bbb4c6e046bb37b4a81573f5547cfb946cebe972.camel@linux.intel.com>
Subject: Re: [PATCH v7] mm/page_alloc.c: memory_hotplug: free pages as
 higher order
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Arun KS <arunks@codeaurora.org>, arunks.linux@gmail.com,
        akpm@linux-foundation.org, vbabka@suse.cz, osalvador@suse.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        getarunks@gmail.com
Date:   Tue, 08 Jan 2019 13:53:03 -0800
In-Reply-To: <20190108200436.GK31793@dhcp22.suse.cz>
References: <1546578076-31716-1-git-send-email-arunks@codeaurora.org>
         <37498672d5b2345b1435477e78251282af42742b.camel@linux.intel.com>
         <20190108200436.GK31793@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-01-08 at 21:04 +0100, Michal Hocko wrote:
> On Tue 08-01-19 10:40:18, Alexander Duyck wrote:
> > On Fri, 2019-01-04 at 10:31 +0530, Arun KS wrote:
> > > When freeing pages are done with higher order, time spent on coalescing
> > > pages by buddy allocator can be reduced.  With section size of 256MB, hot
> > > add latency of a single section shows improvement from 50-60 ms to less
> > > than 1 ms, hence improving the hot add latency by 60 times.  Modify
> > > external providers of online callback to align with the change.
> > > 
> > > Signed-off-by: Arun KS <arunks@codeaurora.org>
> > > Acked-by: Michal Hocko <mhocko@suse.com>
> > > Reviewed-by: Oscar Salvador <osalvador@suse.de>
> > 
> > After running into my initial issue I actually had a few more questions
> > about this patch.
> > 
> > > [...]
> > > +static int online_pages_blocks(unsigned long start, unsigned long nr_pages)
> > > +{
> > > +	unsigned long end = start + nr_pages;
> > > +	int order, ret, onlined_pages = 0;
> > > +
> > > +	while (start < end) {
> > > +		order = min(MAX_ORDER - 1,
> > > +			get_order(PFN_PHYS(end) - PFN_PHYS(start)));
> > > +
> > > +		ret = (*online_page_callback)(pfn_to_page(start), order);
> > > +		if (!ret)
> > > +			onlined_pages += (1UL << order);
> > > +		else if (ret > 0)
> > > +			onlined_pages += ret;
> > > +
> > > +		start += (1UL << order);
> > > +	}
> > > +	return onlined_pages;
> > >  }
> > >  
> > 
> > Should the limit for this really be MAX_ORDER - 1 or should it be
> > pageblock_order? In some cases this will be the same value, but I seem
> > to recall that for x86 MAX_ORDER can be several times larger than
> > pageblock_order.
> 
> Does it make any difference when we are in fact trying to onine nr_pages
> and we clamp to it properly?

I'm not entirely sure if it does or not.

What I notice looking through the code though is that there are a
number of checks for the pageblock migrate type. There ends up being
checks in __free_one_page, free_one_page, and __free_pages_ok all
related to this. It might be moot since we are starting with a offline
section, but I just brought this up because I know in the case of
deferred page init we were limiting ourselves to pageblock_order and I
wasn't sure if there was some specific reason for doing that.

> > >  static int online_pages_range(unsigned long start_pfn, unsigned long nr_pages,
> > >  			void *arg)
> > >  {
> > > -	unsigned long i;
> > >  	unsigned long onlined_pages = *(unsigned long *)arg;
> > > -	struct page *page;
> > >  
> > >  	if (PageReserved(pfn_to_page(start_pfn)))
> > 
> > I'm not sure we even really need this check. Getting back to the
> > discussion I have been having with Michal in regards to the need for
> > the DAX pages to not have the reserved bit cleared I was originally
> > wondering if we could replace this check with a call to
> > online_section_nr since the section shouldn't be online until we set
> > the bit below in online_mem_sections.
> > 
> > However after doing some further digging it looks like this could
> > probably be dropped entirely since we only call this function from
> > online_pages and that function is only called by memory_block_action if
> > pages_correctly_probed returns true. However pages_correctly_probed
> > should return false if any of the sections contained in the page range
> > is already online.
> 
> Yes you are right but I guess it would be better to address in a
> separate patch that deals with PageReserved manipulation in general.
> I do not think we want to remove the check silently. People who might be
> interested in backporting this for whatever reason might screatch their
> head why the test is not needed anymore.

Yeah I am already working on that, it is what led me to review this
patch. Just thought I would bring it up since it would make it possible
to essentially reduce the size and/or need for a new function.

