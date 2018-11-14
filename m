Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B8EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 12:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E432086B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 12:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LWHKoSeo";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jSMSn6TN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9E432086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732220AbeKNWhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 17:37:33 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40198 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbeKNWhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 17:37:32 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F3BA8601D4; Wed, 14 Nov 2018 12:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542198868;
        bh=UTejcDY/XE3AHidaahIJmn23UpUx87hv2SPQ3EFob4c=;
        h=From:To:Cc:Subject:Date:From;
        b=LWHKoSeoiEEtm9Hn8Z8L2VLp0Eb303MYv7XuuH2/YIntbNqeIakOESTHQLMDE0I/+
         WvgHgybRuH8//GxrQK3Y3CpPfcnnRXawep0gJ934DeyqKRHpgvVmyx8qhbip85o6FP
         GZs3Bbp6MRT67F1SF7qrRgnnZ9d35kTnwBLE5piE=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 142F06022B;
        Wed, 14 Nov 2018 12:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542198867;
        bh=UTejcDY/XE3AHidaahIJmn23UpUx87hv2SPQ3EFob4c=;
        h=From:To:Cc:Subject:Date:From;
        b=jSMSn6TNB7tDExMsQc+mmsl2HaSGWG/JqSY4AGB96V8WsU913VcliG15Ng0Cvk7LQ
         uCKSuTWtG9zQULysnc2dhgwa9zFKUV/qDiOgRWGPC6QzQ5FClwYN8+Vc3Iv3C+iLQd
         4l0SOGR20ecXzodNx4CZudYyBiyj8syrF6HMiIUs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 142F06022B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [RESEND v2] Bluetooth: hci_qca: Add helper to set device address.
Date:   Wed, 14 Nov 2018 18:04:17 +0530
Message-Id: <20181114123417.3544-1-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add qca_set_bdaddr() to set the device
address for latest Qualcomm Bluetooth chipset wcn3990 and above.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/bluetooth/btqca.c   | 19 +++++++++++++++++++
 drivers/bluetooth/btqca.h   |  8 +++++++-
 drivers/bluetooth/hci_qca.c |  5 ++++-
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index ec9e03a6b778..612268574fc7 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -391,6 +391,25 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 }
 EXPORT_SYMBOL_GPL(qca_uart_setup);
 
+int qca_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
+{
+	struct sk_buff *skb;
+	int err;
+
+	skb = __hci_cmd_sync_ev(hdev, EDL_WRITE_BD_ADDR_OPCODE, 6, bdaddr,
+				HCI_EV_VENDOR, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		bt_dev_err(hdev, "QCA Change address cmd failed (%d)", err);
+		return err;
+	}
+
+	kfree_skb(skb);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(qca_set_bdaddr);
+
 MODULE_AUTHOR("Ben Young Tae Kim <ytkim@qca.qualcomm.com>");
 MODULE_DESCRIPTION("Bluetooth support for Qualcomm Atheros family ver " VERSION);
 MODULE_VERSION(VERSION);
diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
index 0c01f375fe83..c72c56ea7480 100644
--- a/drivers/bluetooth/btqca.h
+++ b/drivers/bluetooth/btqca.h
@@ -20,6 +20,7 @@
 
 #define EDL_PATCH_CMD_OPCODE		(0xFC00)
 #define EDL_NVM_ACCESS_OPCODE		(0xFC0B)
+#define EDL_WRITE_BD_ADDR_OPCODE	(0xFC14)
 #define EDL_PATCH_CMD_LEN		(1)
 #define EDL_PATCH_VER_REQ_CMD		(0x19)
 #define EDL_PATCH_TLV_REQ_CMD		(0x1E)
@@ -140,7 +141,7 @@ int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr);
 int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 		   enum qca_btsoc_type soc_type, u32 soc_ver);
 int qca_read_soc_version(struct hci_dev *hdev, u32 *soc_version);
-
+int qca_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr);
 #else
 
 static inline int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr)
@@ -159,4 +160,9 @@ static inline int qca_read_soc_version(struct hci_dev *hdev, u32 *soc_version)
 	return -EOPNOTSUPP;
 }
 
+static inline int qca_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index f036c8f98ea3..53ac5ade532b 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1241,7 +1241,10 @@ static int qca_setup(struct hci_uart *hu)
 	}
 
 	/* Setup bdaddr */
-	hu->hdev->set_bdaddr = qca_set_bdaddr_rome;
+	if (qcadev->btsoc_type == QCA_WCN3990)
+		hu->hdev->set_bdaddr = qca_set_bdaddr;
+	else
+		hu->hdev->set_bdaddr = qca_set_bdaddr_rome;
 
 	return ret;
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

