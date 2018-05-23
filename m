Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754636AbeEWQHb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 12:07:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57656 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751570AbeEWQHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 12:07:30 -0400
Date: Wed, 23 May 2018 08:57:34 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Joel Fernandes <joelaf@google.com>
Cc: linux-kernel@vger.kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zilstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, byungchul.park@lge.com,
        kernel-team@android.com, Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 1/4] rcu: Speed up calling of RCU tasks callbacks
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180523063815.198302-1-joel@joelfernandes.org>
 <20180523063815.198302-2-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523063815.198302-2-joel@joelfernandes.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18052316-0012-0000-0000-0000164BF3E2
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009072; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000261; SDB=6.01036555; UDB=6.00530280; IPR=6.00815682;
 MB=3.00021259; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-23 16:07:18
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052316-0013-0000-0000-000052E859BC
Message-Id: <20180523155734.GK3803@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-23_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805230159
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 11:38:12PM -0700, Joel Fernandes wrote:
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> 
> RCU tasks callbacks can take at least 1 second before the callbacks are
> executed. This happens even if the hold-out tasks enter their quiescent states
> quickly. I noticed this when I was testing trampoline callback execution.
> 
> To test the trampoline freeing, I wrote a simple script:
> cd /sys/kernel/debug/tracing/
> echo '__schedule_bug:traceon' > set_ftrace_filter;
> echo '!__schedule_bug:traceon' > set_ftrace_filter;
> 
> In the background I had simple bash while loop:
> while [ 1 ]; do x=1; done &
> 
> Total time of completion of above commands in seconds:
> 
> With this patch:
> real    0m0.179s
> user    0m0.000s
> sys     0m0.054s
> 
> Without this patch:
> real    0m1.098s
> user    0m0.000s
> sys     0m0.053s
> 
> That's a greater than 6X speed up in performance. In order to accomplish
> this, I am waiting for HZ/10 time before entering the hold-out checking
> loop. The loop still preserves its checking of held tasks every 1 second
> as before, in case this first test doesn't succeed.
> 
> Cc: Steven Rostedt <rostedt@goodmis.org>

Given an ack from Steven, I would be happy to take this, give or take
some nits below.

							Thanx, Paul

> Cc: Peter Zilstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>
> Cc: byungchul.park@lge.com
> Cc: kernel-team@android.com
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/update.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> index 5783bdf86e5a..a28698e44b08 100644
> --- a/kernel/rcu/update.c
> +++ b/kernel/rcu/update.c
> @@ -743,6 +743,12 @@ static int __noreturn rcu_tasks_kthread(void *arg)
>  		 */
>  		synchronize_srcu(&tasks_rcu_exit_srcu);
> 
> +		/*
> +		 * Wait a little bit incase held tasks are released

				in case

> +		 * during their next timer ticks.
> +		 */
> +		schedule_timeout_interruptible(HZ/10);
> +
>  		/*
>  		 * Each pass through the following loop scans the list
>  		 * of holdout tasks, removing any that are no longer
> @@ -755,7 +761,6 @@ static int __noreturn rcu_tasks_kthread(void *arg)
>  			int rtst;
>  			struct task_struct *t1;
> 
> -			schedule_timeout_interruptible(HZ);
>  			rtst = READ_ONCE(rcu_task_stall_timeout);
>  			needreport = rtst > 0 &&
>  				     time_after(jiffies, lastreport + rtst);
> @@ -768,6 +773,11 @@ static int __noreturn rcu_tasks_kthread(void *arg)
>  				check_holdout_task(t, needreport, &firstreport);
>  				cond_resched();
>  			}
> +
> +			if (list_empty(&rcu_tasks_holdouts))
> +				break;
> +
> +			schedule_timeout_interruptible(HZ);

Is there a better way to do this?  Can this be converted into a for-loop?
Alternatively, would it make sense to have a firsttime local variable
initialized to true, to keep the schedule_timeout_interruptible() at
the beginning of the loop, but skip it on the first pass through the loop?

Don't get me wrong, what you have looks functionally correct, but
duplicating the condition might cause problems later on, for example,
should a bug fix be needed in the condition.

>  		}
> 
>  		/*
> -- 
> 2.17.0.441.gb46fe60e1d-goog
> 
