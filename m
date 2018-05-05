Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751941AbeEECiJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 22:38:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:42500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751709AbeEECiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 22:38:07 -0400
Date: Sat, 5 May 2018 11:38:03 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-trace-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: Re: [PATCH v7 00/16] tracing: probeevent: Improve fetcharg features
Message-Id: <20180505113803.45700179a93091b114ec6984@kernel.org>
In-Reply-To: <20180504120642.354cdd1f@gandalf.local.home>
References: <152465856498.26224.16969986455942749517.stgit@devbox>
        <20180503181137.6d82d897@gandalf.local.home>
        <20180505004828.9b75b6802472f09b0d2de5b8@kernel.org>
        <20180504120642.354cdd1f@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 May 2018 12:06:42 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 5 May 2018 00:48:28 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > So the syntax will be
> > 
> > p[:EVENT] SYM[(CAST)|+OFFS] [FETCHARG]
> > 
> > And here is an example;
> > 
> > p:myevent vfs_read(void *file, char *buf, size_t count, void *pos) $arg1 $arg2
> 
> If we do this, why bother with $arg1 $arg2?

User may want to trace only some of them. :)

> 
> We could allow this to be an alternative format?

I think we can skip passing $args, which implies trace all arguments.

p[:EVENT] SYM[(CAST)|+OFFS] [FETCHARG(*)]

*) if SYM(CAST) is given but no FETCHARG, which implies to trace
all arguments in the CAST.

> > In this case inside '()' will be analyzed and packed as something
> > like "reference type" data and it is used when converting "$argN".
> > And maybe we can provide $args special variable to record all
> > arguments (it can be available only when the (CAST) is given).
> > 
> > This gives the user a consistent model; if you just give a symbol
> > the arguments may not be correctly translated. but if you give a
> > type-casting information, it will be much better.
> > 
> > > 
> > > Also, when looking at the kprobe code, I was looking at this function:
> > >   
> > > > /* Ftrace callback handler for kprobes -- called under preepmt disabed */
> > > > void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
> > > > 			   struct ftrace_ops *ops, struct pt_regs *regs)
> > > > {
> > > > 	struct kprobe *p;
> > > > 	struct kprobe_ctlblk *kcb;
> > > > 
> > > > 	/* Preempt is disabled by ftrace */
> > > > 	p = get_kprobe((kprobe_opcode_t *)ip);
> > > > 	if (unlikely(!p) || kprobe_disabled(p))
> > > > 		return;
> > > > 
> > > > 	kcb = get_kprobe_ctlblk();
> > > > 	if (kprobe_running()) {
> > > > 		kprobes_inc_nmissed_count(p);
> > > > 	} else {
> > > > 		unsigned long orig_ip = regs->ip;
> > > > 		/* Kprobe handler expects regs->ip = ip + 1 as breakpoint hit */
> > > > 		regs->ip = ip + sizeof(kprobe_opcode_t);
> > > > 
> > > > 		/* To emulate trap based kprobes, preempt_disable here */
> > > > 		preempt_disable();
> > > > 		__this_cpu_write(current_kprobe, p);
> > > > 		kcb->kprobe_status = KPROBE_HIT_ACTIVE;
> > > > 		if (!p->pre_handler || !p->pre_handler(p, regs)) {
> > > > 			__skip_singlestep(p, regs, kcb, orig_ip);
> > > > 			preempt_enable_no_resched();  
> > > 
> > > This preemption disabling and enabling looks rather strange. Looking at
> > > git blame, it appears this was added for jprobes. Can we remove it now
> > > that jprobes is going away?  
> > 
> > No, that is not for jprobes but for compatibility with kprobe's user
> > handler. Since this transformation is done silently, user can not
> > change their handler for ftrace case. So we need to keep this condition
> > same as original kprobes.
> > 
> > And anyway, for using smp_processor_id() for accessing per-cpu,
> > we should disable preemption, correct?
> 
> But as stated at the start of the function:
> 
>  /* Preempt is disabled by ftrace */

Ah, yes. So this is only for the jprobes.

> 
> 
> The reason I ask, is that we have for this function:
> 
> 		/* To emulate trap based kprobes, preempt_disable here */
> 		preempt_disable();
> 		__this_cpu_write(current_kprobe, p);
> 		kcb->kprobe_status = KPROBE_HIT_ACTIVE;
> 		if (!p->pre_handler || !p->pre_handler(p, regs)) {
> 			__skip_singlestep(p, regs, kcb, orig_ip);
> 			preempt_enable_no_resched();
> 		}
> 
> And in arch/x86/kernel/kprobes/core.c we have:
> 
> 	preempt_disable();
> 
> 	kcb = get_kprobe_ctlblk();
> 	p = get_kprobe(addr);
> 
> 	if (p) {
> 		if (kprobe_running()) {
> 			if (reenter_kprobe(p, regs, kcb))
> 				return 1;
> 		} else {
> 			set_current_kprobe(p, regs, kcb);
> 			kcb->kprobe_status = KPROBE_HIT_ACTIVE;
> 
> 			/*
> 			 * If we have no pre-handler or it returned 0, we
> 			 * continue with normal processing.  If we have a
> 			 * pre-handler and it returned non-zero, it prepped
> 			 * for calling the break_handler below on re-entry
> 			 * for jprobe processing, so get out doing nothing
> 			 * more here.
> 			 */
> 			if (!p->pre_handler || !p->pre_handler(p, regs))
> 				setup_singlestep(p, regs, kcb, 0);
> 			return 1;
> 
> 
> Which is why I thought it was for jprobes. I'm a bit confused about
> where preemption is enabled again.

You're right. So I would like to remove it with x86 jprobe support
code to avoid inconsistency.

Thanks!

-- 
Masami Hiramatsu <mhiramat@kernel.org>
