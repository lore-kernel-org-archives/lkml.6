Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96148C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA5922070B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="havscmDW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729749AbeLNQCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 11:02:12 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45571 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729223AbeLNQCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 11:02:10 -0500
Received: by mail-wr1-f67.google.com with SMTP id t6so5750516wrr.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 08:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kSbUmE3EGKEapXTs6bs0NCt+NOaZjSpHnZY2OS9OQMI=;
        b=havscmDWwZGMAzKt5wuIleD+HFomPrfW11OQVCs5Gs6Z9+OvpKXIkYwSNhbFiiAuQr
         HcvAf5tlFEPY/VY55VCrgOhPWoPbwzex4ruA8Ui2KaBgfmOXMvU272J/S5C1I+4MuoE7
         DFEFwD8jgxaE0oHhgW0KDi2R9azUbbBJ9LWQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kSbUmE3EGKEapXTs6bs0NCt+NOaZjSpHnZY2OS9OQMI=;
        b=GjYJjf0NOLHtQvCVCqoq05C/rRs5yG49Ncc0rmQ/wkHcXEY7wiR/cd5ZJ9ESDhb6/j
         X8u+kBHXN05EWygX5eoLBgAKP++hA6hH23LYsYSM6RHOQqXImylGh8oDspqDrunvZNNU
         j13mkAI7LH26K2dfnSj4YfVJ3aFXFEq/fROu2tL4+LPAz5NuNsF08MKRx+2lFV//zgxL
         C/LZDxm+AYoSeoeYv8pnN34eHRSxgDYVv9sKtpCGoqZeDU73N06HKd/jLerSU5j2ikEA
         1apJf1/ymEXpc1pA6eSirEvySzQyZVTKGtU414NIshIna80lJo1TAzCWaaMeNLesC/2P
         2Ihg==
X-Gm-Message-State: AA+aEWbgD9IUYxYhqznnkyPkmuogHhubtTVq+IkCeHmHTwzY9zINTCjY
        OKRpb8NKLlONIpgc6hFa9+wnyA==
X-Google-Smtp-Source: AFSGD/UNMtQWYHcWruz2zm+etKgh5LyLzCvNX2+0B+5b9k00Q7mAkdJow/HGpzWY7iJn23tqLnzB1g==
X-Received: by 2002:adf:c108:: with SMTP id r8mr3195463wre.233.1544803327999;
        Fri, 14 Dec 2018 08:02:07 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:ed2e:a6ad:f6ef:ff8e])
        by smtp.gmail.com with ESMTPSA id e17sm7888738wri.36.2018.12.14.08.02.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Dec 2018 08:02:07 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     valentin.schneider@arm.com, Morten.Rasmussen@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 3/3] sched/fair: fix unnecessary increase of balance interval
Date:   Fri, 14 Dec 2018 17:01:57 +0100
Message-Id: <1544803317-7610-4-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544803317-7610-1-git-send-email-vincent.guittot@linaro.org>
References: <1544803317-7610-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of active balance, we increase the balance interval to cover
pinned tasks cases not covered by all_pinned logic. Neverthless, the active
migration triggered by asym packing should be treated as the normal
unbalanced case and reset the interval to default value otherwise active
migration for asym_packing can be easily delayed for hundreds of ms
because of this all_pinned detection mecanism.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9591e7a..487287e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8857,21 +8857,24 @@ static struct rq *find_busiest_queue(struct lb_env *env,
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
+	       sched_asym_prefer(env->dst_cpu, env->src_cpu);
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
@@ -9150,7 +9153,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 	} else
 		sd->nr_balance_failed = 0;
 
-	if (likely(!active_balance)) {
+	if (likely(!active_balance) || asym_active_balance(&env)) {
 		/* We were unbalanced, so reset the balancing interval */
 		sd->balance_interval = sd->min_interval;
 	} else {
-- 
2.7.4

