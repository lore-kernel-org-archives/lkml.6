Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_NXDOMAIN,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13D8C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5947A208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:34:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5947A208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bgodavar-linux.qualcomm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388581AbeG0P4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 11:56:46 -0400
Received: from alexa-out-blr-02.qualcomm.com ([103.229.18.198]:57041 "EHLO
        alexa-out-blr.qualcomm.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730562AbeG0P4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 11:56:46 -0400
X-IronPort-AV: E=Sophos;i="5.51,409,1526322600"; 
   d="scan'208";a="115125"
Received: from ironmsg04-blr.qualcomm.com ([10.86.208.133])
  by alexa-out-blr.qualcomm.com with ESMTP/TLS/AES256-SHA; 27 Jul 2018 19:43:25 +0530
X-IronPort-AV: E=McAfee;i="5900,7806,8966"; a="828472"
Received: from bgodavar-linux.qualcomm.com ([10.206.64.85])
  by ironmsg04-blr.qualcomm.com with ESMTP; 27 Jul 2018 19:43:25 +0530
Received: by bgodavar-linux.qualcomm.com (Postfix, from userid 2304065)
        id 927A53C25; Fri, 27 Jul 2018 19:43:23 +0530 (IST)
From:   Balakrishna Godavarthi <bgodavar@bgodavar-linux.qualcomm.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, mka@chromium.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, thierry.escande@linaro.org,
        rtatiya@codeaurora.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v11 2/7] Bluetooth: btqca: Rename ROME specific functions to generic functions
Date:   Fri, 27 Jul 2018 19:43:15 +0530
Message-Id: <20180727141320.25218-3-bgodavar@bgodavar-linux.qualcomm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180727141320.25218-1-bgodavar@bgodavar-linux.qualcomm.com>
References: <20180727141320.25218-1-bgodavar@bgodavar-linux.qualcomm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Balakrishna Godavarthi <bgodavar@codeaurora.org>

Some of the QCA BTSoC ROME functions, are used for different versions
or different make of BTSoC's. Instead of duplicating the same functions
for new chip, update names of the functions that are used for both
chips to keep this generic and would help in future when we would have
new BT SoC. To have generic text in logs updated from ROME to QCA where
ever possible. This avoids confusion to user, when using the future
Qualcomm Bluetooth SoC's. Updated BT_DBG, BT_ERR and BT_INFO with
bt_dev_dbg, bt_dev_err and bt_dev_info where ever applicable.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/bluetooth/btqca.c   | 85 ++++++++++++++++++-------------------
 drivers/bluetooth/btqca.h   | 10 ++++-
 drivers/bluetooth/hci_qca.c |  2 +-
 3 files changed, 51 insertions(+), 46 deletions(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 8219816c54a0..c5cf9cab438a 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -27,7 +27,7 @@
 
 #define VERSION "0.1"
 
-static int rome_patch_ver_req(struct hci_dev *hdev, u32 *rome_version)
+int qca_read_soc_version(struct hci_dev *hdev, u32 *soc_version)
 {
 	struct sk_buff *skb;
 	struct edl_event_hdr *edl;
@@ -35,36 +35,35 @@ static int rome_patch_ver_req(struct hci_dev *hdev, u32 *rome_version)
 	char cmd;
 	int err = 0;
 
-	BT_DBG("%s: ROME Patch Version Request", hdev->name);
+	bt_dev_dbg(hdev, "QCA Version Request");
 
 	cmd = EDL_PATCH_VER_REQ_CMD;
 	skb = __hci_cmd_sync_ev(hdev, EDL_PATCH_CMD_OPCODE, EDL_PATCH_CMD_LEN,
 				&cmd, HCI_VENDOR_PKT, HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
 		err = PTR_ERR(skb);
-		BT_ERR("%s: Failed to read version of ROME (%d)", hdev->name,
-		       err);
+		bt_dev_err(hdev, "Reading QCA version information failed (%d)",
+			   err);
 		return err;
 	}
 
 	if (skb->len != sizeof(*edl) + sizeof(*ver)) {
-		BT_ERR("%s: Version size mismatch len %d", hdev->name,
-		       skb->len);
+		bt_dev_err(hdev, "QCA Version size mismatch len %d", skb->len);
 		err = -EILSEQ;
 		goto out;
 	}
 
 	edl = (struct edl_event_hdr *)(skb->data);
 	if (!edl) {
-		BT_ERR("%s: TLV with no header", hdev->name);
+		bt_dev_err(hdev, "QCA TLV with no header");
 		err = -EILSEQ;
 		goto out;
 	}
 
 	if (edl->cresp != EDL_CMD_REQ_RES_EVT ||
 	    edl->rtype != EDL_APP_VER_RES_EVT) {
-		BT_ERR("%s: Wrong packet received %d %d", hdev->name,
-		       edl->cresp, edl->rtype);
+		bt_dev_err(hdev, "QCA Wrong packet received %d %d", edl->cresp,
+			   edl->rtype);
 		err = -EIO;
 		goto out;
 	}
@@ -76,11 +75,11 @@ static int rome_patch_ver_req(struct hci_dev *hdev, u32 *rome_version)
 	BT_DBG("%s: ROM    :0x%08x", hdev->name, le16_to_cpu(ver->rome_ver));
 	BT_DBG("%s: SOC    :0x%08x", hdev->name, le32_to_cpu(ver->soc_id));
 
-	/* ROME chipset version can be decided by patch and SoC
+	/* QCA chipset version can be decided by patch and SoC
 	 * version, combination with upper 2 bytes from SoC
 	 * and lower 2 bytes from patch will be used.
 	 */
-	*rome_version = (le32_to_cpu(ver->soc_id) << 16) |
+	*soc_version = (le32_to_cpu(ver->soc_id) << 16) |
 			(le16_to_cpu(ver->rome_ver) & 0x0000ffff);
 
 out:
@@ -88,18 +87,19 @@ static int rome_patch_ver_req(struct hci_dev *hdev, u32 *rome_version)
 
 	return err;
 }
+EXPORT_SYMBOL_GPL(qca_read_soc_version);
 
-static int rome_reset(struct hci_dev *hdev)
+static int qca_send_reset(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
 	int err;
 
-	BT_DBG("%s: ROME HCI_RESET", hdev->name);
+	bt_dev_dbg(hdev, "QCA HCI_RESET");
 
 	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
 		err = PTR_ERR(skb);
-		BT_ERR("%s: Reset failed (%d)", hdev->name, err);
+		bt_dev_err(hdev, "QCA Reset failed (%d)", err);
 		return err;
 	}
 
@@ -108,7 +108,7 @@ static int rome_reset(struct hci_dev *hdev)
 	return 0;
 }
 
