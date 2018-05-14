Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932202AbeENPFE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 11:05:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39154 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754525AbeENPFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 11:05:00 -0400
Date: Mon, 14 May 2018 10:04:58 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Jiri Slaby <jslaby@suse.cz>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org
Subject: Re: [PATCH v2 3/6] x86/stacktrace: remove STACKTRACE_DUMP_ONCE from
 __save_stack_trace_reliable
Message-ID: <20180514150458.bf2u6cki4ocheiv2@treble>
References: <20180514140653.23678-1-jslaby@suse.cz>
 <20180514140653.23678-3-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180514140653.23678-3-jslaby@suse.cz>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 04:06:50PM +0200, Jiri Slaby wrote:
> The stack unwinding can sometimes fail yet. Especially with the
> generated debug info. So do not yell at users -- live patching (the only
> user of this interface) will inform the user about the failure
> gracefully.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  arch/x86/kernel/stacktrace.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/stacktrace.c b/arch/x86/kernel/stacktrace.c
> index 3a4602c2324f..e0169b128523 100644
> --- a/arch/x86/kernel/stacktrace.c
> +++ b/arch/x86/kernel/stacktrace.c
> @@ -125,20 +125,16 @@ __save_stack_trace_reliable(struct stack_trace *trace,
>  		 * generated code which __kernel_text_address() doesn't know
>  		 * about.
>  		 */
> -		if (!addr) {
> -			STACKTRACE_DUMP_ONCE(task);
> +		if (!addr)
>  			return -EINVAL;
> -		}
>  
>  		if (save_stack_address(trace, addr, false))
>  			return -EINVAL;
>  	}
>  
>  	/* Check for stack corruption */
> -	if (unwind_error(&state)) {
> -		STACKTRACE_DUMP_ONCE(task);
> +	if (unwind_error(&state))
>  		return -EINVAL;
> -	}
>  
>  	/* Success path for non-user tasks, i.e. kthreads and idle tasks */
>  	if (!(task->flags & (PF_KTHREAD | PF_IDLE)))

The STACKTRACE_DUMP_ONCE macro itself can also be removed.

Also the subject is a bit long, how about

  x86/stacktrace: Remove STACKTRACE_DUMP_ONCE

-- 
Josh
