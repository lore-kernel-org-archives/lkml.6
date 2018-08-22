Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCD5C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 12:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B92042098B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 12:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TIYQs+RR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BPB+uX/M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B92042098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbeHVP3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 11:29:08 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58844 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727754AbeHVP3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 11:29:08 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 53EE760159; Wed, 22 Aug 2018 12:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534939470;
        bh=bV1NDFO4xCWocdUuS5Bas+c1kVDWmQA0BN2N0+p3qBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TIYQs+RRBxxbOwQnG6+3MErolTFYjH8zHyTZza6Z7mpn5cVBptxzni6H6NRj+WXWF
         0igp3isi7MWnTEsPKLQrYKp0NjTtM/RiBgP8pT0QEd3N0dvYiebR+K9n3NYyk09kKJ
         7s3wGnTL0Ss071d3wp56rtTjFsgK/BHuW+5rbC4U=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B777D6030D;
        Wed, 22 Aug 2018 12:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534939469;
        bh=bV1NDFO4xCWocdUuS5Bas+c1kVDWmQA0BN2N0+p3qBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BPB+uX/M1JbYikvYfUIGsWat3qIsRc7s3I9qhlW/s6Z91LVuGayNvZivdi7+1PQdz
         E33nq/RPQuT9tBLOtL99JkiV+DPWNK89+GAkEu6WZ+I/Xf37b2QeqBl0XMoov2OLDQ
         oRkNAHkfAijOwGztfcZltxSIzbLwmVQS8howgmbQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B777D6030D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v1 1/2] Bluetooth: hci_serdev: clear HCI_UART_PROTO_READY to avoid closing proto races
Date:   Wed, 22 Aug 2018 17:34:11 +0530
Message-Id: <20180822120412.20285-2-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180822120412.20285-1-bgodavar@codeaurora.org>
References: <20180822120412.20285-1-bgodavar@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clearing HCI_UART_PROTO_READY will avoid usage of proto function pointers
before running the proto close function pointer. There is chance of kernel
crash, due to usage of non proto close function pointers after proto close.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---
 drivers/bluetooth/hci_serdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index aa2543b3c286..46e20444ba19 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -368,6 +368,7 @@ void hci_uart_unregister_device(struct hci_uart *hu)
 {
 	struct hci_dev *hdev = hu->hdev;
 
+	clear_bit(HCI_UART_PROTO_READY, &hu->flags);
 	hci_unregister_dev(hdev);
 	hci_free_dev(hdev);
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

