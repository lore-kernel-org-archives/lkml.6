Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4334BC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8C2420647
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ts0MglRm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8C2420647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731542AbeGZUZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 16:25:32 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59852 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730068AbeGZUZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 16:25:32 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6QJ4DK5105529;
        Thu, 26 Jul 2018 19:06:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=WGoUUz9BkNtdGRir8msjK3/dVbXBDQ3LTSOBL9+GNjU=;
 b=Ts0MglRmZrqe2fpyu2QuqOCC1DsnvX7o1MEh7yKWc8YgPUrN+Fc9GWbPp5WwRrMdEsqv
 65owBUVkEgFo0mxLyCsriarQOFu2PXio3ND2POktBlkIsbVQGTvasmruNIKFvK8wRy/U
 Tqy1VdReIfDOfEbcUonkAZi3op04Sd5lZXOxsYpjNShTKjDDVZX+8rceipgxsZ8dv4Ze
 goWornY63uYgIjWar4N61kVvzXNTw4OyBpkTb29KUkY0kSxjZ0GPjgLykIae74GkMsD/
 2HNLEOQdfBpLkjN8Dhz/stguIcxWEb6HvT/mOC2qIm+WTXR3uxfsGs+MY/BDpL9aP1kB /Q== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2kbwfq4e11-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jul 2018 19:06:06 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6QJ64w8000580
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jul 2018 19:06:04 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6QJ62mH004393;
        Thu, 26 Jul 2018 19:06:02 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 26 Jul 2018 12:06:01 -0700
Subject: Re: [PATCH v4 08/11] hugetlb: Introduce generic version of
 prepare_hugepage_range
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
 <20180705110716.3919-9-alex@ghiti.fr>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <5f2bebab-4ee9-bdbe-fcaa-445d6fd2dc69@oracle.com>
