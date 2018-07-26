Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D65EC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E2662083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="voRjIuiE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E2662083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731392AbeGZUaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 16:30:22 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35540 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730517AbeGZUaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 16:30:21 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6QJ4IpW105607;
        Thu, 26 Jul 2018 19:10:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=ThwKrb+lljbWoqu1BD+lOEyqJFH//Lc8c/4WdpX7W9M=;
 b=voRjIuiEu2bMw6dNgC32tSVD8eidAsQdnHeH5RXg2mpxkb9av1we4PBquJos+4mOGGg9
 sDW4213cepy8RSnva3xvz18BWTvAvLX3eXU4HWPQrm1JjnizsROH+fos/j0tQsVSQlP7
 Z8dt2efq9607TZIuZRdoSQZ/ZWCTje8OcQYSJ1fRg7z+CRWHlXmxiJ2BASd1AHv1gdVY
 sS/IerQyJBs42jxDJjcT+yBohrXZOARzlWzv7SwWN01WNfMglAND3I9paF0ENnJqob1K
 9EeFds3MdIUzZQMCaMZ9KPMXoSuRrJ9aAbXJy+qU3GvVb53mYR55UoTNnfSdPTOq+1WN vg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2kbwfq4ep4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jul 2018 19:10:57 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6QJAtdw008659
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jul 2018 19:10:55 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6QJAq4o017707;
        Thu, 26 Jul 2018 19:10:53 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 26 Jul 2018 12:10:52 -0700
Subject: Re: [PATCH v4 09/11] hugetlb: Introduce generic version of
 huge_ptep_set_wrprotect
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
 <20180705110716.3919-10-alex@ghiti.fr>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <2265de04-4e0e-9d7e-d460-cc9287b9d606@oracle.com>
Date:   Thu, 26 Jul 2018 12:10:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180705110716.3919-10-alex@ghiti.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8965 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=933
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807260195
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/2018 04:07 AM, Alexandre Ghiti wrote:
> arm, ia64, mips, sh, x86 architectures use the same version
> of huge_ptep_set_wrprotect, so move this generic implementation into
> asm-generic/hugetlb.h.
> Note: powerpc uses twice for book3s/32 and nohash/32 the same version as
> the above architectures, but the modification was not straightforward
> and hence has not been done.
> 

Just one small comment, otehrwise
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  arch/arm/include/asm/hugetlb-3level.h        | 6 ------
>  arch/arm64/include/asm/hugetlb.h             | 1 +
>  arch/ia64/include/asm/hugetlb.h              | 6 ------
>  arch/mips/include/asm/hugetlb.h              | 6 ------
>  arch/parisc/include/asm/hugetlb.h            | 1 +
>  arch/powerpc/include/asm/book3s/32/pgtable.h | 2 ++
>  arch/powerpc/include/asm/book3s/64/pgtable.h | 1 +
>  arch/powerpc/include/asm/nohash/32/pgtable.h | 2 ++
>  arch/powerpc/include/asm/nohash/64/pgtable.h | 1 +

As in patch 03, the book3s and nohash header files do not explicitly
include <asm-generic/hugetlb.h>.  With these, I had an even harder time
finding out who brought in that file.  This is not an issue with this
patch, just wish there was some easier way to check/prove include file
dependencies.  Since it compiles, I am sure it is OK.
-- 
Mike Kravetz

