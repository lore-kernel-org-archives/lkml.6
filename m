Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1657AECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA505206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:35:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA505206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388978AbeGTNXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:23:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42938 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388086AbeGTNXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:23:23 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1E4A4CF2;
        Fri, 20 Jul 2018 12:33:08 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bhadram Varka <vbhadram@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 43/92] stmmac: fix DMA channel hang in half-duplex mode
Date:   Fri, 20 Jul 2018 14:13:47 +0200
Message-Id: <20180720121420.494201259@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121417.206337808@linuxfoundation.org>
References: <20180720121417.206337808@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bhadram Varka <vbhadram@nvidia.com>

[ Upstream commit b6cfffa7ad923c73f317ea50fd4ebcb3b4b6669c ]

HW does not support Half-duplex mode in multi-queue
scenario. Fix it by not advertising the Half-Duplex
mode if multi-queue enabled.

Signed-off-by: Bhadram Varka <vbhadram@nvidia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -914,6 +914,7 @@ static void stmmac_check_pcs_mode(struct
 static int stmmac_init_phy(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
+	u32 tx_cnt = priv->plat->tx_queues_to_use;
 	struct phy_device *phydev;
 	char phy_id_fmt[MII_BUS_ID_SIZE + 3];
 	char bus_id[MII_BUS_ID_SIZE];
@@ -955,6 +956,15 @@ static int stmmac_init_phy(struct net_de
 					 SUPPORTED_1000baseT_Full);
 
 	/*
+	 * Half-duplex mode not supported with multiqueue
+	 * half-duplex can only works with single queue
+	 */
+	if (tx_cnt > 1)
+		phydev->supported &= ~(SUPPORTED_1000baseT_Half |
+				       SUPPORTED_100baseT_Half |
+				       SUPPORTED_10baseT_Half);
+
+	/*
 	 * Broken HW is sometimes missing the pull-up resistor on the
 	 * MDIO line, which results in reads to non-existent devices returning
 	 * 0 rather than 0xffff. Catch this here and treat 0 as a non-existent


