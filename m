Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933576AbeCSXGQ convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 19:06:16 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:10562 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933347AbeCSXGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 19:06:12 -0400
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 19 Mar 2018 16:06:08 -0700
Subject: Re: [PATCH 09/14] mm/hmm: do not differentiate between empty entry or
 missing directory
To: <jglisse@redhat.com>, <linux-mm@kvack.org>
CC: Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, Evgeny Baskakov <ebaskakov@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>
References: <20180316191414.3223-1-jglisse@redhat.com>
 <20180316191414.3223-10-jglisse@redhat.com>
X-Nvconfidentiality: public
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <680af8e7-0f6d-85cb-f259-8a6a1d1dc9c3@nvidia.com>
Date: Mon, 19 Mar 2018 16:06:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180316191414.3223-10-jglisse@redhat.com>
X-Originating-IP: [10.110.48.28]
X-ClientProxiedBy: HQMAIL102.nvidia.com (172.18.146.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/16/2018 12:14 PM, jglisse@redhat.com wrote:
> From: Jérôme Glisse <jglisse@redhat.com>
> 
> There is no point in differentiating between a range for which there
> is not even a directory (and thus entries) and empty entry (pte_none()
> or pmd_none() returns true).
> 
> Simply drop the distinction ie remove HMM_PFN_EMPTY flag and merge now
> duplicate hmm_vma_walk_hole() and hmm_vma_walk_clear() functions.
> 
> Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> Cc: Evgeny Baskakov <ebaskakov@nvidia.com>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: Mark Hairgrove <mhairgrove@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> ---
>  include/linux/hmm.h |  8 +++-----
>  mm/hmm.c            | 45 +++++++++++++++------------------------------
>  2 files changed, 18 insertions(+), 35 deletions(-)
> 
> diff --git a/include/linux/hmm.h b/include/linux/hmm.h
> index 78b3ed6d7977..6d2b6bf6da4b 100644
> --- a/include/linux/hmm.h
> +++ b/include/linux/hmm.h
> @@ -84,7 +84,6 @@ struct hmm;
>   * HMM_PFN_VALID: pfn is valid
>   * HMM_PFN_WRITE: CPU page table has write permission set
>   * HMM_PFN_ERROR: corresponding CPU page table entry points to poisoned memory
> - * HMM_PFN_EMPTY: corresponding CPU page table entry is pte_none()
>   * HMM_PFN_SPECIAL: corresponding CPU page table entry is special; i.e., the
>   *      result of vm_insert_pfn() or vm_insert_page(). Therefore, it should not
>   *      be mirrored by a device, because the entry will never have HMM_PFN_VALID
> @@ -94,10 +93,9 @@ struct hmm;
>  #define HMM_PFN_VALID (1 << 0)
>  #define HMM_PFN_WRITE (1 << 1)
>  #define HMM_PFN_ERROR (1 << 2)
> -#define HMM_PFN_EMPTY (1 << 3)
> -#define HMM_PFN_SPECIAL (1 << 4)
> -#define HMM_PFN_DEVICE_UNADDRESSABLE (1 << 5)
> -#define HMM_PFN_SHIFT 6
> +#define HMM_PFN_SPECIAL (1 << 3)
> +#define HMM_PFN_DEVICE_UNADDRESSABLE (1 << 4)
> +#define HMM_PFN_SHIFT 5
>  
>  /*
>   * hmm_pfn_to_page() - return struct page pointed to by a valid HMM pfn
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 04595a994542..2118e42cb838 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -305,6 +305,16 @@ static void hmm_pfns_clear(uint64_t *pfns,
>  		*pfns = 0;
>  }
>  
> +/*
> + * hmm_vma_walk_hole() - handle a range back by no pmd or no pte


Maybe write it like this:

 * hmm_vma_walk_hole() - handle a range that is not backed by any pmd or pte
 

> + * @start: range virtual start address (inclusive)
> + * @end: range virtual end address (exclusive)
> + * @walk: mm_walk structure
> + * Returns: 0 on success, -EAGAIN after page fault, or page fault error
> + *
> + * This is an helper call whenever pmd_none() or pte_none() returns true
> + * or when there is no directory covering the range.

Instead of those two lines, how about:

 * This routine will be called whenever pmd_none() or pte_none() returns
 * true, or whenever there is no page directory covering the VA range.


> + */
>  static int hmm_vma_walk_hole(unsigned long addr,
>  			     unsigned long end,
>  			     struct mm_walk *walk)
> @@ -314,31 +324,6 @@ static int hmm_vma_walk_hole(unsigned long addr,
>  	uint64_t *pfns = range->pfns;
>  	unsigned long i;
>  
> -	hmm_vma_walk->last = addr;
> -	i = (addr - range->start) >> PAGE_SHIFT;
> -	for (; addr < end; addr += PAGE_SIZE, i++) {
> -		pfns[i] = HMM_PFN_EMPTY;
> -		if (hmm_vma_walk->fault) {
> -			int ret;
> -
> -			ret = hmm_vma_do_fault(walk, addr, &pfns[i]);
> -			if (ret != -EAGAIN)
> -				return ret;
> -		}
> -	}
> -
> -	return hmm_vma_walk->fault ? -EAGAIN : 0;
> -}
> -
> -static int hmm_vma_walk_clear(unsigned long addr,
> -			      unsigned long end,
> -			      struct mm_walk *walk)
> -{
> -	struct hmm_vma_walk *hmm_vma_walk = walk->private;
> -	struct hmm_range *range = hmm_vma_walk->range;
> -	uint64_t *pfns = range->pfns;
> -	unsigned long i;
> -

Nice consolidation!

>  	hmm_vma_walk->last = addr;
>  	i = (addr - range->start) >> PAGE_SHIFT;
>  	for (; addr < end; addr += PAGE_SIZE, i++) {
> @@ -397,10 +382,10 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
>  		if (!pmd_devmap(pmd) && !pmd_trans_huge(pmd))
>  			goto again;
>  		if (pmd_protnone(pmd))
> -			return hmm_vma_walk_clear(start, end, walk);
> +			return hmm_vma_walk_hole(start, end, walk);
>  
>  		if (write_fault && !pmd_write(pmd))
> -			return hmm_vma_walk_clear(start, end, walk);
> +			return hmm_vma_walk_hole(start, end, walk);
>  
>  		pfn = pmd_pfn(pmd) + pte_index(addr);
>  		flag |= pmd_write(pmd) ? HMM_PFN_WRITE : 0;
> @@ -419,7 +404,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
>  		pfns[i] = 0;
>  
>  		if (pte_none(pte)) {
> -			pfns[i] = HMM_PFN_EMPTY;
> +			pfns[i] = 0;

Why is this being set to zero? (0 == HMM_PFN_VALID, btw.)
I would have expected HMM_PFN_NONE. Actually, looking through the 
larger patchset, I think there are a couple of big questions about
these HMM_PFN_* flags. Maybe it's just that the comment documentation
has fallen completely behind, but it looks like there is an actual
problem in the code:

1. HMM_PFN_* used to be bit shifts, so setting them directly sometimes
worked. But now they are enum values, so that doesn't work anymore.
Yet they are still being set directly in places: the enum is being
treated as a flag, probably incorrectly.

Previously: 

#define HMM_PFN_VALID (1 << 0)
#define HMM_PFN_WRITE (1 << 1)
#define HMM_PFN_ERROR (1 << 2)
#define HMM_PFN_EMPTY (1 << 3)
...

New:

enum hmm_pfn_flag_e {
	HMM_PFN_VALID = 0,
	HMM_PFN_WRITE,
	HMM_PFN_ERROR,
	HMM_PFN_NONE,
...

Yet we still have, for example:

    pfns = HMM_PFN_ERROR;

This might be accidentally working, because HMM_PFN_ERROR
has a value of 2, so only one bit is set, but...yikes.

2. The hmm_range.flags variable is a uint64_t* (pointer). And then
the patchset uses the HMM_PFN_* enum to *index* into that as an 
array. Something is highly suspect here, because...an array that is
indexed by HMM_PFN_* enums? It's certainly not documented that way.

Examples:
    range->flags[HMM_PFN_ERROR]
 
    range->flags[HMM_PFN_VALID] 

I'll go through and try to point these out right next to the relevant
parts of the patchset, but because I'm taking a little longer than 
I'd hoped to review this, I figured it's best to alert you earlier, as
soon as I spot something.

>  			if (hmm_vma_walk->fault)
>  				goto fault;
>  			continue;
> @@ -470,8 +455,8 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
>  
>  fault:
>  		pte_unmap(ptep);
> -		/* Fault all pages in range */
> -		return hmm_vma_walk_clear(start, end, walk);
> +		/* Fault all pages in range if ask for */

Maybe this, instead (assuming I understand this correctly):

                /*
                 * Fault in each page in the range, if that page was
                 * requested.
                 */

thanks,
-- 
John Hubbard
NVIDIA

> +		return hmm_vma_walk_hole(start, end, walk);
>  	}
>  	pte_unmap(ptep - 1);
>  
> 
