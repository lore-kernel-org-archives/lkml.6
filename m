Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753396AbeBLRb4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 12:31:56 -0500
Received: from merlin.infradead.org ([205.233.59.134]:49000 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752732AbeBLRbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 12:31:55 -0500
Date: Mon, 12 Feb 2018 18:31:47 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mel Gorman <mgorman@techsingularity.net>
Cc: Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] sched/fair: Do not migrate due to a sync wakeup on
 exit
Message-ID: <20180212173147.GZ25201@hirez.programming.kicks-ass.net>
References: <20180212145857.8056-1-mgorman@techsingularity.net>
 <20180212145857.8056-5-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180212145857.8056-5-mgorman@techsingularity.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 02:58:57PM +0000, Mel Gorman wrote:
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 28c8d9c91955..50442697b455 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5710,8 +5710,14 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
>  	if (idle_cpu(this_cpu) && cpus_share_cache(this_cpu, prev_cpu))
>  		return idle_cpu(prev_cpu) ? prev_cpu : this_cpu;
>  
> -	if (sync && cpu_rq(this_cpu)->nr_running == 1)
> +	if (sync && cpu_rq(this_cpu)->nr_running == 1) {
> +		/* Avoid tasks exiting pulling parents to new nodes */
> +		if ((current->flags & PF_EXITING) &&
> +		    !cpus_share_cache(this_cpu, prev_cpu))
> +			return prev_cpu;
> +

Cute, but should we not kill @sync right at the source in this case?

Something a little like this?

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5eb3ffc9be84..568ea4ce5b36 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6342,7 +6342,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
 	int cpu = smp_processor_id();
 	int new_cpu = prev_cpu;
 	int want_affine = 0;
-	int sync = wake_flags & WF_SYNC;
+	int sync = (wake_flags & WF_SYNC) && !(current->flags & PF_EXITING);
 
 	if (sd_flag & SD_BALANCE_WAKE) {
 		record_wakee(p);
