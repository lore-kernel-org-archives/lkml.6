Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23263C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 18:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEC5020671
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 18:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nzZg+lRY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEC5020671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730761AbeGZUFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 16:05:04 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47212 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729801AbeGZUFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 16:05:04 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6QIdlxF117893;
        Thu, 26 Jul 2018 18:45:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=iga+Dad2RaqUbadTOBDnT1nmywvDUDQe5ckOfJDiLxE=;
 b=nzZg+lRY9PgTP1pbppXRm0jrtldrydf6zuyoualF9BS5LtETWHrneScxq1NsX0IzkIrQ
 OH0/GNOYRPbRsMY1S7TBSIV1Gxz59gBCtxaRMutvygoO9j79J7lNu+eO2Lu2cOWO+8VI
 FpAUkZYqdfI7Lfdhf0OVUGRMlNodBs3fQYBhLT6cwFhY+JJqjrohRdbTNPY/SjVyvROa
 lT0hnvyIo8YVW8pUQ6Rcfyr0IyViic/aozdgjD+jM3VdjOhcqr4pA6I0ZXQ4Zk6MWD0w
 mHNYqoLv4HO4IRh7aOmK6QEx4qxLVCKZQPKIAeSs2TrScXTmTCOcUKseHxP2qLk1iBa5 OQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2kbvsp4cd1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jul 2018 18:45:29 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6QIjTX7007340
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jul 2018 18:45:29 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6QIjRbE028239;
        Thu, 26 Jul 2018 18:45:27 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 26 Jul 2018 11:45:26 -0700
Subject: Re: [PATCH v4 02/11] hugetlb: Introduce generic version of
 hugetlb_free_pgd_range
To:     Alexandre Ghiti <alex@ghiti.fr>, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, tony.luck@intel.com,
        fenghua.yu@intel.com, ralf@linux-mips.org, paul.burton@mips.com,
        jhogan@kernel.org, jejb@parisc-linux.org, deller@gmx.de,
        benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org
References: <20180705110716.3919-1-alex@ghiti.fr>
 <20180705110716.3919-3-alex@ghiti.fr>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <623882f0-584d-6e03-d266-d0ddcb5d89aa@oracle.com>
Date:   Thu, 26 Jul 2018 11:45:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180705110716.3919-3-alex@ghiti.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8965 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807260191
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/2018 04:07 AM, Alexandre Ghiti wrote:
> arm, arm64, mips, parisc, sh, x86 architectures use the
> same version of hugetlb_free_pgd_range, so move this generic
> implementation into asm-generic/hugetlb.h.
> 

Just one small issue below.  Not absolutely necessary to fix.
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  arch/arm/include/asm/hugetlb.h     | 12 ++----------
>  arch/arm64/include/asm/hugetlb.h   | 10 ----------
>  arch/ia64/include/asm/hugetlb.h    |  5 +++--
>  arch/mips/include/asm/hugetlb.h    | 13 ++-----------
>  arch/parisc/include/asm/hugetlb.h  | 12 ++----------
>  arch/powerpc/include/asm/hugetlb.h |  4 +++-
>  arch/sh/include/asm/hugetlb.h      | 12 ++----------
>  arch/sparc/include/asm/hugetlb.h   |  4 +++-
>  arch/x86/include/asm/hugetlb.h     | 11 ++---------
>  include/asm-generic/hugetlb.h      | 11 +++++++++++
>  10 files changed, 30 insertions(+), 64 deletions(-)
> 
> diff --git a/arch/arm/include/asm/hugetlb.h b/arch/arm/include/asm/hugetlb.h
> index 7d26f6c4f0f5..047b893ef95d 100644
> --- a/arch/arm/include/asm/hugetlb.h
> +++ b/arch/arm/include/asm/hugetlb.h
> @@ -23,19 +23,9 @@
>  #define _ASM_ARM_HUGETLB_H
>  
>  #include <asm/page.h>
> -#include <asm-generic/hugetlb.h>
>  
>  #include <asm/hugetlb-3level.h>
>  
> -static inline void hugetlb_free_pgd_range(struct mmu_gather *tlb,
> -					  unsigned long addr, unsigned long end,
> -					  unsigned long floor,
> -					  unsigned long ceiling)
> -{
> -	free_pgd_range(tlb, addr, end, floor, ceiling);
> -}
> -
> -
>  static inline int is_hugepage_only_range(struct mm_struct *mm,
>  					 unsigned long addr, unsigned long len)
>  {
> @@ -68,4 +58,6 @@ static inline void arch_clear_hugepage_flags(struct page *page)
>  	clear_bit(PG_dcache_clean, &page->flags);
>  }
>  
> +#include <asm-generic/hugetlb.h>
> +

