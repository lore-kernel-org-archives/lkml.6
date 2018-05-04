Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751612AbeEDRau (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 13:30:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36566 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751464AbeEDRat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 13:30:49 -0400
Date: Fri, 4 May 2018 10:32:06 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Joel Fernandes <joelaf@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: rcu-bh design
Reply-To: paulmck@linux.vnet.ibm.com
References: <CAJWu+oqCun1Ae6GqPxnS+eCDi3jadGPp+MO8TjOWgs+AiAh79A@mail.gmail.com>
 <20180504123050.2841f80d@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504123050.2841f80d@gandalf.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18050417-0036-0000-0000-000002EF8D11
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008970; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000258; SDB=6.01027465; UDB=6.00524844; IPR=6.00806598;
 MB=3.00020930; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-04 17:30:46
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050417-0037-0000-0000-00004437678D
Message-Id: <20180504173205.GQ26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-04_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805040160
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 12:30:50PM -0400, Steven Rostedt wrote:
> On Fri, 04 May 2018 16:20:11 +0000
> Joel Fernandes <joelaf@google.com> wrote:
> 
> > Hi Paul, everyone,
> > 
> > I had some question(s) about rcu-bh design.
> > I am trying to understand the reasoning or need of it. I see that rcu-bh
> > will disable softirqs across read-side sections. But I am wondering why
> > this is needed. __do_softirq already disables softirq when a softirq
> > handler is running. The only reason I can see is, rcu-bh helps in
> > situations where - a softirq interrupts a preemptible RCU read-section and
> > prevents that read section from completing. But this problem would happen
> > if anyone where to use rcu-preempt - then does rcu-preempt even make sense
> > to use and shouldn't everyone be using rcu-bh?
> 
> I thought rcu-bh uses softirqs as a quiescent state. Thus, blocking
> softirqs from happening makes sense. I don't think an
> rcu_read_lock_bh() makes sense in a softirq.

Agreed, any place in the code where bottom halves are enabled is an RCU-bh
quiescent state.

> > The other usecase for rcu-bh seems to be if context-switch is used as a
> > quiescent state, then softirq flood can prevent that from happening and
> > cause rcu grace periods from completing. 
> 
> > But preemptible RCU *does not* use context-switch as a quiescent state.
> 
> It doesn't?

It does, but only sort of.

A context switch really is always an RCU-preempt quiescent state from
the perspective of the CPU.  However, from the perspective of the task,
context switch is a quiescent state only if the task is not in an
RCU-preempt read-side critical section at the time.

> > So in that case rcu-bh would make
> > sense only in a configuration where we're not using preemptible-rcu at all
> > and are getting flooded by softirqs. Is that the reason rcu-bh needs to
> > exist?
> 
> Maybe I'm confused by what you are asking.

The existence and use of RCU-bh in no way degrades the preemptibility of
RCU-preempt read-side critical sections.  The reason is that RCU-bh and
RCU-preempt are completely separate, represented by different rcu_state
structure instances.

							Thanx, Paul
