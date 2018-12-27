Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB64C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 07:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4904620856
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 07:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NLX90WKX";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QvfaJZ84"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730130AbeL0HcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 02:32:11 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:50226 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729457AbeL0HcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 02:32:09 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4A7E56076A; Thu, 27 Dec 2018 07:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545895928;
        bh=WZG+A/lmqrYYJ4AHc3vmsR2FiErs+UP65rv8EBaPR+M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NLX90WKXT8RMaHmxwLtOiyfmyKWiYItkbJJRNBoduHJnnVb6Dna3K2yW/nPUo7ySG
         myGtqtnCzZwL29hsTWTgVbkE4AYeuvKZ4q2SL/y7mzkX4xZcKPjHciZPHlar5d0EEh
         G3TPW+NO8DZNSy3RpP5RH1N7jtAX9akRcSY2esDs=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9020E6076A;
        Thu, 27 Dec 2018 07:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545895923;
        bh=WZG+A/lmqrYYJ4AHc3vmsR2FiErs+UP65rv8EBaPR+M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QvfaJZ84D1Dw8rdxanrP8CUkR8JRlRzlMEVXczCA47+HhUIq0tgstq7fYKH4vcoNG
         h58IgqwCbCtp2y1rVgFFKawhBlIsZDNECFpdNwlFoVikBk4zhpMolM/5TbOLIzOxtd
         NIbRHKVy5uZfol+jxqJUg11l+dqIz0BKXUAbr0Jg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9020E6076A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v6 5/6] Bluetooth: hci_qca: Update baudrate change wait time for wcn3990
Date:   Thu, 27 Dec 2018 13:01:35 +0530
Message-Id: <20181227073136.8431-6-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181227073136.8431-1-bgodavar@codeaurora.org>
References: <20181227073136.8431-1-bgodavar@codeaurora.org>
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

Changes in v6:
 * intial patch.

---
 drivers/bluetooth/hci_qca.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 4677a6a2716a..61b0fb1ff32f 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -60,7 +60,8 @@
 
 #define IBS_WAKE_RETRANS_TIMEOUT_MS	100
 #define IBS_TX_IDLE_TIMEOUT_MS		2000
-#define BAUDRATE_SETTLE_TIMEOUT_MS	300
+#define ROME_BD_SETTLE_TIMEOUT_MS	300
+#define WCN3990_BD_SETTLE_TIMEOUT_MS	100
 
 /* susclk rate */
 #define SUSCLK_RATE_32KHZ	32768
@@ -972,8 +973,11 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
 	struct hci_uart *hu = hci_get_drvdata(hdev);
 	struct qca_data *qca = hu->priv;
 	struct sk_buff *skb;
+	struct qca_serdev *qcadev;
+	unsigned int bd_settling_timeout;
 	u8 cmd[] = { 0x01, 0x48, 0xFC, 0x01, 0x00 };
 
+	qcadev = serdev_device_get_drvdata(hu->serdev);
 	if (baudrate > QCA_BAUDRATE_3200000)
 		return -EINVAL;
 
@@ -996,8 +1000,12 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
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

