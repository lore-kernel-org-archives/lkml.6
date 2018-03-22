Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751739AbeCVSaa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 14:30:30 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41784 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751692AbeCVSa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 14:30:28 -0400
Subject: Re: [PATCH] arm64: tlbflush: avoid writing RES0 bits
To: Philip Elcan <pelcan@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Cc: Thomas Speier <tspeier@codeaurora.org>,
        Shanker Donthineni <shankerd@codeaurora.org>
References: <1521666172-2494-1-git-send-email-pelcan@codeaurora.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <00ae42df-d0b7-f63b-9cca-4c3e65a3938e@arm.com>
Date: Thu, 22 Mar 2018 18:30:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521666172-2494-1-git-send-email-pelcan@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/18 21:02, Philip Elcan wrote:
> Bits [47:44] of the TLBI register operand are RES0 for instructions that
> require a VA, per the ARM ARM spec, so TLBI operations should avoid writing
> non-zero values to these bits.

If we're going to start sanitising addresses to respect RES0 bits, then 
we should probably do it properly to cope with the cases where bits 
63:47 are also RES0, and others - I guess we never actually try to do 
something like VAE1IS with a kernel VA, but AFAICS that would still be 
busted even after this patch.

Robin.

> Signed-off-by: Philip Elcan <pelcan@codeaurora.org>
> ---
>   arch/arm64/include/asm/tlbflush.h | 16 ++++++++++------
>   1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index 9e82dd7..dbd22a9 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -60,6 +60,9 @@
>   		__tlbi(op, (arg) | USER_ASID_FLAG);				\
>   } while (0)
>   
> +/* This macro masks out RES0 bits in the TLBI operand */
> +#define __TLBI_VADDR(addr) (addr & ~GENMASK_ULL(47, 44))
> +
>   /*
>    *	TLB Management
>    *	==============
> @@ -128,7 +131,8 @@ static inline void flush_tlb_mm(struct mm_struct *mm)
>   static inline void flush_tlb_page(struct vm_area_struct *vma,
>   				  unsigned long uaddr)
>   {
> -	unsigned long addr = uaddr >> 12 | (ASID(vma->vm_mm) << 48);
> +	unsigned long addr = __TLBI_VADDR(uaddr >> 12) |
> +			     (ASID(vma->vm_mm) << 48);
>   
>   	dsb(ishst);
>   	__tlbi(vale1is, addr);
> @@ -154,8 +158,8 @@ static inline void __flush_tlb_range(struct vm_area_struct *vma,
>   		return;
>   	}
>   
> -	start = asid | (start >> 12);
> -	end = asid | (end >> 12);
> +	start = asid | __TLBI_VADDR(start >> 12);
> +	end = asid | __TLBI_VADDR(end >> 12);
>   
>   	dsb(ishst);
>   	for (addr = start; addr < end; addr += 1 << (PAGE_SHIFT - 12)) {
> @@ -185,8 +189,8 @@ static inline void flush_tlb_kernel_range(unsigned long start, unsigned long end
>   		return;
>   	}
>   
> -	start >>= 12;
> -	end >>= 12;
> +	start = __TLBI_VADDR(start >> 12);
> +	end = __TLBI_VADDR(end >> 12);
>   
>   	dsb(ishst);
>   	for (addr = start; addr < end; addr += 1 << (PAGE_SHIFT - 12))
> @@ -202,7 +206,7 @@ static inline void flush_tlb_kernel_range(unsigned long start, unsigned long end
>   static inline void __flush_tlb_pgtable(struct mm_struct *mm,
>   				       unsigned long uaddr)
>   {
> -	unsigned long addr = uaddr >> 12 | (ASID(mm) << 48);
> +	unsigned long addr = __TLBI_VADDR(uaddr >> 12) | (ASID(mm) << 48);
>   
>   	__tlbi(vae1is, addr);
>   	__tlbi_user(vae1is, addr);
> 
