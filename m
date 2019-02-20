Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193DFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D420A206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DvVLRNpd";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RBJ0ynFo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfBTLZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:25:34 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:50554 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfBTLZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:25:34 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C7F9D601EA; Wed, 20 Feb 2019 11:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550661932;
        bh=h0Vo6ovhZYdyYgbdfk38gIfa4lo+R5R/ObTapMEo7Mw=;
        h=From:To:Cc:Subject:Date:From;
        b=DvVLRNpdcHMvplI4fV3uBd1AJgTwZ+9/dJ6AOqJOOPUi6QUbCNmvzat/Os0s6c9wG
         oEGt5mIleCAbROHvJ5eFXWDmf3UtWOn2JJ7tv4yj87wBjqqPDQh5Sc0LblytwyGhFd
         xn18PpKKUH8s0bTy9Yo7iGRM6OdvtBeqwuQZiAxU=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5EFFC60585;
        Wed, 20 Feb 2019 11:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550661931;
        bh=h0Vo6ovhZYdyYgbdfk38gIfa4lo+R5R/ObTapMEo7Mw=;
        h=From:To:Cc:Subject:Date:From;
        b=RBJ0ynFo1YbjnZ/fwgcnfoBvMW+cfGPAy6Bwzyo3EfHeXxeS0xOb/Y4ZMZY+5WdkD
         iesk2OammJpxJgbl21ncs66hfAZOqaNj9vU2wViaZRAII0KRbiWccT54xjSj/n7m3v
         POYhXvMvdwl8r7iOcKT1sY+zMGU+AP8z5yKl1YlA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5EFFC60585
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v1] Bluetooth: hci_qca: Update baudrate change wait time for wcn3990
Date:   Wed, 20 Feb 2019 16:55:16 +0530
Message-Id: <20190220112516.19179-1-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch will update the baudrate change request wait time from
300 ms to 100 ms. When host sends the change baudrate request to
the controller, controller sets its clock and wait until the
clocks settle down. Here the Wait time is required for both
host and controller to be on sync.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---
 drivers/bluetooth/hci_qca.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 5e03504c4e0c..22f3c983f868 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -59,7 +59,8 @@
 
 #define IBS_WAKE_RETRANS_TIMEOUT_MS	100
 #define IBS_TX_IDLE_TIMEOUT_MS		2000
-#define BAUDRATE_SETTLE_TIMEOUT_MS	300
+#define ROME_BD_SETTLE_TIMEOUT_MS	300
+#define WCN3990_BD_SETTLE_TIMEOUT_MS	100
 #define POWER_PULSE_TRANS_TIMEOUT_MS	100
 
 /* susclk rate */
@@ -965,8 +966,11 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
 	struct hci_uart *hu = hci_get_drvdata(hdev);
 	struct qca_data *qca = hu->priv;
 	struct sk_buff *skb;
+	struct qca_serdev *qcadev;
+	unsigned int bd_settling_timeout;
 	u8 cmd[] = { 0x01, 0x48, 0xFC, 0x01, 0x00 };
 
+	qcadev = serdev_device_get_drvdata(hu->serdev);
 	if (baudrate > QCA_BAUDRATE_3200000)
 		return -EINVAL;
 
@@ -989,8 +993,12 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
 	 * controller will come back after they receive this HCI command
 	 * then host can communicate with new baudrate to controller
 	 */
+	bd_settling_timeout = qcadev->btsoc_type == QCA_WCN3990 ?
+			       WCN3990_BD_SETTLE_TIMEOUT_MS :
+			       ROME_BD_SETTLE_TIMEOUT_MS;
+
 	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(msecs_to_jiffies(BAUDRATE_SETTLE_TIMEOUT_MS));
+	schedule_timeout(msecs_to_jiffies(bd_settling_timeout));
 	set_current_state(TASK_RUNNING);
 
 	return 0;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

