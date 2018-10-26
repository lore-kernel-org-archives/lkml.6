Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC1AECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 16:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22D662086B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 16:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="H25pe06r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22D662086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbeJ0Ata (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 20:49:30 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52509 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbeJ0At2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 20:49:28 -0400
Received: by mail-wm1-f66.google.com with SMTP id 189-v6so2041933wmw.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 09:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qwD5lMO+Jv5rC3Vbru4Vtmb8zAHEDsjHqlZgpqUjRR8=;
        b=H25pe06rx+frN9OjQrKtkbdQTsca3GsL+X2Xl8b+LTMA97OlSJcBrI+ti1fGocAuJ3
         Z3UQzN7AuIQcBszK66yJ6D0+6ZO/sCJbapvIUmPRK3JO69wIsiHt/wVFYVPpU2kD+jnG
         93YFURfb3UT+O525BRzEGjOXjkNwOVmme2keY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qwD5lMO+Jv5rC3Vbru4Vtmb8zAHEDsjHqlZgpqUjRR8=;
        b=hXuyrga7Jymp+bkktpgegw/ZxKQak240HuqX8ZFg2YK5VA0djtWvIFBtZpoPd9YTxD
         61KsCgyrhIieYGwpUEzbed4gO9CRCd80vT0QQ7BYvMRxfp4TMfN/bX/nT4m2QFY1FWD7
         vpq/Mia5kY8R25MbkhZ8QOipJ2HaILt4aklTDX2nfjkY18LFYts7dgrcdTX3WQpu1VQ1
         x+IZ8AhG9Cfa2JhJ97xzr4Zcc4bn/MTkhc6JI7hNGdZClVWtRNu5m6+QcSYGpg2rRz4+
         57H0vNdTxgsKhTDirQn3XK/bHtQ5ews3sYqLakO83O+qo9dGa73/KMscOyR9Rf5dyDue
         vcgg==
X-Gm-Message-State: AGRZ1gJ//C2zCR+gYJUdu3Y4ooSbPfh7FcMgEvnzYYmh6zx3OrwKluX3
        SxEDg+CqPth+y5dhd1ZAnaRigw==
X-Google-Smtp-Source: AJdET5dPyFwMiPzkjdIwH1ViVyoaFaJqGntUvbLqMEU5TOEWhUEqIqb8tdZWAGxaoEA9uUGDKqbfhQ==
X-Received: by 2002:a1c:c142:: with SMTP id r63-v6mr5951742wmf.72.1540570308899;
        Fri, 26 Oct 2018 09:11:48 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:d30:71a0:24b4:1c25])
        by smtp.gmail.com with ESMTPSA id y16-v6sm11807209wru.18.2018.10.26.09.11.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Oct 2018 09:11:47 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, pjt@google.com,
        bsegall@google.com, thara.gopinath@linaro.org,
        pkondeti@codeaurora.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v5 1/2] sched/fair: move rq_of helper function
Date:   Fri, 26 Oct 2018 18:11:42 +0200
Message-Id: <1540570303-6097-2-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540570303-6097-1-git-send-email-vincent.guittot@linaro.org>
References: <1540570303-6097-1-git-send-email-vincent.guittot@linaro.org>
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
index d59307e..6806c27 100644
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
@@ -411,12 +404,6 @@ static inline struct task_struct *task_of(struct sched_entity *se)
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
index 798b1af..618b578 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -922,6 +922,22 @@ struct rq {
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