Date:   Thu, 26 Jul 2018 12:05:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180705110716.3919-9-alex@ghiti.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8965 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807260195
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/2018 04:07 AM, Alexandre Ghiti wrote:
> arm, arm64, powerpc, sparc, x86 architectures use the same version of
> prepare_hugepage_range, so move this generic implementation into
> asm-generic/hugetlb.h.
> 

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  arch/arm/include/asm/hugetlb.h     | 11 -----------
>  arch/arm64/include/asm/hugetlb.h   | 11 -----------
>  arch/ia64/include/asm/hugetlb.h    |  1 +
>  arch/mips/include/asm/hugetlb.h    |  1 +
>  arch/parisc/include/asm/hugetlb.h  |  1 +
>  arch/powerpc/include/asm/hugetlb.h | 15 ---------------
>  arch/sh/include/asm/hugetlb.h      |  1 +
>  arch/sparc/include/asm/hugetlb.h   | 16 ----------------
>  arch/x86/include/asm/hugetlb.h     | 15 ---------------
>  include/asm-generic/hugetlb.h      | 15 +++++++++++++++
>  10 files changed, 19 insertions(+), 68 deletions(-)
> 
> diff --git a/arch/arm/include/asm/hugetlb.h b/arch/arm/include/asm/hugetlb.h
> index 1e718a626ef9..34fb401efe81 100644
> --- a/arch/arm/include/asm/hugetlb.h
> +++ b/arch/arm/include/asm/hugetlb.h
> @@ -32,17 +32,6 @@ static inline int is_hugepage_only_range(struct mm_struct *mm,
>  	return 0;
>  }
>  
> -static inline int prepare_hugepage_range(struct file *file,
> -					 unsigned long addr, unsigned long len)
> -{
> -	struct hstate *h = hstate_file(file);
> -	if (len & ~huge_page_mask(h))
> -		return -EINVAL;
> -	if (addr & ~huge_page_mask(h))
> -		return -EINVAL;
> -	return 0;
> -}
> -
>  static inline void arch_clear_hugepage_flags(struct page *page)
>  {
>  	clear_bit(PG_dcache_clean, &page->flags);
> diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
> index 1fd64ebf0cd7..3e7f6e69b28d 100644
> --- a/arch/arm64/include/asm/hugetlb.h
> +++ b/arch/arm64/include/asm/hugetlb.h
> @@ -31,17 +31,6 @@ static inline int is_hugepage_only_range(struct mm_struct *mm,
>  	return 0;
>  }
>  
> -static inline int prepare_hugepage_range(struct file *file,
> -					 unsigned long addr, unsigned long len)
> -{
> -	struct hstate *h = hstate_file(file);
> -	if (len & ~huge_page_mask(h))
> -		return -EINVAL;
> -	if (addr & ~huge_page_mask(h))
> -		return -EINVAL;
> -	return 0;
> -}
> -
>  static inline void arch_clear_hugepage_flags(struct page *page)
>  {
>  	clear_bit(PG_dcache_clean, &page->flags);
> diff --git a/arch/ia64/include/asm/hugetlb.h b/arch/ia64/include/asm/hugetlb.h
> index 82fe3d7a38d9..cbe296271030 100644
> --- a/arch/ia64/include/asm/hugetlb.h
> +++ b/arch/ia64/include/asm/hugetlb.h
> @@ -9,6 +9,7 @@ void hugetlb_free_pgd_range(struct mmu_gather *tlb, unsigned long addr,
>  			    unsigned long end, unsigned long floor,
>  			    unsigned long ceiling);
>  
> +#define __HAVE_ARCH_PREPARE_HUGEPAGE_RANGE
>  int prepare_hugepage_range(struct file *file,
>  			unsigned long addr, unsigned long len);
>  
> diff --git a/arch/mips/include/asm/hugetlb.h b/arch/mips/include/asm/hugetlb.h
> index b3d6bb53ee6e..6ff2531cfb1d 100644
> --- a/arch/mips/include/asm/hugetlb.h
> +++ b/arch/mips/include/asm/hugetlb.h
> @@ -18,6 +18,7 @@ static inline int is_hugepage_only_range(struct mm_struct *mm,
>  	return 0;
>  }
>  
> +#define __HAVE_ARCH_PREPARE_HUGEPAGE_RANGE
>  static inline int prepare_hugepage_range(struct file *file,
>  					 unsigned long addr,
>  					 unsigned long len)
> diff --git a/arch/parisc/include/asm/hugetlb.h b/arch/parisc/include/asm/hugetlb.h
> index 5a102d7251e4..fb7e0fd858a3 100644
> --- a/arch/parisc/include/asm/hugetlb.h
> +++ b/arch/parisc/include/asm/hugetlb.h
> @@ -22,6 +22,7 @@ static inline int is_hugepage_only_range(struct mm_struct *mm,
>   * If the arch doesn't supply something else, assume that hugepage
>   * size aligned regions are ok without further preparation.
>   */
> +#define __HAVE_ARCH_PREPARE_HUGEPAGE_RANGE
>  static inline int prepare_hugepage_range(struct file *file,
>  			unsigned long addr, unsigned long len)
>  {
> diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
> index 7123599089c6..69c14ecac133 100644
> --- a/arch/powerpc/include/asm/hugetlb.h
> +++ b/arch/powerpc/include/asm/hugetlb.h
> @@ -117,21 +117,6 @@ void hugetlb_free_pgd_range(struct mmu_gather *tlb, unsigned long addr,
>  			    unsigned long end, unsigned long floor,
>  			    unsigned long ceiling);
>  
> -/*
> - * If the arch doesn't supply something else, assume that hugepage
> - * size aligned regions are ok without further preparation.
> - */
> -static inline int prepare_hugepage_range(struct file *file,
> -			unsigned long addr, unsigned long len)
> -{
> -	struct hstate *h = hstate_file(file);
> -	if (len & ~huge_page_mask(h))
> -		return -EINVAL;
> -	if (addr & ~huge_page_mask(h))
> -		return -EINVAL;
> -	return 0;
> -}
> -
>  #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
>  static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
>  					    unsigned long addr, pte_t *ptep)
> diff --git a/arch/sh/include/asm/hugetlb.h b/arch/sh/include/asm/hugetlb.h
> index 54f65094efe6..f1bbd255ee43 100644
> --- a/arch/sh/include/asm/hugetlb.h
> +++ b/arch/sh/include/asm/hugetlb.h
> @@ -15,6 +15,7 @@ static inline int is_hugepage_only_range(struct mm_struct *mm,
>   * If the arch doesn't supply something else, assume that hugepage
>   * size aligned regions are ok without further preparation.
>   */
> +#define __HAVE_ARCH_PREPARE_HUGEPAGE_RANGE
>  static inline int prepare_hugepage_range(struct file *file,
>  			unsigned long addr, unsigned long len)
>  {
> diff --git a/arch/sparc/include/asm/hugetlb.h b/arch/sparc/include/asm/hugetlb.h
> index f661362376e0..2101ea217f33 100644
> --- a/arch/sparc/include/asm/hugetlb.h
> +++ b/arch/sparc/include/asm/hugetlb.h
> @@ -26,22 +26,6 @@ static inline int is_hugepage_only_range(struct mm_struct *mm,
>  	return 0;
>  }
>  
> -/*
> - * If the arch doesn't supply something else, assume that hugepage
> - * size aligned regions are ok without further preparation.
> - */
> -static inline int prepare_hugepage_range(struct file *file,
> -			unsigned long addr, unsigned long len)
> -{
> -	struct hstate *h = hstate_file(file);
> -
> -	if (len & ~huge_page_mask(h))
> -		return -EINVAL;
> -	if (addr & ~huge_page_mask(h))
> -		return -EINVAL;
> -	return 0;
> -}
> -
>  #define __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
>  static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
>  					 unsigned long addr, pte_t *ptep)
> diff --git a/arch/x86/include/asm/hugetlb.h b/arch/x86/include/asm/hugetlb.h
> index 19668672ab37..2e5117d37c7d 100644
> --- a/arch/x86/include/asm/hugetlb.h
> +++ b/arch/x86/include/asm/hugetlb.h
> @@ -12,21 +12,6 @@ static inline int is_hugepage_only_range(struct mm_struct *mm,
>  	return 0;
>  }
>  
> -/*
> - * If the arch doesn't supply something else, assume that hugepage
> - * size aligned regions are ok without further preparation.
> - */
> -static inline int prepare_hugepage_range(struct file *file,
> -			unsigned long addr, unsigned long len)
> -{
> -	struct hstate *h = hstate_file(file);
> -	if (len & ~huge_page_mask(h))
> -		return -EINVAL;
> -	if (addr & ~huge_page_mask(h))
> -		return -EINVAL;
> -	return 0;
> -}
> -
>  static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
>  					   unsigned long addr, pte_t *ptep)
>  {
> diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
> index cd9697672b79..6c0c8b0c71e0 100644
> --- a/include/asm-generic/hugetlb.h
> +++ b/include/asm-generic/hugetlb.h
> @@ -87,4 +87,19 @@ static inline pte_t huge_pte_wrprotect(pte_t pte)
>  }
>  #endif
>  
> +#ifndef __HAVE_ARCH_PREPARE_HUGEPAGE_RANGE
> +static inline int prepare_hugepage_range(struct file *file,
> +		unsigned long addr, unsigned long len)
> +{
> +	struct hstate *h = hstate_file(file);
> +
> +	if (len & ~huge_page_mask(h))
> +		return -EINVAL;
> +	if (addr & ~huge_page_mask(h))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +#endif
> +
>  #endif /* _ASM_GENERIC_HUGETLB_H */
> 
