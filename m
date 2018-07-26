Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF060C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95F1620647
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WSR9n950"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95F1620647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731197AbeGZUYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 16:24:43 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33998 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730269AbeGZUYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 16:24:43 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6QJ4TeV136048;
        Thu, 26 Jul 2018 19:05:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=4z6sLJkrwTPQZVbBwChhC1ZXxPtsDYiNFUsAq+NTYpA=;
 b=WSR9n950l0L1ep8QLpRYiBlRMNdBapW+PE2YX5I1qgL/rDlN/WO5TvCyWxdpwOf6W4Bh
 JBIR2HMcbWsHAH4ihXsR2P0bKQfzAhuShZ8180NMscEpeXJCx2iZ2rZ2ZihvOUsmNNb/
 RlCTenIHaExFu4TGbnHV1ldjURWl2deK61yfQ2cJFJKkeI05fTyOxaCwlsik3EN24fHJ
 JUJ17EbCIHvDDOvcFihmrhPgVRl/Qwo7dC5sPiOPbfhu8IiKMZ8jUmm4U1E1Nzh8lK9G
 NWqx3Xi+h/xpAgru1Cy32hsnFuqAsBljqJ9crEccjIvR5w9iktC5zLOXcHyYJNK1TyJL EQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2kbvsp4egs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jul 2018 19:05:21 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6QJ5KRj029365
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jul 2018 19:05:21 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6QJ5Kkn008761;
        Thu, 26 Jul 2018 19:05:20 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 26 Jul 2018 12:05:19 -0700
Subject: Re: [PATCH v4 07/11] hugetlb: Introduce generic version of
 huge_pte_wrprotect
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
 <20180705110716.3919-8-alex@ghiti.fr>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <8a8f0608-ff9a-04ea-7c63-2b3bb99b7966@oracle.com>
