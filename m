Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC44C169C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 00:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAADD2073F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 00:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqCKR6Ou"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfBGANU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 19:13:20 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41842 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfBGANT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 19:13:19 -0500
Received: by mail-pf1-f196.google.com with SMTP id b7so3910898pfi.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 16:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=48Lg5cdIe9wRbTnv/tNdejkqN45TMVAk+WqGnyWGTjA=;
        b=HqCKR6OuBcQt97rlsYoAQcvEO7RRrWJcdoGLSBqM1fSolA8O19r91tORH0nIWQoQc5
         nTgeB2LDP/jhzUtZrSQBzUS6oVqWWJ9/02Pri1CpGMAO9NVvvqfQre3xc8w4Eh6KF1pj
         Q1l6LmgFj34P1XN8qSblJVSe+zptFrOpoyWYUEk0Z3Z5pGyDxDqxmVR+D0yXMMXn++hm
         HZNnPzvkzRoqTR11iDQYn0QOgEuvgATonUCFMmd0VXTthKGBu6kna79KpYhbT3mRUYLW
         4Bf7mncPiv9DzbQY2SRQ8IE01jBP9XNiIFzQHQU7r3tv0cCWxV2EDMif6HJaQXEJTCbs
         WqJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=48Lg5cdIe9wRbTnv/tNdejkqN45TMVAk+WqGnyWGTjA=;
        b=d34UiEELoRjzRMnPs2y8PnAm5pHiRvrS+aDL1s9OSCcxibxd9NyF8DCMpjHCf3DoA2
         0TUL8qsIDdejNL03wFbD+RWg7aqwufKmGhxVna+FhvsrQ8+5Orm7J+awL+kWpb+u5iSw
         i7ooA+HcgYOghObuyA9AuFX6UgzLP5bq0/WEyQPqPWT2urngQRnEMxwABjLo2/xmMdPd
         eNjMOgbwbFiyJbX5F0weygIq8y+4yt5vMk2NBe8mTcO48FBJOAbnv4w9QSKi5LeDnBhX
         WzfmC2IqJYWAQT095x5KjvGYdQ0AN0iRMv60mSbCNF68oYhHLnh4pNrm2MwR9E3PDG3x
         syAQ==
X-Gm-Message-State: AHQUAuZaj8mWwMq2W07jeFSZ94p+t39uI4gxMXTxSUQPbrIHWhoRxRwz
        H1gqPy0mRWuIMSktxTMrRIo=
X-Google-Smtp-Source: AHgI3IZPPSigw1TjlI3b2LqynBuNEQvZITJgdbJE9uG0tHKErmdtRl0F/p38eJPUpnYLcgOfoKzw+w==
X-Received: by 2002:a63:da18:: with SMTP id c24mr2384970pgh.318.1549498398589;
        Wed, 06 Feb 2019 16:13:18 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id z15sm10149790pgc.77.2019.02.06.16.13.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 16:13:17 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-nvme@lists.infradead.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-core: Share code between nvme_wait_ready() and nvme_shutdown_ctrl()
Date:   Wed,  6 Feb 2019 16:13:12 -0800
Message-Id: <20190207001312.13672-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code polling NVME_CSTS_SHST_CMPLT in nvme_shutdown_ctrl() is very
similar to polling loop in nvme_wait_ready(). Move shared polling loop
code into __nvme_wait_ready() and re-implement both
nvme_shutdown_ctrl() and nvme_wait_ready() on top of it to avoid code
repetition.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/nvme/host/core.c | 54 ++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b47c59f0cbd8..633fbc21425c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1797,28 +1797,41 @@ const struct block_device_operations nvme_ns_head_ops = {
 };
 #endif /* CONFIG_NVME_MULTIPATH */
 
-static int nvme_wait_ready(struct nvme_ctrl *ctrl, u64 cap, bool enabled)
+static int __nvme_wait_ready(struct nvme_ctrl *ctrl, u32 mask, u32 value,
+			     unsigned long timeout)
 {
-	unsigned long timeout =
-		((NVME_CAP_TIMEOUT(cap) + 1) * HZ / 2) + jiffies;
-	u32 csts, bit = enabled ? NVME_CSTS_RDY : 0;
+	u32 csts;
 	int ret;
 
 	while ((ret = ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts)) == 0) {
 		if (csts == ~0)
 			return -ENODEV;
-		if ((csts & NVME_CSTS_RDY) == bit)
+		if ((csts & mask) == value)
 			break;
 
 		msleep(100);
 		if (fatal_signal_pending(current))
 			return -EINTR;
-		if (time_after(jiffies, timeout)) {
-			dev_err(ctrl->device,
-				"Device not ready; aborting %s\n", enabled ?
-						"initialisation" : "reset");
-			return -ENODEV;
-		}
+		if (time_after(jiffies, timeout))
+			return -ETIMEDOUT;
+	}
+
+	return ret;
+}
+
+static int nvme_wait_ready(struct nvme_ctrl *ctrl, u64 cap, bool enabled)
+{
+	unsigned long timeout =
+		((NVME_CAP_TIMEOUT(cap) + 1) * HZ / 2) + jiffies;
+	u32 bit = enabled ? NVME_CSTS_RDY : 0;
+	int ret;
+
+	ret = __nvme_wait_ready(ctrl, NVME_CSTS_RDY, bit, timeout);
+	if (ret == -ETIMEDOUT) {
+		dev_err(ctrl->device,
+			"Device not ready; aborting %s\n", enabled ?
+			"initialisation" : "reset");
+		ret = -ENODEV;
 	}
 
 	return ret;
@@ -1883,7 +1896,6 @@ EXPORT_SYMBOL_GPL(nvme_enable_ctrl);
 int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl)
 {
 	unsigned long timeout = jiffies + (ctrl->shutdown_timeout * HZ);
-	u32 csts;
 	int ret;
 
 	ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
@@ -1893,18 +1905,12 @@ int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl)
 	if (ret)
 		return ret;
 
-	while ((ret = ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts)) == 0) {
-		if ((csts & NVME_CSTS_SHST_MASK) == NVME_CSTS_SHST_CMPLT)
-			break;
-
-		msleep(100);
-		if (fatal_signal_pending(current))
-			return -EINTR;
-		if (time_after(jiffies, timeout)) {
-			dev_err(ctrl->device,
-				"Device shutdown incomplete; abort shutdown\n");
-			return -ENODEV;
-		}
+	ret = __nvme_wait_ready(ctrl, NVME_CSTS_SHST_MASK,
+				NVME_CSTS_SHST_CMPLT, timeout);
+	if (ret == -ETIMEDOUT) {
+		dev_err(ctrl->device,
+			"Device shutdown incomplete; abort shutdown\n");
+		ret = -ENODEV;
 	}
 
 	return ret;
-- 
2.20.1

