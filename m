Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id CE235C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84C1F208B7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9EUkBTG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84C1F208B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934935AbeFLQsA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:48:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:33350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934882AbeFLQr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:47:57 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F366D208B7;
        Tue, 12 Jun 2018 16:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528822076;
        bh=YOjI1NCl+iwQOvz+/VprM9EFlLuCUCGZTA56NjSbICE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l9EUkBTGbAYA7Jux3WWDghIrNpWPY6Sp3j1K1wWFDxXERtyrWklJFHFoLYYdjhdZQ
         LWLqIBAu95Yl3JPA1OuM4x8tYStSZYRqoC5dA4DAf/4LXubcP2dJ3+X43NgLMcWVn9
         wvTzXvqlcOwMRQ/GqcVYR8f7TcZTpwGMtXOi8OUw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 26/31] net: phy: broadcom: Fix bcm_write_exp()
Date:   Tue, 12 Jun 2018 18:46:29 +0200
Message-Id: <20180612164621.823639935@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612164620.797338191@linuxfoundation.org>
References: <20180612164620.797338191@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit 79fb218d97980d4fee9a64f4c8ff05289364ba25 ]

On newer PHYs, we need to select the expansion register to write with
setting bits [11:8] to 0xf. This was done correctly by bcm7xxx.c prior
to being migrated to generic code under bcm-phy-lib.c which
unfortunately used the older implementation from the BCM54xx days.

Fix this by creating an inline stub: bcm_write_exp_sel() which adds the
correct value (MII_BCM54XX_EXP_SEL_ER) and update both the Cygnus PHY
and BCM7xxx PHY drivers which require setting these bits.

broadcom.c is unchanged because some PHYs even use a different selector
method, so let them specify it directly (e.g: SerDes secondary selector).

Fixes: a1cba5613edf ("net: phy: Add Broadcom phy library for common interfaces")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/bcm-cygnus.c  |    6 +++---
 drivers/net/phy/bcm-phy-lib.h |    7 +++++++
 drivers/net/phy/bcm7xxx.c     |    4 ++--
 3 files changed, 12 insertions(+), 5 deletions(-)

--- a/drivers/net/phy/bcm-cygnus.c
+++ b/drivers/net/phy/bcm-cygnus.c
@@ -61,17 +61,17 @@ static int bcm_cygnus_afe_config(struct
 		return rc;
 
 	/* make rcal=100, since rdb default is 000 */
-	rc = bcm_phy_write_exp(phydev, MII_BRCM_CORE_EXPB1, 0x10);
+	rc = bcm_phy_write_exp_sel(phydev, MII_BRCM_CORE_EXPB1, 0x10);
 	if (rc < 0)
 		return rc;
 
 	/* CORE_EXPB0, Reset R_CAL/RC_CAL Engine */
-	rc = bcm_phy_write_exp(phydev, MII_BRCM_CORE_EXPB0, 0x10);
+	rc = bcm_phy_write_exp_sel(phydev, MII_BRCM_CORE_EXPB0, 0x10);
 	if (rc < 0)
 		return rc;
 
 	/* CORE_EXPB0, Disable Reset R_CAL/RC_CAL Engine */
-	rc = bcm_phy_write_exp(phydev, MII_BRCM_CORE_EXPB0, 0x00);
+	rc = bcm_phy_write_exp_sel(phydev, MII_BRCM_CORE_EXPB0, 0x00);
 
 	return 0;
 }
--- a/drivers/net/phy/bcm-phy-lib.h
+++ b/drivers/net/phy/bcm-phy-lib.h
@@ -14,11 +14,18 @@
 #ifndef _LINUX_BCM_PHY_LIB_H
 #define _LINUX_BCM_PHY_LIB_H
 
+#include <linux/brcmphy.h>
 #include <linux/phy.h>
 
 int bcm_phy_write_exp(struct phy_device *phydev, u16 reg, u16 val);
 int bcm_phy_read_exp(struct phy_device *phydev, u16 reg);
 
+static inline int bcm_phy_write_exp_sel(struct phy_device *phydev,
+					u16 reg, u16 val)
+{
+	return bcm_phy_write_exp(phydev, reg | MII_BCM54XX_EXP_SEL_ER, val);
+}
+
 int bcm_phy_write_misc(struct phy_device *phydev,
 		       u16 reg, u16 chl, u16 value);
 int bcm_phy_read_misc(struct phy_device *phydev,
--- a/drivers/net/phy/bcm7xxx.c
+++ b/drivers/net/phy/bcm7xxx.c
@@ -48,10 +48,10 @@
 static void r_rc_cal_reset(struct phy_device *phydev)
 {
 	/* Reset R_CAL/RC_CAL Engine */
-	bcm_phy_write_exp(phydev, 0x00b0, 0x0010);
+	bcm_phy_write_exp_sel(phydev, 0x00b0, 0x0010);
 
 	/* Disable Reset R_AL/RC_CAL Engine */
-	bcm_phy_write_exp(phydev, 0x00b0, 0x0000);
+	bcm_phy_write_exp_sel(phydev, 0x00b0, 0x0000);
 }
 
 static int bcm7xxx_28nm_b0_afe_config_init(struct phy_device *phydev)


