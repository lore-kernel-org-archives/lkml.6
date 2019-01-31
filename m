Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DF5C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48E0220B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Kuh4WEvG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbfAaJRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 04:17:01 -0500
Received: from mail.skyhub.de ([5.9.137.197]:48092 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbfAaJRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 04:17:01 -0500
Received: from zn.tnic (p200300EC2BCC5900B46C3D45560FB189.dip0.t-ipconnect.de [IPv6:2003:ec:2bcc:5900:b46c:3d45:560f:b189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3BFCC1EC04FB;
        Thu, 31 Jan 2019 10:16:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1548926218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=MjjBY21aFDgJM9hDTB4o1CeGD50VMNQPK7JpvqfPim8=;
        b=Kuh4WEvGEhL6GguE2CJm8nCRDaBkMJwgk5dKEQEXrQIiEDOloFqHhei+z+W5znV9+b3aoX
        1M2H7XSu18rvqkprhnGI/WhbdZc2i2Np/ykb8+va/RKKlt4KZkxRdVqAj1lgZUojjyxGi2
        J7hhFe7GV+gYiIKFpWwDPXBMbaKCTYw=
Date:   Thu, 31 Jan 2019 10:16:49 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 22/22] x86/fpu: Defer FPU state load until return to
 userspace
Message-ID: <20190131091649.GA6749@zn.tnic>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
 <20190109114744.10936-23-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190109114744.10936-23-bigeasy@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 12:47:44PM +0100, Sebastian Andrzej Siewior wrote:
> From: Rik van Riel <riel@surriel.com>
> 
> Defer loading of FPU state until return to userspace. This gives
> the kernel the potential to skip loading FPU state for tasks that
> stay in kernel mode, or for tasks that end up with repeated
> invocations of kernel_fpu_begin() & kernel_fpu_end().

s/&/and/

> The __fpregs_changes_{begin|end}() section ensures that the register

registers - please check all your commit messages and code comments for
usage of singular "register" where the plural "registers" is supposed to
be. There are a couple of places.

> remain unchanged. Otherwise a context switch or a BH could save the

s/BH/bottom half/

> registers to its FPU context and processor's FPU register would became

"become"

> random if beeing modified at the same time.
> 
> KVM swaps the host/guest register on entry/exit path. I kept the flow as

Passive: "The flow has been kept."

> is. First it ensures that the registers are loaded and then saves the
> current (host) state before it loads the guest's register. The swap is
> done at the very end with disabled interrupts so it should not change
> anymore before theg guest is entered. The read/save version seems to be
> cheaper compared to memcpy() in a micro benchmark.
> 
> Each thread gets TIF_NEED_FPU_LOAD set as part of fork() / fpu__copy().
> For kernel threads, this flag gets never cleared which avoids saving /
> restoring the FPU state for kernel threads and during in-kernel usage of
> the FPU register.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/x86/entry/common.c             |   8 +++
>  arch/x86/include/asm/fpu/api.h      |  22 +++++-
>  arch/x86/include/asm/fpu/internal.h |  27 +++++---
>  arch/x86/include/asm/trace/fpu.h    |   5 +-
>  arch/x86/kernel/fpu/core.c          | 104 +++++++++++++++++++++-------
>  arch/x86/kernel/fpu/signal.c        |  46 +++++++-----
>  arch/x86/kernel/process.c           |   2 +-
>  arch/x86/kernel/process_32.c        |   5 +-
>  arch/x86/kernel/process_64.c        |   5 +-
>  arch/x86/kvm/x86.c                  |  20 ++++--
>  10 files changed, 179 insertions(+), 65 deletions(-)

Needs checkpatch fixing:

WARNING: 'beeing' may be misspelled - perhaps 'being'?
#29: 
random if beeing modified at the same time.

WARNING: braces {} are not necessary for single statement blocks
#282: FILE: arch/x86/kernel/fpu/core.c:149:
+               if (!copy_fpregs_to_fpstate(fpu)) {
+                       copy_kernel_to_fpregs(&fpu->state);
+               }

WARNING: please, no spaces at the start of a line
#391: FILE: arch/x86/kernel/fpu/core.c:375:
+       struct fpu *fpu = &current->thread.fpu;$

WARNING: please, no spaces at the start of a line
#393: FILE: arch/x86/kernel/fpu/core.c:377:
+       if (test_thread_flag(TIF_NEED_FPU_LOAD))$

WARNING: suspect code indent for conditional statements (7, 15)
#393: FILE: arch/x86/kernel/fpu/core.c:377:
+       if (test_thread_flag(TIF_NEED_FPU_LOAD))
+               return;

ERROR: code indent should use tabs where possible
#394: FILE: arch/x86/kernel/fpu/core.c:378:
+               return;$

WARNING: please, no spaces at the start of a line
#394: FILE: arch/x86/kernel/fpu/core.c:378:
+               return;$

WARNING: please, no spaces at the start of a line
#395: FILE: arch/x86/kernel/fpu/core.c:379:
+       WARN_ON_FPU(!fpregs_state_valid(fpu, smp_processor_id()));$

total: 1 errors, 7 warnings, 499 lines checked

Also, this patch could use some splitting for easier review, like adding
the helpers in a pre-patch and then wiring in all the logic in another,
for example.

> diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> index 7bc105f47d21a..13e8e29af6ab7 100644
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
> @@ -196,6 +197,13 @@ __visible inline void prepare_exit_to_usermode(struct pt_regs *regs)
>  	if (unlikely(cached_flags & EXIT_TO_USERMODE_LOOP_FLAGS))
>  		exit_to_usermode_loop(regs, cached_flags);
>  
> +	/* Reload ti->flags; we may have rescheduled above. */
> +	cached_flags = READ_ONCE(ti->flags);
> +
> +	fpregs_assert_state_consistent();

So this one already tests TIF_NEED_FPU_LOAD when the kernel has been
built with CONFIG_X86_DEBUG_FPU=y.

I guess we can remove that CONFIG_X86_DEBUG_FPU around it and run it
unconditionally. And then make it return the test result so that you
don't have to run the same test again on cached_flags, or ?

> +	if (unlikely(cached_flags & _TIF_NEED_FPU_LOAD))
> +		switch_fpu_return();

And looking at the code, the consistency check and the potential loading
of FPU registers in switch_fpu_return() belong together so they're kinda
begging to be a single function...?

> +
>  #ifdef CONFIG_COMPAT
>  	/*
>  	 * Compat syscalls set TS_COMPAT.  Make sure we clear it before
> diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
> index 31b66af8eb914..c17620af5d797 100644
> --- a/arch/x86/include/asm/fpu/api.h
> +++ b/arch/x86/include/asm/fpu/api.h
> @@ -10,7 +10,7 @@
>  
>  #ifndef _ASM_X86_FPU_API_H
>  #define _ASM_X86_FPU_API_H
> -#include <linux/preempt.h>
> +#include <linux/bottom_half.h>
>  
>  /*
>   * Use kernel_fpu_begin/end() if you intend to use FPU in kernel context. It
> @@ -22,17 +22,37 @@
>  extern void kernel_fpu_begin(void);
>  extern void kernel_fpu_end(void);
>  extern bool irq_fpu_usable(void);
> +extern void fpregs_mark_activate(void);
>  
> +/*
> + * Use __fpregs_changes_begin() while editing CPU's FPU registers or fpu->state.
> + * A context switch will (and softirq might) save CPU's FPU register to
> + * fpu->state and set TIF_NEED_FPU_LOAD leaving CPU's FPU registers in a random
> + * state.
> + */
>  static inline void __fpregs_changes_begin(void)
>  {
>  	preempt_disable();
> +	local_bh_disable();
>  }
>  
>  static inline void __fpregs_changes_end(void)
>  {
> +	local_bh_enable();
>  	preempt_enable();
>  }
>  
> +#ifdef CONFIG_X86_DEBUG_FPU
> +extern void fpregs_assert_state_consistent(void);
> +#else
> +static inline void fpregs_assert_state_consistent(void) { }
> +#endif
> +
> +/*
> + * Load the task FPU state before returning to userspace.
> + */
> +extern void switch_fpu_return(void);
> +
>  /*
>   * Query the presence of one or more xfeatures. Works on any legacy CPU as well.
>   *
> diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
> index 672e51bc0e9b5..61627f8cb3ff4 100644
> --- a/arch/x86/include/asm/fpu/internal.h
> +++ b/arch/x86/include/asm/fpu/internal.h
> @@ -29,7 +29,7 @@ extern void fpu__prepare_write(struct fpu *fpu);
>  extern void fpu__save(struct fpu *fpu);
>  extern int  fpu__restore_sig(void __user *buf, int ia32_frame);
>  extern void fpu__drop(struct fpu *fpu);
> -extern int  fpu__copy(struct fpu *dst_fpu, struct fpu *src_fpu);
> +extern int  fpu__copy(struct task_struct *dst, struct task_struct *src);
>  extern void fpu__clear(struct fpu *fpu);
>  extern int  fpu__exception_code(struct fpu *fpu, int trap_nr);
>  extern int  dump_fpu(struct pt_regs *ptregs, struct user_i387_struct *fpstate);
> @@ -482,13 +482,20 @@ static inline void fpregs_activate(struct fpu *fpu)
>  	trace_x86_fpu_regs_activated(fpu);
>  }
>  
> -static inline void __fpregs_load_activate(struct fpu *fpu, int cpu)
> +static inline void __fpregs_load_activate(void)
>  {
> +	struct fpu *fpu = &current->thread.fpu;
> +	int cpu = smp_processor_id();
> +
> +	if (WARN_ON_ONCE(current->mm == NULL))

			!current->mm

is what we do with NULL checks.

> +		return;
> +
>  	if (!fpregs_state_valid(fpu, cpu)) {
> -		if (current->mm)
> -			copy_kernel_to_fpregs(&fpu->state);
> +		copy_kernel_to_fpregs(&fpu->state);
>  		fpregs_activate(fpu);
> +		fpu->last_cpu = cpu;
>  	}
> +	clear_thread_flag(TIF_NEED_FPU_LOAD);
>  }
>  
>  /*
> @@ -499,8 +506,8 @@ static inline void __fpregs_load_activate(struct fpu *fpu, int cpu)
>   *  - switch_fpu_prepare() saves the old state.
>   *    This is done within the context of the old process.
>   *
> - *  - switch_fpu_finish() restores the new state as
> - *    necessary.
> + *  - switch_fpu_finish() sets TIF_NEED_FPU_LOAD; the floating point state
> + *    will get loaded on return to userspace, or when the kernel needs it.
>   */
>  static inline void
>  switch_fpu_prepare(struct fpu *old_fpu, int cpu)
> @@ -521,10 +528,10 @@ switch_fpu_prepare(struct fpu *old_fpu, int cpu)
>   */
>  
>  /*
> - * Set up the userspace FPU context for the new task, if the task
> - * has used the FPU.
> + * Load PKRU from the FPU context if available. Delay loading the loading of the

"loading the loading"?

> + * complete FPU state until the return to userland.
>   */
> -static inline void switch_fpu_finish(struct fpu *new_fpu, int cpu)
> +static inline void switch_fpu_finish(struct fpu *new_fpu)
>  {
>  	struct pkru_state *pk;
>  	u32 pkru_val = 0;
> @@ -532,7 +539,7 @@ static inline void switch_fpu_finish(struct fpu *new_fpu, int cpu)
>  	if (!static_cpu_has(X86_FEATURE_FPU))
>  		return;
>  
> -	__fpregs_load_activate(new_fpu, cpu);
> +	set_thread_flag(TIF_NEED_FPU_LOAD);
>  
>  	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
>  		return;
> diff --git a/arch/x86/include/asm/trace/fpu.h b/arch/x86/include/asm/trace/fpu.h
> index bd65f6ba950f8..91a1422091ceb 100644
> --- a/arch/x86/include/asm/trace/fpu.h
> +++ b/arch/x86/include/asm/trace/fpu.h
> @@ -13,19 +13,22 @@ DECLARE_EVENT_CLASS(x86_fpu,
>  
>  	TP_STRUCT__entry(
>  		__field(struct fpu *, fpu)
> +		__field(bool, load_fpu)

Yeah, I don't think you can do this.

>  		__field(u64, xfeatures)
>  		__field(u64, xcomp_bv)
>  		),
>  
>  	TP_fast_assign(
>  		__entry->fpu		= fpu;
> +		__entry->load_fpu	= test_thread_flag(TIF_NEED_FPU_LOAD);
>  		if (boot_cpu_has(X86_FEATURE_OSXSAVE)) {
>  			__entry->xfeatures = fpu->state.xsave.header.xfeatures;
>  			__entry->xcomp_bv  = fpu->state.xsave.header.xcomp_bv;
>  		}
>  	),
> -	TP_printk("x86/fpu: %p xfeatures: %llx xcomp_bv: %llx",
> +	TP_printk("x86/fpu: %p load: %d xfeatures: %llx xcomp_bv: %llx",
>  			__entry->fpu,
> +			__entry->load_fpu,
>  			__entry->xfeatures,
>  			__entry->xcomp_bv
>  	)
> diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
> index 78d8037635932..f52e687dff9ee 100644
> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c
> @@ -102,23 +102,20 @@ static void __kernel_fpu_begin(void)
>  	kernel_fpu_disable();
>  
>  	if (current->mm) {
> -		/*
> -		 * Ignore return value -- we don't care if reg state
> -		 * is clobbered.
> -		 */
> -		copy_fpregs_to_fpstate(fpu);
> -	} else {
> -		__cpu_invalidate_fpregs_state();
> +		if (!test_thread_flag(TIF_NEED_FPU_LOAD)) {
> +			set_thread_flag(TIF_NEED_FPU_LOAD);

test_and_set_thread_flag ?

> +			/*
> +			 * Ignore return value -- we don't care if reg state
> +			 * is clobbered.
> +			 */
> +			copy_fpregs_to_fpstate(fpu);
> +		}
>  	}
> +	__cpu_invalidate_fpregs_state();
>  }
>  
>  static void __kernel_fpu_end(void)
>  {
> -	struct fpu *fpu = &current->thread.fpu;
> -
> -	if (current->mm)
> -		copy_kernel_to_fpregs(&fpu->state);
> -
>  	kernel_fpu_enable();
>  }
>  
> @@ -145,14 +142,16 @@ void fpu__save(struct fpu *fpu)
>  {
>  	WARN_ON_FPU(fpu != &current->thread.fpu);
>  
> -	preempt_disable();
> +	__fpregs_changes_begin();
>  	trace_x86_fpu_before_save(fpu);
>  
> -	if (!copy_fpregs_to_fpstate(fpu)) {
> -		copy_kernel_to_fpregs(&fpu->state);
> +	if (!test_thread_flag(TIF_NEED_FPU_LOAD)) {
> +		if (!copy_fpregs_to_fpstate(fpu)) {
> +			copy_kernel_to_fpregs(&fpu->state);
> +		}
>  	}
>  	trace_x86_fpu_after_save(fpu);
> -	preempt_enable();
> +	__fpregs_changes_end();
>  }
>  EXPORT_SYMBOL_GPL(fpu__save);
>  
> @@ -185,8 +184,11 @@ void fpstate_init(union fpregs_state *state)
>  }
>  EXPORT_SYMBOL_GPL(fpstate_init);
>  
> -int fpu__copy(struct fpu *dst_fpu, struct fpu *src_fpu)
> +int fpu__copy(struct task_struct *dst, struct task_struct *src)
>  {
> +	struct fpu *dst_fpu = &dst->thread.fpu;
> +	struct fpu *src_fpu = &src->thread.fpu;
> +
>  	dst_fpu->last_cpu = -1;
>  
>  	if (!static_cpu_has(X86_FEATURE_FPU))
> @@ -201,16 +203,23 @@ int fpu__copy(struct fpu *dst_fpu, struct fpu *src_fpu)
>  	memset(&dst_fpu->state.xsave, 0, fpu_kernel_xstate_size);
>  
>  	/*
> -	 * Save current FPU registers directly into the child
> -	 * FPU context, without any memory-to-memory copying.
> +	 * If the FPU registers are not current just memcpy() the state.
> +	 * Otherwise save current FPU registers directly into the child's FPU
> +	 * context, without any memory-to-memory copying.
>  	 *
>  	 * ( The function 'fails' in the FNSAVE case, which destroys
> -	 *   register contents so we have to copy them back. )
> +	 *   register contents so we have to load them back. )
>  	 */
> -	if (!copy_fpregs_to_fpstate(dst_fpu)) {
> -		memcpy(&src_fpu->state, &dst_fpu->state, fpu_kernel_xstate_size);
> -		copy_kernel_to_fpregs(&src_fpu->state);
> -	}
> +	__fpregs_changes_begin();
> +	if (test_thread_flag(TIF_NEED_FPU_LOAD))
> +		memcpy(&dst_fpu->state, &src_fpu->state, fpu_kernel_xstate_size);
> +

Superfluous newline.

> +	else if (!copy_fpregs_to_fpstate(dst_fpu))
> +		copy_kernel_to_fpregs(&dst_fpu->state);
> +
> +	__fpregs_changes_end();
> +
> +	set_tsk_thread_flag(dst, TIF_NEED_FPU_LOAD);
>  
>  	trace_x86_fpu_copy_src(src_fpu);
>  	trace_x86_fpu_copy_dst(dst_fpu);
> @@ -226,10 +235,9 @@ static void fpu__initialize(struct fpu *fpu)
>  {
>  	WARN_ON_FPU(fpu != &current->thread.fpu);
>  
> +	set_thread_flag(TIF_NEED_FPU_LOAD);
>  	fpstate_init(&fpu->state);
>  	trace_x86_fpu_init_state(fpu);
> -
> -	trace_x86_fpu_activate_state(fpu);
>  }
>  
>  /*
> @@ -308,6 +316,8 @@ void fpu__drop(struct fpu *fpu)
>   */
>  static inline void copy_init_fpstate_to_fpregs(void)
>  {
> +	__fpregs_changes_begin();
> +
>  	if (use_xsave())
>  		copy_kernel_to_xregs(&init_fpstate.xsave, -1);
>  	else if (static_cpu_has(X86_FEATURE_FXSR))
> @@ -317,6 +327,9 @@ static inline void copy_init_fpstate_to_fpregs(void)
>  
>  	if (boot_cpu_has(X86_FEATURE_OSPKE))
>  		copy_init_pkru_to_fpregs();
> +
> +	fpregs_mark_activate();
> +	__fpregs_changes_end();
>  }
>  
>  /*
> @@ -339,6 +352,45 @@ void fpu__clear(struct fpu *fpu)
>  		copy_init_fpstate_to_fpregs();
>  }
>  
> +/*
> + * Load FPU context before returning to userspace.
> + */
> +void switch_fpu_return(void)
> +{
> +	if (!static_cpu_has(X86_FEATURE_FPU))
> +		return;
> +
> +	__fpregs_load_activate();
> +}
> +EXPORT_SYMBOL_GPL(switch_fpu_return);
> +
> +#ifdef CONFIG_X86_DEBUG_FPU
> +/*
> + * If current FPU state according to its tracking (loaded FPU ctx on this CPU)
> + * is not valid then we must have TIF_NEED_FPU_LOAD set so the context is loaded on
> + * return to userland.
> + */
> +void fpregs_assert_state_consistent(void)
> +{
> +       struct fpu *fpu = &current->thread.fpu;
> +
> +       if (test_thread_flag(TIF_NEED_FPU_LOAD))
> +               return;
> +       WARN_ON_FPU(!fpregs_state_valid(fpu, smp_processor_id()));
> +}
> +EXPORT_SYMBOL_GPL(fpregs_assert_state_consistent);
> +#endif
> +
> +void fpregs_mark_activate(void)
> +{
> +	struct fpu *fpu = &current->thread.fpu;
> +
> +	fpregs_activate(fpu);
> +	fpu->last_cpu = smp_processor_id();
> +	clear_thread_flag(TIF_NEED_FPU_LOAD);
> +}
> +EXPORT_SYMBOL_GPL(fpregs_mark_activate);
> +
>  /*
>   * x87 math exception handling:
>   */
> diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
> index a17e75fa1a0a6..61a03a34a7304 100644
> --- a/arch/x86/kernel/fpu/signal.c
> +++ b/arch/x86/kernel/fpu/signal.c
> @@ -230,11 +230,9 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
>  	struct fpu *fpu = &tsk->thread.fpu;
>  	int state_size = fpu_kernel_xstate_size;
>  	struct user_i387_ia32_struct env;
> -	union fpregs_state *state;
>  	u64 xfeatures = 0;
>  	int fx_only = 0;
>  	int ret = 0;
> -	void *tmp;
>  
>  	ia32_fxstate &= (IS_ENABLED(CONFIG_X86_32) ||
>  			 IS_ENABLED(CONFIG_IA32_EMULATION));
> @@ -269,14 +267,18 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
>  		}
>  	}
>  
> -	tmp = kzalloc(sizeof(*state) + fpu_kernel_xstate_size + 64, GFP_KERNEL);
> -	if (!tmp)
> -		return -ENOMEM;
> -	state = PTR_ALIGN(tmp, 64);
> +	/*
> +	 * The current state of the FPU registers does not matter. By setting
> +	 * TIF_NEED_FPU_LOAD unconditionally it is ensured that the our xstate

our xstate? You mean the xstate copy in memory I think...

> +	 * is not modified on context switch and that the xstate is considered
> +	 * to loaded again on return to userland (overriding last_cpu avoids the
> +	 * optimisation).
> +	 */
> +	set_thread_flag(TIF_NEED_FPU_LOAD);
> +	__fpu_invalidate_fpregs_state(fpu);
>  
>  	if ((unsigned long)buf_fx % 64)
>  		fx_only = 1;
> -
>  	/*
>  	 * For 32-bit frames with fxstate, copy the fxstate so it can be
>  	 * reconstructed later.
> @@ -292,43 +294,51 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
>  		u64 init_bv = xfeatures_mask & ~xfeatures;
>  
>  		if (using_compacted_format()) {
> -			ret = copy_user_to_xstate(&state->xsave, buf_fx);
> +			ret = copy_user_to_xstate(&fpu->state.xsave, buf_fx);
>  		} else {
> -			ret = __copy_from_user(&state->xsave, buf_fx, state_size);
> +			ret = __copy_from_user(&fpu->state.xsave, buf_fx, state_size);
>  
>  			if (!ret && state_size > offsetof(struct xregs_state, header))
> -				ret = validate_xstate_header(&state->xsave.header);
> +				ret = validate_xstate_header(&fpu->state.xsave.header);
>  		}
>  		if (ret)
>  			goto err_out;
>  
> -		sanitize_restored_xstate(state, envp, xfeatures, fx_only);
> +		sanitize_restored_xstate(&fpu->state, envp, xfeatures, fx_only);
>  
> +		__fpregs_changes_begin();
>  		if (unlikely(init_bv))
>  			copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
> -		ret = copy_users_to_xregs(&state->xsave, xfeatures);
> +		ret = copy_users_to_xregs(&fpu->state.xsave, xfeatures);
>  
>  	} else if (use_fxsr()) {
> -		ret = __copy_from_user(&state->fxsave, buf_fx, state_size);
> -		if (ret)
> +		ret = __copy_from_user(&fpu->state.fxsave, buf_fx, state_size);
> +		if (ret) {
> +			ret = -EFAULT;
>  			goto err_out;
> +		}
>  
> -		sanitize_restored_xstate(state, envp, xfeatures, fx_only);
> +		sanitize_restored_xstate(&fpu->state, envp, xfeatures, fx_only);
> +
> +		__fpregs_changes_begin();
>  		if (use_xsave()) {
>  			u64 init_bv = xfeatures_mask & ~XFEATURE_MASK_FPSSE;
>  			copy_kernel_to_xregs(&init_fpstate.xsave, init_bv);
>  		}
>  
> -		ret = copy_users_to_fxregs(&state->fxsave);
> +		ret = copy_users_to_fxregs(&fpu->state.fxsave);
>  	} else {
> -		ret = __copy_from_user(&state->fsave, buf_fx, state_size);
> +		ret = __copy_from_user(&fpu->state.fsave, buf_fx, state_size);
>  		if (ret)
>  			goto err_out;
> +		__fpregs_changes_begin();

Eww, each branch is doing __fpregs_changes_begin() and we do
__fpregs_changes_end() once at the end. Had to open eyes wider here :)

>  		ret = copy_users_to_fregs(buf_fx);
>  	}
> +	if (!ret)
> +		fpregs_mark_activate();
> +	__fpregs_changes_end();
>  
>  err_out:
> -	kfree(tmp);
>  	if (ret)
>  		fpu__clear(fpu);
>  	return ret;
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index 90ae0ca510837..2e38a14fdbd3f 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -101,7 +101,7 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
>  	dst->thread.vm86 = NULL;
>  #endif
>  
> -	return fpu__copy(&dst->thread.fpu, &src->thread.fpu);
> +	return fpu__copy(dst, src);
>  }
>  
>  /*
> diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
> index 77d9eb43ccac8..1bc47f3a48854 100644
> --- a/arch/x86/kernel/process_32.c
> +++ b/arch/x86/kernel/process_32.c
> @@ -234,7 +234,8 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
>  
>  	/* never put a printk in __switch_to... printk() calls wake_up*() indirectly */
>  
> -	switch_fpu_prepare(prev_fpu, cpu);

Let's add a comment here like the rest of the function does it. Ditto for below.

> +	if (!test_thread_flag(TIF_NEED_FPU_LOAD))
> +		switch_fpu_prepare(prev_fpu, cpu);
>  
>  	/*
>  	 * Save away %gs. No need to save %fs, as it was saved on the

...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
