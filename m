Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932278AbeD0B5s (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 21:57:48 -0400
Received: from mail.savoirfairelinux.com ([208.88.110.44]:43980 "EHLO
        mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757046AbeD0B5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 21:57:44 -0400
From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
        kernel@savoirfairelinux.com
Subject: [PATCH net-next 1/3] net: dsa: mv88e6xxx: move trunk setup
Date: Thu, 26 Apr 2018 21:56:44 -0400
Message-Id: <20180427015646.24946-2-vivien.didelot@savoirfairelinux.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427015646.24946-1-vivien.didelot@savoirfairelinux.com>
References: <20180427015646.24946-1-vivien.didelot@savoirfairelinux.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the trunking setup out of Global 2 specific setup into the top
level mv88e6xxx_setup function.

Note that the 88E6390 family calls this LAG instead of Trunk and
supports 32 possible ID routing vectors, with LAG ID bit 4 being placed
in Global 2 register 0x1D...

We don't need Trunk (or LAG) IDs for the moment, thus keep it simple.

Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c    | 13 +++++++++++++
 drivers/net/dsa/mv88e6xxx/global2.c |  7 +------
 drivers/net/dsa/mv88e6xxx/global2.h |  7 +++++++
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 3d2091099f7f..379edaf79aca 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -1020,6 +1020,15 @@ static void mv88e6xxx_port_stp_state_set(struct dsa_switch *ds, int port,
 		dev_err(ds->dev, "p%d: failed to update state\n", port);
 }
 
+static int mv88e6xxx_trunk_setup(struct mv88e6xxx_chip *chip)
+{
+	/* Clear all trunk masks and mapping */
+	if (chip->info->global2_addr)
+		return mv88e6xxx_g2_trunk_clear(chip);
+
+	return 0;
+}
+
 static int mv88e6xxx_pot_setup(struct mv88e6xxx_chip *chip)
 {
 	if (chip->info->ops->pot_clear)
@@ -2233,6 +2242,10 @@ static int mv88e6xxx_setup(struct dsa_switch *ds)
 	if (err)
 		goto unlock;
 
+	err = mv88e6xxx_trunk_setup(chip);
+	if (err)
+		goto unlock;
+
 	/* Setup PTP Hardware Clock and timestamping */
 	if (chip->info->ptp_support) {
 		err = mv88e6xxx_ptp_setup(chip);
diff --git a/drivers/net/dsa/mv88e6xxx/global2.c b/drivers/net/dsa/mv88e6xxx/global2.c
index 0ce627fded48..3f24763aedc5 100644
--- a/drivers/net/dsa/mv88e6xxx/global2.c
+++ b/drivers/net/dsa/mv88e6xxx/global2.c
@@ -174,7 +174,7 @@ static int mv88e6xxx_g2_trunk_mapping_write(struct mv88e6xxx_chip *chip, int id,
 	return mv88e6xxx_g2_update(chip, MV88E6XXX_G2_TRUNK_MAPPING, val);
 }
 
-static int mv88e6xxx_g2_clear_trunk(struct mv88e6xxx_chip *chip)
+int mv88e6xxx_g2_trunk_clear(struct mv88e6xxx_chip *chip)
 {
 	const u16 port_mask = BIT(mv88e6xxx_num_ports(chip)) - 1;
 	int i, err;
@@ -1159,10 +1159,5 @@ int mv88e6xxx_g2_setup(struct mv88e6xxx_chip *chip)
 	if (err)
 		return err;
 
-	/* Clear all trunk masks and mapping. */
-	err = mv88e6xxx_g2_clear_trunk(chip);
-	if (err)
-		return err;
-
 	return 0;
 }
diff --git a/drivers/net/dsa/mv88e6xxx/global2.h b/drivers/net/dsa/mv88e6xxx/global2.h
index 520ec70d32e8..7bd4ab31a93e 100644
--- a/drivers/net/dsa/mv88e6xxx/global2.h
+++ b/drivers/net/dsa/mv88e6xxx/global2.h
@@ -327,6 +327,8 @@ int mv88e6352_g2_mgmt_rsvd2cpu(struct mv88e6xxx_chip *chip);
 
 int mv88e6xxx_g2_pot_clear(struct mv88e6xxx_chip *chip);
 
+int mv88e6xxx_g2_trunk_clear(struct mv88e6xxx_chip *chip);
+
 extern const struct mv88e6xxx_irq_ops mv88e6097_watchdog_ops;
 extern const struct mv88e6xxx_irq_ops mv88e6390_watchdog_ops;
 
@@ -495,6 +497,11 @@ static inline int mv88e6xxx_g2_scratch_gpio_set_smi(struct mv88e6xxx_chip *chip,
 	return -EOPNOTSUPP;
 }
 
+static inline int mv88e6xxx_g2_trunk_clear(struct mv88e6xxx_chip *chip)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif /* CONFIG_NET_DSA_MV88E6XXX_GLOBAL2 */
 
 #endif /* _MV88E6XXX_GLOBAL2_H */
-- 
2.17.0
