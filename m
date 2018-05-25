Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968437AbeEYUpC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 16:45:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60384 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968275AbeEYUpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 16:45:01 -0400
Date: Fri, 25 May 2018 13:44:59 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: David Rientjes <rientjes@google.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [patch] mm, hugetlb_cgroup: suppress SIGBUS when hugetlb_cgroup
 charge fails
Message-Id: <20180525134459.5c6f8e06f55307f72b95a901@linux-foundation.org>
In-Reply-To: <alpine.DEB.2.21.1805251316090.167008@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1805251316090.167008@chino.kir.corp.google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 May 2018 13:16:45 -0700 (PDT) David Rientjes <rientjes@google.com> wrote:

> When charging to a hugetlb_cgroup fails, alloc_huge_page() returns
> ERR_PTR(-ENOSPC) which will cause VM_FAULT_SIGBUS to be returned to the
> page fault handler.
> 
> Instead, return the proper error code, ERR_PTR(-ENOMEM), so VM_FAULT_OOM
> is handled correctly.  This is consistent with failing mem cgroup charges
> in the non-hugetlb fault path.
> 
> At the same time, restructure the return paths of alloc_huge_page() so it
> is consistent.

Patch doesn't appear to match the changelog?

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

This doesn't change the return value.

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

Nor does this.
 
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

Nor does this.

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

It would be nice if you could add a comment over alloc_huge_page()
explaining the return values (at least).  Why sometimes ENOMEM, other
times ENOSPC?
