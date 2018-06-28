Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BBBC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF9827633
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HB6/D75V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EF9827633
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935495AbeF1PqU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 11:46:20 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34877 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935010AbeF1Ppg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 11:45:36 -0400
Received: by mail-wm0-f65.google.com with SMTP id z137-v6so9613949wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 08:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Zl1T6q56msdYU0ByNc7HaXHBLSwGLVg5J9bQL90yjrE=;
        b=HB6/D75VP9llFmXijrF8Pi7+2MV2uJ7hICGfVk38x//OXSMU0RET6k3syL9yeJDf/Z
         u8YjjmdH9gXzGpBoZJ/+xe5gN5PrEmEFsfTZ/fv7QoVyxpAtexLig86MLkk9yVQSWMv5
         5Zt5Sr6ZuJ7YavA+Z9z0Wyjkb7sv+oENNPIGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Zl1T6q56msdYU0ByNc7HaXHBLSwGLVg5J9bQL90yjrE=;
        b=nyUcRk1k3R1G1W4nFDFn1DcMigpCjqk01KKaJwQ9ZN62gEHzDiWY46E/klZYhktBxp
         xM9d1p85mPFoVQzuSmD1V5YRkWSE2apDk11p/K3OEdAGRHaylUCT+e7VuGEfaLH/pDWX
         Mbn/o8AvuTW/AUi+QqSzTJLwtcYjz6VXlqNKSZc3aG56wu1/wL1bW0acpIewZsxbhcQo
         6MoAfHr8TPBsgVNLy2yxxY36NXhp6RCU0TIgdjhAWLiq6WuBxnPundELUM0HARm8xasU
         xa9dvkuvWdJMHKyxGm/o6/ugxcbAZnUGRO5c/5pPS47uhDBTPYuhKUyFd05JA5mEn919
         svUw==
X-Gm-Message-State: APt69E3vaIgr08qBGoAFaBdt9j/UcAE4WcZECS+w45KtXoU0xPiVqMqy
        lDNoY/qA3MxIuu2CSghkZMQ1Fg==
X-Google-Smtp-Source: AAOMgpfH3MMitBE2ODnbstECQIiilteXDi+S9gHTT1DKQavY7ac+c8++peree3xsAloxnoQNfKRp7w==
X-Received: by 2002:a1c:b801:: with SMTP id i1-v6mr8440469wmf.30.1530200734938;
        Thu, 28 Jun 2018 08:45:34 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:21c3:ec41:bec9:c38])
        by smtp.gmail.com with ESMTPSA id i4-v6sm6202115wrq.28.2018.06.28.08.45.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Jun 2018 08:45:34 -0700 (PDT)
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
Subject: [PATCH 09/11] sched: use pelt for scale_rt_capacity()
Date:   Thu, 28 Jun 2018 17:45:12 +0200
Message-Id: <1530200714-4504-10-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530200714-4504-1-git-send-email-vincent.guittot@linaro.org>
References: <1530200714-4504-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The utilization of the CPU by rt, dl and interrupts are now tracked with
PELT so we can use these metrics instead of rt_avg to evaluate the remaining
capacity available for cfs class.

scale_rt_capacity() behavior has been changed and now returns the remaining
capacity available for cfs instead of a scaling factor because rt, dl and
interrupt provide now absolute utilization value.

The same formula as schedutil is used:
  irq util_avg + (1 - irq util_avg / max capacity ) * /Sum rq util_avg
but the implementation is different because it doesn't return the same value
and doesn't benefit of the same optimization

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/deadline.c |  2 --
 kernel/sched/fair.c     | 41 +++++++++++++++++++----------------------
 kernel/sched/pelt.c     |  2 +-
 kernel/sched/rt.c       |  2 --
 4 files changed, 20 insertions(+), 27 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index f4de2698..68b8a9f 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1180,8 +1180,6 @@ static void update_curr_dl(struct rq *rq)
 	curr->se.exec_start = now;
 	cgroup_account_cputime(curr, delta_exec);
 
-	sched_rt_avg_update(rq, delta_exec);
-
 	if (dl_entity_is_special(dl_se))
 		return;
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d2758e3..ce0dcbf 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7550,39 +7550,36 @@ static inline int get_sd_load_idx(struct sched_domain *sd,
 static unsigned long scale_rt_capacity(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
-	u64 total, used, age_stamp, avg;
-	s64 delta;
-
-	/*
-	 * Since we're reading these variables without serialization make sure
-	 * we read them once before doing sanity checks on them.
-	 */
-	age_stamp = READ_ONCE(rq->age_stamp);
-	avg = READ_ONCE(rq->rt_avg);
-	delta = __rq_clock_broken(rq) - age_stamp;
+	unsigned long max = arch_scale_cpu_capacity(NULL, cpu);
+	unsigned long used, irq, free;
 
-	if (unlikely(delta < 0))
-		delta = 0;
+#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
+	irq = READ_ONCE(rq->avg_irq.util_avg);
 
-	total = sched_avg_period() + delta;
+	if (unlikely(irq >= max))
+		return 1;
+#endif
 
-	used = div_u64(avg, total);
+	used = READ_ONCE(rq->avg_rt.util_avg);
+	used += READ_ONCE(rq->avg_dl.util_avg);
 
-	if (likely(used < SCHED_CAPACITY_SCALE))
-		return SCHED_CAPACITY_SCALE - used;
+	if (unlikely(used >= max))
+		return 1;
 
-	return 1;
+	free = max - used;
+#if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
+	free *= (max - irq);
+	free /= max;
+#endif
+	return free;
 }
 
 static void update_cpu_capacity(struct sched_domain *sd, int cpu)
 {
-	unsigned long capacity = arch_scale_cpu_capacity(sd, cpu);
+	unsigned long capacity = scale_rt_capacity(cpu);
 	struct sched_group *sdg = sd->groups;
 
-	cpu_rq(cpu)->cpu_capacity_orig = capacity;
-
-	capacity *= scale_rt_capacity(cpu);
-	capacity >>= SCHED_CAPACITY_SHIFT;
+	cpu_rq(cpu)->cpu_capacity_orig = arch_scale_cpu_capacity(sd, cpu);
 
 	if (!capacity)
 		capacity = 1;
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index ead6d8b..35475c0 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -237,7 +237,7 @@ ___update_load_avg(struct sched_avg *sa, unsigned long load, unsigned long runna
 	 */
 	sa->load_avg = div_u64(load * sa->load_sum, divider);
 	sa->runnable_load_avg =	div_u64(runnable * sa->runnable_load_sum, divider);
-	sa->util_avg = sa->util_sum / divider;
+	WRITE_ONCE(sa->util_avg, sa->util_sum / divider);
 }
 
 /*
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 0e3e57a..2a881bd 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -970,8 +970,6 @@ static void update_curr_rt(struct rq *rq)
 	curr->se.exec_start = now;
 	cgroup_account_cputime(curr, delta_exec);
 
-	sched_rt_avg_update(rq, delta_exec);
-
 	if (!rt_bandwidth_enabled())
 		return;
 
-- 
2.7.4

