Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754005AbeDRMx2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 08:53:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:57420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753933AbeDRMx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 08:53:26 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 211162175C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Wed, 18 Apr 2018 09:53:22 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
        LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org
Subject: Re: [PATCH v2] tracing/x86: Update syscall trace events to handle
 new x86 syscall func names
Message-ID: <20180418125322.GB2895@kernel.org>
References: <20180417130702.01575029@gandalf.local.home>
 <20180417172236.GA17342@light.dominikbrodowski.net>
 <20180417180430.GF3625@kernel.org>
 <20180417181304.GA2895@kernel.org>
 <20180417174128.0f3457f0@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180417174128.0f3457f0@gandalf.local.home>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Apr 17, 2018 at 05:41:28PM -0400, Steven Rostedt escreveu:
> On Tue, 17 Apr 2018 15:13:04 -0300 Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > Yeah, failing:

> > [root@jouet ~]# strace -e openat -e file perf test -F -v "mmap interface" |& grep syscalls
> > openat(AT_FDCWD, "/sys/kernel/debug/tracing/events/syscalls/sys_enter_getsid/format", O_RDONLY) = 3
> > openat(AT_FDCWD, "/sys/kernel/debug/tracing/events/syscalls/sys_enter_getppid/format", O_RDONLY) = -1 ENOENT (No such file or directory)
 
> It doesn't have to do with the number of parameters, not everything
> has "__x64" on it.
 
> Try this patch:

Trying...
 
> diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
> index 09ad88572746..15582648887f 100644
> --- a/arch/x86/include/asm/ftrace.h
> +++ b/arch/x86/include/asm/ftrace.h
> @@ -31,6 +31,19 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
>  	return addr;
>  }
>  
> +#define ARCH_HAS_SYSCALL_MATCH_SYM_NAME
> +static inline bool arch_syscall_match_sym_name(const char *sym, const char *name)
> +{
> +	/*
> +	 * Compare the symbol name with the system call name. Skip the
> +	 * "__x64_sys", "__ia32_sys" or simple "sys" prefix.
> +	 */
> +	return !strcmp(sym + 3, name + 3) ||
> +		(!strncmp(sym, "__x64_", 6) && !strcmp(sym + 9, name + 3)) ||
> +		(!strncmp(sym, "__ia32_", 7) && !strcmp(sym + 10, name + 3));
> +
> +}
> +
>  #ifdef CONFIG_DYNAMIC_FTRACE
>  
>  struct dyn_arch_ftrace {
