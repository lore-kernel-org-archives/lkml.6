Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702AFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 329A421872
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388093AbfBNXTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 18:19:55 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:49575 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728900AbfBNXTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 18:19:53 -0500
X-UUID: 815dceab5c944c48b649f04f7c173402-20190215
X-UUID: 815dceab5c944c48b649f04f7c173402-20190215
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1231095270; Fri, 15 Feb 2019 07:19:43 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 15 Feb 2019 07:19:43 +0800
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
Subject: [PATCH 6/6] Bluetooth: mediatek: add support for MediaTek MT7663U and MT7668U UART devices
Date:   Fri, 15 Feb 2019 07:19:38 +0800
Message-ID: <aa7ebe9c5935eae1df5528bf64ae9689996d06d7.1550184473.git.sean.wang@mediatek.com>
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

This adds the support of enabling MT7663U and MT7668U Bluetooth function
running on the top of btmtkuart driver.

There are a few differences between MT766[3,8]U and MT7622 where
MT766[3,8]U are standalone devices based on UART transport while MT7622
bluetooth is a built-in device on MediaTek SoC communicating with the host
through BTIF serial transport. Thus, extra setup sequence is necessary
for these standalone devices such as remote regulator and reset control via
GPIO, baud rate changing handshake between the host and device and so on.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/bluetooth/btmtkuart.c | 281 ++++++++++++++++++++++++++++++++--
 1 file changed, 271 insertions(+), 10 deletions(-)

diff --git a/drivers/bluetooth/btmtkuart.c b/drivers/bluetooth/btmtkuart.c
index e73b1013ba73..b0b680dd69f4 100644
--- a/drivers/bluetooth/btmtkuart.c
+++ b/drivers/bluetooth/btmtkuart.c
@@ -12,11 +12,15 @@
 #include <linux/atomic.h>
 #include <linux/clk.h>
 #include <linux/firmware.h>
+#include <linux/gpio/consumer.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
 #include <linux/serdev.h>
 #include <linux/skbuff.h>
 
@@ -25,18 +29,26 @@
 
 #include "h4_recv.h"
 
-#define VERSION "0.1"
+#define VERSION "0.2"
 
 #define FIRMWARE_MT7622		"mediatek/mt7622pr2h.bin"
+#define FIRMWARE_MT7663		"mediatek/mt7663pr2h.bin"
+#define FIRMWARE_MT7668		"mediatek/mt7668pr2h.bin"
 
 #define MTK_STP_TLR_SIZE	2
 
 #define BTMTKUART_TX_STATE_ACTIVE	1
 #define BTMTKUART_TX_STATE_WAKEUP	2
 #define BTMTKUART_TX_WAIT_VND_EVT	3
