Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86037C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CDD22084A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbeLSQIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:08:54 -0500
Received: from outbound-smtp08.blacknight.com ([46.22.139.13]:44672 "EHLO
        outbound-smtp08.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727976AbeLSQIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 11:08:53 -0500
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp08.blacknight.com (Postfix) with ESMTPS id 3A4541C28B4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 16:08:51 +0000 (GMT)
Received: (qmail 29934 invoked from network); 19 Dec 2018 16:08:51 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.229.96])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 19 Dec 2018 16:08:51 -0000
Date:   Wed, 19 Dec 2018 16:04:01 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Linux-MM <linux-mm@kvack.org>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, ying.huang@intel.com,
        kirill@shutemov.name, Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 08/14] mm, compaction: Use the page allocator bulk-free
 helper for lists of pages
Message-ID: <20181219160401.GA31517@techsingularity.net>
References: <20181214230310.572-1-mgorman@techsingularity.net>
 <20181214230310.572-9-mgorman@techsingularity.net>
 <e5a93476-c31d-5c5e-7649-2b23188aaaac@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <e5a93476-c31d-5c5e-7649-2b23188aaaac@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 10:55:31AM +0100, Vlastimil Babka wrote:
> On 12/15/18 12:03 AM, Mel Gorman wrote:
> > release_pages() is a simpler version of free_unref_page_list() but it
> > tracks the highest PFN for caching the restart point of the compaction
> > free scanner. This patch optionally tracks the highest PFN in the core
> > helper and converts compaction to use it.
> > 
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Nit below:
> 
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -2961,18 +2961,26 @@ void free_unref_page(struct page *page)
> >  /*
> >   * Free a list of 0-order pages
> >   */
> > -void free_unref_page_list(struct list_head *list)
> > +void __free_page_list(struct list_head *list, bool dropref,
> > +				unsigned long *highest_pfn)
> >  {
> >  	struct page *page, *next;
> >  	unsigned long flags, pfn;
> >  	int batch_count = 0;
> >  
> > +	if (highest_pfn)
> > +		*highest_pfn = 0;
> > +
> >  	/* Prepare pages for freeing */
> >  	list_for_each_entry_safe(page, next, list, lru) {
> > +		if (dropref)
> > +			WARN_ON_ONCE(!put_page_testzero(page));
> 
> That will warn just once, but then page will remain with elevated count
> and free_unref_page_prepare() will warn either immediately or later
> depending on DEBUG_VM, for each page.
> Also IIRC it's legal for basically anyone to do get_page_unless_zero()
> and later put_page(), and this would now cause warning. Maybe just test
> for put_page_testzero() result without warning, and continue? Hm but
> then we should still do a list_del() and that becomes racy after
> dropping our ref...
> 

While there are cases where such a pattern is legal, this function
simply does not expect it and the callers do not violate the rule. If it
ever gets a new user that makes mistakes, they'll get the warning. Sure,
the page leaks but it'll be in a state where it's unsafe to do anything
else with it.

-- 
Mel Gorman
SUSE Labs
