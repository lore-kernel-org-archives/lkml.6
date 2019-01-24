Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBA6C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C75312184C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbfAXPXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 10:23:18 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:57110 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbfAXPXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 10:23:17 -0500
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1gmgqY-0000jG-DC; Thu, 24 Jan 2019 15:23:14 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     drake@endlessm.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH 1/3] Bluetooth: btrtl: Let rtl_load_file() always return error code
Date:   Thu, 24 Jan 2019 23:23:08 +0800
Message-Id: <20190124152310.29717-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of rtl_load_file() can be either firmware length or
error code.

For consistency, always return error code and pass firmware length via
another pointer.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/bluetooth/btrtl.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 41405de27d66..a134a79bf0ef 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -413,7 +413,8 @@ static int rtl_download_firmware(struct hci_dev *hdev,
 	return ret;
 }
 
-static int rtl_load_file(struct hci_dev *hdev, const char *name, u8 **buff)
+static int rtl_load_file(struct hci_dev *hdev, const char *name,
+			 u8 **buff, int *fw_size)
 {
 	const struct firmware *fw;
 	int ret;
@@ -422,8 +423,8 @@ static int rtl_load_file(struct hci_dev *hdev, const char *name, u8 **buff)
 	ret = request_firmware(&fw, name, &hdev->dev);
 	if (ret < 0)
 		return ret;
-	ret = fw->size;
-	*buff = kmemdup(fw->data, ret, GFP_KERNEL);
+	*fw_size = fw->size;
+	*buff = kmemdup(fw->data, fw->size, GFP_KERNEL);
 	if (!*buff)
 		ret = -ENOMEM;
 
@@ -564,12 +565,11 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 			goto err_free;
 	}
 
-	btrtl_dev->fw_len = rtl_load_file(hdev, btrtl_dev->ic_info->fw_name,
-					  &btrtl_dev->fw_data);
-	if (btrtl_dev->fw_len < 0) {
+	ret = rtl_load_file(hdev, btrtl_dev->ic_info->fw_name,
+			    &btrtl_dev->fw_data, &btrtl_dev->fw_len);
+	if (ret || !btrtl_dev->fw_len) {
 		rtl_dev_err(hdev, "firmware file %s not found\n",
 			    btrtl_dev->ic_info->fw_name);
-		ret = btrtl_dev->fw_len;
 		goto err_free;
 	}
 
@@ -581,13 +581,12 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 			snprintf(cfg_name, sizeof(cfg_name), "%s.bin",
 				 btrtl_dev->ic_info->cfg_name);
 		}
-		btrtl_dev->cfg_len = rtl_load_file(hdev, cfg_name,
-						   &btrtl_dev->cfg_data);
+		ret = rtl_load_file(hdev, cfg_name, &btrtl_dev->cfg_data,
+				    &btrtl_dev->cfg_len);
 		if (btrtl_dev->ic_info->config_needed &&
-		    btrtl_dev->cfg_len <= 0) {
+		    (ret || !btrtl_dev->cfg_len)) {
 			rtl_dev_err(hdev, "mandatory config file %s not found\n",
 				    btrtl_dev->ic_info->cfg_name);
-			ret = btrtl_dev->cfg_len;
 			goto err_free;
 		}
 	}
-- 
2.17.1

