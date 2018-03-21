Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751472AbeCUFYh convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 01:24:37 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:13407 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbeCUFYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 01:24:35 -0400
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 20 Mar 2018 22:24:34 -0700
Subject: Re: [PATCH 10/15] mm/hmm: do not differentiate between empty entry or
 missing directory v2
To: <jglisse@redhat.com>, <linux-mm@kvack.org>
CC: Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, Evgeny Baskakov <ebaskakov@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>
References: <20180320020038.3360-1-jglisse@redhat.com>
 <20180320020038.3360-11-jglisse@redhat.com>
X-Nvconfidentiality: public
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <4b0da5bb-4e44-798c-f4dd-cabc93cfeb99@nvidia.com>
Date: Tue, 20 Mar 2018 22:24:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180320020038.3360-11-jglisse@redhat.com>
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
> There is no point in differentiating between a range for which there
> is not even a directory (and thus entries) and empty entry (pte_none()
> or pmd_none() returns true).
> 
> Simply drop the distinction ie remove HMM_PFN_EMPTY flag and merge now
> duplicate hmm_vma_walk_hole() and hmm_vma_walk_clear() functions.
> 
> Changed since v1:
>   - Improved comments
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
> index 54d684fe3b90..cf283db22106 100644
> --- a/include/linux/hmm.h
> +++ b/include/linux/hmm.h
> @@ -84,7 +84,6 @@ struct hmm;
>   * HMM_PFN_VALID: pfn is valid. It has, at least, read permission.
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

Hi Jerome,

Nearly done with this one...see below for a bit more detail, but I think if we did this:

    #define HMM_PFN_EMPTY (0)

...it would work out nicely.

> -#define HMM_PFN_SPECIAL (1 << 4)
> -#define HMM_PFN_DEVICE_UNADDRESSABLE (1 << 5)
> -#define HMM_PFN_SHIFT 6
> +#define HMM_PFN_SPECIAL (1 << 3)
> +#define HMM_PFN_DEVICE_UNADDRESSABLE (1 << 4)
> +#define HMM_PFN_SHIFT 5
>  

<snip>

> @@ -438,7 +423,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
>  		pfns[i] = 0;
>  
>  		if (pte_none(pte)) {
> -			pfns[i] = HMM_PFN_EMPTY;
> +			pfns[i] = 0;

This works, but why not keep HMM_PFN_EMPTY, and just define it as zero?
Symbols are better than raw numbers here.


>  			if (hmm_vma_walk->fault)
>  				goto fault;
>  			continue;
> @@ -489,8 +474,8 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
>  
>  fault:
>  		pte_unmap(ptep);
> -		/* Fault all pages in range */
> -		return hmm_vma_walk_clear(start, end, walk);
> +		/* Fault any virtual address we were ask to fault */

                                                     asked to fault

thanks,
-- 
John Hubbard
NVIDIA