I don't think moving the #include is necessary in this case where you are
not adding a __HAVE_ARCH_HUGE* definition.  I like having all the #include
statements at the top if possible.
-- 
Mike Kravetz

>  #endif /* _ASM_ARM_HUGETLB_H */
> diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
> index 3fcf14663dfa..4af1a800a900 100644
> --- a/arch/arm64/include/asm/hugetlb.h
> +++ b/arch/arm64/include/asm/hugetlb.h
> @@ -25,16 +25,6 @@ static inline pte_t huge_ptep_get(pte_t *ptep)
>  	return READ_ONCE(*ptep);
>  }
>  
> -
> -
> -static inline void hugetlb_free_pgd_range(struct mmu_gather *tlb,
> -					  unsigned long addr, unsigned long end,
> -					  unsigned long floor,
> -					  unsigned long ceiling)
> -{
> -	free_pgd_range(tlb, addr, end, floor, ceiling);
> -}
> -
>  static inline int is_hugepage_only_range(struct mm_struct *mm,
>  					 unsigned long addr, unsigned long len)
>  {
> diff --git a/arch/ia64/include/asm/hugetlb.h b/arch/ia64/include/asm/hugetlb.h
> index 74d2a5540aaf..afe9fa4d969b 100644
> --- a/arch/ia64/include/asm/hugetlb.h
> +++ b/arch/ia64/include/asm/hugetlb.h
> @@ -3,9 +3,8 @@
>  #define _ASM_IA64_HUGETLB_H
>  
>  #include <asm/page.h>
> -#include <asm-generic/hugetlb.h>
> -
>  
> +#define __HAVE_ARCH_HUGETLB_FREE_PGD_RANGE
>  void hugetlb_free_pgd_range(struct mmu_gather *tlb, unsigned long addr,
>  			    unsigned long end, unsigned long floor,
>  			    unsigned long ceiling);
> @@ -70,4 +69,6 @@ static inline void arch_clear_hugepage_flags(struct page *page)
>  {
>  }
>  
> +#include <asm-generic/hugetlb.h>
> +
>  #endif /* _ASM_IA64_HUGETLB_H */
> diff --git a/arch/mips/include/asm/hugetlb.h b/arch/mips/include/asm/hugetlb.h
> index 982bc0685330..53764050243e 100644
> --- a/arch/mips/include/asm/hugetlb.h
> +++ b/arch/mips/include/asm/hugetlb.h
> @@ -10,8 +10,6 @@
>  #define __ASM_HUGETLB_H
>  
>  #include <asm/page.h>
> -#include <asm-generic/hugetlb.h>
> -
>  
>  static inline int is_hugepage_only_range(struct mm_struct *mm,
>  					 unsigned long addr,
> @@ -38,15 +36,6 @@ static inline int prepare_hugepage_range(struct file *file,
>  	return 0;
>  }
>  
> -static inline void hugetlb_free_pgd_range(struct mmu_gather *tlb,
> -					  unsigned long addr,
> -					  unsigned long end,
> -					  unsigned long floor,
> -					  unsigned long ceiling)
> -{
> -	free_pgd_range(tlb, addr, end, floor, ceiling);
> -}
> -
>  static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
>  				   pte_t *ptep, pte_t pte)
>  {
> @@ -114,4 +103,6 @@ static inline void arch_clear_hugepage_flags(struct page *page)
>  {
>  }
>  
> +#include <asm-generic/hugetlb.h>
> +
>  #endif /* __ASM_HUGETLB_H */
> diff --git a/arch/parisc/include/asm/hugetlb.h b/arch/parisc/include/asm/hugetlb.h
> index 58e0f4620426..28c23b68d38d 100644
> --- a/arch/parisc/include/asm/hugetlb.h
> +++ b/arch/parisc/include/asm/hugetlb.h
> @@ -3,8 +3,6 @@
>  #define _ASM_PARISC64_HUGETLB_H
>  
>  #include <asm/page.h>
> -#include <asm-generic/hugetlb.h>
> -
>  
>  void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
>  		     pte_t *ptep, pte_t pte);
> @@ -32,14 +30,6 @@ static inline int prepare_hugepage_range(struct file *file,
>  	return 0;
>  }
>  
> -static inline void hugetlb_free_pgd_range(struct mmu_gather *tlb,
> -					  unsigned long addr, unsigned long end,
> -					  unsigned long floor,
> -					  unsigned long ceiling)
> -{
> -	free_pgd_range(tlb, addr, end, floor, ceiling);
> -}
> -
>  static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
>  					 unsigned long addr, pte_t *ptep)
>  {
> @@ -71,4 +61,6 @@ static inline void arch_clear_hugepage_flags(struct page *page)
>  {
>  }
>  
> +#include <asm-generic/hugetlb.h>
> +
>  #endif /* _ASM_PARISC64_HUGETLB_H */
> diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
> index 3225eb6402cc..a7d5c739df9b 100644
> --- a/arch/powerpc/include/asm/hugetlb.h
> +++ b/arch/powerpc/include/asm/hugetlb.h
> @@ -4,7 +4,6 @@
>  
>  #ifdef CONFIG_HUGETLB_PAGE
>  #include <asm/page.h>
> -#include <asm-generic/hugetlb.h>
>  
>  extern struct kmem_cache *hugepte_cache;
>  
> @@ -113,6 +112,7 @@ static inline void flush_hugetlb_page(struct vm_area_struct *vma,
>  void flush_hugetlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
>  #endif
>  
> +#define __HAVE_ARCH_HUGETLB_FREE_PGD_RANGE
>  void hugetlb_free_pgd_range(struct mmu_gather *tlb, unsigned long addr,
>  			    unsigned long end, unsigned long floor,
>  			    unsigned long ceiling);
> @@ -179,6 +179,8 @@ static inline void arch_clear_hugepage_flags(struct page *page)
>  {
>  }
>  
> +#include <asm-generic/hugetlb.h>
> +
>  #else /* ! CONFIG_HUGETLB_PAGE */
>  static inline void flush_hugetlb_page(struct vm_area_struct *vma,
>  				      unsigned long vmaddr)
> diff --git a/arch/sh/include/asm/hugetlb.h b/arch/sh/include/asm/hugetlb.h
> index 735939c0f513..f6a51b609409 100644
> --- a/arch/sh/include/asm/hugetlb.h
> +++ b/arch/sh/include/asm/hugetlb.h
> @@ -4,8 +4,6 @@
>  
>  #include <asm/cacheflush.h>
>  #include <asm/page.h>
> -#include <asm-generic/hugetlb.h>
> -
>  
>  static inline int is_hugepage_only_range(struct mm_struct *mm,
>  					 unsigned long addr,
> @@ -27,14 +25,6 @@ static inline int prepare_hugepage_range(struct file *file,
>  	return 0;
>  }
>  
> -static inline void hugetlb_free_pgd_range(struct mmu_gather *tlb,
> -					  unsigned long addr, unsigned long end,
> -					  unsigned long floor,
> -					  unsigned long ceiling)
> -{
> -	free_pgd_range(tlb, addr, end, floor, ceiling);
> -}
> -
>  static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
>  				   pte_t *ptep, pte_t pte)
>  {
> @@ -85,4 +75,6 @@ static inline void arch_clear_hugepage_flags(struct page *page)
>  	clear_bit(PG_dcache_clean, &page->flags);
>  }
>  
> +#include <asm-generic/hugetlb.h>
> +
>  #endif /* _ASM_SH_HUGETLB_H */
> diff --git a/arch/sparc/include/asm/hugetlb.h b/arch/sparc/include/asm/hugetlb.h
> index 300557c66698..59d89b52ccb7 100644
> --- a/arch/sparc/include/asm/hugetlb.h
> +++ b/arch/sparc/include/asm/hugetlb.h
> @@ -3,7 +3,6 @@
>  #define _ASM_SPARC64_HUGETLB_H
>  
>  #include <asm/page.h>
> -#include <asm-generic/hugetlb.h>
>  
>  #ifdef CONFIG_HUGETLB_PAGE
>  struct pud_huge_patch_entry {
> @@ -84,8 +83,11 @@ static inline void arch_clear_hugepage_flags(struct page *page)
>  {
>  }
>  
> +#define __HAVE_ARCH_HUGETLB_FREE_PGD_RANGE
>  void hugetlb_free_pgd_range(struct mmu_gather *tlb, unsigned long addr,
>  			    unsigned long end, unsigned long floor,
>  			    unsigned long ceiling);
>  
> +#include <asm-generic/hugetlb.h>
> +
>  #endif /* _ASM_SPARC64_HUGETLB_H */
> diff --git a/arch/x86/include/asm/hugetlb.h b/arch/x86/include/asm/hugetlb.h
> index 5ed826da5e07..996ce8e15365 100644
> --- a/arch/x86/include/asm/hugetlb.h
> +++ b/arch/x86/include/asm/hugetlb.h
> @@ -3,7 +3,6 @@
>  #define _ASM_X86_HUGETLB_H
>  
>  #include <asm/page.h>
> -#include <asm-generic/hugetlb.h>
>  
>  #define hugepages_supported() boot_cpu_has(X86_FEATURE_PSE)
>  
> @@ -28,14 +27,6 @@ static inline int prepare_hugepage_range(struct file *file,
>  	return 0;
>  }
>  
> -static inline void hugetlb_free_pgd_range(struct mmu_gather *tlb,
> -					  unsigned long addr, unsigned long end,
> -					  unsigned long floor,
> -					  unsigned long ceiling)
> -{
> -	free_pgd_range(tlb, addr, end, floor, ceiling);
> -}
> -
>  static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
>  				   pte_t *ptep, pte_t pte)
>  {
> @@ -90,4 +81,6 @@ static inline void arch_clear_hugepage_flags(struct page *page)
>  static inline bool gigantic_page_supported(void) { return true; }
>  #endif
>  
> +#include <asm-generic/hugetlb.h>
> +
>  #endif /* _ASM_X86_HUGETLB_H */
> diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
> index 3da7cff52360..c697ca9dda18 100644
> --- a/include/asm-generic/hugetlb.h
> +++ b/include/asm-generic/hugetlb.h
> @@ -40,4 +40,15 @@ static inline void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
>  }
>  #endif
>  
> +#ifndef __HAVE_ARCH_HUGETLB_FREE_PGD_RANGE
> +static inline void hugetlb_free_pgd_range(struct mmu_gather *tlb,
> +		unsigned long addr, unsigned long end,
> +		unsigned long floor, unsigned long ceiling)
> +{
> +	free_pgd_range(tlb, addr, end, floor, ceiling);
> +}
> +
> +
> +#endif
> +
>  #endif /* _ASM_GENERIC_HUGETLB_H */
> 
