Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163878AbeCBAmp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 19:42:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:42676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163856AbeCBAmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 19:42:43 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0571021737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Fri, 2 Mar 2018 09:42:39 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Yang Bo <yangbo@deepin.com>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Laura Abbott <labbott@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/kprobe: unbalanced preempt counter with
 CONFIG_PREEMPT=y
Message-Id: <20180302094239.34c88e000aa86c4126cae99a@kernel.org>
In-Reply-To: <alpine.DEB.2.21.1803012057300.1391@nanos.tec.linutronix.de>
References: <20180115042501.20882-1-yangbo@deepin.com>
        <alpine.DEB.2.21.1803012057300.1391@nanos.tec.linutronix.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Mar 2018 22:12:56 +0100 (CET)
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Mon, 15 Jan 2018, yangbo@deepin.com wrote:
> 
> > From: Yang Bo <yangbo@deepin.com>
> > 
> > For each kprobe hook, preempt_disable() is called twice, but
> > preempt_enable() is called once, when CONFIG_PREEMPT=y. No
> > matter kprobe uses ftrace or int3. Then the preempt counter
> > overflows, the process might be preempted and migrate to another
> > cpu. It causes the kprobe int3 being treated as not kprobe's int3,
> > kernel dies.
> > 
> > The backtrace looks like this:
> > 
> > int3: 0000 [#1] PREEMPT SMP
> > Modules linkedd in: ...
> > CPU: 1 PID: 2618 COMM: ...
> > Hardware: ...
> > task: ...
> > RIP: 0010[<ffffffff81457cd5>] [<ffffffff81457cd5>] jprobe_return_end+0x0/0xb
> > ...
> > RIP [<ffffffff81457cd5>] jprobe_return_end+0x0/0xb
> > RSP ...
> > 
> > Signed-off-by: Yang Bo <yangbo@deepin.com>
> > ---
> >  arch/x86/kernel/kprobes/core.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> > index bd36f3c33cd0..1ea5c9caa8f1 100644
> > --- a/arch/x86/kernel/kprobes/core.c
> > +++ b/arch/x86/kernel/kprobes/core.c
> > @@ -611,6 +611,7 @@ static void setup_singlestep(struct kprobe *p, struct pt_regs *regs,
> >  		regs->ip = (unsigned long)p->addr;
> >  	else
> >  		regs->ip = (unsigned long)p->ainsn.insn;
> > +	preempt_enable_no_resched();
> 
> Good catch, but to be honest the proper fix is to move the preempt_enable()
> invocation to the callsite. This kind of asymetric handling is error prone
> and leads exactly to that type of bugs. Just adding more preempt_enable()
> invocations is proliferating the problem.

Oops, I missed to send my NACK not to ML...

----
> NACK. While single-stepping we have to disable preemption, this
> is balanced right after debug-exception is handled (which you
> removed next patch).
> 
> kprobes does not use only int3, but also debug (single step) exception.
> So, basically its sequence is;
> 1) disable preemption at int3 handler and return
> 2) do single-step on returned instruction
> 3) enable preemption at debug exception handler
----


> 
> Looking deeper into kprobe_int3_handler() there are more places which do
> this completely unomprehensible conditional preempt count handling via
> skip_singlestep() and setup_detour_execution(). What an unholy mess.
> 
> Masami?

As I pointed above, since kprobe has to disable preempt while singlestepping,
preempt_disable()/enable() must be separated in int3 handler and debug handler
by default. There are some exception paths for skipping singlestep to speed up
the process. Maybe I can make it better to handle it in kprobe_int3_handler()

E.g. check singlestep setup in the end of kprobe_int3_handler() and decide
 to enable preempt again or keep disabled.

Does it match to your thought?

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
