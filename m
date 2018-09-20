Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFB5C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7952D21533
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WUQ0uZFc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7952D21533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389051AbeIUBEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:04:13 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41900 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388558AbeIUBEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:04:13 -0400
Received: by mail-pf1-f195.google.com with SMTP id h79-v6so4819552pfk.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 12:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uTB54otE2bw7+61Z1ydJwtI+Yieov8luc9OYgjIrcXA=;
        b=WUQ0uZFcXUG+ptQG1hM1mvLSSw8ztr5gWHMqB8hcRD8P2UN2i8ljbHdifLPfUBChp5
         OYMIAUQ6nHbBOe6fQErxDw2qMnTrmBpQe8ac91f0gLSP8yzo1fqMR/PWVExT5AiUATc5
         MMLM7rOh/njpIcjzGQ9rzlLD6lv6X7BVnGe70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uTB54otE2bw7+61Z1ydJwtI+Yieov8luc9OYgjIrcXA=;
        b=DtJ7zguf0Mgv5tiriMTriqOzhkK7FGxJEM6oIv74ueI6zADQzQI1rihkXHO82Qs9V1
         /uQN1w4ffmQzz8xKGjJlV45lsVcbYVWhgO/Dd1ztk+pZ+pZmxkvfA6u0100hUKBcmKD6
         E+Cbxfv8Crn6xcVy+V5wiZu1oIMhzsj+CKpX3Wj5Y8HONOzzRy1OdZiQFMd3KBs8pY1C
         xXNi6NEmQXxpyI2NfSrljSl1au2VqXWVAVMFmKVPvdwj3UsZCGOH/4ql6LhTdW9nqTmQ
         oDtlTx4tr0Uu6SOBDnggdVGooP3Qb7Roj/laNSXAlXejcWJzhBks/CYRBY+e7awtMfcr
         F1/Q==
X-Gm-Message-State: APzg51C7XPacmAuKznKspZaX+FC76kECieNfIXnDbWT03+/DbcyJ5xgG
        0EbSMH6rQDcuV6awQ7lP1M0BoblyrBU=
X-Google-Smtp-Source: ANB0VdYrie1VYx/tbqMBVC4A1Ecs3Z+E7/sprkJGRWEJuDiZUBbUmSi6GNR+4Xd2qcCGf6yahuFvOg==
X-Received: by 2002:a65:58c3:: with SMTP id e3-v6mr3248965pgu.117.1537471153782;
        Thu, 20 Sep 2018 12:19:13 -0700 (PDT)
Received: from localhost.localdomain ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id k13-v6sm4424443pgf.37.2018.09.20.12.19.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Sep 2018 12:19:12 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 34/44] coresight: etb10: Handle errors enabling the device
Date:   Thu, 20 Sep 2018 13:18:09 -0600
Message-Id: <1537471099-19781-35-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
References: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Prepare the etb10 driver to return errors in enabling
the device.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etb10.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 08fa660098f8..824be0c5f592 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -106,7 +106,7 @@ static unsigned int etb_get_buffer_depth(struct etb_drvdata *drvdata)
 	return depth;
 }
 
-static void etb_enable_hw(struct etb_drvdata *drvdata)
+static void __etb_enable_hw(struct etb_drvdata *drvdata)
 {
 	int i;
 	u32 depth;
@@ -134,6 +134,12 @@ static void etb_enable_hw(struct etb_drvdata *drvdata)
 	CS_LOCK(drvdata->base);
 }
 
+static int etb_enable_hw(struct etb_drvdata *drvdata)
+{
+	__etb_enable_hw(drvdata);
+	return 0;
+}
+
 static int etb_enable_sysfs(struct coresight_device *csdev)
 {
 	int ret = 0;
@@ -152,8 +158,9 @@ static int etb_enable_sysfs(struct coresight_device *csdev)
 	if (drvdata->mode == CS_MODE_SYSFS)
 		goto out;
 
-	drvdata->mode = CS_MODE_SYSFS;
-	etb_enable_hw(drvdata);
+	ret = etb_enable_hw(drvdata);
+	if (!ret)
+		drvdata->mode = CS_MODE_SYSFS;
 
 out:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
@@ -183,8 +190,9 @@ static int etb_enable_perf(struct coresight_device *csdev, void *data)
 	if (ret)
 		goto out;
 
-	drvdata->mode = CS_MODE_PERF;
-	etb_enable_hw(drvdata);
+	ret = etb_enable_hw(drvdata);
+	if (!ret)
+		drvdata->mode = CS_MODE_PERF;
 
 out:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
-- 
2.7.4

