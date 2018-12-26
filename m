Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_RHS_DOB,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA553C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D9E42054F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545863881;
	bh=dkp2YOtjFnnU2agVguo0Bh7UlBlulvbzLj1qK/NVAg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KkBbMwlt056ZRggiwy8cymB8oZfbCD2Z/fqFlVRql9jU9CxNNV2G96mQqnixns6CZ
	 x6RGiCtwEMuQVYinLa2YJlwUWes1fmUxJuZEwQslNDQNMXPpKys/ErHS1ZqjkSAt6r
	 +lG47zcAnzPvqQi1BsGmDa2W9qW0WUiyNztBjCiE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbeLZWiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:38:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:38090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728573AbeLZWh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:37:58 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD00A2054F;
        Wed, 26 Dec 2018 22:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863877;
        bh=dkp2YOtjFnnU2agVguo0Bh7UlBlulvbzLj1qK/NVAg8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OWP7+c9meZOL+FbnAyGVZAIa1oRTw3k21RmQlgw6t5EQTPxJjP4OD3TaVDVBlOZNC
         7eks36RYA3U9K59vNn3L7JW07PZy03vQtYLNLq7qVnysHZVLd11rXPc7sIbkuQNmzM
         NNLv8wp5taFmnyZbbqkRFfK0o/0La/oFtUSP5TF8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        Baruch Siach <baruch@tkos.co.il>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 68/97] net: mvpp2: 10G modes aren't supported on all ports
Date:   Wed, 26 Dec 2018 17:35:28 -0500
Message-Id: <20181226223557.149329-68-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223557.149329-1-sashal@kernel.org>
References: <20181226223557.149329-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Antoine Tenart <antoine.tenart@bootlin.com>

[ Upstream commit 006791772084383de779ef29f2e06f3a6e111e7d ]

The mvpp2_phylink_validate() function sets all modes that are
supported by a given PPv2 port. A recent change made all ports to
advertise they support 10G modes in certain cases. This is not true,
as only the port #0 can do so. This patch fixes it.

Fixes: 01b3fd5ac97c ("net: mvpp2: fix detection of 10G SFP modules")
Cc: Baruch Siach <baruch@tkos.co.il>
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 6320e080b831..d5bc90476b4f 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -4292,12 +4292,14 @@ static void mvpp2_phylink_validate(struct net_device *dev,
 	case PHY_INTERFACE_MODE_10GKR:
 	case PHY_INTERFACE_MODE_XAUI:
 	case PHY_INTERFACE_MODE_NA:
-		phylink_set(mask, 10000baseCR_Full);
-		phylink_set(mask, 10000baseSR_Full);
-		phylink_set(mask, 10000baseLR_Full);
-		phylink_set(mask, 10000baseLRM_Full);
-		phylink_set(mask, 10000baseER_Full);
-		phylink_set(mask, 10000baseKR_Full);
+		if (port->gop_id == 0) {
+			phylink_set(mask, 10000baseCR_Full);
+			phylink_set(mask, 10000baseSR_Full);
+			phylink_set(mask, 10000baseLR_Full);
+			phylink_set(mask, 10000baseLRM_Full);
+			phylink_set(mask, 10000baseER_Full);
+			phylink_set(mask, 10000baseKR_Full);
+		}
 		/* Fall-through */
 	case PHY_INTERFACE_MODE_RGMII:
 	case PHY_INTERFACE_MODE_RGMII_ID:
-- 
2.19.1

