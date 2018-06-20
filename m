Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68656C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD8A20871
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZTaSZAJe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AD8A20871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753709AbeFTKJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 06:09:53 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:46097 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751166AbeFTKJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 06:09:51 -0400
Received: by mail-io0-f195.google.com with SMTP id d22-v6so2934048iof.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 03:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CmrbHURGnnXeauZ9zukpkyJygwtSiKTdGTSDKox29gc=;
        b=ZTaSZAJePqDT5zz5hQ4jx+MQlMrW9KFdticShUk5zh592tzY5Hsi5Jwpnbs8mgUIcO
         DDVBuHdbrfty6WpY9ahq1BHhSuDQAwiySnjF6Tsx/mNV8Foh64FZRjWhuicH6sGhdbnf
         z2GkEI1GdvqwHmE+HXLdscNHWuwqTC2SYJ1Es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CmrbHURGnnXeauZ9zukpkyJygwtSiKTdGTSDKox29gc=;
        b=EdZA02GsGkCTT5NY7+9cfnzV72NUkOGFRyCTF0S2BSCUbX013usl9DPYhn2a1c59Td
         yxAyJuQct9NKBoC/tkGY2wh40STdM3kP/m3CxlHeAFSv20XC3fdNX+c/ZESQLSnmkk/p
         PTAT63wafXZDYJSBnEO8uwiF8kUAL+m1jarRh3bd1as5gpFaFnTDuyoC+JRrrcNYPyoB
         SJi8skJxwdYRvjqCUC5Fjqr53qAjF7hY3hOayV6suLr1kplYl/Pgsk0PFHr+atCTDnv2
         sS9RUl6JIxzSOj1oxzoJxXalhvRN8B1FhURcMEUCn7oAMGDPIo4dFIkdbqwDyOVKqZkj
         9WbQ==
X-Gm-Message-State: APt69E03yQtSEnwsQahFa32Eub28nCHfLGd/CazOIFpvqMfNiTuEYzqB
        7xe/P3n8DjvMYhSChffYCL8ei+TNy+isLsXt6f3hfA==
X-Google-Smtp-Source: ADUXVKK/qHEdrBCSipcSheGuq9nXw7ddaKeziH6J/4wvzdivbej5YkFMbqhow+WKLSuO55Dm2SS2r2wD0LvG/YU5kVI=
X-Received: by 2002:a6b:dd0b:: with SMTP id f11-v6mr16276180ioc.173.1529489390476;
 Wed, 20 Jun 2018 03:09:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bbc7:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 03:09:49
 -0700 (PDT)
In-Reply-To: <20180620085755.20045-2-yaojun8558363@gmail.com>
References: <20180620085755.20045-1-yaojun8558363@gmail.com> <20180620085755.20045-2-yaojun8558363@gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 20 Jun 2018 12:09:49 +0200
Message-ID: <CAKv+Gu8_=uTJFDXr0GpGMc=9WZ9tbz305CE6i=qbnqRB=suRVA@mail.gmail.com>
Subject: Re: [PATCH 1/1] arm64/mm: move {idmap_pg_dir,tramp_pg_dir,swapper_pg_dir}
 to .rodata section
To:     Jun Yao <yaojun8558363@gmail.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        James Morse <james.morse@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 June 2018 at 10:57, Jun Yao <yaojun8558363@gmail.com> wrote:
> Move {idmap_pg_dir,tramp_pg_dir,swapper_pg_dir} to .rodata
> section. And update the swapper_pg_dir by fixmap.
>

I think we may be able to get away with not mapping idmap_pg_dir and
tramp_pg_dir at all.

As for swapper_pg_dir, it would indeed be nice if we could keep those
mappings read-only most of the time, but I'm not sure how useful this
is if we apply it to the root level only.

