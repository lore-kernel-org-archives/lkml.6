Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751240AbeECWLm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 18:11:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:54714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750965AbeECWLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 18:11:40 -0400
Date: Thu, 3 May 2018 18:11:37 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-trace-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: Re: [PATCH v7 00/16] tracing: probeevent: Improve fetcharg features
Message-ID: <20180503181137.6d82d897@gandalf.local.home>
In-Reply-To: <152465856498.26224.16969986455942749517.stgit@devbox>
References: <152465856498.26224.16969986455942749517.stgit@devbox>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Apr 2018 21:16:06 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi,
> 
> This is the 7th version of the fetch-arg improvement series.
> This includes variable changes on fetcharg framework like,
> 
> - Add fetcharg testcases (syntax, argN, symbol, string and array)
>   and probepoint testcase.
> - Rewrite fetcharg framework with fetch_insn, switch-case based
>   instead of function pointer.
> - Add "symbol" type support, which shows symbol+offset instead of
>   address value.
> - Add "$argN" fetcharg, which fetches function parameters.
>   (currently only for x86-64)
> - Add array type support (including string arrary :) ) ,
>   which enables to get fixed length array from probe-events.
> - Add array type support for perf-probe, so that user can
>   dump partial array entries.
> 
> V6 is here:
>  https://lkml.org/lkml/2018/3/17/75
> 
> Changes from the v6 are here:
>  [6/16]  - Fix to return an error if failed to fetch string and
>         fill zero-length data_loc in error case.
>  [11/16] - Update document for restructured text.
>  [15/16] - Fix README test.
>  [16/16] - Add type-casting description (and note) to documentation.
> 
> And rebased on the latest Steve's ftrace/core branch.
> 

Hi Masami,

I skimmed through the patches and it they appear fine. I've applied
them and started playing a little.

I've been thinking my function based events, and thought instead I
would make them part of the kprobe infrastructure. Just have a slightly
different format, and instead of being p: or r: be f: And keep the
format I was suggesting.

What do you think?

Also, when looking at the kprobe code, I was looking at this function:

> /* Ftrace callback handler for kprobes -- called under preepmt disabed */
> void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
> 			   struct ftrace_ops *ops, struct pt_regs *regs)
> {
> 	struct kprobe *p;
> 	struct kprobe_ctlblk *kcb;
> 
> 	/* Preempt is disabled by ftrace */
> 	p = get_kprobe((kprobe_opcode_t *)ip);
> 	if (unlikely(!p) || kprobe_disabled(p))
> 		return;
> 
> 	kcb = get_kprobe_ctlblk();
> 	if (kprobe_running()) {
> 		kprobes_inc_nmissed_count(p);
> 	} else {
> 		unsigned long orig_ip = regs->ip;
> 		/* Kprobe handler expects regs->ip = ip + 1 as breakpoint hit */
> 		regs->ip = ip + sizeof(kprobe_opcode_t);
> 
> 		/* To emulate trap based kprobes, preempt_disable here */
> 		preempt_disable();
> 		__this_cpu_write(current_kprobe, p);
> 		kcb->kprobe_status = KPROBE_HIT_ACTIVE;
> 		if (!p->pre_handler || !p->pre_handler(p, regs)) {
> 			__skip_singlestep(p, regs, kcb, orig_ip);
> 			preempt_enable_no_resched();

This preemption disabling and enabling looks rather strange. Looking at
git blame, it appears this was added for jprobes. Can we remove it now
that jprobes is going away?

> 		}
> 		/*
> 		 * If pre_handler returns !0, it sets regs->ip and
> 		 * resets current kprobe, and keep preempt count +1.
> 		 */
> 	}
> }

-- Steve
