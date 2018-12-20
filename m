Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BFFC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B038020989
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298382;
	bh=zDZidYK3ddE6HMqqTppHGgCaqV17mOhHX5LHUN3CzCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R7PofGP5c4k4ROpwOxYlZ88HJU/vCHUsm/0wNoXhuKuJtavkjr/OQHmevSBsimiAP
	 kLJTMi7Nx+uRHvJnczUv8LUVaM8jamHBOhI4XWoGL1PrpAJfjSODtFxsj3CIg/qhqx
	 XG/kXtglBt92MizgCouvtNDBDqEEUcU7tiL2wpWU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733226AbeLTJdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:33:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:41542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732983AbeLTJat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:30:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37F2421741;
        Thu, 20 Dec 2018 09:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298248;
        bh=zDZidYK3ddE6HMqqTppHGgCaqV17mOhHX5LHUN3CzCY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dkhtpNJoJWr78Ugg7MONlDNOLfUBdNXxOrlo3FJSu+KtWBLv0TCGhWGh77cH1kHMI
         wiWKlvQr7eTHUrHWWWaWxG2UEPK+0PO3OcnGd2vgMIOz/+D0MndkWtTKR7jWURx/lx
         7G5ohIdlJSjEOH9O1HwL+Mwo3mQIqa4TcRJGbIco=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Baruch Siach <baruch@tkos.co.il>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 53/67] net: mvpp2: fix phylink handling of invalid PHY modes
Date:   Thu, 20 Dec 2018 10:19:05 +0100
Message-Id: <20181220085905.642107004@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085903.562090333@linuxfoundation.org>
References: <20181220085903.562090333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



