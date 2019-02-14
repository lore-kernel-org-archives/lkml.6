Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BF0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C0B621928
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388222AbfBNXUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 18:20:04 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:30545 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728951AbfBNXUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 18:20:01 -0500
X-UUID: d122ed798cbf4c31abb71e19d33d735d-20190215
X-UUID: d122ed798cbf4c31abb71e19d33d735d-20190215
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1547761015; Fri, 15 Feb 2019 07:19:50 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
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
Subject: [PATCH 5/6] Bluetooth: mediatek: update the common setup between MT7622 and other devices
Date:   Fri, 15 Feb 2019 07:19:37 +0800
Message-ID: <9ea118140651636b3b868e28004d474ded4af5b6.1550184473.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1550184473.git.sean.wang@mediatek.com>
References: <cover.1550184473.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: CFE28462E4E2A0066D3FC60D06A4F34C9D90092C173465561A42EF3D0F811AA22000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Update the setup sequence on MT7622 to apply the same flow with MT7663U
and MT7668U USB [1] as much as possible. These additional commands are
required to parse the corresponding event to determine what current state
the Bluetooth device is on and thus it's necessary to extend
mtk_hci_wmt_sync to support the reading status in the same patch.

[1] http://lists.infradead.org/pipermail/linux-mediatek/2019-January/017074.html

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/bluetooth/btmtkuart.c | 204 +++++++++++++++++++++++++++++++---
 1 file changed, 190 insertions(+), 14 deletions(-)

diff --git a/drivers/bluetooth/btmtkuart.c b/drivers/bluetooth/btmtkuart.c
index 4451b1db139a..e73b1013ba73 100644
--- a/drivers/bluetooth/btmtkuart.c
+++ b/drivers/bluetooth/btmtkuart.c
@@ -12,6 +12,7 @@
 #include <linux/atomic.h>
 #include <linux/clk.h>
 #include <linux/firmware.h>
