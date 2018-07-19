Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DB2C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DBCD20684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 12:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bA3dsgaa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DBCD20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730966AbeGSMnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 08:43:10 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34050 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730451AbeGSMnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 08:43:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id c13-v6so7817253wrt.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 05:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=vbIBHcCP7TWdjRelz80wqC2++ODtotrHkzVxAc96dQg=;
        b=bA3dsgaaS3TWRxXDmdYtFzcPD1YVcPV2jW2eT+zsFcvJ+WYfRY+/2ZtOGuV/KzPem9
         HlQY5ekQK2sc/FWQNHC3ov9x4RCkfjRcKkpneh4Vn5LlzGZf1nwEzghG31SFvtscXOIu
         ay0X1dZb1h5IHWmSVRKvCFE6Aq95FfqImiHhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vbIBHcCP7TWdjRelz80wqC2++ODtotrHkzVxAc96dQg=;
        b=lUcIa4QjuZ8qdhJp7K3vRylb6VqJKIQiQQvgFQuYCT+2ux2tBuDa+5xz0Aqdp4a0wP
         E2XfynExuHZnSSYt4Z+Xe48FkliRNVd+gnjPf0cKnnZ1mimJMXw9QUUp/mw0fOJ2oSUt
         bWcLNC91AbaX/IiC3ErCo6pYAaieFtWcdxmMapEZ5Ph2XX9XM6BNZp9Qr2CGvjep95A/
         bLM98dd9Refuku7YKTlei9HXc0xvXDGW46K5xcrgFWWIOKeFIfsHPHEcS4gBiJ/J9oLE
         o9L/w7Y7McO88WiV/2cIrwfVEwGTipCX0dFnrhj2sXeK5K1SEGXasyZ2PeD+S4pJK8fc
         gPlA==
X-Gm-Message-State: AOUpUlHmxF1UV9Lx37rW0hV0OFlnK9FoM5VP7lgJausc6374TsY3XiQT
        u/J5DZRc9rnNkzj9KCGF3TztZ2vUq2Q=
X-Google-Smtp-Source: AAOMgpd6V/SGSJzicM7V012nbHOwpgTfpgQ6xINZg46NNMvgOCO2w+wDTHFfjOUkbKuFGeZvs104FA==
X-Received: by 2002:a5d:5043:: with SMTP id h3-v6mr6974818wrt.186.1532001619411;
        Thu, 19 Jul 2018 05:00:19 -0700 (PDT)
Received: from vingu-laptop.home ([2a01:cb14:8227:ec00:30f7:19b6:cda6:1ba8])
        by smtp.gmail.com with ESMTPSA id f20-v6sm9882203wrh.89.2018.07.19.05.00.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jul 2018 05:00:18 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched/fair: remove #ifdefs from scale_rt_capacity
Date:   Thu, 19 Jul 2018 14:00:06 +0200
Message-Id: <1532001606-6689-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reuse cpu_util_irq() that has been defined for schedutil and set irq util
to 0 when !CONFIG_IRQ_TIME_ACCOUNTING

But the compiler is not able to optimize the sequence (at least with
aarch64 GCC 7.2.1)
	free *= (max - irq);
	free /= max;
when irq is fixed to 0

Add a new inline function scale_irq_capacity() that will scale utilization
when irq is accounted. Reuse this funciton in schedutil which applies
similar formula.

Suggested-by: Ingo Molnar <mingo@redhat.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c |  3 +--
 kernel/sched/fair.c              | 13 +++----------
 kernel/sched/sched.h             | 20 ++++++++++++++++++--
 3 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 97dcd44..3fffad3 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -247,8 +247,7 @@ static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
 	 *   U' = irq + ------- * U
 	 *                max
 	 */
-	util *= (max - irq);
-	util /= max;
+	util = scale_irq_capacity(util, irq, max);
 	util += irq;
 
 	/*
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d5f7d52..14c3fdd 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7551,16 +7551,12 @@ static unsigned long scale_rt_capacity(int cpu)
 	struct rq *rq = cpu_rq(cpu);
 	unsigned long max = arch_scale_cpu_capacity(NULL, cpu);
 	unsigned long used, free;
-#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
 	unsigned long irq;
-#endif
 
-#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
-	irq = READ_ONCE(rq->avg_irq.util_avg);
+	irq = cpu_util_irq(rq);
 
 	if (unlikely(irq >= max))
 		return 1;
-#endif
 
 	used = READ_ONCE(rq->avg_rt.util_avg);
 	used += READ_ONCE(rq->avg_dl.util_avg);
@@ -7569,11 +7565,8 @@ static unsigned long scale_rt_capacity(int cpu)
 		return 1;
 
 	free = max - used;
-#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
-	free *= (max - irq);
-	free /= max;
-#endif
-	return free;
+
+	return scale_irq_capacity(free, irq, max);
 }
 
 static void update_cpu_capacity(struct sched_domain *sd, int cpu)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ebb4b3c..b80c3fd 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2210,17 +2210,33 @@ static inline unsigned long cpu_util_rt(struct rq *rq)
 {
 	return READ_ONCE(rq->avg_rt.util_avg);
 }
+#endif
 
-#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
+#if defined(SMP) \
+ && (defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING))
 static inline unsigned long cpu_util_irq(struct rq *rq)
 {
 	return rq->avg_irq.util_avg;
 }
+
+static inline
+unsigned long scale_irq_capacity(unsigned long util, unsigned long irq, unsigned long max)
+{
+	util *= (max - irq);
+	util /= max;
+
+	return util;
+
+}
 #else
 static inline unsigned long cpu_util_irq(struct rq *rq)
 {
 	return 0;
 }
 
-#endif
+static inline
+unsigned long scale_irq_capacity(unsigned long util, unsigned long irq, unsigned long max)
+{
+	return util;
+}
 #endif
-- 
2.7.4

