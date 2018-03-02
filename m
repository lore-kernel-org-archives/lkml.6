Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426418AbeCBSBb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 13:01:31 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60042 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424042AbeCBSB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 13:01:29 -0500
Date: Fri, 2 Mar 2018 18:01:31 +0000
From: Will Deacon <will.deacon@arm.com>
To: Douglas Anderson <dianders@chromium.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, briannorris@chromium.org,
        evgreen@chromium.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64/debug: Fix registers on sleeping tasks
Message-ID: <20180302180131.GA20579@arm.com>
References: <20180301193803.129195-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180301193803.129195-1-dianders@chromium.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2018 at 11:38:03AM -0800, Douglas Anderson wrote:
> This is the equivalent of commit 001bf455d206 ("ARM: 8428/1: kgdb: Fix
> registers on sleeping tasks") but for arm64.  Nuff said.

It's a pity that 001bf455d206 doesn't explain *why* past_pt_regs doesn't
work.

Anyway, does this mean you're actually using kgdb on arm64? Does the rest of
it appear to work?

Will

> diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
> index 2122cd187f19..01285d4dcdc3 100644
> --- a/arch/arm64/kernel/kgdb.c
> +++ b/arch/arm64/kernel/kgdb.c
> @@ -138,14 +138,26 @@ int dbg_set_reg(int regno, void *mem, struct pt_regs *regs)
>  void
>  sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct task_struct *task)
>  {
> -	struct pt_regs *thread_regs;
> +	struct thread_struct *thread = &task->thread;
> +	struct cpu_context *cpu_context = &thread->cpu_context;
>  
>  	/* Initialize to zero */
>  	memset((char *)gdb_regs, 0, NUMREGBYTES);
> -	thread_regs = task_pt_regs(task);
> -	memcpy((void *)gdb_regs, (void *)thread_regs->regs, GP_REG_BYTES);
> -	/* Special case for PSTATE (check comments in asm/kgdb.h for details) */
> -	dbg_get_reg(33, gdb_regs + GP_REG_BYTES, thread_regs);
> +
> +	gdb_regs[19] = cpu_context->x19;
> +	gdb_regs[20] = cpu_context->x20;
> +	gdb_regs[21] = cpu_context->x21;
> +	gdb_regs[22] = cpu_context->x22;
> +	gdb_regs[23] = cpu_context->x23;
> +	gdb_regs[24] = cpu_context->x24;
> +	gdb_regs[25] = cpu_context->x25;
> +	gdb_regs[26] = cpu_context->x26;
> +	gdb_regs[27] = cpu_context->x27;
> +	gdb_regs[28] = cpu_context->x28;
> +	gdb_regs[29] = cpu_context->fp;
> +
> +	gdb_regs[31] = cpu_context->sp;
> +	gdb_regs[32] = cpu_context->pc;
>  }
>  
>  void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long pc)
> -- 
> 2.16.2.395.g2e18187dfd-goog
> 
