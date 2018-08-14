Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE288C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 22:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F7F82170A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 22:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UxIhyTxw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F7F82170A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729972AbeHOBDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 21:03:47 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:50350 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727776AbeHOBDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 21:03:46 -0400
Received: by mail-it0-f66.google.com with SMTP id j81-v6so20664314ite.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 15:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n51nv7HwDkyeWHHsQ0Nv037MqvdoJ65KhHly2Ldym/Y=;
        b=UxIhyTxw92DOtIN8p6E3424O47ORqXDZodEsy1RhgIFb/26kg1HEtKrc0R6SBhCJ88
         KMKSofpmU3p+IWUoft+4FTqideD8//vuKceqjR9pf1c+Pn+SsPdjS6L59K9mEW8iqjny
         W5jiFs61RZCez6fNgIH2xCUdaFaWrL1SNWWfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n51nv7HwDkyeWHHsQ0Nv037MqvdoJ65KhHly2Ldym/Y=;
        b=iUqdnibClsPRovorA9PTjr0B8QZLVIfHScezntIgzTnwXxSaHhAtnKm9o1Yc+8tgqt
         NMJbI1kPV6j0APxEmEMWfvF2K+QDg2V4nHlk/+9G0RSqIndYEeVU0ECPHUBgzllNFhoV
         4biuXaNZm/197YaLun/QRUVSpK8vVnFFHPDqq0Rj/Yu3rvl8Nu4ATwiOpSLgeL5Ael+N
         2N/QasGP+Oaf4tYwbIPclg44Sn7h6eoxJiPrlD0jrPvnTN7a8DbyIFIPycHF8xavG6Du
         8yTmexvjO8IsYgaLX7F3Ov2reP+vVmsrQYsiaQLzoQIMEEKfyNddWwrt8KIvEuNNm5Ii
         UZPg==
X-Gm-Message-State: AOUpUlGUQ97H0wiPuGxXSh2aNREaHghT6mlmcqulTUyZ9q9zje38C0wK
        AF3EBMDgonxxZnuSuqHCNO7CKQ==
X-Google-Smtp-Source: AA+uWPxr+g4pSFkvTx2BWnW8vVksa4vBFz/w6tklU+ksxYS553VZEPNmyTHouM/UUxB+xi1mnyj+8g==
X-Received: by 2002:a24:e347:: with SMTP id d68-v6mr16873835ith.75.1534284870823;
        Tue, 14 Aug 2018 15:14:30 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id m1-v6sm7858231iok.81.2018.08.14.15.14.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 14 Aug 2018 15:14:29 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     alexander.shishkin@linux.intel.com, suzuki.poulose@arm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] coresight: etb10: Splitting function etb_enable()
Date:   Tue, 14 Aug 2018 16:14:26 -0600
Message-Id: <1534284866-2523-2-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534284866-2523-1-git-send-email-mathieu.poirier@linaro.org>
References: <1534284866-2523-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Up until now the relative simplicity of enabling the ETB made it
possible to accommodate processing for both sysFS and perf methods.
But work on claimtags and CPU-wide trace scenarios is adding some
complexity, making the current code messy and hard to maintain.

As such follow what has been done for ETF and ETR components and split
function etb_enable() so that processing for both API can be done
cleanly.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etb10.c | 73 +++++++++++++++++++--------
 1 file changed, 52 insertions(+), 21 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 69287163ce4e..08fa660098f8 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -134,7 +134,7 @@ static void etb_enable_hw(struct etb_drvdata *drvdata)
 	CS_LOCK(drvdata->base);
 }
 
-static int etb_enable(struct coresight_device *csdev, u32 mode, void *data)
+static int etb_enable_sysfs(struct coresight_device *csdev)
 {
 	int ret = 0;
 	unsigned long flags;
@@ -142,48 +142,79 @@ static int etb_enable(struct coresight_device *csdev, u32 mode, void *data)
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 
-	/*
-	 * When accessing from Perf, a HW buffer can be handled
-	 * by a single trace entity.  In sysFS mode many tracers
-	 * can be logging to the same HW buffer.
-	 */
+	/* Don't messup with perf sessions. */
 	if (drvdata->mode == CS_MODE_PERF) {
 		ret = -EBUSY;
 		goto out;
 	}
 
-	/* Don't let perf disturb sysFS sessions */
-	if (drvdata->mode == CS_MODE_SYSFS && mode == CS_MODE_PERF) {
-		ret = -EBUSY;
+	/* Nothing to do, the tracer is already enabled. */
+	if (drvdata->mode == CS_MODE_SYSFS)
 		goto out;
-	}
 
-	/* Nothing to do, the tracer is already enabled. */
-	if (drvdata->mode == CS_MODE_SYSFS && mode == CS_MODE_SYSFS)
+	drvdata->mode = CS_MODE_SYSFS;
+	etb_enable_hw(drvdata);
+
+out:
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	return ret;
+}
+
+static int etb_enable_perf(struct coresight_device *csdev, void *data)
+{
+	int ret = 0;
+	unsigned long flags;
+	struct etb_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	spin_lock_irqsave(&drvdata->spinlock, flags);
+
+	/* No need to continue if the component is already in use. */
+	if (drvdata->mode != CS_MODE_DISABLED) {
+		ret = -EBUSY;
 		goto out;
+	}
 
 	/*
 	 * We don't have an internal state to clean up if we fail to setup
 	 * the perf buffer. So we can perform the step before we turn the
 	 * ETB on and leave without cleaning up.
 	 */
-	if (mode == CS_MODE_PERF) {
-		ret = etb_set_buffer(csdev, (struct perf_output_handle *)data);
-		if (ret)
-			goto out;
-	}
+	ret = etb_set_buffer(csdev, (struct perf_output_handle *)data);
+	if (ret)
+		goto out;
 
-	drvdata->mode = mode;
+	drvdata->mode = CS_MODE_PERF;
 	etb_enable_hw(drvdata);
 
 out:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
-
-	if (!ret)
-		dev_dbg(drvdata->dev, "ETB enabled\n");
 	return ret;
 }
 
+static int etb_enable(struct coresight_device *csdev, u32 mode, void *data)
+{
+	int ret;
+	struct etb_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	switch (mode) {
+	case CS_MODE_SYSFS:
+		ret = etb_enable_sysfs(csdev);
+		break;
+	case CS_MODE_PERF:
+		ret = etb_enable_perf(csdev, data);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	if (ret)
+		return ret;
+
+	dev_dbg(drvdata->dev, "ETB enabled\n");
+	return 0;
+}
+
 static void etb_disable_hw(struct etb_drvdata *drvdata)
 {
 	u32 ffcr;
-- 
2.7.4

