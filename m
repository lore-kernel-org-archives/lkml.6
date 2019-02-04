Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C92C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 642F12082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZQcggmn3";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Sxq6GNqe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731098AbfBDPHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 10:07:07 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:38842 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbfBDPHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 10:07:04 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6E3526090B; Mon,  4 Feb 2019 15:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549292823;
        bh=gBAjWmb5wZi7IM+pLlmP740rWD4a0iAgMw9l28gY5BQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZQcggmn3j0Fznstk3R9G6Ab2/FnrSkqhfh564XioFEmwfO3DSV05atVeRxUzLNPA/
         465HwuAwYwYwH5fCRwaClI0QUZPCRLEqEgmmH/9j5Bj8h/kPxtViIBxqUIDMkFOaaR
         HckwT9w9rD+vSFO2kbM1pU4yK6usaj0BHM5Fkdeo=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DA006608CE;
        Mon,  4 Feb 2019 15:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549292822;
        bh=gBAjWmb5wZi7IM+pLlmP740rWD4a0iAgMw9l28gY5BQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sxq6GNqeWsT8oZEHbI6mCXfe8Z2AOnnTGYZXcwI86LlPO12yL1uDLhq29/Cw3IxJE
         wEBsT65S3WrFgS+Wk8U014xHs4EPLVzjxorp+q9ifjfp6M8XJSahgXToGrmWtlrhKL
         52DBD0Lh2uFwJTQ3COyprAvobYhCi88xNK7BTLxg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DA006608CE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v11 2/3] Bluetooth: hci_qca: Deassert RTS while baudrate change command
Date:   Mon,  4 Feb 2019 20:36:42 +0530
Message-Id: <20190204150643.25165-3-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190204150643.25165-1-bgodavar@codeaurora.org>
References: <20190204150643.25165-1-bgodavar@codeaurora.org>
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
Changes in v10:
Enabled flow control back when the baudarte change request fails.
---
 drivers/bluetooth/hci_qca.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 9a1c0a71b460..e3cf0dbfc89d 100644
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
 
@@ -1089,7 +1078,8 @@ static int qca_check_speeds(struct hci_uart *hu)
 static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 {
 	unsigned int speed, qca_baudrate;
-	int ret;
+	struct qca_serdev *qcadev;
+	int ret = 0;
 
 	if (speed_type == QCA_INIT_SPEED) {
 		speed = qca_get_speed(hu, QCA_INIT_SPEED);
@@ -1100,16 +1090,27 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 		if (!speed)
 			return 0;
 
+		/* Disable flow control for wcn3990 to deassert RTS while
+		 * changing the baudrate of chip and host.
+		 */
+		qcadev = serdev_device_get_drvdata(hu->serdev);
+		if (qcadev->btsoc_type == QCA_WCN3990)
+			hci_uart_set_flow_control(hu, true);
+
 		qca_baudrate = qca_get_baudrate_value(speed);
 		bt_dev_dbg(hu->hdev, "Set UART speed to %d", speed);
 		ret = qca_set_baudrate(hu->hdev, qca_baudrate);
 		if (ret)
-			return ret;
+			goto error;
 
 		host_set_baudrate(hu, speed);
+
+error:
+		if (qcadev->btsoc_type == QCA_WCN3990)
+			hci_uart_set_flow_control(hu, false);
 	}
 
-	return 0;
+	return ret;
 }
 
 static int qca_wcn3990_init(struct hci_uart *hu)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

