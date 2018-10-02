Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC726C64EBC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 23:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C57D20666
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 23:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhqQxB9z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C57D20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbeJCGkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 02:40:49 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37833 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbeJCGks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 02:40:48 -0400
Received: by mail-qk1-f193.google.com with SMTP id x8-v6so2367282qka.4;
        Tue, 02 Oct 2018 16:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7W+fynjKrnTeSdB+hRvIBvBA1YTPZIJJ4Hhu/WF9Xks=;
        b=hhqQxB9zlrjdja/4jhQxSuFxWiEdAHOI/U5iAiGJ6Rz1OpetkiTcf3mvtgitzer9dW
         GGB4dG8xxzL7IbV/nzI7QRBjJSXW70c81DNooEXIsN7eJKRSiAwWTcrAruR+8PUbn8MU
         WhMbYHnmXrwPDPNKNQCPMNuxT9JMqEmqXcNqkOaXQ3AVw++JwJWCZnIR1FLIaxjg/cHO
         lh0E6yRSPU7lUX4R/a+Iu3hCbaOMqcizorXXkhxlCWtvygnQ/kSqNK6Yabitl0gfQFlD
         VsWSPvl4SQBx3Zp1GdPjbG8ZsNztjO34SIxA5S0vo1FruWP+ZbLicZaAp14o+8/rSqVm
         /yJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7W+fynjKrnTeSdB+hRvIBvBA1YTPZIJJ4Hhu/WF9Xks=;
        b=mVk/Nyra1qBZGNAOT6kHbQKoRgFb5Z9fIdFsEByLQeJAHMJOq4viTX/wX1WRaojUTh
         zFQqzSKnK5K+eFlpuh9S0QhEjv741pRrjrNUT5h745j4vtPmmHuZ/Ev0cxd/F0U8XQ+9
         wxo1k99DCv1M+r+l1OWTZmfmamLMpUKUc3z0KtQ8yVhGOAZEuaD8NMkXY66TUoyA+DcC
         Ukje68MG4Jv2l/U9atWvTdJuRM+yvDyz1erc5LqX7iAGZpELyzN1AmlabljOxKh0v5dU
         t9BIVIqsc2gbh60KZo31XgurOG+ANBRE32ePkGltb1+x4jQXu2TTJLSU6NSuuqvUtTtx
         evhA==
X-Gm-Message-State: ABuFfojSAWYkzSmjxhk5syXtlBZOgX5tzRYJQfoxiBN46f+WqfvpgZXF
        VVXkRnzYyMS392kGTbyPNfM7e+7y
X-Google-Smtp-Source: ACcGV60vqBVhB+RA1vKbc3l0Gy3+tsyyJ5OuGApXm+RSSKJbOuVyqKqVBo4VRW2kc9+PkIChOJuKPw==
X-Received: by 2002:a37:14d4:: with SMTP id 81-v6mr13554689qku.201.1538524495431;
        Tue, 02 Oct 2018 16:54:55 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id g34-v6sm7522382qta.79.2018.10.02.16.54.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 16:54:54 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: systemport: Fix wake-up interrupt race during resume
Date:   Tue,  2 Oct 2018 16:52:03 -0700
Message-Id: <20181002235204.26135-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AON_PM_L2 is normally used to trigger and identify the source of a
wake-up event. Since the RX_SYS clock is no longer turned off, we also
have an interrupt being sent to the SYSTEMPORT INTRL_2_0 controller, and
that interrupt remains active up until the magic packet detector is
disabled which happens much later during the driver resumption.

The race happens if we have a CPU that is entering the SYSTEMPORT
INTRL2_0 handler during resume, and another CPU has managed to clear the
wake-up interrupt during bcm_sysport_resume_from_wol(). In that case, we
have the first CPU stuck in the interrupt handler with an interrupt
cause that has been cleared under its feet, and so we keep returning
IRQ_NONE and we never make any progress.

This was not a problem before because we would always turn off the
RX_SYS clock during WoL, so the SYSTEMPORT INTRL2_0 would also be turned
off as well, thus not latching the interrupt.

