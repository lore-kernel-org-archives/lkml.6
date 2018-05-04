Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751826AbeEDRPY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 13:15:24 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:41064 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751676AbeEDRPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 13:15:23 -0400
X-Google-Smtp-Source: AB8JxZqCMC9ARDzXJEdEBrghCOZGSVcPW4mcrc0OZ2dHHrsA+nHiFqh/5Q7Jb1r0LnIGf5+GDjA9MwJPvh6NKnISev8=
MIME-Version: 1.0
References: <CAJWu+oqCun1Ae6GqPxnS+eCDi3jadGPp+MO8TjOWgs+AiAh79A@mail.gmail.com>
 <20180504123050.2841f80d@gandalf.local.home>
In-Reply-To: <20180504123050.2841f80d@gandalf.local.home>
From: Joel Fernandes <joelaf@google.com>
Date: Fri, 04 May 2018 17:15:11 +0000
Message-ID: <CAJWu+oqXmSC3zUZobQA4=qY_acRvOsq67c6dHXfVzTGqxqdaTA@mail.gmail.com>
Subject: Re: rcu-bh design
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,
Just for a warning/disclaimer, I am new to RCU-land and trying to make
sense ;-) So forgive me if something sounds too outlandish.

On Fri, May 4, 2018 at 9:30 AM Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 04 May 2018 16:20:11 +0000
> Joel Fernandes <joelaf@google.com> wrote:

> > Hi Paul, everyone,
> >
> > I had some question(s) about rcu-bh design.
> > I am trying to understand the reasoning or need of it. I see that rcu-bh
> > will disable softirqs across read-side sections. But I am wondering why
> > this is needed. __do_softirq already disables softirq when a softirq
> > handler is running. The only reason I can see is, rcu-bh helps in
> > situations where - a softirq interrupts a preemptible RCU read-section
and
> > prevents that read section from completing. But this problem would
happen
> > if anyone where to use rcu-preempt - then does rcu-preempt even make
sense
> > to use and shouldn't everyone be using rcu-bh?

> I thought rcu-bh uses softirqs as a quiescent state. Thus, blocking
> softirqs from happening makes sense. I don't think an
> rcu_read_lock_bh() makes sense in a softirq.

Ok.

> >
> > The other usecase for rcu-bh seems to be if context-switch is used as a
> > quiescent state, then softirq flood can prevent that from happening and
> > cause rcu grace periods from completing.

> > But preemptible RCU *does not* use context-switch as a quiescent state.

> It doesn't?

I thought that's what preemptible rcu is about. You can get preempted but
you shouldn't block in a read-section. Is that not true?


> > So in that case rcu-bh would make
> > sense only in a configuration where we're not using preemptible-rcu at
all
> > and are getting flooded by softirqs. Is that the reason rcu-bh needs to
> > exist?

> Maybe I'm confused by what you are asking.

Sorry for any confusion. I was going through the below link for motivation
of rcu-bh and why it was created:
https://www.kernel.org/doc/Documentation/RCU/Design/Requirements/Requirements.html#Bottom-Half%20Flavor

I was asking why rcu-bh is needed in the kernel, like why can't we just use
rcu-preempt. As per above link, the motivation of rcu-bh was to prevent
denial of service during heavy softirq load. I was trying to understand
that usecase. In my mind, such denial of service / out of memory is then
even possible with preemptible rcu which is used in many places in the
kernel, then why not just use rcu-bh for everything? I was just studying
this RCU flavor (and all other RCU flavors) and so this question popped up.

thanks,

- Joel
