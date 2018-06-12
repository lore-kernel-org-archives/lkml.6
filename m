Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D612EC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 09:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C4E120693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 09:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IgOfO+LZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C4E120693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933362AbeFLJRD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 05:17:03 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50751 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754182AbeFLJRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 05:17:01 -0400
Received: by mail-wm0-f65.google.com with SMTP id e16-v6so19255595wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 02:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WvtMndVcE+zY1AzybVkxQW7fclsVFc5neOS/DrsQdO0=;
        b=IgOfO+LZeFt81ZluWkjXymXIMwnlsdVvqsgghxi4aiqCQ1Ugm/ElSVrON94G+2sx5l
         97rsMifKd+/U3bDbiobkcEjxQjqBJKAwTe6xSp9eoltOzqG0oiB2MCl7QIFn8BjB6iN4
         0rMLXEuBYGh4JfQXIeWadFOikPnHAYFHhyjoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WvtMndVcE+zY1AzybVkxQW7fclsVFc5neOS/DrsQdO0=;
        b=reg9pDL596tGdIw/6EvrL9k9Dp9tqizP059Dv2kVYxzkmkZrbZsb1hiPLvViIz2WpW
         mgFszrFl/zP2uomO3toE48c6w5uM+yvoRUGvJhpkBWcwhAxMC24qG+Z5W0h8WHBL8Gt2
         yQWIXh0Kz5uf2JdNlcsBazc3nffylnqkKjvPf0P5XCGrR/83ygL7B/EBBsRREzVMIO1I
         LZIT6Wac59XlVkjgwNIA6XhbAtq6e2nXi1r6464HUgNbds14UyLpMMkyTIjTD7/7JpTj
         wT/DSBMtqx3seL1sG1q00f66ardywMJhPRNHZ6C4ISGXIcITwZw7hJmO78WOpZINilSH
         wqJQ==
X-Gm-Message-State: APt69E1p24lYfWIQvttwBOkNPybcVhEFWi/mbi1d9YDtkGuxRyKn/79R
        amWHwakFawW8lBBbBLh0eQ37wg==
X-Google-Smtp-Source: ADUXVKKt7jQdFHBYtiwde2tSwF96fU/EtVGPUisd6Wtz0/foi3amdHwGDtNMrYaJBV7ZjVKPfqkB1Q==
X-Received: by 2002:a1c:6b56:: with SMTP id g83-v6mr1618951wmc.143.1528795020475;
        Tue, 12 Jun 2018 02:17:00 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:45d:8afb:43b3:1e03])
        by smtp.gmail.com with ESMTPSA id m145-v6sm784446wma.19.2018.06.12.02.16.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Jun 2018 02:16:59 -0700 (PDT)
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
Subject: [PATCH v6 08/11] cpufreq/schedutil: take into account interrupt
Date:   Tue, 12 Jun 2018 11:16:56 +0200
Message-Id: <1528795016-18208-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <CAKfTPtCCi665e45Ar52VLvaeem4Acin0jgo_563nAhYEkhHacw@mail.gmail.com>
References: <CAKfTPtCCi665e45Ar52VLvaeem4Acin0jgo_563nAhYEkhHacw@mail.gmail.com>
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
index 25cee59..092c310 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -58,6 +58,7 @@ struct sugov_cpu {
 	unsigned long		util_dl;
 	unsigned long		bw_dl;
 	unsigned long		util_rt;
+	unsigned long		util_irq;
 	unsigned long		max;
 
 	/* The field below is for single-CPU policies only: */
@@ -182,21 +183,30 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu)
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
+	 * Interrupt time is not seen by rqs utilization so we can compare
+	 * them with the CPU capacity
+	 */
+	if ((util + sg_cpu->util_dl) >= max)
+		return max;
 
 	/*
 	 * As there is still idle time on the CPU, we need to compute the
@@ -207,10 +217,17 @@ static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
 	 * periods of time.
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
 
 static void sugov_set_iowait_boost(struct sugov_cpu *sg_cpu, u64 time, unsigned int flags)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b534a43..873b567 100644
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

