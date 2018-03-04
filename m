Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752525AbeCDJus (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 04:50:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:42634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751793AbeCDJup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 04:50:45 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C66D2133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Sun, 4 Mar 2018 18:50:39 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org, Yang Bo <yangbo@deepin.com>,
        Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Laura Abbott <labbott@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH -tip] x86: kprobes: Cleanup preempt disabling and
 enabling
Message-Id: <20180304185039.4ce71a8018307287814585fc@kernel.org>
In-Reply-To: <20180303212545.8aa1ddb856975ffcac4672b5@kernel.org>
References: <152004878307.12012.17534094592580782444.stgit@devbox>
        <20180303095823.phaoeuvcjhoirwg3@gmail.com>
        <20180303212545.8aa1ddb856975ffcac4672b5@kernel.org>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Mar 2018 21:25:45 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Sat, 3 Mar 2018 10:58:23 +0100
> Ingo Molnar <mingo@kernel.org> wrote:
> 
> > 
> > * Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > 
> > > +/*
> > > + * Interrupts are disabled on entry as trap3 is an interrupt gate and they
> > > + * remain disabled throughout this function.
> > > + */
> > > +int kprobe_int3_handler(struct pt_regs *regs)
> > > +{
> > > +	struct kprobe_ctlblk *kcb;
> > > +	int ret;
> > > +
> > > +	if (user_mode(regs))
> > > +		return 0;
> > > +
> > > +	/*
> > > +	 * We don't want to be preempted for the entire
> > > +	 * duration of kprobe processing.
> > > +	 */
> > > +	preempt_disable();
> > > +
> > > +	kcb = get_kprobe_ctlblk();
> > > +	ret = kprobe_int3_dispatcher(regs, kcb);
> > > +
> > > +	if (!kprobe_ready_for_singlestep(regs))
> > > +		preempt_enable_no_resched();
> > > +
> > > +	return ret;
> > 
> > What's the point of disabling preemption, if IRQs are disabled already?
> > 
> > There's no preemption when IRQs are off...
> 
> Ahh, right! Whole the kprobe singlestepping, IRQs are off (kprobes drops
> IF from regs->flags for single stepping) so we don't need to care about
> preempt count anymore...

Hmm, I've found one issue for removing preemption... This is caused by error-
injection framework and similar routines.

OK, let me explain it. Histrically, jprobe needs to run its handler with preempt
disabled. So kprobes skips preempt_enable() (and singlestep too) when its 
pre_handler returns 1 (which is the signal that the handler is jprobe pre_handler).
Thus, this patch has a bug IF jprobe is survived. Fortunatelly(?) the jprobe has
gone now, actual code is still there but interface has gone.

Then, we have no problem?
No, actually not, because of new error injection framework. The error injection
framework uses similar techniq of jprobe. But it actually doesn't call back to
longjmp-restore function, it changes regs->ip, enable preemption and return 1.
In this path, since it doesn't setup singlestep (because return 1), above patch
preempt_enable() again in the end of kprobe_int3_handler(). This may cause
double decrement the preemt count when we use error_injection feature on bpf
and fault-injection.

So it must check "does kprobes set up singlestep, or kprobe pre_handler returns 1?"

To tell the truth, this never happen currently because all error-injectable
functions are ftrace-based, which will preempt_enable() if it pre_handler
returns 1. But this means the behaviors of ftrace-based kprobes (and optprobe) and
normal kprobes are different. That is a bug.

So please ignore this patch. 
 
Anyway, I would like to change this behavior among archs after removing jprobe code.
If we don't have jprobe, there is no reason to skip preempt_enable() if pre_handler
returns 1. (including ftrace-based kprobe and optprobe)

My plan is
 1. Remove arch-independent jprobe code
 2. Remove jprobes related code from each architecture.
 3. Change preempt behavior for each arch and update error-injection/bpf code.

In step3, if I split patches for each arch, there is a chance to make a buggy kernel in
error injection code. I will make a unified patch (for tree wide) or introduce some
temporal flag (like ARCH_NO_PREEMPT_FIXUP) so that error-injection/bpf can check it.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
