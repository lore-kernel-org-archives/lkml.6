Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F91EC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6CFA240F6
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:38:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6CFA240F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753068AbeGEFiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 01:38:06 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:45135 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750884AbeGEFiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 01:38:03 -0400
X-Originating-IP: 79.86.19.127
Received: from [192.168.0.11] (127.19.86.79.rev.sfr.net [79.86.19.127])
        (Authenticated sender: alex@ghiti.fr)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id EA0AA1BF208;
        Thu,  5 Jul 2018 05:37:54 +0000 (UTC)
Subject: Re: [PATCH v2 06/11] hugetlb: Introduce generic version of
 huge_pte_none
To:     linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, tony.luck@intel.com, fenghua.yu@intel.com,
        ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        jejb@parisc-linux.org, deller@gmx.de, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au, ysato@users.sourceforge.jp,
        dalias@libc.org, davem@davemloft.net, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org
References: <20180705050323.301-1-alex@ghiti.fr>
 <20180705051242.694-1-alex@ghiti.fr> <20180705051242.694-6-alex@ghiti.fr>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <92f84f1e-652c-6442-fafa-acfa63607601@ghiti.fr>
Date:   Thu, 5 Jul 2018 05:37:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180705051242.694-6-alex@ghiti.fr>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: fr
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please drop this serie, sorry for the noise.


