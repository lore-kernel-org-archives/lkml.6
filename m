Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934118AbeEWTNn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 15:13:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:35358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934122AbeEWTNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 15:13:40 -0400
Date: Wed, 23 May 2018 15:13:37 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Joel Fernandes <joelaf@google.com>, linux-kernel@vger.kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Peter Zilstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, byungchul.park@lge.com,
        kernel-team@android.com, Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 1/4] rcu: Speed up calling of RCU tasks callbacks
Message-ID: <20180523151337.469bba34@gandalf.local.home>
In-Reply-To: <20180523170303.GR3803@linux.vnet.ibm.com>
References: <20180523063815.198302-1-joel@joelfernandes.org>
        <20180523063815.198302-2-joel@joelfernandes.org>
        <20180523155734.GK3803@linux.vnet.ibm.com>
        <20180523124531.7b0e972a@gandalf.local.home>
        <20180523170303.GR3803@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 May 2018 10:03:03 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> > > > diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> > > > index 5783bdf86e5a..a28698e44b08 100644
> > > > --- a/kernel/rcu/update.c
> > > > +++ b/kernel/rcu/update.c
> > > > @@ -743,6 +743,12 @@ static int __noreturn rcu_tasks_kthread(void *arg)
> > > >  		 */
> > > >  		synchronize_srcu(&tasks_rcu_exit_srcu);
> > > > 
> > > > +		/*
> > > > +		 * Wait a little bit incase held tasks are released    
> > > 
> > > 				in case
> > >   
> > > > +		 * during their next timer ticks.
> > > > +		 */
> > > > +		schedule_timeout_interruptible(HZ/10);
> > > > +
> > > >  		/*
> > > >  		 * Each pass through the following loop scans the list
> > > >  		 * of holdout tasks, removing any that are no longer
> > > > @@ -755,7 +761,6 @@ static int __noreturn rcu_tasks_kthread(void *arg)
> > > >  			int rtst;
> > > >  			struct task_struct *t1;
> > > > 
> > > > -			schedule_timeout_interruptible(HZ);
> > > >  			rtst = READ_ONCE(rcu_task_stall_timeout);
> > > >  			needreport = rtst > 0 &&
> > > >  				     time_after(jiffies, lastreport + rtst);
> > > > @@ -768,6 +773,11 @@ static int __noreturn rcu_tasks_kthread(void *arg)
> > > >  				check_holdout_task(t, needreport, &firstreport);
> > > >  				cond_resched();
> > > >  			}
> > > > +
> > > > +			if (list_empty(&rcu_tasks_holdouts))
> > > > +				break;
> > > > +
> > > > +			schedule_timeout_interruptible(HZ);    
> > 
> > Why is this a full second wait and not the HZ/10 like the others?  
> 
> The idea is to respond quickly on small idle systems and to reduce the
> number of possibly quite lengthy traversals of the task list otherwise.
> I actually considered exponential backoff, but decided to keep it simple,
> at least to start with.

Ah, now it makes sense. Reading what you wrote, we can still do a
backoff and keep it simple. What about the patch below. It appears to
have the same performance improvement as Joel's

-- Steve

> > > 
> > > Is there a better way to do this?  Can this be converted into a for-loop?
> > > Alternatively, would it make sense to have a firsttime local variable
> > > initialized to true, to keep the schedule_timeout_interruptible() at
> > > the beginning of the loop, but skip it on the first pass through the loop?
> > > 
> > > Don't get me wrong, what you have looks functionally correct, but
> > > duplicating the condition might cause problems later on, for example,
> > > should a bug fix be needed in the condition.
> > >   


diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 68fa19a5e7bd..c6df9fa916cf 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -796,13 +796,22 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 		 * holdouts.  When the list is empty, we are done.
 		 */
 		lastreport = jiffies;
-		while (!list_empty(&rcu_tasks_holdouts)) {
+		for (;;) {
 			bool firstreport;
 			bool needreport;
 			int rtst;
 			struct task_struct *t1;
+			int fract = 15;
+
+			/* Slowly back off waiting for holdouts */
+			schedule_timeout_interruptible(HZ/fract);
+
+			if (list_empty(&rcu_tasks_holdouts))
+				break;
+
+			if (fract > 1)
+				fract--;
 
-			schedule_timeout_interruptible(HZ);
 			rtst = READ_ONCE(rcu_task_stall_timeout);
 			needreport = rtst > 0 &&
 				     time_after(jiffies, lastreport + rtst);
