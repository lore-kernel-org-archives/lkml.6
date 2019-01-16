Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA8EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9094720657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Bl/qLLpF";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Cv9Lhyot"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392494AbfAPLq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 06:46:29 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:43292 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389613AbfAPLq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 06:46:27 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5EBB260112; Wed, 16 Jan 2019 11:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547639186;
        bh=muJ2CiEmaMEIWO0ldvwLSSVENmHq3SnVNoauTtTKjJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bl/qLLpFliGr43xDJpQPaSj4cft/P/kAMllnFkLgap9zWyaHxw0fI8YK/4o0RogrP
         Dxx7zbeVEArumw9TNwlk/BOP0+h4pb9DeCJznGv2T6DxMN5QJ6thKjaR9aFYTa9U4e
         Wiv4vktXvjgt1yz5MPv1UC87yuEHGjcqkdeVkszQ=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B00EB60807;
        Wed, 16 Jan 2019 11:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547639184;
        bh=muJ2CiEmaMEIWO0ldvwLSSVENmHq3SnVNoauTtTKjJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cv9LhyothRbazKzWXoq0s4Vz+X3TSS7WkoL72SGZq8erpvjWIld+GGcClX6xdmQEX
         w0ZSoPMzxkVn8zf6c6vE6X0lXmviHvohyvj3+X/LHYKaVkUjkMMqhAgSrp6uoSY8g9
         yn7TeV40pZyrpWhZYnpImeccQBA5ChVTWsHVAd2k=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B00EB60807
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v8 1/3] Bluetooth: hci_qca: use wait_until_sent() for power pulses
Date:   Wed, 16 Jan 2019 17:16:01 +0530
Message-Id: <20190116114603.500-2-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190116114603.500-1-bgodavar@codeaurora.org>
References: <20190116114603.500-1-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wcn3990 requires a power pulse to turn ON/OFF along with
regulators. Sometimes we are observing the power pulses are sent
out with some time delay, due to queuing these commands. This is
causing synchronization issues with chip, which intern delay the
chip setup or may end up with communication issues.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---
Changes in v8:
 * Updated 1 second timeout instead of indefinite wait.

Changes in v7:
 *  updated the wait time to 5 ms after sending power pulses.

Changes in v6:
 * added serdev_device_write_flush() in qca_send_power_pulse
   instead during the power off pulse.

Changes in v5:
 * added serdev_device_write_flush() in qca_power_off().
---
 drivers/bluetooth/hci_qca.c | 46 ++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 26 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index f036c8f98ea3..681bfa30467e 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -60,6 +60,7 @@
 #define IBS_WAKE_RETRANS_TIMEOUT_MS	100
 #define IBS_TX_IDLE_TIMEOUT_MS		2000
 #define BAUDRATE_SETTLE_TIMEOUT_MS	300
+#define POWER_PULSE_TRANS_TIMEOUT_MS	1000
 
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
+	int timeout = __msecs_to_jiffies(POWER_PULSE_TRANS_TIMEOUT_MS);
 
 	/* These power pulses are single byte command which are sent
 	 * at required baudrate to wcn3990. On wcn3990, we have an external
@@ -1029,22 +1029,22 @@ static int qca_send_power_pulse(struct hci_dev *hdev, u8 cmd)
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
-
-	/* Wait for 100 uS for SoC to settle down */
-	usleep_range(100, 200);
+	serdev_device_wait_until_sent(hu->serdev, timeout);
+	/* Wait of 5ms is required for assuring to send the byte on the Tx
+	 * line and also for the controller to settle down for the received
+	 * byte.
+	 */
+	usleep_range(5000, 6000);
 	hci_uart_set_flow_control(hu, false);
 
 	return 0;
@@ -1116,7 +1116,6 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 
 static int qca_wcn3990_init(struct hci_uart *hu)
 {
-	struct hci_dev *hdev = hu->hdev;
 	struct qca_serdev *qcadev;
 	int ret;
 
@@ -1139,12 +1138,12 @@ static int qca_wcn3990_init(struct hci_uart *hu)
 
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
 
@@ -1274,13 +1273,8 @@ static const struct qca_vreg_data qca_soc_data = {
 
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

