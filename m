Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965655AbeEXXTV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 19:19:21 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35258 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964852AbeEXXTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 19:19:20 -0400
X-Google-Smtp-Source: AB8JxZp3tgQ2ofBUwN1UV8DsLodk2VV+YdEKRJy5FlyKQlMVkt4CVVWSynq9EG+0iZtkVibfLfP9NA==
Date: Thu, 24 May 2018 16:19:18 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zilstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, byungchul.park@lge.com,
        kernel-team@android.com, Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v4] rcu: Speed up calling of RCU tasks callbacks
Message-ID: <20180524231918.GA98334@joelaf.mtv.corp.google.com>
References: <20180524184946.5fa82d19@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524184946.5fa82d19@gandalf.local.home>
User-Agent: Mutt/1.9.2 (2017-12-15)
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

Should be 90% of original?

> 
> Link: http://lkml.kernel.org/r/20180523063815.198302-2-joel@joelfernandes.org
> Reported-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Suggested-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
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

Other than minor change log change, looks good to me:

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel
