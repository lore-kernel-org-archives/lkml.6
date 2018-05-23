Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753768AbeEWDKG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 23:10:06 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36263 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753165AbeEWDKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 23:10:05 -0400
X-Google-Smtp-Source: AB8JxZoaTN0vno4Yj2Cr6s7MUqREjb9XxwkO9/5KV2E5gkW4xEjhi8GRuB1a/c5fFFqt+uci/g12qw==
Date: Tue, 22 May 2018 20:10:03 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        byungchul.park@lge.com, mathieu.desnoyers@efficios.com,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: Tasks RCU vs Preempt RCU
Message-ID: <20180523031003.GA60111@joelaf.mtv.corp.google.com>
References: <20180518183623.GA163151@joelaf.mtv.corp.google.com>
 <20180519022918.GV3803@linux.vnet.ibm.com>
 <20180519225905.GB134184@joelaf.mtv.corp.google.com>
 <20180520004938.GZ3803@linux.vnet.ibm.com>
 <20180520112843.57079857@grimm.local.home>
 <20180520191846.GA248075@joelaf.mtv.corp.google.com>
 <20180521215951.2d6abfcb@gandalf.local.home>
 <20180522045414.GG40541@joelaf.mtv.corp.google.com>
 <20180522083832.45353d5f@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180522083832.45353d5f@gandalf.local.home>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 08:38:32AM -0400, Steven Rostedt wrote:
> On Mon, 21 May 2018 21:54:14 -0700
> Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> 
> > Yes, lets brain storm this if you like. One way I was thinking if we can
> > manually check every CPU and see what state its in (usermode, kernel, idle
> > etc) using an IPI mechanism. Once all CPUs have been seen to be in usermode,
> > or idle atleast once - then we are done. You have probably already thought
> 
> Nope, it has nothing to do with CPUs, it really has to do with tasks.
> 
> 	CPU0
> 	----
>  task 1: (pinned to CPU 0)
> 	 call func_tracer_trampoline
> 	 [on trampoline]
> 	 [timer tick, schedule ]
> 
>  task 2: (higher priority, also pinned to CPU 0)
> 	 goes to user space
> 	 [ Runs for along time ]
> 
> We cannot free the trampoline until task 2 releases the CPU and lets
> task 1 run again to get off the CPU.

Right. I totally missed that. Ofcourse, its not sufficient to see if a CPU is
in usermode. :(

> > about this so feel free to say why its not a good idea, but to me there are 3
> > places that a tasks quiescent state is recorded: during the timer tick,
> > during task sleep and during rcu_note_voluntary_context_switch in
> > cond_resched_rcu_qs. Of these, I feel only the cond_resched_rcu_qs case isn't
> > trackable with IPI mechanism which may make the detection a bit slower, but
> > tasks-RCU in mainline is slow right now anyway (~ 1 second delay if any task
> > was held).
> 
> 
> The way I was originally going to handle this was with a per task
> counter, where it can be incremented at certain points via tracepoints.
> 
> Thus my synchronize tasks, would have connected to a bunch of
> tracepoints at known quiescent states that would increment the counter,
> and then check each task until they all pass a certain point, or are in
> a quiescent state (userspace or idle). But this would be doing much of
> what RCU does today, and that is why we decided to hook with the RCU
> infrastructure.
> 
> I have to ask, what's your motivation for getting rid of RCU tasks?

Again, my motivation was just to see if we could use RCU-preempt. Linus was
talking about unifying RCU variants/API better. I believe Paul is well on top of
that task and I have been helping as I could with his recent series for that.
Since RCU-preempt doesn't suit this job, looks like we have keep RCU tasks
around. That said I sent you a patch to speed up RCU-tasks a bit, could you a
take a look? Paul was asking for your input: https://lkml.org/lkml/2018/5/20/263

Welcome back from your vacation, hope it was fun!

thanks,

 - Joel
