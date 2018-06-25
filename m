Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD94C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE82E25A9E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="C6cvzapc";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mEHlj2aS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE82E25A9E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934179AbeFYNli (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 09:41:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43420 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933996AbeFYNkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 09:40:39 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A748D6071C; Mon, 25 Jun 2018 13:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529934038;
        bh=urgRVwFj9YbFwxeCSV5jAVLLGFHkI3lZIBuDMn/yfIo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C6cvzapcGF1U3cy5X01BvatYwTd3yS5dYFnKYlQ/3Jdf2MXJI7O+GbhCadeMU1XT4
         IxnXDVClSSFVSF26hrUZJQM+5/97WliQHfGW6Kc0bh4G6WONLGkZtTlSqtcR+eOKBA
         Z+5WLTHxXeILkmLoOv6Azads7LCNkZgHU0J/BPWQ=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 309E060712;
        Mon, 25 Jun 2018 13:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529934037;
        bh=urgRVwFj9YbFwxeCSV5jAVLLGFHkI3lZIBuDMn/yfIo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mEHlj2aSf4TMG2efbxQwEcqj4ADQe5QNn9cVPtKeGPulO+e/eCdt2Fk7PttyFsMag
         /YCWSnXBRhHcZAelSV4efoZEEORAu6SNlNOA3WEGKkHpBxmA+ALNgWEyFu+m2v1iGU
         Gi8rZrvk0OSF6DRSY63YqsN6cs/UGioffIkKClyU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 309E060712
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, mka@chromium.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, rtatiya@codeaurora.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v8 4/7] Bluetooth: hci_qca: Add wrapper functions for setting UART speed
Date:   Mon, 25 Jun 2018 19:10:10 +0530
Message-Id: <20180625134013.19684-5-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180625134013.19684-1-bgodavar@codeaurora.org>
References: <20180625134013.19684-1-bgodavar@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function qca_setup, we set initial and operating speeds for Qualcomm
Bluetooth SoC's. This block of code is common across different
Qualcomm Bluetooth SoC's. Instead of duplicating the code, created
a wrapper function to set the speeds. So that future coming SoC's
can use these wrapper functions to set speeds.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---
Changes in v8:
    * common function to set INIT and operating speeds.
    * moved hardware flow control to qca_set_speed().
	
Changes in v7:
    * initial patch
    * created wrapper functions for init and operating speeds.
---
 drivers/bluetooth/hci_qca.c | 89 +++++++++++++++++++++++++++----------
 1 file changed, 65 insertions(+), 24 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index fe62420ef838..38b7dbe6c897 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -119,6 +119,11 @@ struct qca_data {
 	u64 votes_off;
 };
 
+enum qca_speed_type {
+	QCA_INIT_SPEED = 1,
+	QCA_OPER_SPEED
+};
+
 struct qca_serdev {
 	struct hci_uart	 serdev_hu;
 	struct gpio_desc *bt_en;
@@ -923,6 +928,60 @@ static inline void host_set_baudrate(struct hci_uart *hu, unsigned int speed)
 		hci_uart_set_baudrate(hu, speed);
 }
 
+static unsigned int qca_get_speed(struct hci_uart *hu,
+				  enum qca_speed_type speed_type)
+{
+	unsigned int speed = 0;
+
+	if (speed_type == QCA_INIT_SPEED) {
+		if (hu->init_speed)
+			speed = hu->init_speed;
+		else if (hu->proto->init_speed)
+			speed = hu->proto->init_speed;
+	} else {
+		if (hu->oper_speed)
+			speed = hu->oper_speed;
+		else if (hu->proto->oper_speed)
+			speed = hu->proto->oper_speed;
+	}
+
+	return speed;
+}
+
+static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
+{
+	unsigned int speed, qca_baudrate;
+	int ret;
+
+	if (speed_type == QCA_INIT_SPEED) {
+		speed = qca_get_speed(hu, QCA_INIT_SPEED);
+		if (speed)
+			host_set_baudrate(hu, speed);
+		else
+			bt_dev_err(hu->hdev, "Init speed should be non zero");
+
+		return 0;
+	}
+
+	speed = qca_get_speed(hu, QCA_OPER_SPEED);
+	if (!speed) {
+		bt_dev_err(hu->hdev, "operating speed should be non zero");
+		return 0;
+	}
+
+	qca_baudrate = qca_get_baudrate_value(speed);
+	bt_dev_info(hu->hdev, "Set UART speed to %d", speed);
+	ret = qca_set_baudrate(hu->hdev, qca_baudrate);
+	if (ret) {
+		bt_dev_err(hu->hdev, "Failed to change the baudrate (%d)", ret);
+		return ret;
+	}
+
+	host_set_baudrate(hu, speed);
+
+	return ret;
+}
+
 static int qca_setup(struct hci_uart *hu)
 {
 	struct hci_dev *hdev = hu->hdev;
@@ -937,35 +996,17 @@ static int qca_setup(struct hci_uart *hu)
 	clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
 
 	/* Setup initial baudrate */
-	speed = 0;
-	if (hu->init_speed)
-		speed = hu->init_speed;
-	else if (hu->proto->init_speed)
-		speed = hu->proto->init_speed;
-
-	if (speed)
-		host_set_baudrate(hu, speed);
+	qca_set_speed(hu, QCA_INIT_SPEED);
 
 	/* Setup user speed if needed */
-	speed = 0;
-	if (hu->oper_speed)
-		speed = hu->oper_speed;
-	else if (hu->proto->oper_speed)
-		speed = hu->proto->oper_speed;
+	ret = qca_set_speed(hu, QCA_OPER_SPEED);
+	if (ret)
+		return ret;
 
-	if (speed) {
+	speed = qca_get_speed(hu, QCA_OPER_SPEED);
+	if (speed)
 		qca_baudrate = qca_get_baudrate_value(speed);
 
-		bt_dev_info(hdev, "Set UART speed to %d", speed);
-		ret = qca_set_baudrate(hdev, qca_baudrate);
-		if (ret) {
-			bt_dev_err(hdev, "Failed to change the baud rate (%d)",
-				   ret);
-			return ret;
-		}
-		host_set_baudrate(hu, speed);
-	}
-
 	/* Setup patch / NVM configurations */
 	ret = qca_uart_setup(hdev, qca_baudrate, QCA_ROME, soc_ver);
 	if (!ret) {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

