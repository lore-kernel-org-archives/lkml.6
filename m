Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD2CC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 11:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6FF4208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 11:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JYhV642n";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hv7i8ucl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6FF4208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731642AbeHWO7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 10:59:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45798 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbeHWO7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 10:59:15 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5E6BC60116; Thu, 23 Aug 2018 11:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535023798;
        bh=2iEUXB+Q0sJTvnfjFcpw3ZLQXSh1AxYPjmswbXKA/w8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JYhV642niexzuLVrrdAWSxyKFxqEzx1UPO2vDmIxWmNzeoEK3H13PUzHkcFvnXgd5
         YnLAR/e1u25l3fbJMSKeiNMK91WPPj//qYdcYwi2BWmTgnQRdjvR0bog1R6fIqzky/
         5Xuev2rOctfEqlUjKEG+sylv2CUYfbItCJ8u2sno=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EA90B60251;
        Thu, 23 Aug 2018 11:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535023797;
        bh=2iEUXB+Q0sJTvnfjFcpw3ZLQXSh1AxYPjmswbXKA/w8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hv7i8ucl48VVI5+U1cvQqBVNUfUZVJp/D/O/UZ3wk76rNOSw6ZAbZRIhmiX2B0ikQ
         +W/ItwVZ2HwYAbRIzfYu2YpA6+AB6vRDklYeRg3UhluHUuEPm2xKvNDaGRCE8k5PxF
         UE+ijM/JzWoPDksKGv/mrZ1tW263FlAbeJNiFOvI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EA90B60251
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v1 1/1] Bluetooth: hci_qca: Add poweroff support during hci down for wcn3990
Date:   Thu, 23 Aug 2018 16:59:35 +0530
Message-Id: <20180823112935.17342-2-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180823112935.17342-1-bgodavar@codeaurora.org>
References: <20180823112935.17342-1-bgodavar@codeaurora.org>
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
 drivers/bluetooth/hci_qca.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index e182f6019f68..98d33c6b8909 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -595,6 +595,9 @@ static int qca_close(struct hci_uart *hu)
 	struct qca_serdev *qcadev;
 	struct qca_data *qca = hu->priv;
 
+	if (!qca)
+		return 0;
+
 	BT_DBG("hu %p qca close", hu);
 
 	serial_clock_vote(HCI_IBS_VOTE_STATS_UPDATE, hu);
@@ -1098,6 +1101,32 @@ static int qca_set_speed(struct hci_uart *hu, enum qca_speed_type speed_type)
 	return 0;
 }
 
+static int hci_uart_open(struct hci_dev *hdev)
+{
+	struct hci_uart *hu = hci_get_drvdata(hdev);
+
+	BT_DBG("%s %p", hdev->name, hdev);
+	set_bit(HCI_UART_PROTO_READY, &hu->flags);
+
+	return qca_open(hu);
+}
+
+static int hci_uart_close(struct hci_dev *hdev)
+{
+	struct hci_uart *hu = hci_get_drvdata(hdev);
+
+	BT_DBG("%s %p", hdev->name, hdev);
+
+	/* After this step, we should not allow Tx and Rx work
+	 * function to execute. As we are freeing qca tx and rx
+	 * buffers which may cause kernel crash.
+	 */
+	clear_bit(HCI_UART_PROTO_READY, &hu->flags);
+	qca_close(hu);
+
+	return 0;
+}
+
 static int qca_wcn3990_init(struct hci_uart *hu)
 {
 	struct hci_dev *hdev = hu->hdev;
@@ -1154,6 +1183,11 @@ static int qca_setup(struct hci_uart *hu)
 
 	if (qcadev->btsoc_type == QCA_WCN3990) {
 		bt_dev_info(hdev, "setting up wcn3990");
+
+		hdev->open  = hci_uart_open;
+		hdev->close = hci_uart_close;
+		set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
+
 		ret = qca_wcn3990_init(hu);
 		if (ret)
 			return ret;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

