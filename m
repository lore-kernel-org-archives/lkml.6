Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B07CC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECFAF2077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECFAF2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbeICUvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 16:51:42 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58496 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727447AbeICUvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 16:51:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2360480D;
        Mon,  3 Sep 2018 09:30:50 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E97893F5BC;
        Mon,  3 Sep 2018 09:30:49 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id A8E171AE3046; Mon,  3 Sep 2018 17:31:03 +0100 (BST)
Date:   Mon, 3 Sep 2018 17:31:03 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     "Haibo.Xu" <haibo.xu@arm.com>
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, nd@arm.com, jdike@addtoit.com,
        richard@nod.at
Subject: Re: [PATCH] arm64/ptrace: add PTRACE_SYSEMU and
 PTRACE_SYSEMU_SINGLESTEP support
Message-ID: <20180903163103.GC6954@arm.com>
References: <20180903062310.GA4524@haibo-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180903062310.GA4524@haibo-VirtualBox>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 02:23:17PM +0800, Haibo.Xu wrote:
> Add PTRACE_SYSEMU and PTRACE_SYSEMU_SINGLESTEP support on ARM64.
> This copies the x86 semantics for invoking ptrace hooks, and have
> been verified on ARM64 machine.
> 
> Signed-off-by: Haibo.Xu <haibo.xu@arm.com>
> Signed-off-by: Bin.Lu <bin.lu@arm.com>
> ---
>  arch/arm64/include/asm/thread_info.h |  5 ++++-
>  arch/arm64/include/uapi/asm/ptrace.h |  2 ++
>  arch/arm64/kernel/ptrace.c           | 17 +++++++++++++++++
>  3 files changed, 23 insertions(+), 1 deletion(-)

What is PTRACE_SYSEMU and what is its semantics? Why isn't it done in the
core ptrace code?

> diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
> index 46c3b93..5060d2d 100644
> --- a/arch/arm64/include/asm/thread_info.h
> +++ b/arch/arm64/include/asm/thread_info.h
> @@ -75,6 +75,7 @@ struct thread_info {
>   *  TIF_SYSCALL_TRACE	- syscall trace active
>   *  TIF_SYSCALL_TRACEPOINT - syscall tracepoint for ftrace
>   *  TIF_SYSCALL_AUDIT	- syscall auditing
> + *  TIF_SYSCALL_EMU	- syscall emulation active
>   *  TIF_SECOMP		- syscall secure computing
>   *  TIF_SIGPENDING	- signal pending
>   *  TIF_NEED_RESCHED	- rescheduling necessary
> @@ -91,6 +92,7 @@ struct thread_info {
>  #define TIF_SYSCALL_AUDIT	9
>  #define TIF_SYSCALL_TRACEPOINT	10
>  #define TIF_SECCOMP		11
> +#define TIF_SYSCALL_EMU		12
>  #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
>  #define TIF_FREEZE		19
>  #define TIF_RESTORE_SIGMASK	20
> @@ -106,6 +108,7 @@ struct thread_info {
>  #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
>  #define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)
>  #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
> +#define _TIF_SYSCALL_EMU	(1 << TIF_SYSCALL_EMU)
>  #define _TIF_UPROBE		(1 << TIF_UPROBE)
>  #define _TIF_32BIT		(1 << TIF_32BIT)
>  
> @@ -115,7 +118,7 @@ struct thread_info {
>  
>  #define _TIF_SYSCALL_WORK	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
>  				 _TIF_SYSCALL_TRACEPOINT | _TIF_SECCOMP | \
> -				 _TIF_NOHZ)
> +				 _TIF_NOHZ | _TIF_SYSCALL_EMU)
>  
>  #endif /* __KERNEL__ */
>  #endif /* __ASM_THREAD_INFO_H */
> diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
> index b5c3933..04ab06f 100644
> --- a/arch/arm64/include/uapi/asm/ptrace.h
> +++ b/arch/arm64/include/uapi/asm/ptrace.h
> @@ -23,6 +23,8 @@
>  
>  #include <asm/hwcap.h>
>  
> +#define PTRACE_SYSEMU			31
> +#define PTRACE_SYSEMU_SINGLESTEP	32
>  
>  /*
>   * PSR bits
> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> index fc35e06..ff3e322 100644
> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c
> @@ -165,6 +165,9 @@ void ptrace_disable(struct task_struct *child)
>  	 * is likely to cause regressions on obscure architectures.
>  	 */
>  	user_disable_single_step(child);
> +#ifdef TIF_SYSCALL_EMU
> +	clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
> +#endif
>  }
>  
>  #ifdef CONFIG_HAVE_HW_BREAKPOINT
> @@ -1351,6 +1354,11 @@ asmlinkage int syscall_trace_enter(struct pt_regs *regs)
>  	if (test_thread_flag(TIF_SYSCALL_TRACE))
>  		tracehook_report_syscall(regs, PTRACE_SYSCALL_ENTER);
>  
> +	if (test_thread_flag(TIF_SYSCALL_EMU)) {
> +		tracehook_report_syscall(regs, PTRACE_SYSCALL_ENTER);
> +		return -1;
> +	}

This looks weird -- are TIF_SYSCALL_EMU and TIF_SYSCALL_TRACE mutually
exclusive, or is it harmless to report this twice? Why do we return early
and skip the seccomp checks?

Will

> +
>  	/* Do the secure computing after ptrace; failures should be fast. */
>  	if (secure_computing(NULL) == -1)
>  		return -1;
> @@ -1373,6 +1381,15 @@ asmlinkage void syscall_trace_exit(struct pt_regs *regs)
>  
>  	if (test_thread_flag(TIF_SYSCALL_TRACE))
>  		tracehook_report_syscall(regs, PTRACE_SYSCALL_EXIT);
> +
> +	/*
> +	 * We only get here because of TIF_SINGLESTEP,
> +	 * for PTRACE_SYSEMU_SINGLESTEP, we already reported
> +	 * the syscall instruction in syscall_trace_enter().
> +	 */
> +	if (test_thread_flag(TIF_SINGLESTEP) &&
> +			!test_thread_flag(TIF_SYSCALL_EMU))
> +		tracehook_report_syscall_exit(regs, 1);
>  }
>  
>  /*
> -- 
> 2.7.4
> 