+#define BTMTKUART_REQUIRED_WAKEUP	4
+
+#define BTMTKUART_FLAG_STANDALONE_HW	 BIT(0)
 
 enum {
 	MTK_WMT_PATCH_DWNLD = 0x1,
+	MTK_WMT_TEST = 0x2,
+	MTK_WMT_WAKEUP = 0x3,
+	MTK_WMT_HIF = 0x4,
 	MTK_WMT_FUNC_CTRL = 0x6,
 	MTK_WMT_RST = 0x7,
 	MTK_WMT_SEMAPHORE = 0x17,
@@ -57,6 +69,11 @@ struct mtk_stp_hdr {
 	u8	cs;
 } __packed;
 
+struct btmtkuart_data {
+	unsigned int flags;
+	const char *fwname;
+};
+
 struct mtk_wmt_hdr {
 	u8	dir;
 	u8	op;
@@ -100,6 +117,14 @@ struct btmtkuart_dev {
 	struct serdev_device *serdev;
 	struct clk *clk;
 
+	struct regulator *vcc;
+	struct gpio_desc *reset;
+	struct pinctrl *pinctrl;
+	struct pinctrl_state *pins_runtime;
+	struct pinctrl_state *pins_boot;
+	speed_t	desired_speed;
+	speed_t	curr_speed;
+
 	struct work_struct tx_work;
 	unsigned long tx_state;
 	struct sk_buff_head txq;
@@ -110,8 +135,15 @@ struct btmtkuart_dev {
 	u8	stp_pad[6];
 	u8	stp_cursor;
 	u16	stp_dlen;
+
+	const struct btmtkuart_data *data;
 };
 
+#define btmtkuart_is_standalone(bdev)	\
+	((bdev)->data->flags & BTMTKUART_FLAG_STANDALONE_HW)
+#define btmtkuart_is_builtin_soc(bdev)	\
+	!((bdev)->data->flags & BTMTKUART_FLAG_STANDALONE_HW)
+
 static int mtk_hci_wmt_sync(struct hci_dev *hdev,
 			    struct btmtk_hci_wmt_params *wmt_params)
 {
@@ -202,7 +234,7 @@ static int mtk_hci_wmt_sync(struct hci_dev *hdev,
 	return err;
 }
 
-static int mtk_setup_fw(struct hci_dev *hdev)
+static int mtk_setup_firmware(struct hci_dev *hdev, const char *fwname)
 {
 	struct btmtk_hci_wmt_params wmt_params;
 	const struct firmware *fw;
@@ -211,7 +243,7 @@ static int mtk_setup_fw(struct hci_dev *hdev)
 	int err, dlen;
 	u8 flag;
 
-	err = request_firmware(&fw, FIRMWARE_MT7622, &hdev->dev);
+	err = request_firmware(&fw, fwname, &hdev->dev);
 	if (err < 0) {
 		bt_dev_err(hdev, "Failed to load firmware file (%d)", err);
 		return err;
@@ -523,6 +555,23 @@ static int btmtkuart_open(struct hci_dev *hdev)
 		goto err_open;
 	}
 
+	if (btmtkuart_is_standalone(bdev)) {
+		if (bdev->curr_speed != bdev->desired_speed)
+			err = serdev_device_set_baudrate(bdev->serdev,
+							 115200);
+		else
+			err = serdev_device_set_baudrate(bdev->serdev,
+							 bdev->desired_speed);
+
+		if (err < 0) {
+			bt_dev_err(hdev, "Unable to set baudrate UART device %s",
+				   dev_name(&bdev->serdev->dev));
+			goto  err_serdev_close;
+		}
+
+		serdev_device_set_flow_control(bdev->serdev, false);
+	}
+
 	bdev->stp_cursor = 2;
 	bdev->stp_dlen = 0;
 
@@ -546,6 +595,8 @@ static int btmtkuart_open(struct hci_dev *hdev)
 	pm_runtime_put_sync(dev);
 err_disable_rpm:
 	pm_runtime_disable(dev);
+err_serdev_close:
+	serdev_device_close(bdev->serdev);
 err_open:
 	return err;
 }
@@ -606,8 +657,74 @@ static int btmtkuart_func_query(struct hci_dev *hdev)
 	return status;
 }
 
+static int btmtkuart_change_baudrate(struct hci_dev *hdev)
+{
+	struct btmtkuart_dev *bdev = hci_get_drvdata(hdev);
+	struct btmtk_hci_wmt_params wmt_params;
+	u32 baudrate;
+	u8 param;
+	int err;
+
+	/* Indicate the device to enter the probe state the host is
+	 * ready to change a new baudrate.
+	 */
+	baudrate = cpu_to_le32(bdev->desired_speed);
+	wmt_params.op = MTK_WMT_HIF;
+	wmt_params.flag = 1;
+	wmt_params.dlen = 4;
+	wmt_params.data = &baudrate;
+	wmt_params.status = NULL;
+
+	err = mtk_hci_wmt_sync(hdev, &wmt_params);
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed to device baudrate (%d)", err);
+		return err;
+	}
+
+	err = serdev_device_set_baudrate(bdev->serdev,
+					 bdev->desired_speed);
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed to set up host baudrate (%d)",
+			   err);
+		return err;
+	}
+
+	serdev_device_set_flow_control(bdev->serdev, false);
+
+	/* Send a dummy byte 0xff to activate the new baudrate */
+	param = 0xff;
+	err = serdev_device_write(bdev->serdev, &param, sizeof(param),
+				  MAX_SCHEDULE_TIMEOUT);
+	if (err < 0 || err < sizeof(param))
+		return err;
+
+	serdev_device_wait_until_sent(bdev->serdev, 0);
+
+	/* Wait some time for the device changing baudrate done */
+	usleep_range(20000, 22000);
+
+	/* Test the new baudrate */
+	wmt_params.op = MTK_WMT_TEST;
+	wmt_params.flag = 7;
+	wmt_params.dlen = 0;
+	wmt_params.data = NULL;
+	wmt_params.status = NULL;
+
+	err = mtk_hci_wmt_sync(hdev, &wmt_params);
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed to test new baudrate (%d)",
+			   err);
+		return err;
+	}
+
+	bdev->curr_speed = bdev->desired_speed;
+
+	return 0;
+}
+
 static int btmtkuart_setup(struct hci_dev *hdev)
 {
+	struct btmtkuart_dev *bdev = hci_get_drvdata(hdev);
 	struct btmtk_hci_wmt_params wmt_params;
 	ktime_t calltime, delta, rettime;
 	struct btmtk_tci_sleep tci_sleep;
@@ -618,6 +735,28 @@ static int btmtkuart_setup(struct hci_dev *hdev)
 
 	calltime = ktime_get();
 
+	/* Wakeup MCUSYS is required for certain devices before we start to
+	 * do any setups.
+	 */
+	if (test_bit(BTMTKUART_REQUIRED_WAKEUP, &bdev->tx_state)) {
+		wmt_params.op = MTK_WMT_WAKEUP;
+		wmt_params.flag = 3;
+		wmt_params.dlen = 0;
+		wmt_params.data = NULL;
+		wmt_params.status = NULL;
+
+		err = mtk_hci_wmt_sync(hdev, &wmt_params);
+		if (err < 0) {
+			bt_dev_err(hdev, "Failed to wakeup the chip (%d)", err);
+			return err;
+		}
+
+		clear_bit(BTMTKUART_REQUIRED_WAKEUP, &bdev->tx_state);
+	}
+
+	if (btmtkuart_is_standalone(bdev))
+		btmtkuart_change_baudrate(hdev);
+
 	/* Query whether the firmware is already download */
 	wmt_params.op = MTK_WMT_SEMAPHORE;
 	wmt_params.flag = 1;
@@ -637,7 +776,7 @@ static int btmtkuart_setup(struct hci_dev *hdev)
 	}
 
 	/* Setup a firmware which the device definitely requires */
