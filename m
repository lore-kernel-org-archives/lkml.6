Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857C0C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 482E12098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:36:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 482E12098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbeJCOXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 10:23:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56136 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbeJCOXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 10:23:15 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1g7bhR-00088O-Sf; Wed, 03 Oct 2018 07:36:02 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: [RESEND] [PATCH 1/3] Bluetooth: btintel: Add firmware lock function
Date:   Wed,  3 Oct 2018 15:35:54 +0800
Message-Id: <20181003073556.28154-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When Intel 8260 starts to load Bluetooth firmware and WiFi firmware, by
calling btintel_download_firmware() and iwl_pcie_load_given_ucode_8000()
respectively, the Bluetooth btintel_download_firmware() aborts half way:
[   11.950216] Bluetooth: hci0: Failed to send firmware data (-38)

Let btusb and iwlwifi load firmwares exclusively can avoid the issue, so
introduce a lock to use in btusb and iwlwifi.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/bluetooth/btintel.c   | 14 ++++++++++++++
 drivers/bluetooth/btintel.h   | 10 ++++++++++
 include/linux/intel-wifi-bt.h |  8 ++++++++
 3 files changed, 32 insertions(+)
 create mode 100644 include/linux/intel-wifi-bt.h

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 5270d5513201..2d2a983a6641 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -35,6 +35,8 @@
 
 #define BDADDR_INTEL (&(bdaddr_t) {{0x00, 0x8b, 0x9e, 0x19, 0x03, 0x00}})
 
+static DEFINE_MUTEX(firmware_lock);
+
 int btintel_check_bdaddr(struct hci_dev *hdev)
 {
 	struct hci_rp_read_bd_addr *bda;
@@ -724,6 +726,18 @@ int btintel_download_firmware(struct hci_dev *hdev, const struct firmware *fw,
 }
 EXPORT_SYMBOL_GPL(btintel_download_firmware);
 
+void btintel_firmware_lock(void)
+{
+	mutex_lock(&firmware_lock);
+}
+EXPORT_SYMBOL_GPL(btintel_firmware_lock);
+
+void btintel_firmware_unlock(void)
+{
+	mutex_unlock(&firmware_lock);
+}
+EXPORT_SYMBOL_GPL(btintel_firmware_unlock);
+
 MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
 MODULE_DESCRIPTION("Bluetooth support for Intel devices ver " VERSION);
 MODULE_VERSION(VERSION);
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index 41c642cc523f..1373ffc2b575 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -102,6 +102,8 @@ int btintel_read_boot_params(struct hci_dev *hdev,
 			     struct intel_boot_params *params);
 int btintel_download_firmware(struct hci_dev *dev, const struct firmware *fw,
 			      u32 *boot_param);
+void btintel_firmware_lock(void);
+void btintel_firmware_unlock(void);
 #else
 
 static inline int btintel_check_bdaddr(struct hci_dev *hdev)
@@ -196,4 +198,12 @@ static inline int btintel_download_firmware(struct hci_dev *dev,
 {
 	return -EOPNOTSUPP;
 }
+
+static inline void btintel_firmware_lock(void)
+{
+}
+
+static inline void btintel_firmware_unlock(void)
+{
+}
 #endif
diff --git a/include/linux/intel-wifi-bt.h b/include/linux/intel-wifi-bt.h
new file mode 100644
index 000000000000..260ed628d19b
--- /dev/null
+++ b/include/linux/intel-wifi-bt.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __INTEL_WIFI_BT_H__
+#define __INTEL_WIFI_BT_H__
+
+void btintel_firmware_lock(void);
+void btintel_firmware_unlock(void);
+
+#endif
-- 
2.17.1

