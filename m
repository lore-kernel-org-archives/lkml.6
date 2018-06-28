Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9332C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AA8327635
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YAG7P0jM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AA8327635
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935514AbeF1Pqf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 11:46:35 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41778 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030200AbeF1Ppc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 11:45:32 -0400
Received: by mail-wr0-f194.google.com with SMTP id h10-v6so5995385wrq.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 08:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LJM9mfokBEkFWGXIXh91vliCCTSGjKg+K/zcNJNEiLM=;
        b=YAG7P0jMqLC0N+FEFJYFNzId+EuXU0Ba3HtU1Cqmz9rJ464yvAcOstX81PPfvj41YV
         /QHVNC5zm+ME+7McKZZizCWTyiBbRhvI3s3ODDyQIpLmuyH7lh60dyk/dD1ormCGZRTM
         3MP5SBvqEodIYQI89BeEiU8VWnApAp6O0MzI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LJM9mfokBEkFWGXIXh91vliCCTSGjKg+K/zcNJNEiLM=;
        b=BtcvuIoj/jmh6uQQrW37OUmLp58GCbl+4r5K+ZTFd7OnV8q1I1DzjXrizyegm6uGeo
         kIbwZvJKPWBMu2TmStYZC+qQy1eR6QcQc9GFl/TC9R/aaVK7ldBauJmDIyjssFPFKvMM
         kPPeJfvhyQvtgPcX1W33rknh43gqEdn6ntE/bZmf92gYYeJmBLicvQGZQyY+qNJaQzzh
         M+4qageeqSbX+64+JN7QOk9+Q8qtGqT890/DLkpmOfiloYWpMyuAcDKh+0CX+HrjKvOE
         l6suN1QcRhGd1Kf772eRJ93HKwpId0j/M5VDEoXewhWDjHv5sW3CR6l2KNnx39UITUx5
         v2Bw==
X-Gm-Message-State: APt69E1kZhK8Y9Kc1Aib+NXummdUENy25lQDc/Ok4p32+HP1xlFriFat
        8j4bF8DCOXmPbr9rYqxulTy+EQ==
X-Google-Smtp-Source: AAOMgpehVTkaCb36QKA2EZVsAiS+YQ7SxKj6AoZvpnMk41b2PxEOkbzoYOU0M8uMnbXmUUMdZ2HaOg==
X-Received: by 2002:adf:b782:: with SMTP id s2-v6mr8931779wre.247.1530200731383;
        Thu, 28 Jun 2018 08:45:31 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:21c3:ec41:bec9:c38])
        by smtp.gmail.com with ESMTPSA id i4-v6sm6202115wrq.28.2018.06.28.08.45.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Jun 2018 08:45:30 -0700 (PDT)
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
Subject: [PATCH 07/11] cpufreq/schedutil: take into account interrupt
Date:   Thu, 28 Jun 2018 17:45:10 +0200
Message-Id: <1530200714-4504-8-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530200714-4504-1-git-send-email-vincent.guittot@linaro.org>
References: <1530200714-4504-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The time spent under interrupt can be significant but it is not reflected
in the utilization of CPU when deciding to choose an OPP. Now that we have
access to this metric, schedutil can take it into account when selecting
the OPP for a CPU.
rqs utilization don't see the time spend under interrupt context and report
their value in the normal context time window. We need to compensate this when
adding interrupt utilization

The CPU utilization is :
  irq util_avg + (1 - irq util_avg / max capacity ) * /Sum rq util_avg

A test with iperf on hikey (octo arm64) gives:
iperf -c server_address -r -t 5

w/o patch		w/ patch
Tx 276 Mbits/sec        304 Mbits/sec +10%
Rx 299 Mbits/sec        328 Mbits/sec +09%

8 iterations
stdev is lower than 1%
Only WFI idle state is enable (shallowest diel state)

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c | 25 +++++++++++++++++++++----
 kernel/sched/sched.h             | 13 +++++++++++++
 2 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index edfbfc1..b77bfef 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -58,6 +58,7 @@ struct sugov_cpu {
 	unsigned long		util_dl;
 	unsigned long		bw_dl;
 	unsigned long		util_rt;
+	unsigned long		util_irq;
 	unsigned long		max;
 
 	/* The field below is for single-CPU policies only: */
@@ -190,21 +191,30 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu)
 	sg_cpu->util_dl  = cpu_util_dl(rq);
 	sg_cpu->bw_dl    = cpu_bw_dl(rq);
 	sg_cpu->util_rt  = cpu_util_rt(rq);
+	sg_cpu->util_irq = cpu_util_irq(rq);
 }
 
 static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
 {
 	struct rq *rq = cpu_rq(sg_cpu->cpu);
-	unsigned long util;
+	unsigned long util, max = sg_cpu->max;
 
 	if (rq->rt.rt_nr_running)
 		return sg_cpu->max;
 
+	if (unlikely(sg_cpu->util_irq >= max))
+		return max;
+
+	/* Sum rq utilization */
 	util = sg_cpu->util_cfs;
 	util += sg_cpu->util_rt;
 
-	if ((util + sg_cpu->util_dl) >= sg_cpu->max)
-		return sg_cpu->max;
+	/*
+	 * Interrupt time is not seen by rqs utilization nso we can compare
+	 * them with the CPU capacity
+	 */
+	if ((util + sg_cpu->util_dl) >= max)
+		return max;
 
 	/*
 	 * As there is still idle time on the CPU, we need to compute the
@@ -220,10 +230,17 @@ static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
 	 * ready for such an interface. So, we only do the latter for now.
 	 */
 
+	/* Weight rqs utilization to normal context window */
+	util *= (max - sg_cpu->util_irq);
+	util /= max;
+
+	/* Add interrupt utilization */
+	util += sg_cpu->util_irq;
+
 	/* Add DL bandwidth requirement */
 	util += sg_cpu->bw_dl;
 
-	return min(sg_cpu->max, util);
+	return min(max, util);
 }
 
 /**
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 377be2b..9438e68 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2221,4 +2221,17 @@ static inline unsigned long cpu_util_rt(struct rq *rq)
 {
 	return rq->avg_rt.util_avg;
 }
+
+#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
+static inline unsigned long cpu_util_irq(struct rq *rq)
+{
+	return rq->avg_irq.util_avg;
+}
+#else
+static inline unsigned long cpu_util_irq(struct rq *rq)
+{
+	return 0;
+}
+
+#endif
 #endif
-- 
2.7.4