The fix is to make sure we do not enable either the MPD or
BRCM_TAG_MATCH interrupts since those are redundant with what the
AON_PM_L2 interrupt controller already processes and they would cause
such a race to occur.

Fixes: bb9051a2b230 ("net: systemport: Add support for WAKE_FILTER")
Fixes: 83e82f4c706b ("net: systemport: add Wake-on-LAN support")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/broadcom/bcmsysport.c | 28 +++++++++-------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index 147045757b10..c57238fce863 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -1069,9 +1069,6 @@ static void bcm_sysport_resume_from_wol(struct bcm_sysport_priv *priv)
 {
 	u32 reg;
 
-	/* Stop monitoring MPD interrupt */
-	intrl2_0_mask_set(priv, INTRL2_0_MPD | INTRL2_0_BRCM_MATCH_TAG);
-
 	/* Disable RXCHK, active filters and Broadcom tag matching */
 	reg = rxchk_readl(priv, RXCHK_CONTROL);
 	reg &= ~(RXCHK_BRCM_TAG_MATCH_MASK <<
@@ -1081,6 +1078,17 @@ static void bcm_sysport_resume_from_wol(struct bcm_sysport_priv *priv)
 	/* Clear the MagicPacket detection logic */
 	mpd_enable_set(priv, false);
 
+	reg = intrl2_0_readl(priv, INTRL2_CPU_STATUS);
+	if (reg & INTRL2_0_MPD)
+		netdev_info(priv->netdev, "Wake-on-LAN (MPD) interrupt!\n");
+
+	if (reg & INTRL2_0_BRCM_MATCH_TAG) {
+		reg = rxchk_readl(priv, RXCHK_BRCM_TAG_MATCH_STATUS) &
+				  RXCHK_BRCM_TAG_MATCH_MASK;
+		netdev_info(priv->netdev,
+			    "Wake-on-LAN (filters 0x%02x) interrupt!\n", reg);
+	}
+
 	netif_dbg(priv, wol, priv->netdev, "resumed from WOL\n");
 }
 
@@ -1105,7 +1113,6 @@ static irqreturn_t bcm_sysport_rx_isr(int irq, void *dev_id)
 	struct bcm_sysport_priv *priv = netdev_priv(dev);
 	struct bcm_sysport_tx_ring *txr;
 	unsigned int ring, ring_bit;
-	u32 reg;
 
 	priv->irq0_stat = intrl2_0_readl(priv, INTRL2_CPU_STATUS) &
 			  ~intrl2_0_readl(priv, INTRL2_CPU_MASK_STATUS);
@@ -1131,16 +1138,6 @@ static irqreturn_t bcm_sysport_rx_isr(int irq, void *dev_id)
 	if (priv->irq0_stat & INTRL2_0_TX_RING_FULL)
 		bcm_sysport_tx_reclaim_all(priv);
 
-	if (priv->irq0_stat & INTRL2_0_MPD)
-		netdev_info(priv->netdev, "Wake-on-LAN (MPD) interrupt!\n");
-
-	if (priv->irq0_stat & INTRL2_0_BRCM_MATCH_TAG) {
-		reg = rxchk_readl(priv, RXCHK_BRCM_TAG_MATCH_STATUS) &
-				  RXCHK_BRCM_TAG_MATCH_MASK;
-		netdev_info(priv->netdev,
-			    "Wake-on-LAN (filters 0x%02x) interrupt!\n", reg);
-	}
-
 	if (!priv->is_lite)
 		goto out;
 
@@ -2641,9 +2638,6 @@ static int bcm_sysport_suspend_to_wol(struct bcm_sysport_priv *priv)
 	/* UniMAC receive needs to be turned on */
 	umac_enable_set(priv, CMD_RX_EN, 1);
 
-	/* Enable the interrupt wake-up source */
-	intrl2_0_mask_clear(priv, INTRL2_0_MPD | INTRL2_0_BRCM_MATCH_TAG);
-
 	netif_dbg(priv, wol, ndev, "entered WOL mode\n");
 
 	return 0;
-- 
2.17.1

