Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EFCC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 05:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE4CF21568
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 05:44:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE4CF21568
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932135AbeF0FoW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 01:44:22 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:14608 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752811AbeF0Fnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 01:43:41 -0400
X-UUID: 52cbee4dbe9d4dd2a53af3b81ac4ea4e-20180627
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1305502956; Wed, 27 Jun 2018 13:43:34 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 27 Jun 2018 13:43:28 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 27 Jun 2018 13:43:28 +0800
From:   <sean.wang@mediatek.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v4 6/7] Bluetooth: mediatek: Add protocol support for MediaTek serial devices
Date:   Wed, 27 Jun 2018 13:43:24 +0800
Message-ID: <48215a1276c36af7ad581c3d83759fe9f55e3c4b.1530004712.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1530004712.git.sean.wang@mediatek.com>
References: <cover.1530004712.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

This adds a driver to run on the top of btuart driver for the MediaTek
serial protocol based on running H:4, which can enable the built-in
Bluetooth device inside MT7622 SoC.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/bluetooth/Kconfig     |  12 ++
 drivers/bluetooth/Makefile    |   2 +
 drivers/bluetooth/btmtkuart.c | 355 ++++++++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btmtkuart.h | 119 ++++++++++++++
 drivers/bluetooth/btuart.c    |  18 +++
 5 files changed, 506 insertions(+)
 create mode 100644 drivers/bluetooth/btmtkuart.c
 create mode 100644 drivers/bluetooth/btmtkuart.h

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 00fdf5f..1a44afd 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -85,6 +85,18 @@ config BT_HCIBTUART
 	  Say Y here to compile support for Bluetooth UART devices into the
 	  kernel or say M to compile it as module (btuart).
 
+config BT_HCIBTUART_MTK
+	tristate "MediaTek HCI UART driver"
+	depends on BT_HCIBTUART
+	default y
+	help
+	  MediaTek Bluetooth HCI UART driver.
+	  This driver is required if you want to use MediaTek Bluetooth
+	  with serial interface.
+
+	  Say Y here to compile support for MediaTek Bluetooth UART devices
+	  into the kernel or say M to compile it as module (btmtkuart).
+
 config BT_HCIUART
 	tristate "HCI UART driver"
 	depends on SERIAL_DEV_BUS || !SERIAL_DEV_BUS
diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
index 60a19cb..c9a8926 100644
--- a/drivers/bluetooth/Makefile
+++ b/drivers/bluetooth/Makefile
@@ -26,6 +26,8 @@ obj-$(CONFIG_BT_BCM)		+= btbcm.o
 obj-$(CONFIG_BT_RTL)		+= btrtl.o
 obj-$(CONFIG_BT_QCA)		+= btqca.o
 
+obj-$(CONFIG_BT_HCIBTUART_MTK)	+= btmtkuart.o
+
 obj-$(CONFIG_BT_HCIUART_NOKIA)	+= hci_nokia.o
 
 obj-$(CONFIG_BT_HCIRSI)		+= btrsi.o
