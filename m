Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F37ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD75221534
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cUFt+sLL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD75221534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388952AbeIUBD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:03:58 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:47007 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388926AbeIUBD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:03:57 -0400
Received: by mail-pf1-f196.google.com with SMTP id u24-v6so4806723pfn.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 12:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NWG9grRsxUmH4u+WMkh8hg9iSj2KGxYmj7m4vuDxpFE=;
        b=cUFt+sLLeLDzFjkfrELI2DxG3Ni+wGyqlJLpVTmiATnZmw4QiDHm2G0MpObVzvHwiu
         /4i7LjIA/354MOEs/ss6xE5EcPYKnL/96RIb09lZgBi7vKBBBGa+HMZW77SAq5iqGBTF
         ccsg3JVcdxaVy9fPBwOHbzZpmJhcioB68EtPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NWG9grRsxUmH4u+WMkh8hg9iSj2KGxYmj7m4vuDxpFE=;
        b=CBfw1jZKsJlK9oM48I8YlWbH7iJqO4LJEfEa1J4w3Qkh1ZxDgtEZ7dqdNDdY/HvMdx
         wBKZQoppwyOLXXu4JpzfBjN4SDHEaKCVTOFqIbAcDiu8TTOq1bHHxxlmTNXyWY9BapRN
         Q7wLGSU2PEvy2aepJf0stW0iqZt/c1vh31iTgSdzm89jHgm0h6pKHYTNylYuo8IJQ/jo
         PISANHuyxe4ewGne4c1ASAUJAWHzaTlwE8uD5oqvAIFOfUzgAKjQYZVcOHO6Vyqgqo9n
         HvEZdE8e02k4GBdZtPiog0WEHmUybuce54CWRj5NkE8j7xtGj3NgiXRyjs+MF+HpHhvK
         JDgQ==
X-Gm-Message-State: APzg51Ac5ukum9ZQRkIa4EY1cJGvgZF19j7/eX7eeHNMy63J68mqEHVm
        ve42OYcq3sBuGnx+TNk1aBMHeSG7u2c=
X-Google-Smtp-Source: ANB0VdYJGCnsujLhMrannvLJYTV8H21/Jhb7vi5Jzx7Ss1uMnSem8X6BPN1OhU9cGvu0ESF1mcyeYA==
X-Received: by 2002:a62:9101:: with SMTP id l1-v6mr42647547pfe.226.1537471138461;
        Thu, 20 Sep 2018 12:18:58 -0700 (PDT)
Received: from localhost.localdomain ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id k13-v6sm4424443pgf.37.2018.09.20.12.18.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Sep 2018 12:18:57 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 24/44] coresight: etb10: Splitting function etb_enable()
Date:   Thu, 20 Sep 2018 13:17:59 -0600
Message-Id: <1537471099-19781-25-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
References: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
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
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
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

