Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751788AbeCIIuk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:50:40 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:38823 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750942AbeCIIui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:50:38 -0500
X-Google-Smtp-Source: AG47ELvPFWCds3O6xYXLi7PgiU8YQ+N2fqgiRv77XLXTdhKBqburpB2hCZnaRJ5YrkuXjW9XMBCfZX/fyM6ZDQBOr+g=
MIME-Version: 1.0
In-Reply-To: <20180309084151.2379-3-alexander.sverdlin@nokia.com>
References: <20180309084151.2379-1-alexander.sverdlin@nokia.com> <20180309084151.2379-3-alexander.sverdlin@nokia.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 9 Mar 2018 08:50:36 +0000
Message-ID: <CAKv+Gu87oP4Bxn_XkQkc2zf8GXLhoRkWBkUr5N0KMdyMfq1GMg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] ARM: ftrace: Add MODULE_PLTS support
To: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

On 9 March 2018 at 08:41, Alexander Sverdlin
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
>  arch/arm/kernel/module-plts.c | 53 +++++++++++++++++++++++++++---------
>  4 files changed, 97 insertions(+), 22 deletions(-)
>
> diff --git a/arch/arm/include/asm/ftrace.h b/arch/arm/include/asm/ftrace.h
> index 9e842ff..faeb6b1 100644
> --- a/arch/arm/include/asm/ftrace.h
> +++ b/arch/arm/include/asm/ftrace.h
> @@ -19,6 +19,9 @@ struct dyn_arch_ftrace {
>  #ifdef CONFIG_OLD_MCOUNT
>         bool    old_mcount;
>  #endif
> +#ifdef CONFIG_ARM_MODULE_PLTS
> +       struct module *mod;
> +#endif
>  };
>
>  static inline unsigned long ftrace_call_adjust(unsigned long addr)
> diff --git a/arch/arm/include/asm/module.h b/arch/arm/include/asm/module.h
> index 6996405..e3d7a51 100644
> --- a/arch/arm/include/asm/module.h
> +++ b/arch/arm/include/asm/module.h
> @@ -30,6 +30,7 @@ struct plt_entries {
>
>  struct mod_plt_sec {
>         struct elf32_shdr       *plt;
> +       struct plt_entries      *plt_ent;
>         int                     plt_count;
>  };
>
> diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
> index 5617932..b55355f 100644
> --- a/arch/arm/kernel/ftrace.c
> +++ b/arch/arm/kernel/ftrace.c
> @@ -98,6 +98,19 @@ int ftrace_arch_code_modify_post_process(void)
>
>  static unsigned long ftrace_call_replace(unsigned long pc, unsigned long addr)
>  {
> +       s32 offset = addr - pc;
> +       s32 blim = 0xfe000008;
> +       s32 flim = 0x02000004;
> +
> +       if (IS_ENABLED(CONFIG_THUMB2_KERNEL)) {
> +               blim = 0xff000004;
> +               flim = 0x01000002;
> +       }
> +
> +       if (IS_ENABLED(CONFIG_ARM_MODULE_PLTS) &&
> +           (offset < blim || offset > flim))
> +               return 0;
> +
>         return arm_gen_branch_link(pc, addr);
>  }
>
> @@ -166,10 +179,22 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
>  {
>         unsigned long new, old;
>         unsigned long ip = rec->ip;
> +       unsigned long aaddr = adjust_address(rec, addr);
>
>         old = ftrace_nop_replace(rec);
>
> -       new = ftrace_call_replace(ip, adjust_address(rec, addr));
> +       new = ftrace_call_replace(ip, aaddr);
> +
> +#ifdef CONFIG_ARM_MODULE_PLTS
> +       if (!new) {
> +               struct module *mod = rec->arch.mod;
> +
> +               if (mod) {
> +                       aaddr = get_module_plt(mod, ip, aaddr);
> +                       new = ftrace_call_replace(ip, aaddr);
> +               }
> +       }
> +#endif
>
>         return ftrace_modify_code(rec->ip, old, new, true);
>  }
> @@ -199,20 +224,39 @@ int ftrace_make_nop(struct module *mod,
>         unsigned long new;
>         int ret;
>
> -       old = ftrace_call_replace(ip, adjust_address(rec, addr));
> -       new = ftrace_nop_replace(rec);
> -       ret = ftrace_modify_code(ip, old, new, true);
> +#ifdef CONFIG_ARM_MODULE_PLTS
> +       /* mod is only supplied during module loading */
> +       if (!mod)
> +               mod = rec->arch.mod;
> +       else
> +               rec->arch.mod = mod;
> +#endif
>
> -#ifdef CONFIG_OLD_MCOUNT
> -       if (ret == -EINVAL && addr == MCOUNT_ADDR) {
> -               rec->arch.old_mcount = true;
> +       for (;;) {
> +               unsigned long aaddr = adjust_address(rec, addr);
> +
> +               old = ftrace_call_replace(ip, aaddr);
> +
> +#ifdef CONFIG_ARM_MODULE_PLTS
> +               if (!old && mod) {
> +                       aaddr = get_module_plt(mod, ip, aaddr);
> +                       old = ftrace_call_replace(ip, aaddr);
> +               }
> +#endif
>
> -               old = ftrace_call_replace(ip, adjust_address(rec, addr));
>                 new = ftrace_nop_replace(rec);
>                 ret = ftrace_modify_code(ip, old, new, true);
> -       }
> +
> +#ifdef CONFIG_OLD_MCOUNT
> +               if (ret == -EINVAL && !rec->arch.old_mcount) {
> +                       rec->arch.old_mcount = true;
> +                       continue;
> +               }
>  #endif
>
> +               break;
> +       }
> +
>         return ret;
>  }
>
> diff --git a/arch/arm/kernel/module-plts.c b/arch/arm/kernel/module-plts.c
> index f272711..a216256 100644
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
> @@ -22,6 +23,15 @@
>                                                     (PLT_ENT_STRIDE - 8))
>  #endif
>
> +static u32 fixed_plts[] = {
> +       FTRACE_ADDR,
> +       MCOUNT_ADDR,
> +#ifdef CONFIG_OLD_MCOUNT
> +       (unsigned long)ftrace_caller_old,
> +       (unsigned long)mcount,
> +#endif
> +};
> +

