Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BDDC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78BBD240FE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RM9E5o/z";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jd0aYRua"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78BBD240FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754385AbeGEQzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:55:49 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49320 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754037AbeGEQzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:55:45 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EA43360B19; Thu,  5 Jul 2018 16:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530809745;
        bh=8L82e/+Sk8pKywjwDQIk2rPyyenFFOZ1S76p2IuIIus=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RM9E5o/zYD9vf0Kb1BY5+EKDclSDkt7pNvLi5phI/vH3mQAcR2cGIo8P22BlAjYwa
         uSgOEtH4MfXuEt5Vz3DMbxGVH99KnxizN/mPTouG42w0w3oTj9VKwKfpEdx0vo5r1b
         zRFwvn5U3YgFBeZC36KYygOwK+rRfZhd+9qoJwIk=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E008860B10;
        Thu,  5 Jul 2018 16:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530809744;
        bh=8L82e/+Sk8pKywjwDQIk2rPyyenFFOZ1S76p2IuIIus=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jd0aYRuaB9RNdqdv0YbiXVrpJ7qebDe4+0rDGw49AEcLsxP9ci+z3MwSghQdS9+90
         8BnugH3az6VExFXCPHd7Jk/NiYopXlrROdq0M4UJ2sBRwqTvBWS74nN6j3IcSNqXue
         VlBnRUKrPrMrriPnwpIy2Kt7pT02o9OI7pIoe1B8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E008860B10
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, mka@chromium.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, thierry.escande@linaro.org,
        rtatiya@codeaurora.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v9 4/7] Bluetooth: hci_qca: Add wrapper functions for setting UART speed
Date:   Thu,  5 Jul 2018 22:25:12 +0530
Message-Id: <20180705165515.13340-5-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180705165515.13340-1-bgodavar@codeaurora.org>
References: <20180705165515.13340-1-bgodavar@codeaurora.org>
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
Changes in v9:
    * added corner case to fail driver if speeds are missing.

Changes in v8:
    * common function to set INIT and operating speeds.

Changes in v7:
    * initial patch
    * created wrapper functions for init and operating speeds.
---
 drivers/bluetooth/hci_qca.c | 94 ++++++++++++++++++++++++++++---------
 1 file changed, 71 insertions(+), 23 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index c02e1d465cca..9106547324fa 100644
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
@@ -923,6 +928,62 @@ static inline void host_set_baudrate(struct hci_uart *hu, unsigned int speed)
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
+static int qca_check_speeds(struct hci_uart *hu)
+{
+	/* One or the other speeds should be non zero. */
+	if (!qca_get_speed(hu, QCA_INIT_SPEED) &&
+	    !qca_get_speed(hu, QCA_OPER_SPEED))
+		return -EINVAL;
+
+	return 0;
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
+	} else {
+		speed = qca_get_speed(hu, QCA_OPER_SPEED);
+		if (!speed)
+			return 0;
+
+		qca_baudrate = qca_get_baudrate_value(speed);
+		bt_dev_info(hu->hdev, "Set UART speed to %d", speed);
+		ret = qca_set_baudrate(hu->hdev, qca_baudrate);
+		if (ret)
+			return ret;
+
+		host_set_baudrate(hu, speed);
+	}
+
+	return 0;
+}
+
 static int qca_setup(struct hci_uart *hu)
 {
 	struct hci_dev *hdev = hu->hdev;
@@ -933,37 +994,24 @@ static int qca_setup(struct hci_uart *hu)
 
 	bt_dev_info(hdev, "ROME setup");
 
+	ret = qca_check_speeds(hu);
+	if (ret)
+		return ret;
+
 	/* Patch downloading has to be done without IBS mode */
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
-
+	speed = qca_get_speed(hu, QCA_OPER_SPEED);
 	if (speed) {
-		qca_baudrate = qca_get_baudrate_value(speed);
-
-		bt_dev_info(hdev, "Set UART speed to %d", speed);
-		ret = qca_set_baudrate(hdev, qca_baudrate);
-		if (ret) {
-			bt_dev_err(hdev, "Failed to change the baud rate (%d)",
-				   ret);
+		ret = qca_set_speed(hu, QCA_OPER_SPEED);
+		if (ret)
 			return ret;
-		}
-		host_set_baudrate(hu, speed);
+
+		qca_baudrate = qca_get_baudrate_value(speed);
 	}
 
 	/* Get QCA version information */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

