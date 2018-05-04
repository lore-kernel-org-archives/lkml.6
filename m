Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751846AbeEDSsg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 14:48:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35942 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751605AbeEDSsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 14:48:33 -0400
Date: Fri, 4 May 2018 11:49:51 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Joel Fernandes <joelaf@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: rcu-bh design
Reply-To: paulmck@linux.vnet.ibm.com
References: <CAJWu+oqCun1Ae6GqPxnS+eCDi3jadGPp+MO8TjOWgs+AiAh79A@mail.gmail.com>
 <20180504123050.2841f80d@gandalf.local.home>
 <CAJWu+oqXmSC3zUZobQA4=qY_acRvOsq67c6dHXfVzTGqxqdaTA@mail.gmail.com>
 <20180504174330.GS26088@linux.vnet.ibm.com>
 <CAJWu+opXqw6BoKSzoV4xD0QBJ4s3C-KL=QBESZdEZ5RQCQKphw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJWu+opXqw6BoKSzoV4xD0QBJ4s3C-KL=QBESZdEZ5RQCQKphw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18050418-0052-0000-0000-000002E918EA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008970; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000258; SDB=6.01027491; UDB=6.00524859; IPR=6.00806624;
 MB=3.00020930; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-04 18:48:31
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050418-0053-0000-0000-00005C90ED17
Message-Id: <20180504184951.GU26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-04_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805040172
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 06:34:32PM +0000, Joel Fernandes wrote:
> On Fri, May 4, 2018 at 10:42 AM Paul E. McKenney
> <paulmck@linux.vnet.ibm.com>
> wrote:
> [...]
> > > > > But preemptible RCU *does not* use context-switch as a quiescent
> state.
> > > > It doesn't?
> > >
> > > I thought that's what preemptible rcu is about. You can get preempted
> but
> > > you shouldn't block in a read-section. Is that not true?
> 
> > Almost.  All context switches in an RCU-preempt read-side critical section
> > must be subject to priority boosting.  Preemption is one example, because
> > boosting the priority of the preempted task will make it runnable.
> > The priority-inheritance -rt "spinlock" is another example, because
> > boosting the priority of the task holding the lock will eventually make
> > runnable the task acquiring the lock within the RCU-preempt read-side
> > critical section.
> 
> Yes I understand priority boosting is needed with preemptible RCU so that
> read-sections are making forward progress. I meant (and correct me if I'm
> wrong) that, as long as a task doesn't sleep in a preemptible RCU
> read-section (rcu-preempt flavor), then bad things wont happen and RCU will
> work correctly.

The exception is -rt "spinlock" acquisition.  If the "spinlock" is held,
the task acquiring it will block, which is legal within an RCU-preempt
read-side critical section.

This exception is why I define bad things in terms of lack of
susceptibility to priority boosting instead of sleeping.

> > > > > So in that case rcu-bh would make
> > > > > sense only in a configuration where we're not using preemptible-rcu
> at
> > > all
> > > > > and are getting flooded by softirqs. Is that the reason rcu-bh
> needs to
> > > > > exist?
> > >
> > > > Maybe I'm confused by what you are asking.
> > >
> > > Sorry for any confusion. I was going through the below link for
> motivation
> > > of rcu-bh and why it was created:
> > >
> https://www.kernel.org/doc/Documentation/RCU/Design/Requirements/Requirements.html#Bottom-Half%20Flavor
> > >
> > > I was asking why rcu-bh is needed in the kernel, like why can't we just
> use
> > > rcu-preempt. As per above link, the motivation of rcu-bh was to prevent
> > > denial of service during heavy softirq load. I was trying to understand
> > > that usecase. In my mind, such denial of service / out of memory is then
> > > even possible with preemptible rcu which is used in many places in the
> > > kernel, then why not just use rcu-bh for everything? I was just studying
> > > this RCU flavor (and all other RCU flavors) and so this question popped
> up.
> 
> > Because RCU-bh is not preemptible.
> 
> > And the non-DoS nature of RCU-bh is one challenge in my current quest to
> > fold all three flavors (RCU-bh,  RCU-preempt, and RCU-sched) into one
> > flavor to rule them all.  ;-)
> 
> But what prevents DoS'ing of RCU-preempt? That means all RCU-preempt uses
> in the kernel are susceptible to DoS'ing as well?

Right now, not much.  So this is one of the problems I must solve.

> Isn't the issue the heavy softirq processing itself which can also lead to
> other issues such as scheduling issues (other than the OOM) so probably
> that should be fixed instead of RCU?

In theory, yes.  In practice, the way that the kernel hangs leads them
to yell at me about RCU instead of yelling at whoever is behind the
root cause.  So it behooves me to make RCU able to deal with whatever
shows up, at least where reasonably feasible.  Otherwise, I am signed up
to fix random DoS-related bugs though more that 20 million lines of code,
which would be a nobel quest, but not one that I am currently prepared
to sign up for.  ;-)

Hence things like RCU CPU stall warnings.

But yes, there have been some modifications to softirq and I will
no doubt have to make a few more in order to make this work.

							Thanx, Paul
