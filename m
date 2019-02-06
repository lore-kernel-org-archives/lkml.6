Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580CDC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1394720821
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 16:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LZrkH0bs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730919AbfBFQO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 11:14:58 -0500
Received: from merlin.infradead.org ([205.233.59.134]:57538 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729517AbfBFQO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 11:14:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SMStrzzHtoFU3Wbccp1F0gNLe7SzcN7GBRltmOx94No=; b=LZrkH0bs0PU/KXyRc9nBv2R8I
        YcTj/bdGjFBViqbNYef2s5UvmAiLTNHtVF/EWNwi2aqmqKHR2ecYrhGD5gZIRoOY2nAzBBaMlgMV9
        mjvb6eN0WO4RnVYFoKv5gLKuXIXH8ZvydI4t0IBYKtxcGy9ZJNi8pjWTuu6JNrLsmJiBRsBug6+As
        oF7NhzzymOfiu5N7a+nUnLWqDDqWVPLve5hzbishyp+DNuZVj63CM7sEdXQkTz5bSEfDNg3ZSWkxF
        lH9yPXFJIH/bZJt27Tq/TdENxQIzRqiSpgKNvAX94VDDfldGhI6CqE2Wt7wn94rQbdGc2eKH5YS3G
        TdBDuwZgg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1grPqg-0003qx-7W; Wed, 06 Feb 2019 16:14:54 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EB55E2029E076; Wed,  6 Feb 2019 17:14:52 +0100 (CET)
Date:   Wed, 6 Feb 2019 17:14:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        vincent.guittot@linaro.org, morten.rasmussen@arm.com,
        Dietmar.Eggemann@arm.com
Subject: Re: [PATCH 5/5] sched/fair: Skip LLC nohz logic for asymmetric
 systems
Message-ID: <20190206161452.GL17550@hirez.programming.kicks-ass.net>
References: <20190117153411.2390-1-valentin.schneider@arm.com>
 <20190117153411.2390-6-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117153411.2390-6-valentin.schneider@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 03:34:11PM +0000, Valentin Schneider wrote:
> The LLC nohz condition will become true as soon as >=2 CPUs in a
> single LLC domain are busy. On big.LITTLE systems, this translates to
> two or more CPUs of a "cluster" (big or LITTLE) being busy.
> 
> Issuing a nohz kick in these conditions isn't desired for asymmetric
> systems, as if the busy CPUs can provide enough compute capacity to
> the running tasks, then we can leave the nohz CPUs in peace.
> 
> Skip the LLC nohz condition for asymmetric systems, and rely on
> nr_running & capacity checks to trigger nohz kicks when the system
> actually needs them.
> 
> Suggested-by: Morten Rasmussen <morten.rasmussen@arm.com>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  kernel/sched/fair.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 291dfdb0183f..ff27bf56e8d4 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9545,6 +9545,17 @@ static void nohz_balancer_kick(struct rq *rq)
>  	}
>  
>  	rcu_read_lock();
> +
> +	if (static_branch_unlikely(&sched_asym_cpucapacity))
> +		/*
> +		 * For asymmetric systems, we do not want to nicely balance
> +		 * cache use, instead we want to embrace asymmetry and only
> +		 * ensure tasks have enough CPU capacity.
> +		 *
> +		 * Skip the LLC logic because it's not relevant in that case.
> +		 */
> +		goto check_capacity;
> +
>  	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
>  	if (sds) {
>  		/*

Since (before this) the actual order of the various tests doesn't
matter, it's a logical cascade of conditions for which to KICK_MASK.

We can easily reorder and short-circuit the cascase like so, no?

The only concern is if sd_llc_shared < sd_asym_capacity; in which case
we just lost a balance opportunity. Not sure how to best retain that
though.

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9568,25 +9568,6 @@ static void nohz_balancer_kick(struct rq
 	}
 
 	rcu_read_lock();
-	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
-	if (sds) {
-		/*
-		 * If there is an imbalance between LLC domains (IOW we could
-		 * increase the overall cache use), we need some less-loaded LLC
-		 * domain to pull some load. Likewise, we may need to spread
-		 * load within the current LLC domain (e.g. packed SMT cores but
-		 * other CPUs are idle). We can't really know from here how busy
-		 * the others are - so just get a nohz balance going if it looks
-		 * like this LLC domain has tasks we could move.
-		 */
-		nr_busy = atomic_read(&sds->nr_busy_cpus);
-		if (nr_busy > 1) {
-			flags = NOHZ_KICK_MASK;
-			goto unlock;
-		}
-
-	}
-
 	sd = rcu_dereference(rq->sd);
 	if (sd) {
 		/*
@@ -9600,6 +9581,20 @@ static void nohz_balancer_kick(struct rq
 		}
 	}
 
+	sd = rcu_dereference(per_cpu(sd_asym_packing, cpu));
+	if (sd) {
+		/*
+		 * When ASYM_PACKING; see if there's a more preferred CPU going
+		 * idle; in which case, kick the ILB to move tasks around.
+		 */
+		for_each_cpu_and(i, sched_domain_span(sd), nohz.idle_cpus_mask) {
+			if (sched_asym_prefer(i, cpu)) {
+				flags = NOHZ_KICK_MASK;
+				goto unlock;
+			}
+		}
+	}
+
 	sd = rcu_dereference(per_cpu(sd_asym_cpucapacity, cpu));
 	if (sd) {
 		/*
@@ -9610,21 +9605,36 @@ static void nohz_balancer_kick(struct rq
 			flags = NOHZ_KICK_MASK;
 			goto unlock;
 		}
+
+		/*
+		 * For asymmetric systems, we do not want to nicely balance
+		 * cache use, instead we want to embrace asymmetry and only
+		 * ensure tasks have enough CPU capacity.
+		 *
+		 * Skip the LLC logic because it's not relevant in that case.
+		 */
+		goto unlock;
 	}
 
-	sd = rcu_dereference(per_cpu(sd_asym_packing, cpu));
-	if (sd) {
+	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
+	if (sds) {
 		/*
-		 * When ASYM_PACKING; see if there's a more preferred CPU going
-		 * idle; in which case, kick the ILB to move tasks around.
+		 * If there is an imbalance between LLC domains (IOW we could
+		 * increase the overall cache use), we need some less-loaded LLC
+		 * domain to pull some load. Likewise, we may need to spread
+		 * load within the current LLC domain (e.g. packed SMT cores but
+		 * other CPUs are idle). We can't really know from here how busy
+		 * the others are - so just get a nohz balance going if it looks
+		 * like this LLC domain has tasks we could move.
 		 */
-		for_each_cpu_and(i, sched_domain_span(sd), nohz.idle_cpus_mask) {
-			if (sched_asym_prefer(i, cpu)) {
-				flags = NOHZ_KICK_MASK;
-				goto unlock;
-			}
+		nr_busy = atomic_read(&sds->nr_busy_cpus);
+		if (nr_busy > 1) {
+			flags = NOHZ_KICK_MASK;
+			goto unlock;
 		}
+
 	}
+
 unlock:
 	rcu_read_unlock();
 out:
