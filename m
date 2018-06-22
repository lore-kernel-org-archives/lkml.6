Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23081C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF08424449
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JfbBvsQG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF08424449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933684AbeFVO7A (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 10:59:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:51546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933346AbeFVO66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 10:58:58 -0400
Received: from mail-wr0-f178.google.com (mail-wr0-f178.google.com [209.85.128.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF9CD24452
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 14:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529679538;
        bh=YIcd25hItudbAnR3e8FxILsTG+/dNB6DB/hIccN71O0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JfbBvsQGFqsnnWFhp482qSA24lZWfYVxl5QsXj9xK+v9S/wRhJKKJGPuFCSfVzpx/
         hHnbUIlSmWu9J6CHmm4O1v3SL00cwTaislZDBKToR2Cl0qMY34i9MkMff5RXl2SqQp
         SiNgfnHqmOLDpsyTbq+4wzwdkaSghC4q99v1sju0=
Received: by mail-wr0-f178.google.com with SMTP id k16-v6so7034447wro.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 07:58:57 -0700 (PDT)
X-Gm-Message-State: APt69E2G0i8EV8p/3IwhdwGcZSkrhr896R9vL+TXYiWT2NOKp5fJi2bc
        d3wbRU3giSsigetsjMaSU8C3zFLMA4pqLQ0X/+MGPw==
X-Google-Smtp-Source: AAOMgpdfJrN0uNloee64i7W/NQfgy3Cf3uAGxzAlE2kcRwyLdeaFT/HCClMZ9dhl/if1HJZ5QtZwkxQk8e3eLQTEv2c=
X-Received: by 2002:adf:fe4c:: with SMTP id m12-v6mr1835256wrs.171.1529679536244;
 Fri, 22 Jun 2018 07:58:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180620195652.27251-1-riel@surriel.com> <20180620195652.27251-3-riel@surriel.com>
In-Reply-To: <20180620195652.27251-3-riel@surriel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 22 Jun 2018 07:58:43 -0700
X-Gmail-Original-Message-ID: <CALCETrX+EmeV5PxfwDwO=W4Deu9T_nPj5WbQX0mgxMV08vN=tg@mail.gmail.com>
Message-ID: <CALCETrX+EmeV5PxfwDwO=W4Deu9T_nPj5WbQX0mgxMV08vN=tg@mail.gmail.com>
Subject: Re: [PATCH 2/7] x86,tlb: leave lazy TLB mode at page table free time
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
> Andy discovered that speculative memory accesses while in lazy
> TLB mode can crash a system, when a CPU tries to dereference a
> speculative access using memory contents that used to be valid
> page table memory, but have since been reused for something else
> and point into la-la land.
>
> The latter problem can be prevented in two ways. The first is to
> always send a TLB shootdown IPI to CPUs in lazy TLB mode, while
> the second one is to only send the TLB shootdown at page table
> freeing time.
>
> The second should result in fewer IPIs, since operationgs like
> mprotect and madvise are very common with some workloads, but
> do not involve page table freeing. Also, on munmap, batching
> of page table freeing covers much larger ranges of virtual
> memory than the batching of unmapped user pages.
>
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Tested-by: Song Liu <songliubraving@fb.com>
> ---
>  arch/x86/include/asm/tlbflush.h |  5 +++++
>  arch/x86/mm/tlb.c               | 24 ++++++++++++++++++++++++
>  include/asm-generic/tlb.h       | 10 ++++++++++
>  mm/memory.c                     | 22 ++++++++++++++--------
>  4 files changed, 53 insertions(+), 8 deletions(-)
>
> diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
> index 6690cd3fc8b1..3aa3204b5dc0 100644
> --- a/arch/x86/include/asm/tlbflush.h
> +++ b/arch/x86/include/asm/tlbflush.h
> @@ -554,4 +554,9 @@ extern void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
>         native_flush_tlb_others(mask, info)
>  #endif
>
> +extern void tlb_flush_remove_tables(struct mm_struct *mm);
> +extern void tlb_flush_remove_tables_local(void *arg);
> +
> +#define HAVE_TLB_FLUSH_REMOVE_TABLES
> +
>  #endif /* _ASM_X86_TLBFLUSH_H */
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index e055d1a06699..61773b07ed54 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -646,6 +646,30 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
>         put_cpu();
>  }
>
> +void tlb_flush_remove_tables_local(void *arg)
> +{
> +       struct mm_struct *mm = arg;
> +
> +       if (this_cpu_read(cpu_tlbstate.loaded_mm) == mm &&
> +                       this_cpu_read(cpu_tlbstate.is_lazy))
> +               /*
> +                * We're in lazy mode.  We need to at least flush our
> +                * paging-structure cache to avoid speculatively reading
> +                * garbage into our TLB.  Since switching to init_mm is barely
> +                * slower than a minimal flush, just switch to init_mm.
> +                */
> +               switch_mm_irqs_off(NULL, &init_mm, NULL);

Can you add braces?

> +}
> +
> +void tlb_flush_remove_tables(struct mm_struct *mm)
> +{
> +       int cpu = get_cpu();
> +       /*
> +        * XXX: this really only needs to be called for CPUs in lazy TLB mode.
> +        */
> +       if (cpumask_any_but(mm_cpumask(mm), cpu) < nr_cpu_ids)
> +               smp_call_function_many(mm_cpumask(mm), tlb_flush_remove_tables_local, (void *)mm, 1);

I suspect that most if the gain will come from fixing this limitation :)
