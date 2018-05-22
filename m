Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753335AbeEVXWd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 19:22:33 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:47093 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753008AbeEVXWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 19:22:31 -0400
X-Google-Smtp-Source: AB8JxZpJhqbaPQEeUrNUtcNNctETibNUCJ+yZBf7BA+OA07bgFIUA558BT03neft7iocktgiK+JCWQ==
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: jon.mason@broadcom.com, Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: phy: broadcom: Fix auxiliary control register reads
Date: Tue, 22 May 2018 16:22:26 -0700
Message-Id: <20180522232227.6355-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are currently doing auxiliary control register reads with the shadow
register value 0b111 (0x7) which incidentally is also the selector value
that should be present in bits [2:0]. Fix this by using the appropriate
selector mask which is defined (MII_BCM54XX_AUXCTL_SHDWSEL_MASK).

This does not have a functional impact yet because we always access the
MII_BCM54XX_AUXCTL_SHDWSEL_MISC (0x7) register in the current code.
This might change at some point though.

Fixes: 5b4e29005123 ("net: phy: broadcom: add bcm54xx_auxctl_read")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
David, please queue this for -stable as well, thank you!

 drivers/net/phy/bcm-phy-lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/bcm-phy-lib.c b/drivers/net/phy/bcm-phy-lib.c
index 5ad130c3da43..d5e0833d69b9 100644
--- a/drivers/net/phy/bcm-phy-lib.c
+++ b/drivers/net/phy/bcm-phy-lib.c
@@ -56,7 +56,7 @@ int bcm54xx_auxctl_read(struct phy_device *phydev, u16 regnum)
 	/* The register must be written to both the Shadow Register Select and
 	 * the Shadow Read Register Selector
 	 */
-	phy_write(phydev, MII_BCM54XX_AUX_CTL, regnum |
+	phy_write(phydev, MII_BCM54XX_AUX_CTL, MII_BCM54XX_AUXCTL_SHDWSEL_MASK |
 		  regnum << MII_BCM54XX_AUXCTL_SHDWSEL_READ_SHIFT);
 	return phy_read(phydev, MII_BCM54XX_AUX_CTL);
 }
-- 
2.14.1
