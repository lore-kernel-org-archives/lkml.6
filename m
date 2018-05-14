Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752674AbeENLHJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 07:07:09 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40128 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752305AbeENLHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 07:07:08 -0400
Date: Mon, 14 May 2018 12:07:03 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
        james.morse@arm.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 07/18] arm64: remove sigreturn wrappers
Message-ID: <20180514110702.GD7753@e103592.cambridge.arm.com>
References: <20180514094640.27569-1-mark.rutland@arm.com>
 <20180514094640.27569-8-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514094640.27569-8-mark.rutland@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 10:46:29AM +0100, Mark Rutland wrote:
> The arm64 sigreturn* syscall handlers are non-standard. Rather than
> taking a number of user parameters in registers as per the AAPCS,
> they expect the pt_regs as their sole argument.
> 
> To make this work, we override the syscall definitions to invoke
> wrappers written in assembly, which mov the SP into x0, and branch to
> their respective C functions.
> 
> On other architectures (such as x86), the sigreturn* functions take no
> argument and instead use current_pt_regs() to acquire the user
> registers. This requires less boilerplate code, and allows for other
> features such as interposing C code in this path.

Hmmm, I always wondered why rt_sigreturn() et al. were handled
specially.

If there's effectively no underlying reason for that, it makes sense
to regularise the interface to these syscalls.

Tentatively-reviewed-by: Dave Martin <Dave.Martin@arm.com>

