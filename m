Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA8FC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C4A6214C5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wf0ys7uZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C4A6214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbeJIXmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:42:53 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35852 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbeJIXmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:42:53 -0400
Received: by mail-qt1-f194.google.com with SMTP id u34-v6so2301477qth.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 09:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qbCXCRSOePNWlZULbLaHD5z+rbdqCdhX0BsGRnKqI98=;
        b=Wf0ys7uZUptTZHdHTnhf5tZpd1u4BVhNoa1dMrTUTehXQMI5widEclWXpmET2J/UUi
         ARuy7IAJwYHViB65i4fUg3atGzJCISXwL41NA69Ez8RJSEKWYZ2J4+dM0jo1Qve39upJ
         MpuyjDSN/TOVTQQ6IUmaj/c2KXnifFczKDCCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qbCXCRSOePNWlZULbLaHD5z+rbdqCdhX0BsGRnKqI98=;
        b=UhNNGhCfQrDgc73xJbzE5uiIyP6uAXQ6o+DWrbqvask8Q41MaTPt1Qf/pj9AZP+dsH
         DNu6DJGvqFjhLTkYoki13M+sS/xlnPQaSoK0brOrxOVKW6932Iyzo9lBtcoDsTL88aX4
         6gOoTeCi5onsQ9k4PT3+doyCnZVrSQkgoPNKB53cVLouuS5YI+KUweTmBJwFjoVCVJi1
         JpSIYzHEbZaDOwe8gl9TZD4pFO/stM2Rq3xHXAZvwfbrd3qR0EZQUxRJ/mKUKGfDzLLO
         0b3GZ9LPq6nmZJ4ZpP+Q/gixp0DvCeRbwCOAaZB4ql7MiL/KElNwrYQIHzdQi0YDhqIK
         GRBg==
X-Gm-Message-State: ABuFfoj1CZBOhggix3J4XwWCDO5/AwJMD5ejkxuOvVT7I4A/zRsJxTFc
        a9gkERqju8JA8swkFu7BQG7sD1Me42oPxQ==
X-Google-Smtp-Source: ACcGV61ySOJUEVwHniPNKYbI9/uqoPV3JwF7vNoBsqH4cV6gKAxWSel+VxBJUydaqXjXzo9BQ8iQMw==
X-Received: by 2002:a0c:d285:: with SMTP id q5mr6920778qvh.46.1539102308545;
        Tue, 09 Oct 2018 09:25:08 -0700 (PDT)
Received: from Thara-Work-Ubuntu.fios-router.home (pool-71-255-245-97.washdc.fios.verizon.net. [71.255.245.97])
        by smtp.googlemail.com with ESMTPSA id o7-v6sm10441169qkc.67.2018.10.09.09.25.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Oct 2018 09:25:07 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, rui.zhang@intel.com
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        amit.kachhap@gmail.com, viresh.kumar@linaro.org,
        javi.merino@kernel.org, edubezval@gmail.com,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        quentin.perret@arm.com, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org
Subject: [RFC PATCH 2/7] sched/pelt.c: Add support to track thermal pressure
Date:   Tue,  9 Oct 2018 12:24:57 -0400
Message-Id: <1539102302-9057-3-git-send-email-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
References: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extrapolating on the exisitng framework to track rt/dl utilization using
pelt signals, add a similar mechanism to track thermal pressue. The
difference here from rt/dl utilization tracking is that, instead of
tracking time spent by a cpu running a rt/dl task through util_avg,
the average thermal pressure is tracked through load_avg.
In order to track average thermal pressure, a new sched_avg variable
avg_thermal is introduced. Function update_thermal_avg can be called
to do the periodic bookeeping (accumulate, decay and average)
of the thermal pressure.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 kernel/sched/pelt.c  | 14 ++++++++++++++
 kernel/sched/pelt.h  |  7 +++++++
 kernel/sched/sched.h |  1 +
 3 files changed, 22 insertions(+)

diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 05b8798..7034ede 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -362,6 +362,20 @@ int update_dl_rq_load_avg(u64 now, struct rq *rq, int running)
 	return 0;
 }
 
+int update_thermal_avg(u64 now, struct rq *rq, u64 capacity)
+{
+	if (___update_load_sum(now, rq->cpu, &rq->avg_thermal,
+				capacity,
+				capacity,
+				capacity, 0)) {
+
+		___update_load_avg(&rq->avg_thermal, 1, 1);
+		return 1;
+	}
+
+	return 0;
+}
+
 #if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
 /*
  * irq:
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index d2894db..cc5a3ad 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -5,6 +5,7 @@ int __update_load_avg_se(u64 now, int cpu, struct cfs_rq *cfs_rq, struct sched_e
 int __update_load_avg_cfs_rq(u64 now, int cpu, struct cfs_rq *cfs_rq);
 int update_rt_rq_load_avg(u64 now, struct rq *rq, int running);
 int update_dl_rq_load_avg(u64 now, struct rq *rq, int running);
+int update_thermal_avg(u64 now, struct rq *rq, u64 capacity);
 
 #if defined(CONFIG_IRQ_TIME_ACCOUNTING) || defined(CONFIG_PARAVIRT_TIME_ACCOUNTING)
 int update_irq_load_avg(struct rq *rq, u64 running);
@@ -67,6 +68,12 @@ update_irq_load_avg(struct rq *rq, u64 running)
 {
 	return 0;
 }
+
+static inline int
+update_thermal_avg(u64 now, struct rq *rq, u64 capacity)
+{
+	return 0;
+}
 #endif
 
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4a2e8ca..30b40a5 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -859,6 +859,7 @@ struct rq {
 #define HAVE_SCHED_AVG_IRQ
 	struct sched_avg	avg_irq;
 #endif
+	struct sched_avg	avg_thermal;
 	u64			idle_stamp;
 	u64			avg_idle;
 
-- 
2.1.4

