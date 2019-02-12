Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D436BC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE32218A3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Llvr7yni"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbfBLJ1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 04:27:42 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35620 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfBLJ1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 04:27:42 -0500
Received: by mail-pf1-f193.google.com with SMTP id z15so282826pfa.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 01:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=js2oV91gkpITswyRz8+4yttTulMcRdALQnRF5jRIEYc=;
        b=Llvr7ynibkY71NBRrPxV6NDJj7HyDNt0dJC2XSxJMA/H2xAh6cj6HxMz2DbTyIEqyX
         drVWryXJN8XJykdDY7L02BlNgymoFO9W7QDBnkOY192Fp6EgQd+FEX12uQmJqQ/C+J6X
         CHmKt25mWDsfHMki1dVYVsSQYj8frUZMKISVrr4ZvSEEkYgvOhLAbjtQlJl4ZeO4eopO
         UI1ndO2tGM85tRr3CJAYewmZfnK7M+wPw7j59IkS8sZYjXp4gP6HFr8+ErCacTSnSHv+
         TagmqrAfBlzLYzqb42U35iX1u/dVLTPTOzv2jpITXO1ii3H7xzYOKGBfm/4JkWBEmsgG
         GRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=js2oV91gkpITswyRz8+4yttTulMcRdALQnRF5jRIEYc=;
        b=qaDRV3ZzX/f1VlB8T55VOk1nxIJDnuU3cl4ntK7l1eHlk93kUBMhJTVlK8DiETWnQ5
         vGR5g6lFzrrWKkeiu/pm26zBYft4jFXvsT17+qcL4vlelFId+6j+YvJnds69SKMIAezl
         Dm1/X0j1OgB+LQNfbDzvR6KN2EDu8W1BacFQsfU+KRwIorTlyf7zAjYM0cObllEbXN2D
         XGV2erz+kmc5JPMmMEuuNhZgsEVhd5pO1iKPItvGF4l/djMT6MZ/KJItaZurYglID+rU
         SInZIvMzRLAiCQGTfMlTBoohxp6BzKnapIXj5iDZbnK47R0eOd/5uUOaNTcN8XMlS983
         cYOw==
X-Gm-Message-State: AHQUAua6A0YmSkqRrMHuTOY+WrN1z5ar8NaP3Sc31RTspTAq+ljrQH4z
        VwRHwj57ukvGAR2Mj1+RETJ3WKwpqTI=
X-Google-Smtp-Source: AHgI3IZnHwofItZnNrMaS6NjsD0WU2vBuuilp4URUzo5vNp5O+SvHHCr8ZG7uuvqBM1tKc0uEDBsIA==
X-Received: by 2002:a62:20c9:: with SMTP id m70mr998718pfj.118.1549963661232;
        Tue, 12 Feb 2019 01:27:41 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id c18sm7661692pfc.63.2019.02.12.01.27.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 01:27:40 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched: Use non-atomic cpumask_{set,clear}_cpu()
Date:   Tue, 12 Feb 2019 14:57:01 +0530
Message-Id: <2e2a10f84b9049a81eef94ed6d5989447c21e34a.1549963617.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce00
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpumasks updated here are not subject to concurrency and using
atomic bitops for them is pointless and expensive. Use the non-atomic
variants instead.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 kernel/sched/fair.c      | 6 +++---
 kernel/sched/isolation.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8abd1c271499..8213ff6e365d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6097,7 +6097,7 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
 		bool idle = true;
 
 		for_each_cpu(cpu, cpu_smt_mask(core)) {
-			cpumask_clear_cpu(cpu, cpus);
+			__cpumask_clear_cpu(cpu, cpus);
 			if (!available_idle_cpu(cpu))
 				idle = false;
 		}
@@ -9105,7 +9105,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 		if ((env.flags & LBF_DST_PINNED) && env.imbalance > 0) {
 
 			/* Prevent to re-select dst_cpu via env's CPUs */
-			cpumask_clear_cpu(env.dst_cpu, env.cpus);
+			__cpumask_clear_cpu(env.dst_cpu, env.cpus);
 
 			env.dst_rq	 = cpu_rq(env.new_dst_cpu);
 			env.dst_cpu	 = env.new_dst_cpu;
@@ -9132,7 +9132,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 
 		/* All tasks on this runqueue were pinned by CPU affinity */
 		if (unlikely(env.flags & LBF_ALL_PINNED)) {
-			cpumask_clear_cpu(cpu_of(busiest), cpus);
+			__cpumask_clear_cpu(cpu_of(busiest), cpus);
 			/*
 			 * Attempting to continue load balancing at the current
 			 * sched_domain level only makes sense if there are
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 81faddba9e20..b02d148e7672 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -80,7 +80,7 @@ static int __init housekeeping_setup(char *str, enum hk_flags flags)
 		cpumask_andnot(housekeeping_mask,
 			       cpu_possible_mask, non_housekeeping_mask);
 		if (cpumask_empty(housekeeping_mask))
-			cpumask_set_cpu(smp_processor_id(), housekeeping_mask);
+			__cpumask_set_cpu(smp_processor_id(), housekeeping_mask);
 	} else {
 		cpumask_var_t tmp;
 
-- 
2.20.1.321.g9e740568ce00

