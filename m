Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E04C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 22:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D61F2170A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 22:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OxtBixD2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D61F2170A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbeHOBDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 21:03:44 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34983 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727776AbeHOBDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 21:03:44 -0400
Received: by mail-io0-f193.google.com with SMTP id w11-v6so19901652iob.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 15:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ESncSgmCF65uR5Mjzqxtn9ajR1WbAE7v81L5WJOABy4=;
        b=OxtBixD2V9Jhg1n9ecw1Y7QVjIWmmGreTDkvupfhpNRoc+efaai+HiU6drtKM71chZ
         3NDL7i0QCweE/pIyEUSw9NAfjim2gbChdgKBnX7LRnC0PCmsRe/+nVjAafBmTo0Z7U37
         kfrpOTO2lmqJw2VCn0sMpZAhFfIVe5oK5mtF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ESncSgmCF65uR5Mjzqxtn9ajR1WbAE7v81L5WJOABy4=;
        b=W+QVVXFewbiClYeopeVdaOwN0drtFCI8E6j+DSxM3z0CThMyHPTw0B7YwJdF8iZIgm
         /aB+dGthu1xuAmzVgcnvQIW4F9TaWisgkDJ2oimcET9gZEqeCVEYEs2yyRDDeEyux5up
         1MXCHXcpDKxMfBDi5/AUl8FlfafcSkptj+BBIZajBCD+zS7EvqKK1SI71+l+JzLH3McG
         XWXQpxM5WGn9LllbhAb2M83/fCHfd+O5WZuskkjeSSqzOeKKumPEqX+MOspiD0W89Zjp
         aX09X1FyuW7/rdywGj0Fpk9dpc5SXQfbGOuYCDlzFXRa/03vW2w1+oxl9n02GydGLJwj
         pFUA==
X-Gm-Message-State: AOUpUlHMONw57X0RHCeFrviB0Z4vnNwEeEP5NSgLEV4B/yA1UzonThGr
        YxnwUjaE52/DOGkp9MXYKms14D65S70=
X-Google-Smtp-Source: AA+uWPzjYF7lCvQUXAO9YsfTlFfp1s6vilLRmdQNXIIgOVuOd8pP6vGEEt1B1tTtGgxq14nHH4NRQg==
X-Received: by 2002:a6b:b010:: with SMTP id z16-v6mr19960214ioe.206.1534284869098;
        Tue, 14 Aug 2018 15:14:29 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id m1-v6sm7858231iok.81.2018.08.14.15.14.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 14 Aug 2018 15:14:28 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     alexander.shishkin@linux.intel.com, suzuki.poulose@arm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] coresight: etb10: Refactor etb_drvdata::mode handling
Date:   Tue, 14 Aug 2018 16:14:25 -0600
Message-Id: <1534284866-2523-1-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves the etb_drvdata::mode from a locat_t to a simple u32,
as it is for the ETF and ETR drivers.  This streamlines the code and adds
commonality with the other drivers when dealing with similar operations.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etb10.c | 62 +++++++++++++++------------
 1 file changed, 34 insertions(+), 28 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 9fd77fdc1244..69287163ce4e 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -5,7 +5,6 @@
  * Description: CoreSight Embedded Trace Buffer driver
  */
 
-#include <asm/local.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/types.h>
@@ -72,8 +71,8 @@
  * @miscdev:	specifics to handle "/dev/xyz.etb" entry.
  * @spinlock:	only one at a time pls.
  * @reading:	synchronise user space access to etb buffer.
- * @mode:	this ETB is being used.
  * @buf:	area of memory where ETB buffer content gets sent.
+ * @mode:	this ETB is being used.
  * @buffer_depth: size of @buf.
  * @trigger_cntr: amount of words to store after a trigger.
  */
@@ -85,8 +84,8 @@ struct etb_drvdata {
 	struct miscdevice	miscdev;
 	spinlock_t		spinlock;
 	local_t			reading;
-	local_t			mode;
 	u8			*buf;
+	u32			mode;
 	u32			buffer_depth;
 	u32			trigger_cntr;
 };
@@ -138,44 +137,48 @@ static void etb_enable_hw(struct etb_drvdata *drvdata)
 static int etb_enable(struct coresight_device *csdev, u32 mode, void *data)
 {
 	int ret = 0;
-	u32 val;
 	unsigned long flags;
 	struct etb_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
-	/*
-	 * We don't have an internal state to clean up if we fail to setup
-	 * the perf buffer. So we can perform the step before we turn the
-	 * ETB on and leave without cleaning up.
-	 */
-	if (mode == CS_MODE_PERF) {
-		ret = etb_set_buffer(csdev, (struct perf_output_handle *)data);
-		if (ret)
-			goto out;
-	}
+	spin_lock_irqsave(&drvdata->spinlock, flags);
 
-	val = local_cmpxchg(&drvdata->mode,
-			    CS_MODE_DISABLED, mode);
 	/*
 	 * When accessing from Perf, a HW buffer can be handled
 	 * by a single trace entity.  In sysFS mode many tracers
 	 * can be logging to the same HW buffer.
 	 */
-	if (val == CS_MODE_PERF)
-		return -EBUSY;
+	if (drvdata->mode == CS_MODE_PERF) {
+		ret = -EBUSY;
+		goto out;
+	}
 
 	/* Don't let perf disturb sysFS sessions */
-	if (val == CS_MODE_SYSFS && mode == CS_MODE_PERF)
-		return -EBUSY;
+	if (drvdata->mode == CS_MODE_SYSFS && mode == CS_MODE_PERF) {
+		ret = -EBUSY;
+		goto out;
+	}
 
 	/* Nothing to do, the tracer is already enabled. */
-	if (val == CS_MODE_SYSFS)
+	if (drvdata->mode == CS_MODE_SYSFS && mode == CS_MODE_SYSFS)
 		goto out;
 
-	spin_lock_irqsave(&drvdata->spinlock, flags);
+	/*
+	 * We don't have an internal state to clean up if we fail to setup
+	 * the perf buffer. So we can perform the step before we turn the
+	 * ETB on and leave without cleaning up.
+	 */
+	if (mode == CS_MODE_PERF) {
+		ret = etb_set_buffer(csdev, (struct perf_output_handle *)data);
+		if (ret)
+			goto out;
+	}
+
+	drvdata->mode = mode;
 	etb_enable_hw(drvdata);
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 out:
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+
 	if (!ret)
 		dev_dbg(drvdata->dev, "ETB enabled\n");
 	return ret;
@@ -277,11 +280,14 @@ static void etb_disable(struct coresight_device *csdev)
 	unsigned long flags;
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
-	etb_disable_hw(drvdata);
-	etb_dump_hw(drvdata);
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
-	local_set(&drvdata->mode, CS_MODE_DISABLED);
+	/* Disable the ETB only if it needs to */
+	if (drvdata->mode != CS_MODE_DISABLED) {
+		etb_disable_hw(drvdata);
+		etb_dump_hw(drvdata);
+		drvdata->mode = CS_MODE_DISABLED;
+	}
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	dev_dbg(drvdata->dev, "ETB disabled\n");
 }
@@ -488,7 +494,7 @@ static void etb_dump(struct etb_drvdata *drvdata)
 	unsigned long flags;
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
-	if (local_read(&drvdata->mode) == CS_MODE_SYSFS) {
+	if (drvdata->mode == CS_MODE_SYSFS) {
 		etb_disable_hw(drvdata);
 		etb_dump_hw(drvdata);
 		etb_enable_hw(drvdata);
-- 
2.7.4

