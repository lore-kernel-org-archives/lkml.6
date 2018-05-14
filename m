Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752703AbeENLHg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 07:07:36 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40170 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752242AbeENLHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 07:07:35 -0400
Date: Mon, 14 May 2018 12:07:30 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
        james.morse@arm.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 10/18] arm64: convert native/compat syscall entry to C
Message-ID: <20180514110729.GF7753@e103592.cambridge.arm.com>
References: <20180514094640.27569-1-mark.rutland@arm.com>
 <20180514094640.27569-11-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514094640.27569-11-mark.rutland@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 10:46:32AM +0100, Mark Rutland wrote:
> Now that the syscall invocation logic is in C, we can migrate the rest
> of the syscall entry logic over, so that the entry assembly needn't look
> at the register values at all.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/kernel/entry.S   | 42 ++++--------------------------------------
>  arch/arm64/kernel/syscall.c | 40 ++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 42 insertions(+), 40 deletions(-)
> 
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 5c60369b52fc..13afefbf608f 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -690,14 +690,9 @@ el0_sync_compat:
>  	b.ge	el0_dbg
>  	b	el0_inv
>  el0_svc_compat:
> -	/*
> -	 * AArch32 syscall handling
> -	 */
> -	ldr	x16, [tsk, #TSK_TI_FLAGS]	// load thread flags
> -	adrp	stbl, compat_sys_call_table	// load compat syscall table pointer
> -	mov	wscno, w7			// syscall number in w7 (r7)
> -	mov     wsc_nr, #__NR_compat_syscalls
> -	b	el0_svc_naked
> +	mov	x0, sp
> +	bl	el0_svc_compat_handler
> +	b	ret_to_user
>  
>  	.align	6
>  el0_irq_compat:
> @@ -895,37 +890,8 @@ ENDPROC(ret_to_user)
>   */
>  	.align	6
>  el0_svc:
> -	ldr	x16, [tsk, #TSK_TI_FLAGS]	// load thread flags
> -	adrp	stbl, sys_call_table		// load syscall table pointer
> -	mov	wscno, w8			// syscall number in w8
> -	mov	wsc_nr, #__NR_syscalls
> -
> -#ifdef CONFIG_ARM64_SVE
> -alternative_if_not ARM64_SVE
> -	b	el0_svc_naked
> -alternative_else_nop_endif
> -	tbz	x16, #TIF_SVE, el0_svc_naked	// Skip unless TIF_SVE set:
> -	bic	x16, x16, #_TIF_SVE		// discard SVE state
> -	str	x16, [tsk, #TSK_TI_FLAGS]
> -
> -	/*
> -	 * task_fpsimd_load() won't be called to update CPACR_EL1 in
> -	 * ret_to_user unless TIF_FOREIGN_FPSTATE is still set, which only
> -	 * happens if a context switch or kernel_neon_begin() or context
> -	 * modification (sigreturn, ptrace) intervenes.
> -	 * So, ensure that CPACR_EL1 is already correct for the fast-path case:
> -	 */
> -	mrs	x9, cpacr_el1
> -	bic	x9, x9, #CPACR_EL1_ZEN_EL0EN	// disable SVE for el0
> -	msr	cpacr_el1, x9			// synchronised by eret to el0
> -#endif
> -
> -el0_svc_naked:					// compat entry point
>  	mov	x0, sp
> -	mov	w1, wscno
> -	mov	w2, wsc_nr
> -	mov	x3, stbl
> -	bl	el0_svc_common
> +	bl	el0_svc_handler
>  	b	ret_to_user
>  ENDPROC(el0_svc)
>  
> diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
> index 5df857e32b48..4706f841e758 100644
> --- a/arch/arm64/kernel/syscall.c
> +++ b/arch/arm64/kernel/syscall.c
> @@ -6,7 +6,9 @@
>  #include <linux/ptrace.h>
>  
>  #include <asm/daifflags.h>
> +#include <asm/fpsimd.h>
>  #include <asm/thread_info.h>
> +#include <asm/unistd.h>
>  
>  long do_ni_syscall(struct pt_regs *regs);
>  
> @@ -41,8 +43,8 @@ static inline bool has_syscall_work(unsigned long flags)
>  int syscall_trace_enter(struct pt_regs *regs);
>  void syscall_trace_exit(struct pt_regs *regs);
>  
> -asmlinkage void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
> -			       syscall_fn_t syscall_table[])
> +static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
> +			   syscall_fn_t syscall_table[])
>  {
>  	unsigned long flags = current_thread_info()->flags;
>  
> @@ -79,3 +81,37 @@ asmlinkage void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
>  trace_exit:
>  	syscall_trace_exit(regs);
>  }
> +
> +static inline void sve_user_reset(void)

Static function with no caller...

> +{
> +	if (!system_supports_sve())
> +		return;
> +
> +	/*
> +	 * task_fpsimd_load() won't be called to update CPACR_EL1 in
> +	 * ret_to_user unless TIF_FOREIGN_FPSTATE is still set, which only
> +	 * happens if a context switch or kernel_neon_begin() or context
> +	 * modification (sigreturn, ptrace) intervenes.
> +	 * So, ensure that CPACR_EL1 is already correct for the fast-path case.
> +	 */
> +	if (test_and_clear_thread_flag(TIF_SVE))
> +		sve_user_disable();

sve_user_disable() is already inline, and incorporates the if()
internally via sysreg_clear_set().

So, should this just be

	clear_thread_flag(TIF_SVE);
	sve_user_disable();

> +}
> +
> +extern syscall_fn_t sys_call_table[];
> +
> +asmlinkage void el0_svc_handler(struct pt_regs *regs)
> +{

if (system_supports_sve()) ?

> +	sve_user_disable();

Or should this be replaced by a call to sve_user_reset()?

I suspect the latter, since we do want to be clearing TIF_SVE here too.


[...]

Cheers
---Dave
