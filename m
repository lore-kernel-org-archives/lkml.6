Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751365AbeETTSt (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 15:18:49 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:45575 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751030AbeETTSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 15:18:48 -0400
X-Google-Smtp-Source: AB8JxZoZlcuXNw/ABZS+Rt2FIC9/7/Q+GAflgF/EMy7NsEgBTehhTcAfs0rCQAYvHOqZh1NGUPjVcg==
Date: Sun, 20 May 2018 12:18:46 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        byungchul.park@lge.com, mathieu.desnoyers@efficios.com,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: Tasks RCU vs Preempt RCU
Message-ID: <20180520191846.GA248075@joelaf.mtv.corp.google.com>
References: <20180518183623.GA163151@joelaf.mtv.corp.google.com>
 <20180519022918.GV3803@linux.vnet.ibm.com>
 <20180519225905.GB134184@joelaf.mtv.corp.google.com>
 <20180520004938.GZ3803@linux.vnet.ibm.com>
 <20180520112843.57079857@grimm.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180520112843.57079857@grimm.local.home>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 20, 2018 at 11:28:43AM -0400, Steven Rostedt wrote:
> 
> [ Steve interrupts his time off ]

Hope you're enjoying your vacation :)

> On Sat, 19 May 2018 17:49:38 -0700
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> 
> > I suggested to Steven that the rcu_read_lock() and rcu_read_unlock() might
> > be outside of the trampoline, but this turned out to be infeasible.  Not
> > that I remember why!  ;-)
> 
> Because the trampoline itself is what needs to be freed. The trampoline
> is what mcount/fentry or an optimized kprobe jumps to.
> 
> 
> <func>:
> 	nop
> 
> [ enable function tracing ]
> 
> <func>:
> 	call func_tramp --> set up stack
> 			    call function_tracer()
> 			    pop stack
> 			    ret
> 
> 			    ^^^^^
> 			    This is the trampoline
> 
> There's no way to know when a task will be on the trampoline or not.
> The trampoline is allocated, and we need RCU_tasks to know when we can
> free it. The only way to make a "wrapper" is to modify more of the code
> text to do whatever before calling the trampoline, which is
> impractical.
> 
> The allocated trampolines were added as an optimization, where two
> registered callback functions from ftrace that are attached to two
> different functions don't call the same trampoline which would have to
> do a loop and a hash lookup to know what callback to call per function.
> If a callback is the only one attached to a specific function, then a
> trampoline is allocated and will call that callback directly, keeping
> the overhead down.

Right, I saw your trampoline prototype tree. I understand how it works now,
thanks.

> There is no feasible way to know when a task is on a trampoline
> without adding overhead that negates the speed up we receive by making
> individual trampolines to begin with.

Are you speaking of time overhead or space overhead, or both?

Just thinking out loud and probably some food for thought..

The rcu_read_lock/unlock primitive are extrememly fast, so I don't personally
think there's a time hit.

Could we get around the trampoline code == data issue by say using a
multi-stage trampoline like so? :

 	call func_tramp --> (static
			    trampoline)               (dynamic trampoline)
			    rcu_read_lock()  -------> set up stack
		 	                              call function_tracer()
 			                              pop stack
                            rcu_read_unlock() <------ ret
 
I know there's probably more to it than this, but conceptually atleast, it
feels like all the RCU infrastructure is already there to handle preemption
within a trampoline and it would be cool if the trampoline were as shown
above for the dynamically allocated trampolines. Atleast I feel it will be
faster than the pre-trampoline code that did the hash lookups / matching to
call the right function callbacks, and could help eliminiate need for the
RCU-tasks subsystem and its kthread then.

If you still feel its nots worth it, then that's okay too and clearly the
RCU-tasks has benefits such as a simpler trampoline implementation..

thanks!

- Joel
