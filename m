Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE960C282D7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 02:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA4920836
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 02:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbfBLC2g convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 21:28:36 -0500
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:40021 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbfBLC2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 21:28:35 -0500
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x1C2SDTt005703
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 12 Feb 2019 11:28:13 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x1C2SDt8023625;
        Tue, 12 Feb 2019 11:28:13 +0900
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x1C2R5hR011347;
        Tue, 12 Feb 2019 11:28:13 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.152] [10.38.151.152]) by mail02.kamome.nec.co.jp with ESMTP id BT-MMP-2305838; Tue, 12 Feb 2019 11:24:30 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC24GP.gisp.nec.co.jp ([10.38.151.152]) with mapi id 14.03.0319.002; Tue,
 12 Feb 2019 11:24:29 +0900
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
Thread-Index: AQHUuODePgsnC0Y0+kCvHMlE24frN6XUI3qAgACAsgCAADeYAIAAHE6AgAW8IYCAADdTAA==
Date:   Tue, 12 Feb 2019 02:24:28 +0000
Message-ID: <20190212022428.GA12369@hori1.linux.bs1.fc.nec.co.jp>
References: <20190130211443.16678-1-mike.kravetz@oracle.com>
 <917e7673-051b-e475-8711-ed012cff4c44@oracle.com>
 <20190208023132.GA25778@hori1.linux.bs1.fc.nec.co.jp>
 <07ce373a-d9ea-f3d3-35cc-5bc181901caf@oracle.com>
 <20190208073149.GA14423@hori1.linux.bs1.fc.nec.co.jp>
 <ffe58925-a301-6791-44d5-e3bec7f9ebf3@oracle.com>
In-Reply-To: <ffe58925-a301-6791-44d5-e3bec7f9ebf3@oracle.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.51.8.82]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <69DFA1325EDE5E42AA1565A296EAB74D@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 03:06:27PM -0800, Mike Kravetz wrote:
> On 2/7/19 11:31 PM, Naoya Horiguchi wrote:
> > On Thu, Feb 07, 2019 at 09:50:30PM -0800, Mike Kravetz wrote:
> >> On 2/7/19 6:31 PM, Naoya Horiguchi wrote:
> >>> On Thu, Feb 07, 2019 at 10:50:55AM -0800, Mike Kravetz wrote:
> >>>> On 1/30/19 1:14 PM, Mike Kravetz wrote:
> >>>>> +++ b/fs/hugetlbfs/inode.c
> >>>>> @@ -859,6 +859,16 @@ static int hugetlbfs_migrate_page(struct address_space *mapping,
> >>>>>  	rc = migrate_huge_page_move_mapping(mapping, newpage, page);
> >>>>>  	if (rc != MIGRATEPAGE_SUCCESS)
> >>>>>  		return rc;
> >>>>> +
> >>>>> +	/*
> >>>>> +	 * page_private is subpool pointer in hugetlb pages, transfer
> >>>>> +	 * if needed.
> >>>>> +	 */
> >>>>> +	if (page_private(page) && !page_private(newpage)) {
> >>>>> +		set_page_private(newpage, page_private(page));
> >>>>> +		set_page_private(page, 0);
> >>>
> >>> You don't have to copy PagePrivate flag?
> >>>
> >>
> >> Well my original thought was no.  For hugetlb pages, PagePrivate is not
> >> associated with page_private.  It indicates a reservation was consumed.
> >> It is set  when a hugetlb page is newly allocated and the allocation is
> >> associated with a reservation and the global reservation count is
> >> decremented.  When the page is added to the page cache or rmap,
> >> PagePrivate is cleared.  If the page is free'ed before being added to page
> >> cache or rmap, PagePrivate tells free_huge_page to restore (increment) the
> >> reserve count as we did not 'instantiate' the page.
> >>
> >> So, PagePrivate is only set from the time a huge page is allocated until
> >> it is added to page cache or rmap.  My original thought was that the page
> >> could not be migrated during this time.  However, I am not sure if that
> >> reasoning is correct.  The page is not locked, so it would appear that it
> >> could be migrated?  But, if it can be migrated at this time then perhaps
> >> there are bigger issues for the (hugetlb) page fault code?
> > 
> > In my understanding, free hugetlb pages are not expected to be passed to
> > migrate_pages(), and currently that's ensured by each migration caller
> > which checks and avoids free hugetlb pages on its own.
> > migrate_pages() and its internal code are probably not aware of handling
> > free hugetlb pages, so if they are accidentally passed to migration code,
> > that's a big problem as you are concerned.
> > So the above reasoning should work at least this assumption is correct.
> > 
> > Most of migration callers are not intersted in moving free hugepages.
> > The one I'm not sure of is the code path from alloc_contig_range().
> > If someone think it's worthwhile to migrate free hugepage to get bigger
> > contiguous memory, he/she tries to enable that code path and the assumption
> > will be broken.
> 
> You are correct.  We do not migrate free huge pages.  I was thinking more
> about problems if we migrate a page while it is being added to a task's page
> table as in hugetlb_no_page.
> 
> Commit bcc54222309c ("mm: hugetlb: introduce page_huge_active") addresses
> this issue, but I believe there is a bug in the implementation.
> isolate_huge_page contains this test:
> 
> 	if (!page_huge_active(page) || !get_page_unless_zero(page)) {
> 		ret = false;
> 		goto unlock;
> 	}
> 
> If the condition is not met, then the huge page can be isolated and migrated.
> 
> In hugetlb_no_page, there is this block of code:
> 
>                 page = alloc_huge_page(vma, haddr, 0);
>                 if (IS_ERR(page)) {
>                         ret = vmf_error(PTR_ERR(page));
>                         goto out;
>                 }
>                 clear_huge_page(page, address, pages_per_huge_page(h));
>                 __SetPageUptodate(page);
>                 set_page_huge_active(page);
> 
>                 if (vma->vm_flags & VM_MAYSHARE) {
>                         int err = huge_add_to_page_cache(page, mapping, idx);
>                         if (err) {
>                                 put_page(page);
>                                 if (err == -EEXIST)
>                                         goto retry;
>                                 goto out;
>                         }
>                 } else {
>                         lock_page(page);
>                         if (unlikely(anon_vma_prepare(vma))) {
>                                 ret = VM_FAULT_OOM;
>                                 goto backout_unlocked;
>                         }
>                         anon_rmap = 1;
>                 }
>         } else {
> 
> Note that we call set_page_huge_active BEFORE locking the page.  This
> means that we can isolate the page and have migration take place while
> we continue to add the page to page tables.  I was able to make this
> happen by adding a udelay() after set_page_huge_active to simulate worst
> case scheduling behavior.  It resulted in VM_BUG_ON while unlocking page.
> My test had several threads faulting in huge pages.  Another thread was
> offlining the memory blocks forcing migration.

This shows another problem, so I agree we need a fix.

> 
> To fix this, we need to delay the set_page_huge_active call until after
> the page is locked.  I am testing a patch with this change.  Perhaps we
> should even delay calling set_page_huge_active until we know there are
> no errors and we know the page is actually in page tables?

Yes, calling set_page_huge_active after page table is set up sounds nice to me.

> 
> While looking at this, I think there is another issue.  When a hugetlb
> page is migrated, we do not migrate the 'page_huge_active' state of the
> page.  That should be moved as the page is migrated.  Correct?

Yes, and I think that putback_active_hugepage(new_hpage) at the last step
of migration sequence handles the copying of 'page_huge_active' state.

Thanks,
Naoya Horiguchi
