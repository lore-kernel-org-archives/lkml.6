Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A07EC282D8
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 02:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1907420855
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 02:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549076269;
	bh=emiNIlH/C1NJBSwDXaqPG2ZpVwXA18IE3cNzje2PF8Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=EfM1p+PdhGFyjfye2vFIl5w571qSRlZ2ApGe8aB94B8kG9RvNCmORtGUwMXfXGEVZ
	 LSQCw7SPQAqp0nO8C8bULsg3OaJPl9IDCFlHe6IlNUmnb4Xjq4v23+WUogjiCHTasF
	 dEdAok/2Tb4mG0z8wSV9oRGlCRRF19xXkwPctVZM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfBBC5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 21:57:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:58064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbfBBC5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 21:57:46 -0500
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC57A20855
        for <linux-kernel@vger.kernel.org>; Sat,  2 Feb 2019 02:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549076265;
        bh=emiNIlH/C1NJBSwDXaqPG2ZpVwXA18IE3cNzje2PF8Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yErfo/uKg84/dm9GFuh9J+gRDyqs1dkoLSayaC8p7VVNzdwK/hUxs+BauWscR9CRk
         c376SlPqcljcmEGXJMsoD9iC79Rngikk+TO5d0PDutqOGuyaa5/ROnPvLIzAt/VVrH
         IiMJaQKmRk9HIqy4vQIfArbc4intxdSpKpY4nCSg=
Received: by mail-wr1-f48.google.com with SMTP id t6so9007743wrr.12
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 18:57:44 -0800 (PST)
X-Gm-Message-State: AJcUukeXHGtF7rXWvAs+vVxpSWiP6zFR3sk4ObMWjyyPmEOUnAQx360w
        +Qkt09I4+lMwHuGGrWxN/QNOCrKMsAvefhtALuaNnA==
X-Google-Smtp-Source: ALg8bN4zaaU8M9QY7tm2JTnDsuRDAeEReNGxnH1kIIo6VwHCRjBzdmP5tEMy4m+ylRZa86MrZGt17qnoVh2a1owyzRU=
X-Received: by 2002:a5d:550f:: with SMTP id b15mr42173802wrv.330.1549076263497;
 Fri, 01 Feb 2019 18:57:43 -0800 (PST)
MIME-Version: 1.0
References: <20190201205319.15995-1-chang.seok.bae@intel.com> <20190201205319.15995-7-chang.seok.bae@intel.com>
In-Reply-To: <20190201205319.15995-7-chang.seok.bae@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 1 Feb 2019 18:57:32 -0800
X-Gmail-Original-Message-ID: <CALCETrUFF3AcO7n_SWs--9YQ=05Swpq5zqjcjWb8_mOLJDRwZw@mail.gmail.com>
Message-ID: <CALCETrUFF3AcO7n_SWs--9YQ=05Swpq5zqjcjWb8_mOLJDRwZw@mail.gmail.com>
Subject: Re: [PATCH v5 05/13] x86/fsgsbase/64: Enable FSGSBASE instructions in
 the helper functions
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 1, 2019 at 12:54 PM Chang S. Bae <chang.seok.bae@intel.com> wrote:
>
> The helper functions will switch on faster accesses to FSBASE and GSBASE
> when the FSGSBASE feature is enabled.
>
> Accessing user GSBASE needs a couple of SWAPGS operations. It is avoidable
> if the user GSBASE is saved at kernel entry, being updated as changes, and
> restored back at kernel exit. However, it seems to spend more cycles for
> savings and restorations. Little or no benefit was measured from
> experiments.
>
> Also, introduce __{rd,wr}gsbase_inactive() as helpers to access user GSBASE
> with SWAPGS. Note, for Xen PV, paravirt hooks can be added, since it may
> allow a very efficient but different implementation.
>
> [ Use NOKPROBE_SYMBOL instead of __kprobes ]

^^^ This line looks like it shold be deleted.

