Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751500AbeBXUMp (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 15:12:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:42780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751417AbeBXUMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 15:12:44 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE547206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Sat, 24 Feb 2018 15:12:40 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH tip/core/rcu 06/10] trace: Eliminate
 cond_resched_rcu_qs() in favor of cond_resched()
Message-ID: <20180224151240.0d63a059@vmware.local.home>
In-Reply-To: <1512156104-20104-6-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20171201192122.GA19301@linux.vnet.ibm.com>
        <1512156104-20104-6-git-send-email-paulmck@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  1 Dec 2017 11:21:40 -0800
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> Now that cond_resched() also provides RCU quiescent states when
> needed, it can be used in place of cond_resched_rcu_qs().  This
> commit therefore makes this change.

Are you sure this is true?

I just bisected a lock up on my machine down to this commit.

With CONFIG_TRACEPOINT_BENCHMARK=y

# cd linux.git/tools/testing/selftests/ftrace/
# ./ftracetest test.d/ftrace/func_traceonoff_triggers.tc

Locks up with a backtrace of:

[  614.186509] INFO: rcu_tasks detected stalls on tasks:
[  614.192253] 000000005834f2a5: .. nvcsw: 2/2 holdout: 1 idle_cpu: -1/1
[  614.199385] event_benchmark R  running task    15264  1507      2 0x90000000
[  614.207159] Call Trace:
[  614.210335]  ? trace_hardirqs_on_thunk+0x1a/0x1c
[  614.215653]  ? retint_kernel+0x2d/0x2d
[  614.220101]  ? ring_buffer_set_clock+0x10/0x10
[  614.225232]  ? benchmark_event_kthread+0x35/0x2d0
[  614.230624]  ? kthread+0x129/0x140
[  614.234708]  ? trace_benchmark_reg+0x80/0x80
[  614.239646]  ? kthread_create_worker_on_cpu+0x50/0x50
[  614.245361]  ? ret_from_fork+0x3a/0x50

The comment in the benchmark code that this commit affects is:

		 *
		 * Note the _rcu_qs() version of cond_resched() will
		 * notify synchronize_rcu_tasks() that this thread has
		 * passed a quiescent state for rcu_tasks. Otherwise
		 * this thread will never voluntarily schedule which would
		 * block synchronize_rcu_tasks() indefinitely.
		 */
		cond_resched();

Seems to me that cond_resched() isn't the same as cond_resched_rcu_qs().

-- Steve


> 
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> ---
>  kernel/trace/trace_benchmark.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_benchmark.c b/kernel/trace/trace_benchmark.c
> index 79f838a75077..22fee766081b 100644
> --- a/kernel/trace/trace_benchmark.c
> +++ b/kernel/trace/trace_benchmark.c
> @@ -165,7 +165,7 @@ static int benchmark_event_kthread(void *arg)
>  		 * this thread will never voluntarily schedule which would
>  		 * block synchronize_rcu_tasks() indefinitely.
>  		 */
> -		cond_resched_rcu_qs();
> +		cond_resched();
>  	}
>  
>  	return 0;
> -
