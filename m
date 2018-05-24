Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161498AbeEXVnC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 17:43:02 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56590 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161485AbeEXVnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 17:43:00 -0400
Subject: Re: [PATCH -V2 -mm 3/4] mm, hugetlbfs: Rename address to haddr in
 hugetlb_cow()
To: "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <andi.kleen@intel.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Hugh Dickins <hughd@google.com>, Minchan Kim <minchan@kernel.org>,
        Shaohua Li <shli@fb.com>, Christopher Lameter <cl@linux.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Punit Agrawal <punit.agrawal@arm.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@suse.com>
References: <20180524005851.4079-1-ying.huang@intel.com>
 <20180524005851.4079-4-ying.huang@intel.com>
From: Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <4e569170-9f4e-eb12-d10d-fe9b7fcdfc9d@oracle.com>
Date: Thu, 24 May 2018 14:42:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180524005851.4079-4-ying.huang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8903 signatures=668700
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805240245
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/23/2018 05:58 PM, Huang, Ying wrote:
> From: Huang Ying <ying.huang@intel.com>
> 
> To take better advantage of general huge page copying optimization,
> the target subpage address will be passed to hugetlb_cow(), then
> copy_user_huge_page().  So we will use both target subpage address and
> huge page size aligned address in hugetlb_cow().  To distinguish
> between them, "haddr" is used for huge page size aligned address to be
> consistent with Transparent Huge Page naming convention.
> 
> Now, only huge page size aligned address is used in hugetlb_cow(), so
> the "address" is renamed to "haddr" in hugetlb_cow() in this patch.
> Next patch will use target subpage address in hugetlb_cow() too.
> 
> The patch is just code cleanup without any functionality changes.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Suggested-by: Mike Kravetz <mike.kravetz@oracle.com>
> Suggested-by: Michal Hocko <mhocko@suse.com>

I believe Kirill may have been the one who suggested using haddr to be
consistent with usage in huge_memory.c.

> Cc: David Rientjes <rientjes@google.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Andi Kleen <andi.kleen@intel.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Matthew Wilcox <mawilcox@microsoft.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Shaohua Li <shli@fb.com>
> Cc: Christopher Lameter <cl@linux.com>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> Cc: Punit Agrawal <punit.agrawal@arm.com>
> Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
>  mm/hugetlb.c | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 696befffe6f7..ad3bec2ed269 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3500,7 +3500,7 @@ static void unmap_ref_private(struct mm_struct *mm, struct vm_area_struct *vma,
>   * Keep the pte_same checks anyway to make transition from the mutex easier.
>   */
>  static int hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
> -		       unsigned long address, pte_t *ptep,
> +		       unsigned long haddr, pte_t *ptep,
>  		       struct page *pagecache_page, spinlock_t *ptl)
>  {
>  	pte_t pte;
> @@ -3518,7 +3518,7 @@ static int hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
>  	 * and just make the page writable */
>  	if (page_mapcount(old_page) == 1 && PageAnon(old_page)) {
>  		page_move_anon_rmap(old_page, vma);
> -		set_huge_ptep_writable(vma, address, ptep);
> +		set_huge_ptep_writable(vma, haddr, ptep);
>  		return 0;
>  	}
>  
> @@ -3542,7 +3542,7 @@ static int hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
>  	 * be acquired again before returning to the caller, as expected.
>  	 */
>  	spin_unlock(ptl);
> -	new_page = alloc_huge_page(vma, address, outside_reserve);
> +	new_page = alloc_huge_page(vma, haddr, outside_reserve);
>  
>  	if (IS_ERR(new_page)) {
>  		/*
> @@ -3555,11 +3555,10 @@ static int hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
>  		if (outside_reserve) {
>  			put_page(old_page);
>  			BUG_ON(huge_pte_none(pte));
> -			unmap_ref_private(mm, vma, old_page, address);
> +			unmap_ref_private(mm, vma, old_page, haddr);
>  			BUG_ON(huge_pte_none(pte));
>  			spin_lock(ptl);
> -			ptep = huge_pte_offset(mm, address & huge_page_mask(h),
> -					       huge_page_size(h));
> +			ptep = huge_pte_offset(mm, haddr, huge_page_size(h));

Ha!  The name change points out an obviously unnecessary conversion in
the existing code.  Yes, hugetlb_cow is always passed a hpage aligned
address today.

>  			if (likely(ptep &&
>  				   pte_same(huge_ptep_get(ptep), pte)))
>  				goto retry_avoidcopy;
> @@ -3584,12 +3583,12 @@ static int hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
>  		goto out_release_all;
>  	}
>  
> -	copy_user_huge_page(new_page, old_page, address, vma,
> +	copy_user_huge_page(new_page, old_page, haddr, vma,
>  			    pages_per_huge_page(h));
>  	__SetPageUptodate(new_page);
>  	set_page_huge_active(new_page);
>  
> -	mmun_start = address & huge_page_mask(h);
> +	mmun_start = haddr;

And another one.

>  	mmun_end = mmun_start + huge_page_size(h);
>  	mmu_notifier_invalidate_range_start(mm, mmun_start, mmun_end);
>  
> @@ -3598,25 +3597,24 @@ static int hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
>  	 * before the page tables are altered
>  	 */
>  	spin_lock(ptl);
> -	ptep = huge_pte_offset(mm, address & huge_page_mask(h),
> -			       huge_page_size(h));
> +	ptep = huge_pte_offset(mm, haddr, huge_page_size(h));

And yet another.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

>  	if (likely(ptep && pte_same(huge_ptep_get(ptep), pte))) {
>  		ClearPagePrivate(new_page);
>  
>  		/* Break COW */
> -		huge_ptep_clear_flush(vma, address, ptep);
> +		huge_ptep_clear_flush(vma, haddr, ptep);
>  		mmu_notifier_invalidate_range(mm, mmun_start, mmun_end);
> -		set_huge_pte_at(mm, address, ptep,
> +		set_huge_pte_at(mm, haddr, ptep,
>  				make_huge_pte(vma, new_page, 1));
>  		page_remove_rmap(old_page, true);
> -		hugepage_add_new_anon_rmap(new_page, vma, address);
> +		hugepage_add_new_anon_rmap(new_page, vma, haddr);
>  		/* Make the old page be freed below */
>  		new_page = old_page;
>  	}
>  	spin_unlock(ptl);
>  	mmu_notifier_invalidate_range_end(mm, mmun_start, mmun_end);
>  out_release_all:
> -	restore_reserve_on_error(h, vma, address, new_page);
> +	restore_reserve_on_error(h, vma, haddr, new_page);
>  	put_page(new_page);
>  out_release_old:
>  	put_page(old_page);
> 
