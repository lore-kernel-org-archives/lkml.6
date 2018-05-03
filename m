Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751287AbeECQLR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 12:11:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60196 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751095AbeECQLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 12:11:15 -0400
Date: Thu, 3 May 2018 09:12:31 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>
Subject: Re: cpu stopper threads and load balancing leads to deadlock
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180420095005.GH4064@hirez.programming.kicks-ass.net>
 <20180424133325.GA3179@codeblueprint.co.uk>
 <1525349542.9956.2.camel@gmx.de>
 <20180503122808.GZ12217@hirez.programming.kicks-ass.net>
 <1525351221.9956.4.camel@gmx.de>
 <20180503124943.GB12217@hirez.programming.kicks-ass.net>
 <1525354359.5576.1.camel@gmx.de>
 <20180503135617.GC12217@hirez.programming.kicks-ass.net>
 <1525357015.5577.2.camel@gmx.de>
 <20180503144450.GD12217@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180503144450.GD12217@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18050316-0052-0000-0000-000002E85098
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008962; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000258; SDB=6.01026958; UDB=6.00524543; IPR=6.00806091;
 MB=3.00020908; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-03 16:11:12
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050316-0053-0000-0000-00005C8D5EFC
Message-Id: <20180503161231.GI26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-03_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805030141
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2018 at 04:44:50PM +0200, Peter Zijlstra wrote:
> On Thu, May 03, 2018 at 04:16:55PM +0200, Mike Galbraith wrote:
> > On Thu, 2018-05-03 at 15:56 +0200, Peter Zijlstra wrote:
> > > On Thu, May 03, 2018 at 03:32:39PM +0200, Mike Galbraith wrote:
> > > 
> > > > Dang.  With $subject fix applied as well..
> > > 
> > > That's a NO then... :-(
> > 
> > Could say who cares about oddball offline wakeup stat. <cringe>
> 
> Yeah, nobody.. but I don't want to have to change the wakeup code to
> deal with this if at all possible. That'd just add conditions that are
> 'always' false, except in this exceedingly rare circumstance.
> 
> So ideally we manage to tell RCU that it needs to pay attention while
> we're doing this here thing, which is what I thought RCU_NONIDLE() was
> about.

One straightforward approach would be to provide a arch-specific
Kconfig option that tells notify_cpu_starting() not to bother invoking
rcu_cpu_starting().  Then x86 selects this Kconfig option and invokes
rcu_cpu_starting() itself early enough to avoid splats.

See the (untested, probably does not even build) patch below.

I have no idea where to insert either the "select" or the call to
rcu_cpu_starting(), so I left those out.  I know that putting the
call too early will cause trouble, but I have no idea what constitutes
"too early".  :-/

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 0db8938fbb23..58f7ea1de247 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -948,7 +948,8 @@ void notify_cpu_starting(unsigned int cpu)
 	enum cpuhp_state target = min((int)st->target, CPUHP_AP_ONLINE);
 	int ret;
 
-	rcu_cpu_starting(cpu);	/* Enables RCU usage on this CPU. */
+	if (!IS_ENABLED(CONFIG_RCU_CPU_ONLINE_EARLY))
+		rcu_cpu_starting(cpu);	/* Enables RCU usage on this CPU. */
 	while (st->state < target) {
 		st->state++;
 		ret = cpuhp_invoke_callback(cpu, st->state, true, NULL, NULL);
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 9210379c0353..a874c0d74797 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -238,4 +238,7 @@ config RCU_NOCB_CPU
 	  Say Y here if you want to help to debug reduced OS jitter.
 	  Say N here if you are unsure.
 
+config RCU_CPU_ONLINE_EARLY
+       bool
+
 endmenu # "RCU Subsystem"
