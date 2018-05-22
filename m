Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751687AbeEVRGC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 13:06:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37672 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751277AbeEVRF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 13:05:57 -0400
Date: Tue, 22 May 2018 10:05:52 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>
Subject: Re: cpu stopper threads and load balancing leads to deadlock
Reply-To: paulmck@linux.vnet.ibm.com
References: <1525354359.5576.1.camel@gmx.de>
 <20180503135617.GC12217@hirez.programming.kicks-ass.net>
 <1525357015.5577.2.camel@gmx.de>
 <20180503144450.GD12217@hirez.programming.kicks-ass.net>
 <20180503161231.GI26088@linux.vnet.ibm.com>
 <20180503164508.GG12217@hirez.programming.kicks-ass.net>
 <1526358626.19125.0.camel@gmx.de>
 <20180517140345.GI3803@linux.vnet.ibm.com>
 <20180517142322.GU12217@hirez.programming.kicks-ass.net>
 <20180517145614.GK3803@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517145614.GK3803@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18052217-0004-0000-0000-000014229BE7
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009066; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000261; SDB=6.01036094; UDB=6.00530005; IPR=6.00815223;
 MB=3.00021242; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-22 17:05:55
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052217-0005-0000-0000-0000874F573B
Message-Id: <20180522170552.GA26530@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-22_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805220186
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 07:56:14AM -0700, Paul E. McKenney wrote:
> On Thu, May 17, 2018 at 04:23:22PM +0200, Peter Zijlstra wrote:
> > On Thu, May 17, 2018 at 07:03:45AM -0700, Paul E. McKenney wrote:
> > > On Tue, May 15, 2018 at 06:30:26AM +0200, Mike Galbraith wrote:
> > > I have not queued it, but given Peter's Signed-off-by and your Tested-by
> > > I would be happy to do so.
> > 
> > And a Changelog of course :-)
> 
> Thank you both!
> 
> Is this OK for 4.19, or do we need it for 4.18?  I am guessing 4.18,
> but figured I should ask before wildly rebasing the 82 commits destined
> for 4.19.  ;-)

Hearing nothing countering my assumption, I have queued this just after
my v4.18 merge point.  Please see below for the commit, and please let
me know if I messed anything up.

							Thanx, Paul

------------------------------------------------------------------------

commit 354238a30982b817262fe6f9d00f808451694366
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Tue May 22 09:50:53 2018 -0700

    rcu/x86: Provide early rcu_cpu_starting() callback
    
    The x86/mtrr code does horrific things because hardware. It uses
    stop_machine_from_inactive_cpu(), which does a wakeup (of the stopper
    thread on another CPU), which uses RCU, all before the CPU is onlined.
    
    RCU complains about this, because wakeups use RCU and RCU does
    (rightfully) not consider offline CPUs for grace-periods.
    
    Fix this by initializing RCU way early in the MTRR case.
    
    Tested-by: Mike Galbraith <efault@gmx.de>
    Signed-off-by: Peter Zijlstra <peterz@infradead.org>
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

diff --git a/arch/x86/kernel/cpu/mtrr/main.c b/arch/x86/kernel/cpu/mtrr/main.c
index 7468de429087..07360523c3ce 100644
--- a/arch/x86/kernel/cpu/mtrr/main.c
+++ b/arch/x86/kernel/cpu/mtrr/main.c
@@ -793,6 +793,9 @@ void mtrr_ap_init(void)
 
 	if (!use_intel() || mtrr_aps_delayed_init)
 		return;
+
+	rcu_cpu_starting(smp_processor_id());
+
 	/*
 	 * Ideally we should hold mtrr_mutex here to avoid mtrr entries
 	 * changed, but this routine will be called in cpu boot time,
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 4fccdfa25716..aa7cade1b9f3 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3665,6 +3665,8 @@ int rcutree_dead_cpu(unsigned int cpu)
 	return 0;
 }
 
+static DEFINE_PER_CPU(int, rcu_cpu_started);
+
 /*
  * Mark the specified CPU as being online so that subsequent grace periods
  * (both expedited and normal) will wait on it.  Note that this means that
@@ -3686,6 +3688,11 @@ void rcu_cpu_starting(unsigned int cpu)
 	struct rcu_node *rnp;
 	struct rcu_state *rsp;
 
+	if (per_cpu(rcu_cpu_started, cpu))
+		return;
+
+	per_cpu(rcu_cpu_started, cpu) = 1;
+
 	for_each_rcu_flavor(rsp) {
 		rdp = per_cpu_ptr(rsp->rda, cpu);
 		rnp = rdp->mynode;
@@ -3742,6 +3749,8 @@ void rcu_report_dead(unsigned int cpu)
 	preempt_enable();
 	for_each_rcu_flavor(rsp)
 		rcu_cleanup_dying_idle_cpu(cpu, rsp);
+
+	per_cpu(rcu_cpu_started, cpu) = 0;
 }
 
 /* Migrate the dead CPU's callbacks to the current CPU. */
