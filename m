Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751336AbeEVEes (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 00:34:48 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:40061 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751272AbeEVEel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 00:34:41 -0400
X-Google-Smtp-Source: AB8JxZoFbnsNJi9LItKyHCFEf1ux25IL6vPPFQRm6hu6F+Q0lqJov8xHHxc1ZTnNqf+X1ArZQkTrhk9ETSnpCSyKoSo=
MIME-Version: 1.0
References: <20180518183623.GA163151@joelaf.mtv.corp.google.com>
 <20180519022918.GV3803@linux.vnet.ibm.com> <20180519225905.GB134184@joelaf.mtv.corp.google.com>
 <20180520004938.GZ3803@linux.vnet.ibm.com> <20180520112843.57079857@grimm.local.home>
 <20180520191846.GA248075@joelaf.mtv.corp.google.com> <20180521215951.2d6abfcb@gandalf.local.home>
In-Reply-To: <20180521215951.2d6abfcb@gandalf.local.home>
From: Joel Fernandes <joelaf@google.com>
Date: Mon, 21 May 2018 21:34:28 -0700
Message-ID: <CAJWu+or3WXt68erpat_mJHmGVfg=GJHgmKcK0tq3LOjZuPrSMw@mail.gmail.com>
Subject: Re: Tasks RCU vs Preempt RCU
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 6:59 PM Steven Rostedt <rostedt@goodmis.org> wrote:
[...]
> >
> > Just thinking out loud and probably some food for thought..
> >
> > The rcu_read_lock/unlock primitive are extrememly fast, so I don't
personally
> > think there's a time hit.
> >
> > Could we get around the trampoline code == data issue by say using a
> > multi-stage trampoline like so? :
> >
> >       call func_tramp --> (static
> >                           trampoline)               (dynamic trampoline)
> >                           rcu_read_lock()  -------> set up stack
> >                                                     call
function_tracer()
> >                                                     pop stack
> >                             rcu_read_unlock() <------ ret
> >
> > I know there's probably more to it than this, but conceptually atleast,
it

> Yes, there is more to it. Think about why we create a dynamic
> trampoline. It is to make a custom call per callback for a group of
> functions being traced by that callback.

> Now, if we make that static trampoline, we just lost the reason for the
> dynamic one. How would that work if you have 5 different users of the
> callbacks (and lets not forget about optimized kprobes)? How do you
> jump from the static trampoline to the dynamic one with a single call?

> > feels like all the RCU infrastructure is already there to handle
preemption
> > within a trampoline and it would be cool if the trampoline were as shown
> > above for the dynamically allocated trampolines. Atleast I feel it will
be
> > faster than the pre-trampoline code that did the hash lookups /
matching to
> > call the right function callbacks, and could help eliminiate need for
the
> > RCU-tasks subsystem and its kthread then.

> I don't see how the static trampoline would be able to call. Do we
> create a static trampoline for every function that is traced and never
> delete it? That's a lot of memory.

Yeah, ok. That was a dumb idea. :) I see it defeats the point.

> Also, we trace rcu_read_lock/unlock(), and I use that for a lot of
> debugging. And we also need to deal with tracing code that RCU does not
> watch, because function tracing does a lot of that too. I finally gave
> up trying to have the stack tracer trace those locations, because it
> was a serious game of whack a mole that would never end. I don't want
> to give up full function tracing for the same reason.

Yes, I understand. Its good to not have it depend on too many things which
may limit its utility.

> > If you still feel its nots worth it, then that's okay too and clearly
the
> > RCU-tasks has benefits such as a simpler trampoline implementation..

> If you are worried about making RCU simpler, we can go to my original
> thought which was to make a home grown RCU like system that we can use,
> as this has different requirements than normal RCU has. Like we don't
> need a "lock" at all. We just need guaranteed quiescent points that we
> make sure all tasks would go through before freeing the trampolines.
> But it was decided to create a new flavor of RCU instead of doing that.

Yes, lets brain storm this if you like. One way I was thinking if we can
manually check every CPU and see what state its in (usermode, kernel, idle
etc) using an IPI mechanism. Once all CPUs have been seen to be usermode,
or idle atleast once - then we are done. You have probably already thought
about this so feel free to say why its not a good idea, but to me there are
3 places that a tasks quiescent state is recorded. During the timer tick,
during task sleep and during cond_resched_tasks_qs.  Of these, I feel only
the cond_resched case isn't trackable with and IPI mechanism.

thanks,

- Joel
