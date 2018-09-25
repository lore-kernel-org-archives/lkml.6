Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A933C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3902D2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:48:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3902D2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbeIYW5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 18:57:04 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:46542 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbeIYW5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 18:57:03 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42KRpx3R3dz9ttCY;
        Tue, 25 Sep 2018 18:48:41 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id tXfwbOzctd8i; Tue, 25 Sep 2018 18:48:41 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42KRpx2gpyz9ttCN;
        Tue, 25 Sep 2018 18:48:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6EA658B7E5;
        Tue, 25 Sep 2018 18:48:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id WILEYpKLbejY; Tue, 25 Sep 2018 18:48:41 +0200 (CEST)
Received: from PO15451 (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AE98F8B7C8;
        Tue, 25 Sep 2018 18:48:40 +0200 (CEST)
Subject: Re: [PATCH v4 16/20] powerpc/mm: Extend pte_fragment functionality to
 nohash/32
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1537288312.git.christophe.leroy@c-s.fr>
 <a2f88be3bdaddc54a5836d6049c616b1739aef42.1537288312.git.christophe.leroy@c-s.fr>
 <89038b3e-f1cd-a4a0-481b-46cef2b5e388@linux.ibm.com>
From:   Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <509b9290-82e6-8b91-a852-67453ebd06c0@c-s.fr>
Date:   Tue, 25 Sep 2018 18:48:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <89038b3e-f1cd-a4a0-481b-46cef2b5e388@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 19/09/2018 à 05:03, Aneesh Kumar K.V a écrit :
> On 9/18/18 10:27 PM, Christophe Leroy wrote:
>> In order to allow the 8xx to handle pte_fragments, this patch
>> extends the use of pte_fragments to nohash/32 platforms.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   arch/powerpc/include/asm/mmu-40x.h           |  1 +
>>   arch/powerpc/include/asm/mmu-44x.h           |  1 +
>>   arch/powerpc/include/asm/mmu-8xx.h           |  1 +
>>   arch/powerpc/include/asm/mmu-book3e.h        |  1 +
>>   arch/powerpc/include/asm/mmu_context.h       |  2 +-
>>   arch/powerpc/include/asm/nohash/32/pgalloc.h | 43 
>> +++++++++++-----------------
>>   arch/powerpc/include/asm/nohash/32/pgtable.h |  7 +++--
>>   arch/powerpc/include/asm/page.h              |  6 +---
>>   arch/powerpc/include/asm/pgtable.h           |  8 ++++++
>>   arch/powerpc/mm/Makefile                     |  3 ++
>>   arch/powerpc/mm/mmu_context_nohash.c         |  1 +
>>   arch/powerpc/mm/pgtable-frag.c               |  6 ++++
>>   arch/powerpc/mm/pgtable_32.c                 |  8 ++++--
>>   13 files changed, 51 insertions(+), 37 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/mmu-40x.h 
>> b/arch/powerpc/include/asm/mmu-40x.h
>> index 74f4edb5916e..7c77ceed71d6 100644
>> --- a/arch/powerpc/include/asm/mmu-40x.h
>> +++ b/arch/powerpc/include/asm/mmu-40x.h
>> @@ -58,6 +58,7 @@ typedef struct {
>>       unsigned int    id;
>>       unsigned int    active;
>>       unsigned long    vdso_base;
>> +    void *pte_frag;
>>   } mm_context_t;
>>
>>   #endif /* !__ASSEMBLY__ */
>> diff --git a/arch/powerpc/include/asm/mmu-44x.h 
>> b/arch/powerpc/include/asm/mmu-44x.h
>> index 295b3dbb2698..3d72e889ae7b 100644
>> --- a/arch/powerpc/include/asm/mmu-44x.h
>> +++ b/arch/powerpc/include/asm/mmu-44x.h
>> @@ -109,6 +109,7 @@ typedef struct {
>>       unsigned int    id;
>>       unsigned int    active;
>>       unsigned long    vdso_base;
>> +    void *pte_frag;
>>   } mm_context_t;
>>
>>   #endif /* !__ASSEMBLY__ */
>> diff --git a/arch/powerpc/include/asm/mmu-8xx.h 
>> b/arch/powerpc/include/asm/mmu-8xx.h
>> index fa05aa566ece..750cef6f65e3 100644
>> --- a/arch/powerpc/include/asm/mmu-8xx.h
>> +++ b/arch/powerpc/include/asm/mmu-8xx.h
>> @@ -179,6 +179,7 @@ typedef struct {
>>       unsigned int id;
>>       unsigned int active;
>>       unsigned long vdso_base;
>> +    void *pte_frag;
>>   #ifdef CONFIG_PPC_MM_SLICES
>>       u16 user_psize;        /* page size index */
>>       unsigned char low_slices_psize[SLICE_ARRAY_SIZE];
>> diff --git a/arch/powerpc/include/asm/mmu-book3e.h 
>> b/arch/powerpc/include/asm/mmu-book3e.h
>> index e20072972e35..8e8aad5172ab 100644
>> --- a/arch/powerpc/include/asm/mmu-book3e.h
>> +++ b/arch/powerpc/include/asm/mmu-book3e.h
>> @@ -230,6 +230,7 @@ typedef struct {
>>       unsigned int    id;
>>       unsigned int    active;
>>       unsigned long    vdso_base;
>> +    void *pte_frag;
>>   } mm_context_t;
>>
>>   /* Page size definitions, common between 32 and 64-bit
>> diff --git a/arch/powerpc/include/asm/mmu_context.h 
>> b/arch/powerpc/include/asm/mmu_context.h
>> index b2f89b621b15..7f2c37a3f99d 100644
>> --- a/arch/powerpc/include/asm/mmu_context.h
>> +++ b/arch/powerpc/include/asm/mmu_context.h
>> @@ -222,7 +222,7 @@ static inline int arch_dup_mmap(struct mm_struct 
>> *oldmm,
>>       return 0;
>>   }
>>
>> -#ifndef CONFIG_PPC_BOOK3S_64
>> +#if defined(CONFIG_PPC_BOOK3E_64) || defined(CONFIG_PPC_BOOK3S_32)
>>   static inline void arch_exit_mmap(struct mm_struct *mm)
>>   {
>>   }
>> diff --git a/arch/powerpc/include/asm/nohash/32/pgalloc.h 
>> b/arch/powerpc/include/asm/nohash/32/pgalloc.h
>> index f3fec9052f31..e69423ad8e2e 100644
>> --- a/arch/powerpc/include/asm/nohash/32/pgalloc.h
>> +++ b/arch/powerpc/include/asm/nohash/32/pgalloc.h
>> @@ -27,6 +27,9 @@ extern void __bad_pte(pmd_t *pmd);
>>   extern struct kmem_cache *pgtable_cache[];
>>   #define PGT_CACHE(shift) pgtable_cache[shift]
>>
>> +pte_t *pte_fragment_alloc(struct mm_struct *mm, unsigned long vmaddr, 
>> int kernel);
>> +void pte_fragment_free(unsigned long *table, int kernel);
>> +
>>   static inline pgd_t *pgd_alloc(struct mm_struct *mm)
>>   {
>>       return kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE),
>> @@ -58,11 +61,10 @@ static inline void pmd_populate_kernel(struct 
>> mm_struct *mm, pmd_t *pmdp,
>>   static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmdp,
>>                   pgtable_t pte_page)
>>   {
>> -    *pmdp = __pmd((page_to_pfn(pte_page) << PAGE_SHIFT) | _PMD_USER |
>> -              _PMD_PRESENT);
>> +    *pmdp = __pmd(__pa(pte_page) | _PMD_USER | _PMD_PRESENT);
>>   }
>>
>> -#define pmd_pgtable(pmd) pmd_page(pmd)
>> +#define pmd_pgtable(pmd) ((pgtable_t)pmd_page_vaddr(pmd))
>>   #else
>>
>>   static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t 
>> *pmdp,
>> @@ -74,49 +76,38 @@ static inline void pmd_populate_kernel(struct 
>> mm_struct *mm, pmd_t *pmdp,
>>   static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmdp,
>>                   pgtable_t pte_page)
>>   {
>> -    *pmdp = __pmd((unsigned long)lowmem_page_address(pte_page) | 
>> _PMD_PRESENT);
>> +    *pmdp = __pmd((unsigned long)pte_page | _PMD_PRESENT);
>>   }
>>
>> -#define pmd_pgtable(pmd) pmd_page(pmd)
>> +#define pmd_pgtable(pmd) ((pgtable_t)pmd_page_vaddr(pmd))
>>   #endif
>>
>> -static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm, 
>> unsigned long address)
>> +static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
>> +                      unsigned long address)
>>   {
>> -    return (pte_t *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
>> +    return (pte_t *)pte_fragment_alloc(mm, address, 1);
>>   }
>>
>> -static inline pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned 
>> long address)
>> +static inline pgtable_t pte_alloc_one(struct mm_struct *mm,
>> +                      unsigned long address)
>>   {
>> -    struct page *ptepage;
>> -
>> -    gfp_t flags = GFP_KERNEL | __GFP_ZERO | __GFP_ACCOUNT;
>> -
>> -    ptepage = alloc_pages(flags, 0);
>> -    if (!ptepage)
>> -        return NULL;
>> -    if (!pgtable_page_ctor(ptepage)) {
>> -        __free_page(ptepage);
>> -        return NULL;
>> -    }
>> -    return ptepage;
>> +    return (pgtable_t)pte_fragment_alloc(mm, address, 0);
>>   }
>>
>>   static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
>>   {
>> -    free_page((unsigned long)pte);
>> +    pte_fragment_free((unsigned long *)pte, 1);
>>   }
>>
>>   static inline void pte_free(struct mm_struct *mm, pgtable_t ptepage)
>>   {
>> -    pgtable_page_dtor(ptepage);
>> -    __free_page(ptepage);
>> +    pte_fragment_free((unsigned long *)ptepage, 0);
>>   }
>>
>>   static inline void pgtable_free(void *table, unsigned index_size)
>>   {
>>       if (!index_size) {
>> -        pgtable_page_dtor(virt_to_page(table));
>> -        free_page((unsigned long)table);
>> +        pte_fragment_free((unsigned long *)table, 0);
>>       } else {
>>           BUG_ON(index_size > MAX_PGTABLE_INDEX_SIZE);
>>           kmem_cache_free(PGT_CACHE(index_size), table);
>> @@ -155,6 +146,6 @@ static inline void __pte_free_tlb(struct 
>> mmu_gather *tlb, pgtable_t table,
>>                     unsigned long address)
>>   {
>>       tlb_flush_pgtable(tlb, address);
>> -    pgtable_free_tlb(tlb, page_address(table), 0);
>> +    pgtable_free_tlb(tlb, table, 0);
>>   }
>>   #endif /* _ASM_POWERPC_PGALLOC_32_H */
>> diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h 
>> b/arch/powerpc/include/asm/nohash/32/pgtable.h
>> index d2908a8038e8..73e2b1fbdb36 100644
>> --- a/arch/powerpc/include/asm/nohash/32/pgtable.h
>> +++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
>> @@ -336,12 +336,12 @@ static inline int pte_young(pte_t pte)
>>    */
>>   #ifndef CONFIG_BOOKE
>>   #define pmd_page_vaddr(pmd)    \
>> -    ((unsigned long) __va(pmd_val(pmd) & PAGE_MASK))
>> +    ((unsigned long)__va(pmd_val(pmd) & ~(PTE_TABLE_SIZE - 1)))
>>   #define pmd_page(pmd)        \
>>       pfn_to_page(pmd_val(pmd) >> PAGE_SHIFT)
>>   #else
>>   #define pmd_page_vaddr(pmd)    \
>> -    ((unsigned long) (pmd_val(pmd) & PAGE_MASK))
>> +    ((unsigned long)(pmd_val(pmd) & ~(PTE_TABLE_SIZE - 1)))
>>   #define pmd_page(pmd)        \
>>       pfn_to_page((__pa(pmd_val(pmd)) >> PAGE_SHIFT))
>>   #endif
>> @@ -360,7 +360,8 @@ static inline int pte_young(pte_t pte)
>>       (pmd_bad(*(dir)) ? NULL : (pte_t *)pmd_page_vaddr(*(dir)) + \
>>                     pte_index(addr))
>>   #define pte_offset_map(dir, addr)        \
>> -    ((pte_t *) kmap_atomic(pmd_page(*(dir))) + pte_index(addr))
>> +    ((pte_t *)(kmap_atomic(pmd_page(*(dir))) + \
>> +           (pmd_page_vaddr(*(dir)) & ~PAGE_MASK)) + pte_index(addr))
>>   #define pte_unmap(pte)        kunmap_atomic(pte)
>>
>>   /*
>> diff --git a/arch/powerpc/include/asm/page.h 
>> b/arch/powerpc/include/asm/page.h
>> index f6a1265face2..27d1c16601ee 100644
>> --- a/arch/powerpc/include/asm/page.h
>> +++ b/arch/powerpc/include/asm/page.h
>> @@ -335,7 +335,7 @@ void arch_free_page(struct page *page, int order);
>>   #endif
>>
>>   struct vm_area_struct;
>> -#ifdef CONFIG_PPC_BOOK3S_64
>> +#if !defined(CONFIG_PPC_BOOK3E_64) && !defined(CONFIG_PPC_BOOK3S_32)
>>   /*
>>    * For BOOK3s 64 with 4k and 64K linux page size
>>    * we want to use pointers, because the page table
>> @@ -343,12 +343,8 @@ struct vm_area_struct;
>>    */
>>   typedef pte_t *pgtable_t;
>>   #else
>> -#if defined(CONFIG_PPC_64K_PAGES) && defined(CONFIG_PPC64)
>> -typedef pte_t *pgtable_t;
>> -#else
>>   typedef struct page *pgtable_t;
>>   #endif
>> -#endif
>>
> 
> 
> Now that is getting complicated. Is there a way to move that to platform 
> header instead of that complicated #if?

Ok, added two new patches for that in v5 (one distributes mmu-xxx.h in 
platform dirs, the other moves pgtable_t typedefs in relevant files)

> 
>>   #include <asm-generic/memory_model.h>
>>   #endif /* __ASSEMBLY__ */
>> diff --git a/arch/powerpc/include/asm/pgtable.h 
>> b/arch/powerpc/include/asm/pgtable.h
>> index 8b38f7730211..1865a3e4ab8c 100644
>> --- a/arch/powerpc/include/asm/pgtable.h
>> +++ b/arch/powerpc/include/asm/pgtable.h
>> @@ -94,12 +94,20 @@ unsigned long vmalloc_to_phys(void *vmalloc_addr);
>>   void pgtable_cache_add(unsigned int shift);
>>   void pgtable_cache_init(void);
>>
>> +pte_t *early_alloc_pte(void);
>> +
>>   #if defined(CONFIG_STRICT_KERNEL_RWX) || defined(CONFIG_PPC32)
>>   void mark_initmem_nx(void);
>>   #else
>>   static inline void mark_initmem_nx(void) { }
>>   #endif
>>
>> +#ifndef PTE_FRAG_NR
>> +#define PTE_FRAG_NR        1
>> +#define PTE_FRAG_SIZE_SHIFT    PAGE_SHIFT
>> +#define PTE_FRAG_SIZE        PAGE_SIZE
>> +#endif
>> +
> 
> IMHO we should avoid that. The #ifndef challenge is that we should 
> always make sure the header inclusion is correct so that platform 
> headers get included before. Why not move it to the platform that want 
> to use pte fragmentation?

Ok, in v5 functions using it now defined static inline in platform 
headers so moved them there are well.

> 
> 
>>   #endif /* __ASSEMBLY__ */
>>
>>   #endif /* _ASM_POWERPC_PGTABLE_H */
>> diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
>> index bd43b3ee52cb..e1deb15fe85e 100644
>> --- a/arch/powerpc/mm/Makefile
>> +++ b/arch/powerpc/mm/Makefile
>> @@ -18,6 +18,9 @@ obj-$(CONFIG_PPC_BOOK3E_64)   += pgtable-book3e.o
>>   obj-$(CONFIG_PPC_BOOK3S_64)    += pgtable-hash64.o hash_utils_64.o 
>> slb_low.o slb.o \
>>                      $(hash64-y) mmu_context_book3s64.o 
>> pgtable-book3s64.o \
>>                      pgtable-frag.o
>> +ifndef CONFIG_PPC_BOOK3S_32
>> +obj-$(CONFIG_PPC32)        += pgtable-frag.o
>> +endif
>>   obj-$(CONFIG_PPC_RADIX_MMU)    += pgtable-radix.o tlb-radix.o
>>   obj-$(CONFIG_PPC_STD_MMU_32)    += ppc_mmu_32.o hash_low_32.o 
>> mmu_context_hash32.o
>>   obj-$(CONFIG_PPC_STD_MMU)    += tlb_hash$(BITS).o
>> diff --git a/arch/powerpc/mm/mmu_context_nohash.c 
>> b/arch/powerpc/mm/mmu_context_nohash.c
>> index 4d80239ef83c..98f0ef463dc8 100644
>> --- a/arch/powerpc/mm/mmu_context_nohash.c
>> +++ b/arch/powerpc/mm/mmu_context_nohash.c
>> @@ -385,6 +385,7 @@ int init_new_context(struct task_struct *t, struct 
>> mm_struct *mm)
>>   #endif
>>       mm->context.id = MMU_NO_CONTEXT;
>>       mm->context.active = 0;
>> +    mm->context.pte_frag = NULL;
>>       return 0;
>>   }
>>
>> diff --git a/arch/powerpc/mm/pgtable-frag.c 
>> b/arch/powerpc/mm/pgtable-frag.c
>> index ab4910e92aaf..d554a1cbc56d 100644
>> --- a/arch/powerpc/mm/pgtable-frag.c
>> +++ b/arch/powerpc/mm/pgtable-frag.c
>> @@ -30,6 +30,7 @@ static void pte_frag_destroy(void *pte_frag)
>>       }
>>   }
>>
>> +#ifdef CONFIG_PPC_BOOK3S_64
>>   static void pmd_frag_destroy(void *pmd_frag)
>>   {
>>       int count;
>> @@ -44,6 +45,7 @@ static void pmd_frag_destroy(void *pmd_frag)
>>           __free_page(page);
>>       }
>>   }
>> +#endif
>>
>>   static void destroy_pagetable_cache(struct mm_struct *mm)
>>   {
>> @@ -53,15 +55,18 @@ static void destroy_pagetable_cache(struct 
>> mm_struct *mm)
>>       if (frag)
>>           pte_frag_destroy(frag);
>>
>> +#ifdef CONFIG_PPC_BOOK3S_64
>>       frag = mm->context.pmd_frag;
>>       if (frag)
>>           pmd_frag_destroy(frag);
>> +#endif
>>   }
>>
>>   void arch_exit_mmap(struct mm_struct *mm)
>>   {
>>       destroy_pagetable_cache(mm);
>>
>> +#ifdef CONFIG_PPC_BOOK3S_64
>>       if (radix_enabled()) {
>>           /*
>>            * Radix doesn't have a valid bit in the process table
>> @@ -79,6 +84,7 @@ void arch_exit_mmap(struct mm_struct *mm)
>>            */
>>           process_tb[mm->context.id].prtb0 = 0;
>>       }
>> +#endif
>>   }
>>
> 
> is there a way to avoid all that #ifdef? May be redo the frag code such 
> that we have few helpers that is platform independent?

