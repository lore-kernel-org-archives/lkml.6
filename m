Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB394C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 11:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC2720879
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 11:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hzP92zyx";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GAoaKLAF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732180AbeL1Lsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 06:48:35 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49110 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730740AbeL1Lsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 06:48:32 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C0F56607F1; Fri, 28 Dec 2018 11:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545997711;
        bh=P9mVx3x8GQpWeDs9HzDzOXqCEQYaxzmqm3jh5tLIGq0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hzP92zyxXmCz4+D/r9lffn4BnWAOYmQIuYv1mdE7wGm2XmvjWlNF2FoR+bQfMDe3y
         YH8g8eVr2Qfevw6IvDPJZcDbcC1RWalJJSN8vYxSgUiWCRZUJN9EPB6cH5uUqe2IME
         m2Z0weAAngYxaw5Y76zpfleGSNK6eRlCxgGgKxvQ=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8B9936037C;
        Fri, 28 Dec 2018 11:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545997710;
        bh=P9mVx3x8GQpWeDs9HzDzOXqCEQYaxzmqm3jh5tLIGq0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GAoaKLAFZ746xfRCZ6h2v5Ij+eMHaJKzu6vk1d61FPI1CJK3Ki+0sEKupTG8mbajD
         U1igvc1TkJcBO+PIxPiY41TyBL21P+kkwjkSqt51EbDRYheXaBnGPkmopP0sIhPOW5
         b25OWWcZ9RmwnOWJKf1YzewKDihnjDDL/WxmGJ5Q=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8B9936037C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v7 1/4] Bluetooth: hci_qca: use wait_until_sent() for power pulses
Date:   Fri, 28 Dec 2018 17:18:16 +0530
Message-Id: <20181228114819.17479-2-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181228114819.17479-1-bgodavar@codeaurora.org>
References: <20181228114819.17479-1-bgodavar@codeaurora.org>
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
Changes in v7:
 *  updated the wait time to 5 ms after sending power pulses.

Changes in v6:
 * added serdev_device_write_flush() in qca_send_power_pulse
   instead during the power off pulse.

Changes in v5:
 * added serdev_device_write_flush() in qca_power_off().
---
 drivers/bluetooth/hci_qca.c | 43 ++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 25 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index f036c8f98ea3..2aab34b3e696 100644
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
@@ -1029,22 +1027,23 @@ static int qca_send_power_pulse(struct hci_dev *hdev, u8 cmd)
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
+	serdev_device_wait_until_sent(hu->serdev, 0);
 
-	/* Wait for 100 uS for SoC to settle down */
-	usleep_range(100, 200);
+	/* Wait of 5ms is required for assuring to send the byte on the Tx
+	 * line and also for the controller to settle down for the received
+	 * byte.
+	 */
+	usleep_range(5000, 6000);
 	hci_uart_set_flow_control(hu, false);
 
 	return 0;
@@ -1116,7 +1115,6 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 
 static int qca_wcn3990_init(struct hci_uart *hu)
 {
-	struct hci_dev *hdev = hu->hdev;
 	struct qca_serdev *qcadev;
 	int ret;
 
@@ -1139,12 +1137,12 @@ static int qca_wcn3990_init(struct hci_uart *hu)
 
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
 
@@ -1274,13 +1272,8 @@ static const struct qca_vreg_data qca_soc_data = {
 
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

