Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752518AbeEVQI0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 12:08:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50562 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751412AbeEVQIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 12:08:19 -0400
Date: Tue, 22 May 2018 09:09:49 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Joel Fernandes <joel@joelfernandes.org>, byungchul.park@lge.com,
        mathieu.desnoyers@efficios.com, Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: Tasks RCU vs Preempt RCU
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180518183623.GA163151@joelaf.mtv.corp.google.com>
 <20180519022918.GV3803@linux.vnet.ibm.com>
 <20180519225905.GB134184@joelaf.mtv.corp.google.com>
 <20180520004938.GZ3803@linux.vnet.ibm.com>
 <20180520112843.57079857@grimm.local.home>
 <20180520191846.GA248075@joelaf.mtv.corp.google.com>
 <20180521215951.2d6abfcb@gandalf.local.home>
 <20180522045414.GG40541@joelaf.mtv.corp.google.com>
 <20180522083832.45353d5f@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180522083832.45353d5f@gandalf.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18052216-0024-0000-0000-000018758532
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009066; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000261; SDB=6.01036075; UDB=6.00529993; IPR=6.00815204;
 MB=3.00021242; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-22 16:08:16
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052216-0025-0000-0000-00005019F294
Message-Id: <20180522160949.GU3803@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-22_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805220178
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 08:38:32AM -0400, Steven Rostedt wrote:
> On Mon, 21 May 2018 21:54:14 -0700
> Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> 
> > Yes, lets brain storm this if you like. One way I was thinking if we can
> > manually check every CPU and see what state its in (usermode, kernel, idle
> > etc) using an IPI mechanism. Once all CPUs have been seen to be in usermode,
> > or idle atleast once - then we are done. You have probably already thought
> 
> Nope, it has nothing to do with CPUs, it really has to do with tasks.
> 
> 	CPU0
> 	----
>  task 1: (pinned to CPU 0)
> 	 call func_tracer_trampoline
> 	 [on trampoline]
> 	 [timer tick, schedule ]
> 
>  task 2: (higher priority, also pinned to CPU 0)
> 	 goes to user space
> 	 [ Runs for along time ]
> 
> We cannot free the trampoline until task 2 releases the CPU and lets
> task 1 run again to get off the CPU.

What Steven said!  IPIs get to CPUs, but we need to handle the
(unlikely, but very real) case where a bunch of tasks are preempted
within trampolines.

> > about this so feel free to say why its not a good idea, but to me there are 3
> > places that a tasks quiescent state is recorded: during the timer tick,
> > during task sleep and during rcu_note_voluntary_context_switch in
> > cond_resched_rcu_qs. Of these, I feel only the cond_resched_rcu_qs case isn't
> > trackable with IPI mechanism which may make the detection a bit slower, but
> > tasks-RCU in mainline is slow right now anyway (~ 1 second delay if any task
> > was held).
> 
> The way I was originally going to handle this was with a per task
> counter, where it can be incremented at certain points via tracepoints.
> 
> Thus my synchronize tasks, would have connected to a bunch of
> tracepoints at known quiescent states that would increment the counter,
> and then check each task until they all pass a certain point, or are in
> a quiescent state (userspace or idle). But this would be doing much of
> what RCU does today, and that is why we decided to hook with the RCU
> infrastructure.

Just for the record, if you guys realy want to take over Tasks RCU,
I have no objections.  For one thing, I don't anticipate any other use
cases for it (famous last words!).  But you break it, you buy it!  ;-)

							Thanx, Paul

> I have to ask, what's your motivation for getting rid of RCU tasks?
> 
> -- Steve
> 
