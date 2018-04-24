Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755214AbeDXOeF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 10:34:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:46630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750778AbeDXOeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 10:34:02 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9641C21774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Tue, 24 Apr 2018 10:33:58 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] ftrace/x86: Fix arch_syscall_match_sym_name for x86_64
Message-ID: <20180424103358.3e8efe6e@gandalf.local.home>
In-Reply-To: <20180424101738.30015-1-jolsa@kernel.org>
References: <20180424101738.30015-1-jolsa@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Apr 2018 12:17:38 +0200
Jiri Olsa <jolsa@kernel.org> wrote:

> Recent commit changed the name prefix of syscalls
> for x86_64 (check the 'Fixes:' for commit number).
> 
> The names switch from "sys_" prefix to ""__x64_sys_",
> which made the default matching function always fail.
> 
> Consequently the ftrace syscall __init code could not
> match any syscall metadata so the "syscall" events
> vanished. This fix returns them back.
> 

Hi Jiri,

I already fixed it and it's queued it my tree. I'm waiting for some
other patches that are waiting for review so I can start testing and
push to Linus.

Also, this was half the fix, the total fix is here:

  http://lkml.kernel.org/r/20180418114509.5a76847d@gandalf.local.home

I think I'm done waiting, I'll start testing and get my queue out. If
the other patches don't get the proper acks, I'm not taking them.

Thanks,

-- Steve

> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Fixes: d5a00528b58c ("syscalls/core, syscalls/x86: Rename struct pt_regs-based sys_*() to __x64_sys_*()")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/x86/include/asm/ftrace.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
> index 09ad88572746..7b131ad39ee2 100644
> --- a/arch/x86/include/asm/ftrace.h
> +++ b/arch/x86/include/asm/ftrace.h
> @@ -67,6 +67,18 @@ static inline bool arch_trace_is_compat_syscall(struct pt_regs *regs)
>  	return false;
>  }
>  #endif /* CONFIG_FTRACE_SYSCALLS && CONFIG_IA32_EMULATION */
> +
> +#ifdef CONFIG_X86_64
> +#define ARCH_HAS_SYSCALL_MATCH_SYM_NAME 1
> +static inline bool arch_syscall_match_sym_name(const char *sym, const char *name)
> +{
> +	/*
> +	 * Skip the __x64_sys_ prefix and compare the
> +	 * syscall name only.
> +	 */
> +	return !strcmp(sym + 9, name + 3);
> +}
> +#endif /* CONFIG_X86_64 */
>  #endif /* !__ASSEMBLY__  && !COMPILE_OFFSETS */
>  
>  #endif /* _ASM_X86_FTRACE_H */
