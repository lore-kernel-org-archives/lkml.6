Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A830ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 023CD2087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:36:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 023CD2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730564AbeIXWjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 18:39:23 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38466 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728137AbeIXWjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 18:39:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46B1680D;
        Mon, 24 Sep 2018 09:36:23 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 14B013F5BD;
        Mon, 24 Sep 2018 09:36:21 -0700 (PDT)
Date:   Mon, 24 Sep 2018 17:36:19 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Jun Yao <yaojun8558363@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, james.morse@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/6] arm64/mm: Populate the swapper_pg_dir by fixmap.
Message-ID: <20180924163619.rx7bae67i5isq2fy@lakrids.cambridge.arm.com>
References: <20180917044333.30051-1-yaojun8558363@gmail.com>
 <20180917044333.30051-6-yaojun8558363@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917044333.30051-6-yaojun8558363@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 12:43:32PM +0800, Jun Yao wrote:
> Since we will move the swapper_pg_dir to rodata section, we need a
> way to update it. The fixmap can handle it. When the swapper_pg_dir
> needs to be updated, we map it dynamically. The map will be
> canceled after the update is complete. In this way, we can defend
> against KSMA(Kernel Space Mirror Attack).
> 
> Signed-off-by: Jun Yao <yaojun8558363@gmail.com>
> ---
>  arch/arm64/include/asm/pgtable.h | 38 ++++++++++++++++++++++++++------
>  arch/arm64/mm/mmu.c              | 25 +++++++++++++++++++--
>  2 files changed, 54 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index b11d6fc62a62..9e643fc2453d 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -429,8 +429,29 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
>  				 PUD_TYPE_TABLE)
>  #endif
>  
> +extern pgd_t init_pg_dir[PTRS_PER_PGD];
> +extern pgd_t init_pg_end[];
> +extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
> +extern pgd_t swapper_pg_end[];
> +extern pgd_t idmap_pg_dir[PTRS_PER_PGD];
> +extern pgd_t tramp_pg_dir[PTRS_PER_PGD];
> +
> +extern void set_swapper_pgd(pgd_t *pgdp, pgd_t pgd);
> +
> +static inline bool in_swapper_pgdir(void *addr)
> +{
> +	return ((unsigned long)addr & PAGE_MASK) ==
> +		((unsigned long)swapper_pg_dir & PAGE_MASK);
> +}
> +
>  static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
>  {
> +#ifdef __PAGETABLE_PMD_FOLDED
> +	if (in_swapper_pgdir(pmdp)) {
> +		set_swapper_pgd((pgd_t *)pmdp, __pgd(pmd_val(pmd)));
> +		return;
> +	}
> +#endif
>  	WRITE_ONCE(*pmdp, pmd);
>  
>  	if (pmd_valid(pmd))
> @@ -484,6 +505,12 @@ static inline phys_addr_t pmd_page_paddr(pmd_t pmd)
>  
>  static inline void set_pud(pud_t *pudp, pud_t pud)
>  {
> +#ifdef __PAGETABLE_PUD_FOLDED
> +	if (in_swapper_pgdir(pudp)) {
> +		set_swapper_pgd((pgd_t *)pudp, __pgd(pud_val(pud)));
> +		return;
> +	}
> +#endif
>  	WRITE_ONCE(*pudp, pud);
>  
>  	if (pud_valid(pud))
> @@ -538,6 +565,10 @@ static inline phys_addr_t pud_page_paddr(pud_t pud)
>  
>  static inline void set_pgd(pgd_t *pgdp, pgd_t pgd)
>  {
> +	if (in_swapper_pgdir(pgdp)) {
> +		set_swapper_pgd(pgdp, pgd);
> +		return;
> +	}

It's somewhat frustrating that we have to duplicate this logic across
all of set_p{m,u,g}d(), rather than this living in set_pgd(), passing
the value up set_pmd() -> set_pud() -> set_pgd().

I see that the generic no-p{m,u}d headers force this structure, and I
haven't come up with anything better. :/

>  	WRITE_ONCE(*pgdp, pgd);
>  	dsb(ishst);
>  }
> @@ -718,13 +749,6 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
>  }
>  #endif
>  
> -extern pgd_t init_pg_dir[PTRS_PER_PGD];
> -extern pgd_t init_pg_end[];
> -extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
> -extern pgd_t swapper_pg_end[];
> -extern pgd_t idmap_pg_dir[PTRS_PER_PGD];
> -extern pgd_t tramp_pg_dir[PTRS_PER_PGD];
> -
>  /*
>   * Encode and decode a swap entry:
>   *	bits 0-1:	present (must be zero)
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 71532bcd76c1..a8a60927f716 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -67,6 +67,24 @@ static pte_t bm_pte[PTRS_PER_PTE] __page_aligned_bss;
>  static pmd_t bm_pmd[PTRS_PER_PMD] __page_aligned_bss __maybe_unused;
>  static pud_t bm_pud[PTRS_PER_PUD] __page_aligned_bss __maybe_unused;
>  
> +static DEFINE_SPINLOCK(swapper_pgdir_lock);
> +
> +void set_swapper_pgd(pgd_t *pgdp, pgd_t pgd)
> +{
> +	pgd_t *fixmap_pgdp;
> +
> +	spin_lock(&swapper_pgdir_lock);
> +	fixmap_pgdp = pgd_set_fixmap(__pa(pgdp));
> +	WRITE_ONCE(*fixmap_pgdp, pgd);
> +	/*
> +	 * We need dsb(ishst) here to ensure the page-table-walker sees
> +	 * our new entry before set_p?d() returns. The fixmap's
> +	 * flush_tlb_kernel_range() via clear_fixmap() does this for us.
> +	 */
> +	pgd_clear_fixmap();
> +	spin_unlock(&swapper_pgdir_lock);
> +}

I'm rather worried that we could deadlock here.

Are we certain we never poke the kernel page tables in IRQ context?

Otherwise, this looks fine to me.

Thanks,
Mark.

> +
>  pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
>  			      unsigned long size, pgprot_t vma_prot)
>  {
> @@ -629,8 +647,11 @@ static void __init map_kernel(pgd_t *pgdp)
>   */
>  void __init paging_init(void)
>  {
> -	map_kernel(swapper_pg_dir);
> -	map_mem(swapper_pg_dir);
> +	pgd_t *pgdp = pgd_set_fixmap(__pa_symbol(swapper_pg_dir));
> +
> +	map_kernel(pgdp);
> +	map_mem(pgdp);
> +	pgd_clear_fixmap();
>  	cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
>  	init_mm.pgd = swapper_pg_dir;
>  }
> -- 
> 2.17.1
> 
