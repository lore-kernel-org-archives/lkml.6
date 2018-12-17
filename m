Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB42C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1D8320874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LvDiZ3bp";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OftJ/QUn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387437AbeLQON6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 09:13:58 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:46942 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387409AbeLQON4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 09:13:56 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DB7A66071C; Mon, 17 Dec 2018 14:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545056035;
        bh=cha9YkKT0Mg0ydqFDNy/tLlbHyKKx+h32VQdZDbm6zc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LvDiZ3bpWLNs1NjKUJkEQEnbF3T3cSbLq6fx4qrJAXc7mzSivUeyBwAP7a7gi/kFt
         PxAkg4jdvrmBUh3d83jaY9/lx7WlJIJrnHwQjsSW52ToPV5saOLiXwS5PU+Rh4qe93
         3mvsFSsPw4YMmpy7yGcNSw3FllDHqC5GyyTThbfw=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 19232608CF;
        Mon, 17 Dec 2018 14:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545056032;
        bh=cha9YkKT0Mg0ydqFDNy/tLlbHyKKx+h32VQdZDbm6zc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OftJ/QUn5us5DkALaLkzPKCEuMJonHg85cS4cympCNeBdC+WUuvdP/z9YnWrbzXHo
         iAxRasv/DzldX/zBuDiz+ghOjvdf04OviNcBhqXEwJLBTMafxiG9pPZkrHccPCfM10
         crLOgi0Wey1Bn8OybcUhkr00lnmIE5/QsZrgQqIs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 19232608CF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, johan@kernel.org
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v4 2/5] Bluetooth: hci_qca: Deassert RTS while baudrate change command
Date:   Mon, 17 Dec 2018 19:43:27 +0530
Message-Id: <20181217141330.6294-3-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181217141330.6294-1-bgodavar@codeaurora.org>
References: <20181217141330.6294-1-bgodavar@codeaurora.org>
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
v4: 
 * no change
v3:
 * Updated comments in code to be more specific.
v2:
 * updated commit text and comments.
v1:
 * initial patch
---
 drivers/bluetooth/hci_qca.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index d8bc77c8c9b9..204fef3846e4 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -963,7 +963,6 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
 	struct hci_uart *hu = hci_get_drvdata(hdev);
 	struct qca_data *qca = hu->priv;
 	struct sk_buff *skb;
-	struct qca_serdev *qcadev;
 	u8 cmd[] = { 0x01, 0x48, 0xFC, 0x01, 0x00 };
 
 	if (baudrate > QCA_BAUDRATE_3200000)
@@ -977,13 +976,6 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
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
@@ -999,9 +991,6 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
 	schedule_timeout(msecs_to_jiffies(BAUDRATE_SETTLE_TIMEOUT_MS));
 	set_current_state(TASK_RUNNING);
 
-	if (qcadev->btsoc_type == QCA_WCN3990)
-		hci_uart_set_flow_control(hu, false);
-
 	return 0;
 }
 
@@ -1086,6 +1075,7 @@ static int qca_check_speeds(struct hci_uart *hu)
 static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 {
 	unsigned int speed, qca_baudrate;
+	struct qca_serdev *qcadev;
 	int ret;
 
 	if (speed_type == QCA_INIT_SPEED) {
@@ -1097,6 +1087,15 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
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
@@ -1104,6 +1103,9 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
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