diff --git a/drivers/bluetooth/btmtkuart.c b/drivers/bluetooth/btmtkuart.c
new file mode 100644
index 0000000..3118f61
--- /dev/null
+++ b/drivers/bluetooth/btmtkuart.c
@@ -0,0 +1,355 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018 MediaTek Inc.
+
+/*
+ * Bluetooth support for MediaTek serial devices
+ *
+ * Author: Sean Wang <sean.wang@mediatek.com>
+ *
+ */
+
+#include <asm/unaligned.h>
+#include <linux/atomic.h>
+#include <linux/clk.h>
+#include <linux/firmware.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/serdev.h>
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+
+#include "h4_recv.h"
+#include "btuart.h"
+#include "btmtkuart.h"
+
+static void mtk_stp_reset(struct mtk_stp_splitter *sp)
+{
+	sp->cursor = 2;
+	sp->dlen = 0;
+}
+
+static const unsigned char *
+mtk_stp_split(struct btuart_dev *bdev, struct mtk_stp_splitter *sp,
+	      const unsigned char *data, int count, int *sz_h4)
+{
+	struct mtk_stp_hdr *shdr;
+
+	/* The cursor is reset when all the data of STP is consumed out. */
+	if (!sp->dlen && sp->cursor >= 6)
+		sp->cursor = 0;
+
+	/* Filling pad until all STP info is obtained. */
+	while (sp->cursor < 6 && count > 0) {
+		sp->pad[sp->cursor] = *data;
+		sp->cursor++;
+		data++;
+		count--;
+	}
+
+	/* Retrieve STP info and have a sanity check. */
+	if (!sp->dlen && sp->cursor >= 6) {
+		shdr = (struct mtk_stp_hdr *)&sp->pad[2];
+		sp->dlen = shdr->dlen1 << 8 | shdr->dlen2;
+
+		/* Resync STP when unexpected data is being read. */
+		if (shdr->prefix != 0x80 || sp->dlen > 2048) {
+			bt_dev_err(bdev->hdev, "stp format unexpect (%d, %d)",
+				   shdr->prefix, sp->dlen);
+			mtk_stp_reset(sp);
+		}
+	}
+
+	/* Directly quit when there's no data found for H4 can process. */
+	if (count <= 0)
+		return NULL;
+
+	/* Tranlate to how much the size of data H4 can handle so far. */
+	*sz_h4 = min_t(int, count, sp->dlen);
+	/* Update the remaining size of STP packet. */
+	sp->dlen -= *sz_h4;
+
+	/* Data points to STP payload which can be handled by H4. */
+	return data;
+}
+
+static int mtk_stp_send(struct btuart_dev *bdev, struct sk_buff *skb)
+{
+	struct mtk_stp_hdr *shdr;
+	struct sk_buff *new_skb;
+	int dlen;
+
+	memcpy(skb_push(skb, 1), &hci_skb_pkt_type(skb), 1);
+	dlen = skb->len;
+
+	/* Make sure of STP header at least has 4-bytes free space to fill. */
+	if (unlikely(skb_headroom(skb) < MTK_STP_HDR_SIZE)) {
+		new_skb = skb_realloc_headroom(skb, MTK_STP_HDR_SIZE);
+		kfree_skb(skb);
+		skb = new_skb;
+	}
+
+	/* Build for STP packet format. */
+	shdr = skb_push(skb, MTK_STP_HDR_SIZE);
+	mtk_make_stp_hdr(shdr, 0, dlen);
+	skb_put_zero(skb, MTK_STP_TLR_SIZE);
+
+	skb_queue_tail(&bdev->txq, skb);
+
+	return 0;
+}
+
+static int mtk_hci_wmt_sync(struct btuart_dev *bdev, u8 opcode, u8 flag,
+			    u16 plen, const void *param)
+{
+	struct mtk_hci_wmt_cmd wc;
+	struct mtk_wmt_hdr *hdr;
+	struct sk_buff *skb;
+	u32 hlen;
+
+	hlen = sizeof(*hdr) + plen;
+	if (hlen > 255)
+		return -EINVAL;
+
+	hdr = (struct mtk_wmt_hdr *)&wc;
+	mtk_make_wmt_hdr(hdr, opcode, plen, flag);
+	memcpy(wc.data, param, plen);
+
+	atomic_inc(&bdev->hdev->cmd_cnt);
+
+	skb =  __hci_cmd_sync_ev(bdev->hdev, 0xfc6f, hlen, &wc, HCI_VENDOR_PKT,
+				 HCI_INIT_TIMEOUT);
+
+	if (IS_ERR(skb)) {
+		int err = PTR_ERR(skb);
+
+		bt_dev_err(bdev->hdev, "Failed to send wmt cmd (%d)\n", err);
+		return err;
+	}
+
+	kfree_skb(skb);
+
+	return 0;
+}
+
+static int mtk_setup_fw(struct btuart_dev *bdev)
+{
+	const struct firmware *fw;
+	struct device *dev;
+	const char *fwname;
+	const u8 *fw_ptr;
+	size_t fw_size;
+	int err, dlen;
+	u8 flag;
+
+	dev = &bdev->serdev->dev;
+	fwname = FIRMWARE_MT7622;
+
+	err = request_firmware(&fw, fwname, dev);
+	if (err < 0) {
+		bt_dev_err(bdev->hdev, "Failed to load firmware file (%d)",
+			   err);
+		return err;
+	}
+
+	fw_ptr = fw->data;
+	fw_size = fw->size;
+
+	/* The size of patch header is 30 bytes, should be skip. */
+	if (fw_size < 30)
+		return -EINVAL;
+
+	fw_size -= 30;
+	fw_ptr += 30;
+
+	while (fw_size > 0) {
+		dlen = min_t(int, 250, fw_size);
+
+		/* Tell deivice the position in sequence. */
+		flag = (fw_size - dlen <= 0) ? 3 :
+		       (fw_size < fw->size - 30) ? 2 : 1;
+
+		err = mtk_hci_wmt_sync(bdev, MTK_WMT_PATCH_DWNLD, flag, dlen,
+				       fw_ptr);
+		if (err < 0)
+			break;
+
+		fw_size -= dlen;
+		fw_ptr += dlen;
+	}
+
+	release_firmware(fw);
+
+	return err;
+}
+
+void *mtk_btuart_init(struct device *dev)
+{
+	struct mtk_bt_dev *soc;
+
+	soc = devm_kzalloc(dev, sizeof(*soc), GFP_KERNEL);
+	if (!soc)
+		return ERR_PTR(-ENOMEM);
+
+	soc->sp = devm_kzalloc(dev, sizeof(*soc->sp), GFP_KERNEL);
+	if (!soc->sp)
+		return ERR_PTR(-ENOMEM);
+
+	soc->clk = devm_clk_get(dev, "ref");
+	if (IS_ERR(soc->clk))
+		return ERR_CAST(soc->clk);
+
+	return soc;
+}
+EXPORT_SYMBOL_GPL(mtk_btuart_init);
+
+int mtk_btuart_send(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct btuart_dev *bdev = hci_get_drvdata(hdev);
+
+	return mtk_stp_send(bdev, skb);
+}
+EXPORT_SYMBOL_GPL(mtk_btuart_send);
+
+int mtk_btuart_hci_frame(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_event_hdr *hdr = (void *)skb->data;
+
+	/* Fix up the vendor event id with HCI_VENDOR_PKT instead of
+	 * 0xe4 so that btmon can parse the kind of vendor event properly.
+	 */
+	if (hdr->evt == 0xe4)
+		hdr->evt = HCI_VENDOR_PKT;
+
+	/* Each HCI event would go through the core. */
+	return hci_recv_frame(hdev, skb);
+}
+EXPORT_SYMBOL_GPL(mtk_btuart_hci_frame);
+
+int mtk_btuart_recv(struct hci_dev *hdev, const u8 *data, size_t count)
+{
+	struct btuart_dev *bdev = hci_get_drvdata(hdev);
+	const unsigned char *p_left = data, *p_h4;
+	const struct btuart_vnd *vnd = bdev->vnd;
+	struct mtk_bt_dev *soc = bdev->data;
+	int sz_left = count, sz_h4, adv;
+	struct device *dev;
+	int err;
+
+	dev = &bdev->serdev->dev;
+
+	while (sz_left > 0) {
+		/*  The serial data received from MT7622 BT controller is
+		 *  at all time padded around with the STP header and tailer.
+		 *
+		 *  A full STP packet is looking like
+		 *   -----------------------------------
+		 *  | STP header  |  H:4   | STP tailer |
+		 *   -----------------------------------
+		 *  but it don't guarantee to contain a full H:4 packet which
+		 *  means that it's possible for multiple STP packets forms a
+		 *  full H:4 packet and whose length recorded in STP header can
+		 *  shows up the most length the H:4 engine can handle in one
+		 *  time.
+		 */
+
+		p_h4 = mtk_stp_split(bdev, soc->sp, p_left, sz_left, &sz_h4);
+		if (!p_h4)
+			break;
+
+		adv = p_h4 - p_left;
+		sz_left -= adv;
+		p_left += adv;
+
+		bdev->rx_skb = h4_recv_buf(bdev->hdev, bdev->rx_skb, p_h4,
+					   sz_h4, vnd->recv_pkts,
+					   vnd->recv_pkts_cnt);
+		if (IS_ERR(bdev->rx_skb)) {
+			err = PTR_ERR(bdev->rx_skb);
+			bt_dev_err(bdev->hdev,
+				   "Frame reassembly failed (%d)", err);
+			bdev->rx_skb = NULL;
+			return err;
+		}
+
+		sz_left -= sz_h4;
+		p_left += sz_h4;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mtk_btuart_recv);
+
+int mtk_btuart_setup(struct hci_dev *hdev)
+{
+	struct btuart_dev *bdev = hci_get_drvdata(hdev);
+	struct mtk_bt_dev *soc = bdev->data;
+	struct device *dev;
+	u8 param = 0x1;
+	int err = 0;
+
+	dev = &bdev->serdev->dev;
+
+	mtk_stp_reset(soc->sp);
+
+	/* Enable the power domain and clock the device requires. */
+	pm_runtime_enable(dev);
+	err = pm_runtime_get_sync(dev);
+	if (err < 0)
+		goto err_pm2;
+
+	err = clk_prepare_enable(soc->clk);
+	if (err < 0)
+		goto err_pm1;
+
+	/* Setup a firmware which the device definitely requires. */
+	err = mtk_setup_fw(bdev);
+	if (err < 0)
+		goto err_clk;
+
+	/* Activate funciton the firmware providing to. */
+	err = mtk_hci_wmt_sync(bdev, MTK_WMT_RST, 0x4, 0, 0);
+	if (err < 0)
+		goto err_clk;
+
+	/* Enable Bluetooth protocol. */
+	err = mtk_hci_wmt_sync(bdev, MTK_WMT_FUNC_CTRL, 0x0, sizeof(param),
+			       &param);
+	if (err < 0)
+		goto err_clk;
+
+	set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
+
+	return 0;
+err_clk:
+	clk_disable_unprepare(soc->clk);
+err_pm1:
+	pm_runtime_put_sync(dev);
+err_pm2:
+	pm_runtime_disable(dev);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(mtk_btuart_setup);
+
+int mtk_btuart_shutdown(struct hci_dev *hdev)
+{
+	struct btuart_dev *bdev = hci_get_drvdata(hdev);
+	struct device *dev = &bdev->serdev->dev;
+	struct mtk_bt_dev *soc = bdev->data;
+	u8 param = 0x0;
+
+	/* Disable the device. */
+	mtk_hci_wmt_sync(bdev, MTK_WMT_FUNC_CTRL, 0x0, sizeof(param), &param);
+
+	/* Shutdown the clock and power domain the device requires. */
+	clk_disable_unprepare(soc->clk);
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mtk_btuart_shutdown);
+
+MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
+MODULE_DESCRIPTION("Bluetooth Support for MediaTek Serial Devices");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/bluetooth/btmtkuart.h b/drivers/bluetooth/btmtkuart.h
new file mode 100644
index 0000000..e76ab23e
--- /dev/null
+++ b/drivers/bluetooth/btmtkuart.h
@@ -0,0 +1,119 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018 MediaTek Inc.
+ *
+ * Bluetooth support for MediaTek serial devices
+ *
+ * Author: Sean Wang <sean.wang@mediatek.com>
+ *
+ */
+
+#define FIRMWARE_MT7622		"mediatek/mt7622pr2h.bin"
+
+#define MTK_STP_HDR_SIZE	4
+#define MTK_STP_TLR_SIZE	2
+#define MTK_WMT_HDR_SIZE	5
+#define MTK_WMT_CMD_SIZE	(MTK_WMT_HDR_SIZE + MTK_STP_HDR_SIZE + \
+				 MTK_STP_TLR_SIZE + HCI_ACL_HDR_SIZE)
+
+enum {
+	MTK_WMT_PATCH_DWNLD = 0x1,
+	MTK_WMT_FUNC_CTRL = 0x6,
+	MTK_WMT_RST = 0x7
+};
+
+struct mtk_stp_hdr {
+	__u8 prefix;
+	__u8 dlen1:4;
+	__u8 type:4;
+	__u8 dlen2:8;
+	__u8 cs;
+} __packed;
+
+struct mtk_wmt_hdr {
+	__u8	dir;
+	__u8	op;
+	__le16	dlen;
+	__u8	flag;
+} __packed;
+
+struct mtk_hci_wmt_cmd {
+	struct mtk_wmt_hdr hdr;
+	__u8 data[256];
+} __packed;
+
+struct mtk_stp_splitter {
+	u8	pad[6];
+	u8	cursor;
+	u16	dlen;
+};
+
+struct mtk_bt_dev {
+	struct clk *clk;
+	struct completion wmt_cmd;
+	struct mtk_stp_splitter *sp;
+};
+
+static inline void mtk_make_stp_hdr(struct mtk_stp_hdr *hdr, u8 type, u32 dlen)
+{
+	__u8 *p = (__u8 *)hdr;
+
+	hdr->prefix = 0x80;
+	hdr->dlen1 = (dlen & 0xf00) >> 8;
+	hdr->type = type;
+	hdr->dlen2 = dlen & 0xff;
+	hdr->cs = p[0] + p[1] + p[2];
+}
+
+static inline void mtk_make_wmt_hdr(struct mtk_wmt_hdr *hdr, u8 op, u16 plen,
+				    u8 flag)
+{
+	hdr->dir = 1;
+	hdr->op = op;
+	hdr->dlen = cpu_to_le16(plen + 1);
+	hdr->flag = flag;
+}
+
+#if IS_ENABLED(CONFIG_BT_HCIBTUART_MTK)
+
+void *mtk_btuart_init(struct device *dev);
+int mtk_btuart_setup(struct hci_dev *hdev);
+int mtk_btuart_shutdown(struct hci_dev *hdev);
+int mtk_btuart_send(struct hci_dev *hdev, struct sk_buff *skb);
+int mtk_btuart_hci_frame(struct hci_dev *hdev, struct sk_buff *skb);
+int mtk_btuart_recv(struct hci_dev *hdev, const u8 *data, size_t count);
+
+#else
+
+static void *mtk_btuart_init(struct device *dev)
+{
+	return 0;
+}
+
+static inline int mtk_btuart_setup(struct hci_dev *hdev)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int mtk_btuart_shutdown(struct hci_dev *hdev)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int mtk_btuart_send(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	return -EOPNOTSUPP;
+}
+
+static int mtk_btuart_hci_frame(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int mtk_btuart_recv(struct hci_dev *hdev, const u8 *data,
+				  size_t count)
+{
+	return -EOPNOTSUPP;
+}
+
+#endif
diff --git a/drivers/bluetooth/btuart.c b/drivers/bluetooth/btuart.c
index ab7f836..169bf1a 100644
--- a/drivers/bluetooth/btuart.c
+++ b/drivers/bluetooth/btuart.c
@@ -35,6 +35,7 @@
 #include "h4_recv.h"
 #include "btuart.h"
 #include "btbcm.h"
+#include "btmtkuart.h"
 
 #define VERSION "1.0"
 
@@ -396,6 +397,12 @@ static const struct h4_recv_pkt bcm_recv_pkts[] = {
 	{ BCM_RECV_NULL,    .recv = hci_recv_diag  },
 };
 
+static const struct h4_recv_pkt mtk_recv_pkts[] = {
+	{ H4_RECV_ACL,      .recv = hci_recv_frame },
+	{ H4_RECV_SCO,      .recv = hci_recv_frame },
+	{ H4_RECV_EVENT,    .recv = mtk_btuart_hci_frame },
+};
+
 static const struct btuart_vnd bcm_vnd = {
 	.recv_pkts	= bcm_recv_pkts,
 	.recv_pkts_cnt	= ARRAY_SIZE(bcm_recv_pkts),
@@ -403,6 +410,16 @@ static const struct btuart_vnd bcm_vnd = {
 	.setup		= bcm_setup,
 };
 
+static const struct btuart_vnd mtk_vnd = {
+	.recv_pkts	= mtk_recv_pkts,
+	.recv_pkts_cnt	= ARRAY_SIZE(mtk_recv_pkts),
+	.init		= mtk_btuart_init,
+	.setup		= mtk_btuart_setup,
+	.shutdown	= mtk_btuart_shutdown,
+	.send		= mtk_btuart_send,
+	.recv		= mtk_btuart_recv,
+};
+
 static const struct h4_recv_pkt default_recv_pkts[] = {
 	{ H4_RECV_ACL,      .recv = hci_recv_frame },
 	{ H4_RECV_SCO,      .recv = hci_recv_frame },
@@ -487,6 +504,7 @@ static void btuart_remove(struct serdev_device *serdev)
 #ifdef CONFIG_OF
 static const struct of_device_id btuart_of_match_table[] = {
 	{ .compatible = "brcm,bcm43438-bt", .data = &bcm_vnd },
+	{ .compatible = "mediatek,mt7622-bluetooth", .data = &mtk_vnd },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, btuart_of_match_table);
-- 
2.7.4

