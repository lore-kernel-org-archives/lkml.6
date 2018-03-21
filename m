Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751825AbeCUFHg convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 01:07:36 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:8444 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751477AbeCUFHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 01:07:34 -0400
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 20 Mar 2018 22:07:30 -0700
Subject: Re: [PATCH 13/15] mm/hmm: factor out pte and pmd handling to simplify
 hmm_vma_walk_pmd()
To: <jglisse@redhat.com>, <linux-mm@kvack.org>
CC: Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, Evgeny Baskakov <ebaskakov@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>
References: <20180320020038.3360-1-jglisse@redhat.com>
 <20180320020038.3360-14-jglisse@redhat.com>
X-Nvconfidentiality: public
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <e0fd4348-8b8c-90b2-a9d8-91a30768fddc@nvidia.com>
Date: Tue, 20 Mar 2018 22:07:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180320020038.3360-14-jglisse@redhat.com>
X-Originating-IP: [10.110.48.28]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/19/2018 07:00 PM, jglisse@redhat.com wrote:
> From: Jérôme Glisse <jglisse@redhat.com>
> 
> No functional change, just create one function to handle pmd and one
> to handle pte (hmm_vma_handle_pmd() and hmm_vma_handle_pte()).
> 
> Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> Cc: Evgeny Baskakov <ebaskakov@nvidia.com>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: Mark Hairgrove <mhairgrove@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> ---
>  mm/hmm.c | 174 +++++++++++++++++++++++++++++++++++++--------------------------
>  1 file changed, 102 insertions(+), 72 deletions(-)
> 
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 52cdceb35733..dc703e9c3a95 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -351,6 +351,99 @@ static int hmm_vma_walk_hole(unsigned long addr,
>  	return hmm_vma_walk->fault ? -EAGAIN : 0;
>  }
>  
> +static int hmm_vma_handle_pmd(struct mm_walk *walk,
> +			      unsigned long addr,
> +			      unsigned long end,
> +			      uint64_t *pfns,

Hi Jerome,

Nice cleanup, it makes it much easier to follow the code now.

Let's please rename the pfns argument above to "pfn", because in this
helper (and the _pte helper too), there is only one pfn involved, rather
than an array of them.

> +			      pmd_t pmd)
> +{
> +	struct hmm_vma_walk *hmm_vma_walk = walk->private;
> +	unsigned long pfn, i;
> +	uint64_t flag = 0;
> +
> +	if (pmd_protnone(pmd))
> +		return hmm_vma_walk_hole(addr, end, walk);
> +
> +	if ((hmm_vma_walk->fault & hmm_vma_walk->write) && !pmd_write(pmd))
> +		return hmm_vma_walk_hole(addr, end, walk);
> +
> +	pfn = pmd_pfn(pmd) + pte_index(addr);
> +	flag |= pmd_write(pmd) ? HMM_PFN_WRITE : 0;
> +	for (i = 0; addr < end; addr += PAGE_SIZE, i++, pfn++)
> +		pfns[i] = hmm_pfn_from_pfn(pfn) | flag;
> +	hmm_vma_walk->last = end;
> +	return 0;
> +}
> +
> +static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
> +			      unsigned long end, pmd_t *pmdp, pte_t *ptep,
> +			      uint64_t *pfns)

Same thing here: rename pfns --> pfn.

I moved diffs around to attempt to confirm that this is just a refactoring,
and it does look the same. It's easy to overlook things here, but:

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA

