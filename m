Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8009C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88C67206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547218454;
	bh=zergbhZxIP/65RF9oYAbcL0q43Lm5R58BWLpp2TP35Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ySzSilMdOzkdripcOxUxejZHlj6yb8BI9R4Ove39pbVI9GAhJV0r6bhnTNM3neOq3
	 1triLVPtaNI9hy/JfBy8M2xqYxQQEt/pVczmJaeiOoZFR1G8+FZaNz4iUUVNQqRHLg
	 GCYf4IOArs+S0BCMu9J+jlP8VRfbjQ2E7dEC03+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391655AbfAKOyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:54:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:58294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390247AbfAKOhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:37:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01D722133F;
        Fri, 11 Jan 2019 14:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217462;
        bh=zergbhZxIP/65RF9oYAbcL0q43Lm5R58BWLpp2TP35Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dp5DiX7Mh8WRyqlXSR+D5fGUgeoPiLkkc2sVsdLBHCI3bOavXOoRM/jyGBTwvHXxd
         FtIdswKDKbvzXxSBY/shVcYIIHDUJuKWuSeMBdefyjK+XI9B3M+S4Rxr2fuTeF1X2r
         nLkZvCn26+HILnX9182JWqBPtl/i4u+ExSdsO44Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bryan Whitehead <Bryan.Whitehead@microchip.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 062/148] lan743x: Expand phy search for LAN7431
Date:   Fri, 11 Jan 2019 15:14:00 +0100
Message-Id: <20190111131116.737855075@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
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

[ Upstream commit 0db7d253e9f0ff1a41c602429bea93df221be6ed ]

The LAN7431 uses an external phy, and it can be found anywhere in
the phy address space. This patch uses phy address 1 for LAN7430
only. And searches all addresses otherwise.

Signed-off-by: Bryan Whitehead <Bryan.Whitehead@microchip.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/microchip/lan743x_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index aaedf1072460..ff196a66eaaa 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -2722,8 +2722,9 @@ static int lan743x_mdiobus_init(struct lan743x_adapter *adapter)
 	snprintf(adapter->mdiobus->id, MII_BUS_ID_SIZE,
 		 "pci-%s", pci_name(adapter->pdev));
 
-	/* set to internal PHY id */
-	adapter->mdiobus->phy_mask = ~(u32)BIT(1);
+	if ((adapter->csr.id_rev & ID_REV_ID_MASK_) == ID_REV_ID_LAN7430_)
+		/* LAN7430 uses internal phy at address 1 */
+		adapter->mdiobus->phy_mask = ~(u32)BIT(1);
 
 	/* register mdiobus */
 	ret = mdiobus_register(adapter->mdiobus);
-- 
2.19.1



