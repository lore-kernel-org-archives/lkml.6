Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2BFC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43BBA208DC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 19:09:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43BBA208DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbeH0W5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:57:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:59192 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727023AbeH0W5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:57:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4A92DAF41;
        Mon, 27 Aug 2018 19:09:22 +0000 (UTC)
Date:   Mon, 27 Aug 2018 21:09:20 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH v6 1/2] mm: migration: fix migration of huge PMD shared
 pages
Message-ID: <20180827190850.GF21556@dhcp22.suse.cz>
References: <20180823205917.16297-1-mike.kravetz@oracle.com>
 <20180823205917.16297-2-mike.kravetz@oracle.com>
 <20180824084157.GD29735@dhcp22.suse.cz>
 <6063f215-a5c8-2f0c-465a-2c515ddc952d@oracle.com>
 <20180827074645.GB21556@dhcp22.suse.cz>
 <20180827134633.GB3930@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827134633.GB3930@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 27-08-18 09:46:33, Jerome Glisse wrote:
> On Mon, Aug 27, 2018 at 09:46:45AM +0200, Michal Hocko wrote:
> > On Fri 24-08-18 11:08:24, Mike Kravetz wrote:
> > > On 08/24/2018 01:41 AM, Michal Hocko wrote:
> > > > On Thu 23-08-18 13:59:16, Mike Kravetz wrote:
> > > > 
> > > > Acked-by: Michal Hocko <mhocko@suse.com>
> > > > 
> > > > One nit below.
> > > > 
> > > > [...]
> > > >> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > > >> index 3103099f64fd..a73c5728e961 100644
> > > >> --- a/mm/hugetlb.c
> > > >> +++ b/mm/hugetlb.c
> > > >> @@ -4548,6 +4548,9 @@ static unsigned long page_table_shareable(struct vm_area_struct *svma,
> > > >>  	return saddr;
> > > >>  }
> > > >>  
> > > >> +#define _range_in_vma(vma, start, end) \
> > > >> +	((vma)->vm_start <= (start) && (end) <= (vma)->vm_end)
> > > >> +
> > > > 
> > > > static inline please. Macros and potential side effects on given
> > > > arguments are just not worth the risk. I also think this is something
> > > > for more general use. We have that pattern at many places. So I would
> > > > stick that to linux/mm.h
> > > 
> > > Thanks Michal,
> > > 
> > > Here is an updated patch which does as you suggest above.
> > [...]
> > > @@ -1409,6 +1419,32 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
> > >  		subpage = page - page_to_pfn(page) + pte_pfn(*pvmw.pte);
> > >  		address = pvmw.address;
> > >  
> > > +		if (PageHuge(page)) {
> > > +			if (huge_pmd_unshare(mm, &address, pvmw.pte)) {
> > > +				/*
> > > +				 * huge_pmd_unshare unmapped an entire PMD
> > > +				 * page.  There is no way of knowing exactly
> > > +				 * which PMDs may be cached for this mm, so
> > > +				 * we must flush them all.  start/end were
> > > +				 * already adjusted above to cover this range.
> > > +				 */
> > > +				flush_cache_range(vma, start, end);
> > > +				flush_tlb_range(vma, start, end);
> > > +				mmu_notifier_invalidate_range(mm, start, end);
> > > +
> > > +				/*
> > > +				 * The ref count of the PMD page was dropped
> > > +				 * which is part of the way map counting
> > > +				 * is done for shared PMDs.  Return 'true'
> > > +				 * here.  When there is no other sharing,
> > > +				 * huge_pmd_unshare returns false and we will
> > > +				 * unmap the actual page and drop map count
> > > +				 * to zero.
> > > +				 */
> > > +				page_vma_mapped_walk_done(&pvmw);
> > > +				break;
> > > +			}
> > 
> > This still calls into notifier while holding the ptl lock. Either I am
> > missing something or the invalidation is broken in this loop (not also
> > for other invalidations).
> 
> mmu_notifier_invalidate_range() is done with pt lock held only the start
> and end versions need to happen outside pt lock.

OK, that was not clear to me. Especially srcu_read_lock in
__mmu_notifier_invalidate_range suggests the callback might sleep. There
is no note about the pte lock. There is even a note about possible
blocking
	 * If this callback cannot block, and invalidate_range_{start,end}
	 * cannot block, mmu_notifier_ops.flags should have
	 * MMU_INVALIDATE_DOES_NOT_BLOCK set.

I am removing that part of the comment but it really confused me.
-- 
Michal Hocko
SUSE Labs
