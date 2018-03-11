Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932303AbeCKPF2 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 11:05:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:55694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932155AbeCKPF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 11:05:27 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF4FF20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Mon, 12 Mar 2018 00:05:22 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Yang Bo <yangbo@deepin.com>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Laura Abbott <labbott@redhat.com>, Josef Bacik <jbacik@fb.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [RFC PATCH -tip 8/9] error-injection: Fix to not enabling
 preemption in pre_handler
Message-Id: <20180312000522.8bfbd3d5da5fce8a5242ee84@kernel.org>
In-Reply-To: <20180310082248.6inyi5rcxhay2e6v@gmail.com>
References: <152059891712.4214.9539716544254881611.stgit@devbox>
        <152059915597.4214.4086303893931787678.stgit@devbox>
        <20180310082248.6inyi5rcxhay2e6v@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Mar 2018 09:22:48 +0100
Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Since kprobes pre_handler doesn't need to recover preemption
> > even if it modifies regs->ip anymore, this fixes to remove
> > the preempt_enable_no_resched() from pre_handler.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  kernel/fail_function.c |    1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/kernel/fail_function.c b/kernel/fail_function.c
> > index 21b0122cb39c..b1713521f096 100644
> > --- a/kernel/fail_function.c
> > +++ b/kernel/fail_function.c
> > @@ -176,7 +176,6 @@ static int fei_kprobe_handler(struct kprobe *kp, struct pt_regs *regs)
> >  		override_function_with_return(regs);
> >  		/* Kprobe specific fixup */
> >  		reset_current_kprobe();
> > -		preempt_enable_no_resched();
> >  		return 1;
> >  	}
> 
> So where did the matching preempt_disable() get removed? If it's the 6/9 patch, 
> then this patch (and 8/9) should very much be part of it.

It is 7/9, in kprobe_int3_handler() and kprobe_ftrace_handler().
The latter is a bit tricky, originally it enable preemption only when
the pre_handler returns 0, but 7/9 changes it always enables preemption.

> 
> There should be no bisection breakage in the series.

OK, I will merge 7/9-9/9 (anyway those are currently only support x86).

Thanks,

> 
> Thanks,
> 
> 	Ingo


-- 
Masami Hiramatsu <mhiramat@kernel.org>
