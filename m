Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755095AbeDWNLX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 09:11:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41944 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754874AbeDWNLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 09:11:21 -0400
Date: Mon, 23 Apr 2018 06:12:28 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, rostedt@goodmis.org, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
        joel.opensrc@gmail.com
Subject: Re: [PATCH tip/core/rcu 06/22] rcu: Rename cond_resched_rcu_qs() to
 cond_resched_tasks_rcu_qs()
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180423023150.GA21533@linux.vnet.ibm.com>
 <1524450747-22778-6-git-send-email-paulmck@linux.vnet.ibm.com>
 <20180423085347.GS4064@hirez.programming.kicks-ass.net>
 <20180423123223.GK26088@linux.vnet.ibm.com>
 <20180423124855.GZ4064@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423124855.GZ4064@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18042313-0024-0000-0000-0000034CF5DB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008905; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01022101; UDB=6.00521662; IPR=6.00801336;
 MB=3.00020725; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-23 13:11:18
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042313-0025-0000-0000-000047C41944
Message-Id: <20180423131227.GM26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804230137
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 02:48:55PM +0200, Peter Zijlstra wrote:
> On Mon, Apr 23, 2018 at 05:32:23AM -0700, Paul E. McKenney wrote:
> > On Mon, Apr 23, 2018 at 10:53:47AM +0200, Peter Zijlstra wrote:
> > > On Sun, Apr 22, 2018 at 07:32:11PM -0700, Paul E. McKenney wrote:
> > > > Commit e31d28b6ab8f ("trace: Eliminate cond_resched_rcu_qs() in favor
> > > > of cond_resched()") substituted cond_resched() for the earlier call
> > > > to cond_resched_rcu_qs().  However, the new-age cond_resched() does
> > > > not do anything to help RCU-tasks grace periods because (1) RCU-tasks
> > > > is only enabled when CONFIG_PREEMPT=y and (2) cond_resched() is a
> > > > complete no-op when preemption is enabled.  This situation results
> > > > in hangs when running the trace benchmarks.
> > > 
> > > But a few patches earlier you tried to address that..
> > 
> > Yes.  And all this patch does is change the name to better match
> > what this primitive actually does.
> > 
> > I could merge the two patches, if that would help.
> 
> I understood the earlier patch was actually changing cond_resched() to
> also work for task-rcu; which resulted in it acually not being a no-op
> for PREEMPT anymore.
> 
> But then here you say it doesn't because it's a no-op.
> 
> It's not about the rename.. It is about one patch changing PREEMPT
> cond_resched to not be a no-op and you here justifying things because
> PREEMPT cond_resched it a no-op.

So would it help if I instead said in the commit log that it is a
no-op in production builds of the Linux kernel?

							Thanx, Paul