Do we need this stuff in the PLT loader if ftrace is disabled?

>  static bool in_init(const struct module *mod, unsigned long loc)
>  {
>         return loc - (u32)mod->init_layout.base < mod->init_layout.size;
> @@ -31,26 +41,43 @@ u32 get_module_plt(struct module *mod, unsigned long loc, Elf32_Addr val)
>  {
>         struct mod_plt_sec *pltsec = !in_init(mod, loc) ? &mod->arch.core :
>                                                           &mod->arch.init;
> +       int idx;
> +       struct plt_entries *plt;
> +
> +       /* Pre-allocate entries in the first plt */
> +       if (!pltsec->plt_count) {
> +               plt = (struct plt_entries *)pltsec->plt->sh_addr;
> +               for (idx = 0; idx < ARRAY_SIZE(plt->ldr); ++idx)
> +                       plt->ldr[idx] = PLT_ENT_LDR;
> +               memcpy(plt->lit, fixed_plts, sizeof(fixed_plts));
> +               pltsec->plt_count = ARRAY_SIZE(fixed_plts);
> +               /*
> +                * cache the address,
> +                * ELF header is available only during module load
> +                */
> +               pltsec->plt_ent = plt;
> +       }
> +       plt = pltsec->plt_ent;
>
> -       struct plt_entries *plt = (struct plt_entries *)pltsec->plt->sh_addr;
> -       int idx = 0;
> +       idx = ARRAY_SIZE(fixed_plts);
> +       while (idx)
> +               if (plt->lit[--idx] == val)
> +                       return (u32)&plt->ldr[idx];
>

Same here.

>         /*
>          * Look for an existing entry pointing to 'val'. Given that the
>          * relocations are sorted, this will be the last entry we allocated.
>          * (if one exists).
>          */
> -       if (pltsec->plt_count > 0) {
> -               plt += (pltsec->plt_count - 1) / PLT_ENT_COUNT;
> -               idx = (pltsec->plt_count - 1) % PLT_ENT_COUNT;
> +       plt += (pltsec->plt_count - 1) / PLT_ENT_COUNT;
> +       idx = (pltsec->plt_count - 1) % PLT_ENT_COUNT;
>
> -               if (plt->lit[idx] == val)
> -                       return (u32)&plt->ldr[idx];
> +       if (plt->lit[idx] == val)
> +               return (u32)&plt->ldr[idx];
>
> -               idx = (idx + 1) % PLT_ENT_COUNT;
> -               if (!idx)
> -                       plt++;
> -       }
> +       idx = (idx + 1) % PLT_ENT_COUNT;
> +       if (!idx)
> +               plt++;
>
>         pltsec->plt_count++;
>         BUG_ON(pltsec->plt_count * PLT_ENT_SIZE > pltsec->plt->sh_size);
> @@ -182,8 +209,8 @@ static unsigned int count_plts(const Elf32_Sym *syms, Elf32_Addr base,
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
> --
> 2.4.6
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
