Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DE3C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 632CC218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="KjoDGxzf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbfAXNe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 08:34:57 -0500
Received: from mail.skyhub.de ([5.9.137.197]:33036 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727386AbfAXNe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 08:34:56 -0500
Received: from zn.tnic (p200300EC2BCBCF00ADE59F195E19AC34.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:cf00:ade5:9f19:5e19:ac34])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 900421EC014A;
        Thu, 24 Jan 2019 14:34:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1548336894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6Eo4yNWpgk4qG8WEdLISf0rydIY/IYrPOTg+tQz7pR8=;
        b=KjoDGxzfPmlycPGyajvBnxWdkHxsBk4oAjGCrC7CDOrVRkmdl5z39WEFaClg/Z/mRqPxCF
        4wGtccEEpx0jICqu0LiLvD3R64CTtihLdIj+5YvtO6LesBBeAo7sMoqR3efq8AKP6roudD
        KCYC4jNClyLgBhg42XsDV4pWOKSxR9c=
Date:   Thu, 24 Jan 2019 14:34:49 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 07/22] x86/fpu: Remove fpu->initialized
Message-ID: <20190124133449.GC11554@zn.tnic>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
 <20190109114744.10936-8-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190109114744.10936-8-bigeasy@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 12:47:29PM +0100, Sebastian Andrzej Siewior wrote:
