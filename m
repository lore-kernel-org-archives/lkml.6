Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BEF4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 11:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E8DC2087F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 11:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QYgnXLlD";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZW//WANy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732230AbeL1Lsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 06:48:47 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49412 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732193AbeL1Lsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 06:48:38 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 95D236083C; Fri, 28 Dec 2018 11:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545997717;
        bh=oVLi0wN37zbNGhhJgIq3WzbukBzHLUJk3h6FL2j+D0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QYgnXLlDuGvNPwHHqpYWbfc3tBUF6Q1rmjDWBWuxxkiDHsT0knv2LZixOtcZafGfm
         ondGPmVpXdLj2Q2T9S0ZioSiGHwuRGhSDmZ5MNdYjW0bEOSPvx9cZp6qLPP5+ocseX
         xWcQ4qX7X3pWJ723Z7YvpSgmbJQrt7RhnT2H9RBc=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5D36A6087D;
        Fri, 28 Dec 2018 11:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545997716;
        bh=oVLi0wN37zbNGhhJgIq3WzbukBzHLUJk3h6FL2j+D0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZW//WANyS2Wj6EwqVnbg9s4S5ENNGLpQY3Ri/2j+aV+ti5BqqryVA7PH0hba4w+te
         J6pQ0MCIQwBBnBIf0c1HnRssdlKKAycqxeBG1RVDqEBV1OqboPmmD3Su09Y0mhc7v1
         pFxY1fv8226SaAgouJNsL/qY815mEjLs/zf3dZTg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5D36A6087D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v7 3/4] Bluetooth: hci_qca: Disable IBS state machine and flush Tx buffer
Date:   Fri, 28 Dec 2018 17:18:18 +0530
Message-Id: <20181228114819.17479-4-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181228114819.17479-1-bgodavar@codeaurora.org>
References: <20181228114819.17479-1-bgodavar@codeaurora.org>
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
index b79ef901ab8b..9d5e41f159c7 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1274,6 +1274,14 @@ static const struct qca_vreg_data qca_soc_data = {
 
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

