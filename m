Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C252C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 18:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DA5220657
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 18:14:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DA5220657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbeH2WMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 18:12:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48640 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727530AbeH2WMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 18:12:33 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B928E87A81;
        Wed, 29 Aug 2018 18:14:27 +0000 (UTC)
Received: from redhat.com (ovpn-126-69.rdu2.redhat.com [10.10.126.69])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C59E2026D6D;
        Wed, 29 Aug 2018 18:14:26 +0000 (UTC)
Date:   Wed, 29 Aug 2018 14:14:25 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH v6 1/2] mm: migration: fix migration of huge PMD shared
 pages
Message-ID: <20180829181424.GB3784@redhat.com>
References: <20180823205917.16297-1-mike.kravetz@oracle.com>
 <20180823205917.16297-2-mike.kravetz@oracle.com>
 <20180824084157.GD29735@dhcp22.suse.cz>
 <6063f215-a5c8-2f0c-465a-2c515ddc952d@oracle.com>
 <20180827074645.GB21556@dhcp22.suse.cz>
 <20180827134633.GB3930@redhat.com>
 <9209043d-3240-105b-72a3-b4cd30f1b1f1@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9209043d-3240-105b-72a3-b4cd30f1b1f1@oracle.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 29 Aug 2018 18:14:27 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 29 Aug 2018 18:14:27 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jglisse@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 10:24:44AM -0700, Mike Kravetz wrote:
> On 08/27/2018 06:46 AM, Jerome Glisse wrote:
> > On Mon, Aug 27, 2018 at 09:46:45AM +0200, Michal Hocko wrote:
> >> On Fri 24-08-18 11:08:24, Mike Kravetz wrote:
> >>> Here is an updated patch which does as you suggest above.
> >> [...]
> >>> @@ -1409,6 +1419,32 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
> >>>  		subpage = page - page_to_pfn(page) + pte_pfn(*pvmw.pte);
> >>>  		address = pvmw.address;
> >>>  
> >>> +		if (PageHuge(page)) {
> >>> +			if (huge_pmd_unshare(mm, &address, pvmw.pte)) {
> >>> +				/*
> >>> +				 * huge_pmd_unshare unmapped an entire PMD
> >>> +				 * page.  There is no way of knowing exactly
> >>> +				 * which PMDs may be cached for this mm, so
> >>> +				 * we must flush them all.  start/end were
> >>> +				 * already adjusted above to cover this range.
> >>> +				 */
> >>> +				flush_cache_range(vma, start, end);
> >>> +				flush_tlb_range(vma, start, end);
> >>> +				mmu_notifier_invalidate_range(mm, start, end);
> >>> +
> >>> +				/*
> >>> +				 * The ref count of the PMD page was dropped
> >>> +				 * which is part of the way map counting
> >>> +				 * is done for shared PMDs.  Return 'true'
> >>> +				 * here.  When there is no other sharing,
> >>> +				 * huge_pmd_unshare returns false and we will
> >>> +				 * unmap the actual page and drop map count
> >>> +				 * to zero.
> >>> +				 */
> >>> +				page_vma_mapped_walk_done(&pvmw);
> >>> +				break;
> >>> +			}
> >>
> >> This still calls into notifier while holding the ptl lock. Either I am
> >> missing something or the invalidation is broken in this loop (not also
> >> for other invalidations).
> > 
> > mmu_notifier_invalidate_range() is done with pt lock held only the start
> > and end versions need to happen outside pt lock.
> 
> Hi Jérôme (and anyone else having good understanding of mmu notifier API),
> 
> Michal and I have been looking at backports to stable releases.  If you look
> at the v4.4 version of try_to_unmap_one(), it does not use the
> mmu_notifier_invalidate_range_start/end interfaces. Rather, it uses the
> mmu_notifier_invalidate_page(), passing in the address of the page it
> unmapped.  This is done after releasing the ptl lock.  I'm not even sure if
> this works for huge pages, as it appears some THP supporting code was added
> to try_to_unmap_one() after v4.4.
> 
> But, we were wondering what mmu notifier interface to use in the case where
> try_to_unmap_one() unmaps a shared pmd huge page as addressed in the patch
> above.  In this case, a PUD sized area is effectively unmapped.  In the
> code/patch above we have the invalidate range (start and end as well) take
> the PUD sized area into account.
> 
> What would be the best mmu notifier interface to use where there are no
> start/end calls?
> Or, is the best solution to add the start/end calls as is done in later
> versions of the code?  If that is the suggestion, has there been any change
> in invalidate start/end semantics that we should take into account?

start/end would be the one to add, 4.4 seems broken in respect to THP
and mmu notification. Another solution is to fix user of mmu notifier,
they were only a handful back then. For instance properly adjust the
address to match first address covered by pmd or pud and passing down
correct page size to mmu_notifier_invalidate_page() would allow to fix
this easily.

This is ok because user of try_to_unmap_one() replace the pte/pmd/pud
with an invalid one (either poison, migration or swap) inside the
function. So anyone racing would synchronize on those special entry
hence why it is fine to delay mmu_notifier_invalidate_page() to after
dropping the page table lock.

Adding start/end might the solution with less code churn as you would
only need to change try_to_unmap_one().

Cheers,
Jérôme
