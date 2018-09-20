Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F080AECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9953C21531
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="R9Ui3lgX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9953C21531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389030AbeIUBEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:04:10 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35754 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388559AbeIUBEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:04:08 -0400
Received: by mail-pl1-f195.google.com with SMTP id g2-v6so4798477plo.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 12:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sK0hfOiKmw/bseOl/rqlP9b/D7FoJ5EwQi5iLUrFTo4=;
        b=R9Ui3lgXrHXl+vt2ejeyCggPLRvm9yHS8FIW+pc5aSSSomHJwAdazsrfCdX3bstkOH
         ENEJZeSS3woDDyZ3pZXT++9Ufyuc+M+6xirKQ/c3kKXNFNj5rnbRD/lW5VRwqgmrvpat
         EdQcyUbyKZrYouADk8QSNyYTxIMTSU0A6sqW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sK0hfOiKmw/bseOl/rqlP9b/D7FoJ5EwQi5iLUrFTo4=;
        b=JHIxRg2ZKnWs+Dtfu3TmoKGNyAOn4mYvYFroBdcOjrjeW38ekq5ubSlYXYF4X5tUUz
         ej8dPYKtDPeNfOMqLQHOf/1/Y/UNwF+q9VPVmcYd2qjOcHepBBv/xGI9agznCvUC9d4L
         8yDF4viEo/Ks7K0fXf0iSczL5ZWJArpr65GLPEyYuYeOT6DZcMXqLJP/CQmEjwnbkViI
         YYGuDMOZlieS9xV42gpTKjj1LzCcw+nm6G01KZ6vOURqwV7+2V8EijKZ5ASnAIyAEtGv
         LrLY7XuXUVjzqfEeQ4L2E4nYEScpfKEQfZAR7cH/S+ZJN6mDN+qdfADJRjxg+8qY6iLU
         P6EQ==
X-Gm-Message-State: APzg51DMwlSVs8detEwIrZkXK7ixsxWrM06NytgHDeTUWDDbaxsh8zdR
        g8Bebcso9B2OBIP91XUFBPRskA==
X-Google-Smtp-Source: ANB0VdYzJtGjs70UzAQqzrm/HqXwhFvyl9EAwbLHU8HZBcuvzxYe2Ix+D5DJyRLYnX4TSg/7O5ho8w==
X-Received: by 2002:a17:902:864b:: with SMTP id y11-v6mr41064006plt.335.1537471149284;
        Thu, 20 Sep 2018 12:19:09 -0700 (PDT)
Received: from localhost.localdomain ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id k13-v6sm4424443pgf.37.2018.09.20.12.19.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Sep 2018 12:19:08 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 31/44] coresight: tmc-etb/etf: Prepare to handle errors enabling
Date:   Thu, 20 Sep 2018 13:18:06 -0600
Message-Id: <1537471099-19781-32-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
References: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Prepare to handle errors in enabling the hardware and
report it back to the core driver.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 73 +++++++++++++++----------
 1 file changed, 45 insertions(+), 28 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index b54a3db13fee..36af23d2c0f8 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -15,7 +15,7 @@
 static int tmc_set_etf_buffer(struct coresight_device *csdev,
 			      struct perf_output_handle *handle);
 
-static void tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
+static void __tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
 {
 	CS_UNLOCK(drvdata->base);
 
@@ -34,6 +34,12 @@ static void tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
 	CS_LOCK(drvdata->base);
 }
 
+static int tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
+{
+	__tmc_etb_enable_hw(drvdata);
+	return 0;
+}
+
 static void tmc_etb_dump_hw(struct tmc_drvdata *drvdata)
 {
 	char *bufp;
@@ -73,7 +79,7 @@ static void tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
 	CS_LOCK(drvdata->base);
 }
 
-static void tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
+static void __tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
 {
 	CS_UNLOCK(drvdata->base);
 
@@ -89,6 +95,12 @@ static void tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
 	CS_LOCK(drvdata->base);
 }
 
+static int tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
+{
+	__tmc_etf_enable_hw(drvdata);
+	return 0;
+}
+
 static void tmc_etf_disable_hw(struct tmc_drvdata *drvdata)
 {
 	CS_UNLOCK(drvdata->base);
@@ -171,8 +183,12 @@ static int tmc_enable_etf_sink_sysfs(struct coresight_device *csdev)
 		drvdata->buf = buf;
 	}
 
-	drvdata->mode = CS_MODE_SYSFS;
-	tmc_etb_enable_hw(drvdata);
+	ret = tmc_etb_enable_hw(drvdata);
+	if (!ret)
+		drvdata->mode = CS_MODE_SYSFS;
+	else
+		/* Free up the buffer if we failed to enable */
+		used = false;
 out:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
@@ -191,27 +207,25 @@ static int tmc_enable_etf_sink_perf(struct coresight_device *csdev, void *data)
 	struct perf_output_handle *handle = data;
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
-	if (drvdata->reading) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	/*
-	 * In Perf mode there can be only one writer per sink.  There
-	 * is also no need to continue if the ETB/ETR is already operated
-	 * from sysFS.
-	 */
-	if (drvdata->mode != CS_MODE_DISABLED) {
+	do {
 		ret = -EINVAL;
-		goto out;
-	}
+		if (drvdata->reading)
+			break;
+		/*
+		 * In Perf mode there can be only one writer per sink.  There
+		 * is also no need to continue if the ETB/ETF is already
+		 * operated from sysFS.
+		 */
+		if (drvdata->mode != CS_MODE_DISABLED)
+			break;
 
-	ret = tmc_set_etf_buffer(csdev, handle);
-	if (!ret) {
-		drvdata->mode = CS_MODE_PERF;
-		tmc_etb_enable_hw(drvdata);
-	}
-out:
+		ret = tmc_set_etf_buffer(csdev, handle);
+		if (ret)
+			break;
+		ret  = tmc_etb_enable_hw(drvdata);
+		if (!ret)
+			drvdata->mode = CS_MODE_PERF;
+	} while (0);
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	return ret;
@@ -268,6 +282,7 @@ static void tmc_disable_etf_sink(struct coresight_device *csdev)
 static int tmc_enable_etf_link(struct coresight_device *csdev,
 			       int inport, int outport)
 {
+	int ret;
 	unsigned long flags;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
@@ -277,12 +292,14 @@ static int tmc_enable_etf_link(struct coresight_device *csdev,
 		return -EBUSY;
 	}
 
-	tmc_etf_enable_hw(drvdata);
-	drvdata->mode = CS_MODE_SYSFS;
+	ret = tmc_etf_enable_hw(drvdata);
+	if (!ret)
+		drvdata->mode = CS_MODE_SYSFS;
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
-	dev_dbg(drvdata->dev, "TMC-ETF enabled\n");
-	return 0;
+	if (!ret)
+		dev_dbg(drvdata->dev, "TMC-ETF enabled\n");
+	return ret;
 }
 
 static void tmc_disable_etf_link(struct coresight_device *csdev,
@@ -576,7 +593,7 @@ int tmc_read_unprepare_etb(struct tmc_drvdata *drvdata)
 		 * can't be NULL.
 		 */
 		memset(drvdata->buf, 0, drvdata->size);
-		tmc_etb_enable_hw(drvdata);
+		__tmc_etb_enable_hw(drvdata);
 	} else {
 		/*
 		 * The ETB/ETF is not tracing and the buffer was just read.
-- 
2.7.4

