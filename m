Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5905C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 04:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B2F321473
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 04:44:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B2F321473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbeHTH6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 03:58:03 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40688 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbeHTH6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 03:58:03 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1frc2n-0005pM-FF; Mon, 20 Aug 2018 04:43:58 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     davem@davemloft.net
Cc:     linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] r8152: disable RX aggregation on new Dell TB16 dock
Date:   Mon, 20 Aug 2018 12:43:51 +0800
Message-Id: <20180820044351.13368-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a new Dell TB16 dock with a different iSerialNumber.

Apply the same fix from commit 0b1655143df0 ("r8152: disable RX
aggregation on Dell TB16 dock") to this model.

BugLink: https://bugs.launchpad.net/bugs/1785780
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/net/usb/r8152.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 97742708460b..2cd71bdb6484 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -5217,8 +5217,8 @@ static int rtl8152_probe(struct usb_interface *intf,
 		netdev->hw_features &= ~NETIF_F_RXCSUM;
 	}
 
-	if (le16_to_cpu(udev->descriptor.bcdDevice) == 0x3011 &&
-	    udev->serial && !strcmp(udev->serial, "000001000000")) {
+	if (le16_to_cpu(udev->descriptor.bcdDevice) == 0x3011 && udev->serial &&
+	    (!strcmp(udev->serial, "000001000000") || !strcmp(udev->serial, "000002000000"))) {
 		dev_info(&udev->dev, "Dell TB16 Dock, disable RX aggregation");
 		set_bit(DELL_TB_RX_AGG_BUG, &tp->flags);
 	}
-- 
2.17.1

