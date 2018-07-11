Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FEBC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F9C20C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:15:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9F9C20C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389583AbeGKQU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:20:27 -0400
Received: from foss.arm.com ([217.140.101.70]:39708 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbeGKQU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:20:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB09D7A9;
        Wed, 11 Jul 2018 09:15:23 -0700 (PDT)
Received: from [10.1.206.34] (melchizedek.cambridge.arm.com [10.1.206.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 819EC3F589;
        Wed, 11 Jul 2018 09:15:22 -0700 (PDT)
Subject: Re: [PATCH v3 5/5] arm64/mm: Move {idmap_pg_dir, swapper_pg_dir} to
 .rodata section
To:     Jun Yao <yaojun8558363@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, suzuki.poulose@arm.com,
        linux-kernel@vger.kernel.org
References: <20180702111659.25570-1-yaojun8558363@gmail.com>
 <20180702111659.25570-6-yaojun8558363@gmail.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <daaef987-6fff-3720-9881-97fe06b2ee88@arm.com>
Date:   Wed, 11 Jul 2018 17:15:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180702111659.25570-6-yaojun8558363@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yun,

On 02/07/18 12:16, Jun Yao wrote:
> Move {idmap_pg_dir, swapper_pg_dir} to .rodata section and

> populate swapper_pg_dir by fixmap.

(any chance you could split the fixmap bits into a separate patch so that the
rodata move comes last? This will make review and bisecting any problems easier.)


> diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
> index 2e05bcd944c8..a0ce7d0f81c5 100644
> --- a/arch/arm64/include/asm/pgalloc.h
> +++ b/arch/arm64/include/asm/pgalloc.h
> @@ -29,6 +29,23 @@
>  #define PGALLOC_GFP	(GFP_KERNEL | __GFP_ZERO)
>  #define PGD_SIZE	(PTRS_PER_PGD * sizeof(pgd_t))
>  
> +static inline int in_swapper_dir(void *addr)
> +{
> +	if ((unsigned long)addr >= (unsigned long)swapper_pg_dir &&
> +		(unsigned long)addr < (unsigned long)swapper_pg_end) {
> +		return 1;
> +	}
> +	return 0;
> +}

Making this a bool and returning the condition feels more natural.

We know swapper_pg_dir and swapper_pg_end are both page aligned, if we can tell
the compiler, it can generate better code. Something like:
| return ((long)addr & PAGE_MASK) == ((long)swapper_pg_dir & PAGE_MASK);

(if you agree its the same)


> +static inline void *swapper_mirror_addr(void *start, void *addr)
> +{
> +	unsigned long offset;
> +
> +	offset = (unsigned long)addr - (unsigned long)swapper_pg_dir;
> +	return start + offset;
> +}

I think you've re-invented __set_fixmap_offset, ...


>  #if CONFIG_PGTABLE_LEVELS > 2
>  
>  static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
> @@ -49,6 +66,17 @@ static inline void __pud_populate(pud_t *pudp, phys_addr_t pmdp, pudval_t prot)
>  
>  static inline void pud_populate(struct mm_struct *mm, pud_t *pudp, pmd_t *pmdp)
>  {
> +#ifdef __PAGETABLE_PUD_FOLDED
> +	if ((mm == &init_mm) && in_swapper_dir(pudp)) {
> +		pud_t *pud;

> +		pud = pud_set_fixmap(__pa_symbol(swapper_pg_dir));
> +		pud = (pud_t *)swapper_mirror_addr(pud, pudp);

This is calculating the corresponding pudp in the fixmap mapping of swapper.
If you give pud_set_fixmap() the physical address of the original pudp it will
calculate this for you.

I think this could fold down to something like:
|	pud_t *fixmap_pudp = pud_set_fixmap(__kimg_to_phys((long)pudp));

(please check I've dug through all that properly!)


On a wider issue: these p?d_populate() helpers only put table entries down,
these are used by vmalloc(). Unfortunately ioremap() will try to add block
mappings if it can, which don't use this helper. (bits and pieces for testing
this in [0]). Systems with nvdimms probably do this all the time...

We could add the same in_swapper_dir() tests and fixmap operations to
p?d_set_huge(), but it may be worth pushing them down to set_p?d(), which is
where all these paths join up. This would also cover pgd_clear(), which is
called via p?d_none_or_clear_bad().


I think we should do something about concurrent calls. Today that ~should work,
providing they aren't modifying the same locations, but with these changes both
CPUs would try and clear_fixmap()/tlbi the range from underneath each other.

The p?d_alloc() helpers take the mm lock around the p?d_populate() calls, but it
doesn't look like there is any other lock for the ioremap work calling
p?d_set_huge(), so we will need one of our own, especially for
p?d_none_or_clear_bad().


> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 3b408f21fe2e..b479d1b997c2 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -475,6 +475,9 @@ static inline phys_addr_t pmd_page_paddr(pmd_t pmd)
>   */
>  #define mk_pte(page,prot)	pfn_pte(page_to_pfn(page),prot)
>  
> +#define pmd_set_fixmap(addr)		((pmd_t *)set_fixmap_offset(FIX_PMD, addr))
> +#define pmd_clear_fixmap()		clear_fixmap(FIX_PMD)
> +

Ooer, we shouldn't need to move these around. If they're wrong, it should be the
subject of a separate patch, but its more likely we're using the wrong ones...


> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index d69e11ad92e3..beff018bf0f9 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -223,21 +223,25 @@ SECTIONS
>  	BSS_SECTION(0, 0, 0)
>  
>  	. = ALIGN(PAGE_SIZE);
> -	idmap_pg_dir = .;
> -	. += IDMAP_DIR_SIZE;
> +
> +	.rodata : {

Now I'm confused. I thought this named section was output by RO_DATA() further
up, just before __init_begin, which mark_rodata_ro() uses as its end marker.
I thought named sections had to be unique.

Are we expecting the linker to realise we want it to move this stuff up there,
and not move the read-only contents down here, outside the markers. (maybe the
linker always takes the first definition?)

Can we move these to sit near INIT_DIR/INIT_PG_TABLES as a macro, which we then
put after NOTES? (something like KERNEL_PG_TABLES?)


Thanks!

James



[0] abuse kdump to give us a 1G naturally aligned block of memory that is
missing from the linear map. We can memremap() this, and get a top-level block
entry on !4-level systems. Do this late enough  Add 'crashdump=1G' to your cmdline
----------------------%<----------------------
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 325cfb3b858a..081d4e216067 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -20,6 +20,7 @@
 #include <linux/kernel.h>
 #include <linux/export.h>
 #include <linux/errno.h>
+#include <linux/io.h>
 #include <linux/swap.h>
 #include <linux/init.h>
 #include <linux/bootmem.h>
@@ -104,7 +105,7 @@ static void __init reserve_crashkernel(void)
        if (crash_base == 0) {
                /* Current arm64 boot protocol requires 2MB alignment */
                crash_base = memblock_find_in_range(0, ARCH_LOW_ADDRESS_LIMIT,
-                               crash_size, SZ_2M);
+                               crash_size, SZ_1G);
                if (crash_base == 0) {
                        pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
                                crash_size);
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 955b40efcc0c..f8cca5adb0c8 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -485,12 +485,22 @@ static void __init map_mem(pgd_t *pgdp)
                __map_memblock(pgdp, crashk_res.start, crashk_res.end + 1,
                               PAGE_KERNEL,
                               NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
-               memblock_clear_nomap(crashk_res.start,
-                                    resource_size(&crashk_res));
        }
 #endif
 }

+#ifdef CONFIG_KEXEC_CORE
+static void hack__remap_kdump_region(void)
+{
+       size_t size = crashk_res.end - crashk_res.start;
+
+       if (!crashk_res.end)
+               return;
+
+       memremap((unsigned long)crashk_res.start, size, MEMREMAP_WB);
+}
+#endif
+ void mark_rodata_ro(void)
 {
        unsigned long section_size;
@@ -504,6 +514,10 @@ void mark_rodata_ro(void)
                            section_size, PAGE_KERNEL_RO);

        debug_checkwx();
+
+#ifdef CONFIG_KEXEC_CORE
+       hack__remap_kdump_region();
+#endif
 }

 static void __init map_kernel_segment(pgd_t *pgdp, void *va_start, void *va_end,
----------------------%<----------------------
