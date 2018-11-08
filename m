Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25499ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E121120857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPNaM9xN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E121120857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbeKIHbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:31:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:45850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727765AbeKIHbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:31:20 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BAEE20857;
        Thu,  8 Nov 2018 21:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714033;
        bh=1gi5CcXdD8djwcRXtymG0X2sEhVZVCYJc6ahvjrOo7M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XPNaM9xNs9AbUdiTZ6wPifyNct84re3MeZOOnO5Qwlkr8wy4kG7OpocQPtbOmHEeU
         XwKgyWhZDy5lFJdBbzw1nDaaHQvb4aILR6NHLcQ+eUzop3KEx3AAcEVgOOmc01eRuU
         rWfviR9o/teIZrRpW2yQP48VBysz+r8x+JyhMe4Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 014/144] net: systemport: Fix wake-up interrupt race during resume
Date:   Thu,  8 Nov 2018 13:49:45 -0800
Message-Id: <20181108215055.824490259@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit 45ec318578c0c22a11f5b9927d064418e1ab1905 ]

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
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bcmsysport.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -769,14 +769,22 @@ static void bcm_sysport_resume_from_wol(
 {
 	u32 reg;
 
-	/* Stop monitoring MPD interrupt */
-	intrl2_0_mask_set(priv, INTRL2_0_MPD);
-
 	/* Clear the MagicPacket detection logic */
 	reg = umac_readl(priv, UMAC_MPD_CTRL);
 	reg &= ~MPD_EN;
 	umac_writel(priv, reg, UMAC_MPD_CTRL);
 
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
 
@@ -809,11 +817,6 @@ static irqreturn_t bcm_sysport_rx_isr(in
 	if (priv->irq0_stat & INTRL2_0_TX_RING_FULL)
 		bcm_sysport_tx_reclaim_all(priv);
 
-	if (priv->irq0_stat & INTRL2_0_MPD) {
-		netdev_info(priv->netdev, "Wake-on-LAN interrupt!\n");
-		bcm_sysport_resume_from_wol(priv);
-	}
-
 	return IRQ_HANDLED;
 }
 
@@ -1786,9 +1789,6 @@ static int bcm_sysport_suspend_to_wol(st
 	/* UniMAC receive needs to be turned on */
 	umac_enable_set(priv, CMD_RX_EN, 1);
 
-	/* Enable the interrupt wake-up source */
-	intrl2_0_mask_clear(priv, INTRL2_0_MPD);
-
 	netif_dbg(priv, wol, ndev, "entered WOL mode\n");
 
 	return 0;


