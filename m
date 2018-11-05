Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D71C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 18:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C73A620866
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 18:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UPyIbRNN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C73A620866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387759AbeKFERs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 23:17:48 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:54922 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbeKFERs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 23:17:48 -0500
Received: by mail-it1-f194.google.com with SMTP id d6so14274259itl.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 10:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=x8pRAzEFwZAPSKWJ1IDVJgLPnIwxOwUQ+WkMHQMQ7PM=;
        b=UPyIbRNNKIWvkWeWr+ITQLfIBD+awCEopyEHSSqN9ktKbjj2HWANO5kIQv33LRaczl
         0CSRaxAy4Ro9x+6HyItdSRxx/K9p4YB9nkCTF0QYI7/bj2hLY8eXSYHoph+MTJm9ctMK
         pK4HNm+iJqf8UDzBw0c+8ZF+f7ljUC+vDMiN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=x8pRAzEFwZAPSKWJ1IDVJgLPnIwxOwUQ+WkMHQMQ7PM=;
        b=iiwV3GVoacfqcosKLdF/utzWe0IvGnq1p0rTrT2BGP9qrWUoNufxH8QLQ0Iwju0sHv
         aw4ujNSqAJmswmK2/92QRDj59FlCpnmli3eNqyt2NAHQiUiTYkTiOetGBvcK1wkPog1V
         U0CgP1qzTFLStEyA1h6t2STu99heLJX8MRXV3yQJshnFXr/DRcYNUHJhQw5gApjsjFv2
         V/ofgVWv2FebhYa79DTG1+X7Dx3A+rMP6ZI6uIX71Cr3ng2IB3iED2eerHQ4L02Gm2UY
         A+6qRsXzHdu9eEvQEqtm8tQYChVf9rFXbL1CH8o3d2eaV56HTrKkJmwkqVKzebPEMFLJ
         U9GQ==
X-Gm-Message-State: AGRZ1gIvStcnmWJrnmbGA9VVGTDXOMwQDDPjzOM4sg+APNfqWNptPJJl
        G79+VGkKgpQqJN0+DB0ZYOKap6tfPASxle3o+yb/bg==
X-Google-Smtp-Source: AJdET5dMnY65U4c3sVpXiPoMaKWqhduMF4cQCJpPunE+XXH5TgYyOz/JXlFWhAkLERzQshMx/AZxdRFpfERZ0qb9u7A=
X-Received: by 2002:a24:8347:: with SMTP id d68-v6mr8465342ite.158.1541444204959;
 Mon, 05 Nov 2018 10:56:44 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a6b:4f16:0:0:0:0:0 with HTTP; Mon, 5 Nov 2018 10:56:44 -0800 (PST)
In-Reply-To: <20181105185323.hgoflyvkyujdyjxj@redbean>
References: <20181001140910.086E768BC7@newverein.lst.de> <20181001141652.5478C68BE1@newverein.lst.de>
 <20181105175722.removbbpilqxu7tr@redbean> <20181105185323.hgoflyvkyujdyjxj@redbean>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 5 Nov 2018 19:56:44 +0100
Message-ID: <CAKv+Gu8f+dcL-049YnWJt9Ar2tP9x1DXLAG_cg1thExvnnvY4g@mail.gmail.com>
Subject: Re: [PATCH v2] arm64/module: use plt section indices for relocations
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Torsten Duwe <duwe@lst.de>, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 November 2018 at 19:53, Jessica Yu <jeyu@kernel.org> wrote:
> Instead of saving a pointer to the .plt and .init.plt sections to apply
> plt-based relocations, save and use their section indices instead.
>
> The mod->arch.{core,init}.plt pointers were problematic for livepatch
> because they pointed within temporary section headers (provided by the
> module loader via info->sechdrs) that would be freed after module load.
> Since livepatch modules may need to apply relocations post-module-load
> (for example, to patch a module that is loaded later), using section
> indices to offset into the section headers (instead of accessing them
> through a saved pointer) allows livepatch modules on arm64 to pass in
> their own copy of the section headers to apply_relocate_add() to apply
> delayed relocations.
>
> Signed-off-by: Jessica Yu <jeyu@kernel.org>

