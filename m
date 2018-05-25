Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968140AbeEYUKI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 16:10:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55354 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S967879AbeEYUKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 16:10:07 -0400
Date: Fri, 25 May 2018 13:11:41 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zilstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, byungchul.park@lge.com,
        kernel-team@android.com, Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v4] rcu: Speed up calling of RCU tasks callbacks
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180524184946.5fa82d19@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524184946.5fa82d19@gandalf.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18052520-0040-0000-0000-00000432CE98
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009083; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000262; SDB=6.01037591; UDB=6.00530820; IPR=6.00816719;
 MB=3.00021297; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-25 20:10:05
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052520-0041-0000-0000-00000838EDC0
Message-Id: <20180525201141.GG3803@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-25_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805250208
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 06:49:46PM -0400, Steven Rostedt wrote:
> 
> From: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> Joel Fernandes found that the synchronize_rcu_tasks() was taking a
> significant amount of time. He demonstrated it with the following test:
> 
>  # cd /sys/kernel/tracing
>  # while [ 1 ]; do x=1; done &
>  # echo '__schedule_bug:traceon' > set_ftrace_filter
>  # time echo '!__schedule_bug:traceon' > set_ftrace_filter;
> 
> real	0m1.064s
> user	0m0.000s
> sys	0m0.004s
> 
> Where it takes a little over a second to perform the synchronize,
> because there's a loop that waits 1 second at a time for tasks to get
> through their quiescent points when there's a task that must be waited
> for.
> 
> After discussion we came up with a simple way to wait for holdouts but
> increase the time for each iteration of the loop but no more than a
> full second.
> 
> With the new patch we have:
> 
>  # time echo '!__schedule_bug:traceon' > set_ftrace_filter;
> 
> real	0m0.131s
> user	0m0.000s
> sys	0m0.004s
> 
> Which drops it down to 13% of what the original wait time was.
> 
> Link: http://lkml.kernel.org/r/20180523063815.198302-2-joel@joelfernandes.org
> Reported-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Suggested-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

I queued both commits, thank you all!

							Thanx, Paul

> ---
> diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> index 68fa19a5e7bd..452e47841a86 100644
> --- a/kernel/rcu/update.c
> +++ b/kernel/rcu/update.c
> @@ -715,6 +715,7 @@ static int __noreturn rcu_tasks_kthread(void *arg)
>  	struct rcu_head *list;
>  	struct rcu_head *next;
>  	LIST_HEAD(rcu_tasks_holdouts);
> +	int fract;
> 
>  	/* Run on housekeeping CPUs by default.  Sysadm can move if desired. */
>  	housekeeping_affine(current, HK_FLAG_RCU);
> @@ -796,13 +797,25 @@ static int __noreturn rcu_tasks_kthread(void *arg)
>  		 * holdouts.  When the list is empty, we are done.
>  		 */
>  		lastreport = jiffies;
> -		while (!list_empty(&rcu_tasks_holdouts)) {
> +
> +		/* Start off with HZ/10 wait and slowly back off to 1 HZ wait*/
> +		fract = 10;
> +
> +		for (;;) {
>  			bool firstreport;
>  			bool needreport;
>  			int rtst;
>  			struct task_struct *t1;
> 
> -			schedule_timeout_interruptible(HZ);
> +			if (list_empty(&rcu_tasks_holdouts))
> +				break;
> +
> +			/* Slowly back off waiting for holdouts */
> +			schedule_timeout_interruptible(HZ/fract);
> +
> +			if (fract > 1)
> +				fract--;
> +
>  			rtst = READ_ONCE(rcu_task_stall_timeout);
>  			needreport = rtst > 0 &&
>  				     time_after(jiffies, lastreport + rtst);
> 
