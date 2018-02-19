Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752900AbeBSOeW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 09:34:22 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49754 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752469AbeBSOeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 09:34:21 -0500
Date: Mon, 19 Feb 2018 08:34:17 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, x86@kernel.org,
        brgerst@gmail.com, luto@kernel.org, torvalds@linux-foundation.org,
        ak@linux.intel.com, tglx@linutronix.de, dan.j.williams@intel.com
Subject: Re: [RFC PATCH v2 5/5] x86/entry/64: open-code switch_to_thread_stack
Message-ID: <20180219143417.jsry72fehkbvz6gs@treble>
References: <20180218123116.21334-1-linux@dominikbrodowski.net>
 <20180218123116.21334-6-linux@dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180218123116.21334-6-linux@dominikbrodowski.net>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 18, 2018 at 01:31:16PM +0100, Dominik Brodowski wrote:
> Open-code the two instances which used switch_to_thread_stack. This
> allows us to remove the wrapper around DO_SWITCH_TO_THREAD_STACK.
> 
> While at it, update the UNWIND hint to reflect where the IRET frame is.
> 
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
> ---
>  arch/x86/entry/entry_64.S        | 59 ++++++++++++++++------------------------
>  arch/x86/entry/entry_64_compat.S | 19 ++++++++++++-
>  2 files changed, 42 insertions(+), 36 deletions(-)
> 
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index 0ac2b4865d58..fa61be457082 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -539,17 +539,36 @@ END(irq_entries_start)
>  .endm
>  
>  /*
> - * Switch to the thread stack.  This is called with the IRET frame and
> - * orig_ax on the stack.  (That is, RDI..R12 are not on the stack and
> - * space has not been allocated for them.)
> + * Interrupt entry/exit.
> + *
> + * Interrupt entry points save only callee clobbered registers in fast path.
> + *
> + * Entry runs with interrupts off.
>   */

These comments aren't really accurate anymore:

- The function only handles interrupt entry, not exit.

- All registers are saved, there is no fast path.

> -.macro DO_SWITCH_TO_THREAD_STACK
> +/* 8(%rsp): ~(interrupt number) */
> +ENTRY(interrupt_helper)

"interrupt_helper" is a bit vague, how about "interrupt_entry"?  That
better describes its purpose and also makes it more analagous to
paranoid_entry() and error_entry().

> +	UNWIND_HINT_FUNC
> +	cld
> +
> +	testb	$3, CS-ORIG_RAX+8(%rsp)
> +	jz	1f
> +	SWAPGS
> +
> +	/*
> +	 * Switch to the thread stack.  The IRET frame and orig_ax are
> +	 * on the stack, as well as the return address. RDI..R12 are
> +	 * not (yet) on the stack and space has not (yet) been
> +	 * allocated for them.
> +	 */
>  	pushq	%rdi
> +
>  	/* Need to switch before accessing the thread stack. */
>  	SWITCH_TO_KERNEL_CR3 scratch_reg=%rdi
>  	movq	%rsp, %rdi
>  	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
> -	UNWIND_HINT sp_offset=16 sp_reg=ORC_REG_DI
> +	 /* We have RDI, return address, and orig_ax on the stack on
> +	  * top of the IRET frame. That means offset=24 */
> +	UNWIND_HINT_IRET_REGS base=%rdi offset=24

The hint looks right, though the comment formatting isn't in the kernel
style.

> diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
> index 364ea4a207be..5b9503c7148d 100644
> --- a/arch/x86/entry/entry_64_compat.S
> +++ b/arch/x86/entry/entry_64_compat.S
> @@ -350,7 +350,24 @@ ENTRY(entry_INT80_compat)
>  	pushq	%rax			/* pt_regs->orig_ax */
>  
>  	/* switch to thread stack expects orig_ax to be pushed */
> -	call	switch_to_thread_stack
> +	pushq	%rdi
> +
> +	/* Need to switch before accessing the thread stack. */
> +	SWITCH_TO_KERNEL_CR3 scratch_reg=%rdi
> +	movq	%rsp, %rdi
> +	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
> +	 /* We have RDI and orig_ax on the stack on top of the IRET frame.
> +	  * That means offset=16 */
> +	UNWIND_HINT_IRET_REGS base=%rdi offset=16

Objtool doesn't scan this file yet, so no hints needed here yet.

Adding it to my TODO list...

-- 
Josh