Thanks Jessica

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>
> v2:
> - Do sechdrs[pltsec->plt_shndx].sh_addr instead of pointer math
>
> Note: Addressed Will's comment about the pltsec -> plt_info rename and
> removed that change to reduce unnecessary code churn. I didn't include the
>
> Ack's for this reason so let me know if this version is OK as well.
>
> arch/arm64/include/asm/module.h |  8 +++++---
> arch/arm64/kernel/module-plts.c | 36 ++++++++++++++++++++----------------
> arch/arm64/kernel/module.c      |  9 +++++----
> 3 files changed, 30 insertions(+), 23 deletions(-)
>
> diff --git a/arch/arm64/include/asm/module.h
> b/arch/arm64/include/asm/module.h
> index 97d0ef12e2ff..f81c1847312d 100644
> --- a/arch/arm64/include/asm/module.h
> +++ b/arch/arm64/include/asm/module.h
> @@ -22,7 +22,7 @@
>
> #ifdef CONFIG_ARM64_MODULE_PLTS
> struct mod_plt_sec {
> -       struct elf64_shdr       *plt;
> +       int                     plt_shndx;
>         int                     plt_num_entries;
>         int                     plt_max_entries;
> };
> @@ -36,10 +36,12 @@ struct mod_arch_specific {
> };
> #endif
>
> -u64 module_emit_plt_entry(struct module *mod, void *loc, const Elf64_Rela
> *rela,
> +u64 module_emit_plt_entry(struct module *mod, Elf64_Shdr *sechdrs,
> +                         void *loc, const Elf64_Rela *rela,
>                           Elf64_Sym *sym);
>
> -u64 module_emit_veneer_for_adrp(struct module *mod, void *loc, u64 val);
> +u64 module_emit_veneer_for_adrp(struct module *mod, Elf64_Shdr *sechdrs,
> +                               void *loc, u64 val);
>
> #ifdef CONFIG_RANDOMIZE_BASE
> extern u64 module_alloc_base;
> diff --git a/arch/arm64/kernel/module-plts.c
> b/arch/arm64/kernel/module-plts.c
> index f0690c2ca3e0..a0efe30211d6 100644
> --- a/arch/arm64/kernel/module-plts.c
> +++ b/arch/arm64/kernel/module-plts.c
> @@ -16,12 +16,13 @@ static bool in_init(const struct module *mod, void *loc)
>         return (u64)loc - (u64)mod->init_layout.base <
> mod->init_layout.size;
> }
>
> -u64 module_emit_plt_entry(struct module *mod, void *loc, const Elf64_Rela
> *rela,
> +u64 module_emit_plt_entry(struct module *mod, Elf64_Shdr *sechdrs,
> +                         void *loc, const Elf64_Rela *rela,
>                           Elf64_Sym *sym)
> {
>         struct mod_plt_sec *pltsec = !in_init(mod, loc) ? &mod->arch.core :
>                                                           &mod->arch.init;
> -       struct plt_entry *plt = (struct plt_entry *)pltsec->plt->sh_addr;
> +       struct plt_entry *plt = (struct plt_entry
> *)sechdrs[pltsec->plt_shndx].sh_addr;
>         int i = pltsec->plt_num_entries;
>         u64 val = sym->st_value + rela->r_addend;
>
> @@ -43,11 +44,12 @@ u64 module_emit_plt_entry(struct module *mod, void *loc,
> const Elf64_Rela *rela,
> }
>
> #ifdef CONFIG_ARM64_ERRATUM_843419
> -u64 module_emit_veneer_for_adrp(struct module *mod, void *loc, u64 val)
> +u64 module_emit_veneer_for_adrp(struct module *mod, Elf64_Shdr *sechdrs,
> +                               void *loc, u64 val)
> {
>         struct mod_plt_sec *pltsec = !in_init(mod, loc) ? &mod->arch.core :
>                                                           &mod->arch.init;
> -       struct plt_entry *plt = (struct plt_entry *)pltsec->plt->sh_addr;
> +       struct plt_entry *plt = (struct plt_entry
> *)sechdrs[pltsec->plt_shndx].sh_addr;
>
>         int i = pltsec->plt_num_entries++;
>         u32 mov0, mov1, mov2, br;
>         int rd;
> @@ -202,7 +204,7 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr
> *sechdrs,
>         unsigned long core_plts = 0;
>         unsigned long init_plts = 0;
>         Elf64_Sym *syms = NULL;
> -       Elf_Shdr *tramp = NULL;
> +       Elf_Shdr *pltsec, *tramp = NULL;
>         int i;
>
>         /*
> @@ -211,9 +213,9 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr
> *sechdrs,
>          */
>         for (i = 0; i < ehdr->e_shnum; i++) {
>                 if (!strcmp(secstrings + sechdrs[i].sh_name, ".plt"))
> -                       mod->arch.core.plt = sechdrs + i;
> +                       mod->arch.core.plt_shndx = i;
>                 else if (!strcmp(secstrings + sechdrs[i].sh_name,
> ".init.plt"))
> -                       mod->arch.init.plt = sechdrs + i;
> +                       mod->arch.init.plt_shndx = i;
>                 else if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE) &&
>                          !strcmp(secstrings + sechdrs[i].sh_name,
>                                  ".text.ftrace_trampoline"))
> @@ -222,7 +224,7 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr
> *sechdrs,
>                         syms = (Elf64_Sym *)sechdrs[i].sh_addr;
>         }
>
> -       if (!mod->arch.core.plt || !mod->arch.init.plt) {
> +       if (!mod->arch.core.plt_shndx || !mod->arch.init.plt_shndx) {
>                 pr_err("%s: module PLT section(s) missing\n", mod->name);
>                 return -ENOEXEC;
>         }
> @@ -254,17 +256,19 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr
> *sechdrs,
>                                                 sechdrs[i].sh_info, dstsec);
>         }
>
> -       mod->arch.core.plt->sh_type = SHT_NOBITS;
> -       mod->arch.core.plt->sh_flags = SHF_EXECINSTR | SHF_ALLOC;
> -       mod->arch.core.plt->sh_addralign = L1_CACHE_BYTES;
> -       mod->arch.core.plt->sh_size = (core_plts  + 1) * sizeof(struct
> plt_entry);
> +       pltsec = sechdrs + mod->arch.core.plt_shndx;
> +       pltsec->sh_type = SHT_NOBITS;
> +       pltsec->sh_flags = SHF_EXECINSTR | SHF_ALLOC;
> +       pltsec->sh_addralign = L1_CACHE_BYTES;
> +       pltsec->sh_size = (core_plts  + 1) * sizeof(struct plt_entry);
>         mod->arch.core.plt_num_entries = 0;
>         mod->arch.core.plt_max_entries = core_plts;
>
> -       mod->arch.init.plt->sh_type = SHT_NOBITS;
> -       mod->arch.init.plt->sh_flags = SHF_EXECINSTR | SHF_ALLOC;
> -       mod->arch.init.plt->sh_addralign = L1_CACHE_BYTES;
> -       mod->arch.init.plt->sh_size = (init_plts + 1) * sizeof(struct
> plt_entry);
> +       pltsec = sechdrs + mod->arch.init.plt_shndx;
> +       pltsec->sh_type = SHT_NOBITS;
> +       pltsec->sh_flags = SHF_EXECINSTR | SHF_ALLOC;
> +       pltsec->sh_addralign = L1_CACHE_BYTES;
> +       pltsec->sh_size = (init_plts + 1) * sizeof(struct plt_entry);
>         mod->arch.init.plt_num_entries = 0;
>         mod->arch.init.plt_max_entries = init_plts;
>
> diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
> index f0f27aeefb73..c2abe59c6f8f 100644
> --- a/arch/arm64/kernel/module.c
> +++ b/arch/arm64/kernel/module.c
> @@ -198,7 +198,8 @@ static int reloc_insn_imm(enum aarch64_reloc_op op,
> __le32 *place, u64 val,
>         return 0;
> }
>
> -static int reloc_insn_adrp(struct module *mod, __le32 *place, u64 val)
> +static int reloc_insn_adrp(struct module *mod, Elf64_Shdr *sechdrs,
> +                          __le32 *place, u64 val)
> {
>         u32 insn;
>
> @@ -215,7 +216,7 @@ static int reloc_insn_adrp(struct module *mod, __le32
> *place, u64 val)
>                 insn &= ~BIT(31);
>         } else {
>                 /* out of range for ADR -> emit a veneer */
> -               val = module_emit_veneer_for_adrp(mod, place, val & ~0xfff);
> +               val = module_emit_veneer_for_adrp(mod, sechdrs, place, val &
> ~0xfff);
>                 if (!val)
>                         return -ENOEXEC;
>                 insn = aarch64_insn_gen_branch_imm((u64)place, val,
> @@ -368,7 +369,7 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
>                 case R_AARCH64_ADR_PREL_PG_HI21_NC:
>                         overflow_check = false;
>                 case R_AARCH64_ADR_PREL_PG_HI21:
> -                       ovf = reloc_insn_adrp(me, loc, val);
> +                       ovf = reloc_insn_adrp(me, sechdrs, loc, val);
>                         if (ovf && ovf != -ERANGE)
>                                 return ovf;
>                         break;
> @@ -413,7 +414,7 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
>
>                         if (IS_ENABLED(CONFIG_ARM64_MODULE_PLTS) &&
>                             ovf == -ERANGE) {
> -                               val = module_emit_plt_entry(me, loc,
> &rel[i], sym);
> +                               val = module_emit_plt_entry(me, sechdrs,
> loc, &rel[i], sym);
>                                 if (!val)
>                                         return -ENOEXEC;
>                                 ovf = reloc_insn_imm(RELOC_OP_PREL, loc,
> val, 2,
> --
> 2.14.5
>
