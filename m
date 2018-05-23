Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934820AbeEWUOs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 16:14:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44582 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934424AbeEWUOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 16:14:43 -0400
Date: Wed, 23 May 2018 13:04:58 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Joel Fernandes <joelaf@google.com>, linux-kernel@vger.kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Peter Zilstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, byungchul.park@lge.com,
        kernel-team@android.com, Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 1/4] rcu: Speed up calling of RCU tasks callbacks
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180523063815.198302-1-joel@joelfernandes.org>
 <20180523063815.198302-2-joel@joelfernandes.org>
 <20180523155734.GK3803@linux.vnet.ibm.com>
 <20180523124531.7b0e972a@gandalf.local.home>
 <20180523170303.GR3803@linux.vnet.ibm.com>
 <20180523151337.469bba34@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523151337.469bba34@gandalf.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18052320-0016-0000-0000-000008C9EF08
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009073; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000261; SDB=6.01036637; UDB=6.00530330; IPR=6.00815764;
 MB=3.00021263; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-23 20:14:39
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052320-0017-0000-0000-00003EE04ED3
Message-Id: <20180523200458.GD3803@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-23_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805230198
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 03:13:37PM -0400, Steven Rostedt wrote:
> On Wed, 23 May 2018 10:03:03 -0700
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> 
> > > > > diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> > > > > index 5783bdf86e5a..a28698e44b08 100644
> > > > > --- a/kernel/rcu/update.c
> > > > > +++ b/kernel/rcu/update.c
> > > > > @@ -743,6 +743,12 @@ static int __noreturn rcu_tasks_kthread(void *arg)
> > > > >  		 */
> > > > >  		synchronize_srcu(&tasks_rcu_exit_srcu);
> > > > > 
> > > > > +		/*
> > > > > +		 * Wait a little bit incase held tasks are released    
> > > > 
> > > > 				in case
> > > >   
> > > > > +		 * during their next timer ticks.
> > > > > +		 */
> > > > > +		schedule_timeout_interruptible(HZ/10);
> > > > > +
> > > > >  		/*
> > > > >  		 * Each pass through the following loop scans the list
> > > > >  		 * of holdout tasks, removing any that are no longer
> > > > > @@ -755,7 +761,6 @@ static int __noreturn rcu_tasks_kthread(void *arg)
> > > > >  			int rtst;
> > > > >  			struct task_struct *t1;
> > > > > 
> > > > > -			schedule_timeout_interruptible(HZ);
> > > > >  			rtst = READ_ONCE(rcu_task_stall_timeout);
> > > > >  			needreport = rtst > 0 &&
> > > > >  				     time_after(jiffies, lastreport + rtst);
> > > > > @@ -768,6 +773,11 @@ static int __noreturn rcu_tasks_kthread(void *arg)
> > > > >  				check_holdout_task(t, needreport, &firstreport);
> > > > >  				cond_resched();
> > > > >  			}
> > > > > +
> > > > > +			if (list_empty(&rcu_tasks_holdouts))
> > > > > +				break;
> > > > > +
> > > > > +			schedule_timeout_interruptible(HZ);    
> > > 
> > > Why is this a full second wait and not the HZ/10 like the others?  
> > 
> > The idea is to respond quickly on small idle systems and to reduce the
> > number of possibly quite lengthy traversals of the task list otherwise.
> > I actually considered exponential backoff, but decided to keep it simple,
> > at least to start with.
> 
> Ah, now it makes sense. Reading what you wrote, we can still do a
> backoff and keep it simple. What about the patch below. It appears to
> have the same performance improvement as Joel's

Looks plausible to me!

Joel, do you see any gotchas in Steve's patch?

							Thanx, Paul

> -- Steve
> 
> > > > 
> > > > Is there a better way to do this?  Can this be converted into a for-loop?
> > > > Alternatively, would it make sense to have a firsttime local variable
> > > > initialized to true, to keep the schedule_timeout_interruptible() at
> > > > the beginning of the loop, but skip it on the first pass through the loop?
> > > > 
> > > > Don't get me wrong, what you have looks functionally correct, but
> > > > duplicating the condition might cause problems later on, for example,
> > > > should a bug fix be needed in the condition.
> > > >   
> 
> 
> diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> index 68fa19a5e7bd..c6df9fa916cf 100644
> --- a/kernel/rcu/update.c
> +++ b/kernel/rcu/update.c
> @@ -796,13 +796,22 @@ static int __noreturn rcu_tasks_kthread(void *arg)
>  		 * holdouts.  When the list is empty, we are done.
>  		 */
>  		lastreport = jiffies;
> -		while (!list_empty(&rcu_tasks_holdouts)) {
> +		for (;;) {
>  			bool firstreport;
>  			bool needreport;
>  			int rtst;
>  			struct task_struct *t1;
> +			int fract = 15;
> +
> +			/* Slowly back off waiting for holdouts */
> +			schedule_timeout_interruptible(HZ/fract);
> +
> +			if (list_empty(&rcu_tasks_holdouts))
> +				break;
> +
> +			if (fract > 1)
> +				fract--;
> 
> -			schedule_timeout_interruptible(HZ);
>  			rtst = READ_ONCE(rcu_task_stall_timeout);
>  			needreport = rtst > 0 &&
>  				     time_after(jiffies, lastreport + rtst);
> 
