Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9851C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 07:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFAF021924
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 07:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfBHHgp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 02:36:45 -0500
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:59848 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfBHHgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 02:36:44 -0500
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x187YEIQ004889
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 8 Feb 2019 16:34:14 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x187YEHs004312;
        Fri, 8 Feb 2019 16:34:14 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x187Wdv1024689;
        Fri, 8 Feb 2019 16:34:14 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.148] [10.38.151.148]) by mail03.kamome.nec.co.jp with ESMTP id BT-MMP-2250485; Fri, 8 Feb 2019 16:31:51 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC20GP.gisp.nec.co.jp ([10.38.151.148]) with mapi id 14.03.0319.002; Fri, 8
 Feb 2019 16:31:50 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        "Andrea Arcangeli" <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] huegtlbfs: fix page leak during migration of file pages
Thread-Topic: [PATCH] huegtlbfs: fix page leak during migration of file pages
Thread-Index: AQHUuODePgsnC0Y0+kCvHMlE24frN6XUI3qAgACAsgCAADeYAIAAHE6A
Date:   Fri, 8 Feb 2019 07:31:49 +0000
Message-ID: <20190208073149.GA14423@hori1.linux.bs1.fc.nec.co.jp>
References: <20190130211443.16678-1-mike.kravetz@oracle.com>
 <917e7673-051b-e475-8711-ed012cff4c44@oracle.com>
 <20190208023132.GA25778@hori1.linux.bs1.fc.nec.co.jp>
 <07ce373a-d9ea-f3d3-35cc-5bc181901caf@oracle.com>
In-Reply-To: <07ce373a-d9ea-f3d3-35cc-5bc181901caf@oracle.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.51.8.80]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <B452139787547842A7CC02450396F598@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 09:50:30PM -0800, Mike Kravetz wrote:
> On 2/7/19 6:31 PM, Naoya Horiguchi wrote:
> > On Thu, Feb 07, 2019 at 10:50:55AM -0800, Mike Kravetz wrote:
> >> On 1/30/19 1:14 PM, Mike Kravetz wrote:
> >>> +++ b/fs/hugetlbfs/inode.c
> >>> @@ -859,6 +859,16 @@ static int hugetlbfs_migrate_page(struct address_space *mapping,
> >>>  	rc = migrate_huge_page_move_mapping(mapping, newpage, page);
> >>>  	if (rc != MIGRATEPAGE_SUCCESS)
> >>>  		return rc;
> >>> +
> >>> +	/*
> >>> +	 * page_private is subpool pointer in hugetlb pages, transfer
> >>> +	 * if needed.
> >>> +	 */
> >>> +	if (page_private(page) && !page_private(newpage)) {
> >>> +		set_page_private(newpage, page_private(page));
> >>> +		set_page_private(page, 0);
> > 
> > You don't have to copy PagePrivate flag?
> > 
> 
> Well my original thought was no.  For hugetlb pages, PagePrivate is not
> associated with page_private.  It indicates a reservation was consumed.
> It is set  when a hugetlb page is newly allocated and the allocation is
> associated with a reservation and the global reservation count is
> decremented.  When the page is added to the page cache or rmap,
> PagePrivate is cleared.  If the page is free'ed before being added to page
> cache or rmap, PagePrivate tells free_huge_page to restore (increment) the
> reserve count as we did not 'instantiate' the page.
> 
> So, PagePrivate is only set from the time a huge page is allocated until
> it is added to page cache or rmap.  My original thought was that the page
> could not be migrated during this time.  However, I am not sure if that
> reasoning is correct.  The page is not locked, so it would appear that it
> could be migrated?  But, if it can be migrated at this time then perhaps
> there are bigger issues for the (hugetlb) page fault code?

In my understanding, free hugetlb pages are not expected to be passed to
migrate_pages(), and currently that's ensured by each migration caller
which checks and avoids free hugetlb pages on its own.
migrate_pages() and its internal code are probably not aware of handling
free hugetlb pages, so if they are accidentally passed to migration code,
that's a big problem as you are concerned.
So the above reasoning should work at least this assumption is correct.

Most of migration callers are not intersted in moving free hugepages.
The one I'm not sure of is the code path from alloc_contig_range().
If someone think it's worthwhile to migrate free hugepage to get bigger
contiguous memory, he/she tries to enable that code path and the assumption
will be broken.

Thanks,
Naoya Horiguchi

> 
> >>> +
> >>> +	}
> >>> +
> >>>  	if (mode != MIGRATE_SYNC_NO_COPY)
> >>>  		migrate_page_copy(newpage, page);
> >>>  	else
> >>> diff --git a/mm/migrate.c b/mm/migrate.c
> >>> index f7e4bfdc13b7..0d9708803553 100644
> >>> --- a/mm/migrate.c
> >>> +++ b/mm/migrate.c
> >>> @@ -703,8 +703,14 @@ void migrate_page_states(struct page *newpage, struct page *page)
> >>>  	 */
> >>>  	if (PageSwapCache(page))
> >>>  		ClearPageSwapCache(page);
> >>> -	ClearPagePrivate(page);
> >>> -	set_page_private(page, 0);
> >>> +	/*
> >>> +	 * Unlikely, but PagePrivate and page_private could potentially
> >>> +	 * contain information needed at hugetlb free page time.
> >>> +	 */
> >>> +	if (!PageHuge(page)) {
> >>> +		ClearPagePrivate(page);
> >>> +		set_page_private(page, 0);
> >>> +	}
> > 
> > # This argument is mainly for existing code...
> > 
> > According to the comment on migrate_page():
> > 
> >     /*
> >      * Common logic to directly migrate a single LRU page suitable for
> >      * pages that do not use PagePrivate/PagePrivate2.
> >      *
> >      * Pages are locked upon entry and exit.
> >      */
> >     int migrate_page(struct address_space *mapping, ...
> > 
> > So this common logic assumes that page_private is not used, so why do
> > we explicitly clear page_private in migrate_page_states()?
> 
> Perhaps someone else knows.  If not, I can do some git research and
> try to find out why.
> 
> > buffer_migrate_page(), which is commonly used for the case when
> > page_private is used, does that clearing outside migrate_page_states().
> > So I thought that hugetlbfs_migrate_page() could do in the similar manner.
> > IOW, migrate_page_states() should not do anything on PagePrivate.
> > But there're a few other .migratepage callbacks, and I'm not sure all of
> > them are safe for the change, so this approach might not fit for a small fix.
> 
> I will look at those as well unless someone knows without researching.
> 
> > 
> > # BTW, there seems a typo in $SUBJECT.
> 
> Thanks!
> 
> -- 
> Mike Kravetz
> 
