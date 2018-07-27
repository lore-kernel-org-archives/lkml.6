Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_NXDOMAIN,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA8FC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 855BC208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:34:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 855BC208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bgodavar-linux.qualcomm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732846AbeG0P4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 11:56:22 -0400
Received: from alexa-out-blr-02.qualcomm.com ([103.229.18.198]:57030 "EHLO
        alexa-out-blr.qualcomm.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730562AbeG0P4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 11:56:22 -0400
X-IronPort-AV: E=Sophos;i="5.51,409,1526322600"; 
   d="scan'208";a="115123"
Received: from ironmsg04-blr.qualcomm.com ([10.86.208.133])
  by alexa-out-blr.qualcomm.com with ESMTP/TLS/AES256-SHA; 27 Jul 2018 19:43:25 +0530
X-IronPort-AV: E=McAfee;i="5900,7806,8966"; a="828471"
Received: from bgodavar-linux.qualcomm.com ([10.206.64.85])
  by ironmsg04-blr.qualcomm.com with ESMTP; 27 Jul 2018 19:43:25 +0530
Received: by bgodavar-linux.qualcomm.com (Postfix, from userid 2304065)
        id 56C3D3C07; Fri, 27 Jul 2018 19:43:23 +0530 (IST)
From:   Balakrishna Godavarthi <bgodavar@bgodavar-linux.qualcomm.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, mka@chromium.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, thierry.escande@linaro.org,
        rtatiya@codeaurora.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v11 3/7] Bluetooth: btqca: Redefine qca_uart_setup() to generic function.
Date:   Fri, 27 Jul 2018 19:43:16 +0530
Message-Id: <20180727141320.25218-4-bgodavar@bgodavar-linux.qualcomm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180727141320.25218-1-bgodavar@bgodavar-linux.qualcomm.com>
References: <20180727141320.25218-1-bgodavar@bgodavar-linux.qualcomm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Balakrishna Godavarthi <bgodavar@codeaurora.org>

Redefinition of qca_uart_setup will help future Qualcomm Bluetooth
SoC, to use the same function instead of duplicating the function.
Added new arguments soc_type and soc_ver to the functions.

These arguments will help to decide type of firmware files
to be loaded into Bluetooth chip.
soc_type holds the Bluetooth chip connected to APPS processor.
soc_ver holds the Bluetooth chip version.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v11:
      * added error log in qca_read_soc_version() instead of qca_setup() 
---
 drivers/bluetooth/btqca.c   | 23 ++++++++++-------------
 drivers/bluetooth/btqca.h   | 13 +++++++++++--
 drivers/bluetooth/hci_qca.c | 10 +++++++++-
 3 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index c5cf9cab438a..b2163bf75b95 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -85,6 +85,12 @@ int qca_read_soc_version(struct hci_dev *hdev, u32 *soc_version)
 out:
 	kfree_skb(skb);
 
+	if (!err && *soc_version == 0)
+		err = -EILSEQ;
+
+	if (err)
+		bt_dev_err(hdev, "QCA Failed to get version (%d)", err);
+
 	return err;
 }
 EXPORT_SYMBOL_GPL(qca_read_soc_version);
@@ -327,9 +333,9 @@ int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 }
 EXPORT_SYMBOL_GPL(qca_set_bdaddr_rome);
 
-int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate)
+int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
+		   enum qca_btsoc_type soc_type, u32 soc_ver)
 {
-	u32 rome_ver = 0;
 	struct rome_config config;
 	int err;
 
@@ -337,19 +343,10 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate)
 
 	config.user_baud_rate = baudrate;
 
-	/* Get QCA version information */
-	err = qca_read_soc_version(hdev, &rome_ver);
-	if (err < 0 || rome_ver == 0) {
-		bt_dev_err(hdev, "QCA Failed to get version %d", err);
-		return err;
-	}
-
-	bt_dev_info(hdev, "QCA controller version 0x%08x", rome_ver);
-
 	/* Download rampatch file */
 	config.type = TLV_TYPE_PATCH;
 	snprintf(config.fwname, sizeof(config.fwname), "qca/rampatch_%08x.bin",
-		 rome_ver);
+		 soc_ver);
 	err = qca_download_firmware(hdev, &config);
 	if (err < 0) {
 		bt_dev_err(hdev, "QCA Failed to download patch (%d)", err);
@@ -359,7 +356,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate)
 	/* Download NVM configuration */
 	config.type = TLV_TYPE_NVM;
 	snprintf(config.fwname, sizeof(config.fwname), "qca/nvm_%08x.bin",
-		 rome_ver);
+		 soc_ver);
 	err = qca_download_firmware(hdev, &config);
 	if (err < 0) {
 		bt_dev_err(hdev, "QCA Failed to download NVM (%d)", err);
diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
index 5c9851b11838..a9c2779f3e07 100644
--- a/drivers/bluetooth/btqca.h
+++ b/drivers/bluetooth/btqca.h
@@ -124,10 +124,18 @@ struct tlv_type_hdr {
 	__u8   data[0];
 } __packed;
 
+enum qca_btsoc_type {
+	QCA_INVALID = -1,
+	QCA_AR3002,
+	QCA_ROME,
+	QCA_WCN3990
+};
+
 #if IS_ENABLED(CONFIG_BT_QCA)
 
 int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr);
-int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate);
+int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
+		   enum qca_btsoc_type soc_type, u32 soc_ver);
 int qca_read_soc_version(struct hci_dev *hdev, u32 *soc_version);
 
 #else
@@ -137,7 +145,8 @@ static inline int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdad
 	return -EOPNOTSUPP;
 }
 
-static inline int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate)
+static inline int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
+				 enum qca_btsoc_type soc_type, u32 soc_ver)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index d7b60669b656..5f1c0a8fd5cd 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -929,6 +929,7 @@ static int qca_setup(struct hci_uart *hu)
 	struct qca_data *qca = hu->priv;
 	unsigned int speed, qca_baudrate = QCA_BAUDRATE_115200;
 	int ret;
+	int soc_ver = 0;
 
 	bt_dev_info(hdev, "ROME setup");
 
@@ -965,8 +966,15 @@ static int qca_setup(struct hci_uart *hu)
 		host_set_baudrate(hu, speed);
 	}
 
+	/* Get QCA version information */
+	ret = qca_read_soc_version(hdev, &soc_ver);
+	if (ret)
+		return ret;
+
+	bt_dev_info(hdev, "QCA controller version 0x%08x", soc_ver);
+
 	/* Setup patch / NVM configurations */
-	ret = qca_uart_setup(hdev, qca_baudrate);
+	ret = qca_uart_setup(hdev, qca_baudrate, QCA_ROME, soc_ver);
 	if (!ret) {
 		set_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
 		qca_debugfs_init(hdev);
-- 
2.17.1

