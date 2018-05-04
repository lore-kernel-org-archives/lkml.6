Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751853AbeEDSep (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 14:34:45 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:53478 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751507AbeEDSeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 14:34:44 -0400
X-Google-Smtp-Source: AB8JxZrt4eeDAJXe0a1IELc31tZ5hcSAKPezdG+PDptA3+/gMO45XJVGoGlxdR2UjJ0jbFoygE9jXTDLORSo52OpyXE=
MIME-Version: 1.0
References: <CAJWu+oqCun1Ae6GqPxnS+eCDi3jadGPp+MO8TjOWgs+AiAh79A@mail.gmail.com>
 <20180504123050.2841f80d@gandalf.local.home> <CAJWu+oqXmSC3zUZobQA4=qY_acRvOsq67c6dHXfVzTGqxqdaTA@mail.gmail.com>
 <20180504174330.GS26088@linux.vnet.ibm.com>
In-Reply-To: <20180504174330.GS26088@linux.vnet.ibm.com>
From: Joel Fernandes <joelaf@google.com>
Date: Fri, 04 May 2018 18:34:32 +0000
Message-ID: <CAJWu+opXqw6BoKSzoV4xD0QBJ4s3C-KL=QBESZdEZ5RQCQKphw@mail.gmail.com>
Subject: Re: rcu-bh design
To: Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 4, 2018 at 10:42 AM Paul E. McKenney
<paulmck@linux.vnet.ibm.com>
wrote:
[...]
> > > > But preemptible RCU *does not* use context-switch as a quiescent
state.
> > > It doesn't?
> >
> > I thought that's what preemptible rcu is about. You can get preempted
but
> > you shouldn't block in a read-section. Is that not true?

> Almost.  All context switches in an RCU-preempt read-side critical section
> must be subject to priority boosting.  Preemption is one example, because
> boosting the priority of the preempted task will make it runnable.
> The priority-inheritance -rt "spinlock" is another example, because
> boosting the priority of the task holding the lock will eventually make
> runnable the task acquiring the lock within the RCU-preempt read-side
> critical section.

Yes I understand priority boosting is needed with preemptible RCU so that
read-sections are making forward progress. I meant (and correct me if I'm
wrong) that, as long as a task doesn't sleep in a preemptible RCU
read-section (rcu-preempt flavor), then bad things wont happen and RCU will
work correctly.


> > > > So in that case rcu-bh would make
> > > > sense only in a configuration where we're not using preemptible-rcu
at
> > all
> > > > and are getting flooded by softirqs. Is that the reason rcu-bh
needs to
> > > > exist?
> >
> > > Maybe I'm confused by what you are asking.
> >
> > Sorry for any confusion. I was going through the below link for
motivation
> > of rcu-bh and why it was created:
> >
https://www.kernel.org/doc/Documentation/RCU/Design/Requirements/Requirements.html#Bottom-Half%20Flavor
> >
> > I was asking why rcu-bh is needed in the kernel, like why can't we just
use
> > rcu-preempt. As per above link, the motivation of rcu-bh was to prevent
> > denial of service during heavy softirq load. I was trying to understand
> > that usecase. In my mind, such denial of service / out of memory is then
> > even possible with preemptible rcu which is used in many places in the
> > kernel, then why not just use rcu-bh for everything? I was just studying
> > this RCU flavor (and all other RCU flavors) and so this question popped
up.

> Because RCU-bh is not preemptible.

> And the non-DoS nature of RCU-bh is one challenge in my current quest to
> fold all three flavors (RCU-bh,  RCU-preempt, and RCU-sched) into one
> flavor to rule them all.  ;-)

But what prevents DoS'ing of RCU-preempt? That means all RCU-preempt uses
in the kernel are susceptible to DoS'ing as well?

Isn't the issue the heavy softirq processing itself which can also lead to
other issues such as scheduling issues (other than the OOM) so probably
that should be fixed instead of RCU?

thanks,

- Joel