-	err = mtk_setup_fw(hdev);
+	err = mtk_setup_firmware(hdev, bdev->data->fwname);
 	if (err < 0)
 		return err;
 
@@ -754,24 +893,82 @@ static int btmtkuart_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	return 0;
 }
 
+static int btmtkuart_parse_dt(struct serdev_device *serdev)
+{
+	struct btmtkuart_dev *bdev = serdev_device_get_drvdata(serdev);
+	struct device_node *node = serdev->dev.of_node;
+	u32 speed = 921600;
+	int err;
+
+	if (btmtkuart_is_standalone(bdev)) {
+		of_property_read_u32(node, "current-speed", &speed);
+
+		bdev->desired_speed = speed;
+
+		bdev->vcc = devm_regulator_get(&serdev->dev, "vcc");
+		if (IS_ERR(bdev->vcc)) {
+			err = PTR_ERR(bdev->vcc);
+			return err;
+		}
+
+		bdev->pinctrl = devm_pinctrl_get(&serdev->dev);
+		if (IS_ERR(bdev->pinctrl)) {
+			err = PTR_ERR(bdev->pinctrl);
+			return err;
+		}
+
+		bdev->pins_boot = pinctrl_lookup_state(bdev->pinctrl,
+						       "default");
+		if (IS_ERR(bdev->pins_boot)) {
+			err = PTR_ERR(bdev->pins_boot);
+			return err;
+		}
+
+		bdev->pins_runtime = pinctrl_lookup_state(bdev->pinctrl,
+							  "runtime");
+		if (IS_ERR(bdev->pins_runtime)) {
+			err = PTR_ERR(bdev->pins_runtime);
+			return err;
+		}
+
+		bdev->reset = devm_gpiod_get_optional(&serdev->dev, "reset",
+						      GPIOD_OUT_LOW);
+		if (IS_ERR(bdev->reset)) {
+			err = PTR_ERR(bdev->reset);
+			return err;
+		}
+	} else if (btmtkuart_is_builtin_soc(bdev)) {
+		bdev->clk = devm_clk_get(&serdev->dev, "ref");
+		if (IS_ERR(bdev->clk))
+			return PTR_ERR(bdev->clk);
+	}
+
+	return 0;
+}
+
 static int btmtkuart_probe(struct serdev_device *serdev)
 {
 	struct btmtkuart_dev *bdev;
 	struct hci_dev *hdev;
+	int err;
 
 	bdev = devm_kzalloc(&serdev->dev, sizeof(*bdev), GFP_KERNEL);
 	if (!bdev)
 		return -ENOMEM;
 
-	bdev->clk = devm_clk_get(&serdev->dev, "ref");
-	if (IS_ERR(bdev->clk))
-		return PTR_ERR(bdev->clk);
+	bdev->data = of_device_get_match_data(&serdev->dev);
+	if (!bdev->data)
+		return -ENODEV;
 
 	bdev->serdev = serdev;
 	serdev_device_set_drvdata(serdev, bdev);
 
 	serdev_device_set_client_ops(serdev, &btmtkuart_client_ops);
 
+	err = btmtkuart_parse_dt(serdev);
+	if (err < 0)
+		return err;
+
 	INIT_WORK(&bdev->tx_work, btmtkuart_tx_work);
 	skb_queue_head_init(&bdev->txq);
 
@@ -798,13 +995,54 @@ static int btmtkuart_probe(struct serdev_device *serdev)
 	hdev->manufacturer = 70;
 	set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
 
-	if (hci_register_dev(hdev) < 0) {
+	if (btmtkuart_is_standalone(bdev)) {
+		/* Switch to the specific pin state for the booting requires */
+		pinctrl_select_state(bdev->pinctrl, bdev->pins_boot);
+
+		/* Power on */
+		err = regulator_enable(bdev->vcc);
+		if (err < 0)
+			return err;
+
+		/* Reset if the reset-gpios is available otherwise the board
+		 * -level design should be guaranteed.
+		 */
+		if (bdev->reset) {
+			gpiod_set_value_cansleep(bdev->reset, 1);
+			usleep_range(1000, 2000);
+			gpiod_set_value_cansleep(bdev->reset, 0);
+		}
+
+		/* Wait some time until device got ready and switch to the pin
+		 * mode the device requires for UART transfers.
+		 */
+		msleep(50);
+		pinctrl_select_state(bdev->pinctrl, bdev->pins_runtime);
+
+		/* A standalone device doesn't depends on power domain on SoC,
+		 * so mark it as no callbacks.
+		 */
+		pm_runtime_no_callbacks(&serdev->dev);
+
+		set_bit(BTMTKUART_REQUIRED_WAKEUP, &bdev->tx_state);
+	}
+
+	err = hci_register_dev(hdev);
+	if (err < 0) {
 		dev_err(&serdev->dev, "Can't register HCI device\n");
 		hci_free_dev(hdev);
-		return -ENODEV;
+		goto err_regulator_disable;
 	}
 
 	return 0;
+
+err_regulator_disable:
+	if (btmtkuart_is_standalone(bdev))  {
+		pinctrl_select_state(bdev->pinctrl, bdev->pins_boot);
+		regulator_disable(bdev->vcc);
+	}
+
+	return err;
 }
 
 static void btmtkuart_remove(struct serdev_device *serdev)
@@ -812,13 +1050,34 @@ static void btmtkuart_remove(struct serdev_device *serdev)
 	struct btmtkuart_dev *bdev = serdev_device_get_drvdata(serdev);
 	struct hci_dev *hdev = bdev->hdev;
 
+	if (btmtkuart_is_standalone(bdev))  {
+		pinctrl_select_state(bdev->pinctrl, bdev->pins_boot);
+		regulator_disable(bdev->vcc);
+	}
+
 	hci_unregister_dev(hdev);
 	hci_free_dev(hdev);
 }
 
