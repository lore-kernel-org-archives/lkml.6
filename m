Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF1F5C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7143423EF1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:58:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7143423EF1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753684AbeGFI6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 04:58:22 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:32836 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753075AbeGFI6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 04:58:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A441ED1;
        Fri,  6 Jul 2018 01:58:20 -0700 (PDT)
Received: from [10.1.206.34] (melchizedek.cambridge.arm.com [10.1.206.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD5F63F2EA;
        Fri,  6 Jul 2018 01:58:17 -0700 (PDT)
Subject: Re: [PATCH v3 3/5] arm64/mm: Create initial page tables in
 init_pg_dir
To:     Jun Yao <yaojun8558363@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com,
        suzuki.poulose@arm.com, linux-kernel@vger.kernel.org
References: <20180702111659.25570-1-yaojun8558363@gmail.com>
 <20180702111659.25570-4-yaojun8558363@gmail.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <3977afaa-63ae-e390-7660-4d25146140b8@arm.com>
Date:   Fri, 6 Jul 2018 09:58:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180702111659.25570-4-yaojun8558363@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jun,

On 02/07/18 12:16, Jun Yao wrote:
> Create initial page tables in init_pg_dir and then create final
> page tables in swapper_pg_dir directly.

This is what the patch does, but doesn't preserve the why for the git-log. Could
you expand it to describe why we're doing this.


The series so far fails to boot from me. This is because the kaslr code tries to
read the kaslr-seed from the DT, via the fixmap. To do this, it needs the fixmap
tables installed, which early_fixmap_init() does.

early_fixmap_init() calls pgd_offset_k(), which assumes init_mm.pgd is in use,
so we hit a BUG_ON() when trying to setup the fixmap because we added the tables
to the wrong page tables.

If you enable 'CONFIG_RANDOMIZE_BASE', even without EFI you should see the same
thing happen.


I think we should move this hunk:
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 30ad2f085d1f..b065c08d4008 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -249,6 +249,7 @@ void __init setup_arch(char **cmdline_p)
>  	init_mm.end_code   = (unsigned long) _etext;
>  	init_mm.end_data   = (unsigned long) _edata;
>  	init_mm.brk	   = (unsigned long) _end;
> +	init_mm.pgd	   = init_pg_dir;
>
>  	*cmdline_p = boot_command_line;
>

into early_fixmap_init(), which is the first thing setup_arch() calls.
Something like [0] fixes it.

This looks to be the only thing that goes near init_mm.pgd before paging_init().


> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 7c4c8f318ba9..3b408f21fe2e 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -718,6 +718,8 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
>  }
>  #endif
>  
> +extern pgd_t init_pg_dir[PTRS_PER_PGD] __section(.init.data);
> +extern pgd_t init_pg_end[] __section(.init.data);

normally we'd spell this '__initdata', but if we move them out of the
'.init.data' section we shouldn't, otherwise the extern definition doesn't match
where the symbol appears. (Looks like I was wrong to think that tools like
sparse pick this up, that's just the __iomem/__user stuff.)


> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 2dbb2c9f1ec1..a7ab0010ff80 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -628,26 +628,10 @@ static void __init map_kernel(pgd_t *pgdp)
>   */
>  void __init paging_init(void)
>  {
> -	phys_addr_t pgd_phys = early_pgtable_alloc();
> -	pgd_t *pgdp = pgd_set_fixmap(pgd_phys);
> -
> -	map_kernel(pgdp);
> -	map_mem(pgdp);
> -
> -	/*
> -	 * We want to reuse the original swapper_pg_dir so we don't have to
> -	 * communicate the new address to non-coherent secondaries in
> -	 * secondary_entry, and so cpu_switch_mm can generate the address with
> -	 * adrp+add rather than a load from some global variable.
> -	 *
> -	 * To do this we need to go via a temporary pgd.
> -	 */
> -	cpu_replace_ttbr1(__va(pgd_phys));
> -	memcpy(swapper_pg_dir, pgdp, PGD_SIZE);
> -	cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
> -
> -	pgd_clear_fixmap();
> -	memblock_free(pgd_phys, PAGE_SIZE);
> +	map_kernel(swapper_pg_dir);
> +	map_mem(swapper_pg_dir);

> +	cpu_replace_ttbr1(swapper_pg_dir);

The lm_alias() here is important: cpu_replace_ttbr1() calls virt_to_phys() on
its argument, virt_to_phys() is only intended for addresses in the linear-map
region of the VA space, as it works by doing some arithmetic with the address.

swapper_pg_dir is the name of the kernel symbol, so its address will be in the
kernel-text region of the VA space.

Today virt_to_phys() catches this happening and fixes it, CONFIG_DEBUG_VIRTUAL
will give you a warning, at some point virt_to_phys()'s safety net will go-away.

The original call that did this was wrapped in lm_alias(), which gives you the
linear-map address of a symbol in the kernel-text.


Thanks,

James


[0] make sure fixmap tables go in the init page tables
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 117d080639b3..e097c78a66f8 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -770,6 +771,13 @@ void __init early_fixmap_init(void)
        pmd_t *pmdp;
        unsigned long addr = FIXADDR_START;

+       /*
+        * During early setup we use init_pg_dir, update init_mm so its
+        * implicit use by pgd_offset_k() gets the live page tables.
+        * swapper_pg_dir is restored by paging_init().
+        */
+       init_mm.pgd = init_pg_dir;
+
        pgdp = pgd_offset_k(addr);
        pgd = READ_ONCE(*pgdp);
        if (CONFIG_PGTABLE_LEVELS > 3 &&