> Signed-off-by: Jun Yao <yaojun8558363@gmail.com>
> ---
>  arch/arm64/include/asm/pgalloc.h | 19 +++++++++++++++++++
>  arch/arm64/kernel/vmlinux.lds.S  | 32 ++++++++++++++++++--------------
>  arch/arm64/mm/mmu.c              | 23 +++++++++++++++++++----
>  3 files changed, 56 insertions(+), 18 deletions(-)
>
> diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
> index 2e05bcd944c8..cc96a7e6957d 100644
> --- a/arch/arm64/include/asm/pgalloc.h
> +++ b/arch/arm64/include/asm/pgalloc.h
> @@ -29,6 +29,10 @@
>  #define PGALLOC_GFP    (GFP_KERNEL | __GFP_ZERO)
>  #define PGD_SIZE       (PTRS_PER_PGD * sizeof(pgd_t))
>
> +#if CONFIG_STRICT_KERNEL_RWX
> +extern spinlock_t pgdir_lock;
> +#endif
> +
>  #if CONFIG_PGTABLE_LEVELS > 2
>
>  static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
> @@ -78,6 +82,21 @@ static inline void __pgd_populate(pgd_t *pgdp, phys_addr_t pudp, pgdval_t prot)
>
>  static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgdp, pud_t *pudp)
>  {
> +#if CONFIG_STRICT_KERNEL_RWX
> +       if (mm == &init_mm) {
> +               pgd_t *pgd;
> +
> +               spin_lock(&pgdir_lock);
> +               pgd = pgd_set_fixmap(__pa_symbol(swapper_pg_dir));
> +
> +               pgd = (pgd_t *)((unsigned long)pgd + pgdp - swapper_pg_dir);
> +               __pgd_populate(pgdp, __pa(pudp), PUD_TYPE_TABLE);
> +

This only works for 4-level paging, but we support 2 and 3 level paging as well.

> +               pgd_clear_fixmap();
> +               spin_unlock(&pgdir_lock);
> +               return;
> +       }
> +#endif
>         __pgd_populate(pgdp, __pa(pudp), PUD_TYPE_TABLE);
>  }
>  #else
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 605d1b60469c..86532c57206a 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -216,21 +216,25 @@ SECTIONS
>         BSS_SECTION(0, 0, 0)
>
>         . = ALIGN(PAGE_SIZE);
> -       idmap_pg_dir = .;
> -       . += IDMAP_DIR_SIZE;
>
> -#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
> -       tramp_pg_dir = .;
> -       . += PAGE_SIZE;
> -#endif
> -
> -#ifdef CONFIG_ARM64_SW_TTBR0_PAN
> -       reserved_ttbr0 = .;
> -       . += RESERVED_TTBR0_SIZE;
> -#endif
> -       swapper_pg_dir = .;
> -       . += SWAPPER_DIR_SIZE;
> -       swapper_pg_end = .;
> +       .rodata : {
> +               . = ALIGN(PAGE_SIZE);
> +               idmap_pg_dir = .;
> +               . += IDMAP_DIR_SIZE;
> +
> +               #ifdef CONFIG_UNMAP_KERNEL_AT_EL0

CPP directives should start in the first column

> +               tramp_pg_dir = .;
> +               . += PAGE_SIZE;
> +               #endif
> +
> +               #ifdef CONFIG_ARM64_SW_TTBR0_PAN
> +               reserved_ttbr0 = .;
> +               . += RESERVED_TTBR0_SIZE;
> +               #endif
> +               swapper_pg_dir = .;
> +               . += SWAPPER_DIR_SIZE;
> +               swapper_pg_end = .;
> +       }
>
>         __pecoff_data_size = ABSOLUTE(. - __initdata_begin);
>         _end = .;
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 2dbb2c9f1ec1..c1aa85a6ada5 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -66,6 +66,10 @@ static pte_t bm_pte[PTRS_PER_PTE] __page_aligned_bss;
>  static pmd_t bm_pmd[PTRS_PER_PMD] __page_aligned_bss __maybe_unused;
>  static pud_t bm_pud[PTRS_PER_PUD] __page_aligned_bss __maybe_unused;
>
> +#ifdef CONFIG_STRICT_KERNEL_RWX
> +DEFINE_SPINLOCK(pgdir_lock);
> +#endif
> +
>  pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
>                               unsigned long size, pgprot_t vma_prot)
>  {
> @@ -417,12 +421,22 @@ static void __init __map_memblock(pgd_t *pgdp, phys_addr_t start,
>
>  void __init mark_linear_text_alias_ro(void)
>  {
> +       unsigned long size;
> +
>         /*
>          * Remove the write permissions from the linear alias of .text/.rodata
> +        *
> +        * We free some pages in .rodata at paging_init(), which generates a
> +        * hole. And the hole splits .rodata into two pieces.
>          */
> +       size = (unsigned long)swapper_pg_dir + PAGE_SIZE - (unsigned long)_text;
>         update_mapping_prot(__pa_symbol(_text), (unsigned long)lm_alias(_text),
> -                           (unsigned long)__init_begin - (unsigned long)_text,
> -                           PAGE_KERNEL_RO);
> +                           size, PAGE_KERNEL_RO);
> +
> +       size = (unsigned long)__init_begin - (unsigned long)swapper_pg_end;
> +       update_mapping_prot(__pa_symbol(swapper_pg_end),
> +                           (unsigned long)lm_alias(swapper_pg_end),
> +                           size, PAGE_KERNEL_RO);

I don't think this is necessary. Even if some pages are freed, it
doesn't harm to keep a read-only alias of them here since the new
owner won't access them via this mapping anyway. So we can keep
.rodata as a single region.

>  }
>
>  static void __init map_mem(pgd_t *pgdp)
> @@ -587,8 +601,9 @@ static void __init map_kernel(pgd_t *pgdp)
>          */
>         map_kernel_segment(pgdp, _text, _etext, text_prot, &vmlinux_text, 0,
>                            VM_NO_GUARD);
> -       map_kernel_segment(pgdp, __start_rodata, __inittext_begin, PAGE_KERNEL,
> -                          &vmlinux_rodata, NO_CONT_MAPPINGS, VM_NO_GUARD);
> +       map_kernel_segment(pgdp, __start_rodata, __inittext_begin,
> +                          PAGE_KERNEL, &vmlinux_rodata,
> +                          NO_CONT_MAPPINGS | NO_BLOCK_MAPPINGS, VM_NO_GUARD);

Given the above, you should be able to drop this as well.

>         map_kernel_segment(pgdp, __inittext_begin, __inittext_end, text_prot,
>                            &vmlinux_inittext, 0, VM_NO_GUARD);
>         map_kernel_segment(pgdp, __initdata_begin, __initdata_end, PAGE_KERNEL,
> --
> 2.17.1
>