Yes, in v5 reworked to keep platform specific arch_exit_mmap() and 
destroy_pagetable_cache().

Christophe

> 
>>   static pte_t *get_pte_from_cache(struct mm_struct *mm)
>> diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
>> index 7900b613e6e5..81e6b18d1955 100644
>> --- a/arch/powerpc/mm/pgtable_32.c
>> +++ b/arch/powerpc/mm/pgtable_32.c
>> @@ -195,12 +195,16 @@ EXPORT_SYMBOL(iounmap);
>>   static __init pte_t *early_pte_alloc_kernel(pmd_t *pmdp, unsigned 
>> long va)
>>   {
>>       if (!pmd_present(*pmdp)) {
>> -        pte_t *ptep = __va(memblock_alloc(PAGE_SIZE, PAGE_SIZE));
>> +        pte_t *ptep = __va(memblock_alloc(PTE_FRAG_SIZE, 
>> PTE_FRAG_SIZE));
>>
>>           if (!ptep)
>>               return NULL;
>>
>> -        clear_page(ptep);
>> +        if (PTE_FRAG_SIZE == PAGE_SIZE)
>> +            clear_page(ptep);
>> +        else
>> +            memset(ptep, 0, PTE_FRAG_SIZE);
>> +
>>           pmd_populate_kernel(&init_mm, pmdp, ptep);
>>       }
>>       return pte_offset_kernel(pmdp, va);
>>
