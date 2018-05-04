Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751760AbeEDRmN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 13:42:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57662 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751501AbeEDRmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 13:42:12 -0400
Date: Fri, 4 May 2018 10:43:30 -0700
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJWu+oqXmSC3zUZobQA4=qY_acRvOsq67c6dHXfVzTGqxqdaTA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18050417-2213-0000-0000-0000029F3095
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008970; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000258; SDB=6.01027468; UDB=6.00524846; IPR=6.00806602;
 MB=3.00020930; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-04 17:42:10
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050417-2214-0000-0000-000059FF0F69
Message-Id: <20180504174330.GS26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-04_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805040161
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 05:15:11PM +0000, Joel Fernandes wrote:
> Hi Steven,
> Just for a warning/disclaimer, I am new to RCU-land and trying to make
> sense ;-) So forgive me if something sounds too outlandish.
> 
> On Fri, May 4, 2018 at 9:30 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Fri, 04 May 2018 16:20:11 +0000
> > Joel Fernandes <joelaf@google.com> wrote:
> 
> > > Hi Paul, everyone,
> > >
> > > I had some question(s) about rcu-bh design.
> > > I am trying to understand the reasoning or need of it. I see that rcu-bh
> > > will disable softirqs across read-side sections. But I am wondering why
> > > this is needed. __do_softirq already disables softirq when a softirq
> > > handler is running. The only reason I can see is, rcu-bh helps in
> > > situations where - a softirq interrupts a preemptible RCU read-section
> and
> > > prevents that read section from completing. But this problem would
> happen
> > > if anyone where to use rcu-preempt - then does rcu-preempt even make
> sense
> > > to use and shouldn't everyone be using rcu-bh?
> 
> > I thought rcu-bh uses softirqs as a quiescent state. Thus, blocking
> > softirqs from happening makes sense. I don't think an
> > rcu_read_lock_bh() makes sense in a softirq.
> 
> Ok.
> 
> > > The other usecase for rcu-bh seems to be if context-switch is used as a
> > > quiescent state, then softirq flood can prevent that from happening and
> > > cause rcu grace periods from completing.
> 
> > > But preemptible RCU *does not* use context-switch as a quiescent state.
> > It doesn't?
> 
> I thought that's what preemptible rcu is about. You can get preempted but
> you shouldn't block in a read-section. Is that not true?

Almost.  All context switches in an RCU-preempt read-side critical section
must be subject to priority boosting.  Preemption is one example, because
boosting the priority of the preempted task will make it runnable.
The priority-inheritance -rt "spinlock" is another example, because
boosting the priority of the task holding the lock will eventually make
runnable the task acquiring the lock within the RCU-preempt read-side
critical section.

> > > So in that case rcu-bh would make
> > > sense only in a configuration where we're not using preemptible-rcu at
> all
> > > and are getting flooded by softirqs. Is that the reason rcu-bh needs to
> > > exist?
> 
> > Maybe I'm confused by what you are asking.
> 
> Sorry for any confusion. I was going through the below link for motivation
> of rcu-bh and why it was created:
> https://www.kernel.org/doc/Documentation/RCU/Design/Requirements/Requirements.html#Bottom-Half%20Flavor
> 
> I was asking why rcu-bh is needed in the kernel, like why can't we just use
> rcu-preempt. As per above link, the motivation of rcu-bh was to prevent
> denial of service during heavy softirq load. I was trying to understand
> that usecase. In my mind, such denial of service / out of memory is then
> even possible with preemptible rcu which is used in many places in the
> kernel, then why not just use rcu-bh for everything? I was just studying
> this RCU flavor (and all other RCU flavors) and so this question popped up.

Because RCU-bh is not preemptible.

And the non-DoS nature of RCU-bh is one challenge in my current quest to
fold all three flavors (RCU-bh,  RCU-preempt, and RCU-sched) into one
flavor to rule them all.  ;-)

							Thanx, Paul
