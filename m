Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752234AbeC1KTg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 06:19:36 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39078 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750799AbeC1KTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 06:19:35 -0400
Date: Wed, 28 Mar 2018 11:19:30 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Philip Elcan <pelcan@codeaurora.org>
Cc: linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, Thomas Speier <tspeier@codeaurora.org>,
        Shanker Donthineni <shankerd@codeaurora.org>
Subject: Re: [PATCH V3] arm64: tlbflush: avoid writing RES0 bits
Message-ID: <20180328101928.tidudm6p4rtqie44@lakrids.cambridge.arm.com>
References: <1522202132-16998-1-git-send-email-pelcan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522202132-16998-1-git-send-email-pelcan@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 09:55:32PM -0400, Philip Elcan wrote:
> Several of the bits of the TLBI register operand are RES0 per the ARM
> ARM, so TLBI operations should avoid writing non-zero values to these
> bits.
> 
> This patch adds a macro __TLBI_VADDR(addr, asid) that creates the
> operand register in the correct format and honors the RES0 bits.
> 
> Signed-off-by: Philip Elcan <pelcan@codeaurora.org>
> ---
>  arch/arm64/include/asm/tlbflush.h | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index 9e82dd7..dfc61d7 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -60,6 +60,15 @@
>  		__tlbi(op, (arg) | USER_ASID_FLAG);				\
>  } while (0)
>  
> +/* This macro creates a properly formatted VA operand for the TLBI */
> +#define __TLBI_VADDR(addr, asid)				\
> +	({							\
> +		unsigned long __ta = (addr) >> 12;		\
> +		__ta &= GENMASK_ULL(43, 0);			\
> +		__ta |= (unsigned long)(asid) << 48;		\
> +		__ta;						\
> +	})

As a minor nit, we typically don't indent the start of the macro
function body, and we could drop the leading tab on each line, but
either way:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> +
>  /*
>   *	TLB Management
>   *	==============
> @@ -117,7 +126,7 @@ static inline void flush_tlb_all(void)
>  
>  static inline void flush_tlb_mm(struct mm_struct *mm)
>  {
> -	unsigned long asid = ASID(mm) << 48;
> +	unsigned long asid = __TLBI_VADDR(0, ASID(mm));
>  
>  	dsb(ishst);
>  	__tlbi(aside1is, asid);
> @@ -128,7 +137,7 @@ static inline void flush_tlb_mm(struct mm_struct *mm)
>  static inline void flush_tlb_page(struct vm_area_struct *vma,
>  				  unsigned long uaddr)
>  {
> -	unsigned long addr = uaddr >> 12 | (ASID(vma->vm_mm) << 48);
> +	unsigned long addr = __TLBI_VADDR(uaddr, ASID(vma->vm_mm));
>  
>  	dsb(ishst);
>  	__tlbi(vale1is, addr);
> @@ -146,7 +155,7 @@ static inline void __flush_tlb_range(struct vm_area_struct *vma,
>  				     unsigned long start, unsigned long end,
>  				     bool last_level)
>  {
> -	unsigned long asid = ASID(vma->vm_mm) << 48;
> +	unsigned long asid = ASID(vma->vm_mm);
>  	unsigned long addr;
>  
>  	if ((end - start) > MAX_TLB_RANGE) {
> @@ -154,8 +163,8 @@ static inline void __flush_tlb_range(struct vm_area_struct *vma,
>  		return;
>  	}
>  
> -	start = asid | (start >> 12);
> -	end = asid | (end >> 12);
> +	start = __TLBI_VADDR(start, asid);
> +	end = __TLBI_VADDR(end, asid);
>  
>  	dsb(ishst);
>  	for (addr = start; addr < end; addr += 1 << (PAGE_SHIFT - 12)) {
> @@ -185,8 +194,8 @@ static inline void flush_tlb_kernel_range(unsigned long start, unsigned long end
>  		return;
>  	}
>  
> -	start >>= 12;
> -	end >>= 12;
> +	start = __TLBI_VADDR(start, 0);
> +	end = __TLBI_VADDR(end, 0);
>  
>  	dsb(ishst);
>  	for (addr = start; addr < end; addr += 1 << (PAGE_SHIFT - 12))
> @@ -202,7 +211,7 @@ static inline void flush_tlb_kernel_range(unsigned long start, unsigned long end
>  static inline void __flush_tlb_pgtable(struct mm_struct *mm,
>  				       unsigned long uaddr)
>  {
> -	unsigned long addr = uaddr >> 12 | (ASID(mm) << 48);
> +	unsigned long addr = __TLBI_VADDR(uaddr, ASID(mm));
>  
>  	__tlbi(vae1is, addr);
>  	__tlbi_user(vae1is, addr);
> -- 
> Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
> Qualcomm Technologies, Inc. is a member of the
> Code Aurora Forum, a Linux Foundation Collaborative Project.
> 
