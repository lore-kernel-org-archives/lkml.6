Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753970AbeCYStl (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 14:49:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38286 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753834AbeCYStj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 14:49:39 -0400
Date: Sun, 25 Mar 2018 11:50:26 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Subject: Re: rcu: Add might_sleep() check to synchronize_rcu()
Reply-To: paulmck@linux.vnet.ibm.com
References: <alpine.DEB.2.21.1803232210110.1481@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1803232210110.1481@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18032518-0048-0000-0000-0000024F9A1C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008742; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000255; SDB=6.01008305; UDB=6.00513545; IPR=6.00787593;
 MB=3.00020235; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-25 18:49:38
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032518-0049-0000-0000-0000448D56E5
Message-Id: <20180325185026.GF3675@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-25_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803250229
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 10:12:24PM +0100, Thomas Gleixner wrote:
> Subject: rcu: Add might_sleep() check to synchronize_rcu()
> From: Thomas Gleixner <tglx@linutronix.de>
> Date: Fri, 23 Mar 2018 22:02:18 +0100
> 
> Joel reported a debugobjects warning which is triggered by a RCU callback
> invoking synchronize_rcu(). RCU callbacks run in softirq context, so
> calling synchronize_rcu() is a bad idea as it might sleep.
> 
> debugobjects triggers because __wait_rcu_gp() uses on stack objects and
> invokes debug_object_init_on_stack(). That function checks the object
> address against current's task stack, which fails because the code runs on
> the softirq stack.
> 
> synchronize_rcu() lacks a might_sleep() check which would have caught that
> issue way earlier because it would trigger with the minimal debug options
> enabled.
> 
> Add a might_sleep() check to catch such cases.
> 
> Reported-by: Joel Fernandes <joelaf@google.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> ---
>  kernel/rcu/tree_plugin.h |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -753,6 +753,7 @@ void synchronize_rcu(void)
>  			 "Illegal synchronize_rcu() in RCU read-side critical section");
>  	if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE)
>  		return;
> +	might_sleep();
>  	if (rcu_gp_is_expedited())
>  		synchronize_rcu_expedited();
>  	else

I could add this, but synchronize_rcu_expedited() will do
either a mutex_lock() or a wait_event(), both of which already
have a might_sleep(), and wait_rcu_gp() unconditionally calls
wait_for_completion(), which already has a might_sleep().

Unless there is only one CPU in the system either at early boot.  Is
this possibility common enough to warrant a might_sleep() further up?

							Thanx, Paul
