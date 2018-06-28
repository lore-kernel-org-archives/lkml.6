Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80235C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3062827637
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LUQuXuLi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3062827637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754131AbeF1Pq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 11:46:56 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36868 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967314AbeF1Ppa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 11:45:30 -0400
Received: by mail-wr0-f196.google.com with SMTP id k6-v6so6009749wrp.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 08:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YT5me/HnRjYE9yp/0nmuxMBvwSfbkC95sqdLOxFzYCo=;
        b=LUQuXuLinYCDUNKo+4+Q7SVtwB/719UuWQM1z0wXEsOyEU7vN7h3s5xvp4wrz6C9Mx
         EDvrhjFaOPGXeqebieRzVOO1PERkEhSxQUxHT9QvOV+HK34Bij0VqR1zZM27hDHSoPYR
         twIAjZb6QbBc0pdEoZyqFgUdrTBwWZv8ggJHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YT5me/HnRjYE9yp/0nmuxMBvwSfbkC95sqdLOxFzYCo=;
        b=TD5LpxKykOssMjTOZp+J/eEFc+kwAlbWn4b32ba7ci6cOq5Wsiyc7DRFZVegX1Qq3r
         aT1t5gFikPh+5DHxpmzwqbQmS7uyLsdYbwItjnF3YSUZDrHoI/MoCiYLt3481ZU5c3tU
         eyHLXRCqTtXCmR2jbad+SebdIBkW38Yr64DHeTWQpNC3umyPWQkCe6e92JA3e2rWtpqE
         GbmQ5Q8P43J4d3nj2dqzzEXE3OKEsV+a0ex4j5M4W3DwMgYszzShXPcZaYKk4i86OmOo
         HaqrC+Q8SmpMH/sc7/e+JdSgVg6NrwTDdquri65AeVKFP3VjWvqEz5ReUhAJYYY9xPUe
         bWHg==
X-Gm-Message-State: APt69E2l1U2tzJEC4roGE/1IJgvnVGpGl+ucCFhxUwzzaiTZit/dX2Rj
        z2o7ezxbVbstIi7UBoHjgs2BGQ==
X-Google-Smtp-Source: AAOMgpcFNgPawcqK9hIwkh0s3ua+//wR2P/oBmBBGTeP2FAtXoPOMCwLZ0dgMCg8v2VDv6wxK7ufwQ==
X-Received: by 2002:adf:f708:: with SMTP id r8-v6mr4372177wrp.85.1530200728655;
        Thu, 28 Jun 2018 08:45:28 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:21c3:ec41:bec9:c38])
        by smtp.gmail.com with ESMTPSA id i4-v6sm6202115wrq.28.2018.06.28.08.45.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Jun 2018 08:45:27 -0700 (PDT)
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
Subject: [PATCH 05/11] cpufreq/schedutil: use dl utilization tracking
Date:   Thu, 28 Jun 2018 17:45:08 +0200
Message-Id: <1530200714-4504-6-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530200714-4504-1-git-send-email-vincent.guittot@linaro.org>
References: <1530200714-4504-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have both the dl class bandwidth requirement and the dl class
utilization, we can detect when CPU is fully used so we should run at max.
Otherwise, we keep using the dl bandwidth requirement to define the
utilization of the CPU

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c | 23 +++++++++++++++++------
 kernel/sched/sched.h             |  7 ++++++-
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 9c5e92e..edfbfc1 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -56,6 +56,7 @@ struct sugov_cpu {
 	/* The fields below are only needed when sharing a policy: */
 	unsigned long		util_cfs;
 	unsigned long		util_dl;
+	unsigned long		bw_dl;
 	unsigned long		util_rt;
 	unsigned long		max;
 
@@ -187,6 +188,7 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu)
 	sg_cpu->max = arch_scale_cpu_capacity(NULL, sg_cpu->cpu);
 	sg_cpu->util_cfs = cpu_util_cfs(rq);
 	sg_cpu->util_dl  = cpu_util_dl(rq);
+	sg_cpu->bw_dl    = cpu_bw_dl(rq);
 	sg_cpu->util_rt  = cpu_util_rt(rq);
 }
 
@@ -198,20 +200,29 @@ static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
 	if (rq->rt.rt_nr_running)
 		return sg_cpu->max;
 
-	util = sg_cpu->util_dl;
-	util += sg_cpu->util_cfs;
+	util = sg_cpu->util_cfs;
 	util += sg_cpu->util_rt;
 
+	if ((util + sg_cpu->util_dl) >= sg_cpu->max)
+		return sg_cpu->max;
+
 	/*
-	 * Utilization required by DEADLINE must always be granted while, for
-	 * FAIR, we use blocked utilization of IDLE CPUs as a mechanism to
-	 * gracefully reduce the frequency when no tasks show up for longer
+	 * As there is still idle time on the CPU, we need to compute the
+	 * utilization level of the CPU.
+	 *
+	 * Bandwidth required by DEADLINE must always be granted while, for
+	 * FAIR and RT, we use blocked utilization of IDLE CPUs as a mechanism
+	 * to gracefully reduce the frequency when no tasks show up for longer
 	 * periods of time.
 	 *
 	 * Ideally we would like to set util_dl as min/guaranteed freq and
 	 * util_cfs + util_dl as requested freq. However, cpufreq is not yet
 	 * ready for such an interface. So, we only do the latter for now.
 	 */
+
+	/* Add DL bandwidth requirement */
+	util += sg_cpu->bw_dl;
+
 	return min(sg_cpu->max, util);
 }
 
@@ -367,7 +378,7 @@ static inline bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu) { return false; }
  */
 static inline void ignore_dl_rate_limit(struct sugov_cpu *sg_cpu, struct sugov_policy *sg_policy)
 {
-	if (cpu_util_dl(cpu_rq(sg_cpu->cpu)) > sg_cpu->util_dl)
+	if (cpu_bw_dl(cpu_rq(sg_cpu->cpu)) > sg_cpu->bw_dl)
 		sg_policy->need_freq_update = true;
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 7d7d4f4..ef5d6aa 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2192,11 +2192,16 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
 #endif
 
 #ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
-static inline unsigned long cpu_util_dl(struct rq *rq)
+static inline unsigned long cpu_bw_dl(struct rq *rq)
 {
 	return (rq->dl.running_bw * SCHED_CAPACITY_SCALE) >> BW_SHIFT;
 }
 
+static inline unsigned long cpu_util_dl(struct rq *rq)
+{
+	return READ_ONCE(rq->avg_dl.util_avg);
+}
+
 static inline unsigned long cpu_util_cfs(struct rq *rq)
 {
 	unsigned long util = READ_ONCE(rq->cfs.avg.util_avg);
-- 
2.7.4

