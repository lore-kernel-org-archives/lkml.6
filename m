Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C68C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 624EC20873
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z3/wDbhz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfANNqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 08:46:02 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42770 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfANNqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 08:46:00 -0500
Received: by mail-wr1-f66.google.com with SMTP id q18so22881838wrx.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 05:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zhJfSAlmB/SXCyVXDRxBFTU7e7uygGHPig+jgFbUKkI=;
        b=Z3/wDbhzhopFmyHNBAS1GSnVi/sNKVPlp0oNbYpPLEEL4VqHsy+5ZLBt6oDYjcSO4T
         fSSE2zHTTQQ5i0sIelPEi9Kt/qThgXItG1JoSdo3gDZqGmDhbfP4J2MMFDebFOUdkHFt
         0PH6bLo8xpAZlp4JFNkG55gMcPu3FtXIGRer0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zhJfSAlmB/SXCyVXDRxBFTU7e7uygGHPig+jgFbUKkI=;
        b=na6PqnEmuHXqvIO80XlBYKW67JTuyxm7xuyHpwhlz8trU6id3AUT/AdER5Zqqc7xOI
         r5JMeFCCvd0NmCBZR4c36NgTEiZfJF9HP9X33blnnaCVTkB0TtjwgstpTtwMfbfC43y1
         J218F1sITm4kCXbDb2O2yC75BsTjocPjHFrhOePn9V+56vfRDQiHtsHAhqWON7vmfRzr
         4pqgMkbkJlcX3thV3KumwYSPSvkglKnh29qEBIUecCpEJGNZIz07j5OTvZQGFEvsF+no
         UZbt/oC+H/1N/UhqUVfqVUAcVluiQ+b9kq7jYL2FwrPNd5Dhtsp042iBK1BK8R0gjUQy
         3bfw==
X-Gm-Message-State: AJcUukfWHeKRSQS0RhwjAGKDYVRCedFaZAvh2ES5gssVrbinHk5Gozy6
        60sR69RCFcTVUZC8FZ6plvsQCg==
X-Google-Smtp-Source: ALg8bN5IB0p3NXMh0MZIhvE5oOFk11LD0A8yEBKLDOoJcNBn079uF1rverXDFyN7EkSnLe1MzonW8A==
X-Received: by 2002:adf:b201:: with SMTP id u1mr24126617wra.165.1547473558066;
        Mon, 14 Jan 2019 05:45:58 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id x10sm86766472wrn.29.2019.01.14.05.45.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Jan 2019 05:45:57 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/4] slimbus: core: use slim_device_update_status() to update status
Date:   Mon, 14 Jan 2019 13:44:48 +0000
Message-Id: <20190114134449.15367-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190114134449.15367-1-srinivas.kandagatla@linaro.org>
References: <20190114134449.15367-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use slim_device_update_status() instead of directly calling
the device_status() callback. Move slim_device_update_status() before
probe to avoid forward declaration too.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/core.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
index 1ba08b5f2e78..8ffdc9876223 100644
--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -42,6 +42,23 @@ static int slim_device_match(struct device *dev, struct device_driver *drv)
 	return !!slim_match(sbdrv->id_table, sbdev);
 }
 
+static void slim_device_update_status(struct slim_device *sbdev,
+				      enum slim_device_status status)
+{
+	struct slim_driver *sbdrv;
+
+	if (sbdev->status == status)
+		return;
+
+	sbdev->status = status;
+	if (!sbdev->dev.driver)
+		return;
+
+	sbdrv = to_slim_driver(sbdev->dev.driver);
+	if (sbdrv->device_status)
+		sbdrv->device_status(sbdev, sbdev->status);
+}
+
 static int slim_device_probe(struct device *dev)
 {
 	struct slim_device	*sbdev = to_slim_device(dev);
@@ -55,8 +72,7 @@ static int slim_device_probe(struct device *dev)
 	/* try getting the logical address after probe */
 	ret = slim_get_logical_addr(sbdev);
 	if (!ret) {
-		if (sbdrv->device_status)
-			sbdrv->device_status(sbdev, sbdev->status);
+		slim_device_update_status(sbdev, SLIM_DEVICE_STATUS_UP);
 	} else {
 		dev_err(&sbdev->dev, "Failed to get logical address\n");
 		ret = -EPROBE_DEFER;
@@ -297,23 +313,6 @@ int slim_unregister_controller(struct slim_controller *ctrl)
 }
 EXPORT_SYMBOL_GPL(slim_unregister_controller);
 
-static void slim_device_update_status(struct slim_device *sbdev,
-				      enum slim_device_status status)
-{
-	struct slim_driver *sbdrv;
-
-	if (sbdev->status == status)
-		return;
-
-	sbdev->status = status;
-	if (!sbdev->dev.driver)
-		return;
-
-	sbdrv = to_slim_driver(sbdev->dev.driver);
-	if (sbdrv->device_status)
-		sbdrv->device_status(sbdev, sbdev->status);
-}
-
 /**
  * slim_report_absent() - Controller calls this function when a device
  *	reports absent, OR when the device cannot be communicated with
-- 
2.20.1

