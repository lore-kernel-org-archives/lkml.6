Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88645C32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 01:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA9AD2086A
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 01:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VY9nmx3Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA9AD2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389108AbeKGKvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 05:51:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:47628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388065AbeKGKvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 05:51:45 -0500
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E56A72086A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Nov 2018 01:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541553819;
        bh=/ffvoaHuyhxjOs0IGKN2rDC5c3iTPKbnVcIZ6KCEaCc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VY9nmx3YCfm3zeajMcdacuHxYe+90U5lz90JrzwlMGGLrcxAY9XtoEJgkPR6uPy89
         wvM4t1f7uNeAy9giRpIjCjpTMa4M+Zci9AqSZqPf8fx4MlC4dZ1Krqts/p1n9XaJDQ
         P1MwG9h+Kqhtz1SInCCmW/cMbrCNnTIDjDij4Kfo=
Received: by mail-wr1-f43.google.com with SMTP id u9-v6so5287958wrr.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 17:23:38 -0800 (PST)
X-Gm-Message-State: AGRZ1gKQn5/Vy3nEqg7Cm9WbA2W14qL3TUBE0usg1IWwFLvW5v9pyeQ/
        C/c4ix51lWdtx1B2KvrjkCeuXt3IRtJ1jtbqh8IddA==
X-Google-Smtp-Source: AJdET5fqe7UjwLNsBmnDyF0sI6Z9qOVe/dWwQTnOr/LZe/OKxX8SF9NUHLKZg5Sjx1IGglQ9wTXkZ2t65NJe0QcqiSI=
X-Received: by 2002:adf:97d3:: with SMTP id t19-v6mr27012685wrb.283.1541553817445;
 Tue, 06 Nov 2018 17:23:37 -0800 (PST)
MIME-Version: 1.0
References: <20181101203129.27494-1-chang.seok.bae@intel.com>
In-Reply-To: <20181101203129.27494-1-chang.seok.bae@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 6 Nov 2018 17:23:26 -0800
X-Gmail-Original-Message-ID: <CALCETrXCOgBk7oKrE_CAspA6eqC19CfXckgeCcWUjREVHRHRPg@mail.gmail.com>
Message-ID: <CALCETrXCOgBk7oKrE_CAspA6eqC19CfXckgeCcWUjREVHRHRPg@mail.gmail.com>
Subject: Re: [PATCH v3] x86/fsgsbase/64: Fix the base write helper functions
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 1:32 PM Chang S. Bae <chang.seok.bae@intel.com> wrote:
>
> The helper functions that purport to write the base should just write it
> only. It shouldn't have magic optimizations to change the index.
>
> Make the index explicitly changed from the caller, instead of including
> the code in the helpers.
>
> v2: Fix further on the task write functions. Revert the changes on the
> task read helpers.
>
> v3: Fix putreg(). Edit the changelog.
>
> Suggested-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> ---
>  arch/x86/kernel/process_64.c | 48 ++++++++++++++++++++++--------------
>  arch/x86/kernel/ptrace.c     |  8 +++---
>  2 files changed, 34 insertions(+), 22 deletions(-)
>
> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
> index 31b4755369f0..ad849ce9cb73 100644
> --- a/arch/x86/kernel/process_64.c
> +++ b/arch/x86/kernel/process_64.c
> @@ -339,19 +339,11 @@ static unsigned long x86_fsgsbase_read_task(struct task_struct *task,
>
>  void x86_fsbase_write_cpu(unsigned long fsbase)
>  {
> -       /*
> -        * Set the selector to 0 as a notion, that the segment base is
> -        * overwritten, which will be checked for skipping the segment load
> -        * during context switch.
> -        */
> -       loadseg(FS, 0);
>         wrmsrl(MSR_FS_BASE, fsbase);
>  }
>
>  void x86_gsbase_write_cpu_inactive(unsigned long gsbase)
>  {
> -       /* Set the selector to 0 for the same reason as %fs above. */
> -       loadseg(GS, 0);
>         wrmsrl(MSR_KERNEL_GS_BASE, gsbase);
>  }
>
> @@ -392,12 +384,7 @@ int x86_fsbase_write_task(struct task_struct *task, unsigned long fsbase)
>         if (unlikely(fsbase >= TASK_SIZE_MAX))
>                 return -EPERM;
>
> -       preempt_disable();
>         task->thread.fsbase = fsbase;
> -       if (task == current)
> -               x86_fsbase_write_cpu(fsbase);
> -       task->thread.fsindex = 0;
> -       preempt_enable();
>
>         return 0;
>  }