+static const struct btmtkuart_data mt7622_data = {
+	.fwname = FIRMWARE_MT7622,
+};
+
+static const struct btmtkuart_data mt7663_data = {
+	.flags = BTMTKUART_FLAG_STANDALONE_HW,
+	.fwname = FIRMWARE_MT7663,
+};
+
+static const struct btmtkuart_data mt7668_data = {
+	.flags = BTMTKUART_FLAG_STANDALONE_HW,
+	.fwname = FIRMWARE_MT7668,
+};
+
 #ifdef CONFIG_OF
 static const struct of_device_id mtk_of_match_table[] = {
-	{ .compatible = "mediatek,mt7622-bluetooth"},
+	{ .compatible = "mediatek,mt7622-bluetooth", .data = &mt7622_data},
+	{ .compatible = "mediatek,mt7663u-bluetooth", .data = &mt7663_data},
+	{ .compatible = "mediatek,mt7668u-bluetooth", .data = &mt7668_data},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, mtk_of_match_table);
@@ -840,3 +1099,5 @@ MODULE_DESCRIPTION("MediaTek Bluetooth Serial driver ver " VERSION);
 MODULE_VERSION(VERSION);
 MODULE_LICENSE("GPL");
 MODULE_FIRMWARE(FIRMWARE_MT7622);
+MODULE_FIRMWARE(FIRMWARE_MT7663);
+MODULE_FIRMWARE(FIRMWARE_MT7668);
-- 
2.18.0