Date:   Thu, 26 Jul 2018 12:05:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180705110716.3919-8-alex@ghiti.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8965 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=894
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807260195
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/2018 04:07 AM, Alexandre Ghiti wrote:
> arm, arm64, ia64, mips, parisc, powerpc, sh, sparc, x86
> architectures use the same version of huge_pte_wrprotect, so move
> this generic implementation into asm-generic/hugetlb.h.
> 

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  arch/arm/include/asm/hugetlb.h     | 5 -----
>  arch/arm64/include/asm/hugetlb.h   | 5 -----
>  arch/ia64/include/asm/hugetlb.h    | 5 -----
>  arch/mips/include/asm/hugetlb.h    | 5 -----
>  arch/parisc/include/asm/hugetlb.h  | 5 -----
>  arch/powerpc/include/asm/hugetlb.h | 5 -----
>  arch/sh/include/asm/hugetlb.h      | 5 -----
>  arch/sparc/include/asm/hugetlb.h   | 5 -----
>  arch/x86/include/asm/hugetlb.h     | 5 -----
>  include/asm-generic/hugetlb.h      | 7 +++++++
>  10 files changed, 7 insertions(+), 45 deletions(-)
> 
> diff --git a/arch/arm/include/asm/hugetlb.h b/arch/arm/include/asm/hugetlb.h
> index 3d2ce4dbc145..1e718a626ef9 100644
> --- a/arch/arm/include/asm/hugetlb.h
> +++ b/arch/arm/include/asm/hugetlb.h
> @@ -43,11 +43,6 @@ static inline int prepare_hugepage_range(struct file *file,
>  	return 0;
>  }
>  
> -static inline pte_t huge_pte_wrprotect(pte_t pte)
> -{
> -	return pte_wrprotect(pte);
> -}
> -
>  static inline void arch_clear_hugepage_flags(struct page *page)
>  {
>  	clear_bit(PG_dcache_clean, &page->flags);
> diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
> index 49247c6f94db..1fd64ebf0cd7 100644
> --- a/arch/arm64/include/asm/hugetlb.h
> +++ b/arch/arm64/include/asm/hugetlb.h
> @@ -42,11 +42,6 @@ static inline int prepare_hugepage_range(struct file *file,
>  	return 0;
>  }
>  
> -static inline pte_t huge_pte_wrprotect(pte_t pte)
> -{
> -	return pte_wrprotect(pte);
> -}
> -
>  static inline void arch_clear_hugepage_flags(struct page *page)
>  {
>  	clear_bit(PG_dcache_clean, &page->flags);
> diff --git a/arch/ia64/include/asm/hugetlb.h b/arch/ia64/include/asm/hugetlb.h
> index bf573500b3c4..82fe3d7a38d9 100644
> --- a/arch/ia64/include/asm/hugetlb.h
> +++ b/arch/ia64/include/asm/hugetlb.h
> @@ -26,11 +26,6 @@ static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
>  {
>  }
>  
> -static inline pte_t huge_pte_wrprotect(pte_t pte)
> -{
> -	return pte_wrprotect(pte);
> -}
> -
>  static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
>  					   unsigned long addr, pte_t *ptep)
>  {
> diff --git a/arch/mips/include/asm/hugetlb.h b/arch/mips/include/asm/hugetlb.h
> index 1c9c4531376c..b3d6bb53ee6e 100644
> --- a/arch/mips/include/asm/hugetlb.h
> +++ b/arch/mips/include/asm/hugetlb.h
> @@ -62,11 +62,6 @@ static inline int huge_pte_none(pte_t pte)
>  	return !val || (val == (unsigned long)invalid_pte_table);
>  }
>  
> -static inline pte_t huge_pte_wrprotect(pte_t pte)
> -{
> -	return pte_wrprotect(pte);
> -}
> -
>  static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
>  					   unsigned long addr, pte_t *ptep)
>  {
> diff --git a/arch/parisc/include/asm/hugetlb.h b/arch/parisc/include/asm/hugetlb.h
> index c09d8c74553c..5a102d7251e4 100644
> --- a/arch/parisc/include/asm/hugetlb.h
> +++ b/arch/parisc/include/asm/hugetlb.h
> @@ -38,11 +38,6 @@ static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
>  {
>  }
>  
> -static inline pte_t huge_pte_wrprotect(pte_t pte)
> -{
> -	return pte_wrprotect(pte);
> -}
> -
>  void huge_ptep_set_wrprotect(struct mm_struct *mm,
>  					   unsigned long addr, pte_t *ptep);
>  
> diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
> index 3562d46585ba..7123599089c6 100644
> --- a/arch/powerpc/include/asm/hugetlb.h
> +++ b/arch/powerpc/include/asm/hugetlb.h
> @@ -152,11 +152,6 @@ static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
>  	flush_hugetlb_page(vma, addr);
>  }
>  
> -static inline pte_t huge_pte_wrprotect(pte_t pte)
> -{
> -	return pte_wrprotect(pte);
> -}
> -
>  extern int huge_ptep_set_access_flags(struct vm_area_struct *vma,
>  				      unsigned long addr, pte_t *ptep,
>  				      pte_t pte, int dirty);
> diff --git a/arch/sh/include/asm/hugetlb.h b/arch/sh/include/asm/hugetlb.h
> index a9f8266f33cf..54f65094efe6 100644
> --- a/arch/sh/include/asm/hugetlb.h
> +++ b/arch/sh/include/asm/hugetlb.h
> @@ -31,11 +31,6 @@ static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
>  {
>  }
>  
> -static inline pte_t huge_pte_wrprotect(pte_t pte)
> -{
> -	return pte_wrprotect(pte);
> -}
> -
>  static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
>  					   unsigned long addr, pte_t *ptep)
>  {
> diff --git a/arch/sparc/include/asm/hugetlb.h b/arch/sparc/include/asm/hugetlb.h
> index 11115bbd712e..f661362376e0 100644
> --- a/arch/sparc/include/asm/hugetlb.h
> +++ b/arch/sparc/include/asm/hugetlb.h
> @@ -48,11 +48,6 @@ static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
>  {
>  }
>  
> -static inline pte_t huge_pte_wrprotect(pte_t pte)
> -{
> -	return pte_wrprotect(pte);
> -}
> -
>  static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
>  					   unsigned long addr, pte_t *ptep)
>  {
> diff --git a/arch/x86/include/asm/hugetlb.h b/arch/x86/include/asm/hugetlb.h
> index c5fdc53b6e41..19668672ab37 100644
> --- a/arch/x86/include/asm/hugetlb.h
> +++ b/arch/x86/include/asm/hugetlb.h
> @@ -27,11 +27,6 @@ static inline int prepare_hugepage_range(struct file *file,
>  	return 0;
>  }
>  
> -static inline pte_t huge_pte_wrprotect(pte_t pte)
> -{
> -	return pte_wrprotect(pte);
> -}
> -
>  static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
>  					   unsigned long addr, pte_t *ptep)
>  {
> diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
> index 2fc3d68424e9..cd9697672b79 100644
> --- a/include/asm-generic/hugetlb.h
> +++ b/include/asm-generic/hugetlb.h
> @@ -80,4 +80,11 @@ static inline int huge_pte_none(pte_t pte)
>  }
>  #endif
>  
> +#ifndef __HAVE_ARCH_HUGE_PTE_WRPROTECT
> +static inline pte_t huge_pte_wrprotect(pte_t pte)
> +{
> +	return pte_wrprotect(pte);
> +}
> +#endif
> +
>  #endif /* _ASM_GENERIC_HUGETLB_H */
> 