>  arch/sh/include/asm/hugetlb.h                | 6 ------
>  arch/sparc/include/asm/hugetlb.h             | 1 +
>  arch/x86/include/asm/hugetlb.h               | 6 ------
>  include/asm-generic/hugetlb.h                | 8 ++++++++
>  13 files changed, 17 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/arm/include/asm/hugetlb-3level.h b/arch/arm/include/asm/hugetlb-3level.h
> index b897541520ef..8247cd6a2ac6 100644
> --- a/arch/arm/include/asm/hugetlb-3level.h
> +++ b/arch/arm/include/asm/hugetlb-3level.h
> @@ -37,12 +37,6 @@ static inline pte_t huge_ptep_get(pte_t *ptep)
>  	return retval;
>  }
>  
> -static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
> -					   unsigned long addr, pte_t *ptep)
> -{
> -	ptep_set_wrprotect(mm, addr, ptep);
> -}
> -
>  static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
>  					     unsigned long addr, pte_t *ptep,
>  					     pte_t pte, int dirty)
> diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
> index 3e7f6e69b28d..f4f69ae5466e 100644
> --- a/arch/arm64/include/asm/hugetlb.h
> +++ b/arch/arm64/include/asm/hugetlb.h
> @@ -48,6 +48,7 @@ extern int huge_ptep_set_access_flags(struct vm_area_struct *vma,
>  #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
>  extern pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
>  				     unsigned long addr, pte_t *ptep);
> +#define __HAVE_ARCH_HUGE_PTEP_SET_WRPROTECT
>  extern void huge_ptep_set_wrprotect(struct mm_struct *mm,
>  				    unsigned long addr, pte_t *ptep);
>  #define __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
> diff --git a/arch/ia64/include/asm/hugetlb.h b/arch/ia64/include/asm/hugetlb.h
> index cbe296271030..49d1f7949f3a 100644
> --- a/arch/ia64/include/asm/hugetlb.h
> +++ b/arch/ia64/include/asm/hugetlb.h
> @@ -27,12 +27,6 @@ static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
>  {
>  }
>  
> -static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
> -					   unsigned long addr, pte_t *ptep)
> -{
> -	ptep_set_wrprotect(mm, addr, ptep);
> -}
> -
>  static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
>  					     unsigned long addr, pte_t *ptep,
>  					     pte_t pte, int dirty)
> diff --git a/arch/mips/include/asm/hugetlb.h b/arch/mips/include/asm/hugetlb.h
> index 6ff2531cfb1d..3dcf5debf8c4 100644
> --- a/arch/mips/include/asm/hugetlb.h
> +++ b/arch/mips/include/asm/hugetlb.h
> @@ -63,12 +63,6 @@ static inline int huge_pte_none(pte_t pte)
>  	return !val || (val == (unsigned long)invalid_pte_table);
>  }
>  
> -static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
> -					   unsigned long addr, pte_t *ptep)
> -{
> -	ptep_set_wrprotect(mm, addr, ptep);
> -}
> -
>  static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
>  					     unsigned long addr,
>  					     pte_t *ptep, pte_t pte,
> diff --git a/arch/parisc/include/asm/hugetlb.h b/arch/parisc/include/asm/hugetlb.h
> index fb7e0fd858a3..9c3950ca2974 100644
> --- a/arch/parisc/include/asm/hugetlb.h
> +++ b/arch/parisc/include/asm/hugetlb.h
> @@ -39,6 +39,7 @@ static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
>  {
>  }
>  
> +#define __HAVE_ARCH_HUGE_PTEP_SET_WRPROTECT
>  void huge_ptep_set_wrprotect(struct mm_struct *mm,
>  					   unsigned long addr, pte_t *ptep);
>  
> diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
> index 02f5acd7ccc4..d2cd1d0226e9 100644
> --- a/arch/powerpc/include/asm/book3s/32/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
> @@ -228,6 +228,8 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr,
>  {
>  	pte_update(ptep, (_PAGE_RW | _PAGE_HWWRITE), _PAGE_RO);
>  }
> +
> +#define __HAVE_ARCH_HUGE_PTEP_SET_WRPROTECT
>  static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
>  					   unsigned long addr, pte_t *ptep)
>  {
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index 42aafba7a308..7d957f7c47cd 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -451,6 +451,7 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr,
>  		pte_update(mm, addr, ptep, 0, _PAGE_PRIVILEGED, 0);
>  }
>  
> +#define __HAVE_ARCH_HUGE_PTEP_SET_WRPROTECT
>  static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
>  					   unsigned long addr, pte_t *ptep)
>  {
> diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
> index 7c46a98cc7f4..f39e200d9591 100644
> --- a/arch/powerpc/include/asm/nohash/32/pgtable.h
> +++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
> @@ -249,6 +249,8 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr,
>  {
>  	pte_update(ptep, (_PAGE_RW | _PAGE_HWWRITE), _PAGE_RO);
>  }
> +
> +#define __HAVE_ARCH_HUGE_PTEP_SET_WRPROTECT
>  static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
>  					   unsigned long addr, pte_t *ptep)
>  {
> diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
> index dd0c7236208f..69fbf7e9b4db 100644
> --- a/arch/powerpc/include/asm/nohash/64/pgtable.h
> +++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
> @@ -238,6 +238,7 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr,
>  	pte_update(mm, addr, ptep, _PAGE_RW, 0, 0);
>  }
>  
> +#define __HAVE_ARCH_HUGE_PTEP_SET_WRPROTECT
>  static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
>  					   unsigned long addr, pte_t *ptep)
>  {
> diff --git a/arch/sh/include/asm/hugetlb.h b/arch/sh/include/asm/hugetlb.h
> index f1bbd255ee43..8df4004977b9 100644
> --- a/arch/sh/include/asm/hugetlb.h
> +++ b/arch/sh/include/asm/hugetlb.h
> @@ -32,12 +32,6 @@ static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
>  {
>  }
>  
> -static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
> -					   unsigned long addr, pte_t *ptep)
> -{
> -	ptep_set_wrprotect(mm, addr, ptep);
> -}
> -
>  static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
>  					     unsigned long addr, pte_t *ptep,
>  					     pte_t pte, int dirty)
> diff --git a/arch/sparc/include/asm/hugetlb.h b/arch/sparc/include/asm/hugetlb.h
> index 2101ea217f33..c41754a113f3 100644
> --- a/arch/sparc/include/asm/hugetlb.h
> +++ b/arch/sparc/include/asm/hugetlb.h
> @@ -32,6 +32,7 @@ static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
>  {
>  }
>  
> +#define __HAVE_ARCH_HUGE_PTEP_SET_WRPROTECT
>  static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
>  					   unsigned long addr, pte_t *ptep)
>  {
> diff --git a/arch/x86/include/asm/hugetlb.h b/arch/x86/include/asm/hugetlb.h
> index 2e5117d37c7d..de370836a17d 100644
> --- a/arch/x86/include/asm/hugetlb.h
> +++ b/arch/x86/include/asm/hugetlb.h
> @@ -12,12 +12,6 @@ static inline int is_hugepage_only_range(struct mm_struct *mm,
>  	return 0;
>  }
>  
> -static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
> -					   unsigned long addr, pte_t *ptep)
> -{
> -	ptep_set_wrprotect(mm, addr, ptep);
> -}
> -
>  static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
>  					     unsigned long addr, pte_t *ptep,
>  					     pte_t pte, int dirty)
> diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
> index 6c0c8b0c71e0..9b9039845278 100644
> --- a/include/asm-generic/hugetlb.h
> +++ b/include/asm-generic/hugetlb.h
> @@ -102,4 +102,12 @@ static inline int prepare_hugepage_range(struct file *file,
>  }
>  #endif
>  
> +#ifndef __HAVE_ARCH_HUGE_PTEP_SET_WRPROTECT
> +static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
> +		unsigned long addr, pte_t *ptep)
> +{
> +	ptep_set_wrprotect(mm, addr, ptep);
> +}
> +#endif
> +
>  #endif /* _ASM_GENERIC_HUGETLB_H */
> 
