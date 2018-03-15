Return-Path: <mark.rutland@arm.com>
X-Google-Smtp-Source: AG47ELsTmigx/WOyL4Uk+Jg1lay2FChz622FUJgPUqSZKi6mc5fBrXtGIL/Tf8n8tcXSRwj/ZGTt
ARC-Seal: i=1; a=rsa-sha256; t=1521119607; cv=none;
        d=google.com; s=arc-20160816;
        b=Igzyw4IlLy9g7uX9b1oph+U34HZ44VY7VLSBRrGO6T+2V2xqmshQLINzThw/ls6dlL
         0pnix5S4aNB5XJoj4XdSxGMcemLVzXd5jc29Fl+1nbdmMmcj5Oyzc7jNVCT4RsZg8mUh
         N80Vn7afqiaLS8LmrdLTuBD0QKKU5EnEWVm1DmfU7JybbiZX2MXJfbQ2ipsDOyyK9srZ
         sFa/fVAUps0O/LOIksIxKdys7kuho8OksEB0H8iib4w89XS18x7aW+lnIeMe10EVWn1b
         ZRM4yBQiv9SQ1Qy+bVwr9pb/UHKv2umUHo5klA3DFhr/FsTLDCfBBXLzGu/cF5aFA3F+
         IVRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=U547AOvfyP+h/ibADRi2yxgd2Ig6vE0jvlMh8xnOv4E=;
        b=Xxz+GxCSai9qz6GINRIIhy6/FAo+I5VlXSzgtk6+FTqajKD5APE1ZDzxI/Zl5ZiJoJ
         TFE70FB6Rwg/Zybp62yq5FznW3EPJkTa5Cu642G3mxUD1/E/N1YYB+7S/ZgXOJo0wlym
         VDyM+9HANgM6k6Z3V0vPmnv4tEuG0YFR5QgSvSj7c4BdK5qHrSNB6rE3Hb/d4LKKlDCp
         uPPNBnahxQ9cHJ6AGrJlFDIKycvHKNzZJxMvmNto4lYI0/WipTVyMAMYsrMboCoE6wGD
         kNJGDmiLYMdOV5nuRIs5xQy9TY/w01xUIfkh8Q1PgGIyFEq0AyVAiddd0Q5iJKJMGHJW
         i7Og==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of mark.rutland@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=mark.rutland@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of mark.rutland@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=mark.rutland@arm.com
Date: Thu, 15 Mar 2018 13:13:16 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Chintan Pandya <cpandya@codeaurora.org>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de,
	ard.biesheuvel@linaro.org, marc.zyngier@arm.com,
	james.morse@arm.com, kristina.martsenko@arm.com,
	takahiro.akashi@linaro.org, gregkh@linuxfoundation.org,
	tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	akpm@linux-foundation.org, toshi.kani@hpe.com
Subject: Re: [PATCH v2 2/4] ioremap: Implement TLB_INV before huge mapping
Message-ID: <20180315131316.fd5ftqwgdb5bf5we@lakrids.cambridge.arm.com>
References: <1521117906-20107-1-git-send-email-cpandya@codeaurora.org>
 <1521117906-20107-3-git-send-email-cpandya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521117906-20107-3-git-send-email-cpandya@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595007763353693659?=
X-GMAIL-MSGID: =?utf-8?q?1595009513102313598?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

As a general note, pleas wrap commit text to 72 characters.

On Thu, Mar 15, 2018 at 06:15:04PM +0530, Chintan Pandya wrote:
> Huge mapping changes PMD/PUD which could have
> valid previous entries. This requires proper
> TLB maintanance on some architectures, like
> ARM64.

Just to check, I take it that you mean we could have a valid table
entry, but all the entries in that next level table must be invalid,
right?

> 
> Implent BBM (break-before-make) safe TLB
> invalidation.
> 
> Here, I've used flush_tlb_pgtable() instead
> of flush_kernel_range() because invalidating
> intermediate page_table entries could have
> been optimized for specific arch. That's the
> case with ARM64 at least.

... because if there are valid entries in the next level table,
__flush_tlb_pgtable() is not sufficient to ensure all of these are
removed from the TLB.

Assuming that all entries in the next level table are invalid, this
looks ok to me.

Thanks,
Mark.

> Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
> ---
>  lib/ioremap.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/lib/ioremap.c b/lib/ioremap.c
> index 54e5bba..55f8648 100644
> --- a/lib/ioremap.c
> +++ b/lib/ioremap.c
> @@ -13,6 +13,7 @@
>  #include <linux/export.h>
>  #include <asm/cacheflush.h>
>  #include <asm/pgtable.h>
> +#include <asm-generic/tlb.h>
>  
>  #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
>  static int __read_mostly ioremap_p4d_capable;
> @@ -80,6 +81,7 @@ static inline int ioremap_pmd_range(pud_t *pud, unsigned long addr,
>  		unsigned long end, phys_addr_t phys_addr, pgprot_t prot)
>  {
>  	pmd_t *pmd;
> +	pmd_t old_pmd;
>  	unsigned long next;
>  
>  	phys_addr -= addr;
> @@ -91,10 +93,15 @@ static inline int ioremap_pmd_range(pud_t *pud, unsigned long addr,
>  
>  		if (ioremap_pmd_enabled() &&
>  		    ((next - addr) == PMD_SIZE) &&
> -		    IS_ALIGNED(phys_addr + addr, PMD_SIZE) &&
> -		    pmd_free_pte_page(pmd)) {
> -			if (pmd_set_huge(pmd, phys_addr + addr, prot))
> +		    IS_ALIGNED(phys_addr + addr, PMD_SIZE)) {
> +			old_pmd = *pmd;
> +			pmd_clear(pmd);
> +			flush_tlb_pgtable(&init_mm, addr);
> +			if (pmd_set_huge(pmd, phys_addr + addr, prot)) {
> +				pmd_free_pte_page(&old_pmd);
>  				continue;
> +			} else
> +				set_pmd(pmd, old_pmd);
>  		}
>  
>  		if (ioremap_pte_range(pmd, addr, next, phys_addr + addr, prot))
> @@ -107,6 +114,7 @@ static inline int ioremap_pud_range(p4d_t *p4d, unsigned long addr,
>  		unsigned long end, phys_addr_t phys_addr, pgprot_t prot)
>  {
>  	pud_t *pud;
> +	pud_t old_pud;
>  	unsigned long next;
>  
>  	phys_addr -= addr;
> @@ -118,10 +126,15 @@ static inline int ioremap_pud_range(p4d_t *p4d, unsigned long addr,
>  
>  		if (ioremap_pud_enabled() &&
>  		    ((next - addr) == PUD_SIZE) &&
> -		    IS_ALIGNED(phys_addr + addr, PUD_SIZE) &&
> -		    pud_free_pmd_page(pud)) {
> -			if (pud_set_huge(pud, phys_addr + addr, prot))
> +		    IS_ALIGNED(phys_addr + addr, PUD_SIZE)) {
> +			old_pud = *pud;
> +			pud_clear(pud);
> +			flush_tlb_pgtable(&init_mm, addr);
> +			if (pud_set_huge(pud, phys_addr + addr, prot)) {
> +				pud_free_pmd_page(&old_pud);
>  				continue;
> +			} else
> +				set_pud(pud, old_pud);
>  		}
>  
>  		if (ioremap_pmd_range(pud, addr, next, phys_addr + addr, prot))
> -- 
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation
> Center, Inc., is a member of Code Aurora Forum, a Linux Foundation
> Collaborative Project
> 
