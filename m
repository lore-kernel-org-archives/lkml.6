Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D249DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A070120657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XFffsftc";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XFffsftc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392531AbfAPLqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 06:46:45 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:43548 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389613AbfAPLqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 06:46:32 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 94A39608FB; Wed, 16 Jan 2019 11:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547639191;
        bh=ymB409/EObpTpVe+aPgVCCFfMgzXP9PAx6hVzoDTkiQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XFffsftcqXFYAHVpWi3jut3vDDiYSTCuKn9BeQcHL7S0IzWz2eOMLsGNA4JZm44n7
         TnisocOyk8/q6vVwzKw1Cd5jPhPHBE6Gb7HaYz5WwfNH34Wd8lq9UnpxOCw8YszUA6
         lFZrgzUPHp0JWuVtFL2t9DKBChzyJW2Wdagz8lJQ=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 46D2F6087D;
        Wed, 16 Jan 2019 11:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547639191;
        bh=ymB409/EObpTpVe+aPgVCCFfMgzXP9PAx6hVzoDTkiQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XFffsftcqXFYAHVpWi3jut3vDDiYSTCuKn9BeQcHL7S0IzWz2eOMLsGNA4JZm44n7
         TnisocOyk8/q6vVwzKw1Cd5jPhPHBE6Gb7HaYz5WwfNH34Wd8lq9UnpxOCw8YszUA6
         lFZrgzUPHp0JWuVtFL2t9DKBChzyJW2Wdagz8lJQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 46D2F6087D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v8 3/3] Bluetooth: hci_qca: Disable IBS state machine and flush Tx buffer
Date:   Wed, 16 Jan 2019 17:16:03 +0530
Message-Id: <20190116114603.500-4-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190116114603.500-1-bgodavar@codeaurora.org>
References: <20190116114603.500-1-bgodavar@codeaurora.org>
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
 drivers/bluetooth/hci_qca.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 7e4afcf40da2..7330ba71ada4 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1275,6 +1275,14 @@ static const struct qca_vreg_data qca_soc_data = {
 
 static void qca_power_shutdown(struct hci_uart *hu)
 {
+	struct qca_data *qca = hu->priv;
+
+	/* From this point we go into power off state. But serial port is
+	 * still open, stop queueing the IBS data and flush all the buffered
+	 * data in skb's.
+	 */
+	clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
+	qca_flush(hu);
 	host_set_baudrate(hu, 2400);
 	qca_send_power_pulse(hu, QCA_WCN3990_POWEROFF_PULSE);
 	qca_power_setup(hu, false);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

