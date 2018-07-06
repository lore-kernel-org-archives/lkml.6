Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827C3C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 11:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D1D823E8C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 11:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="po+nDtUB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D1D823E8C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753755AbeGFLjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 07:39:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45974 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753528AbeGFLjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 07:39:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MjGQ8YyvWrelJG2/VjhTeUqBX0ARheuOFT0tH7nbk1k=; b=po+nDtUBQWDx0pD45EcA3C8Up
        AjwkP5y47VNnWhaqEgeYjIOUtcBwPXLr3+CFz7DCxRmGIdiu7daEkjEwuUM5w+CNtcSrNoOjiz0kL
        0+u07QWGCglLosrbRokpvMj/+oM8hTrHaOS+JrcmQMYdERJY+tAJKc6ew+TT4TXYtQbrOTxlJyq1b
        QEo9Zl8awO9++vAkAiICWj9a9A/XlZYOau2xTyQ+R+X0zFE/Yv+9Rh2g5aG2aVo5wY4lhs1bR1210
        YpqRDrBvIoci99arRryDfbGf1bxvMdbG0A2uovrBXLY7ZSYHzF1cq1wqWq8B1e+HAr6xhulrKMa1h
        bR7/6JkGg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fbP59-0004Ad-GV; Fri, 06 Jul 2018 11:39:23 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BE79720298BAE; Fri,  6 Jul 2018 13:39:21 +0200 (CEST)
Date:   Fri, 6 Jul 2018 13:39:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        mingo@redhat.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, thara.gopinath@linaro.org,
        viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org,
        smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com,
        pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
Subject: Re: [RFC PATCH v4 08/12] sched: Add over-utilization/tipping point
 indicator
Message-ID: <20180706113921.GT2458@hirez.programming.kicks-ass.net>
References: <20180628114043.24724-1-quentin.perret@arm.com>
 <20180628114043.24724-9-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628114043.24724-9-quentin.perret@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 12:40:39PM +0100, Quentin Perret wrote:
>  static inline void update_sg_lb_stats(struct lb_env *env,
>  			struct sched_group *group, int load_idx,
>  			int local_group, struct sg_lb_stats *sgs,
> -			bool *overload)
> +			bool *overload, int *overutilized)

> @@ -8308,7 +8336,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>  		}
>  
>  		update_sg_lb_stats(env, sg, load_idx, local_group, sgs,
> -						&overload);
> +						&overload, &overutilized);
>  
>  		if (local_group)
>  			goto next_group;

I'm thinking maybe we should reduce arguments here a little.

@load_idx and @local_group look to be trivially computable..

and possibly we could frob overload and overutilized in a single
variable with some flags?


diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 321cd5dcf2e8..091859069620 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8114,10 +8114,12 @@ static bool update_nohz_stats(struct rq *rq, bool force)
  * @overload: Indicate more than one runnable task for any CPU.
  */
 static inline void update_sg_lb_stats(struct lb_env *env,
-			struct sched_group *group, int load_idx,
-			int local_group, struct sg_lb_stats *sgs,
+			struct sched_group *group,
+			struct sg_lb_stats *sgs,
 			bool *overload)
 {
+	int local_group = cpumask_test_cpu(env->dst_cpu, sched_group_span(sd));
+	int load_idx = get_sd_load_idx(env->sd, env->idle);
 	unsigned long load;
 	int i, nr_running;
 
@@ -8278,7 +8280,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 	struct sched_group *sg = env->sd->groups;
 	struct sg_lb_stats *local = &sds->local_stat;
 	struct sg_lb_stats tmp_sgs;
-	int load_idx, prefer_sibling = 0;
+	int prefer_sibling = 0;
 	bool overload = false;
 
 	if (child && child->flags & SD_PREFER_SIBLING)
@@ -8289,8 +8291,6 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 		env->flags |= LBF_NOHZ_STATS;
 #endif
 
-	load_idx = get_sd_load_idx(env->sd, env->idle);
-
 	do {
 		struct sg_lb_stats *sgs = &tmp_sgs;
 		int local_group;
@@ -8305,8 +8305,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 				update_group_capacity(env->sd, env->dst_cpu);
 		}
 
-		update_sg_lb_stats(env, sg, load_idx, local_group, sgs,
-						&overload);
+		update_sg_lb_stats(env, sg, sgs, &overload);
 
 		if (local_group)
 			goto next_group;
