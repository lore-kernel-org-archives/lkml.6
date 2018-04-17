Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755560AbeDQQ0a (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 12:26:30 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:34602 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754365AbeDQQ00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 12:26:26 -0400
Date: Tue, 17 Apr 2018 18:10:29 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] tracing/x86: Update syscall trace events to handle new
 x86 syscall func names
Message-ID: <20180417161029.GA8733@light.dominikbrodowski.net>
References: <20180417115440.2145f7f5@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180417115440.2145f7f5@gandalf.local.home>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven,

On Tue, Apr 17, 2018 at 11:54:40AM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> Arnaldo noticed that the latest kernel is missing the syscall event system
> directory in x86. I bisected it down to d5a00528b58c ("syscalls/core,
> syscalls/x86: Rename struct pt_regs-based sys_*() to __x64_sys_*()").
> 
> The system call trace events are special, as there is only one trace event
> for all system calls (the raw_syscalls). But a macro that wraps the system
> calls creates meta data for them that copies the name to find the system
> call that maps to the system call table (the number). At boot up, it does a
> kallsyms lookup for this mapping. If it does not find a function, then that
> system call is ignored.
> 
> Because the x86 system calls had "__x86_" appended to the "sys" for the

__x64 actually.

> names, they do not match the default compare algorithm. As this was a
> problem for power pc, the algorithm can be overwritten by the architecture.
> The solution is to have x86 have its own algorithm to do the compare and
> this brings back the system call trace events.

this lets me wonder *which* syscall "function" should be included in this
directory. Is it really the stub (__x64_sys_waitid, for example), or better
the sign-extending C function (__se_sys_waitid) which then calls an
internal helper (__do_sys_waitid). An additional advantage:
__se_sys_waitid would be available on x86 and, AFAICS, on all other archs.

> Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Fixes: d5a00528b58c ("syscalls/core, syscalls/x86: Rename struct pt_regs-based sys_*() to __x64_sys_*()")
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  arch/x86/include/asm/ftrace.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
> index 09ad88572746..c30b3fac20ae 100644
> --- a/arch/x86/include/asm/ftrace.h
> +++ b/arch/x86/include/asm/ftrace.h
> @@ -31,6 +31,16 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
>  	return addr;
>  }
>  
> +#define ARCH_HAS_SYSCALL_MATCH_SYM_NAME
> +static inline bool arch_syscall_match_sym_name(const char *sym, const char *name)
> +{
> +	/*
> +	 * Compare the symbol name with the system call name. Skip the
> +	 * "__x64_sys" prefix.
> +	 */
> +	return !strcmp(sym + 9, name + 3);
> +}

What are the first three chars you skip for *name?

Thanks,
	Dominik
