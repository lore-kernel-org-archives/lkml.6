Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130ABC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D08AC204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="whVZwCzd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D08AC204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730396AbeJSCII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:08:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:57030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730384AbeJSCIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:08:07 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1CFF204FD;
        Thu, 18 Oct 2018 18:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885960;
        bh=b7wRveuyhzWc6pDLQETqtF3mepB0A8qy4fZca+hV98M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=whVZwCzdXaS5c2fWc98d59zTCjDCW015udqaREyN45xc1O2EOtLf3ZEu4cFMENR6F
         cG9oKPXrp7K0HFAMyPPljYDy5h5wyMmsNpkx2NRrWtlM58IM55ZyWv2m1huxXxomXf
         Me5BxRcUanHBdmOpmxoTOoR9q8SO+PJk4UJ4G5j8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 29/48] net: systemport: Fix wake-up interrupt race during resume
Date:   Thu, 18 Oct 2018 19:55:04 +0200
Message-Id: <20181018175429.529030981@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175427.133690306@linuxfoundation.org>
References: <20181018175427.133690306@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -850,14 +850,22 @@ static void bcm_sysport_resume_from_wol(
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
 
@@ -890,11 +898,6 @@ static irqreturn_t bcm_sysport_rx_isr(in
 	if (priv->irq0_stat & INTRL2_0_TX_RING_FULL)
 		bcm_sysport_tx_reclaim_all(priv);
 
-	if (priv->irq0_stat & INTRL2_0_MPD) {
-		netdev_info(priv->netdev, "Wake-on-LAN interrupt!\n");
-		bcm_sysport_resume_from_wol(priv);
-	}
-
 	return IRQ_HANDLED;
 }
 
@@ -1915,9 +1918,6 @@ static int bcm_sysport_suspend_to_wol(st
 	/* UniMAC receive needs to be turned on */
 	umac_enable_set(priv, CMD_RX_EN, 1);
 
-	/* Enable the interrupt wake-up source */
-	intrl2_0_mask_clear(priv, INTRL2_0_MPD);
-
 	netif_dbg(priv, wol, ndev, "entered WOL mode\n");
 
 	return 0;


