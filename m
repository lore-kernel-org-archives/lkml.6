Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE7EC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4D620647
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zs9QbZGX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E4D620647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731276AbeGZUWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 16:22:08 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60114 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730236AbeGZUWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 16:22:08 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6QIwiES131887;
        Thu, 26 Jul 2018 19:02:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=9ITZxudl3qP8BAVGNplV4N7mil04cTtEd5Jvq8KNOy8=;
 b=zs9QbZGXE7Gt/c8guxGhc9zxxKMVEbZVVtw5mWEM5lQZpsvruIVBX38JY5B+ZnI76j2M
 lu5g5UTRbe5oDIwyVXrMuY5aLWTiozyJxaRodcqwiRUP1tup7H6y/OeqjTjohzTQMDl3
 jGAdpKordt65H33q2pi6Rl139PaHnJ5XsOXrE6NJ0pNMdqAFLnW9YHRZN7LANxDwCNW/
 wawiwvUwJI9mmMiMmBUwezWKfIv8rp/MFfkgNTppcf+Yyj6JVU3blsTpfcNvuMEmqexq
 RcTba6SSR1bOdGBKMp22RAho2JcZZkfuFiB2zkTaQmy2qZmdRX+QWLReNkgIEZ+1CaHo Xg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2kbvsp4e5c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jul 2018 19:02:26 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6QJ2PiI026236
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jul 2018 19:02:25 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6QJ2NSg001329;
        Thu, 26 Jul 2018 19:02:23 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 26 Jul 2018 12:02:23 -0700
Subject: Re: [PATCH v4 04/11] hugetlb: Introduce generic version of
 huge_ptep_get_and_clear
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
 <20180705110716.3919-5-alex@ghiti.fr>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <507b484c-924a-0982-ed58-48ac9882fcc5@oracle.com>