>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Cc: Any Lutomirski <luto@kernel.org>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Andrew Cooper <andrew.cooper3@citrix.com>
> ---
>  arch/x86/include/asm/fsgsbase.h | 27 +++++++-------
>  arch/x86/kernel/process_64.c    | 62 +++++++++++++++++++++++++++++++--
>  2 files changed, 72 insertions(+), 17 deletions(-)
>
> diff --git a/arch/x86/include/asm/fsgsbase.h b/arch/x86/include/asm/fsgsbase.h
> index fdd1177499b4..aefd53767a5d 100644
> --- a/arch/x86/include/asm/fsgsbase.h
> +++ b/arch/x86/include/asm/fsgsbase.h
> @@ -49,35 +49,32 @@ static __always_inline void wrgsbase(unsigned long gsbase)
>         asm volatile("wrgsbase %0" :: "r" (gsbase) : "memory");
>  }
>
> +#include <asm/cpufeature.h>
> +
>  /* Helper functions for reading/writing FS/GS base */
>
>  static inline unsigned long x86_fsbase_read_cpu(void)
>  {
>         unsigned long fsbase;
>
> -       rdmsrl(MSR_FS_BASE, fsbase);
> +       if (static_cpu_has(X86_FEATURE_FSGSBASE))
> +               fsbase = rdfsbase();
> +       else
> +               rdmsrl(MSR_FS_BASE, fsbase);
>
>         return fsbase;
>  }
>
> -static inline unsigned long x86_gsbase_read_cpu_inactive(void)
> -{
> -       unsigned long gsbase;
> -
> -       rdmsrl(MSR_KERNEL_GS_BASE, gsbase);
> -
> -       return gsbase;
> -}
> -
>  static inline void x86_fsbase_write_cpu(unsigned long fsbase)
>  {
> -       wrmsrl(MSR_FS_BASE, fsbase);
> +       if (static_cpu_has(X86_FEATURE_FSGSBASE))
> +               wrfsbase(fsbase);
> +       else
> +               wrmsrl(MSR_FS_BASE, fsbase);
>  }
>
> -static inline void x86_gsbase_write_cpu_inactive(unsigned long gsbase)
> -{
> -       wrmsrl(MSR_KERNEL_GS_BASE, gsbase);
> -}
> +extern unsigned long x86_gsbase_read_cpu_inactive(void);
> +extern void x86_gsbase_write_cpu_inactive(unsigned long gsbase);
>
>  #endif /* CONFIG_X86_64 */
>
> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
> index 6a62f4af9fcf..ebc55ed31fe7 100644
> --- a/arch/x86/kernel/process_64.c
> +++ b/arch/x86/kernel/process_64.c
> @@ -160,6 +160,42 @@ enum which_selector {
>         GS
>  };
>
> +/*
> + * Interrupts are disabled here. Out of line to be protected
> + * from kprobes. It is not used on Xen paravirt. When paravirt
> + * support is needed, it needs to be renamed with native_ prefix.
> + */
> +static noinline unsigned long __rdgsbase_inactive(void)
> +{
> +       unsigned long gsbase, flags;
> +
> +       local_irq_save(flags);
> +       native_swapgs();
> +       gsbase = rdgsbase();
> +       native_swapgs();
> +       local_irq_restore(flags);
> +
> +       return gsbase;
> +}
> +NOKPROBE_SYMBOL(__rdgsbase_inactive);
> +
> +/*
> + * Interrupts are disabled here. Out of line to be protected
> + * from kprobes. It is not used on Xen paravirt. When paravirt
> + * support is needed, it needs to be renamed with native_ prefix.
> + */
> +static noinline void __wrgsbase_inactive(unsigned long gsbase)
> +{
> +       unsigned long flags;
> +
> +       local_irq_save(flags);
> +       native_swapgs();
> +       wrgsbase(gsbase);
> +       native_swapgs();
> +       local_irq_restore(flags);
> +}
> +NOKPROBE_SYMBOL(__wrgsbase_inactive);
> +
>  /*
>   * Saves the FS or GS base for an outgoing thread if FSGSBASE extensions are
>   * not available.  The goal is to be reasonably fast on non-FSGSBASE systems.
> @@ -338,13 +374,34 @@ static unsigned long x86_fsgsbase_read_task(struct task_struct *task,
>         return base;
>  }
>
> +unsigned long x86_gsbase_read_cpu_inactive(void)
> +{
> +       unsigned long gsbase;
> +
> +       if (static_cpu_has(X86_FEATURE_FSGSBASE))
> +               gsbase = __rdgsbase_inactive();
> +       else
> +               rdmsrl(MSR_KERNEL_GS_BASE, gsbase);
> +
> +       return gsbase;
> +}
> +
> +void x86_gsbase_write_cpu_inactive(unsigned long gsbase)
> +{
> +       if (static_cpu_has(X86_FEATURE_FSGSBASE))
> +               __wrgsbase_inactive(gsbase);
> +       else
> +               wrmsrl(MSR_KERNEL_GS_BASE, gsbase);
> +}
> +
>  unsigned long x86_fsbase_read_task(struct task_struct *task)
>  {
>         unsigned long fsbase;
>
>         if (task == current)
>                 fsbase = x86_fsbase_read_cpu();
> -       else if (task->thread.fsindex == 0)
> +       else if (static_cpu_has(X86_FEATURE_FSGSBASE) ||
> +                (task->thread.fsindex == 0))
>                 fsbase = task->thread.fsbase;
>         else
>                 fsbase = x86_fsgsbase_read_task(task, task->thread.fsindex);
> @@ -358,7 +415,8 @@ unsigned long x86_gsbase_read_task(struct task_struct *task)
>
>         if (task == current)
>                 gsbase = x86_gsbase_read_cpu_inactive();
> -       else if (task->thread.gsindex == 0)
> +       else if (static_cpu_has(X86_FEATURE_FSGSBASE) ||
> +                (task->thread.gsindex == 0))
>                 gsbase = task->thread.gsbase;
>         else
>                 gsbase = x86_fsgsbase_read_task(task, task->thread.gsindex);

These last two hunks changes do not belong in this patch.  Presumably
they belong in patch 6.

--Andy



> --
> 2.19.1
>
