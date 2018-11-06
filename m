Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4CEC46464
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B55FA20862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QSfUwFcF";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="K06DETsK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B55FA20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730796AbeKFVal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 16:30:41 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:52004 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbeKFVak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 16:30:40 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 70A9060741; Tue,  6 Nov 2018 12:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541505946;
        bh=dYAMOUS13Op6H/79Zd5PyiWJiNNUXGEEFDZk0+TDHy8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QSfUwFcFnEm75roDyzPzvFkZFYVGHjvplUii4EX25pVdq9J5v7pcunDAoLPpFR2eR
         5UDETHaf+csU89zLnpE3pj/SMO9Z1Rg9dxBnRkWOJLDefcoFIg3eHSjmiVqeYx5VXp
         ZR4lPQZzJ55FUbyn5dgJoHafEj9N9cl9YBW33l2U=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9BA176053D;
        Tue,  6 Nov 2018 12:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541505945;
        bh=dYAMOUS13Op6H/79Zd5PyiWJiNNUXGEEFDZk0+TDHy8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K06DETsKuC7XfOk7JGZiCZ7jHvcbfcfGQSurxZHjLanZeEXkhP8pq1k0QajgQfOnR
         Duo7D+KDGMJd5VF0Er/9rQLC72HDWEXJpO3iil7pn+DDcoWX65Y2ZW4xgkp1ClTJvj
         DNJe6qW2u2TQaTsaKMXwgmlAqbj4tT+Fcw1cL62U=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9BA176053D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v1 2/4] Bluetooth: hci_qca: Pull RTS line high for baudrate change command
Date:   Tue,  6 Nov 2018 17:35:26 +0530
Message-Id: <20181106120528.30342-3-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181106120528.30342-1-bgodavar@codeaurora.org>
References: <20181106120528.30342-1-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch will pull the RTS line high instead of turning off the
flow control, while changing baudrate of host and chip.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---
 drivers/bluetooth/hci_qca.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 051f081d1835..8301663f0004 100644
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
@@ -1097,6 +1087,14 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 		if (!speed)
 			return 0;
 
+		/* Pulling RTS line to high is mandatory while sending change
+		 * baudrate request to SoC and also while setting the host
+		 * baudrate.
+		 */
+		qcadev = serdev_device_get_drvdata(hu->serdev);
+		if (qcadev->btsoc_type == QCA_WCN3990)
+			serdev_device_set_rts(hu->serdev, false);
+
 		qca_baudrate = qca_get_baudrate_value(speed);
 		bt_dev_dbg(hu->hdev, "Set UART speed to %d", speed);
 		ret = qca_set_baudrate(hu->hdev, qca_baudrate);
@@ -1104,6 +1102,9 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
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

