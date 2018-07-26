Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6166AC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2C6E20857
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XfezPij3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2C6E20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731508AbeGZUTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 16:19:51 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55856 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730289AbeGZUTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 16:19:50 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6QIwbjg101467;
        Thu, 26 Jul 2018 19:00:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=+mJQ8lBAXPkGfvLg+V+0g53QCAkZj/VBYqcZUcoFNCI=;
 b=XfezPij3mbNE0kKvXd4evXlPC4AHD8X5WY7tZvmKL0+6eMZtwRrjNMgBbEBGz2ZgUtzg
 rAmHwNcogvIODsgS+2aNAwKzVH4dH5L/v1rOPRbOijE9zV3OND5+Dw0RCUVLYP4caXaV
 JLOu902A4iRzPCkifnTpGsz6seQgGxgIcG+dhhUtqBX8Dplh3Q/6qvoZMC2lk7z5fp6P
 FfXcbtPBBCYi/gQoO8p3HoAxyX3eLs+d3F/miyuoe0f7+T29FMDxc2Mxl/EivD/YWvo0
 l0pDOP31C/fgBD8uuoovLYXJwfFR6FJhB4qK8ykgNL13Bqv1MglNusPwp4FF70n+iF+9 Lg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2kbwfq4dbk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jul 2018 19:00:22 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6QJ0Je6031658
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jul 2018 19:00:20 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6QJ0BFu012454;
        Thu, 26 Jul 2018 19:00:12 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 26 Jul 2018 12:00:09 -0700
Subject: Re: [PATCH v4 03/11] hugetlb: Introduce generic version of
 set_huge_pte_at
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
 <20180705110716.3919-4-alex@ghiti.fr>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <b9341c15-38d5-8a6f-2e51-bae3f6593880@oracle.com>
Date:   Thu, 26 Jul 2018 12:00:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180705110716.3919-4-alex@ghiti.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8965 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=960
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807260194
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/2018 04:07 AM, Alexandre Ghiti wrote:
> arm, ia64, mips, powerpc, sh, x86 architectures use the
> same version of set_huge_pte_at, so move this generic
> implementation into asm-generic/hugetlb.h.
> 

Just one comment below, otherwise:
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  arch/arm/include/asm/hugetlb-3level.h | 6 ------
>  arch/arm64/include/asm/hugetlb.h      | 1 +
>  arch/ia64/include/asm/hugetlb.h       | 6 ------
>  arch/mips/include/asm/hugetlb.h       | 6 ------
>  arch/parisc/include/asm/hugetlb.h     | 1 +
>  arch/powerpc/include/asm/hugetlb.h    | 6 ------
>  arch/sh/include/asm/hugetlb.h         | 6 ------
>  arch/sparc/include/asm/hugetlb.h      | 1 +
>  arch/x86/include/asm/hugetlb.h        | 6 ------
>  include/asm-generic/hugetlb.h         | 8 +++++++-
>  10 files changed, 10 insertions(+), 37 deletions(-)
> 
> diff --git a/arch/arm/include/asm/hugetlb-3level.h b/arch/arm/include/asm/hugetlb-3level.h
> index d4014fbe5ea3..398fb06e8207 100644
> --- a/arch/arm/include/asm/hugetlb-3level.h
> +++ b/arch/arm/include/asm/hugetlb-3level.h
> @@ -37,12 +37,6 @@ static inline pte_t huge_ptep_get(pte_t *ptep)
>  	return retval;
>  }
>  
> -static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
> -				   pte_t *ptep, pte_t pte)
> -{
> -	set_pte_at(mm, addr, ptep, pte);
> -}
> -

Since <asm-generic/hugetlb.h> is not directly included in this file,
I had to search around in the #include dependency chain to look for
it.  It makes me just a tiny bit nervous, but since it compiled, I'm
sure there is not an issue.
-- 
Mike Kravetz

