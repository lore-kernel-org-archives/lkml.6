Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE2AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 07:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED0B921720
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 07:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TPDyeJl/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730697AbeLTH4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 02:56:00 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46724 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730721AbeLTHz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 02:55:56 -0500
Received: by mail-wr1-f68.google.com with SMTP id l9so653866wrt.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 23:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JMZgSdyWPqBACBBm3S9C2jr7vI8zerSZBF4GiDfVwEY=;
        b=TPDyeJl/2A1jvjLcQhEpVHU3bbt+NlZzVlI97aWnTm3th0ZYuK3XvPG8R6MtIvT9na
         rcw87YXsh5yPmS8w6jeETWZjg+rUswDz3NDPWXlRWbHyfsN+pyqQXoyc6JQnxfYOTwq/
         hVUwpmDBvmmlL5ITM3h6LAdViB+9TogDXFmlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JMZgSdyWPqBACBBm3S9C2jr7vI8zerSZBF4GiDfVwEY=;
        b=XkAeAwgZzRIaBxN/UV1bCIMEwU/MLIIXFXg+2g3aqEVS6HrXNkhu9AjnfInz+4Ajav
         M68z4kQ6DDed1Wg4dHodwDaJAC/rgfYBccZMvkoXoQI7WTwn87eYpsMmF0rmPZV3S4M1
         QwXS9P0EcsSwfriRcoBa4PcvBSuSZKlgDKEzu5PaKEzPE2VtVcl4hqh+AKLpslMCUGHC
         dbWc93qgDLhYLJk6neskPQVpR8i+FAksJTbOKrsYt6nOi4zLhVV8NaPJq6Q2IqyD57a9
         AAo+6eAYw4Et54yiaEYajyb8pwfSvhSdP01UtUumGy/DcW9GouuKe05gXNMZi7FTHdR1
         t/AA==
X-Gm-Message-State: AA+aEWYHGww8QaNP0L0f/epPG39W4tjJsCdpisQbUr7e6UdVr61v6UPz
        xgUI+Co7ZdhFXDB1XsyNgtREGw==
X-Google-Smtp-Source: AFSGD/XotY/nLFnRyLuCNNuH7qbTFFN9oNbv01jp4p9jZH99RYnsSxzNdnESJ/3T3+FO/fWhE2kWdA==
X-Received: by 2002:a05:6000:10d1:: with SMTP id b17mr21392340wrx.306.1545292554356;
        Wed, 19 Dec 2018 23:55:54 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:f9b3:37c1:b11a:64ce])
        by smtp.gmail.com with ESMTPSA id c10sm8773299wrw.49.2018.12.19.23.55.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Dec 2018 23:55:53 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     valentin.schneider@arm.com, Morten.Rasmussen@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 3/3] sched/fair: fix unnecessary increase of balance interval
Date:   Thu, 20 Dec 2018 08:55:47 +0100
Message-Id: <1545292547-18770-4-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545292547-18770-1-git-send-email-vincent.guittot@linaro.org>
References: <1545292547-18770-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of active balance, we increase the balance interval to cover
pinned tasks cases not covered by all_pinned logic. Neverthless, the
active migration triggered by asym packing should be treated as the normal
unbalanced case and reset the interval to default value otherwise active
migration for asym_packing can be easily delayed for hundreds of ms
because of this pinned task detection mecanism.
The same happen to other conditions tested in need_active_balance() like
mistfit task and when the capacity of src_cpu is reduced compared to
dst_cpu (see comments in need_active_balance() for details).

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 487c73e..9b1e701 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8849,21 +8849,25 @@ static struct rq *find_busiest_queue(struct lb_env *env,
  */
 #define MAX_PINNED_INTERVAL	512
 
-static int need_active_balance(struct lb_env *env)
+static inline bool
+asym_active_balance(struct lb_env *env)
 {
-	struct sched_domain *sd = env->sd;
+	/*
+	 * ASYM_PACKING needs to force migrate tasks from busy but
+	 * lower priority CPUs in order to pack all tasks in the
+	 * highest priority CPUs.
+	 */
+	return env->idle != CPU_NOT_IDLE && (env->sd->flags & SD_ASYM_PACKING) &&
+	       sched_asym_prefer(env->dst_cpu, env->src_cpu);
+}
 
-	if (env->idle != CPU_NOT_IDLE) {
+static inline bool
+voluntary_active_balance(struct lb_env *env)
+{
+	struct sched_domain *sd = env->sd;
 
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
@@ -8881,6 +8885,16 @@ static int need_active_balance(struct lb_env *env)
 	if (env->src_grp_type == group_misfit_task)
 		return 1;
 
+	return 0;
+}
+
+static int need_active_balance(struct lb_env *env)
+{
+	struct sched_domain *sd = env->sd;
+
+	if (voluntary_active_balance(env))
+		return 1;
+
 	return unlikely(sd->nr_balance_failed > sd->cache_nice_tries+2);
 }
 
@@ -9142,7 +9156,7 @@ static int load_balance(int this_cpu, struct rq *this_rq,
 	} else
 		sd->nr_balance_failed = 0;
 
-	if (likely(!active_balance)) {
+	if (likely(!active_balance) || voluntary_active_balance(&env)) {
 		/* We were unbalanced, so reset the balancing interval */
 		sd->balance_interval = sd->min_interval;
 	} else {
-- 
2.7.4

