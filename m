Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,TRACKER_ID,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957B0C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F30624456
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhAHNF03"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F30624456
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754299AbeFVPEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 11:04:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754269AbeFVPEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 11:04:22 -0400
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com [74.125.82.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39E432445B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 15:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529679861;
        bh=jGxCLxQWNPc0Ad+MggeFu8A7bIfGYrFA4Bi3PMNYnxA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RhAHNF03J/URiLgT7llGZl6yT25JkSQdg21fOuJDJm0sHQqOJLGj7Hy8RdKRp0ete
         6izE9G3GZTgB3gVTm3LUHbeoV9DbOzTFGd+B3u9dhxmctoq6FtevO/ZkbLRkJ/VoGU
         vZ8vRpiBAbnfcf7cmvC94hbNRQtZudSogL+/WYZI=
Received: by mail-wm0-f51.google.com with SMTP id v131-v6so3000954wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 08:04:21 -0700 (PDT)
X-Gm-Message-State: APt69E002WkP7RX9g6JDBYF5y63BkUY6tNfScljPINHUKABHZd5IzXPz
        asm34/N5wrxYLjqxRCC2ZIoBwfPXBuMHAJuh/NMYmA==
X-Google-Smtp-Source: ADUXVKJVZ7HT6GES4o+LQqceoctoDpESFXBDdxCjbGxsZmX1mj0OMFz+HIBVGzHPwkI+o17EMKT36XCh5occiJUbvp4=
X-Received: by 2002:a1c:f30f:: with SMTP id q15-v6mr1934222wmq.36.1529679859643;
 Fri, 22 Jun 2018 08:04:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180620195652.27251-1-riel@surriel.com> <20180620195652.27251-5-riel@surriel.com>
In-Reply-To: <20180620195652.27251-5-riel@surriel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 22 Jun 2018 08:04:07 -0700
X-Gmail-Original-Message-ID: <CALCETrVUgO3PYvwbV9BHbepcEZ=Lwqm8TkETuC5ijUC9h0AQ6Q@mail.gmail.com>
Message-ID: <CALCETrVUgO3PYvwbV9BHbepcEZ=Lwqm8TkETuC5ijUC9h0AQ6Q@mail.gmail.com>
Subject: Re: [PATCH 4/7] x86,tlb: make lazy TLB mode lazier
To:     Rik van Riel <riel@surriel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, 86@vger.kernel.org,
        Andrew Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mike Galbraith <efault@gmx.de>, songliubraving@fb.com,
        kernel-team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 12:57 PM Rik van Riel <riel@surriel.com> wrote:
>
> Lazy TLB mode can result in an idle CPU being woken up by a TLB flush,
> when all it really needs to do is reload %CR3 at the next context switch,
> assuming no page table pages got freed.
>
> This patch deals with that issue by introducing a third TLB state,
> TLBSTATE_FLUSH, which causes %CR3 to be reloaded at the next context
> switch.
>
> Atomic compare and exchange is used to close races between the TLB
> shootdown code and the context switch code. Keying off just the
> tlb_gen is likely to not be enough, since that would not give
> lazy_clb_can_skip_flush() information on when it is facing a race
> and has to send the IPI to a CPU in the middle of a LAZY -> OK switch.
>
> Unlike the 2016 version of this patch, CPUs in TLBSTATE_LAZY are not
> removed from the mm_cpumask(mm), since that would prevent the TLB
> flush IPIs at page table free time from being sent to all the CPUs
> that need them.

Eek, this is so complicated.  In the 2016 version of the patches, you
needed all this.  But I rewrote the whole subsystem to make it easier
now :)  I think that you can get rid of all of this and instead just
revert the relevant parts of:

b956575bed91ecfb136a8300742ecbbf451471ab

All the bookkeeping is already in place -- no need for new state.


