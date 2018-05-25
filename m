Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936271AbeEYOtc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 10:49:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:34832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936185AbeEYOtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 10:49:31 -0400
Date: Fri, 25 May 2018 16:49:28 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Probir Roy <proy@email.wm.edu>, linux-perf-users@vger.kernel.org,
        namhyung@kernel.org, alexander.shishkin@linux.intel.com,
        acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        Andrew Lutomirski <amluto@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Perf record of mem event on kernel data address causing freeze
Message-ID: <20180525144927.GE22082@lerouge>
References: <CAC-KJC3d8aba4UMHPUE8SdM++cQXgXS_U0EvGC_aSJ3ybhbWAw@mail.gmail.com>
 <20180517143852.GD24274@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517143852.GD24274@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 04:38:52PM +0200, Jiri Olsa wrote:
> On Fri, May 11, 2018 at 02:23:14PM -0400, Probir Roy wrote:
> > I am using perf-tool to record memory access to some kernel addresses.
> > For some kernel addresses it freezes/lockup the system.
> > 
> > I am using kernel version 4.15.0 on x86_64 arch. I am running on an
> > Intel Broadwell machine.
> > 
> > I am using Intel's PEBS to sample kernel memory access while running a
> > micro-benchmark (performs repeated file operation) using following
> > command.
> > 
> > $ sudo perf mem -t store record
> > 
> > This records memory references. After that I run a script to set HW
> > breakpoint at the reference addresses.
> > 
> > $ sudo timeout 1s perf record -e mem:<0xaddress>:rw
> > 
> > It causes system hang at some address (for many address perf reports
> > correctly). Nothing is written in kern.log
> > 
> > 
> > I have reported it on bugzilla with detail system information:
> > https://bugzilla.kernel.org/show_bug.cgi?id=199697
> 
> I managed to reproduce.. in my case it's caused by having rw
> breakpoint on data which is touched within do_debug routine,
> and after few nested do_debug I get double fault
> 
> for example I can reproduce it immediately when setting breakpoint
> on rdtp->dynticks_nmi_nesting, which is checked in rcu_nmi_enter
> 
> I have some ugly patch so far that disables breakpoints during
> do_debug processing.. it seems to fix it on my server, could you
> try that?
> 
> thanks,
> jirka
> 
> 
> ---
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index 03f3d7695dac..14d41d59abeb 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -721,9 +721,12 @@ dotraplinkage void do_debug(struct pt_regs *regs, long error_code)
>  {
>  	struct task_struct *tsk = current;
>  	int user_icebp = 0;
> -	unsigned long dr6;
> +	unsigned long dr6, dr7;
>  	int si_code;
>  
> +	get_debugreg(dr7, 7);
> +	set_debugreg(0, 7);
> +
>  	ist_enter(regs);
>  
>  	get_debugreg(dr6, 6);
> @@ -818,6 +821,7 @@ dotraplinkage void do_debug(struct pt_regs *regs, long error_code)
>  
>  exit:
>  	ist_exit(regs);
> +	set_debugreg(dr7, 7);
>  }
>  NOKPROBE_SYMBOL(do_debug);

I'm not sure how much we touch dr7 while in the do_debug() trap, so we may be leaking
some modifications on exit.

I think about a simple do_debug() recursion protection. The problem is where we store
that recursion flag/counter. Ideally I would prefer to have the recursion protection
before ist_enter() which already touches many key memory data (preempt_mask, rcu_data).
But if we set that before ist_enter(), we need the recursion flag to be per task because
preemption is disabled on ist_enter() only, although the comments  suggest it's unsafe
to schedule before anyway. So it could be a TIF_FLAG. But better yet, if we want to be
able to set breakpoint on thread flags, we could add a new field in thread info.

Anyway here is a very dumb version below. Can you test it Probir, to see if that's
at least the right direction?

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 03f3d76..873383b 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -693,6 +693,8 @@ static bool is_sysenter_singlestep(struct pt_regs *regs)
 #endif
 }
 
+static DEFINE_PER_CPU(int, do_debug_recursion);
+
 /*
  * Our handling of the processor debug registers is non-trivial.
  * We do not clear them on entry and exit from the kernel. Therefore
@@ -725,6 +727,10 @@ dotraplinkage void do_debug(struct pt_regs *regs, long error_code)
 	int si_code;
 
 	ist_enter(regs);
+	if (__this_cpu_read(do_debug_recursion))
+		goto exit;
+
+	__this_cpu_write(do_debug_recursion, 1);
 
 	get_debugreg(dr6, 6);
 	/*
@@ -817,6 +823,7 @@ dotraplinkage void do_debug(struct pt_regs *regs, long error_code)
 	debug_stack_usage_dec();
 
 exit:
+	__this_cpu_write(do_debug_recursion, 0);
 	ist_exit(regs);
 }
 NOKPROBE_SYMBOL(do_debug);
