Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514C1C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 963B720855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="W9qc1waS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 963B720855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbeKITbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:31:07 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:50699 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727532AbeKITbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:31:06 -0500
Received: by mail-it1-f193.google.com with SMTP id k206-v6so2289013ite.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 01:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GqgctrRyZRDIarF9cVzfMDAaO+67GRCHPnOcvgAZxh8=;
        b=W9qc1waSmozyogGgDF6dMNvP/hPcX9YyDa0D/JYMbZjEOqL5rtGbHbA8gOvagrZmUt
         +8+AWpw41Ads0b+ahZMZvss6YmcHFlnPfHPOghw7vKpEnH3GtLmKe0DfNjiXh+5u9xKb
         JoPx4sAl0TaG8OjENTZjMxv5AZObM3ideeliM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GqgctrRyZRDIarF9cVzfMDAaO+67GRCHPnOcvgAZxh8=;
        b=jdbk43EFdK/UM3WLFwEkNQPjRHLFQPsE2rTqNmTavM2U388DB+pKMrKqdUT0qiu/kL
         mIBJunA9Q991/HhWNQKqUuLtnRZUlsGS8pGFX4BCEp3S9b+s9mmP0NW0xgTWz5kH8KUd
         UROupXAyFVQGF6q0Cq/flJBdbcOehfWQai8iVutbG0D07O+1KuudkFBEWM4sSr9SteSk
         qWYjgHkzV+MHopZHbfk3XeM0xIlKhPDhRR0tVYUTtxfNdcKOsN9ImXNs/JQ7iUQZyVNX
         IVDFhvj/jKfU5rqFhKzf29ciy9d44UHO7xMDrklNQJqFeimNIGxKp0CFUs9BUNa7Iiou
         /J5w==
X-Gm-Message-State: AGRZ1gIrwIfsQPFQD2CGXKggW+wEwDv+uBMCFVL3uv30Bea7tPtsdVHZ
        8c2W7L/941yVIHUq+WKBMLNHi4Ua7KlkaxhSt60/xg==
X-Google-Smtp-Source: AJdET5dz7zdSczHWPZAP2qjqdDACM7tfw17wCAxbzvXququz+M17Cz6FEN0uPRdbQxoOHkdCV8eTeN6LjCDyQ37JI38=
X-Received: by 2002:a24:2190:: with SMTP id e138-v6mr1667346ita.71.1541757076834;
 Fri, 09 Nov 2018 01:51:16 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a6b:4f16:0:0:0:0:0 with HTTP; Fri, 9 Nov 2018 01:51:16 -0800 (PST)
In-Reply-To: <3cf04e113d71c9f8e4be95fb84a510f085aa4afa.1541711457.git.jpoimboe@redhat.com>
References: <cover.1541711457.git.jpoimboe@redhat.com> <3cf04e113d71c9f8e4be95fb84a510f085aa4afa.1541711457.git.jpoimboe@redhat.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 9 Nov 2018 10:51:16 +0100
Message-ID: <CAKv+Gu_K-=rhV3fkE=OzFM=QipP8wbYhOeMZ8Pa6m=ZCnSOLew@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] static_call: Add static call infrastructure
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh,

Thanks a lot for looking into this.

On 8 November 2018 at 22:15, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> Add a static call infrastructure.  Static calls use code patching to
> hard-code function pointers into direct branch instructions.  They give
> the flexibility of function pointers, but with improved performance.
> This is especially important for cases where retpolines would otherwise
> be used, as retpolines can significantly impact performance.
>
> This code is heavily inspired by the jump label code (aka "static
> jumps"), as some of the concepts are very similar.
>
> There are three implementations, depending on arch support:
>
> 1) optimized: patched call sites (CONFIG_HAVE_STATIC_CALL_OPTIMIZED)
> 2) unoptimized: patched trampolines (CONFIG_HAVE_STATIC_CALL_UNOPTIMIZED)

Could we move to an idiom like inline/out of line? The unoptimized
variant may be perfectly adequate for many arches, and 'unoptimized'
sounds like there is something wrong with it.

