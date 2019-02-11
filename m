Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C0CC282D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A102081B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896691;
	bh=6pwNE8ZWhaiphcsNQOeWXogf7gD1ugiKYe77L/FATb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l4tkWQrsuYRuDGjjnaL+N8CxB4Gy32Q7RrYSoeDuLVCHuqY4VARaq7ygWsFZkL4/J
	 pqGiDg49GGlqa/dTtejluPJb7Wq2t72VGPMuy7z36EcYHw1Et2y1Fm3QXgt3MZUtxb
	 RjKBGFaMLD6s3WE51IUa33przkBPKwBg5bXRG0zY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388271AbfBKOva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:51:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:37472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732860AbfBKOv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:51:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93F472081B;
        Mon, 11 Feb 2019 14:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896686;
        bh=6pwNE8ZWhaiphcsNQOeWXogf7gD1ugiKYe77L/FATb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dxjckAj3O7cI7aNro9MU+vNCS4Ad+hr9y/B4s9AmoA3W4xwZYzl4B4KoNlD0Wg+Sv
         EOtw7o4FUBiYxsja8//VkRfpNZA9hgj5K0RFJn7siuCeYY65av6AbEAP8YuPU/qYi+
         uV+0bAJ1hl8y1oBZ/Cp9n3+cnFrT/Oqj243jskxI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 268/313] net: systemport: Fix WoL with password after deep sleep
Date:   Mon, 11 Feb 2019 15:19:08 +0100
Message-Id: <20190211141911.215399374@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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
 
 	wol->supported = WAKE_MAGIC | WAKE_MAGICSECURE | WAKE_FILTER;
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
@@ -2588,13 +2578,18 @@ static int bcm_sysport_suspend_to_wol(st
 	unsigned int index, i = 0;
 	u32 reg;
 
-	/* Password has already been programmed */
 	reg = umac_readl(priv, UMAC_MPD_CTRL);
 	if (priv->wolopts & (WAKE_MAGIC | WAKE_MAGICSECURE))
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
 
 	if (priv->wolopts & WAKE_FILTER) {
--- a/drivers/net/ethernet/broadcom/bcmsysport.h
+++ b/drivers/net/ethernet/broadcom/bcmsysport.h
@@ -12,6 +12,7 @@
 #define __BCM_SYSPORT_H
 
 #include <linux/bitmap.h>
+#include <linux/ethtool.h>
 #include <linux/if_vlan.h>
 #include <linux/net_dim.h>
 
@@ -776,6 +777,7 @@ struct bcm_sysport_priv {
 	unsigned int		crc_fwd:1;
 	u16			rev;
 	u32			wolopts;
+	u8			sopass[SOPASS_MAX];
 	unsigned int		wol_irq_disabled:1;
 
 	/* MIB related fields */


