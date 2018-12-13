Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2838C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 736AF20849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TTqY4a0t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 736AF20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbeLMNwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 08:52:14 -0500
Received: from merlin.infradead.org ([205.233.59.134]:48484 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729359AbeLMNwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 08:52:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Xhd2WcmUZgrVvNlO5+Nw2dYl2VibqnuQnPMDb/w3x84=; b=TTqY4a0tmpPr9K/mVtEElpmY/
        1cLypjrBKWZlAAlD/aosqJXL7wGpqHkkLK0c1LK40grXl0pU5A48aAX35YRBzAy0QR9H+S5fPU2PN
        omluIapeuwoNV4oStC5xKnenaHHN1v8wuWQysdjCFGnW1HhWVcaTdXsgUXJjbEDabhqghSxm5woMH
        jhgplazAZ6dhJHzDnRzecVlG5ECVZWq/M8leXwq7p5sKPB0NHNP4XzHWc8eC71dpHuKtuc6LmCSXz
        FfYL9Dp96EOycEowRP44iGWJsD+pK+aSyHZ5TyGvqP6FNcEPymlpC1rc6XtI/NqztnvZjgmSFKu87
        2D0M6+UKA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXRPN-0004TK-Ga; Thu, 13 Dec 2018 13:52:09 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 105D5207264F0; Thu, 13 Dec 2018 14:52:08 +0100 (CET)
Date:   Thu, 13 Dec 2018 14:52:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com, Morten.Rasmussen@arm.com
Subject: Re: [PATCH 3/3] sched/fair: fix unnecessary increase of balance
 interval
Message-ID: <20181213135208.GI5289@hirez.programming.kicks-ass.net>
References: <1533657387-29039-1-git-send-email-vincent.guittot@linaro.org>
 <1533657387-29039-4-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533657387-29039-4-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 05:56:27PM +0200, Vincent Guittot wrote:
> +static inline bool
> +asym_active_balance(enum cpu_idle_type idle, unsigned int flags, int dst, int src)
>  {
> +	if (idle != CPU_NOT_IDLE) {
>  
>  		/*
>  		 * ASYM_PACKING needs to force migrate tasks from busy but
>  		 * lower priority CPUs in order to pack all tasks in the
>  		 * highest priority CPUs.
>  		 */
> +		if ((flags & SD_ASYM_PACKING) &&
> +		    sched_asym_prefer(dst, src))
> +			return true;
>  	}
>  
> +	return false;
> +}
> +
> +static int need_active_balance(struct lb_env *env)
> +{
> +	struct sched_domain *sd = env->sd;
> +
> +
> +	if (asym_active_balance(env->idle, sd->flags, env->dst_cpu, env->src_cpu))
> +		return 1;
> +
>  	/*
>  	 * The dst_cpu is idle and the src_cpu CPU has only 1 CFS task.
>  	 * It's worth migrating the task if the src_cpu's capacity is reduced
> @@ -8650,7 +8660,8 @@ static int load_balance(int this_cpu, struct rq *this_rq,
>  	} else
>  		sd->nr_balance_failed = 0;
>  
> +	if (likely(!active_balance) ||
> +	    asym_active_balance(env.idle, sd->flags, env.dst_cpu, env.src_cpu)) {

Perhaps like the below?

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8857,21 +8857,24 @@ static struct rq *find_busiest_queue(str
  */
 #define MAX_PINNED_INTERVAL	512
 
+static inline bool
+asym_active_balance(struct lb_env *env)
+{
+	/*
+	 * ASYM_PACKING needs to force migrate tasks from busy but
+	 * lower priority CPUs in order to pack all tasks in the
+	 * highest priority CPUs.
+	 */
+	return env->idle != CPU_NOT_IDLE && (env->sd->flags & SD_ASYM_PACKING) &&
+		sched_asym_prefer(env->dst_cpu, env->src_cpu);
+}
+
 static int need_active_balance(struct lb_env *env)
 {
 	struct sched_domain *sd = env->sd;
 
-	if (env->idle != CPU_NOT_IDLE) {
-
-		/*
-		 * ASYM_PACKING needs to force migrate tasks from busy but
-		 * lower priority CPUs in order to pack all tasks in the
-		 * highest priority CPUs.
-		 */
-		if ((sd->flags & SD_ASYM_PACKING) &&
-		    sched_asym_prefer(env->dst_cpu, env->src_cpu))
-			return 1;
-	}
+	if (asym_active_balance(env))
+		return 1;
 
 	/*
 	 * The dst_cpu is idle and the src_cpu CPU has only 1 CFS task.
@@ -9150,7 +9153,7 @@ static int load_balance(int this_cpu, st
 	} else
 		sd->nr_balance_failed = 0;
 
-	if (likely(!active_balance)) {
+	if (likely(!active_balance) || asym_active_balance(&env)) {
 		/* We were unbalanced, so reset the balancing interval */
 		sd->balance_interval = sd->min_interval;
 	} else {
