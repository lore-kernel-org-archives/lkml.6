Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8D4C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D71B20825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ByL3KEha"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D71B20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388170AbeKFHsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 02:48:31 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33392 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbeKFHsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 02:48:30 -0500
Received: by mail-pg1-f195.google.com with SMTP id q5-v6so4874267pgv.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 14:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=czk6Nudv5RkepuEAFasNAuqyPXKfGg6GxLpRP0gwu+A=;
        b=ByL3KEhazCZAstZsXQIRX1ZKvzDtDRNwJt7TQWseIuPCLXrAslY0nHP5qe30hx6J5F
         GCqxfUN7Z6N7OJlLvMlpLG4wIZYMO08K/9dwiXCnA1KshkqQXwRi3toRIuoz6LcjQQ6A
         sJxaPSYfxHZ5uihMVRMe9VuY1eLaUksBjIw68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=czk6Nudv5RkepuEAFasNAuqyPXKfGg6GxLpRP0gwu+A=;
        b=E8Q5L4RNitPhZgvjztYNFcP1Gra/bq6sFMHF3NyyZRe3bl5JfIhEOsj8TjoqnD2+Rb
         v8PPUSxqb5kn5wIQN/u1PJ0J9UM+VT84L/m6vBpl6ea1TZxMDaAE+FyPcr1T0RHwsv7v
         KAzpiEDM2/rJTA4VEFUTHdZm/TEZ8s0FlJu/eCOkLTg8bd2qXTGem4fVcL7YneOpqnep
         qe2+yLmBRQGRFAHWIQ3NU8v9VMg0nUD+5SetXue4WqR87T8Rq6zjMeZ3AMzmF5dvinaA
         FaasctDmXJyV+PuAH2KMO4Mawn421BvtMocr2wRdWPPHOGnFej4+ucXRMDBFZep9/oA0
         CtYg==
X-Gm-Message-State: AGRZ1gLwjzFk+UJzItUg60dtbt3taHEZH0Wqp8WVhmEZ2YDpy5NkeRIM
        eFjMxlCXgVfCqWfa/r5Uuxj73w==
X-Google-Smtp-Source: AJdET5ea2SoYfQy6xIUSFfg3dCBPjq2aB9ooJSf22Mf+rD+bmumKJ2qJdXqDQqpKlDnAWUqOIKCAnQ==
X-Received: by 2002:a63:dd0a:: with SMTP id t10-v6mr21672846pgg.379.1541456795182;
        Mon, 05 Nov 2018 14:26:35 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id q26-v6sm58669804pfi.165.2018.11.05.14.26.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Nov 2018 14:26:34 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     alexander.shishkin@linux.intel.com, leo.yan@linaro.org,
        suzuki.poulose@arm.com, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] coresight: etb10: Add support for CLAIM tag
Date:   Mon,  5 Nov 2018 15:26:28 -0700
Message-Id: <1541456790-28282-2-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541456790-28282-1-git-send-email-mathieu.poirier@linaro.org>
References: <1541456790-28282-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following in the footstep of what was done for other CoreSight devices,
add CLAIM tag support to ETB10 in order to synchronise access to the
HW between the kernel and an external agent.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
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

