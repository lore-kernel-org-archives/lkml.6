Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970616AbeEXO7m (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 10:59:42 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54444 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966726AbeEXO7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 10:59:39 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1D99C60262
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cpandya@codeaurora.org
Subject: Re: [PATCH v10 3/4] arm64: Implement page table free interfaces
To: will.deacon@arm.com, catalin.marinas@arm.com, mark.rutland@arm.com,
        labbott@redhat.com, akpm@linux-foundation.org
Cc: toshi.kani@hpe.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1527170250-5291-1-git-send-email-cpandya@codeaurora.org>
 <1527170250-5291-4-git-send-email-cpandya@codeaurora.org>
From: Chintan Pandya <cpandya@codeaurora.org>
Message-ID: <9cecab0d-3045-39dd-638e-59e4e951d23a@codeaurora.org>
Date: Thu, 24 May 2018 20:29:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1527170250-5291-4-git-send-email-cpandya@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/24/2018 7:27 PM, Chintan Pandya wrote:
> Implement pud_free_pmd_page() and pmd_free_pte_page().
> 
> Implementation requires,
>   1) Clearing off the current pud/pmd entry
>   2) Invalidate TLB which could have previously
>      valid but not stale entry
>   3) Freeing of the un-used next level page tables
> 
> Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
> ---
>   arch/arm64/mm/mmu.c | 34 ++++++++++++++++++++++++++++++----
>   1 file changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index da98828..17d9282 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -45,6 +45,7 @@
>   #include <asm/memblock.h>
>   #include <asm/mmu_context.h>
>   #include <asm/ptdump.h>
> +#include <asm/tlbflush.h>
>   
>   #define NO_BLOCK_MAPPINGS	BIT(0)
>   #define NO_CONT_MAPPINGS	BIT(1)
> @@ -973,12 +974,37 @@ int pmd_clear_huge(pmd_t *pmdp)
>   	return 1;
>   }
>   
> -int pud_free_pmd_page(pud_t *pud, unsigned long addr)
> +int pmd_free_pte_page(pmd_t *pmdp, unsigned long addr)
>   {
> -	return pud_none(*pud);
> +	pmd_t *table;
> +	pmd_t pmd;
> +
> +	pmd = READ_ONCE(*pmdp);
> +	if (pmd_present(pmd)) {
> +		table = __va(pmd_val(pmd));
> +		pmd_clear(pmdp);
> +		__flush_tlb_kernel_pgtable(addr);
> +		pte_free_kernel(NULL, (pte_t *) table);
> +	}
> +	return 1;
>   }
>   
> -int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
> +int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
>   {
> -	return pmd_none(*pmd);
> +	pmd_t *table;
> +	pud_t pud;
> +	int i = 0;
> +
> +	pud = READ_ONCE(*pudp);
> +	if (pud_present(pud)) {
> +		table = __va(pud_val(pud));
> +		do {
> +			pmd_free_pte_page(&table[i], addr + (i * PMD_SIZE));
> +		} while (i++, i < PTRS_PER_PMD);
Hi Will,

Right after sending these patches, I realized that do-while condition
can be made to look like what we see in ioremap/vmalloc code. I guess,
that's what you suggested. So, I'll raise v11 fixing that. Any more
concerns ?

> +
> +		pud_clear(pudp);
> +		__flush_tlb_kernel_pgtable(addr);
> +		pmd_free(NULL, table);
> +	}
> +	return 1;
>   }
> 

Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
