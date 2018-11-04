Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F62C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86C0B2133D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ygi5nUtv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86C0B2133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729983AbeKDXHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 18:07:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:44194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729898AbeKDXHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 18:07:01 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6B562086D;
        Sun,  4 Nov 2018 13:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541339517;
        bh=aXlH03divee5fhux/roZfKZr/oG9r/F1Mc5hO0IEskY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ygi5nUtv/c4xqxviyOpweCVwbP2yNw623St/n5pzo6Pamo0SIMlUFmANgItFott66
         WlUb/gCRdd870gEA1rKLrAGNbFz3XOTPerHB/V3d6YbxuytkEtZ+CDuqxG8ooDsk8r
         fLq8V7s546HIc3HbEFqlskRTAtXdtDqMxAzGnIyE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 09/57] r8169: fix broken Wake-on-LAN from S5 (poweroff)
Date:   Sun,  4 Nov 2018 08:50:56 -0500
Message-Id: <20181104135144.88324-9-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104135144.88324-1-sashal@kernel.org>
References: <20181104135144.88324-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit 649f0837a8cc2b39329f2de00fa0d04b029291c5 ]

It was reported that WoL from S5 is broken (WoL from S3 works) and the
analysis showed that during system shutdown the network interface was
brought down already when the actual kernel shutdown started.
Therefore netif_running() returned false and as a consequence the PHY
was suspended. Obviously WoL wasn't working then.
To fix this the original patch needs to be effectively reverted.
A side effect is that when normally bringing down the interface and
WoL is enabled the PHY will remain powered on (like it was before the
original patch).

Fixes: fe87bef01f9b ("r8169: don't check WoL when powering down PHY and interface is down")
Reported-by: Neil MacLeod <neil@nmacleod.com>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/realtek/r8169.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
index 2c350099b83c..4930e0375c1d 100644
--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -4175,10 +4175,15 @@ static void rtl_wol_suspend_quirk(struct rtl8169_private *tp)
 
 static bool rtl_wol_pll_power_down(struct rtl8169_private *tp)
 {
-	if (!netif_running(tp->dev) || !__rtl8169_get_wol(tp))
+	struct phy_device *phydev;
+
+	if (!__rtl8169_get_wol(tp))
 		return false;
 
-	phy_speed_down(tp->dev->phydev, false);
+	/* phydev may not be attached to netdevice */
+	phydev = mdiobus_get_phy(tp->mii_bus, 0);
+
+	phy_speed_down(phydev, false);
 	rtl_wol_suspend_quirk(tp);
 
 	return true;
-- 
2.17.1

