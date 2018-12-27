Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E08C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 07:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F319E214AE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 07:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Hk6kiVG1";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EQICjDx8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729967AbeL0HcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 02:32:08 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:50110 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729457AbeL0HcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 02:32:06 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 805EA60918; Thu, 27 Dec 2018 07:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545895925;
        bh=btUQQKXgsCdglwp3vBDfEEuIUYTBwupLr+lr7XfUx4Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hk6kiVG17OqrD339DSZJr9onwSHh6hcsFR7kAaCk0b1DVSufI6hWmzNxBBk7EwRxF
         G6tWkE42n75Mjweph0mzcM1tIh9IuGX1iqAZO/HHtWG8+nMfm1ULNrFvYQQIorh5uI
         DSyN06SUhMw1z6dWLYBO+jbOgQmXBtgPZneAH3RM=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B21656085C;
        Thu, 27 Dec 2018 07:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545895919;
        bh=btUQQKXgsCdglwp3vBDfEEuIUYTBwupLr+lr7XfUx4Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EQICjDx8inkYKF5RhZnrFtSIHfDcs9Pl4LFMNE9cbVK0fK0+q4trZf0HCDC2wRYYa
         2BKBloTpVzIBo8dcwHXZr+LVWww8PlkWF+jh65BjsaAGmmUZIPGEp8kYrC92LCkFq6
         M/CPD89+qSqti+BtXwXBCDM+ZM0pyDR7gaEueBvk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B21656085C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v6 4/6] Bluetooth: hci_qca: Disable IBS state machine and flush Tx buffer
Date:   Thu, 27 Dec 2018 13:01:34 +0530
Message-Id: <20181227073136.8431-5-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181227073136.8431-1-bgodavar@codeaurora.org>
References: <20181227073136.8431-1-bgodavar@codeaurora.org>
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
index 0751b2359f6f..4677a6a2716a 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1287,6 +1287,8 @@ static void qca_power_shutdown(struct hci_uart *hu)
 	 * still open, discard all the garbage data received on the Rx line.
 	 */
 	set_bit(STATE_DISCARD_RX, &qca->flags);
+	clear_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
+	qca_flush(hu);
 	host_set_baudrate(hu, 2400);
 	qca_send_power_pulse(hu, QCA_WCN3990_POWEROFF_PULSE);
 	qca_power_setup(hu, false);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

