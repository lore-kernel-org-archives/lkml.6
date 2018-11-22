Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13140C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 12:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7FF2206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 12:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="egIVvpO6";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="omsV550n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7FF2206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436758AbeKVXaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 18:30:11 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:37814 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388647AbeKVXaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 18:30:10 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 47E2960712; Thu, 22 Nov 2018 12:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542891057;
        bh=oNhIxjK5O7kpmeHNK1YUXPZoA0AcFe2A1HdQQx7ZPiI=;
        h=From:To:Cc:Subject:Date:From;
        b=egIVvpO60ORWGDVbJpsHIdmBJYtcyN7K2ZadWsNx551tmxT1xUDG8c12DrV+jsTrI
         9iMhSOs0aVXvzIpokvoyGlKUIOGR+V2WzPgfxbMT3EzOsR9fNHzp4rcLbFS/keaHj6
         a7kJHUIU7DVjVqS58HbMgoz1oqIJQnib/mxPXndI=
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D7DAF60227;
        Thu, 22 Nov 2018 12:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542891056;
        bh=oNhIxjK5O7kpmeHNK1YUXPZoA0AcFe2A1HdQQx7ZPiI=;
        h=From:To:Cc:Subject:Date:From;
        b=omsV550nTmounSTZsShVFI9Aqu665Nm1UWv6bMGGReLaJ39RZ6WWAQnPMKhyC3Kh0
         a34+EesGY9LyY4n6BZoTrjFCSBy+IzVqWdb3owJhhU1wmNC91BJ41p/TF5gyEONg2m
         xcFAJGhiZev4ddyQBqyIy9R5pR/No5EgxSdiZzEE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D7DAF60227
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v1] Bluetooth: hci_serdev: Remove setting of HCI_QUIRK_RESET_ON_CLOSE.
Date:   Thu, 22 Nov 2018 18:20:47 +0530
Message-Id: <20181122125047.725-1-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HCI_QUIRK_RESET_ON_CLOSE quirk is required for BT v1.0 based devices,
to send a reset command to the chip during hci device close. Serdev
architecture is used for the latest BT chips, which doesn't require to
send the reset command during close. If still chips required reset
command during close, it would be better enabling it in the vendor
probes or in proto setup.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---
 drivers/bluetooth/hci_serdev.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index c445aa9ac511..490abba94363 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -333,9 +333,6 @@ int hci_uart_register_device(struct hci_uart *hu,
 	if (test_bit(HCI_UART_EXT_CONFIG, &hu->hdev_flags))
 		set_bit(HCI_QUIRK_EXTERNAL_CONFIG, &hdev->quirks);
 
-	if (!test_bit(HCI_UART_RESET_ON_INIT, &hu->hdev_flags))
-		set_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);
-
 	if (test_bit(HCI_UART_CREATE_AMP, &hu->hdev_flags))
 		hdev->dev_type = HCI_AMP;
 	else
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

