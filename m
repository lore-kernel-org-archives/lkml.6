Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F057C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC7D222AE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897357;
	bh=Jztei4wtUJY23q7+WOE14c2Cnm/qGhQw5d89Fch0mR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j85v9NYhn5DH8X5o6+7JFWq41fGoH+xOBKTXC5S7Gu3oIQEfyFnTHa23BgeBq39um
	 VIl/Pz1NhYO/A+9eZvzIWNpVvtvYiss7TFitfLwTFMSt5WWEeKHmrxIo0xl0i7dHD6
	 tEF/hMiqJop2znNOMP3ErLpeMLlgITaMXz245ddo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730127AbfBKPCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:02:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:50690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389635AbfBKPC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:02:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 496DB222A7;
        Mon, 11 Feb 2019 15:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897348;
        bh=Jztei4wtUJY23q7+WOE14c2Cnm/qGhQw5d89Fch0mR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2umM1BNfSi7iS31ZnJukbb2PwG9alG97SsUtlTfjydt5JZ5NFTNK0qvZFCrJ/Q/et
         16zf1ptG3eZaqDSIQ9RCyf1ac1vbtcLTgjdpdxc9d9m61PiQnrdBsqyETQ8UyiGWfk
         5ddrYKkjdX1IAO4WykWXzuRFGhwgvIFzPMcvf9Gc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 172/205] net: systemport: Fix WoL with password after deep sleep
Date:   Mon, 11 Feb 2019 15:19:30 +0100
Message-Id: <20190211141839.609290443@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit 8dfb8d2cceb76b74ad5b58cc65c75994329b4d5e ]

Broadcom STB chips support a deep sleep mode where all register
contents are lost. Because we were stashing the MagicPacket password
into some of these registers a suspend into that deep sleep then a
resumption would not lead to being able to wake-up from MagicPacket with
password again.

Fix this by keeping a software copy of the password and program it
during suspend.

Fixes: 83e82f4c706b ("net: systemport: add Wake-on-LAN support")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bcmsysport.c |   25 ++++++++++---------------
 drivers/net/ethernet/broadcom/bcmsysport.h |    2 ++
 2 files changed, 12 insertions(+), 15 deletions(-)

--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -519,7 +519,6 @@ static void bcm_sysport_get_wol(struct n
 				struct ethtool_wolinfo *wol)
 {
 	struct bcm_sysport_priv *priv = netdev_priv(dev);
-	u32 reg;
 
 	wol->supported = WAKE_MAGIC | WAKE_MAGICSECURE;
 	wol->wolopts = priv->wolopts;
@@ -527,11 +526,7 @@ static void bcm_sysport_get_wol(struct n
 	if (!(priv->wolopts & WAKE_MAGICSECURE))
 		return;
 
-	/* Return the programmed SecureOn password */
-	reg = umac_readl(priv, UMAC_PSW_MS);
-	put_unaligned_be16(reg, &wol->sopass[0]);
-	reg = umac_readl(priv, UMAC_PSW_LS);
-	put_unaligned_be32(reg, &wol->sopass[2]);
+	memcpy(wol->sopass, priv->sopass, sizeof(priv->sopass));
 }
 
 static int bcm_sysport_set_wol(struct net_device *dev,
@@ -547,13 +542,8 @@ static int bcm_sysport_set_wol(struct ne
 	if (wol->wolopts & ~supported)
 		return -EINVAL;
 
-	/* Program the SecureOn password */
-	if (wol->wolopts & WAKE_MAGICSECURE) {
-		umac_writel(priv, get_unaligned_be16(&wol->sopass[0]),
-			    UMAC_PSW_MS);
-		umac_writel(priv, get_unaligned_be32(&wol->sopass[2]),
-			    UMAC_PSW_LS);
-	}
+	if (wol->wolopts & WAKE_MAGICSECURE)
+		memcpy(priv->sopass, wol->sopass, sizeof(priv->sopass));
 
 	/* Flag the device and relevant IRQ as wakeup capable */
 	if (wol->wolopts) {
@@ -2221,12 +2211,17 @@ static int bcm_sysport_suspend_to_wol(st
 	unsigned int timeout = 1000;
 	u32 reg;
 
-	/* Password has already been programmed */
 	reg = umac_readl(priv, UMAC_MPD_CTRL);
 	reg |= MPD_EN;
 	reg &= ~PSW_EN;
-	if (priv->wolopts & WAKE_MAGICSECURE)
+	if (priv->wolopts & WAKE_MAGICSECURE) {
+		/* Program the SecureOn password */
+		umac_writel(priv, get_unaligned_be16(&priv->sopass[0]),
+			    UMAC_PSW_MS);
+		umac_writel(priv, get_unaligned_be32(&priv->sopass[2]),
+			    UMAC_PSW_LS);
 		reg |= PSW_EN;
+	}
 	umac_writel(priv, reg, UMAC_MPD_CTRL);
 
 	/* Make sure RBUF entered WoL mode as result */
--- a/drivers/net/ethernet/broadcom/bcmsysport.h
+++ b/drivers/net/ethernet/broadcom/bcmsysport.h
@@ -11,6 +11,7 @@
 #ifndef __BCM_SYSPORT_H
 #define __BCM_SYSPORT_H
 
+#include <linux/ethtool.h>
 #include <linux/if_vlan.h>
 
 /* Receive/transmit descriptor format */
@@ -754,6 +755,7 @@ struct bcm_sysport_priv {
 	unsigned int		crc_fwd:1;
 	u16			rev;
 	u32			wolopts;
+	u8			sopass[SOPASS_MAX];
 	unsigned int		wol_irq_disabled:1;
 
 	/* MIB related fields */


