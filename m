Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756128AbeCHQTh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 11:19:37 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39757 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756069AbeCHQTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 11:19:35 -0500
X-Google-Smtp-Source: AG47ELtbD1Xf3WKXFvQJb9wf0Zti87hq4sAipmDrLPEdHFs0QWgk74I84r7tbmCTgy4tblMoCAm9Ug==
Subject: Re: [PATCH v2] arm64/debug: Fix registers on sleeping tasks
To: Douglas Anderson <dianders@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>
Cc: briannorris@chromium.org, evgreen@chromium.org, swboyd@chromium.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180305234309.233226-1-dianders@chromium.org>
From: Daniel Thompson <daniel.thompson@linaro.org>
Message-ID: <382abcdd-5264-0c0c-282f-d1f52ecff8e3@linaro.org>
Date: Thu, 8 Mar 2018 16:19:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180305234309.233226-1-dianders@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/18 23:43, Douglas Anderson wrote:
> This is the equivalent of commit 001bf455d206 ("ARM: 8428/1: kgdb: Fix
> registers on sleeping tasks") but for arm64.  Nuff said.
> 
> ...well, perhaps I could also add that task_pt_regs are userspace
> registers and that's not what kgdb is supposed to be reporting.  We're
> supposed to be reporting kernel registers.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

I hacked together a (still very immature) kgdb test suite[1] around the 
turn of the year. Whilst its not quite solid enough for me to recommend 
others deploy it except out of curiosity... so I haven't yet started 
yelling about test suite failures except in the privacy of my own head.

However I can confirm that this patch fixes one of the test suite 
failures I haven't had time to blame allocate yet!

So...
Tested-by: Daniel Thompson <daniel.thompson@linaro.org>

BTW is this something that should Cc: stable?


Daniel.

[1] https://github.com/daniel-thompson/kgdbtest


> ---
> 
> Changes in v2:
> - Init cpu_context in one line
> - Explain that task_pt_regs are userspace
> 
>   arch/arm64/kernel/kgdb.c | 21 ++++++++++++++++-----
>   1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
> index 2122cd187f19..a20de58061a8 100644
> --- a/arch/arm64/kernel/kgdb.c
> +++ b/arch/arm64/kernel/kgdb.c
> @@ -138,14 +138,25 @@ int dbg_set_reg(int regno, void *mem, struct pt_regs *regs)
>   void
>   sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct task_struct *task)
>   {
> -	struct pt_regs *thread_regs;
> +	struct cpu_context *cpu_context = &task->thread.cpu_context;
>   
>   	/* Initialize to zero */
>   	memset((char *)gdb_regs, 0, NUMREGBYTES);
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
>   }
>   
>   void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long pc)
> 