+#include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -37,7 +38,17 @@
 enum {
 	MTK_WMT_PATCH_DWNLD = 0x1,
 	MTK_WMT_FUNC_CTRL = 0x6,
-	MTK_WMT_RST = 0x7
+	MTK_WMT_RST = 0x7,
+	MTK_WMT_SEMAPHORE = 0x17,
+};
+
+enum {
+	BTMTK_WMT_INVALID,
+	BTMTK_WMT_PATCH_UNDONE,
+	BTMTK_WMT_PATCH_DONE,
+	BTMTK_WMT_ON_UNDONE,
+	BTMTK_WMT_ON_DONE,
+	BTMTK_WMT_ON_PROGRESS,
 };
 
 struct mtk_stp_hdr {
@@ -58,6 +69,24 @@ struct mtk_hci_wmt_cmd {
 	u8 data[256];
 } __packed;
 
+struct btmtk_hci_wmt_evt {
+	struct hci_event_hdr hhdr;
+	struct mtk_wmt_hdr whdr;
+} __packed;
+
+struct btmtk_hci_wmt_evt_funcc {
+	struct btmtk_hci_wmt_evt hwhdr;
+	__be16 status;
+} __packed;
+
+struct btmtk_tci_sleep {
+	u8 mode;
+	__le16 duration;
+	__le16 host_duration;
+	u8 host_wakeup_pin;
+	u8 time_compensation;
+} __packed;
+
 struct btmtk_hci_wmt_params {
 	u8 op;
 	u8 flag;
@@ -76,6 +105,7 @@ struct btmtkuart_dev {
 	struct sk_buff_head txq;
 
 	struct sk_buff *rx_skb;
+	struct sk_buff *evt_skb;
 
 	u8	stp_pad[6];
 	u8	stp_cursor;
@@ -86,9 +116,11 @@ static int mtk_hci_wmt_sync(struct hci_dev *hdev,
 			    struct btmtk_hci_wmt_params *wmt_params)
 {
 	struct btmtkuart_dev *bdev = hci_get_drvdata(hdev);
+	struct btmtk_hci_wmt_evt_funcc *wmt_evt_funcc;
+	u32 hlen, status = BTMTK_WMT_INVALID;
+	struct btmtk_hci_wmt_evt *wmt_evt;
 	struct mtk_hci_wmt_cmd wc;
 	struct mtk_wmt_hdr *hdr;
-	u32 hlen;
 	int err;
 
 	hlen = sizeof(*hdr) + wmt_params->dlen;
@@ -133,7 +165,41 @@ static int mtk_hci_wmt_sync(struct hci_dev *hdev,
 		return -ETIMEDOUT;
 	}
 
-	return 0;
+	/* Parse and handle the return WMT event */
+	wmt_evt = (struct btmtk_hci_wmt_evt *)bdev->evt_skb->data;
+	if (wmt_evt->whdr.op != hdr->op) {
+		bt_dev_err(hdev, "Wrong op received %d expected %d",
+			   wmt_evt->whdr.op, hdr->op);
+		err = -EIO;
+		goto err_free_skb;
+	}
+
+	switch (wmt_evt->whdr.op) {
+	case MTK_WMT_SEMAPHORE:
+		if (wmt_evt->whdr.flag == 2)
+			status = BTMTK_WMT_PATCH_UNDONE;
+		else
+			status = BTMTK_WMT_PATCH_DONE;
+		break;
+	case MTK_WMT_FUNC_CTRL:
+		wmt_evt_funcc = (struct btmtk_hci_wmt_evt_funcc *)wmt_evt;
+		if (be16_to_cpu(wmt_evt_funcc->status) == 0x404)
+			status = BTMTK_WMT_ON_DONE;
+		else if (be16_to_cpu(wmt_evt_funcc->status) == 0x420)
+			status = BTMTK_WMT_ON_PROGRESS;
+		else
+			status = BTMTK_WMT_ON_UNDONE;
+		break;
+	}
+
+	if (wmt_params->status)
+		*wmt_params->status = status;
+
+err_free_skb:
+	kfree_skb(bdev->evt_skb);
+	bdev->evt_skb = NULL;
+
+	return err;
 }
 
 static int mtk_setup_fw(struct hci_dev *hdev)
@@ -184,13 +250,29 @@ static int mtk_setup_fw(struct hci_dev *hdev)
 		if (err < 0) {
 			bt_dev_err(hdev, "Failed to send wmt patch dwnld (%d)",
 				   err);
-			break;
+			goto free_fw;
 		}
 
 		fw_size -= dlen;
 		fw_ptr += dlen;
 	}
 
+	wmt_params.op = MTK_WMT_RST;
+	wmt_params.flag = 4;
+	wmt_params.dlen = 0;
+	wmt_params.data = NULL;
+	wmt_params.status = NULL;
+
+	/* Activate funciton the firmware providing to */
+	err = mtk_hci_wmt_sync(hdev, &wmt_params);
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed to send wmt rst (%d)", err);
+		goto free_fw;
+	}
+
+	/* Wait a few moments for firmware activation done */
+	usleep_range(10000, 12000);
+
 free_fw:
 	release_firmware(fw);
 	return err;
@@ -209,7 +291,20 @@ static int btmtkuart_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 	if (hdr->evt == 0xe4)
 		hdr->evt = HCI_EV_VENDOR;
 
+	/* When someone waits for the WMT event, the skb is being cloned
+	 * and being processed the events from there then.
+	 */
+	if (test_bit(BTMTKUART_TX_WAIT_VND_EVT, &bdev->tx_state)) {
+		bdev->evt_skb = skb_clone(skb, GFP_KERNEL);
+		if (!bdev->evt_skb) {
+			err = -ENOMEM;
+			goto err_out;
+		}
+	}
+
 	err = hci_recv_frame(hdev, skb);
+	if (err < 0)
+		goto err_free_skb;
 
 	if (hdr->evt == HCI_EV_VENDOR) {
 		if (test_and_clear_bit(BTMTKUART_TX_WAIT_VND_EVT,
@@ -220,6 +315,13 @@ static int btmtkuart_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 		}
 	}
 
+	return 0;
+
+err_free_skb:
+	kfree_skb(bdev->evt_skb);
+	bdev->evt_skb = NULL;
+
+err_out:
 	return err;
 }
 
@@ -482,28 +584,79 @@ static int btmtkuart_flush(struct hci_dev *hdev)
 	return 0;
 }
 
