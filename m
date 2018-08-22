Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC15C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 12:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68E652098B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 12:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="C8fhAVHF";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="C8fhAVHF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68E652098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbeHVP3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 11:29:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58940 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727754AbeHVP3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 11:29:12 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B8EA86022B; Wed, 22 Aug 2018 12:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534939473;
        bh=un1c80IPdZ62Xf+AxsoPu3ZnIDAwPVXQEmbC4raqoY0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C8fhAVHFCxvnecjIQq+s4jPSeMWody2iRrTWoJMPzOYE5UsHM0njJy/0519VAEewM
         XQey4TsYuBK5nhWmwuB7pYPSkrJuiU0hThcwhqwICJ7a0f7vxb6Pd3u8br0WFqgpfe
         yfhrPZzA40C/yfkWsX9hw29AEMhWxJ97CZObe2X4=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 310126049C;
        Wed, 22 Aug 2018 12:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534939473;
        bh=un1c80IPdZ62Xf+AxsoPu3ZnIDAwPVXQEmbC4raqoY0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C8fhAVHFCxvnecjIQq+s4jPSeMWody2iRrTWoJMPzOYE5UsHM0njJy/0519VAEewM
         XQey4TsYuBK5nhWmwuB7pYPSkrJuiU0hThcwhqwICJ7a0f7vxb6Pd3u8br0WFqgpfe
         yfhrPZzA40C/yfkWsX9hw29AEMhWxJ97CZObe2X4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 310126049C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v1 2/2] Bluetooth: hci_serdev: Add protocol check in hci_uart_dequeue().
Date:   Wed, 22 Aug 2018 17:34:12 +0530
Message-Id: <20180822120412.20285-3-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180822120412.20285-1-bgodavar@codeaurora.org>
References: <20180822120412.20285-1-bgodavar@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will help to check the status of protocol while dequeuing an
skb packet. In some instaces we will end up kernel crash,
where proto close is called and we trying to dequeue an packet.

[  500.142902] [<ffffff80080f9ce4>] do_raw_spin_lock+0x1c/0xe0
[  500.148643] [<ffffff80088f1c7c>] _raw_spin_lock_irqsave+0x38/0x48
[  500.154917] [<ffffff8008780ce8>] skb_dequeue+0x28/0x84
[  500.160209] [<ffffff8000ad6f48>] 0xffffff8000ad6f48
[  500.165230] [<ffffff8000ad6610>] 0xffffff8000ad6610
[  500.170257] [<ffffff80080c7ce8>] process_one_work+0x238/0x3e4
[  500.176174] [<ffffff80080c8330>] worker_thread+0x2bc/0x3d4
[  500.181821] [<ffffff80080cdabc>] kthread+0x138/0x140
[  500.186945] [<ffffff80080844e0>] ret_from_fork+0x10/0x18

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---
 drivers/bluetooth/hci_serdev.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index 46e20444ba19..a541e6ee085e 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -57,9 +57,10 @@ static inline struct sk_buff *hci_uart_dequeue(struct hci_uart *hu)
 {
 	struct sk_buff *skb = hu->tx_skb;
 
-	if (!skb)
-		skb = hu->proto->dequeue(hu);
-	else
+	if (!skb) {
+		if (test_bit(HCI_UART_PROTO_READY, &hu->flags))
+			skb = hu->proto->dequeue(hu);
+	} else
 		hu->tx_skb = NULL;
 
 	return skb;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