>  static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
>  					 unsigned long addr, pte_t *ptep)
>  {
> diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
> index 4af1a800a900..874661a1dff1 100644
> --- a/arch/arm64/include/asm/hugetlb.h
> +++ b/arch/arm64/include/asm/hugetlb.h
> @@ -60,6 +60,7 @@ static inline void arch_clear_hugepage_flags(struct page *page)
>  extern pte_t arch_make_huge_pte(pte_t entry, struct vm_area_struct *vma,
>  				struct page *page, int writable);
>  #define arch_make_huge_pte arch_make_huge_pte
> +#define __HAVE_ARCH_HUGE_SET_HUGE_PTE_AT
>  extern void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
>  			    pte_t *ptep, pte_t pte);
>  extern int huge_ptep_set_access_flags(struct vm_area_struct *vma,
> diff --git a/arch/ia64/include/asm/hugetlb.h b/arch/ia64/include/asm/hugetlb.h
> index afe9fa4d969b..a235d6f60fb3 100644
> --- a/arch/ia64/include/asm/hugetlb.h
> +++ b/arch/ia64/include/asm/hugetlb.h
> @@ -20,12 +20,6 @@ static inline int is_hugepage_only_range(struct mm_struct *mm,
>  		REGION_NUMBER((addr)+(len)-1) == RGN_HPAGE);
>  }
>  
> -static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
> -				   pte_t *ptep, pte_t pte)
> -{
> -	set_pte_at(mm, addr, ptep, pte);
> -}
> -
>  static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
>  					    unsigned long addr, pte_t *ptep)
>  {
> diff --git a/arch/mips/include/asm/hugetlb.h b/arch/mips/include/asm/hugetlb.h
> index 53764050243e..8ea439041d5d 100644
> --- a/arch/mips/include/asm/hugetlb.h
> +++ b/arch/mips/include/asm/hugetlb.h
> @@ -36,12 +36,6 @@ static inline int prepare_hugepage_range(struct file *file,
>  	return 0;
>  }
>  
> -static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
> -				   pte_t *ptep, pte_t pte)
> -{
> -	set_pte_at(mm, addr, ptep, pte);
> -}
> -
>  static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
>  					    unsigned long addr, pte_t *ptep)
>  {
> diff --git a/arch/parisc/include/asm/hugetlb.h b/arch/parisc/include/asm/hugetlb.h
> index 28c23b68d38d..77c8adbac7c3 100644
> --- a/arch/parisc/include/asm/hugetlb.h
> +++ b/arch/parisc/include/asm/hugetlb.h
> @@ -4,6 +4,7 @@
>  
>  #include <asm/page.h>
>  
> +#define __HAVE_ARCH_HUGE_SET_HUGE_PTE_AT
>  void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
>  		     pte_t *ptep, pte_t pte);
>  
> diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
> index a7d5c739df9b..0794b53439d4 100644
> --- a/arch/powerpc/include/asm/hugetlb.h
> +++ b/arch/powerpc/include/asm/hugetlb.h
> @@ -132,12 +132,6 @@ static inline int prepare_hugepage_range(struct file *file,
>  	return 0;
>  }
>  
> -static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
> -				   pte_t *ptep, pte_t pte)
> -{
> -	set_pte_at(mm, addr, ptep, pte);
> -}
> -
>  static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
>  					    unsigned long addr, pte_t *ptep)
>  {
> diff --git a/arch/sh/include/asm/hugetlb.h b/arch/sh/include/asm/hugetlb.h
> index f6a51b609409..bc552e37c1c9 100644
> --- a/arch/sh/include/asm/hugetlb.h
> +++ b/arch/sh/include/asm/hugetlb.h
> @@ -25,12 +25,6 @@ static inline int prepare_hugepage_range(struct file *file,
>  	return 0;
>  }
>  
> -static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
> -				   pte_t *ptep, pte_t pte)
> -{
> -	set_pte_at(mm, addr, ptep, pte);
> -}
> -
>  static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
>  					    unsigned long addr, pte_t *ptep)
>  {
> diff --git a/arch/sparc/include/asm/hugetlb.h b/arch/sparc/include/asm/hugetlb.h
> index 59d89b52ccb7..16b0c53ea6c9 100644
> --- a/arch/sparc/include/asm/hugetlb.h
> +++ b/arch/sparc/include/asm/hugetlb.h
> @@ -12,6 +12,7 @@ struct pud_huge_patch_entry {
>  extern struct pud_huge_patch_entry __pud_huge_patch, __pud_huge_patch_end;
>  #endif
>  
> +#define __HAVE_ARCH_HUGE_SET_HUGE_PTE_AT
>  void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
>  		     pte_t *ptep, pte_t pte);
>  
> diff --git a/arch/x86/include/asm/hugetlb.h b/arch/x86/include/asm/hugetlb.h
> index 996ce8e15365..554d5614b375 100644
> --- a/arch/x86/include/asm/hugetlb.h
> +++ b/arch/x86/include/asm/hugetlb.h
> @@ -27,12 +27,6 @@ static inline int prepare_hugepage_range(struct file *file,
>  	return 0;
>  }
>  
> -static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
> -				   pte_t *ptep, pte_t pte)
> -{
> -	set_pte_at(mm, addr, ptep, pte);
> -}
> -
>  static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
>  					    unsigned long addr, pte_t *ptep)
>  {
> diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
> index c697ca9dda18..ee010b756246 100644
> --- a/include/asm-generic/hugetlb.h
> +++ b/include/asm-generic/hugetlb.h
> @@ -47,8 +47,14 @@ static inline void hugetlb_free_pgd_range(struct mmu_gather *tlb,
>  {
>  	free_pgd_range(tlb, addr, end, floor, ceiling);
>  }
> +#endif
>  
> -
> +#ifndef __HAVE_ARCH_HUGE_SET_HUGE_PTE_AT
> +static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
> +		pte_t *ptep, pte_t pte)
> +{
> +	set_pte_at(mm, addr, ptep, pte);
> +}
>  #endif
>  
>  #endif /* _ASM_GENERIC_HUGETLB_H */
> 
