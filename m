Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90145C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 13:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CB8F208B6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 13:46:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CB8F208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbeH0RdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 13:33:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49650 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726883AbeH0RdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 13:33:21 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CD4768010FDF;
        Mon, 27 Aug 2018 13:46:36 +0000 (UTC)
Received: from redhat.com (ovpn-125-115.rdu2.redhat.com [10.10.125.115])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 47CF31DB5C;
        Mon, 27 Aug 2018 13:46:35 +0000 (UTC)
Date:   Mon, 27 Aug 2018 09:46:33 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
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
Message-ID: <20180827134633.GB3930@redhat.com>
References: <20180823205917.16297-1-mike.kravetz@oracle.com>
 <20180823205917.16297-2-mike.kravetz@oracle.com>
 <20180824084157.GD29735@dhcp22.suse.cz>
 <6063f215-a5c8-2f0c-465a-2c515ddc952d@oracle.com>
 <20180827074645.GB21556@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180827074645.GB21556@dhcp22.suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 27 Aug 2018 13:46:36 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 27 Aug 2018 13:46:36 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jglisse@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 09:46:45AM +0200, Michal Hocko wrote:
> On Fri 24-08-18 11:08:24, Mike Kravetz wrote:
> > On 08/24/2018 01:41 AM, Michal Hocko wrote:
> > > On Thu 23-08-18 13:59:16, Mike Kravetz wrote:
> > > 
> > > Acked-by: Michal Hocko <mhocko@suse.com>
> > > 
> > > One nit below.
> > > 
> > > [...]
> > >> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > >> index 3103099f64fd..a73c5728e961 100644
> > >> --- a/mm/hugetlb.c
> > >> +++ b/mm/hugetlb.c
> > >> @@ -4548,6 +4548,9 @@ static unsigned long page_table_shareable(struct vm_area_struct *svma,
> > >>  	return saddr;
> > >>  }
> > >>  
> > >> +#define _range_in_vma(vma, start, end) \
> > >> +	((vma)->vm_start <= (start) && (end) <= (vma)->vm_end)
> > >> +
> > > 
> > > static inline please. Macros and potential side effects on given
> > > arguments are just not worth the risk. I also think this is something
> > > for more general use. We have that pattern at many places. So I would
> > > stick that to linux/mm.h
> > 
> > Thanks Michal,
> > 
> > Here is an updated patch which does as you suggest above.
> [...]
> > @@ -1409,6 +1419,32 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
> >  		subpage = page - page_to_pfn(page) + pte_pfn(*pvmw.pte);
> >  		address = pvmw.address;
> >  
> > +		if (PageHuge(page)) {
> > +			if (huge_pmd_unshare(mm, &address, pvmw.pte)) {
> > +				/*
> > +				 * huge_pmd_unshare unmapped an entire PMD
> > +				 * page.  There is no way of knowing exactly
> > +				 * which PMDs may be cached for this mm, so
> > +				 * we must flush them all.  start/end were
> > +				 * already adjusted above to cover this range.
> > +				 */
> > +				flush_cache_range(vma, start, end);
> > +				flush_tlb_range(vma, start, end);
> > +				mmu_notifier_invalidate_range(mm, start, end);
> > +
> > +				/*
> > +				 * The ref count of the PMD page was dropped
> > +				 * which is part of the way map counting
> > +				 * is done for shared PMDs.  Return 'true'
> > +				 * here.  When there is no other sharing,
> > +				 * huge_pmd_unshare returns false and we will
> > +				 * unmap the actual page and drop map count
> > +				 * to zero.
> > +				 */
> > +				page_vma_mapped_walk_done(&pvmw);
> > +				break;
> > +			}
> 
> This still calls into notifier while holding the ptl lock. Either I am
> missing something or the invalidation is broken in this loop (not also
> for other invalidations).

mmu_notifier_invalidate_range() is done with pt lock held only the start
and end versions need to happen outside pt lock.

Cheers,
Jérôme
