Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1256C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 611ED20665
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="n5pqX3dk";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cAjdCKMt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 611ED20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbeJZWmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 18:42:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47022 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeJZWmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 18:42:15 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1E25061308; Fri, 26 Oct 2018 14:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540562703;
        bh=E2oy0H/3YQk4why8fNP7iQ89n+sxnlceowphcC0QjTc=;
        h=From:To:Cc:Subject:Date:From;
        b=n5pqX3dkuveGZpOplhffrjoyr535BXP26RCHHb2j0qmN1E6FuTsYlAS2HqsyZm1Lk
         1DlXalvjw0WSvS3eCFFuKNyJoFllk14yyIPyYsmhHXMojvTw4WmnGpYAv+IeibOmeE
         faM6xLoutm7vVynkwdtzjdUDMMhdJC2CZDWXd7+c=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5992660A33;
        Fri, 26 Oct 2018 14:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540562701;
        bh=E2oy0H/3YQk4why8fNP7iQ89n+sxnlceowphcC0QjTc=;
        h=From:To:Cc:Subject:Date:From;
        b=cAjdCKMtIRpK/qWueDKoIqqDfU/KhQAV6ctbhA/Ls/0eANSfWnpFrL6OcIm6uW7x+
         WM1dQEAuS6K8+SRvUlbnHJJCvS/n2rBROBFmMJNxooHxbmyESHxOtTvC1f1zhetMvE
         uVBGrOQzy+8Bs0V4/LSB6gJ9Qn82HU7YFSkm8Cys=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5992660A33
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v1] Bluetooth: hci_qca: Add helper to set device address.
Date:   Fri, 26 Oct 2018 19:34:50 +0530
Message-Id: <20181026140450.13172-1-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add qca_set_device_bdaddr() to set the device
address for latest Qualcomm Bluetooth chipset wcn3990 and above.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---
 drivers/bluetooth/btqca.c   | 21 +++++++++++++++++++++
 drivers/bluetooth/btqca.h   |  9 ++++++++-
 drivers/bluetooth/hci_qca.c |  5 ++++-
 3 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index ec9e03a6b778..132dc6ceb174 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -391,6 +391,27 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 }
 EXPORT_SYMBOL_GPL(qca_uart_setup);
 
+int qca_set_device_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
+{
+	struct sk_buff *skb;
+	u8 cmd[6];
+	int err;
+
+	memcpy(cmd, bdaddr, sizeof(bdaddr_t));
+	skb = __hci_cmd_sync_ev(hdev, EDL_WRITE_BD_ADDR_OPCODE, sizeof(cmd),
+				cmd, HCI_EV_VENDOR, HCI_INIT_TIMEOUT);
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
+EXPORT_SYMBOL_GPL(qca_set_device_bdaddr);
+
 MODULE_AUTHOR("Ben Young Tae Kim <ytkim@qca.qualcomm.com>");
 MODULE_DESCRIPTION("Bluetooth support for Qualcomm Atheros family ver " VERSION);
 MODULE_VERSION(VERSION);
diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
index 0c01f375fe83..8771fc2b193d 100644
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
+int qca_set_device_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr);
 #else
 
 static inline int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr)
@@ -159,4 +160,10 @@ static inline int qca_read_soc_version(struct hci_dev *hdev, u32 *soc_version)
 	return -EOPNOTSUPP;
 }
 
+static inline int qca_set_device_bdaddr(struct hci_dev *hdev,
+					const bdaddr_t *bdaddr)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index f036c8f98ea3..f18d9f5a7782 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1241,7 +1241,10 @@ static int qca_setup(struct hci_uart *hu)
 	}
 
 	/* Setup bdaddr */
-	hu->hdev->set_bdaddr = qca_set_bdaddr_rome;
+	if (qcadev->btsoc_type == QCA_WCN3990)
+		hu->hdev->set_bdaddr = qca_set_device_bdaddr;
+	else
+		hu->hdev->set_bdaddr = qca_set_bdaddr_rome;
 
 	return ret;
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

