Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751785AbeEDWsE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 18:48:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44532 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751621AbeEDWsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 18:48:02 -0400
Date: Fri, 4 May 2018 15:49:21 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Joel Fernandes <joelaf@google.com>
Cc: "Joel Fernandes (Google)" <joel.opensrc@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: rcu-bh design
Reply-To: paulmck@linux.vnet.ibm.com
References: <CAJWu+oqCun1Ae6GqPxnS+eCDi3jadGPp+MO8TjOWgs+AiAh79A@mail.gmail.com>
 <20180504123050.2841f80d@gandalf.local.home>
 <CAJWu+oqXmSC3zUZobQA4=qY_acRvOsq67c6dHXfVzTGqxqdaTA@mail.gmail.com>
 <20180504174330.GS26088@linux.vnet.ibm.com>
 <CAJWu+opXqw6BoKSzoV4xD0QBJ4s3C-KL=QBESZdEZ5RQCQKphw@mail.gmail.com>
 <20180504184951.GU26088@linux.vnet.ibm.com>
 <CAEi0qN=8c6tzNq26x=BBj5u3JoZHXF0DvfwWg=1vjmTU0UC4-w@mail.gmail.com>
 <20180504201129.GX26088@linux.vnet.ibm.com>
 <CAJWu+oo+KQh4NmTf4bu_paH8k_PKuzuXRXrbi3dX8bQYKJwwAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJWu+oo+KQh4NmTf4bu_paH8k_PKuzuXRXrbi3dX8bQYKJwwAQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18050422-0044-0000-0000-0000040FD4D0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008971; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000258; SDB=6.01027570; UDB=6.00524907; IPR=6.00806704;
 MB=3.00020934; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-04 22:48:01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050422-0045-0000-0000-00000841DEBA
Message-Id: <20180504224921.GE26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-04_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805040202
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 08:33:19PM +0000, Joel Fernandes wrote:
> On Fri, May 4, 2018 at 1:10 PM Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> wrote:
> [...]
> > > >> > Almost.  All context switches in an RCU-preempt read-side critical
> section
> > > >> > must be subject to priority boosting.  Preemption is one example,
> because
> > > >> > boosting the priority of the preempted task will make it runnable.
> > > >> > The priority-inheritance -rt "spinlock" is another example, because
> > > >> > boosting the priority of the task holding the lock will eventually
> make
> > > >> > runnable the task acquiring the lock within the RCU-preempt
> read-side
> > > >> > critical section.
> > > >>
> > > >> Yes I understand priority boosting is needed with preemptible RCU so
> that
> > > >> read-sections are making forward progress. I meant (and correct me
> if I'm
> > > >> wrong) that, as long as a task doesn't sleep in a preemptible RCU
> > > >> read-section (rcu-preempt flavor), then bad things wont happen and
> RCU will
> > > >> work correctly.
> > > >
> > > > The exception is -rt "spinlock" acquisition.  If the "spinlock" is
> held,
> > > > the task acquiring it will block, which is legal within an RCU-preempt
> > > > read-side critical section.
> > > >
> > > > This exception is why I define bad things in terms of lack of
> > > > susceptibility to priority boosting instead of sleeping.
> > >
> > > Oh, that's a tricky situation. Thanks for letting me know. I guess my
> > > view was too idealistic. Makes sense now.
> 
> > Well, let me put it this way...
> 
> > Here is your nice elegant little algorithm:
> > https://upload.wikimedia.org/wikipedia/commons/6/6e/Golde33443.jpg
> 
> > Here is your nice elegant little algorithm equipped to survive within
> > the Linux kernel:
> > https://totatema.files.wordpress.com/2012/06/feeling_grizzly-1600x1200.jpg
> 
> A picture speaks a 1000 words! :-D

And I suspect that a real face-to-face encounter with that guy is worth
1000 pictures.  ;-)

> > Any questions?  ;-)
> 
> Yes just one more ;-). I am trying to write a 'probetorture' test inspired
> by RCU torture that whacks the tracepoints in various scenarios. One of the
> things I want to do is verify the RCU callbacks are queued and secondly,
> they are executed. Just to verify that the garbage collect was done and
> we're not leaking the function probe table (not that I don't have
> confidence in the chained callback technique which you mentioned, but it
> would be nice to assure this mechanism is working for tracepoints).
> 
> Is there a way to detect this given a reference to srcu_struct? Mathieu and
> we were chatting about srcu_barrier which is cool but that just tells me
> that if there was a callback queued, it would have executed after the
> readers were done. But not whether something was queued.

Suppose that you are queuing an RCU callback that in turn queues an SRCU
callback on my_srcu_struct, like this:

	void my_rcu_callback(struct rcu_head *rhp)
	{
		p = container_of(rhp, struct my_struct, my_rcu_head);

		free_it_up_or_down(p);
	}

	void my_srcu_callback(struct rcu_head *rhp)
	{
		call_rcu(rhp, my_rcu_callback);
	}

	call_srcu(&my_srcu_struct, &p->my_rcu_head, my_srcu_callback);

Then to make sure that any previously submitted callback has been fully
processed, you do this:

	rcu_barrier();
	srcu_barrier(&my_srcu_struct);

Of course if you queue in the opposite order, like this:

	void my_srcu_callback(struct rcu_head *rhp)
	{
		p = container_of(rhp, struct my_struct, my_rcu_head);

		free_it_up_or_down(p);
	}

	void my_rcu_callback(struct rcu_head *rhp)
	{
		call_srcu(&my_srcu_struct, &p->my_rcu_head, my_srcu_callback);
	}

	call_rcu(rhp, my_rcu_callback);

Then you must wait in the opposite order:

	rcu_barrier();
	srcu_barrier(&my_srcu_struct);

Either way, the trick is that the first *_barrier() call cannot return
until after all previous callbacks have executed, which means that by that
time the callback is enqueued for the other flavor of {S,}RCU.  So the
second *_barrier() call must wait for the callback to be completely done,
through both flavors of {S,}RCU.

So after executing the pair of *_barrier() calls, you know that the
callback is no longer queued.

Does that cover it, or am I missing a turn in here somewhere?

							Thanx, Paul

> thanks,
> 
> - Joel
> PS: I remember Paul, you mentioned you are testing this chained callback
> case in rcutorture, so if the answer is "go read rcutorture", that's
> totally Ok I could just do that ;-)
> 
