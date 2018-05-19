Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752561AbeESW7J (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 18:59:09 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:44877 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752045AbeESW7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 18:59:07 -0400
X-Google-Smtp-Source: AB8JxZoo6qSXqhIHhXQl5iRxVreq64M0b9KxP527uDfC3UGXf4PmtituduHr+1odZrFnFaDLRS3zzQ==
Date: Sat, 19 May 2018 15:59:05 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: rostedt@goodmis.org, byungchul.park@lge.com,
        mathieu.desnoyers@efficios.com, Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: Tasks RCU vs Preempt RCU
Message-ID: <20180519225905.GB134184@joelaf.mtv.corp.google.com>
References: <20180518183623.GA163151@joelaf.mtv.corp.google.com>
 <20180519022918.GV3803@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180519022918.GV3803@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 07:29:18PM -0700, Paul E. McKenney wrote:
> On Fri, May 18, 2018 at 11:36:23AM -0700, Joel Fernandes wrote:
> > Hi,
> > 
> > I was thinking about tasks-RCU and why its needed. Since preempt-RCU allows
> > tasks to be preempted in read-sections, can we not just reuse that mechanism
> > for the trampolines since we track all preempted tasks so we would wait on
> > all tasks preempted within a trampoline?
> > 
> > I am trying to understand what will _not_ work if we did that.. I'm guessing
> > the answer is that that would mean the trampoline has to be wrapped with
> > rcu_read_{lock,unlock} which may add some overhead, but please let me know
> > if I'm missing something else..
> > 
> > The advantage I guess is possible elimination of an RCU variant, and also
> > possibly eliminating the tasks RCU thread that monitors.. Anyway I was
> > thinking more in terms of the effort of reduction of the RCU flavors etc and
> > reducing complexity ideas.
> 
> The problem is that if they are preempted while executing in a trampoline,
> RCU-preempt doesn't queue them nor does it wait on them.

Not if they are wrapped with rcu_read_lock and rcu_read_unlock? From what I
can see, you are preparing a list of blocked tasks that would keep the grace period
from finishing in rcu_preempt_ctxt_queue?

> And the problem with wrapping them with rcu_read_{lock,unlock} is that
> there would be a point before the trampoline executed rcu_read_lock()
> but while it was on the trampoline.  Nothing good comes from this.  ;-)

Yes, I see what you're saying. The data being protected and freed in this
case is the code so relying on it to do the rcu_read_lock seems infeasible.
Conceptually atleast, I feel this can be fixed by cleverly implementing
trampolines such that the rcu_read_lock isn't done during the trampoline
execution. But I am not very experienced with how the trampolines work to say
definitely whether it is or isn't possible or worth it. But atleast I felt it
was a worthwhile food for thought ;)

I actually want to trace out the trampoline executing as it pertains to RCU,
with your latest rcu/dev.. I think it will be fun :)

thanks!

 - Joel
