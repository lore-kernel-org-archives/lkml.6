Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB01DC070C3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B19421477
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTkR4XoT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B19421477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730419AbeJPMFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:05:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:54452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728951AbeJPMFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:05:21 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68E792148D;
        Tue, 16 Oct 2018 04:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663418;
        bh=x9BNu4eQQeDuftKfoJdePgHeJ7Cz/mC8i8A4hyu3fEM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XTkR4XoTlSQ8TyukukDW2dGVhSgWKfGBgD7TFgvvFeZUbWG62oGLqtwSYi4yOPdDb
         1ueIpubVkZUw7w3rgXzC3gihPdfzLbxulP/3x2hm+7y6wLcq0cgNlTI0g/SbuCE9W7
         pN6PWyPS2d0eXOlPqzie94cEkca5Tj6SzZQgHB8Y=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 06/15] asix: Check for supported Wake-on-LAN modes
Date:   Tue, 16 Oct 2018 00:16:41 -0400
Message-Id: <20181016041650.135958-6-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041650.135958-1-sashal@kernel.org>
References: <20181016041650.135958-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit c4ce446e33d7a0e978256ac6fea4c80e59d9de5f ]

The driver currently silently accepts unsupported Wake-on-LAN modes
(other than WAKE_PHY or WAKE_MAGIC) without reporting that to the user,
which is confusing.

Fixes: 2e55cc7210fe ("[PATCH] USB: usbnet (3/9) module for ASIX Ethernet adapters")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/asix_common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/usb/asix_common.c b/drivers/net/usb/asix_common.c
index 75d6f26729a3..ad81af135a32 100644
--- a/drivers/net/usb/asix_common.c
+++ b/drivers/net/usb/asix_common.c
@@ -417,6 +417,9 @@ int asix_set_wol(struct net_device *net, struct ethtool_wolinfo *wolinfo)
 	struct usbnet *dev = netdev_priv(net);
 	u8 opt = 0;
 
+	if (wolinfo->wolopts & ~(WAKE_PHY | WAKE_MAGIC))
+		return -EINVAL;
+
 	if (wolinfo->wolopts & WAKE_PHY)
 		opt |= AX_MONITOR_LINK;
 	if (wolinfo->wolopts & WAKE_MAGIC)
-- 
2.17.1

