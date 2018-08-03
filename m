Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1387C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 11:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6783321707
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 11:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OE5ZPgbR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UgURt2fT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6783321707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbeHCM73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 08:59:29 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57858 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbeHCM71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 08:59:27 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6FB1B60B22; Fri,  3 Aug 2018 11:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533294218;
        bh=c+IM+STRfSG1SwRsEuJBwWeGjee4Q5OItKRpd4xqfQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OE5ZPgbRzPkgnGPJQbvu9Mmq6+2qL5XHpS5D5jLe+YOpq/gGRxq0dWTXlIZPToqTf
         XrxDeCylsrAQPtiOcGYi+y1ubF09Y+sXzEsnGeeci2+37WWGfrek0Y61AC1Z7sPlgH
         4Cc7btBX1gAaJk4HCJqG7qZ2hyuvSf9IUD8kII3Y=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 06515601A1;
        Fri,  3 Aug 2018 11:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533294217;
        bh=c+IM+STRfSG1SwRsEuJBwWeGjee4Q5OItKRpd4xqfQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UgURt2fTIv9YWZROHCfQPuqaLtdyXzlNfW1QTQJ6Enmky9JlOV5JBLo7h3fK04g0i
         2bvtZXwD/PQKRlrGotPB1QH8iRVzlukqUEt3kMnGXxaY8F22S6oCQ6RmB30lIFes+a
         wEMD8xz7h/GY5OkIc+pOtKI2YhaiQ0HuawxxZXQ4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 06515601A1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, mka@chromium.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, thierry.escande@linaro.org,
        rtatiya@codeaurora.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v14 3/7] Bluetooth: btqca: Redefine qca_uart_setup() to generic function.
Date:   Fri,  3 Aug 2018 16:31:27 +0530
Message-Id: <20180803110131.11090-4-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180803110131.11090-1-bgodavar@codeaurora.org>
References: <20180803110131.11090-1-bgodavar@codeaurora.org>
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
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/bluetooth/btqca.c   | 21 ++++++++-------------
 drivers/bluetooth/btqca.h   | 13 +++++++++++--
 drivers/bluetooth/hci_qca.c | 10 +++++++++-
 3 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index c5cf9cab438a..479179c54dcf 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -81,9 +81,13 @@ int qca_read_soc_version(struct hci_dev *hdev, u32 *soc_version)
 	 */
 	*soc_version = (le32_to_cpu(ver->soc_id) << 16) |
 			(le16_to_cpu(ver->rome_ver) & 0x0000ffff);
+	if (*soc_version == 0)
+		err = -EILSEQ;
 
 out:
 	kfree_skb(skb);
+	if (err)
+		bt_dev_err(hdev, "QCA Failed to get version (%d)", err);
 
 	return err;
 }
@@ -327,9 +331,9 @@ int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 }
 EXPORT_SYMBOL_GPL(qca_set_bdaddr_rome);
 
-int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate)
+int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
+		   enum qca_btsoc_type soc_type, u32 soc_ver)
 {
-	u32 rome_ver = 0;
 	struct rome_config config;
 	int err;
 
@@ -337,19 +341,10 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate)
 
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
@@ -359,7 +354,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate)
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
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

