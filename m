Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A382ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60EAC20652
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:11:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60EAC20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731742AbeGRQtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 12:49:49 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60443 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731685AbeGRQts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 12:49:48 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0761B20766; Wed, 18 Jul 2018 18:11:11 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id D0E9120730;
        Wed, 18 Jul 2018 18:11:10 +0200 (CEST)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Yelena Krivosheev <yelena@marvell.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Dmitri Epshtein <dima@marvell.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next v3 7/8] net: mvneta: Verify hardware checksum only when offload checksum feature is set
Date:   Wed, 18 Jul 2018 18:10:56 +0200
Message-Id: <20180718161057.28704-8-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180718161057.28704-1-gregory.clement@bootlin.com>
References: <20180718161057.28704-1-gregory.clement@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yelena Krivosheev <yelena@marvell.com>

If the checksum offload feature is not set, then there is no point to
check the status of the hardware.

[gregory: extract from a larger patch]
Signed-off-by: Yelena Krivosheev <yelena@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 6af583ef2af2..079b515c54c1 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -1720,7 +1720,8 @@ static void mvneta_rx_error(struct mvneta_port *pp,
 static void mvneta_rx_csum(struct mvneta_port *pp, u32 status,
 			   struct sk_buff *skb)
 {
-	if ((status & MVNETA_RXD_L3_IP4) &&
+	if ((pp->dev->features & NETIF_F_RXCSUM) &&
+	    (status & MVNETA_RXD_L3_IP4) &&
 	    (status & MVNETA_RXD_L4_CSUM_OK)) {
 		skb->csum = 0;
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
-- 
2.18.0

