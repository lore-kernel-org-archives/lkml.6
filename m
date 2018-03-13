Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934135AbeCMQMk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 12:12:40 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:52158 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932850AbeCMQMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 12:12:36 -0400
X-Google-Smtp-Source: AG47ELuzBSGSzS1ecfQaxs7avY6D9sFqUxP3WL2LKwocv7wkSZQEz76yEo7wh5MRFGzBlmq+01+XqQgKDb3dd9yPSD4=
MIME-Version: 1.0
In-Reply-To: <20180313135314.18780-3-alexander.sverdlin@nokia.com>
References: <20180313135314.18780-1-alexander.sverdlin@nokia.com> <20180313135314.18780-3-alexander.sverdlin@nokia.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 13 Mar 2018 16:12:34 +0000
Message-ID: <CAKv+Gu-g+2y6Ej0cvLcz0R571HAnj2VXXDF0agWizDzReYMymg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] ARM: ftrace: Add MODULE_PLTS support
To: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 March 2018 at 13:53, Alexander Sverdlin
<alexander.sverdlin@nokia.com> wrote:
> Teach ftrace_make_call() and ftrace_make_nop() about PLTs.
> Teach PLT code about FTRACE and all its callbacks.
> Otherwise the following might happen:
>
> ------------[ cut here ]------------
> WARNING: CPU: 14 PID: 2265 at .../arch/arm/kernel/insn.c:14 __arm_gen_branch+0x83/0x8c()
> ...
> Hardware name: LSI Axxia AXM55XX
> [<c0314a49>] (unwind_backtrace) from [<c03115e9>] (show_stack+0x11/0x14)
> [<c03115e9>] (show_stack) from [<c0519f51>] (dump_stack+0x81/0xa8)
> [<c0519f51>] (dump_stack) from [<c032185d>] (warn_slowpath_common+0x69/0x90)
> [<c032185d>] (warn_slowpath_common) from [<c03218f3>] (warn_slowpath_null+0x17/0x1c)
> [<c03218f3>] (warn_slowpath_null) from [<c03143cf>] (__arm_gen_branch+0x83/0x8c)
> [<c03143cf>] (__arm_gen_branch) from [<c0314337>] (ftrace_make_nop+0xf/0x24)
> [<c0314337>] (ftrace_make_nop) from [<c038ebcb>] (ftrace_process_locs+0x27b/0x3e8)
> [<c038ebcb>] (ftrace_process_locs) from [<c0378d79>] (load_module+0x11e9/0x1a44)
> [<c0378d79>] (load_module) from [<c037974d>] (SyS_finit_module+0x59/0x84)
> [<c037974d>] (SyS_finit_module) from [<c030e981>] (ret_fast_syscall+0x1/0x18)
> ---[ end trace e1b64ced7a89adcc ]---
> ------------[ cut here ]------------
> WARNING: CPU: 14 PID: 2265 at .../kernel/trace/ftrace.c:1979 ftrace_bug+0x1b1/0x234()
> ...
> Hardware name: LSI Axxia AXM55XX
> [<c0314a49>] (unwind_backtrace) from [<c03115e9>] (show_stack+0x11/0x14)
> [<c03115e9>] (show_stack) from [<c0519f51>] (dump_stack+0x81/0xa8)
> [<c0519f51>] (dump_stack) from [<c032185d>] (warn_slowpath_common+0x69/0x90)
> [<c032185d>] (warn_slowpath_common) from [<c03218f3>] (warn_slowpath_null+0x17/0x1c)
> [<c03218f3>] (warn_slowpath_null) from [<c038e87d>] (ftrace_bug+0x1b1/0x234)
> [<c038e87d>] (ftrace_bug) from [<c038ebd5>] (ftrace_process_locs+0x285/0x3e8)
> [<c038ebd5>] (ftrace_process_locs) from [<c0378d79>] (load_module+0x11e9/0x1a44)
> [<c0378d79>] (load_module) from [<c037974d>] (SyS_finit_module+0x59/0x84)
> [<c037974d>] (SyS_finit_module) from [<c030e981>] (ret_fast_syscall+0x1/0x18)
> ---[ end trace e1b64ced7a89adcd ]---
> ftrace failed to modify [<e9ef7006>] 0xe9ef7006
> actual: 02:f0:3b:fa
> ftrace record flags: 0
> (0) expected tramp: c0314265
>
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> ---
>  arch/arm/include/asm/ftrace.h |  3 +++
>  arch/arm/include/asm/module.h |  1 +
>  arch/arm/kernel/ftrace.c      | 62 ++++++++++++++++++++++++++++++++++++-------
>  arch/arm/kernel/module-plts.c | 47 +++++++++++++++++++++++++++++---
>  4 files changed, 100 insertions(+), 13 deletions(-)
>
...
> diff --git a/arch/arm/kernel/module-plts.c b/arch/arm/kernel/module-plts.c
> index f272711..0951270 100644
> --- a/arch/arm/kernel/module-plts.c
> +++ b/arch/arm/kernel/module-plts.c
> @@ -7,6 +7,7 @@
>   */
>
>  #include <linux/elf.h>
> +#include <linux/ftrace.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/sort.h>
> @@ -22,18 +23,54 @@
>                                                     (PLT_ENT_STRIDE - 8))
>  #endif
>
> +static const u32 fixed_plts[] = {
> +#ifdef CONFIG_FUNCTION_TRACER
> +       FTRACE_ADDR,
> +       MCOUNT_ADDR,
> +#ifdef CONFIG_OLD_MCOUNT
> +       (unsigned long)ftrace_caller_old,
> +       (unsigned long)mcount,
> +#endif
> +#endif
> +};
> +
>  static bool in_init(const struct module *mod, unsigned long loc)
>  {
>         return loc - (u32)mod->init_layout.base < mod->init_layout.size;
>  }
>
> +static void prealloc_fixed(struct mod_plt_sec *pltsec, struct plt_entries *plt)
> +{
> +       int i;
> +
> +       if (!ARRAY_SIZE(fixed_plts))
> +               return;
> +
> +       for (i = 0; i < ARRAY_SIZE(plt->ldr); ++i)
> +               plt->ldr[i] = PLT_ENT_LDR;
> +       memcpy(plt->lit, fixed_plts, sizeof(fixed_plts));

This is slightly dodgy. You are assuming that sizeof(plt->lit) >=
sizeof(fixed_plts), which may change depending on configuration or
future changes.

Could you add a BUILD_BUG_ON() here to ensure that this remains the case?

> +       pltsec->plt_count = ARRAY_SIZE(fixed_plts);
> +}
> +
>  u32 get_module_plt(struct module *mod, unsigned long loc, Elf32_Addr val)
>  {
>         struct mod_plt_sec *pltsec = !in_init(mod, loc) ? &mod->arch.core :
>                                                           &mod->arch.init;
> +       struct plt_entries *plt;
> +       int idx;
>
> -       struct plt_entries *plt = (struct plt_entries *)pltsec->plt->sh_addr;
> -       int idx = 0;
> +       /* cache the address, ELF header is available only during module load */
> +       if (!pltsec->plt_ent)
> +               pltsec->plt_ent = (struct plt_entries *)pltsec->plt->sh_addr;
> +       plt = pltsec->plt_ent;
> +

Where is plt_ent ever used?

> +       if (!pltsec->plt_count)
> +               prealloc_fixed(pltsec, plt);
> +

Please move the if () check into prealloc_fixed(), and only keep the loop below


> +       idx = ARRAY_SIZE(fixed_plts);
> +       while (idx)
> +               if (plt->lit[--idx] == val)
> +                       return (u32)&plt->ldr[idx];

Please use a normal for loop here and iterate upward starting at 0


>
>         /*
>          * Look for an existing entry pointing to 'val'. Given that the
> @@ -182,8 +219,8 @@ static unsigned int count_plts(const Elf32_Sym *syms, Elf32_Addr base,
>  int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
>                               char *secstrings, struct module *mod)
>  {
> -       unsigned long core_plts = 0;
> -       unsigned long init_plts = 0;
> +       unsigned long core_plts = ARRAY_SIZE(fixed_plts);
> +       unsigned long init_plts = ARRAY_SIZE(fixed_plts);
>         Elf32_Shdr *s, *sechdrs_end = sechdrs + ehdr->e_shnum;
>         Elf32_Sym *syms = NULL;
>
> @@ -238,6 +275,7 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
>         mod->arch.core.plt->sh_size = round_up(core_plts * PLT_ENT_SIZE,
>                                                sizeof(struct plt_entries));
>         mod->arch.core.plt_count = 0;
> +       mod->arch.core.plt_ent = NULL;
>
>         mod->arch.init.plt->sh_type = SHT_NOBITS;
>         mod->arch.init.plt->sh_flags = SHF_EXECINSTR | SHF_ALLOC;
> @@ -245,6 +283,7 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
>         mod->arch.init.plt->sh_size = round_up(init_plts * PLT_ENT_SIZE,
>                                                sizeof(struct plt_entries));
>         mod->arch.init.plt_count = 0;
> +       mod->arch.init.plt_ent = NULL;
>
>         pr_debug("%s: plt=%x, init.plt=%x\n", __func__,
>                  mod->arch.core.plt->sh_size, mod->arch.init.plt->sh_size);
> --
> 2.4.6
>
