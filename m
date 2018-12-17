Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944EEC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 624702133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ca2Gl0wV";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eMQ5Tz1g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387468AbeLQOOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 09:14:06 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:47566 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387453AbeLQOOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 09:14:02 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F2CEA606FC; Mon, 17 Dec 2018 14:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545056042;
        bh=1iNLe8WRn+N9odS3ukywBfnZVhfKUsjwDcgpCLJyDsw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ca2Gl0wVpzOR8GPNOiqizqFFwYY0N8rJvmVEaYAgbk9DvjoTyNqBqVd+JqelojCft
         ueEDKr5RnKgIwnQ6m3h0xhq47Jd0SQ3XMTmj1ilWZgp7DYrsw8VrLy2vzcdTZo+RwC
         ebb8stUTkdyk6SeliitzIVYuzcPrH+4etn8+6Tks=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8F5766076A;
        Mon, 17 Dec 2018 14:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545056039;
        bh=1iNLe8WRn+N9odS3ukywBfnZVhfKUsjwDcgpCLJyDsw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eMQ5Tz1gOaoTQUz47MbZ1XkTgk8FLwhZpa3VkHI3jUXLA2jDnaz2hbsqg6wGrBlDC
         i8Mt+96bln1U58Td9ouRY29INk6GADV+UIb7O7VDAWj2vHZxnienGNXqlyOdEIBWxx
         1pRhW3J7kc8O4RySRIZq8WXTb37yxnJSb/9sYww4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8F5766076A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, johan@kernel.org
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v4 4/5] Bluetooth: hci_qca: Disable IBS state machine and flush Tx buffer
Date:   Mon, 17 Dec 2018 19:43:29 +0530
Message-Id: <20181217141330.6294-5-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181217141330.6294-1-bgodavar@codeaurora.org>
References: <20181217141330.6294-1-bgodavar@codeaurora.org>
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
v4:
  * no change.
v3: 
  * initial patch
---
 drivers/bluetooth/hci_qca.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index e7e65c4361e6..cb1695bac4f0 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1286,6 +1286,8 @@ static void qca_power_shutdown(struct hci_uart *hu)
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

