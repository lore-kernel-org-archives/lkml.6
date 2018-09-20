Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8233C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A112221531
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PDw6ejHT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A112221531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389062AbeIUBER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:04:17 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37458 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388558AbeIUBEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:04:14 -0400
Received: by mail-pl1-f195.google.com with SMTP id q5-v6so1323463pli.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 12:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nThcwxyyvT+dxtp2XwfLgsk1SXb+AwYpYqhOiuz4UJY=;
        b=PDw6ejHT77dGv7IA9r4zrNG67uzeGLYsVDzLyJokTVXPGLah4uGW5mT+sCd1GZkaT5
         /jGWrMSGmZq+/yGcDkhCei5zkCZLG/ggfzC5XSBgD4XZXno9iHBMJ0iOu9uBS47Gymcl
         mtS6WIbkqyMFZi6Cd61bPQwAVs7xw+1kINvt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nThcwxyyvT+dxtp2XwfLgsk1SXb+AwYpYqhOiuz4UJY=;
        b=syIpdKBqF0cHoh8NesAc1tLxzUX4gPkwQxK7ca/y4QFsHqPeW5qvEI4lnlm1ev1wj6
         LbXY6JmU1khPlFIP+FQ3v8uz+tU/j9kBwVvqrr51UJS1ZH1eunQCdZSNj5N2D4NvsyVb
         IW/Jce8gW3EGXvVAbADQ8LgDYhkP4AxZefSedpxWyO2FGseOg4UiXRIX4bNVY1AYlgfO
         W4HzZhcC8X+Y5pvytgHkO7HiTvmRMf7wm/nSHCpzvmgeCk3PTnvha/Gd2a01FmAcyU7O
         qYvN+Xp7vqrsOzDgoMlpbu1Hn3zWLFeC0+nk+L6yOkUBOCDts1sDsi/apiQMgbBMq7ku
         Madw==
X-Gm-Message-State: APzg51ACjnVJHMVItVm4QbZh8G2uJGO3KYrugdv2XYjKsDiYUFHHflx7
        3lo3o1Hn5IOC3mqyqPhUZCXV2w==
X-Google-Smtp-Source: ANB0VdblrRZsbHE9fX0Ir+v6EMItePH4r34cFjQTCbapzA/mNaVqqriJ3mShgBK4vAJQTD+5UGV2hA==
X-Received: by 2002:a17:902:bd07:: with SMTP id p7-v6mr40068448pls.32.1537471155181;
        Thu, 20 Sep 2018 12:19:15 -0700 (PDT)
Received: from localhost.localdomain ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id k13-v6sm4424443pgf.37.2018.09.20.12.19.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Sep 2018 12:19:14 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 35/44] coresight: dynamic-replicator: Handle multiple connections
Date:   Thu, 20 Sep 2018 13:18:10 -0600
Message-Id: <1537471099-19781-36-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
References: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

When a replicator port is enabled, we block the traffic
on the other port and route all traffic to the new enabled
port. If there are two active trace sessions each targeting
the two different paths from the replicator, the second session
will disable the first session and route all the data to the
second path.
                    ETR
                 /
e.g, replicator
                 \
                    ETB

If CPU0 is operated in sysfs mode to ETR and CPU1 is operated
in perf mode to ETB, depending on the order in which the
replicator is enabled one device is blocked.

Ideally we need trace-id for the session to make the
right choice. That implies we need a trace-id allocation
logic for the coresight subsystem and use that to route
the traffic. The short term solution is to only manage
the "target port" and leave the other port untouched.
That leaves both the paths unaffected, except that some
unwanted traffic may be pushed to the paths (if the Trace-IDs
are not far enough), which is still fine and can be filtered
out while processing rather than silently blocking the data.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../coresight/coresight-dynamic-replicator.c       | 64 ++++++++++++++++------
 1 file changed, 47 insertions(+), 17 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
index ebb80438f6a5..97f4673452cb 100644
--- a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
@@ -34,26 +34,42 @@ struct replicator_state {
 	struct coresight_device	*csdev;
 };
 
+/*
+ * replicator_reset : Reset the replicator configuration to sane values.
+ */
+static void replicator_reset(struct replicator_state *drvdata)
+{
+	CS_UNLOCK(drvdata->base);
+
+	writel_relaxed(0xff, drvdata->base + REPLICATOR_IDFILTER0);
+	writel_relaxed(0xff, drvdata->base + REPLICATOR_IDFILTER1);
+
+	CS_LOCK(drvdata->base);
+}
+
 static int replicator_enable(struct coresight_device *csdev, int inport,
 			      int outport)
 {
+	u32 reg;
 	struct replicator_state *drvdata = dev_get_drvdata(csdev->dev.parent);
 
+	switch (outport) {
+	case 0:
+		reg = REPLICATOR_IDFILTER0;
+		break;
+	case 1:
+		reg = REPLICATOR_IDFILTER1;
+		break;
+	default:
+		WARN_ON(1);
+		return -EINVAL;
+	}
+
 	CS_UNLOCK(drvdata->base);
 
-	/*
-	 * Ensure that the other port is disabled
-	 * 0x00 - passing through the replicator unimpeded
-	 * 0xff - disable (or impede) the flow of ATB data
-	 */
-	if (outport == 0) {
-		writel_relaxed(0x00, drvdata->base + REPLICATOR_IDFILTER0);
-		writel_relaxed(0xff, drvdata->base + REPLICATOR_IDFILTER1);
-	} else {
-		writel_relaxed(0x00, drvdata->base + REPLICATOR_IDFILTER1);
-		writel_relaxed(0xff, drvdata->base + REPLICATOR_IDFILTER0);
-	}
 
+	/* Ensure that the outport is enabled. */
+	writel_relaxed(0x00, drvdata->base + reg);
 	CS_LOCK(drvdata->base);
 
 	dev_dbg(drvdata->dev, "REPLICATOR enabled\n");
@@ -63,15 +79,25 @@ static int replicator_enable(struct coresight_device *csdev, int inport,
 static void replicator_disable(struct coresight_device *csdev, int inport,
 				int outport)
 {
+	u32 reg;
 	struct replicator_state *drvdata = dev_get_drvdata(csdev->dev.parent);
 
+	switch (outport) {
+	case 0:
+		reg = REPLICATOR_IDFILTER0;
+		break;
+	case 1:
+		reg = REPLICATOR_IDFILTER1;
+		break;
+	default:
+		WARN_ON(1);
+		return;
+	}
+
 	CS_UNLOCK(drvdata->base);
 
 	/* disable the flow of ATB data through port */
-	if (outport == 0)
-		writel_relaxed(0xff, drvdata->base + REPLICATOR_IDFILTER0);
-	else
-		writel_relaxed(0xff, drvdata->base + REPLICATOR_IDFILTER1);
+	writel_relaxed(0xff, drvdata->base + reg);
 
 	CS_LOCK(drvdata->base);
 
@@ -156,7 +182,11 @@ static int replicator_probe(struct amba_device *adev, const struct amba_id *id)
 	desc.groups = replicator_groups;
 	drvdata->csdev = coresight_register(&desc);
 
-	return PTR_ERR_OR_ZERO(drvdata->csdev);
+	if (!IS_ERR(drvdata->csdev)) {
+		replicator_reset(drvdata);
+		return 0;
+	}
+	return PTR_ERR(drvdata->csdev);
 }
 
 #ifdef CONFIG_PM
-- 
2.7.4

