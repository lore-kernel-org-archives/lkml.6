Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3E9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96B5E20652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KN+PBl2O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729105AbfAQRoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 12:44:24 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35634 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728907AbfAQRoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 12:44:20 -0500
Received: by mail-wr1-f65.google.com with SMTP id 96so12005383wrb.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 09:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h4pmLxlqAAwEK/Le9rcYUHoEVmGCswsbfr3X31WPqMU=;
        b=KN+PBl2OyDHJD2XvvJ6txUy0nqqE+nyLLH211c1wQ2UupVfDfTv91YjDdfkED6uuBQ
         LLWeeM7oBRWYr71cZkPc0kBgTe3Gl5xFSCm4APkqNr6nbnbGRBS83gStFfJ+LVOh/JZA
         88kubaeSN/v+tI53XOXGj3jxOs8oL8Cer1NNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h4pmLxlqAAwEK/Le9rcYUHoEVmGCswsbfr3X31WPqMU=;
        b=uhImNnlceRhmXNNSeNkDfTsvRqFTHIULPNWefw/yFLL9IwgO7avvKMdmYIX1SaPE8h
         6WRNmYCK5jWfQNR86mRs37U6oZhMk5lrT8OSCb/HovFxsNw8jiMBtUTyaRQBZNW0zCk8
         Y4KEzNO6x8Az8QKxkWQQ7ntd0lhlurnLZrIZ8VA2phl1o4mvsBSSEeaolAhN1+GigCiy
         8uUZgKHY9RDpC3u+1zzIfrJ9x8s3lBG/cxSYOZNbCEHoObaDH9fefz9A4tmUBtNXrzoG
         cOELP/L0zu+KQCvdqz9rW9PaElzscFy5wMKaTGKrEEb27/2fQ16mnhKoUk/1gyXlSBQ7
         JP6w==
X-Gm-Message-State: AJcUukdgC5LxDxbqLbZwcj+xmgCR33f+fIVIjPVqn8IGdCaZVyVMAIww
        P/C1mZNhmHGAqARC48XKeLbDuQ==
X-Google-Smtp-Source: ALg8bN6TBrR9WPwtFTIuBtHeU9+vRMnrbpsMG1lkT1bKnRkM7JbeRxXo0LhppPCEsaYJuSpbsowFdA==
X-Received: by 2002:adf:d146:: with SMTP id b6mr13055449wri.156.1547747058779;
        Thu, 17 Jan 2019 09:44:18 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:8435:96d6:e03:9e78])
        by smtp.gmail.com with ESMTPSA id i186sm47583622wmd.19.2019.01.17.09.44.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Jan 2019 09:44:17 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     valentin.schneider@arm.com, Morten.Rasmussen@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v4 3/3] sched/fair: fix unnecessary increase of balance interval
Date:   Thu, 17 Jan 2019 18:44:09 +0100
Message-Id: <1547747049-6320-4-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547747049-6320-1-git-send-email-vincent.guittot@linaro.org>
References: <1547747049-6320-1-git-send-email-vincent.guittot@linaro.org>
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
index bd3b0ac..0e17991 100644
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

