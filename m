Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755286AbeDQQjd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 12:39:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:56620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754781AbeDQQja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 12:39:30 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C2542175C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Tue, 17 Apr 2018 12:39:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] tracing/x86: Update syscall trace events to handle new
 x86 syscall func names
Message-ID: <20180417123927.4406f990@gandalf.local.home>
In-Reply-To: <20180417161029.GA8733@light.dominikbrodowski.net>
References: <20180417115440.2145f7f5@gandalf.local.home>
        <20180417161029.GA8733@light.dominikbrodowski.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Apr 2018 18:10:29 +0200
Dominik Brodowski <linux@dominikbrodowski.net> wrote:


> > Because the x86 system calls had "__x86_" appended to the "sys" for the  
> 
> __x64 actually.

Heh, I constantly make that mistake.

Hmm, OK, I need to look at this a bit more. If this is x64, then
there's probably syscalls (on 32 bit), that don't have that. It should
probably include more checks. Something like:

  return !strcmp(sym + 9, name + 3) || !strcmp(sym + 3, name + 3);


> 
> > names, they do not match the default compare algorithm. As this was a
> > problem for power pc, the algorithm can be overwritten by the architecture.
> > The solution is to have x86 have its own algorithm to do the compare and
> > this brings back the system call trace events.  
> 
> this lets me wonder *which* syscall "function" should be included in this
> directory. Is it really the stub (__x64_sys_waitid, for example), or better
> the sign-extending C function (__se_sys_waitid) which then calls an
> internal helper (__do_sys_waitid). An additional advantage:
> __se_sys_waitid would be available on x86 and, AFAICS, on all other archs.

It should include anything that uses the "SYSCALL_DEFINE#()" macros.

> 
> > Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Fixes: d5a00528b58c ("syscalls/core, syscalls/x86: Rename struct pt_regs-based sys_*() to __x64_sys_*()")
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > ---
> >  arch/x86/include/asm/ftrace.h | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
> > index 09ad88572746..c30b3fac20ae 100644
> > --- a/arch/x86/include/asm/ftrace.h
> > +++ b/arch/x86/include/asm/ftrace.h
> > @@ -31,6 +31,16 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
> >  	return addr;
> >  }
> >  
> > +#define ARCH_HAS_SYSCALL_MATCH_SYM_NAME
> > +static inline bool arch_syscall_match_sym_name(const char *sym, const char *name)
> > +{
> > +	/*
> > +	 * Compare the symbol name with the system call name. Skip the
> > +	 * "__x64_sys" prefix.
> > +	 */
> > +	return !strcmp(sym + 9, name + 3);
> > +}  
> 
> What are the first three chars you skip for *name?

"sys_"

-- Steve

> 
> Thanks,
> 	Dominik
