Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8DBECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 162F921479
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GZQ5q2DT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 162F921479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbeJTAYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 20:24:47 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36561 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727219AbeJTAYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 20:24:47 -0400
Received: by mail-wr1-f66.google.com with SMTP id y16so38051015wrw.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 09:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oaEkGQ1rlKwLiDv3FIuCYJt+L7qQIIrOC89EmKYAq9Y=;
        b=GZQ5q2DThJ5fdRiJF2HZI0py1F1ckPXm2jh1Qzq/+9D6NIARXVPgCo6Sj5gTgG2HI6
         LRDTQN9GxDGGVz9TGVvvncUkE/RcpnuaJI7gU0uapyu4wbmTkUPoOGWadtDkXC1rcb5x
         QejpBcmyzL4sYVtXIz78xMYr7S/mWlafpNiSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oaEkGQ1rlKwLiDv3FIuCYJt+L7qQIIrOC89EmKYAq9Y=;
        b=hj+9m5svljupT6F78AioWJT9SjSJaIWeUBzkdN+vusLHI1Kd5EN0L8t3L4iQyL0JNl
         Txbnb72P7S/oJUMC4m/XEC0ob4My/oZDqTu/rSnL01twCy3zBnpEAxnigSNFYs6+5jht
         Ls5LNvUcewCirjQIDOV34EmJXK7VlqFVFtZfXAEGdwtAgq8GoI+7aCdYZ311Kqx7dsPL
         q/OlJZN97GZWVxJEw52AEbEcqG5aPyDvrBYOCnwyKddCpbiyPt1aEVlt2pcA+xxkWeDN
         qtvIA+7kelp5Es7q3RciNzrkMTJEGhD3yQ8VBpPL6xtaDgpsm/vD9clI1m3uCfFgmW/K
         +rIg==
X-Gm-Message-State: AGRZ1gJzq8djHh2vE4GdzChA+mZZVchWRCvGJ2DoW9ZBOrBKse+3gPGS
        ycHqKH0MvHj8ONFMvSP68ZACtg==
X-Google-Smtp-Source: AJdET5e/aNbL1M/cqywvaWjVsr+I/vc7SxwZY8TV3NPz1YFR9+z4mFk+UIw/VFxwmHsAwtsbCHCJXQ==
X-Received: by 2002:adf:b612:: with SMTP id f18-v6mr1215668wre.120.1539965878528;
        Fri, 19 Oct 2018 09:17:58 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:9024:3180:921a:1e27])
        by smtp.gmail.com with ESMTPSA id n11-v6sm17009460wrx.17.2018.10.19.09.17.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Oct 2018 09:17:57 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, pjt@google.com,
        bsegall@google.com, thara.gopinath@linaro.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 1/2] sched/fair: move rq_of helper function
Date:   Fri, 19 Oct 2018 18:17:50 +0200
Message-Id: <1539965871-22410-2-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539965871-22410-1-git-send-email-vincent.guittot@linaro.org>
References: <1539965871-22410-1-git-send-email-vincent.guittot@linaro.org>
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
index 6bd142d..0969ce3 100644
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
index 3a4ef8f..3990818 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -566,6 +566,22 @@ struct cfs_rq {
 #endif /* CONFIG_FAIR_GROUP_SCHED */
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
 static inline int rt_bandwidth_enabled(void)
 {
 	return sysctl_sched_rt_runtime >= 0;
-- 
2.7.4

