Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 9IiAEDT1G1t2GwAAmS7hNA
	; Sat, 09 Jun 2018 15:41:40 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2B092608C1; Sat,  9 Jun 2018 15:41:40 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kl3bFnnL"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 890F9606FA;
	Sat,  9 Jun 2018 15:41:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 890F9606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932982AbeFIPfI (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 11:35:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:37328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932969AbeFIPfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 11:35:01 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 752F82087B;
        Sat,  9 Jun 2018 15:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528558501;
        bh=27Tj35fNe/BUTthlahUEZZKU3ChcbZ06gJWTW7v5b2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kl3bFnnLz+WkKks0ouaMz7qdFsh+pZafNtVhflwrZzfy+uymbDuQB42twVmp18zQx
         cc6rbWMFeQxxW6Dh9SGWUu9s+zbu1U3hihcg5UWmLV6QeyHZtsLr5emWVNj4r4YFm6
         RFwmNKMUZctSeTzi9dUVX0m1AcOdYRsgTxac8+iQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 22/41] net: phy: broadcom: Fix bcm_write_exp()
Date: Sat,  9 Jun 2018 17:29:54 +0200
Message-Id: <20180609152927.626540279@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180609152926.389750182@linuxfoundation.org>
References: <20180609152926.389750182@linuxfoundation.org>
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
 int bcm54xx_auxctl_write(struct phy_device *phydev, u16 regnum, u16 val);
 int bcm54xx_auxctl_read(struct phy_device *phydev, u16 regnum);
 
--- a/drivers/net/phy/bcm7xxx.c
+++ b/drivers/net/phy/bcm7xxx.c
@@ -65,10 +65,10 @@ struct bcm7xxx_phy_priv {
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