On 07/05/2018 05:12 AM, Alexandre Ghiti wrote:
> arm, arm64, ia64, parisc, powerpc, sh, sparc, x86 architectures
> use the same version of huge_pte_none, so move this generic
> implementation into asm-generic/hugetlb.h.
>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>   arch/arm/include/asm/hugetlb.h     | 5 -----
>   arch/arm64/include/asm/hugetlb.h   | 5 -----
>   arch/ia64/include/asm/hugetlb.h    | 5 -----
>   arch/mips/include/asm/hugetlb.h    | 1 +
>   arch/parisc/include/asm/hugetlb.h  | 5 -----
>   arch/powerpc/include/asm/hugetlb.h | 5 -----
>   arch/sh/include/asm/hugetlb.h      | 5 -----
>   arch/sparc/include/asm/hugetlb.h   | 5 -----
>   arch/x86/include/asm/hugetlb.h     | 5 -----
>   include/asm-generic/hugetlb.h      | 7 +++++++
>   10 files changed, 8 insertions(+), 40 deletions(-)
>
> diff --git a/arch/arm/include/asm/hugetlb.h b/arch/arm/include/asm/hugetlb.h
> index 047b893ef95d..3d2ce4dbc145 100644
> --- a/arch/arm/include/asm/hugetlb.h
> +++ b/arch/arm/include/asm/hugetlb.h
> @@ -43,11 +43,6 @@ static inline int prepare_hugepage_range(struct file *file,
>   	return 0;
>   }
>   
> -static inline int huge_pte_none(pte_t pte)
> -{
> -	return pte_none(pte);
> -}
> -
>   static inline pte_t huge_pte_wrprotect(pte_t pte)
>   {
>   	return pte_wrprotect(pte);
> diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
> index 4c8dd488554d..49247c6f94db 100644
> --- a/arch/arm64/include/asm/hugetlb.h
> +++ b/arch/arm64/include/asm/hugetlb.h
> @@ -42,11 +42,6 @@ static inline int prepare_hugepage_range(struct file *file,
>   	return 0;
>   }
>   
> -static inline int huge_pte_none(pte_t pte)
> -{
> -	return pte_none(pte);
> -}
> -
>   static inline pte_t huge_pte_wrprotect(pte_t pte)
>   {
>   	return pte_wrprotect(pte);
> diff --git a/arch/ia64/include/asm/hugetlb.h b/arch/ia64/include/asm/hugetlb.h
> index 41b5f6adeee4..bf573500b3c4 100644
> --- a/arch/ia64/include/asm/hugetlb.h
> +++ b/arch/ia64/include/asm/hugetlb.h
> @@ -26,11 +26,6 @@ static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
>   {
>   }
>   
> -static inline int huge_pte_none(pte_t pte)
> -{
> -	return pte_none(pte);
> -}
> -
>   static inline pte_t huge_pte_wrprotect(pte_t pte)
>   {
>   	return pte_wrprotect(pte);
> diff --git a/arch/mips/include/asm/hugetlb.h b/arch/mips/include/asm/hugetlb.h
> index 7df1f116a3cc..1c9c4531376c 100644
> --- a/arch/mips/include/asm/hugetlb.h
> +++ b/arch/mips/include/asm/hugetlb.h
> @@ -55,6 +55,7 @@ static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
>   	flush_tlb_page(vma, addr & huge_page_mask(hstate_vma(vma)));
>   }
>   
> +#define __HAVE_ARCH_HUGE_PTE_NONE
>   static inline int huge_pte_none(pte_t pte)
>   {
>   	unsigned long val = pte_val(pte) & ~_PAGE_GLOBAL;
> diff --git a/arch/parisc/include/asm/hugetlb.h b/arch/parisc/include/asm/hugetlb.h
> index 9afff26747a1..c09d8c74553c 100644
> --- a/arch/parisc/include/asm/hugetlb.h
> +++ b/arch/parisc/include/asm/hugetlb.h
> @@ -38,11 +38,6 @@ static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
>   {
>   }
>   
> -static inline int huge_pte_none(pte_t pte)
> -{
> -	return pte_none(pte);
> -}
> -
>   static inline pte_t huge_pte_wrprotect(pte_t pte)
>   {
>   	return pte_wrprotect(pte);
> diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
> index de0769f0b5b2..530b817e097c 100644
> --- a/arch/powerpc/include/asm/hugetlb.h
> +++ b/arch/powerpc/include/asm/hugetlb.h
> @@ -152,11 +152,6 @@ static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
>   	flush_hugetlb_page(vma, addr);
>   }
>   
> -static inline int huge_pte_none(pte_t pte)
> -{
> -	return pte_none(pte);
> -}
> -
>   static inline pte_t huge_pte_wrprotect(pte_t pte)
>   {
>   	return pte_wrprotect(pte);
> diff --git a/arch/sh/include/asm/hugetlb.h b/arch/sh/include/asm/hugetlb.h
> index 9abf9c86b769..a9f8266f33cf 100644
> --- a/arch/sh/include/asm/hugetlb.h
> +++ b/arch/sh/include/asm/hugetlb.h
> @@ -31,11 +31,6 @@ static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
>   {
>   }
>   
> -static inline int huge_pte_none(pte_t pte)
> -{
> -	return pte_none(pte);
> -}
> -
>   static inline pte_t huge_pte_wrprotect(pte_t pte)
>   {
>   	return pte_wrprotect(pte);
> diff --git a/arch/sparc/include/asm/hugetlb.h b/arch/sparc/include/asm/hugetlb.h
> index 651a9593fcee..11115bbd712e 100644
> --- a/arch/sparc/include/asm/hugetlb.h
> +++ b/arch/sparc/include/asm/hugetlb.h
> @@ -48,11 +48,6 @@ static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
>   {
>   }
>   
> -static inline int huge_pte_none(pte_t pte)
> -{
> -	return pte_none(pte);
> -}
> -
>   static inline pte_t huge_pte_wrprotect(pte_t pte)
>   {
>   	return pte_wrprotect(pte);
> diff --git a/arch/x86/include/asm/hugetlb.h b/arch/x86/include/asm/hugetlb.h
> index 8347d5abf882..c5fdc53b6e41 100644
> --- a/arch/x86/include/asm/hugetlb.h
> +++ b/arch/x86/include/asm/hugetlb.h
> @@ -27,11 +27,6 @@ static inline int prepare_hugepage_range(struct file *file,
>   	return 0;
>   }
>   
> -static inline int huge_pte_none(pte_t pte)
> -{
> -	return pte_none(pte);
> -}
> -
>   static inline pte_t huge_pte_wrprotect(pte_t pte)
>   {
>   	return pte_wrprotect(pte);
> diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
> index ffa63fd8388d..2fc3d68424e9 100644
> --- a/include/asm-generic/hugetlb.h
> +++ b/include/asm-generic/hugetlb.h
> @@ -73,4 +73,11 @@ static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
>   }
>   #endif
>   
> +#ifndef __HAVE_ARCH_HUGE_PTE_NONE
> +static inline int huge_pte_none(pte_t pte)
> +{
> +	return pte_none(pte);
> +}
> +#endif
> +
>   #endif /* _ASM_GENERIC_HUGETLB_H */

