Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CC4C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5EA624053
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Pm4LY5FO";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Pm4LY5FO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5EA624053
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753987AbeGEQzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:55:50 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49096 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754316AbeGEQzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:55:41 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BB56960B19; Thu,  5 Jul 2018 16:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530809740;
        bh=q6M+zS/XmBufHw2VnslcleSZRmobyI6FbMAK7IvhgCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pm4LY5FOvMWJh6Kp5GDIuCCQMfmyvhhybytSw5SVFGUQ8FuPX03bEPEAiUtT1VmNQ
         5WuU9qbdkPoxxfzu1G2GXJi5o3noIVHqhJOzFb0v0+QF8xPzgeCpOc1u/jCuSZGQOC
         ivqbx7Sc1Ad/Q40eJWvz2pjqyiCUP3TptoLxhgq4=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9B814607EB;
        Thu,  5 Jul 2018 16:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530809740;
        bh=q6M+zS/XmBufHw2VnslcleSZRmobyI6FbMAK7IvhgCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pm4LY5FOvMWJh6Kp5GDIuCCQMfmyvhhybytSw5SVFGUQ8FuPX03bEPEAiUtT1VmNQ
         5WuU9qbdkPoxxfzu1G2GXJi5o3noIVHqhJOzFb0v0+QF8xPzgeCpOc1u/jCuSZGQOC
         ivqbx7Sc1Ad/Q40eJWvz2pjqyiCUP3TptoLxhgq4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9B814607EB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, mka@chromium.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, thierry.escande@linaro.org,
        rtatiya@codeaurora.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v9 3/7] Bluetooth: btqca: Redefine qca_uart_setup() to generic function.
Date:   Thu,  5 Jul 2018 22:25:11 +0530
Message-Id: <20180705165515.13340-4-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180705165515.13340-1-bgodavar@codeaurora.org>
References: <20180705165515.13340-1-bgodavar@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Redefinition of qca_uart_setup will help future Qualcomm Bluetooth
SoC, to use the same function instead of duplicating the function.
Added new arguments soc_type and soc_ver to the functions.

These arguments will help to decide type of firmware files
to be loaded into Bluetooth chip.
soc_type holds the Bluetooth chip connected to APPS processor.
soc_ver holds the Bluetooth chip version.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---
Changes in v9:
   * moved qca_read_soc_ver() to qca_setup().

Changes in v8:
    * updated soc_type with enum.

Changes in v7:
    * initial patch
    * redefined qca_uart_setup function to generic.
---
 drivers/bluetooth/btqca.c   | 17 ++++-------------
 drivers/bluetooth/btqca.h   | 13 +++++++++++--
 drivers/bluetooth/hci_qca.c | 11 ++++++++++-
 3 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index c5cf9cab438a..03bcbaaf1ae9 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -327,9 +327,9 @@ int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 }
 EXPORT_SYMBOL_GPL(qca_set_bdaddr_rome);
 
-int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate)
+int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
+		   enum qca_btsoc_type soc_type, u32 soc_ver)
 {
-	u32 rome_ver = 0;
 	struct rome_config config;
 	int err;
 
@@ -337,19 +337,10 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate)
 
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
@@ -359,7 +350,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate)
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
index d7b60669b656..c02e1d465cca 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -929,6 +929,7 @@ static int qca_setup(struct hci_uart *hu)
 	struct qca_data *qca = hu->priv;
 	unsigned int speed, qca_baudrate = QCA_BAUDRATE_115200;
 	int ret;
+	int soc_ver = 0;
 
 	bt_dev_info(hdev, "ROME setup");
 
@@ -965,8 +966,16 @@ static int qca_setup(struct hci_uart *hu)
 		host_set_baudrate(hu, speed);
 	}
 
+	/* Get QCA version information */
+	ret = qca_read_soc_version(hdev, &soc_ver);
+	if (ret < 0 || soc_ver == 0) {
+		bt_dev_err(hdev, "QCA Failed to get version (%d)", ret);
+		return ret;
+	}
+	bt_dev_info(hdev, "QCA controller version 0x%08x", soc_ver);
+
 	/* Setup patch / NVM configurations */
-	ret = qca_uart_setup(hdev, qca_baudrate);
+	ret = qca_uart_setup(hdev, qca_baudrate, QCA_ROME, soc_ver);
 	if (!ret) {
 		set_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
 		qca_debugfs_init(hdev);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

