Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF48C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67EFC20868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="i8F6CGCO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67EFC20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbeLAFxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 00:53:48 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44913 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbeLAFxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 00:53:23 -0500
Received: by mail-pg1-f196.google.com with SMTP id t13so2847591pgr.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 10:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OXwnhYG6hQi1Mbl3UXmr0yioawjZlr4QoOQbaBfX9RQ=;
        b=i8F6CGCOfAYjBRuRriccxKKihlxKdkJTiuAsuI6Rq1UYlMykqzsgSxTWcNZx/3bOHZ
         /1AgbfSqt6i639mZt5TdOoUi4CbHFTV6TpjFSNET1okOzpwje2RZCNlXpn2zcCpPOHX+
         R8BLpWofEXs+urLmVufc6Pa4eMSj0HY5czx08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OXwnhYG6hQi1Mbl3UXmr0yioawjZlr4QoOQbaBfX9RQ=;
        b=inxTgtk2/mTarJewI7RjWNw1KtTC7QAtGGIdzgnBxX5Ez0AL7lnbenEvvD6sC3Tt5k
         TaHjPJ84NOp8/g/AUEzrYHnG0Q+3PcG4gLEvNKAeUAVtOLrkKVslnxoQ0w8fP/cmINpz
         0BxleYG2IZs4Bh/FJkvsZVXUdxK7/883HHkk43YCSQWTqs0rBWkBDsn37WuRmqxPq2sT
         OcCow72X/pizmVZZcxToIJGS/uWn8Wf+3k8avl5rhnzACCoKJZ8asZj9vWsu3ox9a7Rx
         Nr5z6wwQcfPGvqiO6DL8dEHzovhwQ2Xdz/ndBjrUWeDEu4J/fS2wEV0lKuYsKAnLFFEp
         a09Q==
X-Gm-Message-State: AA+aEWbhEEHkrzfDU8pccDPJ9U7/nM4UMxqvyAaCDwTVIoei56LnU+V8
        i4NtyVsia9X1T2+P9hK1RBDU6ixGv1w=
X-Google-Smtp-Source: AFSGD/VE5EDFBI0bjI0ygEYfWERifZ67R/F6hxXNy/YWh0YkeVg1IRgMC1z0Jeq/xRXvQke1Fjsugg==
X-Received: by 2002:a63:e80e:: with SMTP id s14mr5726174pgh.30.1543603391042;
        Fri, 30 Nov 2018 10:43:11 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id l184sm12743147pfc.112.2018.11.30.10.43.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Nov 2018 10:43:10 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] coresight: etb10: Add support for CLAIM tag
Date:   Fri, 30 Nov 2018 11:43:03 -0700
Message-Id: <1543603387-32645-3-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543603387-32645-1-git-send-email-mathieu.poirier@linaro.org>
References: <1543603387-32645-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following in the footstep of what was done for other CoreSight devices,
add CLAIM tag support to ETB10 in order to synchronise access to the
HW between the kernel and an external agent.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etb10.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 824be0c5f592..105782ea64c7 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -136,6 +136,11 @@ static void __etb_enable_hw(struct etb_drvdata *drvdata)
 
 static int etb_enable_hw(struct etb_drvdata *drvdata)
 {
+	int rc = coresight_claim_device(drvdata->base);
+
+	if (rc)
+		return rc;
+
 	__etb_enable_hw(drvdata);
 	return 0;
 }
@@ -223,7 +228,7 @@ static int etb_enable(struct coresight_device *csdev, u32 mode, void *data)
 	return 0;
 }
 
-static void etb_disable_hw(struct etb_drvdata *drvdata)
+static void __etb_disable_hw(struct etb_drvdata *drvdata)
 {
 	u32 ffcr;
 
@@ -313,6 +318,13 @@ static void etb_dump_hw(struct etb_drvdata *drvdata)
 	CS_LOCK(drvdata->base);
 }
 
+static void etb_disable_hw(struct etb_drvdata *drvdata)
+{
+	__etb_disable_hw(drvdata);
+	etb_dump_hw(drvdata);
+	coresight_disclaim_device(drvdata->base);
+}
+
 static void etb_disable(struct coresight_device *csdev)
 {
 	struct etb_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
@@ -323,7 +335,6 @@ static void etb_disable(struct coresight_device *csdev)
 	/* Disable the ETB only if it needs to */
 	if (drvdata->mode != CS_MODE_DISABLED) {
 		etb_disable_hw(drvdata);
-		etb_dump_hw(drvdata);
 		drvdata->mode = CS_MODE_DISABLED;
 	}
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
@@ -402,7 +413,7 @@ static unsigned long etb_update_buffer(struct coresight_device *csdev,
 
 	capacity = drvdata->buffer_depth * ETB_FRAME_SIZE_WORDS;
 
-	etb_disable_hw(drvdata);
+	__etb_disable_hw(drvdata);
 	CS_UNLOCK(drvdata->base);
 
 	/* unit is in words, not bytes */
@@ -510,7 +521,7 @@ static unsigned long etb_update_buffer(struct coresight_device *csdev,
 		handle->head = (cur * PAGE_SIZE) + offset;
 		to_read = buf->nr_pages << PAGE_SHIFT;
 	}
-	etb_enable_hw(drvdata);
+	__etb_enable_hw(drvdata);
 	CS_LOCK(drvdata->base);
 
 	return to_read;
@@ -534,9 +545,9 @@ static void etb_dump(struct etb_drvdata *drvdata)
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 	if (drvdata->mode == CS_MODE_SYSFS) {
-		etb_disable_hw(drvdata);
+		__etb_disable_hw(drvdata);
 		etb_dump_hw(drvdata);
-		etb_enable_hw(drvdata);
+		__etb_enable_hw(drvdata);
 	}
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
-- 
2.7.4

