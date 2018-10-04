Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420DDC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A1B20652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXalJBsz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06A1B20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbeJDXIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 19:08:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:33802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727601AbeJDXIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 19:08:44 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D83012147C
        for <linux-kernel@vger.kernel.org>; Thu,  4 Oct 2018 16:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538669687;
        bh=tE9eGQSRA99v+7WGfZ2aVt6BBFG8QZKFnYZY+fznrFA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GXalJBsz/jFZTWnBogmMwyiGwfSEJAMersWdOppqA4CGgSzDzZLRIti7yWR3/tvuW
         +fsfe60FvbyW1KK+y6FhA8UNQe28/5/iJzqPTS+bvm5HlXnpLV2twH9G999X4ofU8v
         yRI+Olq8l1XC3g2i+fjVVCHR6w1eIKsqxXoOeQzY=
Received: by mail-wr1-f46.google.com with SMTP id 61-v6so9814722wrb.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 09:14:46 -0700 (PDT)
X-Gm-Message-State: ABuFfoiq6slBDKBaByQfP89D0juzC5rnQog+wwi7jZjUT6193y+EnNA0
        bqLtujD+Ui3l6xJml0HfOTUw6uY7S/a5HZ1UNx7cIg==
X-Google-Smtp-Source: ACcGV63xfVrku2b5pA5P3Xs/BlXnR/ahCzj7yls+4NNJaSanwThQSVscxOv342k7VIcAaGE/RwjqdoKel92FQ8uSbBg=
X-Received: by 2002:adf:82e3:: with SMTP id 90-v6mr5152565wrc.131.1538669685226;
 Thu, 04 Oct 2018 09:14:45 -0700 (PDT)
MIME-Version: 1.0
References: <20181004140547.13014-1-bigeasy@linutronix.de> <20181004140547.13014-12-bigeasy@linutronix.de>
In-Reply-To: <20181004140547.13014-12-bigeasy@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 4 Oct 2018 09:14:33 -0700
X-Gmail-Original-Message-ID: <CALCETrV01t-4gya0WEY0=R7XvuDA4dkf_pssfPZKDm9=1fCBmg@mail.gmail.com>
Message-ID: <CALCETrV01t-4gya0WEY0=R7XvuDA4dkf_pssfPZKDm9=1fCBmg@mail.gmail.com>
Subject: Re: [PATCH 11/11] x86/fpu: defer FPU state load until return to userspace
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 4, 2018 at 7:06 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> From: Rik van Riel <riel@surriel.com>
>
> Defer loading of FPU state until return to userspace. This gives
> the kernel the potential to skip loading FPU state for tasks that
> stay in kernel mode, or for tasks that end up with repeated
> invocations of kernel_fpu_begin.
>
> It also increases the chances that a task's FPU state will remain
> valid in the FPU registers until it is scheduled back in, allowing
> us to skip restoring that task's FPU state altogether.
>
> The __fpregs_changes_{begin|end}() section ensures that the register
> remain unchanged. Otherwise a context switch or a BH could save the
> registers to its FPU context and processor's FPU register would remain
> random.
> fpu__restore() has one user so I pulled that preempt_disable() part into
> fpu__restore(). While the function did *load* the registers, it now just
> makes sure that they are loaded on return to userland.
>
> KVM swaps the host/guest register on enry/exit path. I kept the flow as
> is. First it ensures that the registers are loaded and then saves the
> current (host) state before it loads the guest's register. Before
> entring the guest, it ensures that the register are still loaded.
>
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/x86/entry/common.c             |   9 +++
>  arch/x86/include/asm/fpu/api.h      |  11 +++
>  arch/x86/include/asm/fpu/internal.h |  25 ++++---
>  arch/x86/include/asm/trace/fpu.h    |   5 +-
>  arch/x86/kernel/fpu/core.c          | 108 ++++++++++++++++++++--------
>  arch/x86/kernel/fpu/signal.c        |   3 -
>  arch/x86/kernel/process.c           |   2 +-
>  arch/x86/kernel/process_32.c        |   7 +-
>  arch/x86/kernel/process_64.c        |   7 +-
>  arch/x86/kvm/x86.c                  |  18 +++--
>  10 files changed, 143 insertions(+), 52 deletions(-)
>
> diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> index 3b2490b819181..3dad5c3b335eb 100644
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -31,6 +31,7 @@
>  #include <asm/vdso.h>
>  #include <linux/uaccess.h>
>  #include <asm/cpufeature.h>
> +#include <asm/fpu/api.h>
>
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/syscalls.h>
> @@ -196,6 +197,14 @@ __visible inline void prepare_exit_to_usermode(struct pt_regs *regs)
>         if (unlikely(cached_flags & EXIT_TO_USERMODE_LOOP_FLAGS))
>                 exit_to_usermode_loop(regs, cached_flags);
>
> +       /* Reload ti->flags; we may have rescheduled above. */
> +       cached_flags = READ_ONCE(ti->flags);
> +
> +       if (unlikely(cached_flags & _TIF_LOAD_FPU))
> +               switch_fpu_return();
> +       else
> +               fpregs_is_state_consistent();

Shouldn't this be:

fpregs_assert_state_consistent();  /* see below */

if (unlikely(cached_flags & _TIF_LOAD_FPU))
  switch_fpu_return();

> diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
> index a9caac9d4a729..e3077860f7333 100644
> --- a/arch/x86/include/asm/fpu/api.h
> +++ b/arch/x86/include/asm/fpu/api.h
> @@ -27,6 +27,17 @@ extern void kernel_fpu_begin(void);
>  extern void kernel_fpu_end(void);
>  extern bool irq_fpu_usable(void);
>
> +#ifdef CONFIG_X86_DEBUG_FPU
> +extern void fpregs_is_state_consistent(void);
> +#else
> +static inline void fpregs_is_state_consistent(void) { }
> +#endif

Can you name this something like fpregs_assert_state_consistent()?
The "is" name makes it sound like it's:

bool fpregs_is_state_consistent();

and you're supposed to do:

WARN_ON(!fpregs_is_state_consistent());
