Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751817AbeEDT5W (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 15:57:22 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:53396 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751527AbeEDT5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 15:57:21 -0400
X-Google-Smtp-Source: AB8JxZrVnnuW4yWXgLQTL7smOimzAQtXw6+OkOkiYX0VOFBKJdQKIMMfhfMCm1crpMN3lGLJDKVjvr/lr4YDEuFk3hk=
MIME-Version: 1.0
In-Reply-To: <20180504184951.GU26088@linux.vnet.ibm.com>
References: <CAJWu+oqCun1Ae6GqPxnS+eCDi3jadGPp+MO8TjOWgs+AiAh79A@mail.gmail.com>
 <20180504123050.2841f80d@gandalf.local.home> <CAJWu+oqXmSC3zUZobQA4=qY_acRvOsq67c6dHXfVzTGqxqdaTA@mail.gmail.com>
 <20180504174330.GS26088@linux.vnet.ibm.com> <CAJWu+opXqw6BoKSzoV4xD0QBJ4s3C-KL=QBESZdEZ5RQCQKphw@mail.gmail.com>
 <20180504184951.GU26088@linux.vnet.ibm.com>
From: Joel Fernandes <joel.opensrc@gmail.com>
Date: Fri, 4 May 2018 12:57:19 -0700
Message-ID: <CAEi0qN=8c6tzNq26x=BBj5u3JoZHXF0DvfwWg=1vjmTU0UC4-w@mail.gmail.com>
Subject: Re: rcu-bh design
To: Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: Joel Fernandes <joelaf@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 4, 2018 at 11:49 AM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
> On Fri, May 04, 2018 at 06:34:32PM +0000, Joel Fernandes wrote:
>> On Fri, May 4, 2018 at 10:42 AM Paul E. McKenney
>> <paulmck@linux.vnet.ibm.com>
>> wrote:
>> [...]
>> > > > > But preemptible RCU *does not* use context-switch as a quiescent
>> state.
>> > > > It doesn't?
>> > >
>> > > I thought that's what preemptible rcu is about. You can get preempted
>> but
>> > > you shouldn't block in a read-section. Is that not true?
>>
>> > Almost.  All context switches in an RCU-preempt read-side critical section
>> > must be subject to priority boosting.  Preemption is one example, because
>> > boosting the priority of the preempted task will make it runnable.
>> > The priority-inheritance -rt "spinlock" is another example, because
>> > boosting the priority of the task holding the lock will eventually make
>> > runnable the task acquiring the lock within the RCU-preempt read-side
>> > critical section.
>>
>> Yes I understand priority boosting is needed with preemptible RCU so that
>> read-sections are making forward progress. I meant (and correct me if I'm
>> wrong) that, as long as a task doesn't sleep in a preemptible RCU
>> read-section (rcu-preempt flavor), then bad things wont happen and RCU will
>> work correctly.
>
> The exception is -rt "spinlock" acquisition.  If the "spinlock" is held,
> the task acquiring it will block, which is legal within an RCU-preempt
> read-side critical section.
>
> This exception is why I define bad things in terms of lack of
> susceptibility to priority boosting instead of sleeping.

Oh, that's a tricky situation. Thanks for letting me know. I guess my
view was too idealistic. Makes sense now.

>> > > I was asking why rcu-bh is needed in the kernel, like why can't we just
>> use
>> > > rcu-preempt. As per above link, the motivation of rcu-bh was to prevent
>> > > denial of service during heavy softirq load. I was trying to understand
>> > > that usecase. In my mind, such denial of service / out of memory is then
>> > > even possible with preemptible rcu which is used in many places in the
>> > > kernel, then why not just use rcu-bh for everything? I was just studying
>> > > this RCU flavor (and all other RCU flavors) and so this question popped
>> up.
>>
>> > Because RCU-bh is not preemptible.
>>
>> > And the non-DoS nature of RCU-bh is one challenge in my current quest to
>> > fold all three flavors (RCU-bh,  RCU-preempt, and RCU-sched) into one
>> > flavor to rule them all.  ;-)
>>
>> But what prevents DoS'ing of RCU-preempt? That means all RCU-preempt uses
>> in the kernel are susceptible to DoS'ing as well?
>
> Right now, not much.  So this is one of the problems I must solve.

Oh, ok.

>> Isn't the issue the heavy softirq processing itself which can also lead to
>> other issues such as scheduling issues (other than the OOM) so probably
>> that should be fixed instead of RCU?
>
> In theory, yes.  In practice, the way that the kernel hangs leads them
> to yell at me about RCU instead of yelling at whoever is behind the
> root cause.  So it behooves me to make RCU able to deal with whatever
> shows up, at least where reasonably feasible.  Otherwise, I am signed up
> to fix random DoS-related bugs though more that 20 million lines of code,
> which would be a nobel quest, but not one that I am currently prepared
> to sign up for.  ;-)

Yes, I understand. :-)

thanks,

- Joel
