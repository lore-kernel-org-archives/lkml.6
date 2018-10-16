Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13076C070C3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5C192098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5dHW146"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5C192098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbeJPMBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:01:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:48566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728271AbeJPMB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:01:29 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D00DF21479;
        Tue, 16 Oct 2018 04:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663187;
        bh=eS6LfxP3V7zBCGuWv70mJwsz6N/z7z/1npS5oCzVFNI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k5dHW146oGXo3EArSM63ZfStJJPT0kMElslA/hkxTrqDM6hOdjJgDiTMcubSEPZha
         MV8jyMOd4K8FKcyBLNENgbpqRWjdfZJiFKqfyTNK06yL6pAAZ08jDlT6CrfTM0rxWe
         CP/z15vDnQd19MF/RQi0VLS2oO/VHCCRAZsSgZo4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 049/100] lan78xx: Check for supported Wake-on-LAN modes
Date:   Tue, 16 Oct 2018 00:11:30 -0400
Message-Id: <20181016041221.135528-49-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041221.135528-1-sashal@kernel.org>
References: <20181016041221.135528-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit eb9ad088f96653a26b340f7c447c44cf023d5cdc ]

The driver supports a fair amount of Wake-on-LAN modes, but is not
checking that the user specified one that is supported.

Fixes: 55d7de9de6c3 ("Microchip's LAN7800 family USB 2/3 to 10/100/1000 Ethernet device driver")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Woojung Huh <Woojung.Huh@Microchip.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/lan78xx.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index aeca484a75b8..2bb3a081ff10 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1401,19 +1401,10 @@ static int lan78xx_set_wol(struct net_device *netdev,
 	if (ret < 0)
 		return ret;
 
-	pdata->wol = 0;
-	if (wol->wolopts & WAKE_UCAST)
-		pdata->wol |= WAKE_UCAST;
-	if (wol->wolopts & WAKE_MCAST)
-		pdata->wol |= WAKE_MCAST;
-	if (wol->wolopts & WAKE_BCAST)
-		pdata->wol |= WAKE_BCAST;
-	if (wol->wolopts & WAKE_MAGIC)
-		pdata->wol |= WAKE_MAGIC;
-	if (wol->wolopts & WAKE_PHY)
-		pdata->wol |= WAKE_PHY;
-	if (wol->wolopts & WAKE_ARP)
-		pdata->wol |= WAKE_ARP;
+	if (wol->wolopts & ~WAKE_ALL)
+		return -EINVAL;
+
+	pdata->wol = wol->wolopts;
 
 	device_set_wakeup_enable(&dev->udev->dev, (bool)wol->wolopts);
 
-- 
2.17.1

