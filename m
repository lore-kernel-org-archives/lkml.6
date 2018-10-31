Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14141ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD5692064C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbUVqITB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD5692064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbeKAIvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:51:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:53560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728098AbeKAIGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:06:35 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8946D20854;
        Wed, 31 Oct 2018 23:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027185;
        bh=iRbJlu+RCqB5NUUnNMVzp6yjzxF0vNrx9OAwzStowp8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DbUVqITBODFPY6uJHmbVTbfUlucuDkmy3c4jWikfQRSRobBq59OXC/p9iwz4bE8FJ
         sOk9dxhFaCMvXVb6Il4WtT+4uZ/0Rs8cZ4d2JBImLu0+foP8KZ2coE46ZrPi+YUbD0
         Aob4rjje2+6zRxaPLh9o+HrQm8UDJ751XPWy2otM=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 047/146] Bluetooth: hci_qca: Remove hdev dereference in qca_close().
Date:   Wed, 31 Oct 2018 19:04:02 -0400
Message-Id: <20181031230541.28822-47-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230541.28822-1-sashal@kernel.org>
References: <20181031230541.28822-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Balakrishna Godavarthi <bgodavar@codeaurora.org>

[ Upstream commit c2d7827338618a9e73a3f892ca63d9082bb7a94d ]

When flag KASAN is set, we are seeing an following crash while removing
hci_uart module.

[   50.589909] Unable to handle kernel paging request at virtual address 6b6b6b6b6b6b73
[   50.597902] Mem abort info:
[   50.600846]   Exception class = DABT (current EL), IL = 32 bits
[   50.606959]   SET = 0, FnV = 0
[   50.610142]   EA = 0, S1PTW = 0
[   50.613396] Data abort info:
[   50.616401]   ISV = 0, ISS = 0x00000004
[   50.620373]   CM = 0, WnR = 0
[   50.623466] [006b6b6b6b6b6b73] address between user and kernel address ranges
[   50.630818] Internal error: Oops: 96000004 [#1] PREEMPT SMP

[   50.671670] PC is at qca_power_shutdown+0x28/0x100 [hci_uart]
[   50.677593] LR is at qca_close+0x74/0xb0 [hci_uart]
[   50.775689] Process rmmod (pid: 2144, stack limit = 0xffffff801ba90000)
[   50.782493] Call trace:

[   50.872150] [<ffffff8000c3c81c>] qca_power_shutdown+0x28/0x100 [hci_uart]
[   50.879138] [<ffffff8000c3c968>] qca_close+0x74/0xb0 [hci_uart]
[   50.885238] [<ffffff8000c3a71c>] hci_uart_unregister_device+0x44/0x50 [hci_uart]
[   50.892846] [<ffffff8000c3c9f4>] qca_serdev_remove+0x50/0x5c [hci_uart]
[   50.899654] [<ffffff800844f630>] serdev_drv_remove+0x28/0x38
[   50.905489] [<ffffff800850fc44>] device_release_driver_internal+0x140/0x1e4
[   50.912653] [<ffffff800850fd94>] driver_detach+0x78/0x84
[   50.918121] [<ffffff800850edac>] bus_remove_driver+0x80/0xa8
[   50.923942] [<ffffff80085107dc>] driver_unregister+0x4c/0x58
[   50.929768] [<ffffff8000c3ca8c>] qca_deinit+0x24/0x598 [hci_uart]
[   50.936045] [<ffffff8000c3ca10>] hci_uart_exit+0x10/0x48 [hci_uart]
[   50.942495] [<ffffff8008136630>] SyS_delete_module+0x17c/0x224

This crash is due to dereference of hdev, after freeing it.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/hci_qca.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 2fee65886d50..f0d593c3fa72 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -167,7 +167,7 @@ struct qca_serdev {
 };
 
 static int qca_power_setup(struct hci_uart *hu, bool on);
-static void qca_power_shutdown(struct hci_dev *hdev);
+static void qca_power_shutdown(struct hci_uart *hu);
 
 static void __serial_clock_on(struct tty_struct *tty)
 {
@@ -609,7 +609,7 @@ static int qca_close(struct hci_uart *hu)
 	if (hu->serdev) {
 		qcadev = serdev_device_get_drvdata(hu->serdev);
 		if (qcadev->btsoc_type == QCA_WCN3990)
-			qca_power_shutdown(hu->hdev);
+			qca_power_shutdown(hu);
 		else
 			gpiod_set_value_cansleep(qcadev->bt_en, 0);
 
@@ -1232,12 +1232,15 @@ static const struct qca_vreg_data qca_soc_data = {
 	.num_vregs = 4,
 };
 
-static void qca_power_shutdown(struct hci_dev *hdev)
+static void qca_power_shutdown(struct hci_uart *hu)
 {
-	struct hci_uart *hu = hci_get_drvdata(hdev);
+	struct serdev_device *serdev = hu->serdev;
+	unsigned char cmd = QCA_WCN3990_POWEROFF_PULSE;
 
 	host_set_baudrate(hu, 2400);
-	qca_send_power_pulse(hdev, QCA_WCN3990_POWEROFF_PULSE);
+	hci_uart_set_flow_control(hu, true);
+	serdev_device_write_buf(serdev, &cmd, sizeof(cmd));
+	hci_uart_set_flow_control(hu, false);
 	qca_power_setup(hu, false);
 }
 
@@ -1413,7 +1416,7 @@ static void qca_serdev_remove(struct serdev_device *serdev)
 	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
 
 	if (qcadev->btsoc_type == QCA_WCN3990)
-		qca_power_shutdown(qcadev->serdev_hu.hdev);
+		qca_power_shutdown(&qcadev->serdev_hu);
 	else
 		clk_disable_unprepare(qcadev->susclk);
 
-- 
2.17.1

