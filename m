Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751729AbeEDUdc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 16:33:32 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:44773 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751651AbeEDUdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 16:33:31 -0400
X-Google-Smtp-Source: AB8JxZq7ibINtsxDz7dqAhpVMKsuaHxDsmZA4ffG5KrdsfcjidAgnH8OsoyN5xvOHOnN0YvQSFcCmrIMJv3Lq0vDq4M=
MIME-Version: 1.0
References: <CAJWu+oqCun1Ae6GqPxnS+eCDi3jadGPp+MO8TjOWgs+AiAh79A@mail.gmail.com>
 <20180504123050.2841f80d@gandalf.local.home> <CAJWu+oqXmSC3zUZobQA4=qY_acRvOsq67c6dHXfVzTGqxqdaTA@mail.gmail.com>
 <20180504174330.GS26088@linux.vnet.ibm.com> <CAJWu+opXqw6BoKSzoV4xD0QBJ4s3C-KL=QBESZdEZ5RQCQKphw@mail.gmail.com>
 <20180504184951.GU26088@linux.vnet.ibm.com> <CAEi0qN=8c6tzNq26x=BBj5u3JoZHXF0DvfwWg=1vjmTU0UC4-w@mail.gmail.com>
 <20180504201129.GX26088@linux.vnet.ibm.com>
In-Reply-To: <20180504201129.GX26088@linux.vnet.ibm.com>
From: Joel Fernandes <joelaf@google.com>
Date: Fri, 04 May 2018 20:33:19 +0000
Message-ID: <CAJWu+oo+KQh4NmTf4bu_paH8k_PKuzuXRXrbi3dX8bQYKJwwAQ@mail.gmail.com>
Subject: Re: rcu-bh design
To: Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: "Joel Fernandes (Google)" <joel.opensrc@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 4, 2018 at 1:10 PM Paul E. McKenney <paulmck@linux.vnet.ibm.com>
wrote:
[...]
> > >> > Almost.  All context switches in an RCU-preempt read-side critical
section
> > >> > must be subject to priority boosting.  Preemption is one example,
because
> > >> > boosting the priority of the preempted task will make it runnable.
> > >> > The priority-inheritance -rt "spinlock" is another example, because
> > >> > boosting the priority of the task holding the lock will eventually
make
> > >> > runnable the task acquiring the lock within the RCU-preempt
read-side
> > >> > critical section.
> > >>
> > >> Yes I understand priority boosting is needed with preemptible RCU so
that
> > >> read-sections are making forward progress. I meant (and correct me
if I'm
> > >> wrong) that, as long as a task doesn't sleep in a preemptible RCU
> > >> read-section (rcu-preempt flavor), then bad things wont happen and
RCU will
> > >> work correctly.
> > >
> > > The exception is -rt "spinlock" acquisition.  If the "spinlock" is
held,
> > > the task acquiring it will block, which is legal within an RCU-preempt
> > > read-side critical section.
> > >
> > > This exception is why I define bad things in terms of lack of
> > > susceptibility to priority boosting instead of sleeping.
> >
> > Oh, that's a tricky situation. Thanks for letting me know. I guess my
> > view was too idealistic. Makes sense now.

> Well, let me put it this way...

> Here is your nice elegant little algorithm:
> https://upload.wikimedia.org/wikipedia/commons/6/6e/Golde33443.jpg

> Here is your nice elegant little algorithm equipped to survive within
> the Linux kernel:
> https://totatema.files.wordpress.com/2012/06/feeling_grizzly-1600x1200.jpg


A picture speaks a 1000 words! :-D

> Any questions?  ;-)

Yes just one more ;-). I am trying to write a 'probetorture' test inspired
by RCU torture that whacks the tracepoints in various scenarios. One of the
things I want to do is verify the RCU callbacks are queued and secondly,
they are executed. Just to verify that the garbage collect was done and
we're not leaking the function probe table (not that I don't have
confidence in the chained callback technique which you mentioned, but it
would be nice to assure this mechanism is working for tracepoints).

Is there a way to detect this given a reference to srcu_struct? Mathieu and
we were chatting about srcu_barrier which is cool but that just tells me
that if there was a callback queued, it would have executed after the
readers were done. But not whether something was queued.

thanks,

- Joel
PS: I remember Paul, you mentioned you are testing this chained callback
case in rcutorture, so if the answer is "go read rcutorture", that's
totally Ok I could just do that ;-)
