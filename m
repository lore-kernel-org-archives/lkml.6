Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB3FC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98E49244B5
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MgcYwH24"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98E49244B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933946AbeFVPXM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 11:23:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49934 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933468AbeFVPXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 11:23:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rSKWl8pzy17oZoKsWKd5vrHlccasK+0ZOZrrtTIVKRU=; b=MgcYwH24FnjlA667jtUE8tqGu
        BV06a8GwOLykaBfCBWnMBfBwmfBcYIol20qnk7KgBcx4aXx2RqqX2pDWzpqmCZhpf30dbdxLXcdVz
        vsaFTnTJN2qP7c3PzWuH0xsvyqfX5bKNANrYbb+6oJxDZAu+K5pHOKpVzyScG0eoQB34lNwboTJkf
        hZX9ocW2IhwzGgqBDkvtA29q5FazWpVcMIuYCVRWavYZtjozucVZfuBk7P4wm9mybkulII5buV/MW
        Uy0W8sF3bp6FQHalSxUydZNjYUg/RB8DOo+8AzM9VCtjjOITSUl330LiKeLrPKx9fQyvAuSiR03hn
        o6uc7j3FA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fWNts-0006yA-7h; Fri, 22 Jun 2018 15:23:00 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 61CBA2029F1D7; Fri, 22 Jun 2018 17:22:58 +0200 (CEST)
Date:   Fri, 22 Jun 2018 17:22:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, viresh.kumar@linaro.org,
        valentin.schneider@arm.com, patrick.bellasi@arm.com,
        joel@joelfernandes.org, daniel.lezcano@linaro.org,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v6 04/11] cpufreq/schedutil: use rt utilization tracking
Message-ID: <20180622152258.GF2512@hirez.programming.kicks-ass.net>
References: <1528459794-13066-1-git-send-email-vincent.guittot@linaro.org>
 <1528459794-13066-5-git-send-email-vincent.guittot@linaro.org>
 <20180621184524.GB27616@hirez.programming.kicks-ass.net>
 <20180622075853.GC23168@e108498-lin.cambridge.arm.com>
 <20180622113713.GJ2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622113713.GJ2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 01:37:13PM +0200, Peter Zijlstra wrote:
> That is true.. So we could limit the scaling to the case where there is
> no idle time, something like:
> 
> 	util = sg_cpu->util_cfs;
> 
> 	cap_cfs = (1024 - (sg_cpu->util_rt + ...));
> 	if (util == cap_cfs)
> 		util = sg_cpu->max;
> 

OK, it appears this is more or less what the patches do. And I think
there's a small risk/hole with this where util ~= cap_cfs but very close
due to some unaccounted time.

FWIW, when looking, I saw no reason why sugov_get_util() and
sugov_aggregate_util() were in fact separate functions.

--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -53,11 +53,7 @@ struct sugov_cpu {
 	unsigned int		iowait_boost_max;
 	u64			last_update;
 
-	/* The fields below are only needed when sharing a policy: */
-	unsigned long		util_cfs;
 	unsigned long		util_dl;
-	unsigned long		bw_dl;
-	unsigned long		util_rt;
 	unsigned long		max;
 
 	/* The field below is for single-CPU policies only: */
@@ -181,44 +177,38 @@ static unsigned int get_next_freq(struct
 	return cpufreq_driver_resolve_freq(policy, freq);
 }
 
-static void sugov_get_util(struct sugov_cpu *sg_cpu)
+static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
 {
 	struct rq *rq = cpu_rq(sg_cpu->cpu);
+	unsigned long util, max;
 
-	sg_cpu->max = arch_scale_cpu_capacity(NULL, sg_cpu->cpu);
-	sg_cpu->util_cfs = cpu_util_cfs(rq);
-	sg_cpu->util_dl  = cpu_util_dl(rq);
-	sg_cpu->bw_dl    = cpu_bw_dl(rq);
-	sg_cpu->util_rt  = cpu_util_rt(rq);
-}
-
-static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
-{
-	struct rq *rq = cpu_rq(sg_cpu->cpu);
-	unsigned long util;
+	sg_cpu->max = max = arch_scale_cpu_capacity(NULL, sg_cpu->cpu);
+	sg_cpu->util_dl   = cpu_util_dl(rq);
 
 	if (rq->rt.rt_nr_running)
-		return sg_cpu->max;
+		return max;
 
-	util = sg_cpu->util_cfs;
-	util += sg_cpu->util_rt;
+	util  = cpu_util_cfs(rq);
+	util += cpu_util_rt(rq);
 
-	if ((util + sg_cpu->util_dl) >= sg_cpu->max)
-		return sg_cpu->max;
+	/*
+	 * If there is no idle time, we should run at max frequency.
+	 */
+	if ((util + cpu_util_dl(rq)) >= max)
+		return max;
 
 	/*
-	 * As there is still idle time on the CPU, we need to compute the
-	 * utilization level of the CPU.
 	 * Bandwidth required by DEADLINE must always be granted while, for
 	 * FAIR and RT, we use blocked utilization of IDLE CPUs as a mechanism
 	 * to gracefully reduce the frequency when no tasks show up for longer
 	 * periods of time.
+	 *
+	 * Ideally we would like to set bw_dl as min/guaranteed freq and bw_dl
+	 * + util as requested freq. However, cpufreq is not yet ready for such
+	 * an interface. So, we only do the latter for now.
 	 */
 
-	/* Add DL bandwidth requirement */
-	util += sg_cpu->bw_dl;
-
-	return min(sg_cpu->max, util);
+	return min(max, cpu_bw_dl(rq) + util);
 }
 
 /**
@@ -396,9 +386,8 @@ static void sugov_update_single(struct u
 
 	busy = sugov_cpu_is_busy(sg_cpu);
 
-	sugov_get_util(sg_cpu);
+	util = sugov_get_util(sg_cpu);
 	max = sg_cpu->max;
-	util = sugov_aggregate_util(sg_cpu);
 	sugov_iowait_apply(sg_cpu, time, &util, &max);
 	next_f = get_next_freq(sg_policy, util, max);
 	/*
@@ -437,9 +426,8 @@ static unsigned int sugov_next_freq_shar
 		struct sugov_cpu *j_sg_cpu = &per_cpu(sugov_cpu, j);
 		unsigned long j_util, j_max;
 
-		sugov_get_util(j_sg_cpu);
+		j_util = sugov_get_util(j_sg_cpu);
 		j_max = j_sg_cpu->max;
-		j_util = sugov_aggregate_util(j_sg_cpu);
 		sugov_iowait_apply(j_sg_cpu, time, &j_util, &j_max);
 
 		if (j_util * max > j_max * util) {

