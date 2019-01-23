Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06412C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C69A32133D
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="H5xZtLXo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfAWP1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 10:27:08 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56260 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfAWP1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 10:27:05 -0500
Received: by mail-wm1-f66.google.com with SMTP id y139so2364114wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 07:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hReVLUTWGkU8mA22pHwBBkB0pAs98jcygffTpDVc1AM=;
        b=H5xZtLXokiLacrs6wDPekNuZfdOP9oqcYTVEw8J0HQAGoGxxyrgpFxpldRIbRdApTj
         cIKDzK2pmHR4AQtkSNmSDC2SHei2MUZBMt97zvXp9goIwxMofKBwRrvsYJdv2bNOWAXW
         RHtWGK+EFbzelUcb/mu78bsLyRNodM3lUHlRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hReVLUTWGkU8mA22pHwBBkB0pAs98jcygffTpDVc1AM=;
        b=SgOqq+cXzcgEcWdtINcXwDl8yyR6pWdGIPbQU5fb9Kb6BzSYjL0u6fsLm4jDoipc5/
         tikX1u+ZB3AugVKeaf7iLx0TF5g/N4asaFX/7lDxyKZF563EcH48jiuUettaaX8VWZh4
         2QrSFSPcz0PXxUJxz01vqjky610ST9Fr+vyNU0rk5Dy587r2fVvUUsrPaBHyqeus3XvU
         XUnu2WAhjZGek6k0CweQrYfT8CPdly0h7RizL/qVQnfAu/OrOrUzAN4IzhIy0wG3LYcd
         5moGW6/5fy3OmasPkVNN++w41Hw+kct3N341UbWsbaXgAHThZqxUB+jpCls7ZLfjOb1L
         FvVg==
X-Gm-Message-State: AJcUukd3zBvWxPDmOY6MvI74PONkHBBRlFHYti0TIzrSi6KYFtRGrNZj
        A0myrtsyWjpVEYgeKnn0uS+9Uw==
X-Google-Smtp-Source: ALg8bN4NoHFmH6BqXI9JSS0/n/6Djt64Gm9uC1DL4p7vEvaUf61AVbcVWsWMJKMfBhHi/0T9A8QWUQ==
X-Received: by 2002:a1c:7d06:: with SMTP id y6mr3086261wmc.7.1548257223075;
        Wed, 23 Jan 2019 07:27:03 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:5ca6:2921:648b:56b6])
        by smtp.gmail.com with ESMTPSA id b13sm92938536wrn.28.2019.01.23.07.27.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Jan 2019 07:27:01 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, pjt@google.com,
        bsegall@google.com, thara.gopinath@linaro.org,
        pkondeti@codeaurora.org, quentin.perret@arm.com,
        srinivas.pandruvada@linux.intel.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v9 1/3] sched/fair: move rq_of helper function
Date:   Wed, 23 Jan 2019 16:26:52 +0100
Message-Id: <1548257214-13745-2-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548257214-13745-1-git-send-email-vincent.guittot@linaro.org>
References: <1548257214-13745-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move rq_of() helper function so it can be used in pelt.c

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c  | 13 -------------
 kernel/sched/sched.h | 16 ++++++++++++++++
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e2ff4b6..cdddc86 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -248,13 +248,6 @@ const struct sched_class fair_sched_class;
  */
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-
-/* cpu runqueue to which this cfs_rq is attached */
-static inline struct rq *rq_of(struct cfs_rq *cfs_rq)
-{
-	return cfs_rq->rq;
-}
-
 static inline struct task_struct *task_of(struct sched_entity *se)
 {
 	SCHED_WARN_ON(!entity_is_task(se));
@@ -410,12 +403,6 @@ static inline struct task_struct *task_of(struct sched_entity *se)
 	return container_of(se, struct task_struct, se);
 }
 
-static inline struct rq *rq_of(struct cfs_rq *cfs_rq)
-{
-	return container_of(cfs_rq, struct rq, cfs);
-}
-
-
 #define for_each_sched_entity(se) \
 		for (; se; se = NULL)
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d27c1a5..d57a590 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -951,6 +951,22 @@ struct rq {
 #endif
 };
 
+#ifdef CONFIG_FAIR_GROUP_SCHED
+
+/* cpu runqueue to which this cfs_rq is attached */
+static inline struct rq *rq_of(struct cfs_rq *cfs_rq)
+{
+	return cfs_rq->rq;
+}
+
+#else	/* !CONFIG_FAIR_GROUP_SCHED */
+
+static inline struct rq *rq_of(struct cfs_rq *cfs_rq)
+{
+	return container_of(cfs_rq, struct rq, cfs);
+}
+#endif
+
 static inline int cpu_of(struct rq *rq)
 {
 #ifdef CONFIG_SMP
-- 
2.7.4

