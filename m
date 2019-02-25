Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBADC10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CED12146F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 15:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfBYPs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 10:48:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52456 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727712AbfBYPs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 10:48:56 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1PFiwXb057146
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 10:48:55 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qvjwahk8a-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 10:48:54 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Mon, 25 Feb 2019 15:48:52 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Feb 2019 15:48:46 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1PFmj6D62980160
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Feb 2019 15:48:45 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5CF59AE045;
        Mon, 25 Feb 2019 15:48:45 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A3AFAE04D;
        Mon, 25 Feb 2019 15:48:43 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.205.26])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 25 Feb 2019 15:48:43 +0000 (GMT)
Date:   Mon, 25 Feb 2019 17:48:41 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Martin Cracauer <cracauer@cons.org>, Shaohua Li <shli@fb.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v2 08/26] userfaultfd: wp: add WP pagetable tracking to
 x86
References: <20190212025632.28946-1-peterx@redhat.com>
 <20190212025632.28946-9-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212025632.28946-9-peterx@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19022515-0020-0000-0000-0000031B085B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022515-0021-0000-0000-0000216C69DE
Message-Id: <20190225154841.GC24917@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-25_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=943 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902250115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 10:56:14AM +0800, Peter Xu wrote:
> From: Andrea Arcangeli <aarcange@redhat.com>
> 
> Accurate userfaultfd WP tracking is possible by tracking exactly which
> virtual memory ranges were writeprotected by userland. We can't relay
> only on the RW bit of the mapped pagetable because that information is
> destroyed by fork() or KSM or swap. If we were to relay on that, we'd
> need to stay on the safe side and generate false positive wp faults
> for every swapped out page.
> 
> Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  arch/x86/Kconfig                     |  1 +
>  arch/x86/include/asm/pgtable.h       | 52 ++++++++++++++++++++++++++++
>  arch/x86/include/asm/pgtable_64.h    |  8 ++++-
>  arch/x86/include/asm/pgtable_types.h |  9 +++++
>  include/asm-generic/pgtable.h        |  1 +
>  include/asm-generic/pgtable_uffd.h   | 51 +++++++++++++++++++++++++++
>  init/Kconfig                         |  5 +++
>  7 files changed, 126 insertions(+), 1 deletion(-)
>  create mode 100644 include/asm-generic/pgtable_uffd.h
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 68261430fe6e..cb43bc008675 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -209,6 +209,7 @@ config X86
>  	select USER_STACKTRACE_SUPPORT
>  	select VIRT_TO_BUS
>  	select X86_FEATURE_NAMES		if PROC_FS
> +	select HAVE_ARCH_USERFAULTFD_WP		if USERFAULTFD
> 
>  config INSTRUCTION_DECODER
>  	def_bool y
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index 2779ace16d23..6863236e8484 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -23,6 +23,7 @@
> 
>  #ifndef __ASSEMBLY__
>  #include <asm/x86_init.h>
> +#include <asm-generic/pgtable_uffd.h>
> 
>  extern pgd_t early_top_pgt[PTRS_PER_PGD];
>  int __init __early_make_pgtable(unsigned long address, pmdval_t pmd);
> @@ -293,6 +294,23 @@ static inline pte_t pte_clear_flags(pte_t pte, pteval_t clear)
>  	return native_make_pte(v & ~clear);
>  }
> 
> +#ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
> +static inline int pte_uffd_wp(pte_t pte)
> +{
> +	return pte_flags(pte) & _PAGE_UFFD_WP;
> +}
> +
> +static inline pte_t pte_mkuffd_wp(pte_t pte)
> +{
> +	return pte_set_flags(pte, _PAGE_UFFD_WP);
> +}
> +
> +static inline pte_t pte_clear_uffd_wp(pte_t pte)
> +{
> +	return pte_clear_flags(pte, _PAGE_UFFD_WP);
> +}
> +#endif /* CONFIG_HAVE_ARCH_USERFAULTFD_WP */
> +
>  static inline pte_t pte_mkclean(pte_t pte)
>  {
>  	return pte_clear_flags(pte, _PAGE_DIRTY);
> @@ -372,6 +390,23 @@ static inline pmd_t pmd_clear_flags(pmd_t pmd, pmdval_t clear)
>  	return native_make_pmd(v & ~clear);
>  }
> 
> +#ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
> +static inline int pmd_uffd_wp(pmd_t pmd)
> +{
> +	return pmd_flags(pmd) & _PAGE_UFFD_WP;
> +}
> +
> +static inline pmd_t pmd_mkuffd_wp(pmd_t pmd)
> +{
> +	return pmd_set_flags(pmd, _PAGE_UFFD_WP);
> +}
> +
> +static inline pmd_t pmd_clear_uffd_wp(pmd_t pmd)
> +{
> +	return pmd_clear_flags(pmd, _PAGE_UFFD_WP);
> +}
> +#endif /* CONFIG_HAVE_ARCH_USERFAULTFD_WP */
> +
>  static inline pmd_t pmd_mkold(pmd_t pmd)
>  {
>  	return pmd_clear_flags(pmd, _PAGE_ACCESSED);
> @@ -1351,6 +1386,23 @@ static inline pmd_t pmd_swp_clear_soft_dirty(pmd_t pmd)
>  #endif
>  #endif
> 
> +#ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
> +static inline pte_t pte_swp_mkuffd_wp(pte_t pte)
> +{
> +	return pte_set_flags(pte, _PAGE_SWP_UFFD_WP);
> +}
> +
> +static inline int pte_swp_uffd_wp(pte_t pte)
> +{
> +	return pte_flags(pte) & _PAGE_SWP_UFFD_WP;
> +}
> +
> +static inline pte_t pte_swp_clear_uffd_wp(pte_t pte)
> +{
> +	return pte_clear_flags(pte, _PAGE_SWP_UFFD_WP);
> +}
> +#endif /* CONFIG_HAVE_ARCH_USERFAULTFD_WP */
> +
>  #define PKRU_AD_BIT 0x1
>  #define PKRU_WD_BIT 0x2
>  #define PKRU_BITS_PER_PKEY 2
> diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
> index 9c85b54bf03c..e0c5d29b8685 100644
> --- a/arch/x86/include/asm/pgtable_64.h
> +++ b/arch/x86/include/asm/pgtable_64.h
> @@ -189,7 +189,7 @@ extern void sync_global_pgds(unsigned long start, unsigned long end);
>   *
>   * |     ...            | 11| 10|  9|8|7|6|5| 4| 3|2| 1|0| <- bit number
>   * |     ...            |SW3|SW2|SW1|G|L|D|A|CD|WT|U| W|P| <- bit names
> - * | TYPE (59-63) | ~OFFSET (9-58)  |0|0|X|X| X| X|X|SD|0| <- swp entry
> + * | TYPE (59-63) | ~OFFSET (9-58)  |0|0|X|X| X| X|F|SD|0| <- swp entry
>   *
>   * G (8) is aliased and used as a PROT_NONE indicator for
>   * !present ptes.  We need to start storing swap entries above
> @@ -197,9 +197,15 @@ extern void sync_global_pgds(unsigned long start, unsigned long end);
>   * erratum where they can be incorrectly set by hardware on
>   * non-present PTEs.
>   *
> + * SD Bits 1-4 are not used in non-present format and available for
> + * special use described below:
> + *
>   * SD (1) in swp entry is used to store soft dirty bit, which helps us
>   * remember soft dirty over page migration
>   *
> + * F (2) in swp entry is used to record when a pagetable is
> + * writeprotected by userfaultfd WP support.
> + *
>   * Bit 7 in swp entry should be 0 because pmd_present checks not only P,
>   * but also L and G.
>   *
> diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
> index d6ff0bbdb394..8cebcff91e57 100644
> --- a/arch/x86/include/asm/pgtable_types.h
> +++ b/arch/x86/include/asm/pgtable_types.h
> @@ -32,6 +32,7 @@
> 
>  #define _PAGE_BIT_SPECIAL	_PAGE_BIT_SOFTW1
>  #define _PAGE_BIT_CPA_TEST	_PAGE_BIT_SOFTW1
> +#define _PAGE_BIT_UFFD_WP	_PAGE_BIT_SOFTW2 /* userfaultfd wrprotected */
>  #define _PAGE_BIT_SOFT_DIRTY	_PAGE_BIT_SOFTW3 /* software dirty tracking */
>  #define _PAGE_BIT_DEVMAP	_PAGE_BIT_SOFTW4
> 
> @@ -100,6 +101,14 @@
>  #define _PAGE_SWP_SOFT_DIRTY	(_AT(pteval_t, 0))
>  #endif
> 
> +#ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
> +#define _PAGE_UFFD_WP		(_AT(pteval_t, 1) << _PAGE_BIT_UFFD_WP)
> +#define _PAGE_SWP_UFFD_WP	_PAGE_USER
> +#else
> +#define _PAGE_UFFD_WP		(_AT(pteval_t, 0))
> +#define _PAGE_SWP_UFFD_WP	(_AT(pteval_t, 0))
> +#endif
> +
>  #if defined(CONFIG_X86_64) || defined(CONFIG_X86_PAE)
>  #define _PAGE_NX	(_AT(pteval_t, 1) << _PAGE_BIT_NX)
>  #define _PAGE_DEVMAP	(_AT(u64, 1) << _PAGE_BIT_DEVMAP)
> diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
> index 05e61e6c843f..f49afe951711 100644
> --- a/include/asm-generic/pgtable.h
> +++ b/include/asm-generic/pgtable.h
> @@ -10,6 +10,7 @@
>  #include <linux/mm_types.h>
>  #include <linux/bug.h>
>  #include <linux/errno.h>
> +#include <asm-generic/pgtable_uffd.h>
> 
>  #if 5 - defined(__PAGETABLE_P4D_FOLDED) - defined(__PAGETABLE_PUD_FOLDED) - \
>  	defined(__PAGETABLE_PMD_FOLDED) != CONFIG_PGTABLE_LEVELS
> diff --git a/include/asm-generic/pgtable_uffd.h b/include/asm-generic/pgtable_uffd.h
> new file mode 100644
> index 000000000000..643d1bf559c2
> --- /dev/null
> +++ b/include/asm-generic/pgtable_uffd.h
> @@ -0,0 +1,51 @@
> +#ifndef _ASM_GENERIC_PGTABLE_UFFD_H
> +#define _ASM_GENERIC_PGTABLE_UFFD_H
> +
> +#ifndef CONFIG_HAVE_ARCH_USERFAULTFD_WP
> +static __always_inline int pte_uffd_wp(pte_t pte)
> +{
> +	return 0;
> +}
> +
> +static __always_inline int pmd_uffd_wp(pmd_t pmd)
> +{
> +	return 0;
> +}
> +
> +static __always_inline pte_t pte_mkuffd_wp(pte_t pte)
> +{
> +	return pte;
> +}
> +
> +static __always_inline pmd_t pmd_mkuffd_wp(pmd_t pmd)
> +{
> +	return pmd;
> +}
> +
> +static __always_inline pte_t pte_clear_uffd_wp(pte_t pte)
> +{
> +	return pte;
> +}
> +
> +static __always_inline pmd_t pmd_clear_uffd_wp(pmd_t pmd)
> +{
> +	return pmd;
> +}
> +
> +static __always_inline pte_t pte_swp_mkuffd_wp(pte_t pte)
> +{
> +	return pte;
> +}
> +
> +static __always_inline int pte_swp_uffd_wp(pte_t pte)
> +{
> +	return 0;
> +}
> +
> +static __always_inline pte_t pte_swp_clear_uffd_wp(pte_t pte)
> +{
> +	return pte;
> +}
> +#endif /* CONFIG_HAVE_ARCH_USERFAULTFD_WP */
> +
> +#endif /* _ASM_GENERIC_PGTABLE_UFFD_H */
> diff --git a/init/Kconfig b/init/Kconfig
> index c9386a365eea..892d61ddf2eb 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1424,6 +1424,11 @@ config ADVISE_SYSCALLS
>  	  applications use these syscalls, you can disable this option to save
>  	  space.
> 
> +config HAVE_ARCH_USERFAULTFD_WP
> +	bool
> +	help
> +	  Arch has userfaultfd write protection support
> +
>  config MEMBARRIER
>  	bool "Enable membarrier() system call" if EXPERT
>  	default y
> -- 
> 2.17.1
> 

-- 
Sincerely yours,
Mike.

