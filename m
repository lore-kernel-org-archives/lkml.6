Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4A0C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9D732086B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LDh/WAIc";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LDh/WAIc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9D732086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730777AbeKFVah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 16:30:37 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:51888 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbeKFVah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 16:30:37 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D7244605A2; Tue,  6 Nov 2018 12:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541505942;
        bh=mLG9ZCaIJ8+4gofyelc0OXDiSRL2Xx/TlW0/WvtaCfI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LDh/WAIc36pStvXStyp5aKItL1+qEe42g4o33cW5SYFlwbLhqcdIbLah3z+fD/bHA
         hLU+dXrnQKNRr8I6vskFfDiB1ePIEkhsVsh+aIvRXLlQgMWwCqycwURP+CZw9zeBrj
         L3szbsqh0oGjO8FD1/uBsOR7+I24bOZYrdAMP5J4=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A9F6960591;
        Tue,  6 Nov 2018 12:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541505942;
        bh=mLG9ZCaIJ8+4gofyelc0OXDiSRL2Xx/TlW0/WvtaCfI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LDh/WAIc36pStvXStyp5aKItL1+qEe42g4o33cW5SYFlwbLhqcdIbLah3z+fD/bHA
         hLU+dXrnQKNRr8I6vskFfDiB1ePIEkhsVsh+aIvRXLlQgMWwCqycwURP+CZw9zeBrj
         L3szbsqh0oGjO8FD1/uBsOR7+I24bOZYrdAMP5J4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A9F6960591
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v1 1/4] Bluetooth: hci_qca: use wait_until_sent() for power pulses
Date:   Tue,  6 Nov 2018 17:35:25 +0530
Message-Id: <20181106120528.30342-2-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181106120528.30342-1-bgodavar@codeaurora.org>
References: <20181106120528.30342-1-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wcn3990 requires a power pulse to turn ON/OFF along with
regulators. Sometimes we are observing the power pulses are sent
out with some time delay, due to queuing these commands. This is
causing synchronization issues with chip, which intern delay the
chip setup or may end up with communication issues.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---
 drivers/bluetooth/hci_qca.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index f72ded4ec9ae..051f081d1835 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1016,8 +1016,7 @@ static inline void host_set_baudrate(struct hci_uart *hu, unsigned int speed)
 static int qca_send_power_pulse(struct hci_dev *hdev, u8 cmd)
 {
 	struct hci_uart *hu = hci_get_drvdata(hdev);
-	struct qca_data *qca = hu->priv;
-	struct sk_buff *skb;
+	int ret;
 
 	/* These power pulses are single byte command which are sent
 	 * at required baudrate to wcn3990. On wcn3990, we have an external
@@ -1030,18 +1029,14 @@ static int qca_send_power_pulse(struct hci_dev *hdev, u8 cmd)
 	 * sending power pulses to SoC.
 	 */
 	bt_dev_dbg(hdev, "sending power pulse %02x to SoC", cmd);
-
-	skb = bt_skb_alloc(sizeof(cmd), GFP_KERNEL);
-	if (!skb)
-		return -ENOMEM;
-
 	hci_uart_set_flow_control(hu, true);
+	ret = serdev_device_write(hu->serdev, &cmd, sizeof(cmd), 0);
+	if (ret < 0) {
+		bt_dev_err(hdev, "failed to send power pulse %02x to SoC", cmd);
+		return ret;
+	}
 
-	skb_put_u8(skb, cmd);
-	hci_skb_pkt_type(skb) = HCI_COMMAND_PKT;
-
-	skb_queue_tail(&qca->txq, skb);
-	hci_uart_tx_wakeup(hu);
+	serdev_device_wait_until_sent(hu->serdev, 0);
 
 	/* Wait for 100 uS for SoC to settle down */
 	usleep_range(100, 200);
@@ -1283,7 +1278,8 @@ static void qca_power_shutdown(struct hci_uart *hu)
 
 	host_set_baudrate(hu, 2400);
 	hci_uart_set_flow_control(hu, true);
-	serdev_device_write_buf(serdev, &cmd, sizeof(cmd));
+	serdev_device_write(serdev, &cmd, sizeof(cmd), 0);
+	serdev_device_wait_until_sent(serdev, 0);
 	hci_uart_set_flow_control(hu, false);
 	qca_power_setup(hu, false);
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

