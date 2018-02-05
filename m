Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753374AbeBERGX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 12:06:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:54290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752582AbeBERGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 12:06:16 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F05EA217AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 5 Feb 2018 12:06:12 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        linux-rt-users@vger.kernel.org, linux-trace-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Clark Williams <williams@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH 04/18] tracing/x86: Add arch_get_func_args() function
Message-ID: <20180205120612.5d7c97b0@gandalf.local.home>
In-Reply-To: <20180206013322.754e66a4c956383174418953@kernel.org>
References: <20180202230458.840252014@goodmis.org>
        <20180202231017.612058326@goodmis.org>
        <20180206013322.754e66a4c956383174418953@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Feb 2018 01:33:22 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Fri, 02 Feb 2018 18:05:02 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > 
> > Add function to get the function arguments from pt_regs.
> >   
> 
> Can we make it an independent feature in asm/ptrace.h so that
> other components (like kprobe-event) share it?

Most definitely!

> E.g.
> 
> static inline unsigned long regs_get_func_arg(struct pt_regs *regs,
>                                               unsigned int n)
> {
> 	unsigned int offs[] = {
> #ifdef CONFIG_X86_64
> 	offsetof(typeof(regs),di),
> 	offsetof(typeof(regs),si),
> 	offsetof(typeof(regs),dx),
> 	offsetof(typeof(regs),cx),
> 	offsetof(typeof(regs),r8),
> 	offsetof(typeof(regs),r9),
> #else
> 	offsetof(typeof(regs),ax),
> 	offsetof(typeof(regs),dx),
> 	offsetof(typeof(regs),cx),
> #endif
> 	};
> 
> 	if (unlikely(n >= ARRAY_SIZE(offs))
> 		return 0;
> 	return *(unsigned long *)((unsigned long)regs + offs[n]);

I like having the function I used, because it could also handle
arguments in the stack (although I didn't implement that yet). But this
would still be a nice helper function.

-- Steve


> }
> 
> And HAVE_REGS_GET_FUNC_ARG indicates this is defined on that arch.
> 
> Thank you,
> 
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > ---
> >  arch/x86/kernel/ftrace.c | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> > 
> > diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
> > index 01ebcb6f263e..5e845c8cf89d 100644
> > --- a/arch/x86/kernel/ftrace.c
> > +++ b/arch/x86/kernel/ftrace.c
> > @@ -46,6 +46,34 @@ int ftrace_arch_code_modify_post_process(void)
> >  	return 0;
> >  }
> >  
> > +int arch_get_func_args(struct pt_regs *regs,
> > +		       int start, int end, long *args)
> > +{
> > +#ifdef CONFIG_X86_64
> > +# define MAX_ARGS 6
> > +# define INIT_REGS				\
> > +	{	regs->di, regs->si, regs->dx,	\
> > +		regs->cx, regs->r8, regs->r9	\
> > +	}
> > +#else
> > +# define MAX_ARGS 3
> > +# define INIT_REGS				\
> > +	{	regs->ax, regs->dx, regs->cx	}
> > +#endif
> > +	if (!regs)
> > +		return MAX_ARGS;
> > +
> > +	{
> > +		long pt_args[] = INIT_REGS;
> > +		int i;
> > +
> > +		for (i = start; i <= end && i < MAX_ARGS; i++)
> > +			args[i - start] = pt_args[i];
> > +
> > +		return i - start;
> > +	}
> > +}
> > +
> >  union ftrace_code_union {
> >  	char code[MCOUNT_INSN_SIZE];
> >  	struct {
> > -- 
> > 2.15.1
> > 
> >   
> 
> 
