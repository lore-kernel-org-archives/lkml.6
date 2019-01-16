Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECCAC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6EAA20657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="H2kGoQ/s";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bQBQqbB/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392511AbfAPLqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 06:46:36 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:43406 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392489AbfAPLq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 06:46:29 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9515060886; Wed, 16 Jan 2019 11:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547639188;
        bh=qTq48uH68Jm0lhJqFd02ROWOATP2y9qQULkYxeOZe6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H2kGoQ/s5lp+hrHaxtEk2fUeSsLXDfRaMwWsi2DXhgSxX9gj1/JP1eASCIb09erdk
         UM29rXnpAB5B31/T/h/nxc7kORWJ6fsQcyEixhHFFfdrn+hckZPIGImpT471AoKlgC
         GIU6BJQFbaPL9Yt2qeDKe7sJC1RGSQT25ia1F+Zg=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F09CD6084F;
        Wed, 16 Jan 2019 11:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547639187;
        bh=qTq48uH68Jm0lhJqFd02ROWOATP2y9qQULkYxeOZe6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bQBQqbB/Q2t7ZywMgvvN0t1Z9VscGvGh11i6SdKnXMK8Q1ati08TPdntgjuPOqHTR
         jv7FgmXenglj44Kohj8HG/r6CZyFFmVKy7LIiIl3tsiBEu/YRzrJwcAsu6xj1BCMp0
         tKAY5bo1MbuvZLxUVUhxwx10YDzKrNkEADuTnY2U=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F09CD6084F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v8 2/3] Bluetooth: hci_qca: Deassert RTS while baudrate change command
Date:   Wed, 16 Jan 2019 17:16:02 +0530
Message-Id: <20190116114603.500-3-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190116114603.500-1-bgodavar@codeaurora.org>
References: <20190116114603.500-1-bgodavar@codeaurora.org>
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
Note: will keep this change for now. If any change required after further
      discussions i will update accordingly.
---
 drivers/bluetooth/hci_qca.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 681bfa30467e..7e4afcf40da2 100644
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
 
@@ -1091,6 +1080,7 @@ static int qca_check_speeds(struct hci_uart *hu)
 static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 {
 	unsigned int speed, qca_baudrate;
+	struct qca_serdev *qcadev;
 	int ret;
 
 	if (speed_type == QCA_INIT_SPEED) {
@@ -1102,6 +1092,15 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 		if (!speed)
 			return 0;
 
+		/* Deassert RTS while changing the baudrate of chip and host.
+		 * This will prevent chip from transmitting its response with
+		 * the new baudrate while the host port is still operating at
+		 * the old speed.
+		 */
+		qcadev = serdev_device_get_drvdata(hu->serdev);
+		if (qcadev->btsoc_type == QCA_WCN3990)
+			serdev_device_set_rts(hu->serdev, false);
+
 		qca_baudrate = qca_get_baudrate_value(speed);
 		bt_dev_dbg(hu->hdev, "Set UART speed to %d", speed);
 		ret = qca_set_baudrate(hu->hdev, qca_baudrate);
@@ -1109,6 +1108,9 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 			return ret;
 
 		host_set_baudrate(hu, speed);
+
+		if (qcadev->btsoc_type == QCA_WCN3990)
+			serdev_device_set_rts(hu->serdev, true);
 	}
 
 	return 0;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

