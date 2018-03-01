Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161947AbeCAVNT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 16:13:19 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:52453 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161933AbeCAVNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 16:13:14 -0500
Date: Thu, 1 Mar 2018 22:12:56 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Yang Bo <yangbo@deepin.com>
cc: Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Laura Abbott <labbott@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/kprobe: unbalanced preempt counter with
 CONFIG_PREEMPT=y
In-Reply-To: <20180115042501.20882-1-yangbo@deepin.com>
Message-ID: <alpine.DEB.2.21.1803012057300.1391@nanos.tec.linutronix.de>
References: <20180115042501.20882-1-yangbo@deepin.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jan 2018, yangbo@deepin.com wrote:

> From: Yang Bo <yangbo@deepin.com>
> 
> For each kprobe hook, preempt_disable() is called twice, but
> preempt_enable() is called once, when CONFIG_PREEMPT=y. No
> matter kprobe uses ftrace or int3. Then the preempt counter
> overflows, the process might be preempted and migrate to another
> cpu. It causes the kprobe int3 being treated as not kprobe's int3,
> kernel dies.
> 
> The backtrace looks like this:
> 
> int3: 0000 [#1] PREEMPT SMP
> Modules linkedd in: ...
> CPU: 1 PID: 2618 COMM: ...
> Hardware: ...
> task: ...
> RIP: 0010[<ffffffff81457cd5>] [<ffffffff81457cd5>] jprobe_return_end+0x0/0xb
> ...
> RIP [<ffffffff81457cd5>] jprobe_return_end+0x0/0xb
> RSP ...
> 
> Signed-off-by: Yang Bo <yangbo@deepin.com>
> ---
>  arch/x86/kernel/kprobes/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> index bd36f3c33cd0..1ea5c9caa8f1 100644
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -611,6 +611,7 @@ static void setup_singlestep(struct kprobe *p, struct pt_regs *regs,
>  		regs->ip = (unsigned long)p->addr;
>  	else
>  		regs->ip = (unsigned long)p->ainsn.insn;
> +	preempt_enable_no_resched();

Good catch, but to be honest the proper fix is to move the preempt_enable()
invocation to the callsite. This kind of asymetric handling is error prone
and leads exactly to that type of bugs. Just adding more preempt_enable()
invocations is proliferating the problem.

Looking deeper into kprobe_int3_handler() there are more places which do
this completely unomprehensible conditional preempt count handling via
skip_singlestep() and setup_detour_execution(). What an unholy mess.

Masami?

Thanks,

	tglx
