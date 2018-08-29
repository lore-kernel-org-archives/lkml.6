Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A729C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9CBA2084D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mi9t2oiW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9CBA2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbeH2Mro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:47:44 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37862 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbeH2Mrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:47:43 -0400
Received: by mail-wm0-f68.google.com with SMTP id n11-v6so4631125wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 01:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Pgjijn2wJfRCQSPK4qbB6Q/VD+g2NrG2grPakxth6ik=;
        b=Mi9t2oiWma8sxufwofWXTTEb/ZBDvdwmVBsWCAX4R6J3Nx+B/uUjO2b/8bnhjcTk6e
         0BJYXPCl+4wawmyn7h0Zyn5FRgfxTY6Q5jY5AyFrVOeIBouWIDHH6KwhvLspvaxV9xkA
         qK2cewOm0svkwVBjxekZY3Gwh1/O8/cDgJ0Kk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Pgjijn2wJfRCQSPK4qbB6Q/VD+g2NrG2grPakxth6ik=;
        b=NaizvotX5tI0vgTSzFBGVYMP7rtMBeRq9YZqTklzhQkLTIolWgEusVtJNxOZo4PTXw
         kXzJOCE3KRT/fthnt5Rcgm/ae7aZhPMFTIMz/QL/dcV3CAkRCyWTuITnAnLDrlEkbGFI
         OmTwL/2R4WsBznuw9rDkwokltMn6KlV4v4X1ScXIPKOEDpa9jRqDoUsuMJW2mu1SrVkg
         s58wriMT9PiznFNem46UmK6dvsH3LEusy2TLzi/Z7WP8BfPiApNsBztFusKMFZOdFnSS
         ZoatvUNUEdWB6LZEVhwGFNDXlYi21l2Bzy/pafoDoLWgc0z5pmz260m9807cdtuuYWVo
         HT6w==
X-Gm-Message-State: APzg51DSSXr06SWAB8OMzvOdCS2KwuT6ds6k309+yaTeN+ZbM5sTdHnK
        hLkI7uT1FL+L+g3dEPAdBEhQQA==
X-Google-Smtp-Source: ANB0VdZQPMnmsQxwDR/utF1XRsUlZuEAvFjtxElpkvP4bbjg7VM0YmkyKNuCmuYlij+2t7B4O78UFg==
X-Received: by 2002:a1c:82c8:: with SMTP id e191-v6mr3398848wmd.35.1535532711135;
        Wed, 29 Aug 2018 01:51:51 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:4c23:4749:7ea6:c5af])
        by smtp.gmail.com with ESMTPSA id w15-v6sm4297890wrs.8.2018.08.29.01.51.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Aug 2018 01:51:50 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, kernellwp@gmail.com
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched/schedutil : optimize utilization scaling for guest kernel
Date:   Wed, 29 Aug 2018 10:51:42 +0200
Message-Id: <1535532702-3508-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Scaling the utilization of CPUs with irq util_avg in schedutil doesn't give
any benefit and just waste CPU cycles when irq time is not accounted but
only steal time.
Add an internal _scale_irq_capacity() for scale_rt_capacity but scale
cpu utilization in schedutil only if we are accounting irq time.

Suggested-by: Wanpeng Li <kernellwp@gmail.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c  |  2 +-
 kernel/sched/sched.h | 22 ++++++++++++++++++++--
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 309c93f..c1334be 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7501,7 +7501,7 @@ static unsigned long scale_rt_capacity(int cpu)
 
 	free = max - used;
 
-	return scale_irq_capacity(free, irq, max);
+	return _scale_irq_capacity(free, irq, max);
 }
 
 static void update_cpu_capacity(struct sched_domain *sd, int cpu)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4a2e8ca..1003d69 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2221,14 +2221,14 @@ static inline unsigned long cpu_util_irq(struct rq *rq)
 }
 
 static inline
-unsigned long scale_irq_capacity(unsigned long util, unsigned long irq, unsigned long max)
+unsigned long _scale_irq_capacity(unsigned long util, unsigned long irq, unsigned long max)
 {
 	util *= (max - irq);
 	util /= max;
 
 	return util;
-
 }
+
 #else
 static inline unsigned long cpu_util_irq(struct rq *rq)
 {
@@ -2236,8 +2236,26 @@ static inline unsigned long cpu_util_irq(struct rq *rq)
 }
 
 static inline
+unsigned long _scale_irq_capacity(unsigned long util, unsigned long irq, unsigned long max)
+{
+	return util;
+}
+#endif
+
+/*
+ * scale_irq_capacity is used by schedutil to scale utilization only when
+ * irq time is accounted. This scaling is not necessary when only virtual time
+ * is accounted as guest doesn't have access to frequency scaling.
+ */
+#ifdef CONFIG_IRQ_TIME_ACCOUNTING
+
+#define scale_irq_capacity _scale_irq_capacity
+
+#else
+static inline
 unsigned long scale_irq_capacity(unsigned long util, unsigned long irq, unsigned long max)
 {
 	return util;
 }
 #endif
+
-- 
2.7.4