> 3) basic function pointers
>
> For more details, see the comments in include/linux/static_call.h.
>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  arch/Kconfig                      |   6 +
>  include/asm-generic/vmlinux.lds.h |  11 ++
>  include/linux/module.h            |  10 +
>  include/linux/static_call.h       | 186 +++++++++++++++++++
>  include/linux/static_call_types.h |  19 ++
>  kernel/Makefile                   |   1 +
>  kernel/module.c                   |   5 +
>  kernel/static_call.c              | 297 ++++++++++++++++++++++++++++++
>  8 files changed, 535 insertions(+)
>  create mode 100644 include/linux/static_call.h
>  create mode 100644 include/linux/static_call_types.h
>  create mode 100644 kernel/static_call.c
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index e1e540ffa979..9657ad5a80d1 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -879,6 +879,12 @@ config HAVE_ARCH_PREL32_RELOCATIONS
>           architectures, and don't require runtime relocation on relocatable
>           kernels.
>
> +config HAVE_STATIC_CALL_OPTIMIZED
> +       bool
> +
> +config HAVE_STATIC_CALL_UNOPTIMIZED
> +       bool
> +
>  source "kernel/gcov/Kconfig"
>
>  source "scripts/gcc-plugins/Kconfig"
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 3d7a6a9c2370..45d8ced28bd0 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -320,6 +320,7 @@
>         __start_ro_after_init = .;                                      \
>         *(.data..ro_after_init)                                         \
>         JUMP_TABLE_DATA                                                 \
> +       STATIC_CALL_SITES                                               \
>         __end_ro_after_init = .;
>  #endif
>
> @@ -725,6 +726,16 @@
>  #define BUG_TABLE
>  #endif
>
> +#ifdef CONFIG_HAVE_STATIC_CALL_OPTIMIZED
> +#define STATIC_CALL_SITES                                              \
> +       . = ALIGN(8);                                                   \
> +       __start_static_call_sites = .;                                  \
> +       KEEP(*(.static_call_sites))                                     \
> +       __stop_static_call_sites = .;
> +#else
> +#define STATIC_CALL_SITES
> +#endif
> +
>  #ifdef CONFIG_UNWINDER_ORC
>  #define ORC_UNWIND_TABLE                                               \
>         . = ALIGN(4);                                                   \
> diff --git a/include/linux/module.h b/include/linux/module.h
> index fce6b4335e36..91baf181247a 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -21,6 +21,7 @@
>  #include <linux/rbtree_latch.h>
>  #include <linux/error-injection.h>
>  #include <linux/tracepoint-defs.h>
> +#include <linux/static_call_types.h>
>
>  #include <linux/percpu.h>
>  #include <asm/module.h>
> @@ -450,6 +451,10 @@ struct module {
>         unsigned int num_ftrace_callsites;
>         unsigned long *ftrace_callsites;
>  #endif
> +#ifdef CONFIG_HAVE_STATIC_CALL_OPTIMIZED
> +       int num_static_call_sites;
> +       struct static_call_site *static_call_sites;
> +#endif
>
>  #ifdef CONFIG_LIVEPATCH
>         bool klp; /* Is this a livepatch module? */
> @@ -682,6 +687,11 @@ static inline bool is_module_text_address(unsigned long addr)
>         return false;
>  }
>
> +static inline bool within_module_init(unsigned long addr, const struct module *mod)
> +{
> +       return false;
> +}
> +
>  /* Get/put a kernel symbol (calls should be symmetric) */
>  #define symbol_get(x) ({ extern typeof(x) x __attribute__((weak)); &(x); })
>  #define symbol_put(x) do { } while (0)
> diff --git a/include/linux/static_call.h b/include/linux/static_call.h
> new file mode 100644
> index 000000000000..b22987057cf1
> --- /dev/null
> +++ b/include/linux/static_call.h
> @@ -0,0 +1,186 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_STATIC_CALL_H
> +#define _LINUX_STATIC_CALL_H
> +
> +/*
> + * Static call support
> + *
> + * Static calls use code patching to hard-code function pointers into direct
> + * branch instructions.  They give the flexibility of function pointers, but
> + * with improved performance.  This is especially important for cases where
> + * retpolines would otherwise be used, as retpolines can significantly impact
> + * performance.
> + *
> + *
> + * API overview:
> + *
> + *   DECLARE_STATIC_CALL(key, func);
> + *   DEFINE_STATIC_CALL(key, func);
> + *   static_call(key, args...);
> + *   static_call_update(key, func);
> + *
> + *
> + * Usage example:
> + *
> + *   # Start with the following functions (with identical prototypes):
> + *   int func_a(int arg1, int arg2);
> + *   int func_b(int arg1, int arg2);
> + *
> + *   # Define a 'my_key' reference, associated with func_a() by default
> + *   DEFINE_STATIC_CALL(my_key, func_a);
> + *
> + *   # Call func_a()
> + *   static_call(my_key, arg1, arg2);
> + *
> + *   # Update 'my_key' to point to func_b()
> + *   static_call_update(my_key, func_b);
> + *
> + *   # Call func_b()
> + *   static_call(my_key, arg1, arg2);
> + *

Any way we can revert to the default implementation? That would be
useful for, e.g.,  unloading modules that provide an alternative
implementation.

> + *
> + * Implementation details:
> + *
> + * There are three different implementations:
> + *
> + * 1) Optimized static calls (patched call sites)
> + *
> + *    This requires objtool, which detects all the static_call() sites and
> + *    annotates them in the '.static_call_sites' section.  By default, the call
> + *    sites will call into a temporary per-key trampoline which has an indirect
> + *    branch to the current destination function associated with the key.
> + *    During system boot (or module init), all call sites are patched to call
> + *    their destination functions directly.  Updates to a key will patch all
> + *    call sites associated with that key.
> + *
> + * 2) Unoptimized static calls (patched trampolines)
> + *
> + *    Each static_call() site calls into a permanent trampoline associated with
> + *    the key.  The trampoline has a direct branch to the default function.
> + *    Updates to a key will modify the direct branch in the key's trampoline.
> + *
> + * 3) Generic implementation
> + *
> + *    This is the default implementation if the architecture hasn't implemented
> + *    CONFIG_HAVE_STATIC_CALL_[UN]OPTIMIZED.  In this case, a basic
> + *    function pointer is used.
> + */
> +
> +#include <linux/types.h>
> +#include <linux/cpu.h>
> +#include <linux/static_call_types.h>
> +
> +#if defined(CONFIG_HAVE_STATIC_CALL_OPTIMIZED) || \
> +    defined(CONFIG_HAVE_STATIC_CALL_UNOPTIMIZED)
> +
> +#include <asm/static_call.h>
> +
> +extern void arch_static_call_transform(unsigned long insn, void *dest);
> +
> +#endif /* CONFIG_HAVE_STATIC_CALL_[UN]OPTIMIZED */
> +
> +#ifdef CONFIG_HAVE_STATIC_CALL_OPTIMIZED
> +/* Optimized implementation */
> +
> +struct static_call_mod {
> +       struct list_head list;
> +       struct module *mod; /* NULL means vmlinux */
> +       struct static_call_site *sites;
> +};
> +
> +struct static_call_key {
> +       /*
> +        * This field should always be first because the trampolines expect it.
> +        * This points to the current call destination.
> +        */
> +       void *func;
> +
> +       /*
> +        * List of modules (including vmlinux) and the call sites which need to
> +        * be patched for this key.
> +        */
> +       struct list_head site_mods;
> +};
> +
> +extern void __static_call_update(struct static_call_key *key, void *func);
> +extern void arch_static_call_poison_tramp(unsigned long insn);
> +
> +#define DECLARE_STATIC_CALL(key, func)                                 \
> +       extern struct static_call_key key;                              \
> +       extern typeof(func) STATIC_CALL_TRAMP(key);                     \
> +       /* Preserve the ELF symbol so objtool can access it: */         \
> +       __ADDRESSABLE(key)
> +
> +#define DEFINE_STATIC_CALL(key, _func)                                 \
> +       DECLARE_STATIC_CALL(key, _func);                                \
> +       struct static_call_key key = {                                  \
> +               .func = _func,                                          \
> +               .site_mods = LIST_HEAD_INIT(key.site_mods),             \
> +       };                                                              \
> +       ARCH_STATIC_CALL_TEMPORARY_TRAMP(key)
> +
> +#define static_call(key, args...) STATIC_CALL_TRAMP(key)(args)
> +
> +#define static_call_update(key, func)                                  \
> +({                                                                     \
> +       BUILD_BUG_ON(!__same_type(typeof(func), typeof(STATIC_CALL_TRAMP(key)))); \
> +       __static_call_update(&key, func);                               \
> +})
> +
> +#define EXPORT_STATIC_CALL(key)                                                \
> +       EXPORT_SYMBOL(key);                                             \
> +       EXPORT_SYMBOL(STATIC_CALL_TRAMP(key))
> +
> +#define EXPORT_STATIC_CALL_GPL(key)                                    \
> +       EXPORT_SYMBOL_GPL(key);                                         \
> +       EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(key))
> +
> +
> +#elif defined(CONFIG_HAVE_STATIC_CALL_UNOPTIMIZED)
> +/* Unoptimized implementation */
> +
> +#define DECLARE_STATIC_CALL(key, func)                                 \
> +       extern typeof(func) STATIC_CALL_TRAMP(key)
> +
> +#define DEFINE_STATIC_CALL(key, func)                                  \
> +       DECLARE_STATIC_CALL(key, func);                                 \
> +       ARCH_STATIC_CALL_TRAMP(key, func)
> +
> +#define static_call(key, args...) STATIC_CALL_TRAMP(key)(args)
> +
> +#define static_call_update(key, func)                                  \
> +({                                                                     \
> +       BUILD_BUG_ON(!__same_type(func, STATIC_CALL_TRAMP(key)));       \
> +       cpus_read_lock();                                               \
> +       arch_static_call_transform((unsigned long)STATIC_CALL_TRAMP(key),\
> +                                  func);                               \
> +       cpus_read_unlock();                                             \
> +})
> +
> +#define EXPORT_STATIC_CALL(key)                                                \
> +       EXPORT_SYMBOL(STATIC_CALL_TRAMP(key))
> +
> +#define EXPORT_STATIC_CALL_GPL(key)                                    \
> +       EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(key))
> +
> +
> +#else /* Generic implementation */
> +
> +#define DECLARE_STATIC_CALL(key, func)                                 \
> +       extern typeof(func) *key
> +
> +#define DEFINE_STATIC_CALL(key, func)                                  \
> +       typeof(func) *key = func
> +
> +#define static_call(key, args...)                                      \
> +       key(args)
> +
> +#define static_call_update(key, func)                                  \
> +       WRITE_ONCE(key, func)
> +
> +#define EXPORT_STATIC_CALL(key) EXPORT_SYMBOL(key)
> +#define EXPORT_STATIC_CALL_GPL(key) EXPORT_SYMBOL_GPL(key)
> +
> +#endif /* CONFIG_HAVE_STATIC_CALL_OPTIMIZED */
> +
> +#endif /* _LINUX_STATIC_CALL_H */
> diff --git a/include/linux/static_call_types.h b/include/linux/static_call_types.h
> new file mode 100644
> index 000000000000..7dd4b3d7ec2b
> --- /dev/null
> +++ b/include/linux/static_call_types.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _STATIC_CALL_TYPES_H
> +#define _STATIC_CALL_TYPES_H
> +
> +#include <linux/stringify.h>
> +
> +#define STATIC_CALL_TRAMP_PREFIX ____static_call_tramp_
> +#define STATIC_CALL_TRAMP_PREFIX_STR __stringify(STATIC_CALL_TRAMP_PREFIX)
> +
> +#define STATIC_CALL_TRAMP(key) STATIC_CALL_TRAMP_PREFIX##key
> +#define STATIC_CALL_TRAMP_STR(key) __stringify(STATIC_CALL_TRAMP(key))
> +

