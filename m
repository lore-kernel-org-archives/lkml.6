Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9665EC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EB9121533
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jlBQ2yvr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EB9121533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389109AbeIUBEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:04:24 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45825 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388518AbeIUBEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:04:22 -0400
Received: by mail-pf1-f193.google.com with SMTP id i26-v6so4809671pfo.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 12:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jgeumEyt2vKhIehOlTB8fmQUshNYewxvGQGrAiDNIOo=;
        b=jlBQ2yvr+9fOsWy2m0iI8eo7JeQBNX0qSYDjwtmgE77fotnyIjyC/ni2u3D7iA4Yjx
         o0FHs9FUWNJfwbixWhLa91Z/XGLIr89wZrBOQWIGCqUQp9dbwvs1VlewteP/vLDf9EeG
         CIq/6BWEE1Wgem9APqhdVb1Fq3WWiFR0iiarU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jgeumEyt2vKhIehOlTB8fmQUshNYewxvGQGrAiDNIOo=;
        b=qIm5ymi5mYQYNXkw9IAAaliOqurAxp5lHESzUrO3nGKUTJgY6nip6VLAkf1QWCW8FW
         t6q3zoBxylwspzfB7VE1fdlbMe11K/5x/XGASMglJ10u7U7A8X78CVJ58wCUVRuJPiJD
         DN1m3vGSMgJaScfAYkUZKQenRTSL9gyu8eaxuhHfHjjs5RL5UCU3S6bPveNgf2B5pb9v
         tm1hNZoju5ex0rQ6Wpd2UtMkFQ+nf8L38xqp3bz1q+1Vhu6EAo32bmbbwG2jdmsSz7vu
         81GUG2yntAhgNbsaRi/uTY2EaNCKaY0ZeuhTDEUVZsGKHqWqv0x4AEC4xxgd+twJT4vu
         H6xA==
X-Gm-Message-State: APzg51CsIysm/NlTViZt3XzSQHRbd2FMLTHYms5nCxFZ+MFy64BJjK3I
        uzPVNz8Knin3A/utP7EWev3pXCKYxRk=
X-Google-Smtp-Source: ANB0Vda6AQKNJ01r2y/5vDPt2QfXK6vMIVZmgXh+3bM1OdmowCLjzeie2gNYTf7b01JIN0OH/kEs7A==
X-Received: by 2002:a62:6104:: with SMTP id v4-v6mr43176750pfb.122.1537471162782;
        Thu, 20 Sep 2018 12:19:22 -0700 (PDT)
Received: from localhost.localdomain ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id k13-v6sm4424443pgf.37.2018.09.20.12.19.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Sep 2018 12:19:21 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 40/44] coresight: dynamic-replicator: Claim device for use
Date:   Thu, 20 Sep 2018 13:18:15 -0600
Message-Id: <1537471099-19781-41-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
References: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Use CLAIM protocol to make sure the device is available for use.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../coresight/coresight-dynamic-replicator.c       | 23 +++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
index 97f4673452cb..299667b887fc 100644
--- a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
@@ -41,8 +41,11 @@ static void replicator_reset(struct replicator_state *drvdata)
 {
 	CS_UNLOCK(drvdata->base);
 
-	writel_relaxed(0xff, drvdata->base + REPLICATOR_IDFILTER0);
-	writel_relaxed(0xff, drvdata->base + REPLICATOR_IDFILTER1);
+	if (!coresight_claim_device_unlocked(drvdata->base)) {
+		writel_relaxed(0xff, drvdata->base + REPLICATOR_IDFILTER0);
+		writel_relaxed(0xff, drvdata->base + REPLICATOR_IDFILTER1);
+		coresight_disclaim_device_unlocked(drvdata->base);
+	}
 
 	CS_LOCK(drvdata->base);
 }
@@ -50,6 +53,7 @@ static void replicator_reset(struct replicator_state *drvdata)
 static int replicator_enable(struct coresight_device *csdev, int inport,
 			      int outport)
 {
+	int rc = 0;
 	u32 reg;
 	struct replicator_state *drvdata = dev_get_drvdata(csdev->dev.parent);
 
@@ -67,13 +71,19 @@ static int replicator_enable(struct coresight_device *csdev, int inport,
 
 	CS_UNLOCK(drvdata->base);
 
+	if ((readl_relaxed(drvdata->base + REPLICATOR_IDFILTER0) == 0xff) &&
+	    (readl_relaxed(drvdata->base + REPLICATOR_IDFILTER1) == 0xff))
+		rc = coresight_claim_device_unlocked(drvdata->base);
 
 	/* Ensure that the outport is enabled. */
-	writel_relaxed(0x00, drvdata->base + reg);
+	if (!rc) {
+		writel_relaxed(0x00, drvdata->base + reg);
+		dev_dbg(drvdata->dev, "REPLICATOR enabled\n");
+	}
+
 	CS_LOCK(drvdata->base);
 
-	dev_dbg(drvdata->dev, "REPLICATOR enabled\n");
-	return 0;
+	return rc;
 }
 
 static void replicator_disable(struct coresight_device *csdev, int inport,
@@ -99,6 +109,9 @@ static void replicator_disable(struct coresight_device *csdev, int inport,
 	/* disable the flow of ATB data through port */
 	writel_relaxed(0xff, drvdata->base + reg);
 
+	if ((readl_relaxed(drvdata->base + REPLICATOR_IDFILTER0) == 0xff) &&
+	    (readl_relaxed(drvdata->base + REPLICATOR_IDFILTER1) == 0xff))
+		coresight_disclaim_device_unlocked(drvdata->base);
 	CS_LOCK(drvdata->base);
 
 	dev_dbg(drvdata->dev, "REPLICATOR disabled\n");
-- 
2.7.4

