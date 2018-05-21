Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751788AbeEUDA5 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 23:00:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38182 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750883AbeEUDA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 23:00:56 -0400
Date: Sun, 20 May 2018 20:02:25 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Joel Fernandes <joelaf@google.com>
Cc: linux-kernel@vger.kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zilstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, byungchul.park@lge.com,
        kernel-team@android.com, Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH v2] rcu: Speed up calling of RCU tasks callbacks
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180521004324.68371-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180521004324.68371-1-joel@joelfernandes.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18052103-0008-0000-0000-0000030A5835
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009058; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000261; SDB=6.01035332; UDB=6.00529548; IPR=6.00814461;
 MB=3.00021219; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-21 03:00:53
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052103-0009-0000-0000-00003951AA63
Message-Id: <20180521030225.GA3803@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-21_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805210034
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 20, 2018 at 05:43:24PM -0700, Joel Fernandes wrote:
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> 
> RCU tasks callbacks can take atleast 1 second before the callbacks are
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
> That's a great than 6X speed up in performance. In order to accomplish
> this, I am waiting for HZ/10 time before entering the hold-out checking
> loop. The loop still preserves its checking of held tasks every 1 second
> as before, incase this first test doesn't succeed.
> 
> Cc: Steven Rostedt <rostedt@goodmis.org>

Seems straightforward enough.  The commit log needs a bit of cleanup
("atleast", "great than", ...).

Steve, thoughts?  Any reason why this would be a problem?

							Thanx, Paul

> Cc: Peter Zilstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>
> Cc: byungchul.park@lge.com
> Cc: kernel-team@android.com
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
> Changes since v1->v2:
>  - Changed total wait time to HZ/10 instead of 2 jiffies
>  - Updated the commands to reproduce issue
> 
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
>  		}
> 
>  		/*
> -- 
> 2.17.0.441.gb46fe60e1d-goog
> 