>
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Tested-by: Song Liu <songliubraving@fb.com>
> ---
>  arch/x86/include/asm/tlbflush.h |   5 ++
>  arch/x86/include/asm/uv/uv.h    |   6 +--
>  arch/x86/mm/tlb.c               | 108 ++++++++++++++++++++++++++++++++++++----
>  arch/x86/platform/uv/tlb_uv.c   |   2 +-
>  4 files changed, 107 insertions(+), 14 deletions(-)
>
> diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
> index 88a4d6b87ff7..0a8bdd6084de 100644
> --- a/arch/x86/include/asm/tlbflush.h
> +++ b/arch/x86/include/asm/tlbflush.h
> @@ -171,6 +171,7 @@ struct tlb_context {
>
>  #define TLBSTATE_OK    0
>  #define TLBSTATE_LAZY  1
> +#define TLBSTATE_FLUSH 2
>
>  struct tlb_state {
>         /*
> @@ -199,6 +200,10 @@ struct tlb_state {
>          *    We're heuristically guessing that the CR3 load we
>          *    skipped more than makes up for the overhead added by
>          *    lazy mode.
> +        *
> +        *  - Lazily using a real mm, which has seen a TLB invalidation on
> +        *    other CPUs. TLB needs to be flushed at context switch time,
> +        *    state == TLBSTATE_FLUSH.
>          */
>         int state;
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
> index e063e623e52c..4b27d8469848 100644
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
> @@ -227,8 +228,6 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
>                 __flush_tlb_all();
>         }
>  #endif
> -       this_cpu_write(cpu_tlbstate.state, TLBSTATE_OK);
> -
>         /*
>          * The membarrier system call requires a full memory barrier and
>          * core serialization before returning to user-space, after
> @@ -236,8 +235,11 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
>          * memory barrier and core serializing instruction.
>          */
>         if (real_prev == next) {
> +               int *tlbstate = this_cpu_ptr(&cpu_tlbstate.state);
> +               int oldstate = *tlbstate;
> +
>                 VM_WARN_ON(this_cpu_read(cpu_tlbstate.ctxs[prev_asid].ctx_id) !=
> -                          next->context.ctx_id);
> +                               next->context.ctx_id);
>
>                 /*
>                  * We don't currently support having a real mm loaded without
> @@ -250,6 +252,26 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
>                                  !cpumask_test_cpu(cpu, mm_cpumask(next))))
>                         cpumask_set_cpu(cpu, mm_cpumask(next));
>
> +               /*
> +                * In lazy TLB mode. The atomic exchange makes sure there was
> +                * no TLB shootdown all the way to this context switch.
> +                */
> +               if (oldstate == TLBSTATE_LAZY)
> +                       oldstate = cmpxchg(tlbstate, oldstate, TLBSTATE_OK);
> +
> +               /*
> +                * There was a TLB invalidation while this CPU was idle.
> +                * The code in choose_new_asid will figure out what kind
> +                * of flush is needed.
> +                */
> +               if (oldstate == TLBSTATE_FLUSH)
> +                       goto reload_cr3;
> +
> +               /*
> +                * Nothing to do. Either we are switching between two
> +                * threads in the same process, or we were in TLBSTATE_LAZY
> +                * without any TLB invalidations happening.
> +                */
>                 return;
>         } else {
>                 u16 new_asid;
> @@ -294,6 +316,8 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
>                  * Start remote flushes and then read tlb_gen.
>                  */
>                 cpumask_set_cpu(cpu, mm_cpumask(next));
> + reload_cr3:
> +               this_cpu_write(cpu_tlbstate.state, TLBSTATE_OK);
>                 next_tlb_gen = atomic64_read(&next->context.tlb_gen);
>
>                 choose_new_asid(next, next_tlb_gen, &new_asid, &need_flush);
> @@ -454,6 +478,9 @@ static void flush_tlb_func_common(const struct flush_tlb_info *f,
>                  * paging-structure cache to avoid speculatively reading
>                  * garbage into our TLB.  Since switching to init_mm is barely
>                  * slower than a minimal flush, just switch to init_mm.
> +                *
> +                * This should be rare, with native_flush_tlb_others skipping
> +                * IPIs to lazy TLB mode CPUs.
>                  */
>                 switch_mm_irqs_off(NULL, &init_mm, NULL);
>                 return;
> @@ -557,9 +584,57 @@ static void flush_tlb_func_remote(void *info)
>         flush_tlb_func_common(f, false, TLB_REMOTE_SHOOTDOWN);
>  }
>
> +/*
> + * Determine whether a CPU's TLB needs to be flushed now, or whether the
> + * flush can be delayed until the next context switch, by changing the
> + * tlbstate from TLBSTATE_LAZY to TLBSTATE_FLUSH.
> + */
> +static bool lazy_tlb_can_skip_flush(int cpu)
> +{
> +       int *tlbstate = &per_cpu(cpu_tlbstate.state, cpu);
> +       int old;
> +
> +       switch (*tlbstate) {
> +       case TLBSTATE_FLUSH:
> +               /* The TLB will be flushed on the next context switch. */
> +               return true;
> +       case TLBSTATE_LAZY:
> +               /*
> +                * The CPU is in TLBSTATE_LAZY, which could context switch back
> +                * to TLBSTATE_OK, re-using the old TLB state without a flush.
> +                * if that happened, send a TLB flush IPI.
> +                *
> +                * Otherwise, the state is now TLBSTATE_FLUSH, and TLB will
> +                * be flushed at the next context switch. Skip the IPI.
> +                */
> +               old = cmpxchg(tlbstate, TLBSTATE_LAZY, TLBSTATE_FLUSH);
> +               return old != TLBSTATE_OK;
> +       case TLBSTATE_OK:
> +       default:
> +               /* A task on the CPU is actively using the mm. Flush the TLB. */
> +               return false;
> +       }
> +}
> +
>  void native_flush_tlb_others(const struct cpumask *cpumask,
>                              const struct flush_tlb_info *info)
>  {
> +       cpumask_t *mask = (struct cpumask *)cpumask;
> +       cpumask_var_t varmask;
> +       bool can_lazy_flush = false;
> +       unsigned int cpu;
> +
> +       /*
> +        * A temporary cpumask allows the kernel to skip sending IPIs
> +        * to CPUs in lazy TLB state, without also removing them from
> +        * mm_cpumask(mm).
> +        */
> +       if (alloc_cpumask_var(&varmask, GFP_ATOMIC)) {
> +               cpumask_copy(varmask, cpumask);
> +               mask = varmask;
> +               can_lazy_flush = true;
> +       }
> +
>         count_vm_tlb_event(NR_TLB_REMOTE_FLUSH);
>         if (info->end == TLB_FLUSH_ALL)
>                 trace_tlb_flush(TLB_REMOTE_SEND_IPI, TLB_FLUSH_ALL);
> @@ -583,17 +658,30 @@ void native_flush_tlb_others(const struct cpumask *cpumask,
>                  * that UV should be updated so that smp_call_function_many(),
>                  * etc, are optimal on UV.
>                  */
> -               unsigned int cpu;
> -
>                 cpu = smp_processor_id();
> -               cpumask = uv_flush_tlb_others(cpumask, info);
> -               if (cpumask)
> -                       smp_call_function_many(cpumask, flush_tlb_func_remote,
> +               mask = uv_flush_tlb_others(mask, info);
> +               if (mask)
> +                       smp_call_function_many(mask, flush_tlb_func_remote,
>                                                (void *)info, 1);
> -               return;
> +               goto out;
> +       }
> +
> +       /*
> +        * Instead of sending IPIs to CPUs in lazy TLB mode, move that
> +        * CPU's TLB state to TLBSTATE_FLUSH, causing the TLB to be flushed
> +        * at the next context switch, or at page table free time.
> +        */
> +       if (can_lazy_flush) {
> +               for_each_cpu(cpu, mask) {
> +                       if (lazy_tlb_can_skip_flush(cpu))
> +                               cpumask_clear_cpu(cpu, mask);
> +               }
>         }
> -       smp_call_function_many(cpumask, flush_tlb_func_remote,
> +
> +       smp_call_function_many(mask, flush_tlb_func_remote,
>                                (void *)info, 1);
> + out:
> +       free_cpumask_var(varmask);
>  }
>
>  /*
> diff --git a/arch/x86/platform/uv/tlb_uv.c b/arch/x86/platform/uv/tlb_uv.c
> index b36caae0fb2f..42730acec8b7 100644
> --- a/arch/x86/platform/uv/tlb_uv.c
> +++ b/arch/x86/platform/uv/tlb_uv.c
> @@ -1102,7 +1102,7 @@ static int set_distrib_bits(struct cpumask *flush_mask, struct bau_control *bcp,
>   * Returns pointer to cpumask if some remote flushing remains to be
>   * done.  The returned pointer is valid till preemption is re-enabled.
>   */
> -const struct cpumask *uv_flush_tlb_others(const struct cpumask *cpumask,
> +struct cpumask *uv_flush_tlb_others(struct cpumask *cpumask,
>                                           const struct flush_tlb_info *info)
>  {
>         unsigned int cpu = smp_processor_id();
> --
> 2.14.4
>
