Return-Path: <will.deacon@arm.com>
X-Google-Smtp-Source: AIpwx4+h/RvhJpoj3f7BhH9+BzKHC71WlvkwLud5gpy/2SEhPYYedlw47kAE4MgraKmSMT4SI1Lh
ARC-Seal: i=1; a=rsa-sha256; t=1522173639; cv=none;
        d=google.com; s=arc-20160816;
        b=K47yI4MJUmw5DnXkzkS/2Xu5BbhhLm7heU6xPq1FbUxZXjv+SicFzHT6cMItl9M9ue
         drI1jEmiGhzeGu3gmvgCqKbHRV4LdgXvR50HjD8B2i0UDfcesdfXa5WEnC9YJxd4yvN6
         YAUtXGXbHrLSy9HwhvWfgNPEtEelI7LB1nMNNxd4W8D0NCzxg2XBbklLmRIgvMy3LR7O
         TexRNWSoqsr/VbN08LxX46YaWtT25B9CnfZV7KbVgitddmSELvqzNFkBIYKqtxfBJWLh
         5TN+d/zw9p70SNsV1sWRvJH/Y123+9frZGPyWh/U7d59o91hXb3Y8nQo+xN5bytPAOpX
         Xo6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=2cQRaZj5JVDMmxUytvTdSflNCmKVcZrdwjIJmILAcdc=;
        b=oSxUtxC2T7ulRdrLtym3D33lCk6fX+9VyEy/w1SA5ZG+iqVpkvuDXNK+CLcCzxDGdf
         q81NryTWKoAVCIYrZAx5fqBQGjsy2fm4LvLIGg1WcbFeOsPlB5T4+tG0OLvPmM7v2g9O
         UhiWg5zU/4ZKPbyma2VEzOnlrMUCz1gbet4A/deG/lsAo4o4L6vMrnsB43hPLVPCF+oN
         CHk5aE7GNxsnNT9WqNnW3pOB7oZ2VEYFM5dVSJDC2F2p0o6Tl8zIaVxhWaUyN/JbM0da
         P+Ul2DBp0uQyWib9t2CsiBXrGebGRW0tzPYlkwbsMBzxE3z3G6J5fgJ9fswXiaDJTQbN
         PoHw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of will.deacon@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=will.deacon@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of will.deacon@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=will.deacon@arm.com
Date: Tue, 27 Mar 2018 19:00:48 +0100
From: Will Deacon <will.deacon@arm.com>
To: Chintan Pandya <cpandya@codeaurora.org>
Cc: catalin.marinas@arm.com, mark.rutland@arm.com, toshi.kani@hpe.com,
	arnd@arndb.de, ard.biesheuvel@linaro.org, marc.zyngier@arm.com,
	james.morse@arm.com, kristina.martsenko@arm.com,
	takahiro.akashi@linaro.org, gregkh@linuxfoundation.org,
	tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	akpm@linux-foundation.org
Subject: Re: [PATCH v5 3/4] arm64: Implement page table free interfaces
Message-ID: <20180327180048.GJ18435@arm.com>
References: <1522157100-16879-1-git-send-email-cpandya@codeaurora.org>
 <1522157100-16879-4-git-send-email-cpandya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522157100-16879-4-git-send-email-cpandya@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595007777008930452?=
X-GMAIL-MSGID: =?utf-8?q?1596114745855249700?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Chintan,

On Tue, Mar 27, 2018 at 06:54:59PM +0530, Chintan Pandya wrote:
> Implement pud_free_pmd_page() and pmd_free_pte_page().
> 
> Implementation requires,
>  1) Freeing of the un-used next level page tables
>  2) Clearing off the current pud/pmd entry
>  3) Invalidate TLB which could have previously
>     valid but not stale entry
> 
> Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
> ---
> V4->V5:
>  - Using __flush_tlb_kernel_pgtable instead of
>    flush_tlb_kernel_range
> 
> 
>  arch/arm64/mm/mmu.c | 33 +++++++++++++++++++++++++++++++--
>  1 file changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index da98828..3552c7a 100644
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
> @@ -973,12 +974,40 @@ int pmd_clear_huge(pmd_t *pmdp)
>  	return 1;
>  }
>  
> +static int __pmd_free_pte_page(pmd_t *pmd, unsigned long addr, bool tlb_inv)
> +{
> +	pmd_t *table;
> +
> +	if (pmd_val(*pmd)) {

Please can you follow what I did in 20a004e7b017 ("arm64: mm: Use
READ_ONCE/WRITE_ONCE when accessing page tables") and:

  1. Use consistent naming, so pmd_t * pmdp.
  2. Use READ_ONCE to dereference the entry once into a local.

Similarly for the pud code below.

> +		table = __va(pmd_val(*pmd));
> +		pmd_clear(pmd);
> +		if (tlb_inv)
> +			__flush_tlb_kernel_pgtable(addr);
> +
> +		free_page((unsigned long) table);

Hmm. Surely it's only safe to call free_page if !tlb_inv in situations when
the page table is already disconnected at a higher level? That doesn't
appear to be the case with the function below, which still has the pud
installed. What am I missing?

> +	}
> +	return 1;
> +}
> +
>  int pud_free_pmd_page(pud_t *pud, unsigned long addr)
>  {
> -	return pud_none(*pud);
> +	pmd_t *table;
> +	int i;
> +
> +	if (pud_val(*pud)) {
> +		table = __va(pud_val(*pud));
> +		for (i = 0; i < PTRS_PER_PMD; i++)
> +			__pmd_free_pte_page(&table[i], addr + (i * PMD_SIZE),
> +						false);
> +
> +		pud_clear(pud);
> +		flush_tlb_kernel_range(addr, addr + PUD_SIZE);

Why aren't you using __flush_tlb_kernel_pgtable here?

Will