Date:   Thu, 26 Jul 2018 12:02:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180705110716.3919-5-alex@ghiti.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8965 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=854
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807260194
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/2018 04:07 AM, Alexandre Ghiti wrote:
> arm, ia64, sh, x86 architectures use the
> same version of huge_ptep_get_and_clear, so move this generic
> implementation into asm-generic/hugetlb.h.
> 

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  arch/arm/include/asm/hugetlb-3level.h | 6 ------
>  arch/arm64/include/asm/hugetlb.h      | 1 +
>  arch/ia64/include/asm/hugetlb.h       | 6 ------
>  arch/mips/include/asm/hugetlb.h       | 1 +
>  arch/parisc/include/asm/hugetlb.h     | 1 +
>  arch/powerpc/include/asm/hugetlb.h    | 1 +
>  arch/sh/include/asm/hugetlb.h         | 6 ------
>  arch/sparc/include/asm/hugetlb.h      | 1 +
>  arch/x86/include/asm/hugetlb.h        | 6 ------
>  include/asm-generic/hugetlb.h         | 8 ++++++++
>  10 files changed, 13 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/arm/include/asm/hugetlb-3level.h b/arch/arm/include/asm/hugetlb-3level.h
> index 398fb06e8207..ad36e84b819a 100644
> --- a/arch/arm/include/asm/hugetlb-3level.h
> +++ b/arch/arm/include/asm/hugetlb-3level.h
> @@ -49,12 +49,6 @@ static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
>  	ptep_set_wrprotect(mm, addr, ptep);
>  }
>  
> -static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
> -					    unsigned long addr, pte_t *ptep)
> -{
> -	return ptep_get_and_clear(mm, addr, ptep);
> -}
> -
>  static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
>  					     unsigned long addr, pte_t *ptep,
>  					     pte_t pte, int dirty)
> diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
> index 874661a1dff1..6ae0bcafe162 100644
> --- a/arch/arm64/include/asm/hugetlb.h
> +++ b/arch/arm64/include/asm/hugetlb.h
> @@ -66,6 +66,7 @@ extern void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
>  extern int huge_ptep_set_access_flags(struct vm_area_struct *vma,
>  				      unsigned long addr, pte_t *ptep,
>  				      pte_t pte, int dirty);
> +#define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
>  extern pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
>  				     unsigned long addr, pte_t *ptep);
>  extern void huge_ptep_set_wrprotect(struct mm_struct *mm,
> diff --git a/arch/ia64/include/asm/hugetlb.h b/arch/ia64/include/asm/hugetlb.h
> index a235d6f60fb3..6719c74da0de 100644
> --- a/arch/ia64/include/asm/hugetlb.h
> +++ b/arch/ia64/include/asm/hugetlb.h
> @@ -20,12 +20,6 @@ static inline int is_hugepage_only_range(struct mm_struct *mm,
>  		REGION_NUMBER((addr)+(len)-1) == RGN_HPAGE);
>  }
>  
> -static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
> -					    unsigned long addr, pte_t *ptep)
> -{
> -	return ptep_get_and_clear(mm, addr, ptep);
> -}
> -
>  static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
>  					 unsigned long addr, pte_t *ptep)
>  {
> diff --git a/arch/mips/include/asm/hugetlb.h b/arch/mips/include/asm/hugetlb.h
> index 8ea439041d5d..0959cc5a41fa 100644
> --- a/arch/mips/include/asm/hugetlb.h
> +++ b/arch/mips/include/asm/hugetlb.h
> @@ -36,6 +36,7 @@ static inline int prepare_hugepage_range(struct file *file,
>  	return 0;
>  }
>  
> +#define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
>  static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
>  					    unsigned long addr, pte_t *ptep)
>  {
> diff --git a/arch/parisc/include/asm/hugetlb.h b/arch/parisc/include/asm/hugetlb.h
> index 77c8adbac7c3..6e281e1bb336 100644
> --- a/arch/parisc/include/asm/hugetlb.h
> +++ b/arch/parisc/include/asm/hugetlb.h
> @@ -8,6 +8,7 @@
>  void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
>  		     pte_t *ptep, pte_t pte);
>  
> +#define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
>  pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
>  			      pte_t *ptep);
>  
> diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
> index 0794b53439d4..970101cf9c82 100644
> --- a/arch/powerpc/include/asm/hugetlb.h
> +++ b/arch/powerpc/include/asm/hugetlb.h
> @@ -132,6 +132,7 @@ static inline int prepare_hugepage_range(struct file *file,
>  	return 0;
>  }
>  
> +#define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
>  static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
>  					    unsigned long addr, pte_t *ptep)
>  {
> diff --git a/arch/sh/include/asm/hugetlb.h b/arch/sh/include/asm/hugetlb.h
> index bc552e37c1c9..08ee6c00b5e9 100644
> --- a/arch/sh/include/asm/hugetlb.h
> +++ b/arch/sh/include/asm/hugetlb.h
> @@ -25,12 +25,6 @@ static inline int prepare_hugepage_range(struct file *file,
>  	return 0;
>  }
>  
> -static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
> -					    unsigned long addr, pte_t *ptep)
> -{
> -	return ptep_get_and_clear(mm, addr, ptep);
> -}
> -
>  static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
>  					 unsigned long addr, pte_t *ptep)
>  {
> diff --git a/arch/sparc/include/asm/hugetlb.h b/arch/sparc/include/asm/hugetlb.h
> index 16b0c53ea6c9..944e3a4bfaff 100644
> --- a/arch/sparc/include/asm/hugetlb.h
> +++ b/arch/sparc/include/asm/hugetlb.h
> @@ -16,6 +16,7 @@ extern struct pud_huge_patch_entry __pud_huge_patch, __pud_huge_patch_end;
>  void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
>  		     pte_t *ptep, pte_t pte);
>  
> +#define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
>  pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
>  			      pte_t *ptep);
>  
> diff --git a/arch/x86/include/asm/hugetlb.h b/arch/x86/include/asm/hugetlb.h
> index 554d5614b375..48b8d9b13cc6 100644
> --- a/arch/x86/include/asm/hugetlb.h
> +++ b/arch/x86/include/asm/hugetlb.h
> @@ -27,12 +27,6 @@ static inline int prepare_hugepage_range(struct file *file,
>  	return 0;
>  }
>  
> -static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
> -					    unsigned long addr, pte_t *ptep)
> -{
> -	return ptep_get_and_clear(mm, addr, ptep);
> -}
> -
>  static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
>  					 unsigned long addr, pte_t *ptep)
>  {
> diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
> index ee010b756246..0f6f151780dd 100644
> --- a/include/asm-generic/hugetlb.h
> +++ b/include/asm-generic/hugetlb.h
> @@ -57,4 +57,12 @@ static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
>  }
>  #endif
>  
> +#ifndef __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
> +static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
> +		unsigned long addr, pte_t *ptep)
> +{
> +	return ptep_get_and_clear(mm, addr, ptep);
> +}
> +#endif
> +
>  #endif /* _ASM_GENERIC_HUGETLB_H */
> 
