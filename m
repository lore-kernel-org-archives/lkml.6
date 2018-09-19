Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE986C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 659792098A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OnLb29fa";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RSSRSkfT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 659792098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732490AbeISU7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 16:59:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60256 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732326AbeISU7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 16:59:52 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4269860BF5; Wed, 19 Sep 2018 15:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537370487;
        bh=gcE9N+vouJAzdQDuLUjeZk8iW1WGAzfJuCL4fKleacc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OnLb29faJHCZKuanNDyG5o4m5vB/XR8/TauC7DMaRwNArdQeK1zGNIS/e6e2C+zqR
         hcSteIbiVqeovyn2GRBhOn/PHU2FKgpcD/ksTmpMHd80ACaItR0GZzO62tO2tVKjib
         7pDmTn12C068phh65iq5SCwoUS+QxVebRUa8qybk=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7798660BF5;
        Wed, 19 Sep 2018 15:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537370486;
        bh=gcE9N+vouJAzdQDuLUjeZk8iW1WGAzfJuCL4fKleacc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RSSRSkfTjHRjwvJ2RbYcoL78wB/ZCS7uCy+HIb/ebEF/j5mDCl1txXBQ2u4doBWY1
         zbLOHmefeddLRKwHwD29oVqebMBeJkyur0Sx4hCtpffdMGvxGDJvNPin8JYQbMrNUs
         8BLS/UGK2gU0GqYgk8Y/e9Sd2ko1vVXiFzcM89vI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7798660BF5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v2 1/1] Bluetooth: hci_qca: Add poweroff support during hci down for wcn3990
Date:   Wed, 19 Sep 2018 20:51:13 +0530
Message-Id: <20180919152113.7611-2-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180919152113.7611-1-bgodavar@codeaurora.org>
References: <20180919152113.7611-1-bgodavar@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables power off support for hci down and power on support
for hci up. As wcn3990 power sources are ignited by regulators, we will
turn off them during hci down, i.e. an complete power off of wcn3990.
So while hci up, we will call vendor specific open/close and setup which
will turn on the regulators, requests BT chip version and download the
firmware.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---
 drivers/bluetooth/hci_qca.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 74f5fede0274..c3038afa42af 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -168,6 +168,7 @@ struct qca_serdev {
 
 static int qca_power_setup(struct hci_uart *hu, bool on);
 static void qca_power_shutdown(struct hci_uart *hu);
+static int qca_power_off(struct hci_dev *hdev);
 
 static void __serial_clock_on(struct tty_struct *tty)
 {
@@ -1099,8 +1100,26 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 static int qca_wcn3990_init(struct hci_uart *hu)
 {
 	struct hci_dev *hdev = hu->hdev;
+	struct qca_serdev *qcadev;
 	int ret;
 
+	/* Check for vregs status, may be hci0 down has turned
+	 * off the vregs.
+	 */
+	qcadev = serdev_device_get_drvdata(hu->serdev);
+	if (qcadev->bt_power->vregs_on == false) {
+		serdev_device_close(hu->serdev);
+		ret = qca_power_setup(hu, true);
+		if (ret)
+			return ret;
+
+		ret = serdev_device_open(hu->serdev);
+		if (ret) {
+			bt_dev_err(hu->hdev, "failed to open port");
+			return ret;
+		}
+	}
+
 	/* Forcefully enable wcn3990 to enter in to boot mode. */
 	host_set_baudrate(hu, 2400);
 	ret = qca_send_power_pulse(hdev, QCA_WCN3990_POWEROFF_PULSE);
@@ -1152,6 +1171,12 @@ static int qca_setup(struct hci_uart *hu)
 
 	if (qcadev->btsoc_type == QCA_WCN3990) {
 		bt_dev_info(hdev, "setting up wcn3990");
+
+		/* Enable NON_PERSISTENT_SETUP QUIRK to ensure to execute
+		 * setup for every hci0 up.
+		 */
+		set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
+		hu->hdev->shutdown = qca_power_off;
 		ret = qca_wcn3990_init(hu);
 		if (ret)
 			return ret;
@@ -1242,6 +1267,14 @@ static void qca_power_shutdown(struct hci_uart *hu)
 	qca_power_setup(hu, false);
 }
 
+static int qca_power_off(struct hci_dev *hdev)
+{
+	struct hci_uart *hu = hci_get_drvdata(hdev);
+
+	qca_power_shutdown(hu);
+	return 0;
+}
+
 static int qca_enable_regulator(struct qca_vreg vregs,
 				struct regulator *regulator)
 {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

