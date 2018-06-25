Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8D0C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21B1625A9D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jbk/7rK4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZJeLSmv2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21B1625A9D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755652AbeFYNkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 09:40:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43676 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934142AbeFYNku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 09:40:50 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F181160712; Mon, 25 Jun 2018 13:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529934050;
        bh=cpnrg5ikot5QMLeg2HI6P1ZftYO9keWxJcoSS+NMOLU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jbk/7rK46nVpyJ5LpSkSAHO+6jrD1nJyeaTsowFPk+NAh7zs146z/ngA0jnMUtAOn
         50+IVxfgofoUhOSLpDwPaG/G76eojUXds/72HhCHtoggsMKlaX7d49G6duToUtbPxi
         R9qfsG3DoAiIau8Rx+JgJ/sO9pCqB5qRiNrpybeA=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3B24060712;
        Mon, 25 Jun 2018 13:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529934048;
        bh=cpnrg5ikot5QMLeg2HI6P1ZftYO9keWxJcoSS+NMOLU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZJeLSmv2my8rR2Vzdo1juHPNYkzQwWWR1Th5OHHtDh/PaSc2mPwfwrSBVhL8Uj0dJ
         syvbF8b6qfWXCk0/Y+KGWg5fS8mKNGOaGiD4jLoXUQ42Tg0qDphw5CWu26Bytfc2k/
         t/hPVKXaQSFj1r4OfMpQZoav2uVK7Tc+ztSpDL1Q=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3B24060712
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, mka@chromium.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, rtatiya@codeaurora.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v8 7/7] Bluetooth: hci_qca: Add support for Qualcomm Bluetooth chip wcn3990
Date:   Mon, 25 Jun 2018 19:10:13 +0530
Message-Id: <20180625134013.19684-8-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180625134013.19684-1-bgodavar@codeaurora.org>
References: <20180625134013.19684-1-bgodavar@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to set voltage/current of various regulators
to power up/down Bluetooth chip wcn3990.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---
changes in v8:
    * closing qca buffer, if qca_power_setup fails
    * chnaged ibs start timer function call location.
    * updated review comments.
  	
changes in v7:
    * addressed review comments.

changes in v6:
    * Hooked up qca_power to qca_serdev.
    * renamed all the naming inconsistency functions with qca_*
    * leveraged common code of ROME for wcn3990.
    * created wrapper functions for re-usable blocks.
    * updated function of _*regulator_enable and _*regualtor_disable.  
    * removed redundant comments and functions.
    * addressed review comments.

Changes in v5:
    * updated regulator vddpa min_uV to 1304000.
      * addressed review comments.
 
Changes in v4:
    * Segregated the changes of btqca from hci_qca
    * rebased all changes on top of bluetooth-next.
    * addressed review comments.

---
 drivers/bluetooth/btqca.h   |   3 +
 drivers/bluetooth/hci_qca.c | 346 ++++++++++++++++++++++++++++++++----
 2 files changed, 312 insertions(+), 37 deletions(-)

diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
index 24d6667eecf1..ba6bdbef9869 100644
--- a/drivers/bluetooth/btqca.h
+++ b/drivers/bluetooth/btqca.h
@@ -37,6 +37,9 @@
 #define EDL_TAG_ID_HCI			(17)
 #define EDL_TAG_ID_DEEP_SLEEP		(27)
 
