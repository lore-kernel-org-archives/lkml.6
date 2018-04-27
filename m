Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932372AbeD0B6Y (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 21:58:24 -0400
Received: from mail.savoirfairelinux.com ([208.88.110.44]:44006 "EHLO
        mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932218AbeD0B5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 21:57:46 -0400
From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
        kernel@savoirfairelinux.com
Subject: [PATCH net-next 2/3] net: dsa: mv88e6xxx: move device mapping setup
Date: Thu, 26 Apr 2018 21:56:45 -0400
Message-Id: <20180427015646.24946-3-vivien.didelot@savoirfairelinux.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427015646.24946-1-vivien.didelot@savoirfairelinux.com>
References: <20180427015646.24946-1-vivien.didelot@savoirfairelinux.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the Device Mapping setup out of the specific Global 2 code,
into the top level device setup function.

Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c    | 27 +++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/global2.c | 37 +++++------------------------
 drivers/net/dsa/mv88e6xxx/global2.h | 12 +++++++++-
 3 files changed, 44 insertions(+), 32 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 379edaf79aca..0b7530452643 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -1020,6 +1020,29 @@ static void mv88e6xxx_port_stp_state_set(struct dsa_switch *ds, int port,
 		dev_err(ds->dev, "p%d: failed to update state\n", port);
 }
 
+static int mv88e6xxx_devmap_setup(struct mv88e6xxx_chip *chip)
+{
+	int target, port;
+	int err;
+
+	if (!chip->info->global2_addr)
+		return 0;
+
+	/* Initialize the routing port to the 32 possible target devices */
+	for (target = 0; target < 32; target++) {
+		port = 0x1f;
+		if (target < DSA_MAX_SWITCHES)
+			if (chip->ds->rtable[target] != DSA_RTABLE_NONE)
+				port = chip->ds->rtable[target];
+
+		err = mv88e6xxx_g2_device_mapping_write(chip, target, port);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static int mv88e6xxx_trunk_setup(struct mv88e6xxx_chip *chip)
 {
 	/* Clear all trunk masks and mapping */
@@ -2246,6 +2269,10 @@ static int mv88e6xxx_setup(struct dsa_switch *ds)
 	if (err)
 		goto unlock;
 
+	err = mv88e6xxx_devmap_setup(chip);
+	if (err)
+		goto unlock;
+
 	/* Setup PTP Hardware Clock and timestamping */
 	if (chip->info->ptp_support) {
 		err = mv88e6xxx_ptp_setup(chip);
diff --git a/drivers/net/dsa/mv88e6xxx/global2.c b/drivers/net/dsa/mv88e6xxx/global2.c
index 3f24763aedc5..96e74d8d500d 100644
--- a/drivers/net/dsa/mv88e6xxx/global2.c
+++ b/drivers/net/dsa/mv88e6xxx/global2.c
@@ -119,37 +119,17 @@ int mv88e6352_g2_mgmt_rsvd2cpu(struct mv88e6xxx_chip *chip)
 
 /* Offset 0x06: Device Mapping Table register */
 
-static int mv88e6xxx_g2_device_mapping_write(struct mv88e6xxx_chip *chip,
-					     int target, int port)
+int mv88e6xxx_g2_device_mapping_write(struct mv88e6xxx_chip *chip, int target,
+				      int port)
 {
-	u16 val = (target << 8) | (port & 0xf);
+	u16 val = (target << 8) | (port & 0x1f);
+	/* Modern chips use 5 bits to define a device mapping port,
+	 * but bit 4 is reserved on older chips, so it is safe to use.
+	 */
 
 	return mv88e6xxx_g2_update(chip, MV88E6XXX_G2_DEVICE_MAPPING, val);
 }
 
-static int mv88e6xxx_g2_set_device_mapping(struct mv88e6xxx_chip *chip)
-{
-	int target, port;
-	int err;
-
-	/* Initialize the routing port to the 32 possible target devices */
-	for (target = 0; target < 32; ++target) {
-		port = 0xf;
-
-		if (target < DSA_MAX_SWITCHES) {
-			port = chip->ds->rtable[target];
-			if (port == DSA_RTABLE_NONE)
-				port = 0xf;
-		}
-
-		err = mv88e6xxx_g2_device_mapping_write(chip, target, port);
-		if (err)
-			break;
-	}
-
-	return err;
-}
-
 /* Offset 0x07: Trunk Mask Table register */
 
 static int mv88e6xxx_g2_trunk_mask_write(struct mv88e6xxx_chip *chip, int num,
@@ -1154,10 +1134,5 @@ int mv88e6xxx_g2_setup(struct mv88e6xxx_chip *chip)
 	if (err)
 		return err;
 
-	/* Program the DSA routing table. */
-	err = mv88e6xxx_g2_set_device_mapping(chip);
-	if (err)
-		return err;
-
 	return 0;
 }
diff --git a/drivers/net/dsa/mv88e6xxx/global2.h b/drivers/net/dsa/mv88e6xxx/global2.h
index 7bd4ab31a93e..46913a289255 100644
--- a/drivers/net/dsa/mv88e6xxx/global2.h
+++ b/drivers/net/dsa/mv88e6xxx/global2.h
@@ -60,7 +60,8 @@
 #define MV88E6XXX_G2_DEVICE_MAPPING		0x06
 #define MV88E6XXX_G2_DEVICE_MAPPING_UPDATE	0x8000
 #define MV88E6XXX_G2_DEVICE_MAPPING_DEV_MASK	0x1f00
-#define MV88E6XXX_G2_DEVICE_MAPPING_PORT_MASK	0x000f
+#define MV88E6352_G2_DEVICE_MAPPING_PORT_MASK	0x000f
+#define MV88E6390_G2_DEVICE_MAPPING_PORT_MASK	0x001f
 
 /* Offset 0x07: Trunk Mask Table Register */
 #define MV88E6XXX_G2_TRUNK_MASK			0x07
@@ -329,6 +330,9 @@ int mv88e6xxx_g2_pot_clear(struct mv88e6xxx_chip *chip);
 
 int mv88e6xxx_g2_trunk_clear(struct mv88e6xxx_chip *chip);
 
+int mv88e6xxx_g2_device_mapping_write(struct mv88e6xxx_chip *chip, int target,
+				      int port);
+
 extern const struct mv88e6xxx_irq_ops mv88e6097_watchdog_ops;
 extern const struct mv88e6xxx_irq_ops mv88e6390_watchdog_ops;
 
@@ -502,6 +506,12 @@ static inline int mv88e6xxx_g2_trunk_clear(struct mv88e6xxx_chip *chip)
 	return -EOPNOTSUPP;
 }
 
+static inline int mv88e6xxx_g2_device_mapping_write(struct mv88e6xxx_chip *chip,
+						    int target, int port)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif /* CONFIG_NET_DSA_MV88E6XXX_GLOBAL2 */
 
 #endif /* _MV88E6XXX_GLOBAL2_H */
-- 
2.17.0
