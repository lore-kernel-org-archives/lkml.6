Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49019C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 189022082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="N7LT7kQ2";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="K1BatoPY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731133AbfBDPHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 10:07:10 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:39044 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731101AbfBDPHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 10:07:08 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 259C460989; Mon,  4 Feb 2019 15:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549292827;
        bh=Byn/jWLO/SuUHx9hrnRwMPYE5oXEMXK3eT6fCu+VpBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N7LT7kQ2pDmREl9aDqjY1CPnZA8rcA+nJK7x4eyyixG7W36yvMgQVyj/aGPUnFWUL
         QPil9lddKv7HnVEilxsCbP81JHvofI1nAwjhAT6lrXZ/xO/mKaWij3pKPvqZ7S7ORK
         llCGx5qq4ouueYmtLHHyYdB0YNX3Xp/nHr+f+rcs=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8571D60908;
        Mon,  4 Feb 2019 15:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549292826;
        bh=Byn/jWLO/SuUHx9hrnRwMPYE5oXEMXK3eT6fCu+VpBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K1BatoPYd1snxMD88tC8aI+dufkbSbgERXWagOJtkJrkeMX9nmficEOAawjfwrVHB
         DQSszmXL+tTgF4TtBR5wXvSnxA6uGTWWMrdtnbnV9Ii7ZeewSpJN0jhguAh/b5XrRJ
         nYEn1HALffFgN0GCFugKT2GNwjISLl+HAARik8y8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8571D60908
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v11 3/3] Bluetooth: hci_qca: Disable IBS state machine and flush Tx buffer
Date:   Mon,  4 Feb 2019 20:36:43 +0530
Message-Id: <20190204150643.25165-4-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190204150643.25165-1-bgodavar@codeaurora.org>
References: <20190204150643.25165-1-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During hci down we observed IBS sleep commands are queued in the Tx
buffer and hci_uart_write_work is sending data to the chip which is
not required as the chip is powered off. This patch will disable IBS
and flush the Tx buffer before we turn off the chip.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---
 drivers/bluetooth/hci_qca.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index e3cf0dbfc89d..5e03504c4e0c 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -771,16 +771,17 @@ static int qca_enqueue(struct hci_uart *hu, struct sk_buff *skb)
 	/* Prepend skb with frame type */
 	memcpy(skb_push(skb, 1), &hci_skb_pkt_type(skb), 1);
 
+	spin_lock_irqsave(&qca->hci_ibs_lock, flags);
+
 	/* Don't go to sleep in middle of patch download or
 	 * Out-Of-Band(GPIOs control) sleep is selected.
 	 */
 	if (!test_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags)) {
 		skb_queue_tail(&qca->txq, skb);
+		spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
 		return 0;
 	}
 
-	spin_lock_irqsave(&qca->hci_ibs_lock, flags);
-
 	/* Act according to current state */
 	switch (qca->tx_ibs_state) {
 	case HCI_IBS_TX_AWAKE:
@@ -1275,6 +1276,18 @@ static const struct qca_vreg_data qca_soc_data = {
 
 static void qca_power_shutdown(struct hci_uart *hu)
 {
+	struct qca_data *qca = hu->priv;
+	unsigned long flags;
+
+	/* From this point we go into power off state. But serial port is
+	 * still open, stop queueing the IBS data and flush all the buffered
+	 * data in skb's.
+	 */
+	spin_lock_irqsave(&qca->hci_ibs_lock, flags);
+	clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
+	qca_flush(hu);
+	spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
+
 	host_set_baudrate(hu, 2400);
 	qca_send_power_pulse(hu, QCA_WCN3990_POWEROFF_PULSE);
 	qca_power_setup(hu, false);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