Similar objection to last time.  If you get rid of the task == current
check, you should WARN_ON_ONCE(task != current).

> @@ -407,12 +394,7 @@ int x86_gsbase_write_task(struct task_struct *task, unsigned long gsbase)
>         if (unlikely(gsbase >= TASK_SIZE_MAX))
>                 return -EPERM;
>
> -       preempt_disable();
>         task->thread.gsbase = gsbase;
> -       if (task == current)
> -               x86_gsbase_write_cpu_inactive(gsbase);
> -       task->thread.gsindex = 0;
> -       preempt_enable();
>
>         return 0;
>  }
> @@ -758,11 +740,41 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
>
>         switch (option) {
>         case ARCH_SET_GS: {
> +               preempt_disable();
>                 ret = x86_gsbase_write_task(task, arg2);
> +               if (ret == 0) {
> +                       /*
> +                        * ARCH_SET_GS has always overwritten the index
> +                        * and the base. Zero is the most sensible value
> +                        * to put in the index, and is the only value that
> +                        * makes any sense if FSGSBASE is unavailable.
> +                        */
> +                       if (task == current) {
> +                               loadseg(GS, 0);
> +                               x86_gsbase_write_cpu_inactive(arg2);
> +                       } else {
> +                               task->thread.gsindex = 0;
> +                       }
> +               }
> +               preempt_enable();

And you should drop the redundant ...write_task if task == current.

>                 break;
>         }
>         case ARCH_SET_FS: {
> +               preempt_disable();
>                 ret = x86_fsbase_write_task(task, arg2);
> +               if (ret == 0) {
> +                       /*
> +                        * Set the selector to 0 for the same reason
> +                        * as %gs above.
> +                        */
> +                       if (task == current) {
> +                               loadseg(FS, 0);
> +                               x86_fsbase_write_cpu(arg2);
> +                       } else {
> +                               task->thread.fsindex = 0;
> +                       }
> +               }
> +               preempt_enable();
>                 break;
>         }
>         case ARCH_GET_FS: {
> diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
> index ffae9b9740fd..e4ab1abca5b5 100644
> --- a/arch/x86/kernel/ptrace.c
> +++ b/arch/x86/kernel/ptrace.c
> @@ -397,11 +397,11 @@ static int putreg(struct task_struct *child,
>                 if (value >= TASK_SIZE_MAX)
>                         return -EIO;
>                 /*
> -                * When changing the FS base, use the same
> -                * mechanism as for do_arch_prctl_64().
> +                * When changing the FS base, use do_arch_prctl_64()
> +                * to set the index and the base.

to set the index to zero and to set the base as requested.

>                  */
>                 if (child->thread.fsbase != value)
> -                       return x86_fsbase_write_task(child, value);
> +                       return do_arch_prctl_64(child, ARCH_SET_FS, value);
>                 return 0;
>         case offsetof(struct user_regs_struct,gs_base):
>                 /*
> @@ -410,7 +410,7 @@ static int putreg(struct task_struct *child,
>                 if (value >= TASK_SIZE_MAX)
>                         return -EIO;
>                 if (child->thread.gsbase != value)
> -                       return x86_gsbase_write_task(child, value);
> +                       return do_arch_prctl_64(child, ARCH_SET_GS, value);
>                 return 0;
>  #endif
>         }
> --
> 2.19.1
>
