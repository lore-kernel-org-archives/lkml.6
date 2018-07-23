Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEBEECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2355220880
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2355220880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388742AbeGWN2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:28:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45540 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387909AbeGWN2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:28:54 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5FB21BE1;
        Mon, 23 Jul 2018 12:27:56 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 57/63] net: systemport: Fix CRC forwarding check for SYSTEMPORT Lite
Date:   Mon, 23 Jul 2018 14:25:03 +0200
Message-Id: <20180723122448.510502610@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122446.351334162@linuxfoundation.org>
References: <20180723122446.351334162@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit 9e3bff923913729d76d87f0015848ee7b8ff7083 ]

SYSTEMPORT Lite reversed the logic compared to SYSTEMPORT, the
GIB_FCS_STRIP bit is set when the Ethernet FCS is stripped, and that bit
is not set by default. Fix the logic such that we properly check whether
that bit is set or not and we don't forward an extra 4 bytes to the
network stack.

Fixes: 44a4524c54af ("net: systemport: Add support for SYSTEMPORT Lite")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bcmsysport.c |    4 ++--
 drivers/net/ethernet/broadcom/bcmsysport.h |    3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -1946,8 +1946,8 @@ static int bcm_sysport_open(struct net_d
 	if (!priv->is_lite)
 		priv->crc_fwd = !!(umac_readl(priv, UMAC_CMD) & CMD_CRC_FWD);
 	else
-		priv->crc_fwd = !!(gib_readl(priv, GIB_CONTROL) &
-				   GIB_FCS_STRIP);
+		priv->crc_fwd = !((gib_readl(priv, GIB_CONTROL) &
+				  GIB_FCS_STRIP) >> GIB_FCS_STRIP_SHIFT);
 
 	phydev = of_phy_connect(dev, priv->phy_dn, bcm_sysport_adj_link,
 				0, priv->phy_interface);
--- a/drivers/net/ethernet/broadcom/bcmsysport.h
+++ b/drivers/net/ethernet/broadcom/bcmsysport.h
@@ -278,7 +278,8 @@ struct bcm_rsb {
 #define  GIB_GTX_CLK_EXT_CLK		(0 << GIB_GTX_CLK_SEL_SHIFT)
 #define  GIB_GTX_CLK_125MHZ		(1 << GIB_GTX_CLK_SEL_SHIFT)
 #define  GIB_GTX_CLK_250MHZ		(2 << GIB_GTX_CLK_SEL_SHIFT)
-#define  GIB_FCS_STRIP			(1 << 6)
+#define  GIB_FCS_STRIP_SHIFT		6
+#define  GIB_FCS_STRIP			(1 << GIB_FCS_STRIP_SHIFT)
 #define  GIB_LCL_LOOP_EN		(1 << 7)
 #define  GIB_LCL_LOOP_TXEN		(1 << 8)
 #define  GIB_RMT_LOOP_EN		(1 << 9)


