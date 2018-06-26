Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C1DC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 11:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B2D2269B8
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 11:21:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B2D2269B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934541AbeFZLVk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 07:21:40 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43990 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932544AbeFZLVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 07:21:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A459980D;
        Tue, 26 Jun 2018 04:21:38 -0700 (PDT)
Received: from [10.1.206.34] (melchizedek.cambridge.arm.com [10.1.206.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 67AD53F5C0;
        Tue, 26 Jun 2018 04:21:37 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] arm64/mm: Move {tramp_pg_dir, swapper_pg_dir} to
 .rodata section
To:     Jun Yao <yaojun8558363@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
References: <20180625113921.21854-1-yaojun8558363@gmail.com>
 <20180625113921.21854-3-yaojun8558363@gmail.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <f9dfd840-1d90-96f9-2915-7e1bc4bd43a4@arm.com>
Date:   Tue, 26 Jun 2018 12:21:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180625113921.21854-3-yaojun8558363@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jun,

On 25/06/18 12:39, Jun Yao wrote:
> When CONFIG_ARM64_VA_BITS_36/CONFIG_ARM64_VA_BITS_39/
> CONFIG_ARM64_VA_BITS_42 are selected, a block-mapping can be
> written to swapper_pg_dir. To defend 'KSMA', we move swapper_pg_dir
> to .rodata section when these configurations are selected. At the
> same time, we update swapper_pg_dir by fixmap.

I don't think we should consider individual MMU configurations. KSMA is the
motivation for making swapper_pg_dir read-only.
When making swapper_pg_dir read-only it should work in the same way for all
configurations as its simpler.


> diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
> index 62908eeedcdc..881784b43965 100644
> --- a/arch/arm64/include/asm/fixmap.h
> +++ b/arch/arm64/include/asm/fixmap.h
> @@ -83,6 +83,7 @@ enum fixed_addresses {
>  	FIX_PTE,
>  	FIX_PMD,
>  	FIX_PUD,
> +	FIX_SWAPPER,

Please leave this as FIX_PGD that you removed in the previous patch. Depending
on the folding pmd/pud can be used as the top level. If we always use the fixmap
entry that goes with the name, its clear how these operate.


>  	__end_of_fixed_addresses
>  };
> diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
> index 2e05bcd944c8..62512ad9c310 100644
> --- a/arch/arm64/include/asm/pgalloc.h
> +++ b/arch/arm64/include/asm/pgalloc.h

How come you don't touch pgd_populate()? Surely with a 4-level configuration we
may need to put a new pud-table in when we use a fresh chunk of vmalloc space...

(ah, this is because you are conditionally doing all this on configurations
where the MMU has top-level block mappings. I think this is unnecessarily
complicated, we should just do it all the time)


> @@ -49,6 +49,22 @@ static inline void __pud_populate(pud_t *pudp, phys_addr_t pmdp, pudval_t prot)
>  
>  static inline void pud_populate(struct mm_struct *mm, pud_t *pudp, pmd_t *pmdp)
>  {
> +#ifdef CONFIG_ARM64_VA_BITS_39

Please make this depend on the number of levels not the VA size. We also have
3-level page tables for 64K with 48bit VA space, and 16K with 47bit VA space.

I'd prefer some "if (CONFIG_PGTABLE_LEVELS == 3)" style check, as that way the
compiler will always parse the code that is currently hidden behind #ifdefs.

We can avoid use of fixmap entries for subsequent levels by making the check
something like:
| if (CONFIG_PGTABLE_LEVELS == 3 && magic_helper(pud) == swapper_pg_dir)


> +	if (mm == &init_mm) {
> +		pud_t *pud;
> +		unsigned long offset;
> +		extern spinlock_t pgdir_lock;
> +
> +		spin_lock(&pgdir_lock);
> +		pud = (pud_t *)swapper_set_fixmap();

Can't we use pud_set_fixmap for pud levels?

Do we need an extra spinlock?, won't init_mm.page_table_lock always be held?
(we can put a lockdep_assert_held() in here to find cases that aren't).


> +		offset = (unsigned long)pudp - (unsigned long)swapper_pg_dir;
> +		pud = (pud_t *)((unsigned long)pud + offset);

It feels like there should be a helper for this.

I'm not comfortable assuming mm=init_mm means we are actually modifying
swapper_pg_dir. Hibernate does this on the grounds that the tables it generates
will be used as the kernel's mm when it starts restoring. This field wasn't used
before, so it wasn't clear what the field was for. I'm sure we will find
something else doing this...

Could we test that the provided pudp is within swapper_pg_dir before invoking
the fixmap path.


> +		__pud_populate(pud, __pa(pmdp), PMD_TYPE_TABLE);
> +		swapper_clear_fixmap();
> +		spin_unlock(&pgdir_lock);
> +		return;
> +	}
> +#endif
>  	__pud_populate(pudp, __pa(pmdp), PMD_TYPE_TABLE);
>  }
>  #else


> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 9677deb7b6c7..9db187024b44 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S

(Changes here are cleanup, they should be in a separate patch)


> @@ -300,7 +300,7 @@ __create_page_tables:
>  	 * dirty cache lines being evicted.
>  	 */
>  	adrp	x0, idmap_pg_dir
> -	adrp	x1, swapper_pg_end
> +	adrp	x1, idmap_pg_end
>  	sub	x1, x1, x0
>  	bl	__inval_dcache_area

As we no longer modify swapper_pg_dir with the MMU disabled I think this is safe.


> @@ -313,7 +313,7 @@ __create_page_tables:
>  	 * Clear the idmap and init page tables.
>  	 */
>  	adrp	x0, idmap_pg_dir
> -	adrp	x1, swapper_pg_end
> +	adrp	x1, idmap_pg_end
>  	sub	x1, x1, x0
>  	clear_pages x0, x1

With the current placement of swapper_pg_dir after the BSS we rely on this to
zero that memory. It may have junk left over from the boot loader as this is the
area where the kernel's memory-footprint is bigger than the Image file.

Your vmlinux.lds.S changes below conditionally move swapper_pg_dir around.
Sometimes you need this, sometimes you don't.

Please always keep these pgd in the read-only section. I think we should keep
the page-zeroing as a sanity check, we only do it once during boot, and
corruption here isn't something we would be able to debug easily.


> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index b0e4255fcba4..db72c4680f1d 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -219,6 +219,28 @@ SECTIONS
>  	. = ALIGN(PAGE_SIZE);
>  	idmap_pg_dir = .;
>  	. += IDMAP_DIR_SIZE;
> +	idmap_pg_end = .;
> +
> +#if defined(CONFIG_ARM64_VA_BITS_39) || \
> +	defined(CONFIG_ARM64_VA_BITS_36) || \
> +	defined(CONFIG_ARM64_VA_BITS_42)

I think we should always do this read-only-swapper, even if there aren't any
top-level block-mappings. The code will be much more maintainable this way.


> +	.rodata : {
> +#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
> +		. = ALIGN(PAGE_SIZE);
> +		tramp_pg_dir = .;
> +		. += PAGE_SIZE;
> +#endif
> +
> +#ifdef CONFIG_ARM64_SW_TTBR0_PAN
> +		reserved_ttbr0 = .;
> +		. += RESERVED_TTBR0_SIZE;
> +#endif
> +		swapper_pg_dir = .;
> +		. += PAGE_SIZE;
> +		swapper_pg_end = .;
> +	}
> +
> +#else
>  
>  #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
>  	tramp_pg_dir = .;
> @@ -232,6 +254,7 @@ SECTIONS
>  	swapper_pg_dir = .;
>  	. += PAGE_SIZE;
>  	swapper_pg_end = .;
> +#endif



Thanks,

James
