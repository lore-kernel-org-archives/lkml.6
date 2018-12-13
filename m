Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CC4C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AE6A20873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544675433;
	bh=j+nFhipR8gsIQnF7hfYPS7wyNgp46yMvpxGdr+deyMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ciICw+ttkQ7hBeOPbn4L+oPSwGmzR9si5P9+/bmSET89u+qznQHAtplL/UVLANACt
	 nRexTYv7yCEQvalof9v7ljpOMrRHOwdATrBJngs4mWy7UUBEMtOq/E+sdjC9RK+Fbd
	 MebWZ6KvOU7rYAPMA37yoF6HvUPMPnHLjg7oBdeQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AE6A20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbeLMEab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:30:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:43352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727115AbeLMEa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:30:29 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FA7120879;
        Thu, 13 Dec 2018 04:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675428;
        bh=j+nFhipR8gsIQnF7hfYPS7wyNgp46yMvpxGdr+deyMs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O3pfzGe1Dm5HoRjGFnguRvA5ek2mjpCKVhreUXkJABE6OvMHS9NkRM8T2hNyCkhP+
         Mzk6UtpSus4ah8YJClLYJdUopnMU545XZPNV0IJFjJmCgLq8ik/xC1VSP+thmsSso7
         u2IxJcxq2/eMfzbGcDnAeN7g+8lwRDcv1L1faHoY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Baruch Siach <baruch@tkos.co.il>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 57/73] net: mvpp2: fix phylink handling of invalid PHY modes
Date:   Wed, 12 Dec 2018 23:28:22 -0500
Message-Id: <20181213042838.75160-57-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213042838.75160-1-sashal@kernel.org>
References: <20181213042838.75160-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Baruch Siach <baruch@tkos.co.il>

[ Upstream commit 0fb628f0f250c74b1023edd0ca4a57c8b35b9b2c ]

The .validate phylink callback should empty the supported bitmap when
the interface mode is invalid.

Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Antoine Tenart <antoine.tenart@bootlin.com>
Reported-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 33 ++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 1b3b64fea038..6320e080b831 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -4262,8 +4262,27 @@ static void mvpp2_phylink_validate(struct net_device *dev,
 				   unsigned long *supported,
 				   struct phylink_link_state *state)
 {
+	struct mvpp2_port *port = netdev_priv(dev);
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(mask) = { 0, };
 
+	/* Invalid combinations */
+	switch (state->interface) {
+	case PHY_INTERFACE_MODE_10GKR:
+	case PHY_INTERFACE_MODE_XAUI:
+		if (port->gop_id != 0)
+			goto empty_set;
+		break;
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		if (port->gop_id == 0)
+			goto empty_set;
+		break;
+	default:
+		break;
+	}
+
 	phylink_set(mask, Autoneg);
 	phylink_set_port_modes(mask);
 	phylink_set(mask, Pause);
@@ -4271,6 +4290,7 @@ static void mvpp2_phylink_validate(struct net_device *dev,
 
 	switch (state->interface) {
 	case PHY_INTERFACE_MODE_10GKR:
+	case PHY_INTERFACE_MODE_XAUI:
 	case PHY_INTERFACE_MODE_NA:
 		phylink_set(mask, 10000baseCR_Full);
 		phylink_set(mask, 10000baseSR_Full);
@@ -4279,7 +4299,11 @@ static void mvpp2_phylink_validate(struct net_device *dev,
 		phylink_set(mask, 10000baseER_Full);
 		phylink_set(mask, 10000baseKR_Full);
 		/* Fall-through */
-	default:
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+	case PHY_INTERFACE_MODE_SGMII:
 		phylink_set(mask, 10baseT_Half);
 		phylink_set(mask, 10baseT_Full);
 		phylink_set(mask, 100baseT_Half);
@@ -4291,11 +4315,18 @@ static void mvpp2_phylink_validate(struct net_device *dev,
 		phylink_set(mask, 1000baseT_Full);
 		phylink_set(mask, 1000baseX_Full);
 		phylink_set(mask, 2500baseX_Full);
+		break;
+	default:
+		goto empty_set;
 	}
 
 	bitmap_and(supported, supported, mask, __ETHTOOL_LINK_MODE_MASK_NBITS);
 	bitmap_and(state->advertising, state->advertising, mask,
 		   __ETHTOOL_LINK_MODE_MASK_NBITS);
+	return;
+
+empty_set:
+	bitmap_zero(supported, __ETHTOOL_LINK_MODE_MASK_NBITS);
 }
 
 static void mvpp22_xlg_link_state(struct mvpp2_port *port,
-- 
2.19.1

