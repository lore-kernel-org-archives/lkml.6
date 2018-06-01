Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751015AbeFAGM6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 02:12:58 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42980 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750760AbeFAGM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 02:12:56 -0400
X-Google-Smtp-Source: ADUXVKLW4NqyKHoVzYqi48t8gTGWkm0gooNDPSJ1Dyr6d25n5l3drHeJCi/XrsyNj++LQ8Vs422B6w==
Date: Thu, 31 May 2018 23:12:55 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: byungchul park <byungchul.park@lge.com>
Cc: peterz@infradead.org, mingo@kernel.org, rostedt@goodmis.org,
        tglx@linutronix.de, raistlin@linux.it, linux-kernel@vger.kernel.org,
        juri.lelli@gmail.com, bristot@redhat.com, kernel-team@lge.com
Subject: Re: [RESEND, v3, 2/2] sched/deadline: Initialize cp->elements[].cpu
 to an invalid value
Message-ID: <20180601061255.GA189147@joelaf.mtv.corp.google.com>
References: <1515392081-32320-2-git-send-email-byungchul.park@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1515392081-32320-2-git-send-email-byungchul.park@lge.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2018 at 03:14:41PM +0900, byungchul park wrote:
> Currently, migrating tasks to cpu0 unconditionally happens when the
> heap is empty, since cp->elements[].cpu was initialized to 0(=cpu0).
> We have to distinguish between the empty case and cpu0 to avoid the
> unnecessary migrations. Therefore, it has to return an invalid value
> e.i. -1 in that case.
> 
> Signed-off-by: Byungchul Park <byungchul.park@lge.com>
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Acked-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> ---
>  kernel/sched/cpudeadline.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/cpudeadline.c b/kernel/sched/cpudeadline.c
> index 9f02035..bcf903f 100644
> --- a/kernel/sched/cpudeadline.c
> +++ b/kernel/sched/cpudeadline.c
> @@ -138,6 +138,12 @@ int cpudl_find(struct cpudl *cp, struct task_struct *p,
>  		int best_cpu = cpudl_maximum_cpu(cp);
>  		WARN_ON(best_cpu != -1 && !cpu_present(best_cpu));
>  
> +		/*
> +		 * The heap tree is empty for now, just return.
> +		 */
> +		if (best_cpu == -1)
> +			return 0;
> +
>  		if (cpumask_test_cpu(best_cpu, &p->cpus_allowed) &&
>  		    dl_time_before(dl_se->deadline, cpudl_maximum_dl(cp))) {
>  			if (later_mask)
> @@ -265,8 +271,10 @@ int cpudl_init(struct cpudl *cp)
>  		return -ENOMEM;
>  	}
>  
> -	for_each_possible_cpu(i)
> +	for_each_possible_cpu(i) {
> +		cp->elements[i].cpu = -1;
>  		cp->elements[i].idx = IDX_INVALID;

Shouldn't you also set cp->elements[cpu].cpu to -1 in cpudl_clear (when you
set cp->elements[cpu].cpu to IDX_INVALID there)?

thanks,

- Joel
