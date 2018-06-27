Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AD4C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 18:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 933E225E69
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 18:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0fUcX0E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 933E225E69
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935099AbeF0SLI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 14:11:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935039AbeF0SLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 14:11:07 -0400
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com [74.125.82.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAA9525F95
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 18:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530123067;
        bh=0zsBiXDKjSooAZXIGXIKgYtYRf9leQb6AaCmZVsqTAI=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=k0fUcX0ESLiq0BzTsGQcZwQWf8Purf6QAB0JuTjknnsg5fUrNusVTd0rS2FxhIdh5
         3ct6cThF6zDpj9Dl2szjXlMZuWbgLrRH2m99bRUstPGxcJsMdNuhSfEkJyJoZh8GIQ
         D2AShkiXdyx0EJJ81LAMBf+ajPv+c1OOIdW1JwXg=
Received: by mail-wm0-f52.google.com with SMTP id e16-v6so6818390wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 11:11:06 -0700 (PDT)
X-Gm-Message-State: APt69E2JiCRyDbyr+qXbczh7a6frv13YXFkTHFZtN2EPSUnaobsOf+0r
        u9p7XF5BU60HRpIZC9AWZyroTYz2mFqzw2jhtFZ7Xw==
X-Google-Smtp-Source: AAOMgpcgMu3il9Zm86RkGOqj+Q/cX5zXHKB+xlF9V9n721PNVmP9idlhnN2sXwjwf6pfbiduh6laiuNfAV1H2J9MjQw=
X-Received: by 2002:a1c:4a9d:: with SMTP id n29-v6mr5445208wmi.46.1530123065252;
 Wed, 27 Jun 2018 11:11:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:7e92:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 11:10:44
 -0700 (PDT)
In-Reply-To: <20180626173126.12296-4-riel@surriel.com>
References: <20180626173126.12296-1-riel@surriel.com> <20180626173126.12296-4-riel@surriel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 27 Jun 2018 11:10:44 -0700
X-Gmail-Original-Message-ID: <CALCETrVgDXe6NFCmxhyiwMEQmQqyidAh+wQBWeaCKg+z6jQOPw@mail.gmail.com>
Message-ID: <CALCETrVgDXe6NFCmxhyiwMEQmQqyidAh+wQBWeaCKg+z6jQOPw@mail.gmail.com>
Subject: Re: [PATCH 3/6] x86,tlb: make lazy TLB mode lazier
To:     Rik van Riel <riel@surriel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        kernel-team <kernel-team@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Galbraith <efault@gmx.de>, songliubraving@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 10:31 AM Rik van Riel <riel@surriel.com> wrote:
>
> Lazy TLB mode can result in an idle CPU being woken up by a TLB flush,
> when all it really needs to do is reload %CR3 at the next context switch,
> assuming no page table pages got freed.
>
> Memory ordering is used to prevent race conditions between switch_mm_irqs_off,
> which checks whether .tlb_gen changed, and the TLB invalidation code, which
> increments .tlb_gen whenever page table entries get invalidated.
>
> The atomic increment in inc_mm_tlb_gen is its own barrier; the context
> switch code adds an explicit barrier between reading tlbstate.is_lazy and
> next->context.tlb_gen.
>
> Unlike the 2016 version of this patch, CPUs with cpu_tlbstate.is_lazy set
> are not removed from the mm_cpumask(mm), since that would prevent the TLB
> flush IPIs at page table free time from being sent to all the CPUs
> that need them.
>
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Tested-by: Song Liu <songliubraving@fb.com>
> ---
>  arch/x86/include/asm/uv/uv.h  |   6 +-
>  arch/x86/mm/tlb.c             | 131 ++++++++++++++++++++++++++++--------------
>  arch/x86/platform/uv/tlb_uv.c |   2 +-
>  3 files changed, 92 insertions(+), 47 deletions(-)
>
> diff --git a/arch/x86/include/asm/uv/uv.h b/arch/x86/include/asm/uv/uv.h
> index a80c0673798f..d801afb5fe90 100644
> --- a/arch/x86/include/asm/uv/uv.h
> +++ b/arch/x86/include/asm/uv/uv.h
> @@ -17,7 +17,7 @@ extern int is_uv_hubless(void);
>  extern void uv_cpu_init(void);
>  extern void uv_nmi_init(void);
>  extern void uv_system_init(void);
> -extern const struct cpumask *uv_flush_tlb_others(const struct cpumask *cpumask,
> +extern struct cpumask *uv_flush_tlb_others(struct cpumask *cpumask,
>                                                  const struct flush_tlb_info *info);
>
>  #else  /* X86_UV */
> @@ -27,8 +27,8 @@ static inline int is_uv_system(void)  { return 0; }
>  static inline int is_uv_hubless(void)  { return 0; }
>  static inline void uv_cpu_init(void)   { }
>  static inline void uv_system_init(void)        { }
> -static inline const struct cpumask *
> -uv_flush_tlb_others(const struct cpumask *cpumask,
> +static inline struct cpumask *
> +uv_flush_tlb_others(struct cpumask *cpumask,
>                     const struct flush_tlb_info *info)
>  { return cpumask; }
>
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index 9a893673c56b..137a2c62c75b 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -7,6 +7,7 @@
>  #include <linux/export.h>
>  #include <linux/cpu.h>
>  #include <linux/debugfs.h>
> +#include <linux/gfp.h>
>
>  #include <asm/tlbflush.h>
>  #include <asm/mmu_context.h>
> @@ -185,8 +186,11 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
>  {
>         struct mm_struct *real_prev = this_cpu_read(cpu_tlbstate.loaded_mm);
>         u16 prev_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
> +       bool was_lazy = this_cpu_read(cpu_tlbstate.is_lazy);
>         unsigned cpu = smp_processor_id();
>         u64 next_tlb_gen;
> +       bool need_flush;
> +       u16 new_asid;
>
>         /*
>          * NB: The scheduler will call us with prev == next when switching
> @@ -250,10 +254,20 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
>                                  !cpumask_test_cpu(cpu, mm_cpumask(next))))
>                         cpumask_set_cpu(cpu, mm_cpumask(next));
>
> -               return;

You left this comment:

                /*
                 * We don't currently support having a real mm loaded without
                 * our cpu set in mm_cpumask().  We have all the bookkeeping
                 * in place to figure out whether we would need to flush
                 * if our cpu were cleared in mm_cpumask(), but we don't
                 * currently use it.
                 */

Presumably you should either clear the cpu from mm_cpumask when lazy
or you shoudl update the comment.

> +               /*
> +                * Switching straight from one thread in a process to another
> +                * thread in the same process requires no TLB flush at all.
> +                */
> +               if (!was_lazy)
> +                       return;

Comment doesn't match code.  Maybe add "... if we weren't lazy"?

> +
> +               /*
> +                * The code below checks whether there was a TLB flush while
> +                * this CPU was in lazy TLB mode. The barrier ensures ordering
> +                * with the TLB invalidation code advancing .tlb_gen.
> +                */
> +               smp_rmb();

I think it may need to be smp_mb().  You're trying to order
this_cpu_write() against subsequent reads.

In general, the changes to this function are very hard to review
because you're mixing semantic changes and restructuring the function.
Is there any way you could avoid that?  Or maybe just open-code a
tlb_gen check in the unlazying path?


> +       /*
> +        * Instead of sending IPIs to CPUs in lazy TLB mode, move that
> +        * CPU's TLB state to TLBSTATE_FLUSH, causing the TLB to be flushed
> +        * at the next context switch, or at page table free time.
> +        */

Stale comment?