+#define QCA_WCN3990_POWERON_PULSE	0xFC
+#define QCA_WCN3990_POWEROFF_PULSE	0xC0
+
 enum qca_bardrate {
 	QCA_BAUDRATE_115200 	= 0,
 	QCA_BAUDRATE_57600,
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 28187a89b850..bd4c9a78716f 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -5,7 +5,7 @@
  *  protocol extension to H4.
  *
  *  Copyright (C) 2007 Texas Instruments, Inc.
- *  Copyright (c) 2010, 2012 The Linux Foundation. All rights reserved.
+ *  Copyright (c) 2010, 2012, 2018 The Linux Foundation. All rights reserved.
  *
  *  Acknowledgements:
  *  This file is based on hci_ll.c, which was...
@@ -31,9 +31,14 @@
 #include <linux/kernel.h>
 #include <linux/clk.h>
 #include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/device.h>
 #include <linux/gpio/consumer.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
 #include <linux/serdev.h>
 
 #include <net/bluetooth/bluetooth.h>
@@ -124,12 +129,46 @@ enum qca_speed_type {
 	QCA_OPER_SPEED
 };
 
+/*
+ * Voltage regulator information required for configuring the
+ * QCA Bluetooth chipset
+ */
+struct qca_vreg {
+	const char *name;
+	unsigned int min_uV;
+	unsigned int max_uV;
+	unsigned int load_uA;
+};
+
+struct qca_vreg_data {
+	enum qca_btsoc_type soc_type;
+	struct qca_vreg *vregs;
+	size_t num_vregs;
+};
+
+/*
+ * Platform data for the QCA Bluetooth power driver.
+ */
+struct qca_power {
+	struct device *dev;
+	const struct qca_vreg_data *vreg_data;
+	struct regulator_bulk_data *vreg_bulk;
+	bool vregs_on;
+};
+
 struct qca_serdev {
 	struct hci_uart	 serdev_hu;
 	struct gpio_desc *bt_en;
 	struct clk	 *susclk;
+	enum qca_btsoc_type btsoc_type;
+	struct qca_power *bt_power;
+	u32 init_speed;
+	u32 oper_speed;
 };
 
+static int qca_power_setup(struct hci_uart *hu, bool on);
+static void qca_power_shutdown(struct hci_uart *hu);
+
 static void __serial_clock_on(struct tty_struct *tty)
 {
 	/* TODO: Some chipset requires to enable UART clock on client
@@ -407,6 +446,7 @@ static int qca_open(struct hci_uart *hu)
 {
 	struct qca_serdev *qcadev;
 	struct qca_data *qca;
+	int ret;
 
 	BT_DBG("hu %p qca_open", hu);
 
@@ -458,19 +498,32 @@ static int qca_open(struct hci_uart *hu)
 
 	hu->priv = qca;
 
-	timer_setup(&qca->wake_retrans_timer, hci_ibs_wake_retrans_timeout, 0);
-	qca->wake_retrans = IBS_WAKE_RETRANS_TIMEOUT_MS;
-
-	timer_setup(&qca->tx_idle_timer, hci_ibs_tx_idle_timeout, 0);
-	qca->tx_idle_delay = IBS_TX_IDLE_TIMEOUT_MS;
-
 	if (hu->serdev) {
 		serdev_device_open(hu->serdev);
 
 		qcadev = serdev_device_get_drvdata(hu->serdev);
-		gpiod_set_value_cansleep(qcadev->bt_en, 1);
+		if (qcadev->btsoc_type != QCA_WCN3990) {
+			gpiod_set_value_cansleep(qcadev->bt_en, 1);
+		} else {
+			hu->init_speed = qcadev->init_speed;
+			hu->oper_speed = qcadev->oper_speed;
+			ret = qca_power_setup(hu, true);
+			if (ret) {
+				destroy_workqueue(qca->workqueue);
+				kfree_skb(qca->rx_skb);
+				hu->priv = NULL;
+				kfree(qca);
+				return ret;
+			}
+		}
 	}
 
+	timer_setup(&qca->wake_retrans_timer, hci_ibs_wake_retrans_timeout, 0);
+	qca->wake_retrans = IBS_WAKE_RETRANS_TIMEOUT_MS;
+
+	timer_setup(&qca->tx_idle_timer, hci_ibs_tx_idle_timeout, 0);
+	qca->tx_idle_delay = IBS_TX_IDLE_TIMEOUT_MS;
+
 	BT_DBG("HCI_UART_QCA open, tx_idle_delay=%u, wake_retrans=%u",
 	       qca->tx_idle_delay, qca->wake_retrans);
 
@@ -554,10 +607,13 @@ static int qca_close(struct hci_uart *hu)
 	qca->hu = NULL;
 
 	if (hu->serdev) {
-		serdev_device_close(hu->serdev);
-
 		qcadev = serdev_device_get_drvdata(hu->serdev);
-		gpiod_set_value_cansleep(qcadev->bt_en, 0);
+		if (qcadev->btsoc_type == QCA_WCN3990)
+			qca_power_shutdown(hu);
+		else
+			gpiod_set_value_cansleep(qcadev->bt_en, 0);
+
+		serdev_device_close(hu->serdev);
 	}
 
 	kfree_skb(qca->rx_skb);
@@ -930,6 +986,32 @@ static inline void host_set_baudrate(struct hci_uart *hu, unsigned int speed)
 		hci_uart_set_baudrate(hu, speed);
 }
 
+static int qca_send_vendor_cmd(struct hci_dev *hdev, u8 cmd)
+{
+	struct hci_uart *hu = hci_get_drvdata(hdev);
+	struct qca_data *qca = hu->priv;
+	struct sk_buff *skb;
+
+	bt_dev_dbg(hdev, "sending command %02x to SoC", cmd);
+
+	skb = bt_skb_alloc(sizeof(cmd), GFP_KERNEL);
+	if (!skb) {
+		bt_dev_err(hdev, "Failed to allocate memory for vendor packet");
+		return -ENOMEM;
+	}
+
+	skb_put_u8(skb, cmd);
+	hci_skb_pkt_type(skb) = HCI_COMMAND_PKT;
+
+	skb_queue_tail(&qca->txq, skb);
+	hci_uart_tx_wakeup(hu);
+
+	/* Wait for 100 uS for SoC to settle down */
+	usleep_range(100, 200);
+
+	return 0;
+}
+
 static unsigned int qca_get_speed(struct hci_uart *hu,
 				  enum qca_speed_type speed_type)
 {
@@ -952,6 +1034,7 @@ static unsigned int qca_get_speed(struct hci_uart *hu,
 
 static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 {
+	struct qca_serdev *qcadev;
 	unsigned int speed, qca_baudrate;
 	int ret;
 
@@ -971,6 +1054,13 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 		return 0;
 	}
 
+	qcadev = serdev_device_get_drvdata(hu->serdev);
+	/* Disabling hardware flow control is preferred while
+	 * sending change baud rate command to SoC.
+	 */
+	if (qcadev->btsoc_type == QCA_WCN3990)
+		hci_uart_set_flow_control(hu, true);
+
 	qca_baudrate = qca_get_baudrate_value(speed);
 	bt_dev_info(hu->hdev, "Set UART speed to %d", speed);
 	ret = qca_set_baudrate(hu->hdev, qca_baudrate);
@@ -980,8 +1070,10 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 	}
 
 	host_set_baudrate(hu, speed);
+	if (qcadev->btsoc_type == QCA_WCN3990)
+		hci_uart_set_flow_control(hu, false);
 
-	return ret;
+	return 0;
 }
 
 static int qca_setup(struct hci_uart *hu)
@@ -989,10 +1081,11 @@ static int qca_setup(struct hci_uart *hu)
 	struct hci_dev *hdev = hu->hdev;
 	struct qca_data *qca = hu->priv;
 	unsigned int speed, qca_baudrate = QCA_BAUDRATE_115200;
+	struct qca_serdev *qcadev;
 	int ret;
 	int soc_ver = 0;
 
-	bt_dev_info(hdev, "ROME setup");
+	qcadev = serdev_device_get_drvdata(hu->serdev);
 
 	/* Patch downloading has to be done without IBS mode */
 	clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
@@ -1000,6 +1093,35 @@ static int qca_setup(struct hci_uart *hu)
 	/* Setup initial baudrate */
 	qca_set_speed(hu, QCA_INIT_SPEED);
 
+	if (qcadev->btsoc_type == QCA_WCN3990) {
+		bt_dev_dbg(hdev, "setting up wcn3990");
+		hci_uart_set_flow_control(hu, true);
+		ret = qca_send_vendor_cmd(hdev, QCA_WCN3990_POWERON_PULSE);
+		if (ret)
+			return ret;
+
+		hci_uart_set_flow_control(hu, false);
+		serdev_device_close(hu->serdev);
+		ret = serdev_device_open(hu->serdev);
+		if (ret) {
+			bt_dev_err(hdev, "failed to open port");
+			return ret;
+		}
+
+		msleep(100);
+		/* Setup initial baudrate */
+		qca_set_speed(hu, QCA_INIT_SPEED);
+		hci_uart_set_flow_control(hu, false);
+		ret = qca_read_soc_version(hdev, &soc_ver);
+		if (ret < 0 || soc_ver == 0) {
+			bt_dev_err(hdev, "Failed to get version %d", ret);
+			return ret;
+		}
+		bt_dev_info(hdev, "wcn3990 controller version 0x%08x", soc_ver);
+	} else {
+		bt_dev_info(hdev, "ROME setup");
+	}
+
 	/* Setup user speed if needed */
 	ret = qca_set_speed(hu, QCA_OPER_SPEED);
 	if (ret)
@@ -1010,7 +1132,7 @@ static int qca_setup(struct hci_uart *hu)
 		qca_baudrate = qca_get_baudrate_value(speed);
 
 	/* Setup patch / NVM configurations */
-	ret = qca_uart_setup(hdev, qca_baudrate, QCA_ROME, soc_ver);
+	ret = qca_uart_setup(hdev, qca_baudrate, qcadev->btsoc_type, soc_ver);
 	if (!ret) {
 		set_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
 		qca_debugfs_init(hdev);
@@ -1046,9 +1168,124 @@ static struct hci_uart_proto qca_proto = {
 	.dequeue	= qca_dequeue,
 };
 
+static const struct qca_vreg_data qca_soc_data = {
+	.soc_type = QCA_WCN3990,
+	.vregs = (struct qca_vreg []) {
+		{ "vddio",   1352000, 1352000,  0 },
+		{ "vddxtal", 1904000, 2040000,  0 },
+		{ "vddcore", 1800000, 1800000,  1 },
+		{ "vddpa",   1304000, 1304000,  1 },
+		{ "vddldo",  3000000, 3312000,  1 },
+	},
+	.num_vregs = 5,
+};
+
+static void qca_power_shutdown(struct hci_uart *hu)
+{
+	struct hci_dev *hdev = hu->hdev;
+
+	host_set_baudrate(hu, 2400);
+	qca_send_vendor_cmd(hdev, QCA_WCN3990_POWEROFF_PULSE);
+	qca_power_setup(hu, false);
+}
+
+static int qca_enable_regulator(struct qca_vreg vregs,
+				struct regulator *regulator)
+{
+	int ret;
+
+	ret = regulator_set_voltage(regulator, vregs.min_uV,
+				    vregs.max_uV);
+	if (ret)
+		return ret;
+
+	if (vregs.load_uA)
+		ret = regulator_set_load(regulator,
+					 vregs.load_uA);
+
+	if (ret)
+		return ret;
+
+	return regulator_enable(regulator);
+
+}
+
+static void qca_disable_regulator(struct qca_vreg vregs,
+				  struct regulator *regulator)
+{
+	regulator_disable(regulator);
+	regulator_set_voltage(regulator, 0, vregs.max_uV);
+	if (vregs.load_uA)
+		regulator_set_load(regulator, 0);
+
+}
+
+static int qca_power_setup(struct hci_uart *hu, bool on)
+{
+	struct qca_vreg *vregs;
+	struct regulator_bulk_data *vreg_bulk;
+	struct qca_serdev *qcadev;
+	int i, num_vregs, ret = 0;
+
+	qcadev = serdev_device_get_drvdata(hu->serdev);
+	if (!qcadev || !qcadev->bt_power || !qcadev->bt_power->vreg_data ||
+	    !qcadev->bt_power->vreg_bulk)
+		return -EINVAL;
+
+	vregs = qcadev->bt_power->vreg_data->vregs;
+	vreg_bulk = qcadev->bt_power->vreg_bulk;
+	num_vregs = qcadev->bt_power->vreg_data->num_vregs;
+	BT_DBG("on: %d", on);
+	if (on  && !qcadev->bt_power->vregs_on) {
+		for (i = 0; i < num_vregs; i++) {
+			ret = qca_enable_regulator(vregs[i],
+						   vreg_bulk[i].consumer);
+			if (ret)
+				break;
+		}
+
+		if (ret) {
+			BT_ERR("failed to enable regulator:%s", vregs[i].name);
+			/* turn off regulators which are enabled */
+			for (i = i - 1; i >= 0; i--)
+				qca_disable_regulator(vregs[i],
+						      vreg_bulk[i].consumer);
+		} else {
+			qcadev->bt_power->vregs_on = true;
+		}
+	} else if (!on && qcadev->bt_power->vregs_on) {
+		/* turn off regulator in reverse order */
+		i = qcadev->bt_power->vreg_data->num_vregs - 1;
+		for ( ; i >= 0; i--)
+			qca_disable_regulator(vregs[i], vreg_bulk[i].consumer);
+
+		qcadev->bt_power->vregs_on = false;
+	}
+
+	return ret;
+}
+
+static int qca_init_regulators(struct qca_power *qca,
+			       const struct qca_vreg *vregs, size_t num_vregs)
+{
+	int i;
+
+	qca->vreg_bulk = devm_kzalloc(qca->dev, num_vregs *
+				      sizeof(struct regulator_bulk_data),
+				      GFP_KERNEL);
+	if (!qca->vreg_bulk)
+		return -ENOMEM;
+
+	for (i = 0; i < num_vregs; i++)
+		qca->vreg_bulk[i].supply = vregs[i].name;
+
+	return devm_regulator_bulk_get(qca->dev, num_vregs, qca->vreg_bulk);
+}
+
 static int qca_serdev_probe(struct serdev_device *serdev)
 {
 	struct qca_serdev *qcadev;
+	const struct qca_vreg_data *data;
 	int err;
 
 	qcadev = devm_kzalloc(&serdev->dev, sizeof(*qcadev), GFP_KERNEL);
@@ -1056,47 +1293,82 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		return -ENOMEM;
 
 	qcadev->serdev_hu.serdev = serdev;
+	data = of_device_get_match_data(&serdev->dev);
 	serdev_device_set_drvdata(serdev, qcadev);
+	if (data && data->soc_type == QCA_WCN3990) {
+		qcadev->btsoc_type = QCA_WCN3990;
+		qcadev->bt_power = devm_kzalloc(&serdev->dev,
+						sizeof(struct qca_power),
+						GFP_KERNEL);
+		if (!qcadev->bt_power)
+			return -ENOMEM;
+
+		qcadev->bt_power->dev = &serdev->dev;
+		qcadev->bt_power->vreg_data = data;
+		err = qca_init_regulators(qcadev->bt_power, data->vregs,
+					  data->num_vregs);
+		if (err) {
+			BT_ERR("Failed to init regulators:%d", err);
+			goto out;
+		}
 
-	qcadev->bt_en = devm_gpiod_get(&serdev->dev, "enable",
-				       GPIOD_OUT_LOW);
-	if (IS_ERR(qcadev->bt_en)) {
-		dev_err(&serdev->dev, "failed to acquire enable gpio\n");
-		return PTR_ERR(qcadev->bt_en);
-	}
+		qcadev->bt_power->vregs_on = false;
+		device_property_read_u32(&serdev->dev, "max-speed",
+					 &qcadev->oper_speed);
+		if (!qcadev->oper_speed)
+			BT_INFO("UART will pick default operating speed");
+		err = hci_uart_register_device(&qcadev->serdev_hu, &qca_proto);
+		if (err) {
+			BT_ERR("wcn3990 serdev registration failed");
+			goto out;
+		}
+	} else {
+		qcadev->btsoc_type = QCA_ROME;
+		qcadev->bt_en = devm_gpiod_get(&serdev->dev, "enable",
+					       GPIOD_OUT_LOW);
+		if (IS_ERR(qcadev->bt_en)) {
+			dev_err(&serdev->dev, "failed to acquire enable gpio\n");
+			return PTR_ERR(qcadev->bt_en);
+		}
 
-	qcadev->susclk = devm_clk_get(&serdev->dev, NULL);
-	if (IS_ERR(qcadev->susclk)) {
-		dev_err(&serdev->dev, "failed to acquire clk\n");
-		return PTR_ERR(qcadev->susclk);
-	}
+		qcadev->susclk = devm_clk_get(&serdev->dev, NULL);
+		if (IS_ERR(qcadev->susclk)) {
+			dev_err(&serdev->dev, "failed to acquire clk\n");
+			return PTR_ERR(qcadev->susclk);
+		}
 
-	err = clk_set_rate(qcadev->susclk, SUSCLK_RATE_32KHZ);
-	if (err)
-		return err;
+		err = clk_set_rate(qcadev->susclk, SUSCLK_RATE_32KHZ);
+		if (err)
+			return err;
 
-	err = clk_prepare_enable(qcadev->susclk);
-	if (err)
-		return err;
+		err = clk_prepare_enable(qcadev->susclk);
+		if (err)
+			return err;
 
-	err = hci_uart_register_device(&qcadev->serdev_hu, &qca_proto);
-	if (err)
-		clk_disable_unprepare(qcadev->susclk);
+		err = hci_uart_register_device(&qcadev->serdev_hu, &qca_proto);
+		if (err)
+			clk_disable_unprepare(qcadev->susclk);
+	}
+
+out:	return err;
 
-	return err;
 }
 
 static void qca_serdev_remove(struct serdev_device *serdev)
 {
 	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
 
-	hci_uart_unregister_device(&qcadev->serdev_hu);
+	if (qcadev->btsoc_type == QCA_WCN3990)
+		qca_power_shutdown(&qcadev->serdev_hu);
+	else
+		clk_disable_unprepare(qcadev->susclk);
 
-	clk_disable_unprepare(qcadev->susclk);
+	hci_uart_unregister_device(&qcadev->serdev_hu);
 }
 
 static const struct of_device_id qca_bluetooth_of_match[] = {
 	{ .compatible = "qcom,qca6174-bt" },
+	{ .compatible = "qcom,wcn3990-bt", .data = &qca_soc_data},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, qca_bluetooth_of_match);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

