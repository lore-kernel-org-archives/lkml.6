Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752376AbeEGOxZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 10:53:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:46646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752224AbeEGOxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 10:53:22 -0400
Date: Mon, 7 May 2018 23:53:17 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>, shuah@kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Subject: Re: [PATCH v7 00/16] tracing: probeevent: Improve fetcharg features
Message-Id: <20180507235317.fa04131c603dbe59ef78a829@kernel.org>
In-Reply-To: <1525680222.8nou0tzkkt.naveen@linux.ibm.com>
References: <152465856498.26224.16969986455942749517.stgit@devbox>
        <20180503181137.6d82d897@gandalf.local.home>
        <20180505004828.9b75b6802472f09b0d2de5b8@kernel.org>
        <20180504120642.354cdd1f@gandalf.local.home>
        <20180505113803.45700179a93091b114ec6984@kernel.org>
        <1525506231.y43xvmd3yw.naveen@linux.ibm.com>
        <20180505233211.ecad929b13461f1e5f6427d2@kernel.org>
        <1525680222.8nou0tzkkt.naveen@linux.ibm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 May 2018 13:41:53 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> Masami Hiramatsu wrote:
> > On Sat, 05 May 2018 13:16:04 +0530
> > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> > 
> >> Masami Hiramatsu wrote:
> >> > On Fri, 4 May 2018 12:06:42 -0400
> >> > Steven Rostedt <rostedt@goodmis.org> wrote:
> >> > 
> >> >> On Sat, 5 May 2018 00:48:28 +0900
> >> >> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >> >> 
> >> >> > > Also, when looking at the kprobe code, I was looking at this 
> >> >> > > function:
> >> >> > >   
> >> >> > > > /* Ftrace callback handler for kprobes -- called under preepmt disabed */
> >> >> > > > void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
> >> >> > > > 			   struct ftrace_ops *ops, struct pt_regs *regs)
> >> >> > > > {
> >> >> > > > 	struct kprobe *p;
> >> >> > > > 	struct kprobe_ctlblk *kcb;
> >> >> > > > 
> >> >> > > > 	/* Preempt is disabled by ftrace */
> >> >> > > > 	p = get_kprobe((kprobe_opcode_t *)ip);
> >> >> > > > 	if (unlikely(!p) || kprobe_disabled(p))
> >> >> > > > 		return;
> >> >> > > > 
> >> >> > > > 	kcb = get_kprobe_ctlblk();
> >> >> > > > 	if (kprobe_running()) {
> >> >> > > > 		kprobes_inc_nmissed_count(p);
> >> >> > > > 	} else {
> >> >> > > > 		unsigned long orig_ip = regs->ip;
> >> >> > > > 		/* Kprobe handler expects regs->ip = ip + 1 as breakpoint hit */
> >> >> > > > 		regs->ip = ip + sizeof(kprobe_opcode_t);
> >> >> > > > 
> >> >> > > > 		/* To emulate trap based kprobes, preempt_disable here */
> >> >> > > > 		preempt_disable();
> >> >> > > > 		__this_cpu_write(current_kprobe, p);
> >> >> > > > 		kcb->kprobe_status = KPROBE_HIT_ACTIVE;
> >> >> > > > 		if (!p->pre_handler || !p->pre_handler(p, regs)) {
> >> >> > > > 			__skip_singlestep(p, regs, kcb, orig_ip);
> >> >> > > > 			preempt_enable_no_resched();  
> >> >> > > 
> >> >> > > This preemption disabling and enabling looks rather strange. Looking at
> >> >> > > git blame, it appears this was added for jprobes. Can we remove it now
> >> >> > > that jprobes is going away?  
> >> >> > 
> >> >> > No, that is not for jprobes but for compatibility with kprobe's user
> >> >> > handler. Since this transformation is done silently, user can not
> >> >> > change their handler for ftrace case. So we need to keep this condition
> >> >> > same as original kprobes.
> >> >> > 
> >> >> > And anyway, for using smp_processor_id() for accessing per-cpu,
> >> >> > we should disable preemption, correct?
> >> >> 
> >> >> But as stated at the start of the function:
> >> >> 
> >> >>  /* Preempt is disabled by ftrace */
> >> > 
> >> > Ah, yes. So this is only for the jprobes.
> >> > 
> >> >> 
> >> >> 
> >> >> The reason I ask, is that we have for this function:
> >> >> 
> >> >> 		/* To emulate trap based kprobes, preempt_disable here */
> >> >> 		preempt_disable();
> >> >> 		__this_cpu_write(current_kprobe, p);
> >> >> 		kcb->kprobe_status = KPROBE_HIT_ACTIVE;
> >> >> 		if (!p->pre_handler || !p->pre_handler(p, regs)) {
> >> >> 			__skip_singlestep(p, regs, kcb, orig_ip);
> >> >> 			preempt_enable_no_resched();
> >> >> 		}
> >> >> 
> >> >> And in arch/x86/kernel/kprobes/core.c we have:
> >> >> 
> >> >> 	preempt_disable();
> >> >> 
> >> >> 	kcb = get_kprobe_ctlblk();
> >> >> 	p = get_kprobe(addr);
> >> >> 
> >> >> 	if (p) {
> >> >> 		if (kprobe_running()) {
> >> >> 			if (reenter_kprobe(p, regs, kcb))
> >> >> 				return 1;
> >> >> 		} else {
> >> >> 			set_current_kprobe(p, regs, kcb);
> >> >> 			kcb->kprobe_status = KPROBE_HIT_ACTIVE;
> >> >> 
> >> >> 			/*
> >> >> 			 * If we have no pre-handler or it returned 0, we
> >> >> 			 * continue with normal processing.  If we have a
> >> >> 			 * pre-handler and it returned non-zero, it prepped
> >> >> 			 * for calling the break_handler below on re-entry
> >> >> 			 * for jprobe processing, so get out doing nothing
> >> >> 			 * more here.
> >> >> 			 */
> >> >> 			if (!p->pre_handler || !p->pre_handler(p, regs))
> >> >> 				setup_singlestep(p, regs, kcb, 0);
> >> >> 			return 1;
> >> >> 
> >> >> 
> >> >> Which is why I thought it was for jprobes. I'm a bit confused about
> >> >> where preemption is enabled again.
> >> > 
> >> > You're right. So I would like to remove it with x86 jprobe support
> >> > code to avoid inconsistency.
> >> 
> >> I didn't understand that. Which code are you planning to remove? Can you 
> >> please elaborate? I thought we still need to disable preemption in the 
> >> ftrace handler.
> > 
> > Yes, kprobe_ftrace_handler itself must be run under preempt disabled
> > because it depends on a per-cpu variable. What I will remove is the
> > redundant preempt disable/enable_noresched (unbalanced) pair in the
> > kprobe_ftrace_handler, and jprobe x86 ports which is no more used.
> 
> Won't that break out-of-tree users depending on returning a non-zero 
> value to handle preemption differently? You seem to have alluded to it 
> earlier in the mail chain above where you said that this is not just for 
> jprobes (though it was added for jprobes as the main use case).

No, all users are in tree already (function override for bpf and error-injection).
And also, for changing execution path by using kprobes, user handler must call
not only preempt_enable(), but also clear current_kprobe per-cpu variable which
is not exported to kmodules.

This means if there is such out-of-tree module, that must change the kernel or
hack the kernel to identify the address of curent_kprobe. If it requires such
a change or hack for the kernel, it is very easy to update the module too.

Thank you,

> 
> - Naveen
> 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
