Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA10C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 07:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8291E214AE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 07:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EH20Hhd9";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kcPKZLMi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729648AbeL0Hb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 02:31:56 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49642 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbeL0Hbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 02:31:55 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2B84E607F4; Thu, 27 Dec 2018 07:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545895914;
        bh=ITRLyryXN7uxSjs2MrZtJFrNfZRQS34o5eYyhezx0T8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EH20Hhd9ASvt5iXuQvSA0VZmw7+cxs4w1WImPmudPGs166P3dhwmT3QlMfz34YdYW
         L5xBlbkRqNYs9VmSQn7YA/jg7AHSfN/SU5I2YjOFUQ0OyWK5K1youVhG0h7Dc3Ii6k
         DriyBjua2eURcEr7ZtanFnvnS8Sm7RnRL2hvjXLk=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9FEC9604BE;
        Thu, 27 Dec 2018 07:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545895909;
        bh=ITRLyryXN7uxSjs2MrZtJFrNfZRQS34o5eYyhezx0T8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kcPKZLMi0WGZQyrYE3I6aOzla2WgIFjjGMSQGKv8i7BmC/MBC977grn/0vcvidrBx
         ZEJjSltkbIo/iaoPF6rchobDVxtMQ94B+f7hxA7ZR1ruzRKH2MpNpaY+bzCQODcqsr
         ke3oHmwiDFlCE6bkIiunp7AfLGmq0AkKojoQYDpY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9FEC9604BE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v6 1/6] Bluetooth: hci_qca: use wait_until_sent() for power pulses
Date:   Thu, 27 Dec 2018 13:01:31 +0530
Message-Id: <20181227073136.8431-2-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181227073136.8431-1-bgodavar@codeaurora.org>
References: <20181227073136.8431-1-bgodavar@codeaurora.org>
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
Changes in v6:
 * added serdev_device_write_flush() in qca_send_power_pulse
   instead during the power off pulse.

Changes in v5:
 * added serdev_device_write_flush() in qca_power_off().

---
 drivers/bluetooth/hci_qca.c | 38 ++++++++++++++-----------------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index f036c8f98ea3..507a2355c758 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1013,11 +1013,9 @@ static inline void host_set_baudrate(struct hci_uart *hu, unsigned int speed)
 		hci_uart_set_baudrate(hu, speed);
 }
 
-static int qca_send_power_pulse(struct hci_dev *hdev, u8 cmd)
+static int qca_send_power_pulse(struct hci_uart *hu, u8 cmd)
 {
-	struct hci_uart *hu = hci_get_drvdata(hdev);
-	struct qca_data *qca = hu->priv;
-	struct sk_buff *skb;
+	int ret;
 
 	/* These power pulses are single byte command which are sent
 	 * at required baudrate to wcn3990. On wcn3990, we have an external
@@ -1029,19 +1027,17 @@ static int qca_send_power_pulse(struct hci_dev *hdev, u8 cmd)
 	 * save power. Disabling hardware flow control is mandatory while
 	 * sending power pulses to SoC.
 	 */
-	bt_dev_dbg(hdev, "sending power pulse %02x to SoC", cmd);
-
-	skb = bt_skb_alloc(sizeof(cmd), GFP_KERNEL);
-	if (!skb)
-		return -ENOMEM;
-
+	serdev_device_write_flush(hu->serdev);
+	bt_dev_dbg(hu->hdev, "sending power pulse %02x to SoC", cmd);
 	hci_uart_set_flow_control(hu, true);
+	ret = serdev_device_write_buf(hu->serdev, &cmd, sizeof(cmd));
+	if (ret < 0) {
+		bt_dev_err(hu->hdev, "failed to send power pulse %02x to SoC",
+			   cmd);
+		return ret;
+	}
 
-	skb_put_u8(skb, cmd);
-	hci_skb_pkt_type(skb) = HCI_COMMAND_PKT;
-
-	skb_queue_tail(&qca->txq, skb);
-	hci_uart_tx_wakeup(hu);
+	serdev_device_wait_until_sent(hu->serdev, 0);
 
 	/* Wait for 100 uS for SoC to settle down */
 	usleep_range(100, 200);
@@ -1116,7 +1112,6 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 
 static int qca_wcn3990_init(struct hci_uart *hu)
 {
-	struct hci_dev *hdev = hu->hdev;
 	struct qca_serdev *qcadev;
 	int ret;
 
@@ -1139,12 +1134,12 @@ static int qca_wcn3990_init(struct hci_uart *hu)
 
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
 
@@ -1274,13 +1269,8 @@ static const struct qca_vreg_data qca_soc_data = {
 
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

