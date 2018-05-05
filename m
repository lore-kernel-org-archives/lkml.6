Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751811AbeEEAjs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 20:39:48 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:41487 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751710AbeEEAjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 20:39:47 -0400
X-Google-Smtp-Source: AB8JxZr9ImOoO0sSr+hKh0pJYXCO7XZ17+Yq1QP7iAvqoAXpYf7UeDPlLx/PJ1e4pRBOsW6QDb89EnwpL6GUZlR4D7g=
MIME-Version: 1.0
References: <20180504123050.2841f80d@gandalf.local.home> <CAJWu+oqXmSC3zUZobQA4=qY_acRvOsq67c6dHXfVzTGqxqdaTA@mail.gmail.com>
 <20180504174330.GS26088@linux.vnet.ibm.com> <CAJWu+opXqw6BoKSzoV4xD0QBJ4s3C-KL=QBESZdEZ5RQCQKphw@mail.gmail.com>
 <20180504184951.GU26088@linux.vnet.ibm.com> <CAEi0qN=8c6tzNq26x=BBj5u3JoZHXF0DvfwWg=1vjmTU0UC4-w@mail.gmail.com>
 <20180504201129.GX26088@linux.vnet.ibm.com> <CAJWu+oo+KQh4NmTf4bu_paH8k_PKuzuXRXrbi3dX8bQYKJwwAQ@mail.gmail.com>
 <20180504224921.GE26088@linux.vnet.ibm.com> <5ab0c23a-f98d-859f-593f-f32f6c470626@google.com>
 <20180504234342.GJ26088@linux.vnet.ibm.com>
In-Reply-To: <20180504234342.GJ26088@linux.vnet.ibm.com>
From: Joel Fernandes <joelaf@google.com>
Date: Sat, 05 May 2018 00:39:36 +0000
Message-ID: <CAJWu+ornetogyZ4orGFsea-urbdJC2+3UhCT_FKVmJ_EHncX1A@mail.gmail.com>
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

On Fri, May 4, 2018 at 4:42 PM Paul E. McKenney <paulmck@linux.vnet.ibm.com>
wrote:
[..]
> > Say that the tracepoint code is buggy and for some reason a
> > call_srcu wasn't done. For example, say the hypothetical bug I'm
> > taking about is in tracepoint_remove_func which called the
> > rcu_assign_pointer, but didn't call release_probes:
> >
> > diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
> > index d0639d917899..f54cb358f451 100644
> > --- a/kernel/tracepoint.c
> > +++ b/kernel/tracepoint.c
> > @@ -216,7 +216,6 @@ static int tracepoint_add_func(struct tracepoint
*tp,
> >         rcu_assign_pointer(tp->funcs, tp_funcs);
> >         if (!static_key_enabled(&tp->key))
> >                 static_key_slow_inc(&tp->key);
> > -       release_probes(old);
> >         return 0;
> >  }
> > ---
> > I want to catching this from the test code. If I did the following,
> > it would be insufficient then:
> >
> > trace_probe_register(...);
> > srcu_barrier(&my_srcu_struct);  // only tells me any queued calls
> >                               // are done but not that something
> >                               // was queued
> >
> > I was seeing if I could use my_srcu_struct::completed for that. but
> > I'm not sure if that'll work (or that its legal to access it
> > directly - but hey this is just test code! :P).

> This is a bit ugly to do programmatically in the kernel.  The callbacks
> are on per-CPU queues that cannot be safely accessed except by that CPU.
> Plus they are on singly linked lists that can be quite long, so it could
> be insanely slow as well.

> But given that this is test code, why not leverage event tracing?
> There are some relevant events in include/trace/events/rcu.h, starting
> with the rcu_callback trace event.


Sounds like a great idea. I'll try that, thanks.

- Joel
