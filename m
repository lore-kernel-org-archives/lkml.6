Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752529AbeETAsK (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 20:48:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56484 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752199AbeETAsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 20:48:08 -0400
Date: Sat, 19 May 2018 17:49:38 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: rostedt@goodmis.org, byungchul.park@lge.com,
        mathieu.desnoyers@efficios.com, Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: Tasks RCU vs Preempt RCU
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180518183623.GA163151@joelaf.mtv.corp.google.com>
 <20180519022918.GV3803@linux.vnet.ibm.com>
 <20180519225905.GB134184@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180519225905.GB134184@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18052000-0048-0000-0000-0000026F9CEF
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009053; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000261; SDB=6.01034809; UDB=6.00529233; IPR=6.00813937;
 MB=3.00021205; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-20 00:48:06
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052000-0049-0000-0000-0000452E423D
Message-Id: <20180520004938.GZ3803@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-19_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805200006
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 19, 2018 at 03:59:05PM -0700, Joel Fernandes wrote:
> On Fri, May 18, 2018 at 07:29:18PM -0700, Paul E. McKenney wrote:
> > On Fri, May 18, 2018 at 11:36:23AM -0700, Joel Fernandes wrote:
> > > Hi,
> > > 
> > > I was thinking about tasks-RCU and why its needed. Since preempt-RCU allows
> > > tasks to be preempted in read-sections, can we not just reuse that mechanism
> > > for the trampolines since we track all preempted tasks so we would wait on
> > > all tasks preempted within a trampoline?
> > > 
> > > I am trying to understand what will _not_ work if we did that.. I'm guessing
> > > the answer is that that would mean the trampoline has to be wrapped with
> > > rcu_read_{lock,unlock} which may add some overhead, but please let me know
> > > if I'm missing something else..
> > > 
> > > The advantage I guess is possible elimination of an RCU variant, and also
> > > possibly eliminating the tasks RCU thread that monitors.. Anyway I was
> > > thinking more in terms of the effort of reduction of the RCU flavors etc and
> > > reducing complexity ideas.
> > 
> > The problem is that if they are preempted while executing in a trampoline,
> > RCU-preempt doesn't queue them nor does it wait on them.
> 
> Not if they are wrapped with rcu_read_lock and rcu_read_unlock? From what I
> can see, you are preparing a list of blocked tasks that would keep the grace period
> from finishing in rcu_preempt_ctxt_queue?

But being on the ->blkd_tasks list doesn't necessarily block the current
grace period.  Only those tasks on that list that are also referenced
by ->gp_tasks (or that follow some task referenced by ->gp_tasks)
will block the current grace period.  This is be design -- otherwise,
an endless stream of tasks blocking in their RCU read-side critical
sections could prevent the current grace period from ever ending.

> > And the problem with wrapping them with rcu_read_{lock,unlock} is that
> > there would be a point before the trampoline executed rcu_read_lock()
> > but while it was on the trampoline.  Nothing good comes from this.  ;-)
> 
> Yes, I see what you're saying. The data being protected and freed in this
> case is the code so relying on it to do the rcu_read_lock seems infeasible.
> Conceptually atleast, I feel this can be fixed by cleverly implementing
> trampolines such that the rcu_read_lock isn't done during the trampoline
> execution. But I am not very experienced with how the trampolines work to say
> definitely whether it is or isn't possible or worth it. But atleast I felt it
> was a worthwhile food for thought ;)

I suggested to Steven that the rcu_read_lock() and rcu_read_unlock() might
be outside of the trampoline, but this turned out to be infeasible.  Not
that I remember why!  ;-)

> I actually want to trace out the trampoline executing as it pertains to RCU,
> with your latest rcu/dev.. I think it will be fun :)

Cool!

In addition, if you are interested, it might be worth looking for fields
in rcu_dynticks, rcu_data, rcu_node, and rcu_state that are no longer
actually used.  It might also be worth looking for RCU macros that are
no longer used.

I found a few by accident, so there are probably more...

							Thanx, Paul
