Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1B3C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DFB320671
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hvuOU2yq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DFB320671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbeKTVXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 16:23:53 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39204 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728785AbeKTVXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 16:23:52 -0500
Received: by mail-wm1-f67.google.com with SMTP id u13-v6so1711241wmc.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 02:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/iWf/+HB2fUc3oesF9Db4tB9eQPZYersbB7xwtVyrfc=;
        b=hvuOU2yqaSaMmmG7R6c+p0kQEl3WQZXePoVlOppAxtxMO5Ma2Tqp7qJh+pzVvnVax8
         IND/SKFDgp7bHwf50q4ObPijaOEVkWOtw/apkYVnW8tEZ1Qg5gzzTMWp7MYW/crIiJsW
         2Ws62WCecltU7/EwlTbxCZdhvRwkxULSBpTAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/iWf/+HB2fUc3oesF9Db4tB9eQPZYersbB7xwtVyrfc=;
        b=F5FCTFzxtY5pfHF0GClz2t+t9lTEkLXoEcuHkpuyBnTTuLJ60w0z1B40w1koeiceg+
         KhUW5h+nZdB7RQFbg4nI3J11TvjLpRsEnfboN8oUFynLVbwmnuOmKbe9lnKWKSNFHJdu
         4Ov1zda2pQ1AWAe7dD1AwrwdQYwMSluYlw+vMMc992jZrQSjd+wavK/uziK+SajRVpTt
         FG/R0sIGsBPujpLdOaXmzOo1bvmKvhnBnFR0JyQxvMTKW9pzX6voywnt9AbmD9FHjOG7
         h9syKHN5rvLnj2xAcpcBceI/Cm0clHgegHUaTyKktPhF6jYnHoLouZhFk/Pb26d4Op6Z
         SuLg==
X-Gm-Message-State: AA+aEWbLp1MgGzSCGEaIDz4dxEPPY52KKjy22g4u+6gYP7fmpWThC+UU
        yrgq6NNN8vSYZ/MoWcASYDN2AA==
X-Google-Smtp-Source: AJdET5dtLLLBvbfp8KivpZ/dKjUqFaCQDGzjC3M5grJ9JkAKVcRNVQH4Uz2NzNvUKGiFA6gb/hNmFA==
X-Received: by 2002:a1c:c919:: with SMTP id f25mr1793283wmb.75.1542711318889;
        Tue, 20 Nov 2018 02:55:18 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:c511:7193:974b:48e6])
        by smtp.gmail.com with ESMTPSA id f192sm12170831wmd.12.2018.11.20.02.55.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Nov 2018 02:55:18 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, pjt@google.com,
        bsegall@google.com, thara.gopinath@linaro.org,
        pkondeti@codeaurora.org, quentin.perret@arm.com,
        srinivas.pandruvada@linux.intel.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v7 1/2] sched/fair: move rq_of helper function
Date:   Tue, 20 Nov 2018 11:55:07 +0100
Message-Id: <1542711308-25256-2-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542711308-25256-1-git-send-email-vincent.guittot@linaro.org>
References: <1542711308-25256-1-git-send-email-vincent.guittot@linaro.org>
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
index e30dea5..9cd1f32 100644
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
index e0e052a..67e2d56 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -930,6 +930,22 @@ struct rq {
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

