Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964941AbeCCBVF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 20:21:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:34602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964922AbeCCBVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 20:21:04 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A2952178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Sat, 3 Mar 2018 10:20:59 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Yang Bo <yangbo@deepin.com>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Laura Abbott <labbott@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/kprobe: unbalanced preempt counter with
 CONFIG_PREEMPT=y
Message-Id: <20180303102059.ccda7bd4fc9c279c1e481a41@kernel.org>
In-Reply-To: <alpine.DEB.2.21.1803020935170.1803@nanos.tec.linutronix.de>
References: <20180115042501.20882-1-yangbo@deepin.com>
        <alpine.DEB.2.21.1803012057300.1391@nanos.tec.linutronix.de>
        <20180302094239.34c88e000aa86c4126cae99a@kernel.org>
        <alpine.DEB.2.21.1803020935170.1803@nanos.tec.linutronix.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Mar 2018 09:36:06 +0100 (CET)
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Fri, 2 Mar 2018, Masami Hiramatsu wrote:
> > On Thu, 1 Mar 2018 22:12:56 +0100 (CET)
> > Thomas Gleixner <tglx@linutronix.de> wrote:
> > > > For each kprobe hook, preempt_disable() is called twice, but
> > > > preempt_enable() is called once, when CONFIG_PREEMPT=y. No
> > > > matter kprobe uses ftrace or int3. Then the preempt counter
> > > > overflows, the process might be preempted and migrate to another
> > > > cpu. It causes the kprobe int3 being treated as not kprobe's int3,
> > > > kernel dies.
> > > > 
> > > > The backtrace looks like this:
> > > > 
> > > > int3: 0000 [#1] PREEMPT SMP
> > > > Modules linkedd in: ...
> > > > CPU: 1 PID: 2618 COMM: ...
> > > > Hardware: ...
> > > > task: ...
> > > > RIP: 0010[<ffffffff81457cd5>] [<ffffffff81457cd5>] jprobe_return_end+0x0/0xb
> > > > ...
> > > > RIP [<ffffffff81457cd5>] jprobe_return_end+0x0/0xb
> > > > RSP ...
> > > > 
> > > > Signed-off-by: Yang Bo <yangbo@deepin.com>
> > > > ---
> > > >  arch/x86/kernel/kprobes/core.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> > > > index bd36f3c33cd0..1ea5c9caa8f1 100644
> > > > --- a/arch/x86/kernel/kprobes/core.c
> > > > +++ b/arch/x86/kernel/kprobes/core.c
> > > > @@ -611,6 +611,7 @@ static void setup_singlestep(struct kprobe *p, struct pt_regs *regs,
> > > >  		regs->ip = (unsigned long)p->addr;
> > > >  	else
> > > >  		regs->ip = (unsigned long)p->ainsn.insn;
> > > > +	preempt_enable_no_resched();
> > > 
> > > Good catch, but to be honest the proper fix is to move the preempt_enable()
> > > invocation to the callsite. This kind of asymetric handling is error prone
> > > and leads exactly to that type of bugs. Just adding more preempt_enable()
> > > invocations is proliferating the problem.
> > 
> > Oops, I missed to send my NACK not to ML...
> > 
> > ----
> > > NACK. While single-stepping we have to disable preemption, this
> > > is balanced right after debug-exception is handled (which you
> > > removed next patch).
> > > 
> > > kprobes does not use only int3, but also debug (single step) exception.
> > > So, basically its sequence is;
> > > 1) disable preemption at int3 handler and return
> > > 2) do single-step on returned instruction
> > > 3) enable preemption at debug exception handler
> 
> Well, but that does not make the crash Yang is seeing magically go
> away. There must be a bug in that logic somewhere and that needs to be
> addressed.

As Yang said, this bug had been fixed by 

commit 5bb4fc2d8641 ("Disable preemption in ftrace-based jprobes")


> 
> > > Looking deeper into kprobe_int3_handler() there are more places which do
> > > this completely unomprehensible conditional preempt count handling via
> > > skip_singlestep() and setup_detour_execution(). What an unholy mess.
> > > 
> > > Masami?
> > 
> > As I pointed above, since kprobe has to disable preempt while singlestepping,
> > preempt_disable()/enable() must be separated in int3 handler and debug handler
> > by default. There are some exception paths for skipping singlestep to speed up
> > the process. Maybe I can make it better to handle it in kprobe_int3_handler()
> >
> > E.g. check singlestep setup in the end of kprobe_int3_handler() and decide
> >  to enable preempt again or keep disabled.
> > 
> > Does it match to your thought?
> 
> Yes. Doing it at the callsite and documenting the rules proper is much
> preferred. Right now the code looks like:
> 
> 
> 	preempt_disable();
> 	if (foo) {
> 		if (baz())
> 			return;
> 		....
> 		return;
> 	} else {
> 		more of this....
> 	}
> 	preempt_enable();
> 
> And the preempt_enable() is conditionally inside of baz() and other
> functions, which is completely non-obvious.
> 
> 	preempt_disable();
> 	if (foo) {
> 		if (baz()) {
> 			preempt_enable();
> 			return;
> 		}
> 		....
> 		/* Keep preemption disabled across the probe operation */
> 		return;
> 	} else {
> 		more of this....
> 	}
> 	preempt_enable();
> 
> That's a bit more understandable, but still confusing.
> 
> Preemption needs to be disabled when the probe hits and reenabled when the
> probe operation finishes, right?
> 
> So I'd rather have an indicator for probe in progress and use that to
> control preemption:
> 
> handler()
> {
> 	if (!current->probe_active) {
> 		if (is_probe()) {
> 			do_stuff();
> 			current->probe_active = true;
> 			/* Keep preemption disabled across the probe operation */
> 			preempt_disable();
> 			return 1;
> 		}
> 		return 0;
> 	}
> 
> 	if (probe_done()) {
> 	   	do_other_stuff();
> 		current->probe_active = false;
> 		preempt_enable();
> 		return 1;
> 	}
> 	do_more_stuff();
> 	return 1;
> }
> 
> See how that automatically documents the mode of operation and the
> preemption semantics? No need for all that conditional preempt_enable()
> stuff all over the place. It's in reality probably not that simple, but you
> get the idea.

Ok, my idea will be a bit simpler.

handler()
{
	preempt_disable();
	ret = do_kprobe();
	if (!prepared_for_singlestep())
		preempt_enable();
	return ret;
}

This shows in what case we keep preempt disabled, and give a hint
where it is enabled again :)

Thanks,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
