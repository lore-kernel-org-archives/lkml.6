Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752802AbeAaUYt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 15:24:49 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36692 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752311AbeAaUYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 15:24:47 -0500
X-Google-Smtp-Source: AH8x224mXhgrIONAOUtxJq7z4K8Uen+LduR0qvdYv80qXwwYkokC9PDTfc4uqTLa50SzZfXCE9IrTw==
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] x86: Align TLB invalidation info
From: Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15C202)
In-Reply-To: <20180131201118.1694-1-namit@vmware.com>
Date: Wed, 31 Jan 2018 12:24:44 -0800
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <nadav.amit@gmail.com>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Message-Id: <BD28D2CF-CAD7-45A1-87D0-DE38F7B0EFE5@amacapital.net>
References: <20180131201118.1694-1-namit@vmware.com>
To: Nadav Amit <namit@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w0VKPjO9020368



> On Jan 31, 2018, at 12:11 PM, Nadav Amit <namit@vmware.com> wrote:
> 
> The TLB invalidation info is allocated on the stack, which might cause
> it to be unaligned. Since this information may be transferred to
> different cores for TLB shootdown, this might result in an additional
> cache-line bouncing between the cores.
> 
> GCC provides a way to deal with it by using
> __builtin_alloca_with_align(). Use it to avoid the bouncing cache lines.
> 

Eww.  How about __aligned?


> Signed-off-by: Nadav Amit <namit@vmware.com>
> 
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> ---
> arch/x86/mm/tlb.c              | 21 +++++++++++----------
> include/linux/compiler-gcc.h   |  5 +++++
> include/linux/compiler_types.h |  4 ++++
> 3 files changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index 5bfe61a5e8e3..bab7bb5d982f 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -574,37 +574,38 @@ static unsigned long tlb_single_page_flush_ceiling __read_mostly = 33;
> void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
>                unsigned long end, unsigned long vmflag)
> {
> +    struct flush_tlb_info *info;
>    int cpu;
> 
> -    struct flush_tlb_info info = {
> -        .mm = mm,
> -    };
> +    info = __alloca_with_align(sizeof(*info),
> +                   SMP_CACHE_BYTES * BITS_PER_BYTE);
> +    info->mm = mm;
> 
>    cpu = get_cpu();
> 
>    /* This is also a barrier that synchronizes with switch_mm(). */
> -    info.new_tlb_gen = inc_mm_tlb_gen(mm);
> +    info->new_tlb_gen = inc_mm_tlb_gen(mm);
> 
>    /* Should we flush just the requested range? */
>    if ((end != TLB_FLUSH_ALL) &&
>        !(vmflag & VM_HUGETLB) &&
>        ((end - start) >> PAGE_SHIFT) <= tlb_single_page_flush_ceiling) {
> -        info.start = start;
> -        info.end = end;
> +        info->start = start;
> +        info->end = end;
>    } else {
> -        info.start = 0UL;
> -        info.end = TLB_FLUSH_ALL;
> +        info->start = 0UL;
> +        info->end = TLB_FLUSH_ALL;
>    }
> 
>    if (mm == this_cpu_read(cpu_tlbstate.loaded_mm)) {
>        VM_WARN_ON(irqs_disabled());
>        local_irq_disable();
> -        flush_tlb_func_local(&info, TLB_LOCAL_MM_SHOOTDOWN);
> +        flush_tlb_func_local(info, TLB_LOCAL_MM_SHOOTDOWN);
>        local_irq_enable();
>    }
> 
>    if (cpumask_any_but(mm_cpumask(mm), cpu) < nr_cpu_ids)
> -        flush_tlb_others(mm_cpumask(mm), &info);
> +        flush_tlb_others(mm_cpumask(mm), info);
> 
>    put_cpu();
> }
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index 631354acfa72..aea9a2e69417 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -314,6 +314,11 @@
> #define __designated_init __attribute__((designated_init))
> #endif
> 
> +#if GCC_VERSION >= 60100
> +#define __alloca_with_align(size, alignment)                \
> +    __builtin_alloca_with_align(size, alignment)
> +#endif
> +
> #endif    /* gcc version >= 40000 specific checks */
> 
> #if !defined(__noclone)
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 6b79a9bba9a7..c71297d95c74 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -271,4 +271,8 @@ struct ftrace_likely_data {
> # define __native_word(t) (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
> #endif
> 
> +#ifndef __alloca_with_align
> +#define __alloca_with_align(size, alignment) __builtin_alloca(size)
> +#endif
> +
> #endif /* __LINUX_COMPILER_TYPES_H */
> -- 
> 2.14.1
> 
