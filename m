Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AEBC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0159C208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:31:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0159C208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388768AbeG0Qx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 12:53:29 -0400
Received: from bran.ispras.ru ([83.149.199.196]:19366 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730771AbeG0Qx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 12:53:29 -0400
Received: from myklebust.intra.ispras.ru (unknown [10.10.2.207])
        by smtp.ispras.ru (Postfix) with ESMTP id 1FFAA203B2;
        Fri, 27 Jul 2018 18:31:02 +0300 (MSK)
From:   Anton Vasilyev <vasilyev@ispras.ru>
To:     Dave Airlie <airlied@redhat.com>
Cc:     Anton Vasilyev <vasilyev@ispras.ru>,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH] drm: qxl: Fix NULL pointer dereference at qxl_alloc_client_monitors_config
Date:   Fri, 27 Jul 2018 18:30:58 +0300
Message-Id: <20180727153058.23620-1-vasilyev@ispras.ru>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If qxl_alloc_client_monitors_config() fails to allocate
client_monitors_config then NULL pointer dereference occurs
in function qxl_display_copy_rom_client_monitors_config() after
qxl_alloc_client_monitors_config() call.

The patch adds return error from qxl_alloc_client_monitors_config()
and additional status for qxl_display_copy_rom_client_monitors_config
return value.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
---
Note: Is it correct that qxl_display_read_client_monitors_config() does not
return error in case of fail?
---
 drivers/gpu/drm/qxl/qxl_display.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 768207fbbae3..a59b2eca5f5b 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -37,7 +37,8 @@ static bool qxl_head_enabled(struct qxl_head *head)
 	return head->width && head->height;
 }
 
-static void qxl_alloc_client_monitors_config(struct qxl_device *qdev, unsigned count)
+static int qxl_alloc_client_monitors_config(struct qxl_device *qdev,
+		unsigned int count)
 {
 	if (qdev->client_monitors_config &&
 	    count > qdev->client_monitors_config->count) {
@@ -49,15 +50,17 @@ static void qxl_alloc_client_monitors_config(struct qxl_device *qdev, unsigned c
 				sizeof(struct qxl_monitors_config) +
 				sizeof(struct qxl_head) * count, GFP_KERNEL);
 		if (!qdev->client_monitors_config)
-			return;
+			return -ENOMEM;
 	}
 	qdev->client_monitors_config->count = count;
+	return 0;
 }
 
 enum {
 	MONITORS_CONFIG_MODIFIED,
 	MONITORS_CONFIG_UNCHANGED,
 	MONITORS_CONFIG_BAD_CRC,
+	MONITORS_CONFIG_ERROR,
 };
 
 static int qxl_display_copy_rom_client_monitors_config(struct qxl_device *qdev)
@@ -87,7 +90,10 @@ static int qxl_display_copy_rom_client_monitors_config(struct qxl_device *qdev)
 	      && (num_monitors != qdev->client_monitors_config->count)) {
 		status = MONITORS_CONFIG_MODIFIED;
 	}
-	qxl_alloc_client_monitors_config(qdev, num_monitors);
+	if (qxl_alloc_client_monitors_config(qdev, num_monitors)) {
+		status = MONITORS_CONFIG_ERROR;
+		return status;
+	}
 	/* we copy max from the client but it isn't used */
 	qdev->client_monitors_config->max_allowed =
 				qdev->monitors_config->max_allowed;
@@ -161,6 +167,10 @@ void qxl_display_read_client_monitors_config(struct qxl_device *qdev)
 			break;
 		udelay(5);
 	}
+	if (status == MONITORS_CONFIG_ERROR) {
+		DRM_DEBUG_KMS("ignoring client monitors config: error");
+		return;
+	}
 	if (status == MONITORS_CONFIG_BAD_CRC) {
 		DRM_DEBUG_KMS("ignoring client monitors config: bad crc");
 		return;
-- 
2.18.0

