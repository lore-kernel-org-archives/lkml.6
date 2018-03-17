Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752284AbeCQH5y (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 03:57:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:57382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751677AbeCQH5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 03:57:53 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDB6B20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Sat, 17 Mar 2018 16:57:50 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Francis Deslauriers <francis.deslauriers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] kprobe: fix: Add ftrace_ops_assist_func to kprobe
 blacklist
Message-Id: <20180317165750.3bb30290b2bb47a3052b2700@kernel.org>
In-Reply-To: <20180316230154.2d34a98c@vmware.local.home>
References: <1500044315-9508-1-git-send-email-francis.deslauriers@efficios.com>
        <1500044315-9508-3-git-send-email-francis.deslauriers@efficios.com>
        <20170714142900.1c91949c@gandalf.local.home>
        <CADcCL0i_Rw9dRkrTUXiVK4dXOXD6QsRrBRc_pJ3XB_SyEqPR5w@mail.gmail.com>
        <20180316112517.66bdd85a@gandalf.local.home>
        <229385456.11580.1521217739037.JavaMail.zimbra@efficios.com>
        <20180316124134.30fa47d5@gandalf.local.home>
        <20180316124840.3e83bbec@gandalf.local.home>
        <1577244734.11604.1521222781948.JavaMail.zimbra@efficios.com>
        <20180317091334.55f1fc325c26deaa4d4a4d19@kernel.org>
        <20180317102211.a648f26ae0d5a53d95c63022@kernel.org>
        <20180316230154.2d34a98c@vmware.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Mar 2018 23:01:54 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 17 Mar 2018 10:22:11 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Or, we can check it by ftrace_location_range() as below patch.
> 
> Cute ;-)
> 
> > 
> > Note that as a side-effect, we can not trace functions in trace_kprobe.c
> > anymore, and this means it is hard to me to make a testcase of kprobe events.
> > It was the easiest (and maintainable) way to make test cases... sigh.
> > 
> > -----
> > tracing: kprobes: Prohibit probing on notrace function
> > 
> > From: Masami Hiramatsu <mhiramat@kernel.org>
> > 
> > Prohibit kprobe-events probing on notrace function.
> > Since probing on the notrace function can cause recursive
> > event call. In most case those are just skipped, but
> > in some case it falls into infinit recursive call.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  kernel/trace/trace_kprobe.c |   23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> > 
> > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > index 5ce9b8cf7be3..7404b012e51a 100644
> > --- a/kernel/trace/trace_kprobe.c
> > +++ b/kernel/trace/trace_kprobe.c
> > @@ -487,6 +487,23 @@ disable_trace_kprobe(struct trace_kprobe *tk, struct trace_event_file *file)
> >  	return ret;
> >  }
> >  
> > +#ifdef CONFIG_KPROBES_ON_FTRACE
> > +static bool within_notrace_func(struct trace_kprobe *tk)
> > +{
> > +	unsigned long offset, size, addr;
> > +
> > +	addr = kallsyms_lookup_name(trace_kprobe_symbol(tk));
> > +	addr += trace_kprobe_offset(tk);
> > +
> > +	if (!kallsyms_lookup_size_offset(addr, &size, &offset))
> > +		return true;	/* Out of range. */
> > +
> > +	return !ftrace_location_range(addr - offset, addr - offset + size);
> > +}
> > +#else
> > +#define within_notrace_func(tk)	(false)
> > +#endif
> > +
> >  /* Internal register function - just handle k*probes and flags */
> >  static int __register_trace_kprobe(struct trace_kprobe *tk)
> >  {
> > @@ -495,6 +512,12 @@ static int __register_trace_kprobe(struct trace_kprobe *tk)
> >  	if (trace_probe_is_registered(&tk->tp))
> >  		return -EINVAL;
> >  
> > +	if (within_notrace_func(tk)) {
> > +		pr_warn("Could not probe notrace function %s\n",
> > +			trace_kprobe_symbol(tk));
> > +		return -EINVAL;
> > +	}
> 
> This will prevent probing assembly code. Do we want to do that? Or is
> kprobes already prohibited from doing so?

No, kprobes itself can probe any assembly code except for the area where
can cause recursive hit as I explained. So anyway we still need to
mark those functions NOKPROBE_SYMBOL.

And note that this just prevent to probe those notrace code *via kprobe_events*
interface. So pure kprobe user (like systemtap) is not effected by this change.

So, maybe we would better to provide another debug knob which skips above check.
This is only for non-experienced admins :)

Thanks,

> 
> -- Steve
> 
> 
> > +
> >  	for (i = 0; i < tk->tp.nr_args; i++)
> >  		traceprobe_update_arg(&tk->tp.args[i]);
> >  
> > 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
