Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A04C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 899092145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:54:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 899092145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732851AbeIXW53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 18:57:29 -0400
Received: from foss.arm.com ([217.140.101.70]:38802 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728436AbeIXW53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 18:57:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C14380D;
        Mon, 24 Sep 2018 09:54:25 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CDE1D3F5BD;
        Mon, 24 Sep 2018 09:54:23 -0700 (PDT)
Date:   Mon, 24 Sep 2018 17:54:21 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Jun Yao <yaojun8558363@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, james.morse@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/6] arm64/mm: Populate the swapper_pg_dir by fixmap.
Message-ID: <20180924165421.77bjq5m32h5w7ffh@lakrids.cambridge.arm.com>
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

So that we can get consistent build coverage, could we make this:

	if (__is_defined(__PAGETABLE_PMD_FOLDED) && in_swapper_pgdir(pmdp)) {
		set_swapper_pgd((pgd_t *)pmdp, __pgd(pmd_val(pmd)));
		return;
	}

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

... and likewise:

	if (__is_enabled(__PAGETABLE_PUD_FOLDED) && in_swapper_pgdir(pudp)) {
		set_swapper_pgd((pgd_t *)pudp, __pgd(pud_val(pud)));
		return;
	}

Thanks,
Mark.
