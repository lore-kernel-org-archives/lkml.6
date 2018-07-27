Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_NXDOMAIN,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656B0C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CDF2208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:20:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CDF2208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bgodavar-linux.qualcomm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388602AbeG0Pmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 11:42:52 -0400
Received: from alexa-out-blr-02.qualcomm.com ([103.229.18.198]:5650 "EHLO
        alexa-out-blr.qualcomm.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730340AbeG0Pmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 11:42:52 -0400
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Jul 2018 11:42:49 EDT
X-IronPort-AV: E=Sophos;i="5.51,409,1526322600"; 
   d="scan'208";a="115134"
Received: from ironmsg04-blr.qualcomm.com ([10.86.208.133])
  by alexa-out-blr.qualcomm.com with ESMTP/TLS/AES256-SHA; 27 Jul 2018 19:43:27 +0530
X-IronPort-AV: E=McAfee;i="5900,7806,8966"; a="828478"
Received: from bgodavar-linux.qualcomm.com ([10.206.64.85])
  by ironmsg04-blr.qualcomm.com with ESMTP; 27 Jul 2018 19:43:26 +0530
Received: by bgodavar-linux.qualcomm.com (Postfix, from userid 2304065)
        id B7BBD3C2A; Fri, 27 Jul 2018 19:43:23 +0530 (IST)
From:   Balakrishna Godavarthi <bgodavar@bgodavar-linux.qualcomm.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, mka@chromium.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, thierry.escande@linaro.org,
        rtatiya@codeaurora.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v11 4/7] Bluetooth: hci_qca: Add wrapper functions for setting UART speed
Date:   Fri, 27 Jul 2018 19:43:17 +0530
Message-Id: <20180727141320.25218-5-bgodavar@bgodavar-linux.qualcomm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180727141320.25218-1-bgodavar@bgodavar-linux.qualcomm.com>
References: <20180727141320.25218-1-bgodavar@bgodavar-linux.qualcomm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Balakrishna Godavarthi <bgodavar@codeaurora.org>

In function qca_setup, we set initial and operating speeds for Qualcomm
Bluetooth SoC's. This block of code is common across different
Qualcomm Bluetooth SoC's. Instead of duplicating the code, created
a wrapper function to set the speeds. So that future coming SoC's
can use these wrapper functions to set speeds.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/bluetooth/hci_qca.c | 93 ++++++++++++++++++++++++++++---------
 1 file changed, 70 insertions(+), 23 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 5f1c0a8fd5cd..5f8a74d65bec 100644
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
@@ -923,6 +928,61 @@ static inline void host_set_baudrate(struct hci_uart *hu, unsigned int speed)
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
+	if (!qca_get_speed(hu, QCA_INIT_SPEED) ||
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
@@ -933,37 +993,24 @@ static int qca_setup(struct hci_uart *hu)
 
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
2.17.1

