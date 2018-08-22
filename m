Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CD4C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 12:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BA23214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 12:28:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BA23214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbeHVPxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 11:53:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:49286 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727777AbeHVPxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 11:53:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0043BB031;
        Wed, 22 Aug 2018 12:28:50 +0000 (UTC)
Date:   Wed, 22 Aug 2018 14:28:48 +0200
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
Message-ID: <20180822122848.GL29735@dhcp22.suse.cz>
References: <20180821205902.21223-2-mike.kravetz@oracle.com>
 <201808220831.eM0je51n%fengguang.wu@intel.com>
 <975b740d-26a6-eb3f-c8ca-1a9995d0d343@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <975b740d-26a6-eb3f-c8ca-1a9995d0d343@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 21-08-18 18:10:42, Mike Kravetz wrote:
[...]
> diff --git a/mm/rmap.c b/mm/rmap.c
> index eb477809a5c0..8cf853a4b093 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1362,11 +1362,21 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>  	}
>  
>  	/*
> -	 * We have to assume the worse case ie pmd for invalidation. Note that
> -	 * the page can not be free in this function as call of try_to_unmap()
> -	 * must hold a reference on the page.
> +	 * For THP, we have to assume the worse case ie pmd for invalidation.
> +	 * For hugetlb, it could be much worse if we need to do pud
> +	 * invalidation in the case of pmd sharing.
> +	 *
> +	 * Note that the page can not be free in this function as call of
> +	 * try_to_unmap() must hold a reference on the page.
>  	 */
>  	end = min(vma->vm_end, start + (PAGE_SIZE << compound_order(page)));
> +	if (PageHuge(page)) {
> +		/*
> +		 * If sharing is possible, start and end will be adjusted
> +		 * accordingly.
> +		 */
> +		(void)huge_pmd_sharing_possible(vma, &start, &end);
> +	}
>  	mmu_notifier_invalidate_range_start(vma->vm_mm, start, end);

I do not get this part. Why don't we simply unconditionally invalidate
the whole huge page range?

>  
>  	while (page_vma_mapped_walk(&pvmw)) {
> @@ -1409,6 +1419,32 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>  		subpage = page - page_to_pfn(page) + pte_pfn(*pvmw.pte);
>  		address = pvmw.address;
>  
> +		if (PageHuge(page)) {
> +			if (huge_pmd_unshare(mm, &address, pvmw.pte)) {

huge_pmd_unshare is documented to require a pte lock. Where do we take
it?
-- 
Michal Hocko
SUSE Labs