> 
> This patch takes the same approach for arm64.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/unistd32.h |  4 ++--
>  arch/arm64/kernel/entry.S         |  8 --------
>  arch/arm64/kernel/entry32.S       | 10 ----------
>  arch/arm64/kernel/signal.c        |  3 ++-
>  arch/arm64/kernel/signal32.c      |  6 ++++--
>  arch/arm64/kernel/sys.c           |  3 +--
>  arch/arm64/kernel/sys32.c         |  4 ++--
>  7 files changed, 11 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
> index ef292160748c..ab95554b1734 100644
> --- a/arch/arm64/include/asm/unistd32.h
> +++ b/arch/arm64/include/asm/unistd32.h
> @@ -260,7 +260,7 @@ __SYSCALL(117, sys_ni_syscall)
>  #define __NR_fsync 118
>  __SYSCALL(__NR_fsync, sys_fsync)
>  #define __NR_sigreturn 119
> -__SYSCALL(__NR_sigreturn, compat_sys_sigreturn_wrapper)
> +__SYSCALL(__NR_sigreturn, compat_sys_sigreturn)
>  #define __NR_clone 120
>  __SYSCALL(__NR_clone, sys_clone)
>  #define __NR_setdomainname 121
> @@ -368,7 +368,7 @@ __SYSCALL(__NR_getresgid, sys_getresgid16)
>  #define __NR_prctl 172
>  __SYSCALL(__NR_prctl, sys_prctl)
>  #define __NR_rt_sigreturn 173
> -__SYSCALL(__NR_rt_sigreturn, compat_sys_rt_sigreturn_wrapper)
> +__SYSCALL(__NR_rt_sigreturn, compat_sys_rt_sigreturn)
>  #define __NR_rt_sigaction 174
>  __SYSCALL(__NR_rt_sigaction, compat_sys_rt_sigaction)
>  #define __NR_rt_sigprocmask 175
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index ec2ee720e33e..08ea3cbfb08f 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -1108,14 +1108,6 @@ __entry_tramp_data_start:
>  #endif /* CONFIG_UNMAP_KERNEL_AT_EL0 */
>  
>  /*
> - * Special system call wrappers.
> - */
> -ENTRY(sys_rt_sigreturn_wrapper)
> -	mov	x0, sp
> -	b	sys_rt_sigreturn
> -ENDPROC(sys_rt_sigreturn_wrapper)
> -
> -/*
>   * Register switch for AArch64. The callee-saved registers need to be saved
>   * and restored. On entry:
>   *   x0 = previous task_struct (must be preserved across the switch)
> diff --git a/arch/arm64/kernel/entry32.S b/arch/arm64/kernel/entry32.S
> index f332d5d1f6b4..f9461696dde4 100644
> --- a/arch/arm64/kernel/entry32.S
> +++ b/arch/arm64/kernel/entry32.S
> @@ -30,16 +30,6 @@
>   * System call wrappers for the AArch32 compatibility layer.
>   */
>  
> -ENTRY(compat_sys_sigreturn_wrapper)
> -	mov	x0, sp
> -	b	compat_sys_sigreturn
> -ENDPROC(compat_sys_sigreturn_wrapper)
> -
> -ENTRY(compat_sys_rt_sigreturn_wrapper)
> -	mov	x0, sp
> -	b	compat_sys_rt_sigreturn
> -ENDPROC(compat_sys_rt_sigreturn_wrapper)
> -
>  ENTRY(compat_sys_statfs64_wrapper)
>  	mov	w3, #84
>  	cmp	w1, #88
> diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
> index 8e624fec4707..caa7a68cf2d2 100644
> --- a/arch/arm64/kernel/signal.c
> +++ b/arch/arm64/kernel/signal.c
> @@ -538,8 +538,9 @@ static int restore_sigframe(struct pt_regs *regs,
>  	return err;
>  }
>  
> -asmlinkage long sys_rt_sigreturn(struct pt_regs *regs)
> +asmlinkage long sys_rt_sigreturn(void)
>  {
> +	struct pt_regs *regs = current_pt_regs();
>  	struct rt_sigframe __user *frame;
>  
>  	/* Always make any pending restarted system calls return -EINTR */
> diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
> index 77b91f478995..cb10588a7cb2 100644
> --- a/arch/arm64/kernel/signal32.c
> +++ b/arch/arm64/kernel/signal32.c
> @@ -282,8 +282,9 @@ static int compat_restore_sigframe(struct pt_regs *regs,
>  	return err;
>  }
>  
> -asmlinkage int compat_sys_sigreturn(struct pt_regs *regs)
> +asmlinkage int compat_sys_sigreturn(void)
>  {
> +	struct pt_regs *regs = current_pt_regs();
>  	struct compat_sigframe __user *frame;
>  
>  	/* Always make any pending restarted system calls return -EINTR */
> @@ -312,8 +313,9 @@ asmlinkage int compat_sys_sigreturn(struct pt_regs *regs)
>  	return 0;
>  }
>  
> -asmlinkage int compat_sys_rt_sigreturn(struct pt_regs *regs)
> +asmlinkage int compat_sys_rt_sigreturn(void)
>  {
> +	struct pt_regs *regs = current_pt_regs();
>  	struct compat_rt_sigframe __user *frame;
>  
>  	/* Always make any pending restarted system calls return -EINTR */
> diff --git a/arch/arm64/kernel/sys.c b/arch/arm64/kernel/sys.c
> index 72981bae10eb..31045f3fed92 100644
> --- a/arch/arm64/kernel/sys.c
> +++ b/arch/arm64/kernel/sys.c
> @@ -48,8 +48,7 @@ SYSCALL_DEFINE1(arm64_personality, unsigned int, personality)
>  /*
>   * Wrappers to pass the pt_regs argument.
>   */
> -asmlinkage long sys_rt_sigreturn_wrapper(void);
> -#define sys_rt_sigreturn	sys_rt_sigreturn_wrapper
> +asmlinkage long sys_rt_sigreturn(void);
>  #define sys_personality		sys_arm64_personality
>  
>  #undef __SYSCALL
> diff --git a/arch/arm64/kernel/sys32.c b/arch/arm64/kernel/sys32.c
> index a40b1343b819..1ef103c95410 100644
> --- a/arch/arm64/kernel/sys32.c
> +++ b/arch/arm64/kernel/sys32.c
> @@ -25,8 +25,8 @@
>  #include <linux/compiler.h>
>  #include <linux/syscalls.h>
>  
> -asmlinkage long compat_sys_sigreturn_wrapper(void);
> -asmlinkage long compat_sys_rt_sigreturn_wrapper(void);
> +asmlinkage long compat_sys_sigreturn(void);
> +asmlinkage long compat_sys_rt_sigreturn(void);
>  asmlinkage long compat_sys_statfs64_wrapper(void);
>  asmlinkage long compat_sys_fstatfs64_wrapper(void);
>  asmlinkage long compat_sys_pread64_wrapper(void);
> -- 
> 2.11.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
