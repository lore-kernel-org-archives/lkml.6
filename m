Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752331AbeBHP3X (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 10:29:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:58058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752268AbeBHP3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 10:29:17 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25FEC2172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 8 Feb 2018 10:29:13 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        linux-rt-users@vger.kernel.org, linux-trace-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Clark Williams <williams@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>, kernel-team@lge.com
Subject: Re: [PATCH 04/18] tracing/x86: Add arch_get_func_args() function
Message-ID: <20180208102913.36aecd86@gandalf.local.home>
In-Reply-To: <20180208052813.GD24686@sejong>
References: <20180202230458.840252014@goodmis.org>
        <20180202231017.612058326@goodmis.org>
        <20180208052813.GD24686@sejong>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Feb 2018 14:28:13 +0900
Namhyung Kim <namhyung@kernel.org> wrote:

> Hi Steve,
> 
> On Fri, Feb 02, 2018 at 06:05:02PM -0500, Steven Rostedt wrote:
> > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > 
> > Add function to get the function arguments from pt_regs.
> > 
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
>                                 ^^^^^^^^
> 
> I expected it being 'i < end' based on your description.
> 

Ug. Thanks for pointing that out.

-- Steve

> 
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
