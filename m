Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939330AbeE1Otr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 10:49:47 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48514 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932390AbeE1Otm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 10:49:42 -0400
Date: Mon, 28 May 2018 16:49:24 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Paul Burton <paul.burton@mips.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/2] sched: Make select_task_rq() require cpu_active()
 for user tasks
Message-ID: <20180528144924.GE12217@hirez.programming.kicks-ass.net>
References: <20180526154648.11635-1-paul.burton@mips.com>
 <20180526154648.11635-2-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180526154648.11635-2-paul.burton@mips.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 26, 2018 at 08:46:47AM -0700, Paul Burton wrote:

> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1565,7 +1565,8 @@ int select_task_rq(struct task_struct *p, int cpu, int sd_flags, int wake_flags)
>  	 *   not worry about this generic constraint ]
>  	 */
>  	if (unlikely(!cpumask_test_cpu(cpu, &p->cpus_allowed) ||
> -		     !cpu_online(cpu)))
> +		     !cpu_online(cpu) ||
> +		     (!cpu_active(cpu) && !(p->flags & PF_KTHREAD))))
>  		cpu = select_fallback_rq(task_cpu(p), p);

That is not quite right.. and I find that the wrong patch:

  955dbdf4ce87 ("sched: Allow migrating kthreads into online but inactive CPUs")

got merged over my suggested alternative :-(

  http://lkml.kernel.org/r/20170725165821.cejhb7v2s3kecems@hirez.programming.kicks-ass.net

So, lets first fix that, and then your patch becomes something like the
below I think.


--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1562,7 +1562,7 @@ int select_task_rq(struct task_struct *p
 	 *   not worry about this generic constraint ]
 	 */
 	if (unlikely(!cpumask_test_cpu(cpu, &p->cpus_allowed) ||
-		     !cpu_online(cpu)))
+		     (is_per_cpu_kthread(p) ? !cpu_online(cpu) : !cpu_active(cpu)))
 		cpu = select_fallback_rq(task_cpu(p), p);
 
 	return cpu;
