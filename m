Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8121DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 18:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E23320645
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 18:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbfBYS3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 13:29:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56528 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725936AbfBYS3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 13:29:04 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1PIL0xd018798
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 13:29:03 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qvn9gscu9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 13:29:02 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Mon, 25 Feb 2019 18:28:59 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Feb 2019 18:28:53 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1PISr8a51314846
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Feb 2019 18:28:53 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E363652059;
        Mon, 25 Feb 2019 18:28:52 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.205.26])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id ECC2E52051;
        Mon, 25 Feb 2019 18:28:44 +0000 (GMT)
Date:   Mon, 25 Feb 2019 20:28:40 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Martin Cracauer <cracauer@cons.org>, Shaohua Li <shli@fb.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v2 17/26] userfaultfd: wp: support swap and page migration
References: <20190212025632.28946-1-peterx@redhat.com>
 <20190212025632.28946-18-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212025632.28946-18-peterx@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19022518-0028-0000-0000-0000034CDB0D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022518-0029-0000-0000-0000240B2B53
Message-Id: <20190225182832.GI24917@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-25_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902250134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 10:56:23AM +0800, Peter Xu wrote:
> For either swap and page migration, we all use the bit 2 of the entry to
> identify whether this entry is uffd write-protected.  It plays a similar
> role as the existing soft dirty bit in swap entries but only for keeping
> the uffd-wp tracking for a specific PTE/PMD.
> 
> Something special here is that when we want to recover the uffd-wp bit
> from a swap/migration entry to the PTE bit we'll also need to take care
> of the _PAGE_RW bit and make sure it's cleared, otherwise even with the
> _PAGE_UFFD_WP bit we can't trap it at all.
> 
> Note that this patch removed two lines from "userfaultfd: wp: hook
> userfault handler to write protection fault" where we try to remove the
> VM_FAULT_WRITE from vmf->flags when uffd-wp is set for the VMA.  This
> patch will still keep the write flag there.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  include/linux/swapops.h | 2 ++
>  mm/huge_memory.c        | 3 +++
>  mm/memory.c             | 8 ++++++--
>  mm/migrate.c            | 7 +++++++
>  mm/mprotect.c           | 2 ++
>  mm/rmap.c               | 6 ++++++
>  6 files changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/swapops.h b/include/linux/swapops.h
> index 4d961668e5fc..0c2923b1cdb7 100644
> --- a/include/linux/swapops.h
> +++ b/include/linux/swapops.h
> @@ -68,6 +68,8 @@ static inline swp_entry_t pte_to_swp_entry(pte_t pte)
> 
>  	if (pte_swp_soft_dirty(pte))
>  		pte = pte_swp_clear_soft_dirty(pte);
> +	if (pte_swp_uffd_wp(pte))
> +		pte = pte_swp_clear_uffd_wp(pte);
>  	arch_entry = __pte_to_swp_entry(pte);
>  	return swp_entry(__swp_type(arch_entry), __swp_offset(arch_entry));
>  }
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index fb2234cb595a..75de07141801 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2175,6 +2175,7 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>  		write = is_write_migration_entry(entry);
>  		young = false;
>  		soft_dirty = pmd_swp_soft_dirty(old_pmd);
> +		uffd_wp = pmd_swp_uffd_wp(old_pmd);
>  	} else {
>  		page = pmd_page(old_pmd);
>  		if (pmd_dirty(old_pmd))
> @@ -2207,6 +2208,8 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>  			entry = swp_entry_to_pte(swp_entry);
>  			if (soft_dirty)
>  				entry = pte_swp_mksoft_dirty(entry);
> +			if (uffd_wp)
> +				entry = pte_swp_mkuffd_wp(entry);
>  		} else {
>  			entry = mk_pte(page + i, READ_ONCE(vma->vm_page_prot));
>  			entry = maybe_mkwrite(entry, vma);
> diff --git a/mm/memory.c b/mm/memory.c
> index c2035539e9fd..7cee990d67cf 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -736,6 +736,8 @@ copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>  				pte = swp_entry_to_pte(entry);
>  				if (pte_swp_soft_dirty(*src_pte))
>  					pte = pte_swp_mksoft_dirty(pte);
> +				if (pte_swp_uffd_wp(*src_pte))
> +					pte = pte_swp_mkuffd_wp(pte);
>  				set_pte_at(src_mm, addr, src_pte, pte);
>  			}
>  		} else if (is_device_private_entry(entry)) {
> @@ -2815,8 +2817,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
>  	dec_mm_counter_fast(vma->vm_mm, MM_SWAPENTS);
>  	pte = mk_pte(page, vma->vm_page_prot);
> -	if (userfaultfd_wp(vma))
> -		vmf->flags &= ~FAULT_FLAG_WRITE;
>  	if ((vmf->flags & FAULT_FLAG_WRITE) && reuse_swap_page(page, NULL)) {
>  		pte = maybe_mkwrite(pte_mkdirty(pte), vma);
>  		vmf->flags &= ~FAULT_FLAG_WRITE;
> @@ -2826,6 +2826,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	flush_icache_page(vma, page);
>  	if (pte_swp_soft_dirty(vmf->orig_pte))
>  		pte = pte_mksoft_dirty(pte);
> +	if (pte_swp_uffd_wp(vmf->orig_pte)) {
> +		pte = pte_mkuffd_wp(pte);
> +		pte = pte_wrprotect(pte);
> +	}
>  	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
>  	arch_do_swap_page(vma->vm_mm, vma, vmf->address, pte, vmf->orig_pte);
>  	vmf->orig_pte = pte;
> diff --git a/mm/migrate.c b/mm/migrate.c
> index d4fd680be3b0..605ccd1f5c64 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -242,6 +242,11 @@ static bool remove_migration_pte(struct page *page, struct vm_area_struct *vma,
>  		if (is_write_migration_entry(entry))
>  			pte = maybe_mkwrite(pte, vma);
> 
> +		if (pte_swp_uffd_wp(*pvmw.pte)) {
> +			pte = pte_mkuffd_wp(pte);
> +			pte = pte_wrprotect(pte);
> +		}
> +
>  		if (unlikely(is_zone_device_page(new))) {
>  			if (is_device_private_page(new)) {
>  				entry = make_device_private_entry(new, pte_write(pte));
> @@ -2290,6 +2295,8 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>  			swp_pte = swp_entry_to_pte(entry);
>  			if (pte_soft_dirty(pte))
>  				swp_pte = pte_swp_mksoft_dirty(swp_pte);
> +			if (pte_uffd_wp(pte))
> +				swp_pte = pte_swp_mkuffd_wp(swp_pte);
>  			set_pte_at(mm, addr, ptep, swp_pte);
> 
>  			/*
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index ae93721f3795..73a65f07fe41 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -187,6 +187,8 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
>  				newpte = swp_entry_to_pte(entry);
>  				if (pte_swp_soft_dirty(oldpte))
>  					newpte = pte_swp_mksoft_dirty(newpte);
> +				if (pte_swp_uffd_wp(oldpte))
> +					newpte = pte_swp_mkuffd_wp(newpte);
>  				set_pte_at(mm, addr, pte, newpte);
> 
>  				pages++;
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 0454ecc29537..3750d5a5283c 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1469,6 +1469,8 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>  			swp_pte = swp_entry_to_pte(entry);
>  			if (pte_soft_dirty(pteval))
>  				swp_pte = pte_swp_mksoft_dirty(swp_pte);
> +			if (pte_uffd_wp(pteval))
> +				swp_pte = pte_swp_mkuffd_wp(swp_pte);
>  			set_pte_at(mm, pvmw.address, pvmw.pte, swp_pte);
>  			/*
>  			 * No need to invalidate here it will synchronize on
> @@ -1561,6 +1563,8 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>  			swp_pte = swp_entry_to_pte(entry);
>  			if (pte_soft_dirty(pteval))
>  				swp_pte = pte_swp_mksoft_dirty(swp_pte);
> +			if (pte_uffd_wp(pteval))
> +				swp_pte = pte_swp_mkuffd_wp(swp_pte);
>  			set_pte_at(mm, address, pvmw.pte, swp_pte);
>  			/*
>  			 * No need to invalidate here it will synchronize on
> @@ -1627,6 +1631,8 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>  			swp_pte = swp_entry_to_pte(entry);
>  			if (pte_soft_dirty(pteval))
>  				swp_pte = pte_swp_mksoft_dirty(swp_pte);
> +			if (pte_uffd_wp(pteval))
> +				swp_pte = pte_swp_mkuffd_wp(swp_pte);
>  			set_pte_at(mm, address, pvmw.pte, swp_pte);
>  			/* Invalidate as we cleared the pte */
>  			mmu_notifier_invalidate_range(mm, address,
> -- 
> 2.17.1
> 

-- 
Sincerely yours,
Mike.

