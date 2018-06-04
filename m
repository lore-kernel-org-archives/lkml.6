Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752673AbeFDMM7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 08:12:59 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42354 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751769AbeFDMM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 08:12:58 -0400
Date: Mon, 4 Jun 2018 13:13:28 +0100
From: Will Deacon <will.deacon@arm.com>
To: Chintan Pandya <cpandya@codeaurora.org>
Cc: catalin.marinas@arm.com, mark.rutland@arm.com,
        akpm@linux-foundation.org, toshi.kani@hpe.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 4/5] arm64: Implement page table free interfaces
Message-ID: <20180604121328.GG9482@arm.com>
References: <1527856758-27169-1-git-send-email-cpandya@codeaurora.org>
 <1527856758-27169-5-git-send-email-cpandya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527856758-27169-5-git-send-email-cpandya@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 06:09:17PM +0530, Chintan Pandya wrote:
> Implement pud_free_pmd_page() and pmd_free_pte_page().
> 
> Implementation requires,
>  1) Clearing off the current pud/pmd entry
>  2) Invalidate TLB which could have previously
>     valid but not stale entry
>  3) Freeing of the un-used next level page tables

Please can you rewrite this describing the problem that you're solving,
rather than a brief summary of some requirements?

> Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
> ---
>  arch/arm64/mm/mmu.c | 38 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 34 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 8ae5d7a..6e7e16c 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -45,6 +45,7 @@
>  #include <asm/memblock.h>
>  #include <asm/mmu_context.h>
>  #include <asm/ptdump.h>
> +#include <asm/tlbflush.h>
>  
>  #define NO_BLOCK_MAPPINGS	BIT(0)
>  #define NO_CONT_MAPPINGS	BIT(1)
> @@ -977,12 +978,41 @@ int pmd_clear_huge(pmd_t *pmdp)
>  	return 1;
>  }
>  
> -int pud_free_pmd_page(pud_t *pud, unsigned long addr)
> +int pmd_free_pte_page(pmd_t *pmdp, unsigned long addr)
>  {
> -	return pud_none(*pud);
> +	pte_t *table;
> +	pmd_t pmd;
> +
> +	pmd = READ_ONCE(*pmdp);
> +	if (pmd_present(pmd)) {
> +		table = pmd_page_vaddr(pmd);
> +		pmd_clear(pmdp);
> +		__flush_tlb_kernel_pgtable(addr);
> +		pte_free_kernel(NULL, table);
> +	}
> +	return 1;
>  }
>  
> -int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
> +int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
>  {
> -	return pmd_none(*pmd);
> +	pmd_t *table;
> +	pmd_t *entry;
> +	pud_t pud;
> +	unsigned long next, end;
> +
> +	pud = READ_ONCE(*pudp);
> +	if (pud_present(pud)) {

Just some stylistic stuff, but please can you rewrite this as:

	if (!pud_present(pud) || VM_WARN_ON(!pud_table(pud)))
		return 1;

similarly for the pmd/pte code above.

> +		table = pud_page_vaddr(pud);
> +		entry = table;

Could you rename entry -> pmdp, please?

> +		next = addr;
> +		end = addr + PUD_SIZE;
> +		do {
> +			pmd_free_pte_page(entry, next);
> +		} while (entry++, next += PMD_SIZE, next != end);
> +
> +		pud_clear(pudp);
> +		__flush_tlb_kernel_pgtable(addr);
> +		pmd_free(NULL, table);
> +	}
> +	return 1;

So with these patches, we only ever return 1 from these helpers. It looks
like the same is true for x86, so how about we make them void and move the
calls inside the conditionals in lib/ioremap.c? Obviously, this would be a
separate patch on the end.

Will