> The `initialized' member of the fpu struct is always set to one user
								 ^
								 for

> tasks and zero for kernel tasks. This avoids saving/restoring the FPU
> registers for kernel threads.
> 
> I expect that fpu->initialized is always 1 and the 0 case has been

"I expect" reads funny. Make that impartial and passive and "expecting"
is the wrong formulation. It needs to be a clear statement talking about
the FPU context's state and why that state is always initialized.

> removed or is not important. For instance fpu__drop() sets the value to
> zero and its caller call either fpu__initialize() (which would

"its callers invoke" or so

> set it back to one) or don't return to userland.
> 
> The context switch code (switch_fpu_prepare() + switch_fpu_finish())
> can't unconditionally save/restore registers for kernel threads. I have
> no idea what will happen if we restore a zero FPU context for the kernel
> thread (since it never was initialized).

Yeah, avoid those "author is wondering" statements.

> Also it has been agreed that
> for PKRU we don't want a random state (inherited from the previous task)
> but a deterministic one.

Rewrite that to state what the PKRU state is going to be.

> For kernel_fpu_begin() (+end) the situation is similar: The kernel test
> bot told me, that EFI with runtime services uses this before
> alternatives_patched is true. Which means that this function is used too
> early and it wasn't the case before.
> 
> For those two cases current->mm is used to determine between user &
> kernel thread.

Now that we start looking at ->mm, I think we should document this
somewhere prominently, maybe

  arch/x86/include/asm/fpu/internal.h

or so along with all the logic this patchset changes wrt FPU handling.
Then we wouldn't have to wonder in the future why stuff is being done
the way it is done.

Like the FPU saving on the user stack frame or why this was needed:

-	/* Update the thread's fxstate to save the fsave header. */
-	if (ia32_fxstate)
-		copy_fxregs_to_kernel(fpu);

Some sort of a high-level invariants written down would save us a lot of
head scratching in the future.

> For kernel_fpu_begin() we skip save/restore of the FPU
> registers.
> During the context switch into a kernel thread we don't do anything.
> There is no reason to save the FPU state of a kernel thread.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/x86/ia32/ia32_signal.c         | 17 +++-----
>  arch/x86/include/asm/fpu/internal.h | 15 +++----
>  arch/x86/include/asm/fpu/types.h    |  9 ----
>  arch/x86/include/asm/trace/fpu.h    |  5 +--
>  arch/x86/kernel/fpu/core.c          | 68 ++++++++---------------------
>  arch/x86/kernel/fpu/init.c          |  2 -
>  arch/x86/kernel/fpu/regset.c        | 19 ++------
>  arch/x86/kernel/fpu/xstate.c        |  2 -
>  arch/x86/kernel/process_32.c        |  4 +-
>  arch/x86/kernel/process_64.c        |  4 +-
>  arch/x86/kernel/signal.c            | 17 +++-----
>  arch/x86/mm/pkeys.c                 |  7 +--
>  12 files changed, 49 insertions(+), 120 deletions(-)

...

> diff --git a/arch/x86/include/asm/trace/fpu.h b/arch/x86/include/asm/trace/fpu.h
> index 069c04be15076..bd65f6ba950f8 100644
> --- a/arch/x86/include/asm/trace/fpu.h
> +++ b/arch/x86/include/asm/trace/fpu.h
> @@ -13,22 +13,19 @@ DECLARE_EVENT_CLASS(x86_fpu,
>  
>  	TP_STRUCT__entry(
>  		__field(struct fpu *, fpu)
> -		__field(bool, initialized)
>  		__field(u64, xfeatures)
>  		__field(u64, xcomp_bv)
>  		),

Yikes, can you do that?

rostedt has been preaching that adding members at the end of tracepoints
is ok but not changing them in the middle as that breaks ABI.

Might wanna ping him about it first.

>  
>  	TP_fast_assign(
>  		__entry->fpu		= fpu;
> -		__entry->initialized	= fpu->initialized;
>  		if (boot_cpu_has(X86_FEATURE_OSXSAVE)) {
>  			__entry->xfeatures = fpu->state.xsave.header.xfeatures;
>  			__entry->xcomp_bv  = fpu->state.xsave.header.xcomp_bv;
>  		}
>  	),
> -	TP_printk("x86/fpu: %p initialized: %d xfeatures: %llx xcomp_bv: %llx",
> +	TP_printk("x86/fpu: %p xfeatures: %llx xcomp_bv: %llx",
>  			__entry->fpu,
> -			__entry->initialized,
>  			__entry->xfeatures,
>  			__entry->xcomp_bv
>  	)
> diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
> index e43296854e379..3a4668c9d24f1 100644
> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c
> @@ -101,7 +101,7 @@ static void __kernel_fpu_begin(void)
>  
>  	kernel_fpu_disable();
>  
> -	if (fpu->initialized) {
> +	if (current->mm) {
>  		/*
>  		 * Ignore return value -- we don't care if reg state
>  		 * is clobbered.
> @@ -116,7 +116,7 @@ static void __kernel_fpu_end(void)
>  {
>  	struct fpu *fpu = &current->thread.fpu;
>  
> -	if (fpu->initialized)
> +	if (current->mm)
>  		copy_kernel_to_fpregs(&fpu->state);
>  
>  	kernel_fpu_enable();
> @@ -147,10 +147,9 @@ void fpu__save(struct fpu *fpu)
>  
>  	preempt_disable();
>  	trace_x86_fpu_before_save(fpu);
> -	if (fpu->initialized) {
> -		if (!copy_fpregs_to_fpstate(fpu)) {
> -			copy_kernel_to_fpregs(&fpu->state);
> -		}
> +
> +	if (!copy_fpregs_to_fpstate(fpu)) {
> +		copy_kernel_to_fpregs(&fpu->state);
>  	}

WARNING: braces {} are not necessary for single statement blocks
#217: FILE: arch/x86/kernel/fpu/core.c:151:
+       if (!copy_fpregs_to_fpstate(fpu)) {
+               copy_kernel_to_fpregs(&fpu->state);
        }


...

> diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
> index 7888a41a03cdb..77d9eb43ccac8 100644
> --- a/arch/x86/kernel/process_32.c
> +++ b/arch/x86/kernel/process_32.c
> @@ -288,10 +288,10 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
>  	if (prev->gs | next->gs)
>  		lazy_load_gs(next->gs);
>  
> -	switch_fpu_finish(next_fpu, cpu);
> -
>  	this_cpu_write(current_task, next_p);
>  
> +	switch_fpu_finish(next_fpu, cpu);
> +
>  	/* Load the Intel cache allocation PQR MSR. */
>  	resctrl_sched_in();
>  
> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
> index e1983b3a16c43..ffea7c557963a 100644
> --- a/arch/x86/kernel/process_64.c
> +++ b/arch/x86/kernel/process_64.c
> @@ -566,14 +566,14 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
>  
>  	x86_fsgsbase_load(prev, next);
>  
> -	switch_fpu_finish(next_fpu, cpu);
> -
>  	/*
>  	 * Switch the PDA and FPU contexts.
>  	 */
>  	this_cpu_write(current_task, next_p);
>  	this_cpu_write(cpu_current_top_of_stack, task_top_of_stack(next_p));
>  
> +	switch_fpu_finish(next_fpu, cpu);
> +
>  	/* Reload sp0. */
>  	update_task_stack(next_p);
>  

Those moves need at least a comment in the commit message or a separate
patch.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
