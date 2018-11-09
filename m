Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5089BC43610
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17C3A20825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TvtREzwz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17C3A20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbeKJCC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 21:02:26 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38879 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728347AbeKJCCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 21:02:25 -0500
Received: by mail-wm1-f66.google.com with SMTP id f2-v6so2452393wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 08:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qwD5lMO+Jv5rC3Vbru4Vtmb8zAHEDsjHqlZgpqUjRR8=;
        b=TvtREzwzl4ij1ml1I8cnDrOCsZFSiIV7g8HX7C4gDxyR8son5uPiguHFF9aKu8AXm6
         IqK3wvRsMdeCe8Ysqqnn4hGETi5urSlYFndDiBEglkRdkDPCIs1BWZpvRP3U5lcvHdyW
         XycKpCT/zeBHbWjIfePpN3nXmF2VEvF2MdV2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qwD5lMO+Jv5rC3Vbru4Vtmb8zAHEDsjHqlZgpqUjRR8=;
        b=pgMml0Jq1V5/Xr+XYna39aqmp4TmGnMfycUs4yLSv1CLbMjCqksQCuxFGtq+ULFxVw
         c7KNGhTwh4YX4H2zbr4soeH/oP0IiWG8jjPjVwfNzMv9mEJZwCoQUYBhofWElYWs/4Ga
         F299moPhNp5e7kbpGGK7JYoimDYvf2s5hPmX9rmswBI1RRZN7RPXkbcIB/93MJka/3hg
         Iscsz6IF/KQ1dYjY96ky0FgIClGVUUSdW+HIDSmgy7ayRT04oYiDySvWiNhZj9H0yujO
         8tlgVQgc+bWAdxGfW7Suq9Y7t++WfepP3OwrrGlrxf8xcPUjoiUjNXdBmeli5fQkOg22
         Gqvw==
X-Gm-Message-State: AGRZ1gK5R6vCUDwBPm/YbUwItNi/3H5ArmQtvrJb9JwjFifVsLsQns00
        BTl5fTWL15KXHIaRmA0yUPzbKw==
X-Google-Smtp-Source: AJdET5dN+ljIaCQ8mo2UKUiQihMEUlEeYD7mb1GnbsYDo2NlmQOkMxiEWzO36M6al7+5UDLukKXUjQ==
X-Received: by 2002:a1c:62d7:: with SMTP id w206-v6mr44161wmb.14.1541780468759;
        Fri, 09 Nov 2018 08:21:08 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:30de:f495:80da:cbe6])
        by smtp.gmail.com with ESMTPSA id y195-v6sm1970509wme.22.2018.11.09.08.21.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Nov 2018 08:21:07 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, pjt@google.com,
        bsegall@google.com, thara.gopinath@linaro.org,
        pkondeti@codeaurora.org, quentin.perret@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v6 1/2] sched/fair: move rq_of helper function
Date:   Fri,  9 Nov 2018 17:20:53 +0100
Message-Id: <1541780454-9934-2-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541780454-9934-1-git-send-email-vincent.guittot@linaro.org>
References: <1541780454-9934-1-git-send-email-vincent.guittot@linaro.org>
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

