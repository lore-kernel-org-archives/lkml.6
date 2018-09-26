Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04258C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 02:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E4E120833
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 02:43:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E4E120833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbeIZIyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 04:54:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34680 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725901AbeIZIyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 04:54:23 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8Q2dWOM109423
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 22:43:45 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mqwvv7k4a-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 22:43:44 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Wed, 26 Sep 2018 03:43:43 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 26 Sep 2018 03:43:40 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8Q2hdBJ44499124
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Sep 2018 02:43:39 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C652342042;
        Wed, 26 Sep 2018 05:43:23 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD5ED4203F;
        Wed, 26 Sep 2018 05:43:21 +0100 (BST)
Received: from skywalker (unknown [9.199.41.211])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Wed, 26 Sep 2018 05:43:21 +0100 (BST)
Received: (nullmailer pid 6812 invoked by uid 1000);
        Wed, 26 Sep 2018 02:43:36 -0000
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 14/22] powerpc/mm: Move pte_fragment_alloc() to a common location
In-Reply-To: <de995657691084fe1b8a5c31393a82e52604def8.1537892499.git.christophe.leroy@c-s.fr>
References: <cover.1537892498.git.christophe.leroy@c-s.fr> <de995657691084fe1b8a5c31393a82e52604def8.1537892499.git.christophe.leroy@c-s.fr>
Date:   Wed, 26 Sep 2018 08:13:36 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18092602-0028-0000-0000-000002FE9A01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092602-0029-0000-0000-000023B8B017
Message-Id: <87tvmdgeqv.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-26_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=5 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809260026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> In preparation of next patch which generalises the use of
> pte_fragment_alloc() for all, this patch moves the related functions
> in a place that is common to all subarches.
>
> The 8xx will need that for supporting 16k pages, as in that mode
> page tables still have a size of 4k.
>
> Since pte_fragment with only once fragment is not different
> from what is done in the general case, we can easily migrate all
> subarchs to pte fragments.
>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/include/asm/book3s/64/pgalloc.h |   1 +
>  arch/powerpc/mm/Makefile                     |   4 +-
>  arch/powerpc/mm/mmu_context_book3s64.c       |  15 ----
>  arch/powerpc/mm/pgtable-book3s64.c           |  85 --------------------
>  arch/powerpc/mm/pgtable-frag.c               | 116 +++++++++++++++++++++++++++
>  5 files changed, 120 insertions(+), 101 deletions(-)
>  create mode 100644 arch/powerpc/mm/pgtable-frag.c
>
> diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc.h b/arch/powerpc/include/asm/book3s/64/pgalloc.h
> index bfed4cf3b2f3..6c2808c0f052 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgalloc.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
> @@ -39,6 +39,7 @@ extern struct vmemmap_backing *vmemmap_list;
>  extern struct kmem_cache *pgtable_cache[];
>  #define PGT_CACHE(shift) pgtable_cache[shift]
>  
> +void pte_frag_destroy(void *pte_frag);
>  extern pte_t *pte_fragment_alloc(struct mm_struct *, unsigned long, int);
>  extern pmd_t *pmd_fragment_alloc(struct mm_struct *, unsigned long);
>  extern void pte_fragment_free(unsigned long *, int);
> diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
> index d0c1ce1297e3..db2f001183d1 100644
> --- a/arch/powerpc/mm/Makefile
> +++ b/arch/powerpc/mm/Makefile
> @@ -15,7 +15,9 @@ obj-$(CONFIG_PPC_MMU_NOHASH)	+= mmu_context_nohash.o tlb_nohash.o \
>  obj-$(CONFIG_PPC_BOOK3E)	+= tlb_low_$(BITS)e.o
>  hash64-$(CONFIG_PPC_NATIVE)	:= hash_native_64.o
>  obj-$(CONFIG_PPC_BOOK3E_64)   += pgtable-book3e.o
> -obj-$(CONFIG_PPC_BOOK3S_64)	+= pgtable-hash64.o hash_utils_64.o slb.o $(hash64-y) mmu_context_book3s64.o pgtable-book3s64.o
> +obj-$(CONFIG_PPC_BOOK3S_64)	+= pgtable-hash64.o hash_utils_64.o slb.o \
> +				   $(hash64-y) mmu_context_book3s64.o \
> +				   pgtable-book3s64.o pgtable-frag.o
>  obj-$(CONFIG_PPC_RADIX_MMU)	+= pgtable-radix.o tlb-radix.o
>  obj-$(CONFIG_PPC_STD_MMU_32)	+= ppc_mmu_32.o hash_low_32.o mmu_context_hash32.o
>  obj-$(CONFIG_PPC_STD_MMU)	+= tlb_hash$(BITS).o
> diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
> index 510f103d7813..f720c5cc0b5e 100644
> --- a/arch/powerpc/mm/mmu_context_book3s64.c
> +++ b/arch/powerpc/mm/mmu_context_book3s64.c
> @@ -164,21 +164,6 @@ static void destroy_contexts(mm_context_t *ctx)
>  	}
>  }
>  
> -static void pte_frag_destroy(void *pte_frag)
> -{
> -	int count;
> -	struct page *page;
> -
> -	page = virt_to_page(pte_frag);
> -	/* drop all the pending references */
> -	count = ((unsigned long)pte_frag & ~PAGE_MASK) >> PTE_FRAG_SIZE_SHIFT;
> -	/* We allow PTE_FRAG_NR fragments from a PTE page */
> -	if (atomic_sub_and_test(PTE_FRAG_NR - count, &page->pt_frag_refcount)) {
> -		pgtable_page_dtor(page);
> -		__free_page(page);
> -	}
> -}
> -
>  static void pmd_frag_destroy(void *pmd_frag)
>  {
>  	int count;
> diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
> index 01d7c0f7c4f0..723cd324fa34 100644
> --- a/arch/powerpc/mm/pgtable-book3s64.c
> +++ b/arch/powerpc/mm/pgtable-book3s64.c
> @@ -317,91 +317,6 @@ void pmd_fragment_free(unsigned long *pmd)
>  	}
>  }
>  
> -static pte_t *get_pte_from_cache(struct mm_struct *mm)
> -{
> -	void *pte_frag, *ret;
> -
> -	spin_lock(&mm->page_table_lock);
> -	ret = mm->context.pte_frag;
> -	if (ret) {
> -		pte_frag = ret + PTE_FRAG_SIZE;
> -		/*
> -		 * If we have taken up all the fragments mark PTE page NULL
> -		 */
> -		if (((unsigned long)pte_frag & ~PAGE_MASK) == 0)
> -			pte_frag = NULL;
> -		mm->context.pte_frag = pte_frag;
> -	}
> -	spin_unlock(&mm->page_table_lock);
> -	return (pte_t *)ret;
> -}
> -
> -static pte_t *__alloc_for_ptecache(struct mm_struct *mm, int kernel)
> -{
> -	void *ret = NULL;
> -	struct page *page;
> -
> -	if (!kernel) {
> -		page = alloc_page(PGALLOC_GFP | __GFP_ACCOUNT);
> -		if (!page)
> -			return NULL;
> -		if (!pgtable_page_ctor(page)) {
> -			__free_page(page);
> -			return NULL;
> -		}
> -	} else {
> -		page = alloc_page(PGALLOC_GFP);
> -		if (!page)
> -			return NULL;
> -	}
> -
> -	atomic_set(&page->pt_frag_refcount, 1);
> -
> -	ret = page_address(page);
> -	/*
> -	 * if we support only one fragment just return the
> -	 * allocated page.
> -	 */
> -	if (PTE_FRAG_NR == 1)
> -		return ret;
> -	spin_lock(&mm->page_table_lock);
> -	/*
> -	 * If we find pgtable_page set, we return
> -	 * the allocated page with single fragement
> -	 * count.
> -	 */
> -	if (likely(!mm->context.pte_frag)) {
> -		atomic_set(&page->pt_frag_refcount, PTE_FRAG_NR);
> -		mm->context.pte_frag = ret + PTE_FRAG_SIZE;
> -	}
> -	spin_unlock(&mm->page_table_lock);
> -
> -	return (pte_t *)ret;
> -}
> -
> -pte_t *pte_fragment_alloc(struct mm_struct *mm, unsigned long vmaddr, int kernel)
> -{
> -	pte_t *pte;
> -
> -	pte = get_pte_from_cache(mm);
> -	if (pte)
> -		return pte;
> -
> -	return __alloc_for_ptecache(mm, kernel);
> -}
> -
> -void pte_fragment_free(unsigned long *table, int kernel)
> -{
> -	struct page *page = virt_to_page(table);
> -
> -	BUG_ON(atomic_read(&page->pt_frag_refcount) <= 0);
> -	if (atomic_dec_and_test(&page->pt_frag_refcount)) {
> -		if (!kernel)
> -			pgtable_page_dtor(page);
> -		__free_page(page);
> -	}
> -}
> -
>  static inline void pgtable_free(void *table, int index)
>  {
>  	switch (index) {
> diff --git a/arch/powerpc/mm/pgtable-frag.c b/arch/powerpc/mm/pgtable-frag.c
> new file mode 100644
> index 000000000000..d61e7c2a9a79
> --- /dev/null
> +++ b/arch/powerpc/mm/pgtable-frag.c
> @@ -0,0 +1,116 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + *  Handling Page Tables through page fragments
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/gfp.h>
> +#include <linux/mm.h>
> +#include <linux/percpu.h>
> +#include <linux/hardirq.h>
> +#include <linux/hugetlb.h>
> +#include <asm/pgalloc.h>
> +#include <asm/tlbflush.h>
> +#include <asm/tlb.h>
> +
> +void pte_frag_destroy(void *pte_frag)
> +{
> +	int count;
> +	struct page *page;
> +
> +	page = virt_to_page(pte_frag);
> +	/* drop all the pending references */
> +	count = ((unsigned long)pte_frag & ~PAGE_MASK) >> PTE_FRAG_SIZE_SHIFT;
> +	/* We allow PTE_FRAG_NR fragments from a PTE page */
> +	if (atomic_sub_and_test(PTE_FRAG_NR - count, &page->pt_frag_refcount)) {
> +		pgtable_page_dtor(page);
> +		__free_page(page);
> +	}
> +}
> +
> +static pte_t *get_pte_from_cache(struct mm_struct *mm)
> +{
> +	void *pte_frag, *ret;
> +
> +	spin_lock(&mm->page_table_lock);
> +	ret = mm->context.pte_frag;
> +	if (ret) {
> +		pte_frag = ret + PTE_FRAG_SIZE;
> +		/*
> +		 * If we have taken up all the fragments mark PTE page NULL
> +		 */
> +		if (((unsigned long)pte_frag & ~PAGE_MASK) == 0)
> +			pte_frag = NULL;
> +		mm->context.pte_frag = pte_frag;
> +	}
> +	spin_unlock(&mm->page_table_lock);
> +	return (pte_t *)ret;
> +}
> +
> +static pte_t *__alloc_for_ptecache(struct mm_struct *mm, int kernel)
> +{
> +	void *ret = NULL;
> +	struct page *page;
> +
> +	if (!kernel) {
> +		page = alloc_page(PGALLOC_GFP | __GFP_ACCOUNT);
> +		if (!page)
> +			return NULL;
> +		if (!pgtable_page_ctor(page)) {
> +			__free_page(page);
> +			return NULL;
> +		}
> +	} else {
> +		page = alloc_page(PGALLOC_GFP);
> +		if (!page)
> +			return NULL;
> +	}
> +
> +	atomic_set(&page->pt_frag_refcount, 1);
> +
> +	ret = page_address(page);
> +	/*
> +	 * if we support only one fragment just return the
> +	 * allocated page.
> +	 */
> +	if (PTE_FRAG_NR == 1)
> +		return ret;
> +	spin_lock(&mm->page_table_lock);
> +	/*
> +	 * If we find pgtable_page set, we return
> +	 * the allocated page with single fragement
> +	 * count.
> +	 */
> +	if (likely(!mm->context.pte_frag)) {
> +		atomic_set(&page->pt_frag_refcount, PTE_FRAG_NR);
> +		mm->context.pte_frag = ret + PTE_FRAG_SIZE;
> +	}
> +	spin_unlock(&mm->page_table_lock);
> +
> +	return (pte_t *)ret;
> +}
> +
> +pte_t *pte_fragment_alloc(struct mm_struct *mm, unsigned long vmaddr, int kernel)
> +{
> +	pte_t *pte;
> +
> +	pte = get_pte_from_cache(mm);
> +	if (pte)
> +		return pte;
> +
> +	return __alloc_for_ptecache(mm, kernel);
> +}
> +
> +void pte_fragment_free(unsigned long *table, int kernel)
> +{
> +	struct page *page = virt_to_page(table);
> +
> +	BUG_ON(atomic_read(&page->pt_frag_refcount) <= 0);
> +	if (atomic_dec_and_test(&page->pt_frag_refcount)) {
> +		if (!kernel)
> +			pgtable_page_dtor(page);
> +		__free_page(page);
> +	}
> +}
> -- 
> 2.13.3

