Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751354AbeEVMig (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 08:38:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:34190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751036AbeEVMif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 08:38:35 -0400
Date: Tue, 22 May 2018 08:38:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        byungchul.park@lge.com, mathieu.desnoyers@efficios.com,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: Tasks RCU vs Preempt RCU
Message-ID: <20180522083832.45353d5f@gandalf.local.home>
In-Reply-To: <20180522045414.GG40541@joelaf.mtv.corp.google.com>
References: <20180518183623.GA163151@joelaf.mtv.corp.google.com>
        <20180519022918.GV3803@linux.vnet.ibm.com>
        <20180519225905.GB134184@joelaf.mtv.corp.google.com>
        <20180520004938.GZ3803@linux.vnet.ibm.com>
        <20180520112843.57079857@grimm.local.home>
        <20180520191846.GA248075@joelaf.mtv.corp.google.com>
        <20180521215951.2d6abfcb@gandalf.local.home>
        <20180522045414.GG40541@joelaf.mtv.corp.google.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 May 2018 21:54:14 -0700
Joel Fernandes <joel@joelfernandes.org> wrote:


> Yes, lets brain storm this if you like. One way I was thinking if we can
> manually check every CPU and see what state its in (usermode, kernel, idle
> etc) using an IPI mechanism. Once all CPUs have been seen to be in usermode,
> or idle atleast once - then we are done. You have probably already thought

Nope, it has nothing to do with CPUs, it really has to do with tasks.

	CPU0
	----
 task 1: (pinned to CPU 0)
	 call func_tracer_trampoline
	 [on trampoline]
	 [timer tick, schedule ]

 task 2: (higher priority, also pinned to CPU 0)
	 goes to user space
	 [ Runs for along time ]

We cannot free the trampoline until task 2 releases the CPU and lets
task 1 run again to get off the CPU.

> about this so feel free to say why its not a good idea, but to me there are 3
> places that a tasks quiescent state is recorded: during the timer tick,
> during task sleep and during rcu_note_voluntary_context_switch in
> cond_resched_rcu_qs. Of these, I feel only the cond_resched_rcu_qs case isn't
> trackable with IPI mechanism which may make the detection a bit slower, but
> tasks-RCU in mainline is slow right now anyway (~ 1 second delay if any task
> was held).


The way I was originally going to handle this was with a per task
counter, where it can be incremented at certain points via tracepoints.

Thus my synchronize tasks, would have connected to a bunch of
tracepoints at known quiescent states that would increment the counter,
and then check each task until they all pass a certain point, or are in
a quiescent state (userspace or idle). But this would be doing much of
what RCU does today, and that is why we decided to hook with the RCU
infrastructure.

I have to ask, what's your motivation for getting rid of RCU tasks?

-- Steve
