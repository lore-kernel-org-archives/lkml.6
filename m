Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D07FC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57EF42082F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbfBDO4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 09:56:08 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:56182 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727626AbfBDO4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 09:56:06 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 66570608CE; Mon,  4 Feb 2019 14:56:05 +0000 (UTC)
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E986E60791;
        Mon,  4 Feb 2019 14:56:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E986E60791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=qti.qualcomm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=fail smtp.mailfrom=bgodavar@qti.qualcomm.com
From:   Balakrishna Godavarthi <bgodavar@qti.qualcomm.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v10 1/3] Bluetooth: hci_qca: use wait_until_sent() for power pulses
Date:   Mon,  4 Feb 2019 20:25:49 +0530
Message-Id: <20190204145551.22342-2-bgodavar@qti.qualcomm.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190204145551.22342-1-bgodavar@qti.qualcomm.com>
References: <20190204145551.22342-1-bgodavar@qti.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Balakrishna Godavarthi <bgodavar@codeaurora.org>

wcn3990 requires a power pulse to turn ON/OFF along with
regulators. Sometimes we are observing the power pulses are sent
out with some time delay, due to queuing these commands. This is
causing synchronization issues with chip, which intern delay the
chip setup or may end up with communication issues.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v10:
Updated the wait time to 100 us for power pules.
---
 drivers/bluetooth/hci_qca.c | 38 +++++++++++++++----------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 53ac5ade532b..9a1c0a71b460 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -60,6 +60,7 @@
 #define IBS_WAKE_RETRANS_TIMEOUT_MS	100
 #define IBS_TX_IDLE_TIMEOUT_MS		2000
 #define BAUDRATE_SETTLE_TIMEOUT_MS	300
+#define POWER_PULSE_TRANS_TIMEOUT_MS	100
 
 /* susclk rate */
 #define SUSCLK_RATE_32KHZ	32768
@@ -1013,11 +1014,10 @@ static inline void host_set_baudrate(struct hci_uart *hu, unsigned int speed)
 		hci_uart_set_baudrate(hu, speed);
 }
 
-static int qca_send_power_pulse(struct hci_dev *hdev, u8 cmd)
+static int qca_send_power_pulse(struct hci_uart *hu, u8 cmd)
 {
-	struct hci_uart *hu = hci_get_drvdata(hdev);
-	struct qca_data *qca = hu->priv;
-	struct sk_buff *skb;
+	int ret;
+	int timeout = msecs_to_jiffies(POWER_PULSE_TRANS_TIMEOUT_MS);
 
 	/* These power pulses are single byte command which are sent
 	 * at required baudrate to wcn3990. On wcn3990, we have an external
@@ -1029,19 +1029,17 @@ static int qca_send_power_pulse(struct hci_dev *hdev, u8 cmd)
 	 * save power. Disabling hardware flow control is mandatory while
 	 * sending power pulses to SoC.
 	 */
-	bt_dev_dbg(hdev, "sending power pulse %02x to SoC", cmd);
-
-	skb = bt_skb_alloc(sizeof(cmd), GFP_KERNEL);
-	if (!skb)
-		return -ENOMEM;
+	bt_dev_dbg(hu->hdev, "sending power pulse %02x to controller", cmd);
 
+	serdev_device_write_flush(hu->serdev);
 	hci_uart_set_flow_control(hu, true);
+	ret = serdev_device_write_buf(hu->serdev, &cmd, sizeof(cmd));
+	if (ret < 0) {
+		bt_dev_err(hu->hdev, "failed to send power pulse %02x", cmd);
+		return ret;
+	}
 
-	skb_put_u8(skb, cmd);
-	hci_skb_pkt_type(skb) = HCI_COMMAND_PKT;
-
-	skb_queue_tail(&qca->txq, skb);
-	hci_uart_tx_wakeup(hu);
+	serdev_device_wait_until_sent(hu->serdev, timeout);
 
 	/* Wait for 100 uS for SoC to settle down */
 	usleep_range(100, 200);
@@ -1116,7 +1114,6 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 
 static int qca_wcn3990_init(struct hci_uart *hu)
 {
-	struct hci_dev *hdev = hu->hdev;
 	struct qca_serdev *qcadev;
 	int ret;
 
@@ -1139,12 +1136,12 @@ static int qca_wcn3990_init(struct hci_uart *hu)
 
 	/* Forcefully enable wcn3990 to enter in to boot mode. */
 	host_set_baudrate(hu, 2400);
-	ret = qca_send_power_pulse(hdev, QCA_WCN3990_POWEROFF_PULSE);
+	ret = qca_send_power_pulse(hu, QCA_WCN3990_POWEROFF_PULSE);
 	if (ret)
 		return ret;
 
 	qca_set_speed(hu, QCA_INIT_SPEED);
-	ret = qca_send_power_pulse(hdev, QCA_WCN3990_POWERON_PULSE);
+	ret = qca_send_power_pulse(hu, QCA_WCN3990_POWERON_PULSE);
 	if (ret)
 		return ret;
 
@@ -1277,13 +1274,8 @@ static const struct qca_vreg_data qca_soc_data = {
 
 static void qca_power_shutdown(struct hci_uart *hu)
 {
-	struct serdev_device *serdev = hu->serdev;
-	unsigned char cmd = QCA_WCN3990_POWEROFF_PULSE;
-
 	host_set_baudrate(hu, 2400);
-	hci_uart_set_flow_control(hu, true);
-	serdev_device_write_buf(serdev, &cmd, sizeof(cmd));
-	hci_uart_set_flow_control(hu, false);
+	qca_send_power_pulse(hu, QCA_WCN3990_POWEROFF_PULSE);
 	qca_power_setup(hu, false);
 }
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

