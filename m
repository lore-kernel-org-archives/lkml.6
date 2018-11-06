Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B523AC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BEF120862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Wx40riLZ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="J7y0Uomd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BEF120862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387664AbeKFVas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 16:30:48 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:52196 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbeKFVar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 16:30:47 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8823160741; Tue,  6 Nov 2018 12:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541505953;
        bh=4WiXbwc0e4U0WOflxnS1rA4ueY5zCIJjjTBvbcP1RIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wx40riLZjwVGh2j63lEFcG5DLXz5P98dgxUzNXt2SitZON8HlS++JCND2RGs6HP4l
         ucoqel0vR3bQ8LSz6ekEWaknJOOkLzZr4fL3wRvSbJ3DOtcEg1oNfwNltGSBV7z4sT
         Dy9z33vIc1gs7MhscnQ5p8YTxNkJxCuvxyjisFGQ=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D1E0C60B7F;
        Tue,  6 Nov 2018 12:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541505951;
        bh=4WiXbwc0e4U0WOflxnS1rA4ueY5zCIJjjTBvbcP1RIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J7y0Uomds4pxJpILGVnk2WK16badwXtYEILlkU/OJtlUEjL3L3ERshLfLIjkE/nre
         HitBKK+PkHbtpoLHMqkrTpXnMypFtM7UEAmEQcp2ESSZy1oBIs1bpaf9E5vfMRq5bu
         xWs3RWGNvguRw1w7iviCyrkaBApEeSTk3L2csB8E=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D1E0C60B7F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v1 4/4] Bluetooth: hci_qca: Fix frame reassembly errors for wcn3990
Date:   Tue,  6 Nov 2018 17:35:28 +0530
Message-Id: <20181106120528.30342-5-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181106120528.30342-1-bgodavar@codeaurora.org>
References: <20181106120528.30342-1-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[  176.929612] Bluetooth: hci_qca.c:qca_recv() hci0: Frame reassembly failed (-84)
[  176.945734] Bluetooth: hci_qca.c:qca_recv() hci0: Frame reassembly failed (-84)
[  176.953298] Bluetooth: hci_qca.c:qca_recv() hci0: Frame reassembly failed (-84)
[  177.010660] Bluetooth: hci_qca.c:qca_recv() hci0: Frame reassembly failed (-84)
[  177.067633] Bluetooth: hci_qca.c:qca_recv() hci0: Frame reassembly failed (-84)

The above errors log on console due to receiving of stray bytes
when wcn3990 boot up's i.e. when during initial setup procedure.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---
 drivers/bluetooth/hci_qca.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 97b57e0f4725..341f80606574 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -56,6 +56,7 @@
 
 /* Controller states */
 #define STATE_IN_BAND_SLEEP_ENABLED	1
+#define STATE_DISCARD_RX		2
 
 #define IBS_WAKE_RETRANS_TIMEOUT_MS	100
 #define IBS_TX_IDLE_TIMEOUT_MS		2000
@@ -511,6 +512,7 @@ static int qca_open(struct hci_uart *hu)
 		} else {
 			hu->init_speed = qcadev->init_speed;
 			hu->oper_speed = qcadev->oper_speed;
+			set_bit(STATE_DISCARD_RX, &qca->flags);
 			ret = qca_power_setup(hu, true);
 			if (ret) {
 				destroy_workqueue(qca->workqueue);
@@ -903,6 +905,13 @@ static int qca_recv(struct hci_uart *hu, const void *data, int count)
 	if (!test_bit(HCI_UART_REGISTERED, &hu->flags))
 		return -EUNATCH;
 
+	/* We discard Rx data received while device is in booting
+	 * stage, this is due multiple baudrate switch is causing
+	 * UART to read some garbage data.
+	 */
+	if (test_bit(STATE_DISCARD_RX, &qca->flags))
+		return 0;
+
 	qca->rx_skb = h4_recv_buf(hu->hdev, qca->rx_skb, data, count,
 				  qca_recv_pkts, ARRAY_SIZE(qca_recv_pkts));
 	if (IS_ERR(qca->rx_skb)) {
@@ -1192,10 +1201,12 @@ static int qca_setup(struct hci_uart *hu)
 		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
 		clear_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);
 		hu->hdev->shutdown = qca_power_off;
+
 		ret = qca_wcn3990_init(hu);
 		if (ret)
 			return ret;
 
+		clear_bit(STATE_DISCARD_RX, &qca->flags);
 		ret = qca_read_soc_version(hdev, &soc_ver);
 		if (ret)
 			return ret;
@@ -1278,8 +1289,15 @@ static void qca_power_shutdown(struct hci_uart *hu)
 	struct serdev_device *serdev = hu->serdev;
 	unsigned char cmd = QCA_WCN3990_POWEROFF_PULSE;
 
-	host_set_baudrate(hu, 2400);
+	/* From this point we go into power off state,
+	 * disable IBS and discard all the queued data.
+	 */
+	clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
+	set_bit(STATE_DISCARD_RX, &qca->flags);
+	qca_flush(hu);
+
 	hci_uart_set_flow_control(hu, true);
+	host_set_baudrate(hu, 2400);
 	serdev_device_write(serdev, &cmd, sizeof(cmd), 0);
 	serdev_device_wait_until_sent(serdev, 0);
 	hci_uart_set_flow_control(hu, false);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

