Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC03C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 548752229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbfBNXT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 18:19:56 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:48766 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728789AbfBNXTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 18:19:51 -0500
X-UUID: a410d1126c5a4d53984a9d7045ee47b1-20190215
X-UUID: a410d1126c5a4d53984a9d7045ee47b1-20190215
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1492603866; Fri, 15 Feb 2019 07:19:43 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 15 Feb 2019 07:19:42 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 15 Feb 2019 07:19:42 +0800
From:   <sean.wang@mediatek.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 4/6] Bluetooth: mediatek: pass a pointer to mtk_hci_wmt_sync
Date:   Fri, 15 Feb 2019 07:19:36 +0800
Message-ID: <614e7741328e835071099ddcd4f9c2afd9528534.1550184473.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1550184473.git.sean.wang@mediatek.com>
References: <cover.1550184473.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Pass a structure pointer to mtk_hci_wmt_sync rather than several arguments
to avoid take up additional stack area and be better to read the code.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/bluetooth/btmtkuart.c | 63 ++++++++++++++++++++++++++---------
 1 file changed, 48 insertions(+), 15 deletions(-)

diff --git a/drivers/bluetooth/btmtkuart.c b/drivers/bluetooth/btmtkuart.c
index 9f8177b216b6..4451b1db139a 100644
--- a/drivers/bluetooth/btmtkuart.c
+++ b/drivers/bluetooth/btmtkuart.c
@@ -58,6 +58,14 @@ struct mtk_hci_wmt_cmd {
 	u8 data[256];
 } __packed;
 
+struct btmtk_hci_wmt_params {
+	u8 op;
+	u8 flag;
+	u16 dlen;
+	const void *data;
+	u32 *status;
+};
+
 struct btmtkuart_dev {
 	struct hci_dev *hdev;
 	struct serdev_device *serdev;
@@ -74,8 +82,8 @@ struct btmtkuart_dev {
 	u16	stp_dlen;
 };
 
-static int mtk_hci_wmt_sync(struct hci_dev *hdev, u8 op, u8 flag, u16 plen,
-			    const void *param)
+static int mtk_hci_wmt_sync(struct hci_dev *hdev,
+			    struct btmtk_hci_wmt_params *wmt_params)
 {
 	struct btmtkuart_dev *bdev = hci_get_drvdata(hdev);
 	struct mtk_hci_wmt_cmd wc;
@@ -83,16 +91,16 @@ static int mtk_hci_wmt_sync(struct hci_dev *hdev, u8 op, u8 flag, u16 plen,
 	u32 hlen;
 	int err;
 
-	hlen = sizeof(*hdr) + plen;
+	hlen = sizeof(*hdr) + wmt_params->dlen;
 	if (hlen > 255)
 		return -EINVAL;
 
 	hdr = (struct mtk_wmt_hdr *)&wc;
 	hdr->dir = 1;
-	hdr->op = op;
-	hdr->dlen = cpu_to_le16(plen + 1);
-	hdr->flag = flag;
-	memcpy(wc.data, param, plen);
+	hdr->op = wmt_params->op;
+	hdr->dlen = cpu_to_le16(wmt_params->dlen + 1);
+	hdr->flag = wmt_params->flag;
+	memcpy(wc.data, wmt_params->data, wmt_params->dlen);
 
 	set_bit(BTMTKUART_TX_WAIT_VND_EVT, &bdev->tx_state);
 
@@ -130,6 +138,7 @@ static int mtk_hci_wmt_sync(struct hci_dev *hdev, u8 op, u8 flag, u16 plen,
 
 static int mtk_setup_fw(struct hci_dev *hdev)
 {
+	struct btmtk_hci_wmt_params wmt_params;
 	const struct firmware *fw;
 	const u8 *fw_ptr;
 	size_t fw_size;
@@ -155,6 +164,9 @@ static int mtk_setup_fw(struct hci_dev *hdev)
 	fw_ptr += 30;
 	flag = 1;
 
+	wmt_params.op = MTK_WMT_PATCH_DWNLD;
+	wmt_params.status = NULL;
+
 	while (fw_size > 0) {
 		dlen = min_t(int, 250, fw_size);
 
@@ -164,8 +176,11 @@ static int mtk_setup_fw(struct hci_dev *hdev)
 		else if (fw_size < fw->size - 30)
 			flag = 2;
 
-		err = mtk_hci_wmt_sync(hdev, MTK_WMT_PATCH_DWNLD, flag, dlen,
-				       fw_ptr);
+		wmt_params.flag = flag;
+		wmt_params.dlen = dlen;
+		wmt_params.data = fw_ptr;
+
+		err = mtk_hci_wmt_sync(hdev, &wmt_params);
 		if (err < 0) {
 			bt_dev_err(hdev, "Failed to send wmt patch dwnld (%d)",
 				   err);
@@ -469,6 +484,7 @@ static int btmtkuart_flush(struct hci_dev *hdev)
 
 static int btmtkuart_setup(struct hci_dev *hdev)
 {
+	struct btmtk_hci_wmt_params wmt_params;
 	u8 param = 0x1;
 	int err = 0;
 
@@ -477,16 +493,27 @@ static int btmtkuart_setup(struct hci_dev *hdev)
 	if (err < 0)
 		return err;
 
-	/* Activate function the firmware providing to */
-	err = mtk_hci_wmt_sync(hdev, MTK_WMT_RST, 0x4, 0, 0);
+	wmt_params.op = MTK_WMT_RST;
+	wmt_params.flag = 4;
+	wmt_params.dlen = 0;
+	wmt_params.data = NULL;
+	wmt_params.status = NULL;
+
+	/* Activate funciton the firmware providing to */
+	err = mtk_hci_wmt_sync(hdev, &wmt_params);
 	if (err < 0) {
 		bt_dev_err(hdev, "Failed to send wmt rst (%d)", err);
 		return err;
 	}
 
 	/* Enable Bluetooth protocol */
-	err = mtk_hci_wmt_sync(hdev, MTK_WMT_FUNC_CTRL, 0x0, sizeof(param),
-			       &param);
+	wmt_params.op = MTK_WMT_FUNC_CTRL;
+	wmt_params.flag = 0;
+	wmt_params.dlen = sizeof(param);
+	wmt_params.data = &param;
+	wmt_params.status = NULL;
+
+	err = mtk_hci_wmt_sync(hdev, &wmt_params);
 	if (err < 0) {
 		bt_dev_err(hdev, "Failed to send wmt func ctrl (%d)", err);
 		return err;
@@ -497,12 +524,18 @@ static int btmtkuart_setup(struct hci_dev *hdev)
 
 static int btmtkuart_shutdown(struct hci_dev *hdev)
 {
+	struct btmtk_hci_wmt_params wmt_params;
 	u8 param = 0x0;
 	int err;
 
 	/* Disable the device */
-	err = mtk_hci_wmt_sync(hdev, MTK_WMT_FUNC_CTRL, 0x0, sizeof(param),
-			       &param);
+	wmt_params.op = MTK_WMT_FUNC_CTRL;
+	wmt_params.flag = 0;
+	wmt_params.dlen = sizeof(param);
+	wmt_params.data = &param;
+	wmt_params.status = NULL;
+
+	err = mtk_hci_wmt_sync(hdev, &wmt_params);
 	if (err < 0) {
 		bt_dev_err(hdev, "Failed to send wmt func ctrl (%d)", err);
 		return err;
-- 
2.18.0