I needed to apply

diff --git a/include/linux/static_call_types.h
b/include/linux/static_call_types.h
index 7dd4b3d7ec2b..6859b208de6e 100644
--- a/include/linux/static_call_types.h
+++ b/include/linux/static_call_types.h
@@ -7,7 +7,7 @@
 #define STATIC_CALL_TRAMP_PREFIX ____static_call_tramp_
 #define STATIC_CALL_TRAMP_PREFIX_STR __stringify(STATIC_CALL_TRAMP_PREFIX)

-#define STATIC_CALL_TRAMP(key) STATIC_CALL_TRAMP_PREFIX##key
+#define STATIC_CALL_TRAMP(key) __PASTE(STATIC_CALL_TRAMP_PREFIX, key)
 #define STATIC_CALL_TRAMP_STR(key) __stringify(STATIC_CALL_TRAMP(key))

 /* The static call site table is created by objtool. */

or I end up with

0000000000000000 <STATIC_CALL_TRAMP_PREFIXfoo>:
   0: 14000000 b a8 <foo_a>
   4: d503201f nop

> +/* The static call site table is created by objtool. */
> +struct static_call_site {
> +       s32 addr;
> +       s32 key;
> +};
> +
> +#endif /* _STATIC_CALL_TYPES_H */
> diff --git a/kernel/Makefile b/kernel/Makefile
> index 7343b3a9bff0..888bb476ddaf 100644
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -103,6 +103,7 @@ obj-$(CONFIG_TRACEPOINTS) += trace/
>  obj-$(CONFIG_IRQ_WORK) += irq_work.o
>  obj-$(CONFIG_CPU_PM) += cpu_pm.o
>  obj-$(CONFIG_BPF) += bpf/
> +obj-$(CONFIG_HAVE_STATIC_CALL_OPTIMIZED) += static_call.o
>
>  obj-$(CONFIG_PERF_EVENTS) += events/
>
> diff --git a/kernel/module.c b/kernel/module.c
> index 49a405891587..11124d991fcd 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -3121,6 +3121,11 @@ static int find_module_sections(struct module *mod, struct load_info *info)
>         mod->ei_funcs = section_objs(info, "_error_injection_whitelist",
>                                             sizeof(*mod->ei_funcs),
>                                             &mod->num_ei_funcs);
> +#endif
> +#ifdef CONFIG_HAVE_STATIC_CALL_OPTIMIZED
> +       mod->static_call_sites = section_objs(info, ".static_call_sites",
> +                                             sizeof(*mod->static_call_sites),
> +                                             &mod->num_static_call_sites);
>  #endif
>         mod->extable = section_objs(info, "__ex_table",
>                                     sizeof(*mod->extable), &mod->num_exentries);
> diff --git a/kernel/static_call.c b/kernel/static_call.c
> new file mode 100644
> index 000000000000..599ebc6fc4f1
> --- /dev/null
> +++ b/kernel/static_call.c
> @@ -0,0 +1,297 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#include <linux/init.h>
> +#include <linux/static_call.h>
> +#include <linux/bug.h>
> +#include <linux/smp.h>
> +#include <linux/sort.h>
> +#include <linux/slab.h>
> +#include <linux/module.h>
> +#include <linux/cpu.h>
> +#include <linux/processor.h>
> +#include <asm/sections.h>
> +
> +extern struct static_call_site __start_static_call_sites[],
> +                              __stop_static_call_sites[];
> +
> +static bool static_call_initialized;
> +
> +/* mutex to protect key modules/sites */
> +static DEFINE_MUTEX(static_call_mutex);
> +
> +static void static_call_lock(void)
> +{
> +       mutex_lock(&static_call_mutex);
> +}
> +
> +static void static_call_unlock(void)
> +{
> +       mutex_unlock(&static_call_mutex);
> +}
> +
> +static inline unsigned long static_call_addr(struct static_call_site *site)
> +{
> +       return (long)site->addr + (long)&site->addr;
> +}
> +
> +static inline struct static_call_key *static_call_key(const struct static_call_site *site)
> +{
> +       return (struct static_call_key *)((long)site->key + (long)&site->key);
> +}
> +
> +static int static_call_site_cmp(const void *_a, const void *_b)
> +{
> +       const struct static_call_site *a = _a;
> +       const struct static_call_site *b = _b;
> +       const struct static_call_key *key_a = static_call_key(a);
> +       const struct static_call_key *key_b = static_call_key(b);
> +
> +       if (key_a < key_b)
> +               return -1;
> +
> +       if (key_a > key_b)
> +               return 1;
> +
> +       return 0;
> +}
> +
> +static void static_call_site_swap(void *_a, void *_b, int size)
> +{
> +       long delta = (unsigned long)_a - (unsigned long)_b;
> +       struct static_call_site *a = _a;
> +       struct static_call_site *b = _b;
> +       struct static_call_site tmp = *a;
> +
> +       a->addr = b->addr  - delta;
> +       a->key  = b->key   - delta;
> +
> +       b->addr = tmp.addr + delta;
> +       b->key  = tmp.key  + delta;
> +}
> +
> +static inline void static_call_sort_entries(struct static_call_site *start,
> +                                           struct static_call_site *stop)
> +{
> +       sort(start, stop - start, sizeof(struct static_call_site),
> +            static_call_site_cmp, static_call_site_swap);
> +}
> +
> +void __static_call_update(struct static_call_key *key, void *func)
> +{
> +       struct static_call_mod *mod;
> +       struct static_call_site *site, *stop;
> +
> +       cpus_read_lock();
> +       static_call_lock();
> +
> +       if (key->func == func)
> +               goto done;
> +
> +       key->func = func;
> +
> +       /*
> +        * If called before init, leave the call sites unpatched for now.
> +        * In the meantime they'll continue to call the temporary trampoline.
> +        */
> +       if (!static_call_initialized)
> +               goto done;
> +
> +       list_for_each_entry(mod, &key->site_mods, list) {
> +               if (!mod->sites) {
> +                       /*
> +                        * This can happen if the static call key is defined in
> +                        * a module which doesn't use it.
> +                        */
> +                       continue;
> +               }
> +
> +               stop = __stop_static_call_sites;
> +
> +#ifdef CONFIG_MODULES
> +               if (mod->mod) {
> +                       stop = mod->mod->static_call_sites +
> +                              mod->mod->num_static_call_sites;
> +               }
> +#endif
> +
> +               for (site = mod->sites;
> +                    site < stop && static_call_key(site) == key; site++) {
> +                       unsigned long addr = static_call_addr(site);
> +
> +                       if (!mod->mod && init_section_contains((void *)addr, 1))
> +                               continue;
> +                       if (mod->mod && within_module_init(addr, mod->mod))
> +                               continue;
> +
> +                       arch_static_call_transform(addr, func);
> +               }
> +       }
> +
> +done:
> +       static_call_unlock();
> +       cpus_read_unlock();
> +}
> +EXPORT_SYMBOL_GPL(__static_call_update);
> +
> +#ifdef CONFIG_MODULES
> +
> +static int static_call_add_module(struct module *mod)
> +{
> +       struct static_call_site *start = mod->static_call_sites;
> +       struct static_call_site *stop = mod->static_call_sites +
> +                                       mod->num_static_call_sites;
> +       struct static_call_site *site;
> +       struct static_call_key *key, *prev_key = NULL;
> +       struct static_call_mod *static_call_mod;
> +
> +       if (start == stop)
> +               return 0;
> +
> +       module_disable_ro(mod);
> +       static_call_sort_entries(start, stop);
> +       module_enable_ro(mod, false);
> +
> +       for (site = start; site < stop; site++) {
> +               unsigned long addr = static_call_addr(site);
> +
> +               if (within_module_init(addr, mod))
> +                       continue;
> +
> +               key = static_call_key(site);
> +               if (key != prev_key) {
> +                       prev_key = key;
> +
> +                       static_call_mod = kzalloc(sizeof(*static_call_mod), GFP_KERNEL);
> +                       if (!static_call_mod)
> +                               return -ENOMEM;
> +
> +                       static_call_mod->mod = mod;
> +                       static_call_mod->sites = site;
> +                       list_add_tail(&static_call_mod->list, &key->site_mods);
> +
> +                       if (is_module_address((unsigned long)key)) {
> +                               /*
> +                                * The trampoline should no longer be used.
> +                                * Poison it it with a BUG() to catch any stray
> +                                * callers.
> +                                */
> +                               arch_static_call_poison_tramp(addr);
> +                       }
> +               }
> +
> +               arch_static_call_transform(addr, key->func);
> +       }
> +
> +       return 0;
> +}
> +
> +static void static_call_del_module(struct module *mod)
> +{
> +       struct static_call_site *start = mod->static_call_sites;
> +       struct static_call_site *stop = mod->static_call_sites +
> +                                       mod->num_static_call_sites;
> +       struct static_call_site *site;
> +       struct static_call_key *key, *prev_key = NULL;
> +       struct static_call_mod *static_call_mod;
> +
> +       for (site = start; site < stop; site++) {
> +               key = static_call_key(site);
> +               if (key == prev_key)
> +                       continue;
> +               prev_key = key;
> +
> +               list_for_each_entry(static_call_mod, &key->site_mods, list) {
> +                       if (static_call_mod->mod == mod) {
> +                               list_del(&static_call_mod->list);
> +                               kfree(static_call_mod);
> +                               break;
> +                       }
> +               }
> +       }
> +}
> +
> +static int static_call_module_notify(struct notifier_block *nb,
> +                                    unsigned long val, void *data)
> +{
> +       struct module *mod = data;
> +       int ret = 0;
> +
> +       cpus_read_lock();
> +       static_call_lock();
> +
> +       switch (val) {
> +       case MODULE_STATE_COMING:
> +               ret = static_call_add_module(mod);
> +               if (ret) {
> +                       WARN(1, "Failed to allocate memory for static calls");
> +                       static_call_del_module(mod);
> +               }
> +               break;
> +       case MODULE_STATE_GOING:
> +               static_call_del_module(mod);
> +               break;
> +       }
> +
> +       static_call_unlock();
> +       cpus_read_unlock();
> +
> +       return notifier_from_errno(ret);
> +}
> +
> +static struct notifier_block static_call_module_nb = {
> +       .notifier_call = static_call_module_notify,
> +};
> +
> +#endif /* CONFIG_MODULES */
> +
> +static void __init static_call_init(void)
> +{
> +       struct static_call_site *start = __start_static_call_sites;
> +       struct static_call_site *stop  = __stop_static_call_sites;
> +       struct static_call_site *site;
> +
> +       if (start == stop) {
> +               pr_warn("WARNING: empty static call table\n");
> +               return;
> +       }
> +
> +       cpus_read_lock();
> +       static_call_lock();
> +
> +       static_call_sort_entries(start, stop);
> +
> +       for (site = start; site < stop; site++) {
> +               struct static_call_key *key = static_call_key(site);
> +               unsigned long addr = static_call_addr(site);
> +
> +               if (list_empty(&key->site_mods)) {
> +                       struct static_call_mod *mod;
> +
> +                       mod = kzalloc(sizeof(*mod), GFP_KERNEL);
> +                       if (!mod) {
> +                               WARN(1, "Failed to allocate memory for static calls");
> +                               return;
> +                       }
> +
> +                       mod->sites = site;
> +                       list_add_tail(&mod->list, &key->site_mods);
> +
> +                       /*
> +                        * The trampoline should no longer be used.  Poison it
> +                        * it with a BUG() to catch any stray callers.
> +                        */
> +                       arch_static_call_poison_tramp(addr);
> +               }
> +
> +               arch_static_call_transform(addr, key->func);
> +       }
> +
> +       static_call_initialized = true;
> +
> +       static_call_unlock();
> +       cpus_read_unlock();
> +
> +#ifdef CONFIG_MODULES
> +       register_module_notifier(&static_call_module_nb);
> +#endif
> +}
> +early_initcall(static_call_init);
> --
> 2.17.2
>
