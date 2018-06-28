Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CF6C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FAE12762F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cC9zEnGD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FAE12762F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030229AbeF1Ppi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 11:45:38 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36875 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932316AbeF1Ppf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 11:45:35 -0400
Received: by mail-wr0-f195.google.com with SMTP id k6-v6so6010042wrp.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 08:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T44Fp1bkuBlEc/StRgz1812IqYNO9JGIyE7AOt7QI4c=;
        b=cC9zEnGDp61FSn/uuolUneADfnI8vlKJaUYl+Iwhpecy9RmDJsq41UKOT96A4Ac4M/
         iFpaa9bdxlp285udHk64AVALTqrnkN1dAg5LJo5ZkYNfbyZecLKjXhHIbwJZXIH973x4
         PKvgqwTm4jwDy5I5NWKSLp7qfzYW6AqK/AfqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=T44Fp1bkuBlEc/StRgz1812IqYNO9JGIyE7AOt7QI4c=;
        b=crj14VBdBYAfMCh568rjD5GdxIxgzVpxT35CkS8SBLnhN9ECU1RMk1s+BCH9UhVMCv
         EadyJ6U3MKJ4XddnLw+O5boPdB25C2QfhGv6wwibys/HTxZ0f4nj+gLKEfWjgqIWVzPG
         A2enCk56PWKcSMwdMVC0U9ae5DadzMAmgn+vEAsmbHabpe6CDmWSIPzvBk7Er2FklFRx
         TxzeMt6GzyUqdZF2rdhVSSs5LPxUfIP81j/CpLJD6t+dyR9mc45KxkYv6k9M4MHTkMN/
         c1sTEO+tnPOWzmzOa/38+ehr5bB36l6upY3LY8hd7YU8j8Nc2PyT1gZP/CjHVsgWznSe
         8SRQ==
X-Gm-Message-State: APt69E2fA84mYi9lk29XoCeW7Wbz8zbKBcyH/s9doKDUXQF3GvSJLkoq
        s8B2JVfuhoj814k6CYRjZBD4ew==
X-Google-Smtp-Source: AAOMgpeyfcR6a+CJmLpRy4UsKAyBqhMmRG6C6ROZ4PuTjOTcRY8CnBEkWRpATtSWjx5GbdG0JRmZPA==
X-Received: by 2002:adf:ff88:: with SMTP id j8-v6mr9547540wrr.137.1530200733686;
        Thu, 28 Jun 2018 08:45:33 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:21c3:ec41:bec9:c38])
        by smtp.gmail.com with ESMTPSA id i4-v6sm6202115wrq.28.2018.06.28.08.45.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Jun 2018 08:45:32 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, viresh.kumar@linaro.org,
        valentin.schneider@arm.com, patrick.bellasi@arm.com,
        joel@joelfernandes.org, daniel.lezcano@linaro.org,
        quentin.perret@arm.com, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH 08/11] sched: schedutil: remove sugov_aggregate_util()
Date:   Thu, 28 Jun 2018 17:45:11 +0200
Message-Id: <1530200714-4504-9-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530200714-4504-1-git-send-email-vincent.guittot@linaro.org>
References: <1530200714-4504-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no reason why sugov_get_util() and sugov_aggregate_util()
were in fact separate functions.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
[rebased after adding irq tracking and fixed some compilation errors]
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c | 44 ++++++++++++++--------------------------
 kernel/sched/sched.h             |  2 +-
 2 files changed, 16 insertions(+), 30 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index b77bfef..d04f941 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -53,12 +53,7 @@ struct sugov_cpu {
 	unsigned int		iowait_boost_max;
 	u64			last_update;
 
-	/* The fields below are only needed when sharing a policy: */
-	unsigned long		util_cfs;
-	unsigned long		util_dl;
 	unsigned long		bw_dl;
-	unsigned long		util_rt;
-	unsigned long		util_irq;
 	unsigned long		max;
 
 	/* The field below is for single-CPU policies only: */
@@ -182,38 +177,31 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 	return cpufreq_driver_resolve_freq(policy, freq);
 }
 
-static void sugov_get_util(struct sugov_cpu *sg_cpu)
+static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
 {
 	struct rq *rq = cpu_rq(sg_cpu->cpu);
+	unsigned long util, irq, max;
 
-	sg_cpu->max = arch_scale_cpu_capacity(NULL, sg_cpu->cpu);
-	sg_cpu->util_cfs = cpu_util_cfs(rq);
-	sg_cpu->util_dl  = cpu_util_dl(rq);
-	sg_cpu->bw_dl    = cpu_bw_dl(rq);
-	sg_cpu->util_rt  = cpu_util_rt(rq);
-	sg_cpu->util_irq = cpu_util_irq(rq);
-}
-
-static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
-{
-	struct rq *rq = cpu_rq(sg_cpu->cpu);
-	unsigned long util, max = sg_cpu->max;
+	sg_cpu->max = max = arch_scale_cpu_capacity(NULL, sg_cpu->cpu);
+	sg_cpu->bw_dl = cpu_bw_dl(rq);
 
 	if (rq->rt.rt_nr_running)
-		return sg_cpu->max;
+		return max;
+
+	irq = cpu_util_irq(rq);
 
-	if (unlikely(sg_cpu->util_irq >= max))
+	if (unlikely(irq >= max))
 		return max;
 
 	/* Sum rq utilization */
-	util = sg_cpu->util_cfs;
-	util += sg_cpu->util_rt;
+	util = cpu_util_cfs(rq);
+	util += cpu_util_rt(rq);
 
 	/*
 	 * Interrupt time is not seen by rqs utilization nso we can compare
 	 * them with the CPU capacity
 	 */
-	if ((util + sg_cpu->util_dl) >= max)
+	if ((util + cpu_util_dl(rq)) >= max)
 		return max;
 
 	/*
@@ -231,11 +219,11 @@ static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
 	 */
 
 	/* Weight rqs utilization to normal context window */
-	util *= (max - sg_cpu->util_irq);
+	util *= (max - irq);
 	util /= max;
 
 	/* Add interrupt utilization */
-	util += sg_cpu->util_irq;
+	util += irq;
 
 	/* Add DL bandwidth requirement */
 	util += sg_cpu->bw_dl;
@@ -418,9 +406,8 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 
 	busy = sugov_cpu_is_busy(sg_cpu);
 
-	sugov_get_util(sg_cpu);
+	util = sugov_get_util(sg_cpu);
 	max = sg_cpu->max;
-	util = sugov_aggregate_util(sg_cpu);
 	sugov_iowait_apply(sg_cpu, time, &util, &max);
 	next_f = get_next_freq(sg_policy, util, max);
 	/*
@@ -459,9 +446,8 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
 		struct sugov_cpu *j_sg_cpu = &per_cpu(sugov_cpu, j);
 		unsigned long j_util, j_max;
 
-		sugov_get_util(j_sg_cpu);
+		j_util = sugov_get_util(j_sg_cpu);
 		j_max = j_sg_cpu->max;
-		j_util = sugov_aggregate_util(j_sg_cpu);
 		sugov_iowait_apply(j_sg_cpu, time, &j_util, &j_max);
 
 		if (j_util * max > j_max * util) {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9438e68..59a633d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2219,7 +2219,7 @@ static inline unsigned long cpu_util_cfs(struct rq *rq)
 
 static inline unsigned long cpu_util_rt(struct rq *rq)
 {
-	return rq->avg_rt.util_avg;
+	return READ_ONCE(rq->avg_rt.util_avg);
 }
 
 #if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
-- 
2.7.4

