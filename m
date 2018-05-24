Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755014AbeEXXWy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 19:22:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:38436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751796AbeEXXWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 19:22:51 -0400
Date: Thu, 24 May 2018 19:22:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zilstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, byungchul.park@lge.com,
        kernel-team@android.com, Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v4] rcu: Speed up calling of RCU tasks callbacks
Message-ID: <20180524192247.759f7572@gandalf.local.home>
In-Reply-To: <20180524231918.GA98334@joelaf.mtv.corp.google.com>
References: <20180524184946.5fa82d19@gandalf.local.home>
        <20180524231918.GA98334@joelaf.mtv.corp.google.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 May 2018 16:19:18 -0700
Joel Fernandes <joel@joelfernandes.org> wrote:

> On Thu, May 24, 2018 at 06:49:46PM -0400, Steven Rostedt wrote:
> > 
> > From: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > 
> > Joel Fernandes found that the synchronize_rcu_tasks() was taking a
> > significant amount of time. He demonstrated it with the following test:
> > 
> >  # cd /sys/kernel/tracing
> >  # while [ 1 ]; do x=1; done &
> >  # echo '__schedule_bug:traceon' > set_ftrace_filter
> >  # time echo '!__schedule_bug:traceon' > set_ftrace_filter;
> > 
> > real	0m1.064s
> > user	0m0.000s
> > sys	0m0.004s
> > 
> > Where it takes a little over a second to perform the synchronize,
> > because there's a loop that waits 1 second at a time for tasks to get
> > through their quiescent points when there's a task that must be waited
> > for.
> > 
> > After discussion we came up with a simple way to wait for holdouts but
> > increase the time for each iteration of the loop but no more than a
> > full second.
> > 
> > With the new patch we have:
> > 
> >  # time echo '!__schedule_bug:traceon' > set_ftrace_filter;
> > 
> > real	0m0.131s
> > user	0m0.000s
> > sys	0m0.004s
> > 
> > Which drops it down to 13% of what the original wait time was.  
> 
> Should be 90% of original?

That would be if I said "drops it down X" but I said "drops it down to
X of what the original wait time was". And 0.131 is 13% of 1.064. :-)

> Other than minor change log change, looks good to me:
> 
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Awesome, thanks!

-- Steve
