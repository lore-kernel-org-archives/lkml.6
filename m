Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22283C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E648E218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbfAXPXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 10:23:22 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:57116 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbfAXPXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 10:23:20 -0500
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1gmgqc-0000k5-Df; Thu, 24 Jan 2019 15:23:18 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     drake@endlessm.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH 2/3] Bluetooth: btrtl: Let btrtl_initialize() always return error code
Date:   Thu, 24 Jan 2019 23:23:09 +0800
Message-Id: <20190124152310.29717-2-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190124152310.29717-1-kai.heng.feng@canonical.com>
References: <20190124152310.29717-1-kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

btrtl_initialize() may return an address or error code.

To make it more consistent, refactor btrtl_initialize() to always return
error code.

This requires "struct btrtl_device_info" to be allocated on stack. It's
a small structure, and simiar patterns can be found in other bluetooth
vendor helpers.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/bluetooth/btrtl.c  | 43 +++++++++++++-------------------------
 drivers/bluetooth/btrtl.h  |  5 +++--
 drivers/bluetooth/hci_h5.c | 16 ++++++--------
 3 files changed, 23 insertions(+), 41 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index a134a79bf0ef..c36f500d8313 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -516,10 +516,10 @@ void btrtl_free(struct btrtl_device_info *btrtl_dev)
 }
 EXPORT_SYMBOL_GPL(btrtl_free);
 
-struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
-					   const char *postfix)
+int btrtl_initialize(struct hci_dev *hdev,
+		     struct btrtl_device_info *btrtl_dev,
+		     const char *postfix)
 {
-	struct btrtl_device_info *btrtl_dev;
 	struct sk_buff *skb;
 	struct hci_rp_read_local_version *resp;
 	char cfg_name[40];
@@ -527,16 +527,9 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 	u8 hci_ver;
 	int ret;
 
-	btrtl_dev = kzalloc(sizeof(*btrtl_dev), GFP_KERNEL);
-	if (!btrtl_dev) {
-		ret = -ENOMEM;
-		goto err_alloc;
-	}
-
 	skb = btrtl_read_local_version(hdev);
 	if (IS_ERR(skb)) {
-		ret = PTR_ERR(skb);
-		goto err_free;
+		return PTR_ERR(skb);
 	}
 
 	resp = (struct hci_rp_read_local_version *)skb->data;
@@ -555,14 +548,13 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 	if (!btrtl_dev->ic_info) {
 		rtl_dev_err(hdev, "rtl: unknown IC info, lmp subver %04x, hci rev %04x, hci ver %04x",
 			    lmp_subver, hci_rev, hci_ver);
-		ret = -EINVAL;
-		goto err_free;
+		return -EINVAL;
 	}
 
 	if (btrtl_dev->ic_info->has_rom_version) {
 		ret = rtl_read_rom_version(hdev, &btrtl_dev->rom_version);
 		if (ret)
-			goto err_free;
+			return ret;
 	}
 
 	ret = rtl_load_file(hdev, btrtl_dev->ic_info->fw_name,
@@ -570,7 +562,7 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 	if (ret || !btrtl_dev->fw_len) {
 		rtl_dev_err(hdev, "firmware file %s not found\n",
 			    btrtl_dev->ic_info->fw_name);
-		goto err_free;
+		return -ENOENT;
 	}
 
 	if (btrtl_dev->ic_info->cfg_name) {
@@ -587,16 +579,11 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 		    (ret || !btrtl_dev->cfg_len)) {
 			rtl_dev_err(hdev, "mandatory config file %s not found\n",
 				    btrtl_dev->ic_info->cfg_name);
-			goto err_free;
+			return -ENOENT;
 		}
 	}
 
-	return btrtl_dev;
-
-err_free:
-	btrtl_free(btrtl_dev);
-err_alloc:
-	return ERR_PTR(ret);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(btrtl_initialize);
 
@@ -627,16 +614,14 @@ EXPORT_SYMBOL_GPL(btrtl_download_firmware);
 
 int btrtl_setup_realtek(struct hci_dev *hdev)
 {
-	struct btrtl_device_info *btrtl_dev;
+	struct btrtl_device_info btrtl_dev;
 	int ret;
 
-	btrtl_dev = btrtl_initialize(hdev, NULL);
-	if (IS_ERR(btrtl_dev))
-		return PTR_ERR(btrtl_dev);
-
-	ret = btrtl_download_firmware(hdev, btrtl_dev);
+	ret = btrtl_initialize(hdev, &btrtl_dev, NULL);
+	if (ret)
+		return ret;
 
-	btrtl_free(btrtl_dev);
+	ret = btrtl_download_firmware(hdev, &btrtl_dev);
 
 	return ret;
 }
diff --git a/drivers/bluetooth/btrtl.h b/drivers/bluetooth/btrtl.h
index f5e36f3993a8..df15480b7077 100644
--- a/drivers/bluetooth/btrtl.h
+++ b/drivers/bluetooth/btrtl.h
@@ -59,8 +59,9 @@ struct rtl_vendor_config {
 
 #if IS_ENABLED(CONFIG_BT_RTL)
 
-struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
-					   const char *postfix);
+int btrtl_initialize(struct hci_dev *hdev,
+		     struct btrtl_device_info *btrtl_dev,
+		     const char *postfix);
 void btrtl_free(struct btrtl_device_info *btrtl_dev);
 int btrtl_download_firmware(struct hci_dev *hdev,
 			    struct btrtl_device_info *btrtl_dev);
diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 069d1c8fde73..d1fb0a4d82ae 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -868,7 +868,7 @@ static int __maybe_unused h5_serdev_resume(struct device *dev)
 #ifdef CONFIG_BT_HCIUART_RTL
 static int h5_btrtl_setup(struct h5 *h5)
 {
-	struct btrtl_device_info *btrtl_dev;
+	struct btrtl_device_info btrtl_dev;
 	struct sk_buff *skb;
 	__le32 baudrate_data;
 	u32 device_baudrate;
@@ -876,23 +876,22 @@ static int h5_btrtl_setup(struct h5 *h5)
 	bool flow_control;
 	int err;
 
-	btrtl_dev = btrtl_initialize(h5->hu->hdev, h5->id);
-	if (IS_ERR(btrtl_dev))
-		return PTR_ERR(btrtl_dev);
+	err = btrtl_initialize(h5->hu->hdev, &btrtl_dev, h5->id);
+	if (err)
+		return err;
 
 	err = btrtl_get_uart_settings(h5->hu->hdev, btrtl_dev,
 				      &controller_baudrate, &device_baudrate,
 				      &flow_control);
 	if (err)
-		goto out_free;
+		return err;
 
 	baudrate_data = cpu_to_le32(device_baudrate);
 	skb = __hci_cmd_sync(h5->hu->hdev, 0xfc17, sizeof(baudrate_data),
 			     &baudrate_data, HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
 		rtl_dev_err(h5->hu->hdev, "set baud rate command failed\n");
-		err = PTR_ERR(skb);
-		goto out_free;
+		return PTR_ERR(skb);
 	} else {
 		kfree_skb(skb);
 	}
@@ -906,9 +905,6 @@ static int h5_btrtl_setup(struct h5 *h5)
 	/* Give the device some time before the hci-core sends it a reset */
 	usleep_range(10000, 20000);
 
-out_free:
-	btrtl_free(btrtl_dev);
-
 	return err;
 }
 
-- 
2.17.1

