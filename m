Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25270C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 07:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BED7820851
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 07:30:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BED7820851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbeHWK6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 06:58:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:46942 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726068AbeHWK6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 06:58:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2888EAFF9;
        Thu, 23 Aug 2018 07:30:36 +0000 (UTC)
Date:   Thu, 23 Aug 2018 09:30:35 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mm: migration: fix migration of huge PMD shared
 pages
Message-ID: <20180823073035.GT29735@dhcp22.suse.cz>
References: <20180821205902.21223-2-mike.kravetz@oracle.com>
 <201808220831.eM0je51n%fengguang.wu@intel.com>
 <975b740d-26a6-eb3f-c8ca-1a9995d0d343@oracle.com>
 <20180822122848.GL29735@dhcp22.suse.cz>
 <4a95a24f-534f-0938-f358-2a410817a412@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a95a24f-534f-0938-f358-2a410817a412@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 22-08-18 09:48:16, Mike Kravetz wrote:
> On 08/22/2018 05:28 AM, Michal Hocko wrote:
> > On Tue 21-08-18 18:10:42, Mike Kravetz wrote:
> > [...]
> >> diff --git a/mm/rmap.c b/mm/rmap.c
> >> index eb477809a5c0..8cf853a4b093 100644
> >> --- a/mm/rmap.c
> >> +++ b/mm/rmap.c
> >> @@ -1362,11 +1362,21 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
> >>  	}
> >>  
> >>  	/*
> >> -	 * We have to assume the worse case ie pmd for invalidation. Note that
> >> -	 * the page can not be free in this function as call of try_to_unmap()
> >> -	 * must hold a reference on the page.
> >> +	 * For THP, we have to assume the worse case ie pmd for invalidation.
> >> +	 * For hugetlb, it could be much worse if we need to do pud
> >> +	 * invalidation in the case of pmd sharing.
> >> +	 *
> >> +	 * Note that the page can not be free in this function as call of
> >> +	 * try_to_unmap() must hold a reference on the page.
> >>  	 */
> >>  	end = min(vma->vm_end, start + (PAGE_SIZE << compound_order(page)));
> >> +	if (PageHuge(page)) {
> >> +		/*
> >> +		 * If sharing is possible, start and end will be adjusted
> >> +		 * accordingly.
> >> +		 */
> >> +		(void)huge_pmd_sharing_possible(vma, &start, &end);
> >> +	}
> >>  	mmu_notifier_invalidate_range_start(vma->vm_mm, start, end);
> > 
> > I do not get this part. Why don't we simply unconditionally invalidate
> > the whole huge page range?
> 
> In this routine, we are only unmapping a single page.  The existing code
> is limiting the invalidate range to that page size: 4K or 2M.  With shared
> PMDs, we have the possibility of unmapping a PUD_SIZE area: 1G.  I don't
> think we want to unconditionally invalidate 1G.  Is that what you are asking?

But we know that huge_pmd_unshare unmapped a shared pte so we know when
to flush 2MB or 1GB. I really do not like how huge_pmd_sharing_possible
a) duplicates some checks and b) it updates start/stop out of line.

> I do not know how often PMD sharing is exercised.  It certainly is used by
> DBs for large shared areas.  I suspect it is less frequent than hugtlb pages
> in general, and certainly less frequent than THP or base pages.
> 
> >>  
> >>  	while (page_vma_mapped_walk(&pvmw)) {
> >> @@ -1409,6 +1419,32 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
> >>  		subpage = page - page_to_pfn(page) + pte_pfn(*pvmw.pte);
> >>  		address = pvmw.address;
> >>  
> >> +		if (PageHuge(page)) {
> >> +			if (huge_pmd_unshare(mm, &address, pvmw.pte)) {
> > 
> > huge_pmd_unshare is documented to require a pte lock. Where do we take
> > it?
> 
> It is somewhat hidden, but we are in the loop:
> 
> 	while (page_vma_mapped_walk(&pvmw)) {
> 
> The routine page_vma_mapped_walk will acquire the lock, and it correctly
> checks for huge pages and uses huge_pte_lockptr().
> 
> page_vma_mapped_walk_done() will release the lock.

OK, I can see it now. Thanks for the clarification. page_vma_mapped_walk
is quite hard to follow.
-- 
Michal Hocko
SUSE Labs