-static void rome_tlv_check_data(struct rome_config *config,
+static void qca_tlv_check_data(struct rome_config *config,
 				const struct firmware *fw)
 {
 	const u8 *data;
@@ -207,7 +207,7 @@ static void rome_tlv_check_data(struct rome_config *config,
 	}
 }
 
-static int rome_tlv_send_segment(struct hci_dev *hdev, int seg_size,
+static int qca_tlv_send_segment(struct hci_dev *hdev, int seg_size,
 				 const u8 *data, enum rome_tlv_dnld_mode mode)
 {
 	struct sk_buff *skb;
@@ -228,19 +228,19 @@ static int rome_tlv_send_segment(struct hci_dev *hdev, int seg_size,
 				HCI_VENDOR_PKT, HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
 		err = PTR_ERR(skb);
-		BT_ERR("%s: Failed to send TLV segment (%d)", hdev->name, err);
+		bt_dev_err(hdev, "QCA Failed to send TLV segment (%d)", err);
 		return err;
 	}
 
 	if (skb->len != sizeof(*edl) + sizeof(*tlv_resp)) {
-		BT_ERR("%s: TLV response size mismatch", hdev->name);
+		bt_dev_err(hdev, "QCA TLV response size mismatch");
 		err = -EILSEQ;
 		goto out;
 	}
 
 	edl = (struct edl_event_hdr *)(skb->data);
 	if (!edl) {
-		BT_ERR("%s: TLV with no header", hdev->name);
+		bt_dev_err(hdev, "TLV with no header");
 		err = -EILSEQ;
 		goto out;
 	}
@@ -249,8 +249,8 @@ static int rome_tlv_send_segment(struct hci_dev *hdev, int seg_size,
 
 	if (edl->cresp != EDL_CMD_REQ_RES_EVT ||
 	    edl->rtype != EDL_TVL_DNLD_RES_EVT || tlv_resp->result != 0x00) {
-		BT_ERR("%s: TLV with error stat 0x%x rtype 0x%x (0x%x)",
-		       hdev->name, edl->cresp, edl->rtype, tlv_resp->result);
+		bt_dev_err(hdev, "QCA TLV with error stat 0x%x rtype 0x%x (0x%x)",
+			   edl->cresp, edl->rtype, tlv_resp->result);
 		err = -EIO;
 	}
 
@@ -260,23 +260,23 @@ static int rome_tlv_send_segment(struct hci_dev *hdev, int seg_size,
 	return err;
 }
 
-static int rome_download_firmware(struct hci_dev *hdev,
+static int qca_download_firmware(struct hci_dev *hdev,
 				  struct rome_config *config)
 {
 	const struct firmware *fw;
 	const u8 *segment;
 	int ret, remain, i = 0;
 
-	bt_dev_info(hdev, "ROME Downloading %s", config->fwname);
+	bt_dev_info(hdev, "QCA Downloading %s", config->fwname);
 
 	ret = request_firmware(&fw, config->fwname, &hdev->dev);
 	if (ret) {
-		BT_ERR("%s: Failed to request file: %s (%d)", hdev->name,
-		       config->fwname, ret);
+		bt_dev_err(hdev, "QCA Failed to request file: %s (%d)",
+			   config->fwname, ret);
 		return ret;
 	}
 
-	rome_tlv_check_data(config, fw);
+	qca_tlv_check_data(config, fw);
 
 	segment = fw->data;
 	remain = fw->size;
@@ -290,7 +290,7 @@ static int rome_download_firmware(struct hci_dev *hdev,
 		if (!remain || segsize < MAX_SIZE_PER_TLV_SEGMENT)
 			config->dnld_mode = ROME_SKIP_EVT_NONE;
 
-		ret = rome_tlv_send_segment(hdev, segsize, segment,
+		ret = qca_tlv_send_segment(hdev, segsize, segment,
 					    config->dnld_mode);
 		if (ret)
 			break;
@@ -317,8 +317,7 @@ int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 				HCI_VENDOR_PKT, HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
 		err = PTR_ERR(skb);
-		BT_ERR("%s: Change address command failed (%d)",
-		       hdev->name, err);
+		bt_dev_err(hdev, "QCA Change address command failed (%d)", err);
 		return err;
 	}
 
@@ -328,32 +327,32 @@ int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 }
 EXPORT_SYMBOL_GPL(qca_set_bdaddr_rome);
 
-int qca_uart_setup_rome(struct hci_dev *hdev, uint8_t baudrate)
+int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate)
 {
 	u32 rome_ver = 0;
 	struct rome_config config;
 	int err;
 
-	BT_DBG("%s: ROME setup on UART", hdev->name);
+	bt_dev_dbg(hdev, "QCA setup on UART");
 
 	config.user_baud_rate = baudrate;
 
-	/* Get ROME version information */
-	err = rome_patch_ver_req(hdev, &rome_ver);
+	/* Get QCA version information */
+	err = qca_read_soc_version(hdev, &rome_ver);
 	if (err < 0 || rome_ver == 0) {
-		BT_ERR("%s: Failed to get version 0x%x", hdev->name, err);
+		bt_dev_err(hdev, "QCA Failed to get version %d", err);
 		return err;
 	}
 
-	bt_dev_info(hdev, "ROME controller version 0x%08x", rome_ver);
+	bt_dev_info(hdev, "QCA controller version 0x%08x", rome_ver);
 
 	/* Download rampatch file */
 	config.type = TLV_TYPE_PATCH;
 	snprintf(config.fwname, sizeof(config.fwname), "qca/rampatch_%08x.bin",
 		 rome_ver);
-	err = rome_download_firmware(hdev, &config);
+	err = qca_download_firmware(hdev, &config);
 	if (err < 0) {
-		BT_ERR("%s: Failed to download patch (%d)", hdev->name, err);
+		bt_dev_err(hdev, "QCA Failed to download patch (%d)", err);
 		return err;
 	}
 
@@ -361,24 +360,24 @@ int qca_uart_setup_rome(struct hci_dev *hdev, uint8_t baudrate)
 	config.type = TLV_TYPE_NVM;
 	snprintf(config.fwname, sizeof(config.fwname), "qca/nvm_%08x.bin",
 		 rome_ver);
-	err = rome_download_firmware(hdev, &config);
+	err = qca_download_firmware(hdev, &config);
 	if (err < 0) {
-		BT_ERR("%s: Failed to download NVM (%d)", hdev->name, err);
+		bt_dev_err(hdev, "QCA Failed to download NVM (%d)", err);
 		return err;
 	}
 
 	/* Perform HCI reset */
-	err = rome_reset(hdev);
+	err = qca_send_reset(hdev);
 	if (err < 0) {
-		BT_ERR("%s: Failed to run HCI_RESET (%d)", hdev->name, err);
+		bt_dev_err(hdev, "QCA Failed to run HCI_RESET (%d)", err);
 		return err;
 	}
 
-	bt_dev_info(hdev, "ROME setup on UART is completed");
+	bt_dev_info(hdev, "QCA setup on UART is completed");
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(qca_uart_setup_rome);
+EXPORT_SYMBOL_GPL(qca_uart_setup);
 
 MODULE_AUTHOR("Ben Young Tae Kim <ytkim@qca.qualcomm.com>");
 MODULE_DESCRIPTION("Bluetooth support for Qualcomm Atheros family ver " VERSION);
diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
index 13d77fd873b6..5c9851b11838 100644
--- a/drivers/bluetooth/btqca.h
+++ b/drivers/bluetooth/btqca.h
@@ -127,7 +127,8 @@ struct tlv_type_hdr {
 #if IS_ENABLED(CONFIG_BT_QCA)
 
 int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr);
-int qca_uart_setup_rome(struct hci_dev *hdev, uint8_t baudrate);
+int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate);
+int qca_read_soc_version(struct hci_dev *hdev, u32 *soc_version);
 
 #else
 
@@ -136,7 +137,12 @@ static inline int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdad
 	return -EOPNOTSUPP;
 }
 
-static inline int qca_uart_setup_rome(struct hci_dev *hdev, int speed)
+static inline int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int qca_read_soc_version(struct hci_dev *hdev, u32 *soc_version)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 51790dd02afb..d7b60669b656 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -966,7 +966,7 @@ static int qca_setup(struct hci_uart *hu)
 	}
 
 	/* Setup patch / NVM configurations */
-	ret = qca_uart_setup_rome(hdev, qca_baudrate);
+	ret = qca_uart_setup(hdev, qca_baudrate);
 	if (!ret) {
 		set_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
 		qca_debugfs_init(hdev);
-- 
2.17.1

