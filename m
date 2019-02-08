Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A908C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B11120844
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="ATqiyCLs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbfBHQSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 11:18:24 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40691 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbfBHQSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 11:18:23 -0500
Received: by mail-pg1-f195.google.com with SMTP id z10so1768967pgp.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 08:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=rwttkLcB0E6Lz2B+tgr9+cijqY8fQQn5nOYWb3x5YWA=;
        b=ATqiyCLsID2FI6vHntKHhBzn+aar81HJ9Tv8JjbXVpIV9uG//cqIwTvcM2FbgcnACX
         f0uAkfpAXGLXmv0GAK9EfWCCUKhkuAfZdar46KltKoZijBTEMC1SXKiEQ6vroIqDVuU0
         YrlJ67WhEOIwLUUUeDD4/D/Sgjea59Kh+p4Z0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=rwttkLcB0E6Lz2B+tgr9+cijqY8fQQn5nOYWb3x5YWA=;
        b=GbWstD0zp/OV6AnuF407+8nH0b+AIOjLMMHgpN6n7rfDMOmZ7P94e3xQa4GzOLf3Jy
         ayZQPjlD5UrjLDAKizGLwSddIhtPpNKOE3OGMrVVj5Epsxjh6Hbm89p6g0oVLZ2UDdZM
         4OQn8qZ/+2c6uBQYfFW+LtuNw99O8P5qlenROiQhshVbG1xcLbNslm0FdPLM4+26+yOK
         eSqggTtwQW/uae+2yGOU54TXNHkYgaxcH/g2v3CXtcesRSDXmwCwZ6XlF6qeJjhJ+cOt
         zVUCNAsgyB4AdtTUt7qujn5WmGIGYXJlJNTkGdFP5S0xCLxgpWC+42R8CNoTXoELVJic
         sOkg==
X-Gm-Message-State: AHQUAuZvNUwwDtoEFtylcor2Lzw+B5311rAw6eg61sLwe6YXGnNqLrRn
        Z2aTAE1vc5qm5/4ZkOyHZcBFpg==
X-Google-Smtp-Source: AHgI3IYFm9qTo0YgHqGZSOhIItRjWouKqbzosTgd/PKnqIu7ryPVhhmeCqyP/F/uRP5+deEAfJDA9Q==
X-Received: by 2002:aa7:8d51:: with SMTP id s17mr8824013pfe.16.1549642702499;
        Fri, 08 Feb 2019 08:18:22 -0800 (PST)
Received: from localhost (124-171-150-195.dyn.iinet.net.au. [124.171.150.195])
        by smtp.gmail.com with ESMTPSA id s71sm3704832pfa.122.2019.02.08.08.18.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Feb 2019 08:18:20 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH v4 3/3] powerpc/32: Add KASAN support
In-Reply-To: <1f5629e03181d0e30efc603f00dad78912991a45.1548166824.git.christophe.leroy@c-s.fr>
References: <cover.1548166824.git.christophe.leroy@c-s.fr> <1f5629e03181d0e30efc603f00dad78912991a45.1548166824.git.christophe.leroy@c-s.fr>
Date:   Sat, 09 Feb 2019 03:18:17 +1100
Message-ID: <87ef8i45km.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

I've been attempting to port this to 64-bit Book3e nohash (e6500),
although I think I've ended up with an approach more similar to Aneesh's
much earlier (2015) series for book3s.

Part of this is just due to the changes between 32 and 64 bits - we need
to hack around the discontiguous mappings - but one thing that I'm
particularly puzzled by is what the kasan_early_init is supposed to do.

> +void __init kasan_early_init(void)
> +{
> +	unsigned long addr = KASAN_SHADOW_START;
> +	unsigned long end = KASAN_SHADOW_END;
> +	unsigned long next;
> +	pmd_t *pmd = pmd_offset(pud_offset(pgd_offset_k(addr), addr), addr);
> +	int i;
> +	phys_addr_t pa = __pa(kasan_early_shadow_page);
> +
> +	BUILD_BUG_ON(KASAN_SHADOW_START & ~PGDIR_MASK);
> +
> +	if (early_mmu_has_feature(MMU_FTR_HPTE_TABLE))
> +		panic("KASAN not supported with Hash MMU\n");
> +
> +	for (i = 0; i < PTRS_PER_PTE; i++)
> +		__set_pte_at(&init_mm, (unsigned long)kasan_early_shadow_page,
> +			     kasan_early_shadow_pte + i,
> +			     pfn_pte(PHYS_PFN(pa), PAGE_KERNEL_RO), 0);
> +
> +	do {
> +		next = pgd_addr_end(addr, end);
> +		pmd_populate_kernel(&init_mm, pmd, kasan_early_shadow_pte);
> +	} while (pmd++, addr = next, addr != end);
> +}

