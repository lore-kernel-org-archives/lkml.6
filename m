Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034760AbeE1PmY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:42:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:38836 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030841AbeE1PmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 11:42:19 -0400
Date: Mon, 28 May 2018 10:52:31 +0200
From: Michal Hocko <mhocko@kernel.org>
To: David Rientjes <rientjes@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [patch] mm, hugetlb_cgroup: suppress SIGBUS when hugetlb_cgroup
 charge fails
Message-ID: <20180528085231.GA1648@dhcp22.suse.cz>
References: <alpine.DEB.2.21.1805251316090.167008@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1805251316090.167008@chino.kir.corp.google.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 25-05-18 13:16:45, David Rientjes wrote:
> When charging to a hugetlb_cgroup fails, alloc_huge_page() returns
> ERR_PTR(-ENOSPC) which will cause VM_FAULT_SIGBUS to be returned to the
> page fault handler.
> 
> Instead, return the proper error code, ERR_PTR(-ENOMEM), so VM_FAULT_OOM
> is handled correctly.  This is consistent with failing mem cgroup charges
> in the non-hugetlb fault path.

Could you describe the acutal problem you are trying to solve, please?
Also could you explain Why should be the charge and the reservation
failure any different? My memory is dim but the original hugetlb code
was aiming at being compatible with the reservation failures because in
essence the hugetlb simply subdivides the existing pool between cgroups.
I might misremember of course but the changelog should be much more
clear in that case.

> At the same time, restructure the return paths of alloc_huge_page() so it
> is consistent.

Please make an unrelated change in a separate commit.

> Signed-off-by: David Rientjes <rientjes@google.com>
> ---
>  mm/hugetlb.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2006,8 +2006,10 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
>  	 * code of zero indicates a reservation exists (no change).
>  	 */
>  	map_chg = gbl_chg = vma_needs_reservation(h, vma, addr);
> -	if (map_chg < 0)
> -		return ERR_PTR(-ENOMEM);
> +	if (map_chg < 0) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
>  
>  	/*
>  	 * Processes that did not create the mapping will have no
> @@ -2019,8 +2021,8 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
>  	if (map_chg || avoid_reserve) {
>  		gbl_chg = hugepage_subpool_get_pages(spool, 1);
>  		if (gbl_chg < 0) {
> -			vma_end_reservation(h, vma, addr);
> -			return ERR_PTR(-ENOSPC);
> +			ret = -ENOSPC;
> +			goto out_reservation;
>  		}
>  
>  		/*
> @@ -2049,8 +2051,10 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
>  	if (!page) {
>  		spin_unlock(&hugetlb_lock);
>  		page = alloc_buddy_huge_page_with_mpol(h, vma, addr);
> -		if (!page)
> +		if (!page) {
> +			ret = -ENOSPC;
>  			goto out_uncharge_cgroup;
> +		}
>  		if (!avoid_reserve && vma_has_reserves(vma, gbl_chg)) {
>  			SetPagePrivate(page);
>  			h->resv_huge_pages--;
> @@ -2087,8 +2091,10 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
>  out_subpool_put:
>  	if (map_chg || avoid_reserve)
>  		hugepage_subpool_put_pages(spool, 1);
> +out_reservation:
>  	vma_end_reservation(h, vma, addr);
> -	return ERR_PTR(-ENOSPC);
> +out:
> +	return ERR_PTR(ret);
>  }
>  
>  int alloc_bootmem_huge_page(struct hstate *h)

-- 
Michal Hocko
SUSE Labs
