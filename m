Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F37C282CC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 905E4218AD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l7lqKzQx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730311AbfBFQEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 11:04:24 -0500
Received: from merlin.infradead.org ([205.233.59.134]:57498 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbfBFQEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 11:04:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Q/rWpbHpGMiTS5bo3uydh0aPuSbQhnsdlyCvvCnaUhQ=; b=l7lqKzQxQZn+FmUl8k4ISTCy2
        SSmG6I6rrC5RSdVIrVLm32lHjbQObzgTP3HanVCTAYL4Wz+d+wevV9s9UAQyhFIccvwEWrRT/CnIW
        G+acWA3W7Irq2V7H1TTZTrP76jNAvevX/bTk1vsTgkyITFAyiaD0K9kmMtHNqb7dNxnzmx9WeYsaj
        0axwqEDPxOI2ynpXHAz8Nnj7SH9shZV1GaldpwPTdWI7aJz2c6ZONgRhWsDxBtKvUTChHswoFf9AW
        mbTmKqgCG4oWukbOwEwOphj82ur2z570L9dLs1uXl3bX1wR9Psi6FMOWKFAHnpHK13HfNKMEyK8LS
        lF1HZE4gQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1grPgP-0003p9-JO; Wed, 06 Feb 2019 16:04:17 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B0F562029E06A; Wed,  6 Feb 2019 17:04:13 +0100 (CET)
Date:   Wed, 6 Feb 2019 17:04:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        vincent.guittot@linaro.org, morten.rasmussen@arm.com,
        Dietmar.Eggemann@arm.com
Subject: Re: [PATCH 4/5] sched/fair: Tune down misfit nohz kicks
Message-ID: <20190206160413.GK17550@hirez.programming.kicks-ass.net>
References: <20190117153411.2390-1-valentin.schneider@arm.com>
 <20190117153411.2390-5-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117153411.2390-5-valentin.schneider@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 03:34:10PM +0000, Valentin Schneider wrote:
> In
> 
>   commmit 3b1baa6496e6 ("sched/fair: Add 'group_misfit_task' load-balance type")
> 
> we set rq->misfit_task_load whenever the current running task has a
> utilization greater than 80% of rq->cpu_capacity. A non-zero value in
> this field enables misfit load balancing.
> 
> However, if the task being looked at is already running on a CPU of
> highest capacity, there's nothing more we can do for it. We can
> currently spot this in update_sd_pick_busiest(), which prevents us
> from selecting a sched_group of group_type == group_misfit_task as the
> busiest group, but we don't do any of that in nohz_balancer_kick().
> 
> This means that we could repeatedly kick nohz CPUs when there's no
> improvements in terms of load balance to be done.
> 
> Introduce a check_misfit_status() helper that returns true iff there
> is a CPU in the system that could give more CPU capacity to a rq's
> misfit task - IOW, there exists a CPU of higher capacity_orig or the
> rq's CPU is severely pressured by rt/IRQ.
> 
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>

> +static inline int check_misfit_status(struct rq *rq, struct sched_domain *sd)
> +{
> +	return rq->misfit_task_load &&
> +		(rq->cpu_capacity_orig < rq->rd->max_cpu_capacity ||
> +		 check_cpu_capacity(rq, sd));
> +}


> @@ -9527,7 +9539,7 @@ static void nohz_balancer_kick(struct rq *rq)
>  	if (time_before(now, nohz.next_balance))
>  		goto out;
>  
> -	if (rq->nr_running >= 2 || rq->misfit_task_load) {
> +	if (rq->nr_running >= 2) {
>  		flags = NOHZ_KICK_MASK;
>  		goto out;
>  	}
> @@ -9561,6 +9573,14 @@ static void nohz_balancer_kick(struct rq *rq)

	sd = rcu_dereference(rq->sd);
	if (sd) {
		if ((rq->cfs.h_nr_running >= 1) &&
		    check_cpu_capacity(rq, sd)) {
			flags = NOHZ_KICK_MASK;
			goto unlock;
>  		}
>  	}
>  
> +	sd = rcu_dereference(per_cpu(sd_asym_cpucapacity, cpu));
> +	if (sd) {
> +		if (check_misfit_status(rq, sd)) {
> +			flags = NOHZ_KICK_MASK;
> +			goto unlock;
> +		}
> +	}

So while the exact @sd to use for check_cpu_capacity() likely doesn't
matter; this is a 'implicit' test for actually having asym_capacity.

Fair enough I suppose. However, now that you wrote such a nice comment
for the sd_llc_shared case, these other two cases are sad to not have a
comment.

So how about you add something like:

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9589,8 +9589,12 @@ static void nohz_balancer_kick(struct rq
 
 	sd = rcu_dereference(rq->sd);
 	if (sd) {
-		if ((rq->cfs.h_nr_running >= 1) &&
-		    check_cpu_capacity(rq, sd)) {
+		/*
+		 * If there's a CFS task and the current CPU has reduced
+		 * capacity; kick the ILB to see if there's a better CPU to run
+		 * on.
+		 */
+		if (rq->cfs.h_nr_running >= 1 && check_cpu_capacity(rq, sd)) {
 			flags = NOHZ_KICK_MASK;
 			goto unlock;
 		}
@@ -9598,6 +9602,10 @@ static void nohz_balancer_kick(struct rq
 
 	sd = rcu_dereference(per_cpu(sd_asym_cpucapacity, cpu));
 	if (sd) {
+		/*
+		 * When ASYM_CAPACITY; see if there's a higher capacity CPU to
+		 * run the misfit task on.
+		 */
 		if (check_misfit_status(rq, sd)) {
 			flags = NOHZ_KICK_MASK;
 			goto unlock;
@@ -9606,6 +9614,10 @@ static void nohz_balancer_kick(struct rq
 
 	sd = rcu_dereference(per_cpu(sd_asym_packing, cpu));
 	if (sd) {
+		/*
+		 * When ASYM_PACKING; see if there's a more preferred CPU going
+		 * idle; in which case, kick the ILB to move tasks around.
+		 */
 		for_each_cpu_and(i, sched_domain_span(sd), nohz.idle_cpus_mask) {
 			if (sched_asym_prefer(i, cpu)) {
 				flags = NOHZ_KICK_MASK;
