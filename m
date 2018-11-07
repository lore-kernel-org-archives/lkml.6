Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08731C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 23:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C301E20882
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 23:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RepACDJG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C301E20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbeKHIlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 03:41:32 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35717 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727374AbeKHIlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 03:41:31 -0500
Received: by mail-pl1-f195.google.com with SMTP id n4-v6so8563323plp.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 15:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OXwnhYG6hQi1Mbl3UXmr0yioawjZlr4QoOQbaBfX9RQ=;
        b=RepACDJG8LAg/6Bu6ZjqlkO92o+E423fktjs656vjuS/l9NX0YyzirJkSwapvk1bRB
         3K7ftSYA7EtKXFa9SDMmk3kbxkgjSanXIhhmSrp8lUkNNQpoyZ1PemPHNxGdUvxityVE
         wyexUWhvZc8ne/ejzj/PfpYG/vXvLxKyf15Kk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OXwnhYG6hQi1Mbl3UXmr0yioawjZlr4QoOQbaBfX9RQ=;
        b=fb73fpylA8522bQX2QzgPuY/6eoQF8DHcSKqFRCLDpmC5+s20fJyE0Pk+vw+A22Svh
         +7X11wuF4h7CeLC6UxDU58umdbglFUb3YiQ+nDWMZA97WAaqFTJcpwpqxD6fUB31Jmra
         a7sL2nuY/hj8BJ9epwQhKtOnKL1+6YPloibUMTddlA0FgAZI2bKlarwWLKcGOm+XlhoU
         o1fnUFaNywp9DMLBXpsJYYUHMI1a8v0ipPBIr0AciuHPYXCO+jnXBmEcWjA9kOtO+yoe
         HqOojohlJJYG9E8YpeUnusWj60Ae7JXI2AuHEk/Org2teZabjp+syLZInPLba/SLtvpl
         IPig==
X-Gm-Message-State: AGRZ1gKImC76i3dii+QmAgJc1DpFledOF2mR86MREZEk+L1DjKUQkpOA
        5nSnvOCMG7zoy8gQYsVSHIgzvw==
X-Google-Smtp-Source: AJdET5cgWfHoVVCMTvCoFqg468pkwtSyxxcuxLajmQoGjepmMj1hI755gJToba0Tt9i0guUATgBBtA==
X-Received: by 2002:a17:902:110a:: with SMTP id d10-v6mr2228999pla.85.1541632136019;
        Wed, 07 Nov 2018 15:08:56 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id e70-v6sm1802034pfb.113.2018.11.07.15.08.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Nov 2018 15:08:55 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     alexander.shishkin@linux.intel.com, leo.yan@linaro.org,
        suzuki.poulose@arm.com, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] coresight: etb10: Add support for CLAIM tag
Date:   Wed,  7 Nov 2018 16:08:49 -0700
Message-Id: <1541632132-1252-2-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541632132-1252-1-git-send-email-mathieu.poirier@linaro.org>
References: <1541632132-1252-1-git-send-email-mathieu.poirier@linaro.org>
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

