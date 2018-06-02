Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751993AbeFBWCa (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 18:02:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49022 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751436AbeFBWC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 18:02:28 -0400
Date: Sat, 2 Jun 2018 15:01:36 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Souptick Joarder <jrdr.linux@gmail.com>
Cc: viro@zeniv.linux.org.uk, hughd@google.com, akpm@linux-foundation.org,
        mhocko@suse.com, ross.zwisler@linux.intel.com, zi.yan@cs.rutgers.edu,
        kirill.shutemov@linux.intel.com, dan.j.williams@intel.com,
        gregkh@linuxfoundation.org, mark.rutland@arm.com, riel@redhat.com,
        pasha.tatashin@oracle.com, jschoenh@amazon.de,
        kstewart@linuxfoundation.org, rientjes@google.com, tglx@linutronix.de,
        peterz@infradead.org, mgorman@suse.de, yang.s@alibaba-inc.com,
        minchan@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: Change return type int to vm_fault_t for fault
 handlers
Message-ID: <20180602220136.GA14810@bombadil.infradead.org>
References: <20180602200407.GA15200@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180602200407.GA15200@jordon-HP-15-Notebook-PC>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 03, 2018 at 01:34:07AM +0530, Souptick Joarder wrote:
> @@ -3570,9 +3571,8 @@ static int hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
>  			return 0;
>  		}
>  
> -		ret = (PTR_ERR(new_page) == -ENOMEM) ?
> -			VM_FAULT_OOM : VM_FAULT_SIGBUS;
> -		goto out_release_old;
> +		ret = vmf_error(PTR_ERR(new_page));
> +			goto out_release_old;
>  	}
>  
>  	/*

Something weird happened to the goto here?

> +static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
> +			struct vm_area_struct *vma,
> +			struct address_space *mapping, pgoff_t idx,
> +			unsigned long address, pte_t *ptep, unsigned int flags)
>  {
>  	struct hstate *h = hstate_vma(vma);
> -	int ret = VM_FAULT_SIGBUS;
> -	int anon_rmap = 0;
> +	vm_fault_t ret = VM_FAULT_SIGBUS;
> +	int anon_rmap = 0, err;
>  	unsigned long size;
>  	struct page *page;
>  	pte_t new_pte;
> @@ -3742,11 +3743,8 @@ static int hugetlb_no_page(struct mm_struct *mm, struct vm_area_struct *vma,
>  
>  		page = alloc_huge_page(vma, address, 0);
>  		if (IS_ERR(page)) {
> -			ret = PTR_ERR(page);
> -			if (ret == -ENOMEM)
> -				ret = VM_FAULT_OOM;
> -			else
> -				ret = VM_FAULT_SIGBUS;
> +			err = PTR_ERR(page);
> +			ret = vmf_error(err);
>  			goto out;
>  		}
>  		clear_huge_page(page, address, pages_per_huge_page(h));

Not sure why you bother with the 'int err' in this function when just
above you were happy to do

			ret = vmf_error(PTR_ERR(page));

With those fixed,

Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