> +{
> +	struct hmm_vma_walk *hmm_vma_walk = walk->private;
> +	struct vm_area_struct *vma = walk->vma;
> +	pte_t pte = *ptep;
> +
> +	*pfns = 0;
> +
> +	if (pte_none(pte)) {
> +		*pfns = 0;
> +		if (hmm_vma_walk->fault)
> +			goto fault;
> +		return 0;
> +	}
> +
> +	if (!pte_present(pte)) {
> +		swp_entry_t entry = pte_to_swp_entry(pte);
> +
> +		if (!non_swap_entry(entry)) {
> +			if (hmm_vma_walk->fault)
> +				goto fault;
> +			return 0;
> +		}
> +
> +		/*
> +		 * This is a special swap entry, ignore migration, use
> +		 * device and report anything else as error.
> +		 */
> +		if (is_device_private_entry(entry)) {
> +			*pfns = hmm_pfn_from_pfn(swp_offset(entry));
> +			if (is_write_device_private_entry(entry)) {
> +				*pfns |= HMM_PFN_WRITE;
> +			} else if ((hmm_vma_walk->fault & hmm_vma_walk->write))
> +				goto fault;
> +			*pfns |= HMM_PFN_DEVICE_PRIVATE;
> +			return 0;
> +		}
> +
> +		if (is_migration_entry(entry)) {
> +			if (hmm_vma_walk->fault) {
> +				pte_unmap(ptep);
> +				hmm_vma_walk->last = addr;
> +				migration_entry_wait(vma->vm_mm,
> +						pmdp, addr);
> +				return -EAGAIN;
> +			}
> +			return 0;
> +		}
> +
> +		/* Report error for everything else */
> +		*pfns = HMM_PFN_ERROR;
> +		return -EFAULT;
> +	}
> +
> +	if ((hmm_vma_walk->fault & hmm_vma_walk->write) && !pte_write(pte))
> +		goto fault;
> +
> +	*pfns = hmm_pfn_from_pfn(pte_pfn(pte));
> +	*pfns |= pte_write(pte) ? HMM_PFN_WRITE : 0;
> +	return 0;
> +
> +fault:
> +	pte_unmap(ptep);
> +	/* Fault any virtual address we were ask to fault */
> +	return hmm_vma_walk_hole(addr, end, walk);
> +}
> +
>  static int hmm_vma_walk_pmd(pmd_t *pmdp,
>  			    unsigned long start,
>  			    unsigned long end,
> @@ -358,25 +451,20 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
>  {
>  	struct hmm_vma_walk *hmm_vma_walk = walk->private;
>  	struct hmm_range *range = hmm_vma_walk->range;
> -	struct vm_area_struct *vma = walk->vma;
>  	uint64_t *pfns = range->pfns;
>  	unsigned long addr = start, i;
> -	bool write_fault;
>  	pte_t *ptep;
>  
>  	i = (addr - range->start) >> PAGE_SHIFT;
> -	write_fault = hmm_vma_walk->fault & hmm_vma_walk->write;
>  
>  again:
>  	if (pmd_none(*pmdp))
>  		return hmm_vma_walk_hole(start, end, walk);
>  
> -	if (pmd_huge(*pmdp) && vma->vm_flags & VM_HUGETLB)
> +	if (pmd_huge(*pmdp) && (range->vma->vm_flags & VM_HUGETLB))
>  		return hmm_pfns_bad(start, end, walk);
>  
>  	if (pmd_devmap(*pmdp) || pmd_trans_huge(*pmdp)) {
> -		unsigned long pfn;
> -		uint64_t flag = 0;
>  		pmd_t pmd;
>  
>  		/*
> @@ -392,17 +480,8 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
>  		barrier();
>  		if (!pmd_devmap(pmd) && !pmd_trans_huge(pmd))
>  			goto again;
> -		if (pmd_protnone(pmd))
> -			return hmm_vma_walk_hole(start, end, walk);
>  
> -		if (write_fault && !pmd_write(pmd))
> -			return hmm_vma_walk_hole(start, end, walk);
> -
> -		pfn = pmd_pfn(pmd) + pte_index(addr);
> -		flag |= pmd_write(pmd) ? HMM_PFN_WRITE : 0;
> -		for (; addr < end; addr += PAGE_SIZE, i++, pfn++)
> -			pfns[i] = hmm_pfn_from_pfn(pfn) | flag;
> -		return 0;
> +		return hmm_vma_handle_pmd(walk, addr, end, &pfns[i], pmd);
>  	}
>  
>  	if (pmd_bad(*pmdp))
> @@ -410,67 +489,18 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
>  
>  	ptep = pte_offset_map(pmdp, addr);
>  	for (; addr < end; addr += PAGE_SIZE, ptep++, i++) {
> -		pte_t pte = *ptep;
> +		int r;
>  
> -		pfns[i] = 0;
> -
> -		if (pte_none(pte)) {
> -			pfns[i] = 0;
> -			if (hmm_vma_walk->fault)
> -				goto fault;
> -			continue;
> -		}
> -
> -		if (!pte_present(pte)) {
> -			swp_entry_t entry = pte_to_swp_entry(pte);
> -
> -			if (!non_swap_entry(entry)) {
> -				if (hmm_vma_walk->fault)
> -					goto fault;
> -				continue;
> -			}
> -
> -			/*
> -			 * This is a special swap entry, ignore migration, use
> -			 * device and report anything else as error.
> -			 */
> -			if (is_device_private_entry(entry)) {
> -				pfns[i] = hmm_pfn_from_pfn(swp_offset(entry));
> -				if (is_write_device_private_entry(entry)) {
> -					pfns[i] |= HMM_PFN_WRITE;
> -				} else if (write_fault)
> -					goto fault;
> -				pfns[i] |= HMM_PFN_DEVICE_PRIVATE;
> -			} else if (is_migration_entry(entry)) {
> -				if (hmm_vma_walk->fault) {
> -					pte_unmap(ptep);
> -					hmm_vma_walk->last = addr;
> -					migration_entry_wait(vma->vm_mm,
> -							     pmdp, addr);
> -					return -EAGAIN;
> -				}
> -				continue;
> -			} else {
> -				/* Report error for everything else */
> -				pfns[i] = HMM_PFN_ERROR;
> -			}
> -			continue;
> +		r = hmm_vma_handle_pte(walk, addr, end, pmdp, ptep, &pfns[i]);
> +		if (r) {
> +			/* hmm_vma_handle_pte() did unmap pte directory */
> +			hmm_vma_walk->last = addr;
> +			return r;
>  		}
> -
> -		if (write_fault && !pte_write(pte))
> -			goto fault;
> -
> -		pfns[i] = hmm_pfn_from_pfn(pte_pfn(pte));
> -		pfns[i] |= pte_write(pte) ? HMM_PFN_WRITE : 0;
> -		continue;
> -
> -fault:
> -		pte_unmap(ptep);
> -		/* Fault any virtual address we were ask to fault */
> -		return hmm_vma_walk_hole(start, end, walk);
>  	}
>  	pte_unmap(ptep - 1);
>  
> +	hmm_vma_walk->last = addr;
>  	return 0;
>  }
>  
> 
