Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752667AbeCQAJB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 20:09:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:52648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751348AbeCQAJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 20:09:00 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C31204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Sat, 17 Mar 2018 09:08:54 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: rostedt <rostedt@goodmis.org>,
        Francis Deslauriers <francis.deslauriers@efficios.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] kprobe: fix: Add ftrace_ops_assist_func to kprobe
 blacklist
Message-Id: <20180317090854.aef4a3dc6552eeeb00e50498@kernel.org>
In-Reply-To: <229385456.11580.1521217739037.JavaMail.zimbra@efficios.com>
References: <1500044315-9508-1-git-send-email-francis.deslauriers@efficios.com>
        <1500044315-9508-3-git-send-email-francis.deslauriers@efficios.com>
        <20170714142900.1c91949c@gandalf.local.home>
        <CADcCL0i_Rw9dRkrTUXiVK4dXOXD6QsRrBRc_pJ3XB_SyEqPR5w@mail.gmail.com>
        <20180316112517.66bdd85a@gandalf.local.home>
        <229385456.11580.1521217739037.JavaMail.zimbra@efficios.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Mar 2018 12:28:59 -0400 (EDT)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> ----- On Mar 16, 2018, at 11:25 AM, rostedt rostedt@goodmis.org wrote:
> 
> > On Fri, 16 Mar 2018 11:18:25 -0400
> > Francis Deslauriers <francis.deslauriers@efficios.com> wrote:
> > 
> >> Hi Steven,
> >> 
> >> I completely forgot about this issue until recently when I encountered it again.
> >> Instrumenting the ftrace_ops_assist_func symbol and some other symbol
> >> seems to be causing problems.
> >> 
> >> Placing kretprobes like in the following configuration crashes my
> >> kernel (4.16.0-rc5) on a Qemu/KVM virtual machine:
> >> 
> >> config 1:
> >> echo "r:event_1 __fdget" >> kprobe_events
> >> echo "r:event_2 ftrace_ops_assist_func" >> kprobe_events
> >> 
> >> config 2:
> >> echo "r:event_1 __fdget_pos" >> kprobe_events
> >> echo "r:event_2 ftrace_ops_assist_func" >> kprobe_events
> >> 
> >> config 3:
> >> echo 'r:event_1 arch_dup_task_struct' >> kprobe_events
> >> echo 'r:event_2 ftrace_ops_assist_func' >> kprobe_events
> >> 
> >> config 4:
> >> echo 'r:event_1 sys_open' >> kprobe_events
> >> echo 'r:event_2 ftrace_ops_assist_func' >> kprobe_events
> >> 
> >> Here is my kernel config [1]:
> >> 
> >> In a previous email [2], you mentioned that you would like to add the
> >> ftrace-related symbols to a section to un-blacklist them all at once
> >> on demand but wanted to discuss it at Linux Plumbers. Do you still
> >> think that it's the right approach?
> > 
> > We probably didn't discuss it (as there was a lot to discuss, and this
> > was probably overshadowed by that). But yes, you should not probe
> > ftrace called functions. That is guaranteed to crash and that crash is
> > not a bug, but a feature.
> 
> Are you really arguing that crashing the kernel from an ABI visible from
> userspace (even if it's only root user) is not a bug ? You are joking right ?
> Is there an EXPERIMENTAL config option that people need to select in order to
> make sure those ftrace interfaces don't end up on production systems ?
> 
> > 
> > The ftrace and ring buffer files should be blacklisted from being
> > probed. Perhaps the entire directory.
> 
> All code reachable from a kprobe handler should be blacklisted from
> kprobes, yes.

No, actually that is incorrect, since user can make a module to probe
those functions from outside of ftrace via kprobes.

The problematic functions are the functions called between probe-hit
and set current_kprobe (iow, kprobe_ftrace_handler()). After setting
current_kprobe, all probe hits are just skipped.

The issue that Francis faced is actual bug. It must be blacklisted,
since it is called before calling kprobe_ftrace_handler().

target_func
  -> fentry-code
     -> ftrace-code
          -> kprobe_ftrace_handler
                (safe area)
          <- ret
      <- ret (ftrace-code)
  <- ret (fentry-code)

In above model, functions in fentry-code and ftrace-code must be
blacklisted.

Thanks,

> > Anyway, I don't see this as much of an urgent matter, as it's one of
> > those "Patient: Doc, it hurts when I do this. Doc: Don't do that"
> > cases. And there's a lot of urgent issues that currently need to be
> > dealt with.
> 
> OK, short-term we'll remove everything related to ftrace functions
> from our CI fuzzer coverage. Arguably, the fact that a root user can
> crash the kernel through tracefs files is not that great security-wise
> though.
> 
> Considering that our current focus is to test the kprobe instrumentation
> layer (and not ftrace per se), we will move our fuzzer to the LTTng ABI
> instead, which should take care of removing crashes introduced by ftrace
> from our fuzzing results.
> 
> Thanks,
> 
> Mathieu
> 
> 
> > 
> > -- Steve
> > 
> > 
> >> 
> >> I can easily test any patch regarding this issue.
> >> 
> >> [1] http://paste.ubuntu.com/p/BJWvgMnW8z/
> >> [2] https://lkml.org/lkml/2017/7/14/568
> >> 
> >> Thank you,
> >> 
> >> 2017-07-14 14:29 GMT-04:00 Steven Rostedt <rostedt@goodmis.org>:
> >> > On Fri, 14 Jul 2017 10:58:35 -0400
> >> > Francis Deslauriers <francis.deslauriers@efficios.com> wrote:
> >> >  
> >> >> This function is called when a kprobe is hit. Thus it should be
> >> >> blacklisted to prevent kprobe to be triggered by kprobes.
> >> >>
> >> >> Signed-off-by: Francis Deslauriers <francis.deslauriers@efficios.com>
> >> >> ---
> >> >>  kernel/trace/ftrace.c | 2 ++
> >> >>  1 file changed, 2 insertions(+)
> >> >>
> >> >> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> >> >> index b308be3..c473d9b 100644
> >> >> --- a/kernel/trace/ftrace.c
> >> >> +++ b/kernel/trace/ftrace.c
> >> >> @@ -36,6 +36,7 @@
> >> >>
> >> >>  #include <trace/events/sched.h>
> >> >>
> >> >> +#include <asm/kprobes.h>
> >> >>  #include <asm/sections.h>
> >> >>  #include <asm/setup.h>
> >> >>
> >> >> @@ -5739,6 +5740,7 @@ static void ftrace_ops_assist_func(unsigned long ip,
> >> >> unsigned long parent_ip,
> >> >>       preempt_enable_notrace();
> >> >>       trace_clear_recursion(bit);
> >> >>  }
> >> >> +NOKPROBE_SYMBOL(ftrace_ops_assist_func);
> >> >
> >> > Continuing from what I said in the other email, this is fixing a
> >> > symptom and not the problem. The real fix will be much more involved. I
> >> > have a good idea on how to accomplish it too.
> >> >
> >> > -- Steve
> >> >
> >> >  
> >> >>
> >> >>  /**
> >> >>   * ftrace_ops_get_func - get the function a trampoline should call
> >> >  
> >> 
> >> 
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com


-- 
Masami Hiramatsu <mhiramat@kernel.org>
