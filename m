Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758757AbeD0QID (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 12:08:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:51240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758578AbeD0QH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 12:07:58 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BAE82188D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Fri, 27 Apr 2018 12:07:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Joel Fernandes <joelaf@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        fweisbec <fweisbec@gmail.com>, Randy Dunlap <rdunlap@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        kbuild test robot <fengguang.wu@intel.com>,
        baohong liu <baohong.liu@intel.com>,
        vedang patel <vedang.patel@intel.com>,
        kernel-team <kernel-team@android.com>
Subject: Re: [PATCH RFC] tracepoint: Introduce tracepoint callbacks
 executing with preempt on
Message-ID: <20180427120754.42203144@gandalf.local.home>
In-Reply-To: <362165882.5842.1524843735295.JavaMail.zimbra@efficios.com>
References: <20180427042656.190746-1-joelaf@google.com>
        <1169911546.5820.1524839189395.JavaMail.zimbra@efficios.com>
        <20180427104747.2d965925@gandalf.local.home>
        <362165882.5842.1524843735295.JavaMail.zimbra@efficios.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Apr 2018 11:42:15 -0400 (EDT)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> ----- On Apr 27, 2018, at 10:47 AM, rostedt rostedt@goodmis.org wrote:
> 
> > On Fri, 27 Apr 2018 10:26:29 -0400 (EDT)
> > Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> >   
> >> The general approach and the implementation look fine, except for
> >> one small detail: I would be tempted to explicitly disable preemption
> >> around the call to the tracepoint callback for the rcuidle variant,
> >> unless we plan to audit every tracer right away to remove any assumption
> >> that preemption is disabled in the callback implementation.  
> > 
> > I'm thinking that we do that audit. There shouldn't be many instances
> > of it. I like the idea that a tracepoint callback gets called with
> > preemption enabled.  
> 
> I see that ftrace explicitly disables preemption in its ring buffer
> code. FWIW, this is redundant when called from sched-rcu tracepoints
> and from kprobes which adds unnecessary performance overhead.

Sure, but that code is called from other locations that do not have
preemption disabled. Calling preempt_disable() is far from the biggest
overhead of that code path.

> 
> LTTng expects preemption to be disabled when invoked. I can adapt on my
> side as needed, but would prefer not to have redundant preemption disabling
> for probes hooking on sched-rcu tracepoints (which is the common case).

Why not? Really, preempt_disable is simply a per cpu counter, with only
need of adding compiler barriers.

> 
> Do perf callbacks expect preemption to be disabled ?

I'll have to look, but wouldn't be hard to change.

-- Steve
