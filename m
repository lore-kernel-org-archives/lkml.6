Return-Path: <mark.rutland@arm.com>
X-Google-Smtp-Source: AG47ELtmv8sB2nx9zAxX2NyyhSg2Lo8u9hQkTBrj9m4grmigxC5Fsjy6ZRNczrcVqXcQvH/nqWSW
ARC-Seal: i=1; a=rsa-sha256; t=1521119932; cv=none;
        d=google.com; s=arc-20160816;
        b=geZ1QdZCNzjEd4oeuGzBcYijgN9SWVfIY4guu52iiGUC3UJQYaQZpeXIvWdnBfGfSy
         NTqCQ2HVBCWdIrDgz1Us5eEi58G//l3OQB8zicU4MsWdfL+PQ4Nc6dvtyKvmIlTVQtrW
         BGAXR2l6IazCJKwLJCA1x5BeHD78AXMuaGiFsZLulQF2fjXQI/q10xtOwTsWSjTn2ZbT
         wcH12dBPEzqzTasC2vehmwf+zlURTsqYoBtF4LzTn5GKTYK3Kr4t0Es2hGv+lUmSGukA
         Gji3VFb5aprOSx3Z+hjP2NIEM4aeyb4zc9seKq8TSZEey0nNFHACYj4tlF/fEtaGBZJA
         33rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=yZtSiYOTp28Ucf1tEXyTM9AbUXlXVkfCgRrVPbHcrtk=;
        b=P9k7oq8SI24RdyDSXV1GUOmSlB0duzJkkUkENkuYeJVmrrDn/Kdn7rUCcQ2UwWCwFK
         6haepAnVMd67RaDXwwSxm7pWODRWeniAreT1h+ud74CKvnfBK6L3mNId4MK61lYBNXmD
         JOshZUR94nMJLpF3vU25m+rwgDxbBl74P1Un3avv+iR3AypK2jaw1q9XGaddRRUSUBms
         gQLfpzfx1MQL239dXt+u04TpAsDMIm0ZqKrFS9porJV9NWWHZOix0KolMQ5Sihn4Cvla
         ASaHqQiMayH8tXyGik4lbu61dyeS14M6RrW/C1dr5SBip+bLhVToMkpZAVN0JnyeQjUV
         1gJw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of mark.rutland@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=mark.rutland@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of mark.rutland@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=mark.rutland@arm.com
Date: Thu, 15 Mar 2018 13:18:46 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Chintan Pandya <cpandya@codeaurora.org>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de,
	ard.biesheuvel@linaro.org, marc.zyngier@arm.com,
	james.morse@arm.com, kristina.martsenko@arm.com,
	takahiro.akashi@linaro.org, gregkh@linuxfoundation.org,
	tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	akpm@linux-foundation.org, toshi.kani@hpe.com
Subject: Re: [PATCH v2 3/4] arm64: Implement page table free interfaces
Message-ID: <20180315131846.sfpxg3xlpjii3nju@lakrids.cambridge.arm.com>
References: <1521117906-20107-1-git-send-email-cpandya@codeaurora.org>
 <1521117906-20107-4-git-send-email-cpandya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521117906-20107-4-git-send-email-cpandya@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595007777008930452?=
X-GMAIL-MSGID: =?utf-8?q?1595009854592221667?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 06:15:05PM +0530, Chintan Pandya wrote:
> Implement pud_free_pmd_page() and pmd_free_pte_page().
> 
> Make sure, that they are indeed a page table before
> taking them to free.

As mentioned on the prior patch, if the tables we're freeing contain
valid entries, then we need additional TLB maintenance to ensure that
all of these entries have been removed from TLBs.

Either, we always invalidate the entire range, or we walk the tables
and invalidate as we remove them.

Thanks,
Mark.

> 
> Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
> ---
>  arch/arm64/mm/mmu.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 2dbb2c9..6f21a65 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -32,6 +32,7 @@
>  #include <linux/io.h>
>  #include <linux/mm.h>
>  #include <linux/vmalloc.h>
> +#include <linux/hugetlb.h>
>  
>  #include <asm/barrier.h>
>  #include <asm/cputype.h>
> @@ -45,6 +46,7 @@
>  #include <asm/memblock.h>
>  #include <asm/mmu_context.h>
>  #include <asm/ptdump.h>
> +#include <asm/page.h>
>  
>  #define NO_BLOCK_MAPPINGS	BIT(0)
>  #define NO_CONT_MAPPINGS	BIT(1)
> @@ -975,10 +977,24 @@ int pmd_clear_huge(pmd_t *pmdp)
>  
>  int pud_free_pmd_page(pud_t *pud)
>  {
> -	return pud_none(*pud);
> +	pmd_t *pmd;
> +	int i;
> +
> +	pmd = __va(pud_val(*pud));
> +	if (pud_val(*pud) && !pud_huge(*pud)) {
> +		for (i = 0; i < PTRS_PER_PMD; i++)
> +			pmd_free_pte_page(&pmd[i]);
> +
> +		free_page((unsigned long)pmd);
> +	}
> +
> +	return 1;
>  }
>  
>  int pmd_free_pte_page(pmd_t *pmd)
>  {
> -	return pmd_none(*pmd);
> +	if (pmd_val(*pmd) && !pmd_huge(*pmd))
> +		free_page((unsigned long)__va(pmd_val(*pmd)));
> +
> +	return 1;
>  }
> -- 
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation
> Center, Inc., is a member of Code Aurora Forum, a Linux Foundation
> Collaborative Project
> 
