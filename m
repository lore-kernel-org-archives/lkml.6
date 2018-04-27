Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932351AbeD0B5t (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 21:57:49 -0400
Received: from mail.savoirfairelinux.com ([208.88.110.44]:43994 "EHLO
        mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757128AbeD0B5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 21:57:45 -0400
From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
        kernel@savoirfairelinux.com
Subject: [PATCH net-next 3/3] net: dsa: mv88e6xxx: remove Global 2 setup
Date: Thu, 26 Apr 2018 21:56:46 -0400
Message-Id: <20180427015646.24946-4-vivien.didelot@savoirfairelinux.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427015646.24946-1-vivien.didelot@savoirfairelinux.com>
References: <20180427015646.24946-1-vivien.didelot@savoirfairelinux.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The remaining values written to the Switch Management Register in the
mv88e6xxx_g2_setup function are specific to 88E6352 and older, and are
the default values anyway.

Thus remove completely this function. The mv88e6xxx driver no more
contains setup code to access arbitrary Global 2 registers.

Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c    |  7 -------
 drivers/net/dsa/mv88e6xxx/global2.c | 18 ------------------
 drivers/net/dsa/mv88e6xxx/global2.h |  6 ------
 3 files changed, 31 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 0b7530452643..5671fb78c252 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -2222,13 +2222,6 @@ static int mv88e6xxx_setup(struct dsa_switch *ds)
 	if (err)
 		goto unlock;
 
-	/* Setup Switch Global 2 Registers */
-	if (chip->info->global2_addr) {
-		err = mv88e6xxx_g2_setup(chip);
-		if (err)
-			goto unlock;
-	}
-
 	err = mv88e6xxx_irl_setup(chip);
 	if (err)
 		goto unlock;
diff --git a/drivers/net/dsa/mv88e6xxx/global2.c b/drivers/net/dsa/mv88e6xxx/global2.c
index 96e74d8d500d..e6d658181b27 100644
--- a/drivers/net/dsa/mv88e6xxx/global2.c
+++ b/drivers/net/dsa/mv88e6xxx/global2.c
@@ -1118,21 +1118,3 @@ void mv88e6xxx_g2_irq_mdio_free(struct mv88e6xxx_chip *chip,
 	for (phy = 0; phy < chip->info->num_internal_phys; phy++)
 		irq_dispose_mapping(bus->irq[phy]);
 }
-
-int mv88e6xxx_g2_setup(struct mv88e6xxx_chip *chip)
-{
-	u16 reg;
-	int err;
-
-	/* Ignore removed tag data on doubly tagged packets, disable
-	 * flow control messages, force flow control priority to the
-	 * highest, and send all special multicast frames to the CPU
-	 * port at the highest priority.
-	 */
-	reg = MV88E6XXX_G2_SWITCH_MGMT_FORCE_FLOW_CTL_PRI | (0x7 << 4);
-	err = mv88e6xxx_g2_write(chip, MV88E6XXX_G2_SWITCH_MGMT, reg);
-	if (err)
-		return err;
-
-	return 0;
-}
diff --git a/drivers/net/dsa/mv88e6xxx/global2.h b/drivers/net/dsa/mv88e6xxx/global2.h
index 46913a289255..37e8ce2c72a0 100644
--- a/drivers/net/dsa/mv88e6xxx/global2.h
+++ b/drivers/net/dsa/mv88e6xxx/global2.h
@@ -314,7 +314,6 @@ int mv88e6xxx_g2_pvt_write(struct mv88e6xxx_chip *chip, int src_dev,
 			   int src_port, u16 data);
 int mv88e6xxx_g2_misc_4_bit_port(struct mv88e6xxx_chip *chip);
 
-int mv88e6xxx_g2_setup(struct mv88e6xxx_chip *chip);
 int mv88e6xxx_g2_irq_setup(struct mv88e6xxx_chip *chip);
 void mv88e6xxx_g2_irq_free(struct mv88e6xxx_chip *chip);
 
@@ -447,11 +446,6 @@ static inline int mv88e6xxx_g2_misc_4_bit_port(struct mv88e6xxx_chip *chip)
 	return -EOPNOTSUPP;
 }
 
-static inline int mv88e6xxx_g2_setup(struct mv88e6xxx_chip *chip)
-{
-	return -EOPNOTSUPP;
-}
-
 static inline int mv88e6xxx_g2_irq_setup(struct mv88e6xxx_chip *chip)
 {
 	return -EOPNOTSUPP;
-- 
2.17.0
