Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3EAC43612
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1E9E217D8
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="icha6Lb5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TjBnQc4G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387814AbeLTOrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 09:47:07 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:54156 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387799AbeLTOrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 09:47:05 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 103376090F; Thu, 20 Dec 2018 14:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545317224;
        bh=AZMXAIN7S6vMIdRGM+a5k5BTs2hKF3B2m22rlgS88Nw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=icha6Lb5zcmZ8cTAvzIKly0F7MbMEg2Xrm+LW3sdyk1p9x1pgt6Qhhd2k81LOjRUn
         67nMUzRui2kKgJVzukrWkYPNINxm3+brJCjfFmaGHKFraGx3FyDKFlftdOyq0sg6bc
         1HOd1Fh4xZdB5hZyWcgzRMMol2HT1LHSYWLpTAJo=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 801BA6090F;
        Thu, 20 Dec 2018 14:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545317222;
        bh=AZMXAIN7S6vMIdRGM+a5k5BTs2hKF3B2m22rlgS88Nw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TjBnQc4GW2f5GSNIvBNQw1Kq1X3XE31X61MR1SS9BMBnY6+DVSm0huU3K0zepxCJB
         ouTuxnXJTasqanPaF6a6LlCjukavQLBpT0w7xtP7308jskpwsLgOiWIA2ueYnPPLyy
         Uhr2b5r4EBtWsPil7A7fjZxq+Yd7nfbJw7Ldwqus=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 801BA6090F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, johan@kernel.org
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v5 4/5] Bluetooth: hci_qca: Disable IBS state machine and flush Tx buffer
Date:   Thu, 20 Dec 2018 20:16:38 +0530
Message-Id: <20181220144639.15928-5-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181220144639.15928-1-bgodavar@codeaurora.org>
References: <20181220144639.15928-1-bgodavar@codeaurora.org>
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
 drivers/bluetooth/hci_qca.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 52de0b5a0620..cccc9a525926 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1286,6 +1286,8 @@ static void qca_power_shutdown(struct hci_uart *hu)
 	 * still open, discard all the garbage data received on the Rx line.
 	 */
 	set_bit(STATE_DISCARD_RX, &qca->flags);
+	clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
+	qca_flush(hu);
 	serdev_device_write_flush(hu->serdev);
 	host_set_baudrate(hu, 2400);
 	qca_send_power_pulse(hu, QCA_WCN3990_POWEROFF_PULSE);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

