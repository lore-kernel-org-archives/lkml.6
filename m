Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5CBC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 12:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9E6E2084A
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 12:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XakevzBv";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AaRR4Ccl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbfAXMId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 07:08:33 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:42788 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfAXMIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 07:08:31 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D62B2608C5; Thu, 24 Jan 2019 12:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548331710;
        bh=W0TXBimqIR7atPjUaU0V7GVX4mPcIJPM435+KKCgZDo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XakevzBvyQTfIGiDHW1m5lTrq4Oc0l3gEAamE+bHzrs0k4k3/7KxAmI3vd63RWBKi
         RYp9k46nFquXwjy6mUOW9JAAGajxgDktQ37wsRTU5/+XsgHdEO15zPA3OvQu+gOl87
         TMjQZciJpH5i9s/mzuMCq8i4qcCax5G5SFEphKQM=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C4E9E6086B;
        Thu, 24 Jan 2019 12:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548331708;
        bh=W0TXBimqIR7atPjUaU0V7GVX4mPcIJPM435+KKCgZDo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AaRR4CclYXNxqAsEwKXzwQF/KBwvNuNEtiM7J8tqaGisMYSgIBM91yZTK3eo2kSIY
         vzAifTxuIYmiP/SL1MbB0BMBC9lReYR7AG9phRHl75LJ5xkxWxoKL4nqmzv/Ipijgz
         lSXmrkZNyvVAhEgyogqA1DpG3MuRK9yJnMHYTdfc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C4E9E6086B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, johan@kernel.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v9 2/3] Bluetooth: hci_qca: Deassert RTS while baudrate change command
Date:   Thu, 24 Jan 2019 17:38:07 +0530
Message-Id: <20190124120808.8275-3-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190124120808.8275-1-bgodavar@codeaurora.org>
References: <20190124120808.8275-1-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch will help to stop frame reassembly errors while changing
the baudrate. This is because host send a change baudrate request
command to the chip with 115200 bps, Whereas chip will change their
UART clocks to the enable for new baudrate and sends the response
for the change request command with newer baudrate, On host side
we are still operating in 115200 bps which results of reading garbage
data. Here we are pulling RTS line, so that chip we will wait to send data
to host until host change its baudrate.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v9:
 * disabled flow control while setting the baudrate of HOST and chip.
---
 drivers/bluetooth/hci_qca.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index c08f4d105e73..6b5bcd44e24c 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -964,7 +964,6 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
 	struct hci_uart *hu = hci_get_drvdata(hdev);
 	struct qca_data *qca = hu->priv;
 	struct sk_buff *skb;
-	struct qca_serdev *qcadev;
 	u8 cmd[] = { 0x01, 0x48, 0xFC, 0x01, 0x00 };
 
 	if (baudrate > QCA_BAUDRATE_3200000)
@@ -978,13 +977,6 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
 		return -ENOMEM;
 	}
 
-	/* Disabling hardware flow control is mandatory while
-	 * sending change baudrate request to wcn3990 SoC.
-	 */
-	qcadev = serdev_device_get_drvdata(hu->serdev);
-	if (qcadev->btsoc_type == QCA_WCN3990)
-		hci_uart_set_flow_control(hu, true);
-
 	/* Assign commands to change baudrate and packet type. */
 	skb_put_data(skb, cmd, sizeof(cmd));
 	hci_skb_pkt_type(skb) = HCI_COMMAND_PKT;
@@ -1000,9 +992,6 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
 	schedule_timeout(msecs_to_jiffies(BAUDRATE_SETTLE_TIMEOUT_MS));
 	set_current_state(TASK_RUNNING);
 
-	if (qcadev->btsoc_type == QCA_WCN3990)
-		hci_uart_set_flow_control(hu, false);
-
 	return 0;
 }
 
@@ -1089,6 +1078,7 @@ static int qca_check_speeds(struct hci_uart *hu)
 static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 {
 	unsigned int speed, qca_baudrate;
+	struct qca_serdev *qcadev;
 	int ret;
 
 	if (speed_type == QCA_INIT_SPEED) {
@@ -1100,6 +1090,15 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 		if (!speed)
 			return 0;
 
+		/* Deassert RTS while changing the baudrate of chip and host.
+		 * This will prevent chip from transmitting its response with
+		 * the new baudrate while the host port is still operating at
+		 * the old speed.
+		 */
+		qcadev = serdev_device_get_drvdata(hu->serdev);
+		if (qcadev->btsoc_type == QCA_WCN3990)
+			hci_uart_set_flow_control(hu, true);
+
 		qca_baudrate = qca_get_baudrate_value(speed);
 		bt_dev_dbg(hu->hdev, "Set UART speed to %d", speed);
 		ret = qca_set_baudrate(hu->hdev, qca_baudrate);
@@ -1107,6 +1106,9 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 			return ret;
 
 		host_set_baudrate(hu, speed);
+
+		if (qcadev->btsoc_type == QCA_WCN3990)
+			hci_uart_set_flow_control(hu, false);
 	}
 
 	return 0;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