+static int btmtkuart_func_query(struct hci_dev *hdev)
+{
+	struct btmtk_hci_wmt_params wmt_params;
+	int status, err;
+	u8 param = 0;
+
+	/* Query whether the function is enabled */
+	wmt_params.op = MTK_WMT_FUNC_CTRL;
+	wmt_params.flag = 4;
+	wmt_params.dlen = sizeof(param);
+	wmt_params.data = &param;
+	wmt_params.status = &status;
+
+	err = mtk_hci_wmt_sync(hdev, &wmt_params);
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed to query function status (%d)", err);
+		return err;
+	}
+
+	return status;
+}
+
 static int btmtkuart_setup(struct hci_dev *hdev)
 {
 	struct btmtk_hci_wmt_params wmt_params;
+	ktime_t calltime, delta, rettime;
+	struct btmtk_tci_sleep tci_sleep;
+	unsigned long long duration;
+	struct sk_buff *skb;
+	int err, status;
 	u8 param = 0x1;
-	int err = 0;
 
-	/* Setup a firmware which the device definitely requires */
-	err = mtk_setup_fw(hdev);
-	if (err < 0)
-		return err;
+	calltime = ktime_get();
 
-	wmt_params.op = MTK_WMT_RST;
-	wmt_params.flag = 4;
+	/* Query whether the firmware is already download */
+	wmt_params.op = MTK_WMT_SEMAPHORE;
+	wmt_params.flag = 1;
 	wmt_params.dlen = 0;
 	wmt_params.data = NULL;
-	wmt_params.status = NULL;
+	wmt_params.status = &status;
 
-	/* Activate funciton the firmware providing to */
 	err = mtk_hci_wmt_sync(hdev, &wmt_params);
 	if (err < 0) {
-		bt_dev_err(hdev, "Failed to send wmt rst (%d)", err);
+		bt_dev_err(hdev, "Failed to query firmware status (%d)", err);
+		return err;
+	}
+
+	if (status == BTMTK_WMT_PATCH_DONE) {
+		bt_dev_info(hdev, "Firmware already downloaded");
+		goto ignore_setup_fw;
+	}
+
+	/* Setup a firmware which the device definitely requires */
+	err = mtk_setup_fw(hdev);
+	if (err < 0)
 		return err;
+
+ignore_setup_fw:
+	/* Query whether the device is already enabled */
+	err = readx_poll_timeout(btmtkuart_func_query, hdev, status,
+				 status < 0 || status != BTMTK_WMT_ON_PROGRESS,
+				 2000, 5000000);
+	/* -ETIMEDOUT happens */
+	if (err < 0)
+		return err;
+
+	/* The other errors happen in btusb_mtk_func_query */
+	if (status < 0)
+		return status;
+
+	if (status == BTMTK_WMT_ON_DONE) {
+		bt_dev_info(hdev, "function already on");
+		goto ignore_func_on;
 	}
 
 	/* Enable Bluetooth protocol */
@@ -519,6 +672,29 @@ static int btmtkuart_setup(struct hci_dev *hdev)
 		return err;
 	}
 
+ignore_func_on:
+	/* Apply the low power environment setup */
+	tci_sleep.mode = 0x5;
+	tci_sleep.duration = cpu_to_le16(0x640);
+	tci_sleep.host_duration = cpu_to_le16(0x640);
+	tci_sleep.host_wakeup_pin = 0;
+	tci_sleep.time_compensation = 0;
+
+	skb = __hci_cmd_sync(hdev, 0xfc7a, sizeof(tci_sleep), &tci_sleep,
+			     HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		bt_dev_err(hdev, "Failed to apply low power setting (%d)", err);
+		return err;
+	}
+	kfree_skb(skb);
+
+	rettime = ktime_get();
+	delta = ktime_sub(rettime, calltime);
+	duration = (unsigned long long)ktime_to_ns(delta) >> 10;
+
+	bt_dev_info(hdev, "Device setup in %llu usecs", duration);
+
 	return 0;
 }
 
-- 
2.18.0

