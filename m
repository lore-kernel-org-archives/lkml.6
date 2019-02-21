Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95877C10F08
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 06:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F45221841
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 06:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbfBUGJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 01:09:16 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:35752 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfBUGJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 01:09:15 -0500
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9B2CD3810;
        Thu, 21 Feb 2019 06:09:13 +0000 (UTC)
Date:   Wed, 20 Feb 2019 22:09:10 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Davidlohr Bueso <dave@stgolabs.net>, stable@vger.kernel.org
Subject: Re: [PATCH] huegtlbfs: fix races and page leaks during migration
Message-Id: <20190220220910.265bff9a7695540ee4121b80@linux-foundation.org>
In-Reply-To: <20190212221400.3512-1-mike.kravetz@oracle.com>
References: <803d2349-8911-0b47-bc5b-4f2c6cc3f928@oracle.com>
        <20190212221400.3512-1-mike.kravetz@oracle.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2019 14:14:00 -0800 Mike Kravetz <mike.kravetz@oracle.com> wrote:

> hugetlb pages should only be migrated if they are 'active'.  The routines
> set/clear_page_huge_active() modify the active state of hugetlb pages.
> When a new hugetlb page is allocated at fault time, set_page_huge_active
> is called before the page is locked.  Therefore, another thread could
> race and migrate the page while it is being added to page table by the
> fault code.  This race is somewhat hard to trigger, but can be seen by
> strategically adding udelay to simulate worst case scheduling behavior.
> Depending on 'how' the code races, various BUG()s could be triggered.
> 
> To address this issue, simply delay the set_page_huge_active call until
> after the page is successfully added to the page table.
> 
> Hugetlb pages can also be leaked at migration time if the pages are
> associated with a file in an explicitly mounted hugetlbfs filesystem.
> For example, a test program which hole punches, faults and migrates
> pages in such a file (1G in size) will eventually fail because it
> can not allocate a page.  Reported counts and usage at time of failure:
> 
> node0
> 537     free_hugepages
> 1024    nr_hugepages
> 0       surplus_hugepages
> node1
> 1000    free_hugepages
> 1024    nr_hugepages
> 0       surplus_hugepages
> 
> Filesystem                         Size  Used Avail Use% Mounted on
> nodev                              4.0G  4.0G     0 100% /var/opt/hugepool
> 
> Note that the filesystem shows 4G of pages used, while actual usage is
> 511 pages (just under 1G).  Failed trying to allocate page 512.
> 
> If a hugetlb page is associated with an explicitly mounted filesystem,
> this information in contained in the page_private field.  At migration
> time, this information is not preserved.  To fix, simply transfer
> page_private from old to new page at migration time if necessary.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: bcc54222309c ("mm: hugetlb: introduce page_huge_active")
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

cc:stable.  It would be nice to get some review of this one, please?

> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -859,6 +859,18 @@ static int hugetlbfs_migrate_page(struct address_space *mapping,
>  	rc = migrate_huge_page_move_mapping(mapping, newpage, page);
>  	if (rc != MIGRATEPAGE_SUCCESS)
>  		return rc;
> +
> +	/*
> +	 * page_private is subpool pointer in hugetlb pages.  Transfer to
> +	 * new page.  PagePrivate is not associated with page_private for
> +	 * hugetlb pages and can not be set here as only page_huge_active
> +	 * pages can be migrated.
> +	 */
> +	if (page_private(page)) {
> +		set_page_private(newpage, page_private(page));
> +		set_page_private(page, 0);
> +	}
> +
>  	if (mode != MIGRATE_SYNC_NO_COPY)
>  		migrate_page_copy(newpage, page);
>  	else
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index a80832487981..f859e319e3eb 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3625,7 +3625,6 @@ static vm_fault_t hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
>  	copy_user_huge_page(new_page, old_page, address, vma,
>  			    pages_per_huge_page(h));
>  	__SetPageUptodate(new_page);
> -	set_page_huge_active(new_page);
>  
>  	mmun_start = haddr;
>  	mmun_end = mmun_start + huge_page_size(h);
> @@ -3647,6 +3646,7 @@ static vm_fault_t hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
>  				make_huge_pte(vma, new_page, 1));
>  		page_remove_rmap(old_page, true);
>  		hugepage_add_new_anon_rmap(new_page, vma, haddr);
> +		set_page_huge_active(new_page);
>  		/* Make the old page be freed below */
>  		new_page = old_page;
>  	}
> @@ -3792,7 +3792,6 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>  		}
>  		clear_huge_page(page, address, pages_per_huge_page(h));
>  		__SetPageUptodate(page);
> -		set_page_huge_active(page);
>  
>  		if (vma->vm_flags & VM_MAYSHARE) {
>  			int err = huge_add_to_page_cache(page, mapping, idx);
> @@ -3863,6 +3862,10 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>  	}
>  
>  	spin_unlock(ptl);
> +
> +	/* May already be set if not newly allocated page */
> +	set_page_huge_active(page);
> +
>  	unlock_page(page);
>  out:
>  	return ret;
> @@ -4097,7 +4100,6 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>  	 * the set_pte_at() write.
>  	 */
>  	__SetPageUptodate(page);
> -	set_page_huge_active(page);
>  
>  	mapping = dst_vma->vm_file->f_mapping;
>  	idx = vma_hugecache_offset(h, dst_vma, dst_addr);
> @@ -4165,6 +4167,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>  	update_mmu_cache(dst_vma, dst_addr, dst_pte);
>  
>  	spin_unlock(ptl);
> +	set_page_huge_active(page);
>  	if (vm_shared)
>  		unlock_page(page);
>  	ret = 0;
> -- 
> 2.17.2