As far as I can tell it's mapping the early shadow page, read-only, over
the KASAN_SHADOW_START->KASAN_SHADOW_END range, and it's using the early
shadow PTE array from the generic code.

I haven't been able to find an answer to why this is in the docs, so I
was wondering if you or anyone else could explain the early part of
kasan init a bit better.

At the moment, I don't do any early init, and like Aneesh's series for
book3s, I end up needing a special flag to disable kasan until after
kasan_init. Also, as with Balbir's seris for Radix, some tests didn't
fire, although my missing tests are a superset of his. I suspect the
early init has something to do with these...?

(I'm happy to collate answers into a patch to the docs, btw!)

In the long term I hope to revive Aneesh's and Balbir's series for hash
and radix as well.

Regards,
Daniel

> +
> +static void __init kasan_init_region(struct memblock_region *reg)
> +{
> +	void *start = __va(reg->base);
> +	void *end = __va(reg->base + reg->size);
> +	unsigned long k_start, k_end, k_cur, k_next;
> +	pmd_t *pmd;
> +
> +	if (start >= end)
> +		return;
> +
> +	k_start = (unsigned long)kasan_mem_to_shadow(start);
> +	k_end = (unsigned long)kasan_mem_to_shadow(end);
> +	pmd = pmd_offset(pud_offset(pgd_offset_k(k_start), k_start), k_start);
> +
> +	for (k_cur = k_start; k_cur != k_end; k_cur = k_next, pmd++) {
> +		k_next = pgd_addr_end(k_cur, k_end);
> +		if ((void *)pmd_page_vaddr(*pmd) == kasan_early_shadow_pte) {
> +			pte_t *new = pte_alloc_one_kernel(&init_mm);
> +
> +			if (!new)
> +				panic("kasan: pte_alloc_one_kernel() failed");
> +			memcpy(new, kasan_early_shadow_pte, PTE_TABLE_SIZE);
> +			pmd_populate_kernel(&init_mm, pmd, new);
> +		}
> +	};
> +
> +	for (k_cur = k_start; k_cur < k_end; k_cur += PAGE_SIZE) {
> +		void *va = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
> +		pte_t pte = pfn_pte(PHYS_PFN(__pa(va)), PAGE_KERNEL);
> +
> +		if (!va)
> +			panic("kasan: memblock_alloc() failed");
> +		pmd = pmd_offset(pud_offset(pgd_offset_k(k_cur), k_cur), k_cur);
> +		pte_update(pte_offset_kernel(pmd, k_cur), ~0, pte_val(pte));
> +	}
> +	flush_tlb_kernel_range(k_start, k_end);
> +}
> +
> +void __init kasan_init(void)
> +{
> +	struct memblock_region *reg;
> +
> +	for_each_memblock(memory, reg)
> +		kasan_init_region(reg);
> +
> +	kasan_init_tags();
> +
> +	/* At this point kasan is fully initialized. Enable error messages */
> +	init_task.kasan_depth = 0;
> +	pr_info("KASAN init done\n");
> +}
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index 33cc6f676fa6..ae7db88b72d6 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -369,6 +369,10 @@ void __init mem_init(void)
>  	pr_info("  * 0x%08lx..0x%08lx  : highmem PTEs\n",
>  		PKMAP_BASE, PKMAP_ADDR(LAST_PKMAP));
>  #endif /* CONFIG_HIGHMEM */
> +#ifdef CONFIG_KASAN
> +	pr_info("  * 0x%08lx..0x%08lx  : kasan shadow mem\n",
> +		KASAN_SHADOW_START, KASAN_SHADOW_END);
> +#endif
>  #ifdef CONFIG_NOT_COHERENT_CACHE
>  	pr_info("  * 0x%08lx..0x%08lx  : consistent mem\n",
>  		IOREMAP_TOP, IOREMAP_TOP + CONFIG_CONSISTENT_SIZE);
> -- 
> 2.13.3
