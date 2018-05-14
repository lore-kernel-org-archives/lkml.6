Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754468AbeENPDY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 11:03:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42032 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752608AbeENPDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 11:03:23 -0400
Date: Mon, 14 May 2018 10:03:14 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Jiri Slaby <jslaby@suse.cz>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org
Subject: Re: [PATCH v2 2/6] x86/stacktrace: make clear the success paths
Message-ID: <20180514150314.3nok4q7eufi3vgql@treble>
References: <20180514140653.23678-1-jslaby@suse.cz>
 <20180514140653.23678-2-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180514140653.23678-2-jslaby@suse.cz>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 04:06:49PM +0200, Jiri Slaby wrote:
> Make clear which path is for user tasks and for kthreads and idle
> tasks. This will allow easier plug-in of ORC unwinder in the next
> patches.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  arch/x86/kernel/stacktrace.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/stacktrace.c b/arch/x86/kernel/stacktrace.c
> index 8948b7d9c064..3a4602c2324f 100644
> --- a/arch/x86/kernel/stacktrace.c
> +++ b/arch/x86/kernel/stacktrace.c
> @@ -104,16 +104,18 @@ __save_stack_trace_reliable(struct stack_trace *trace,
>  
>  		regs = unwind_get_entry_regs(&state, NULL);
>  		if (regs) {
> +			/* Success path for user tasks */
> +			if (user_mode(regs))
> +				goto success;
> +
>  			/*
>  			 * Kernel mode registers on the stack indicate an
>  			 * in-kernel interrupt or exception (e.g., preemption
>  			 * or a page fault), which can make frame pointers
>  			 * unreliable.
>  			 */
> -			if (!user_mode(regs))
> -				return -EINVAL;
>  
> -			break;
> +			return -EINVAL;
>  		}
>  
>  		addr = unwind_get_return_address(&state);
> @@ -138,6 +140,11 @@ __save_stack_trace_reliable(struct stack_trace *trace,
>  		return -EINVAL;
>  	}
>  
> +	/* Success path for non-user tasks, i.e. kthreads and idle tasks */
> +	if (!(task->flags & (PF_KTHREAD | PF_IDLE)))
> +		return -EINVAL;
> +
> +success:
>  	if (trace->nr_entries < trace->max_entries)
>  		trace->entries[trace->nr_entries++] = ULONG_MAX;
>  
> -- 
> 2.16.3
> 

The unwind_error() check is now getting skipped on the user mode
success path.  It would probably be safer to check it at the very top of
the loop so that it always gets checked.

Also the subject can be "clarified" a bit:

  x86/stacktrace: Clarify the reliable success paths

-- 
Josh
