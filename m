Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751698AbeEKVRp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 17:17:45 -0400
Received: from mail.savoirfairelinux.com ([208.88.110.44]:37214 "EHLO
        mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751228AbeEKVQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 17:16:54 -0400
From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel@savoirfairelinux.com,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        davem@davemloft.net, andrew@lunn.ch, f.fainelli@gmail.com
Subject: [PATCH net-next 2/3] net: dsa: mv88e6xxx: add IEEE and IP mapping ops
Date: Fri, 11 May 2018 17:16:35 -0400
Message-Id: <20180511211636.25995-3-vivien.didelot@savoirfairelinux.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180511211636.25995-1-vivien.didelot@savoirfairelinux.com>
References: <20180511211636.25995-1-vivien.didelot@savoirfairelinux.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All Marvell switch families except 88E6390 have direct registers in
Global 1 for IEEE and IP priorities override mapping. The 88E6390 uses
indirect tables instead.

Add .ieee_pri_map and .ip_pri_map ops to distinct that and call them
from a mv88e6xxx_pri_setup helper. Only non-6390 are concerned ATM.

Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c    | 94 +++++++++++++++++++----------
 drivers/net/dsa/mv88e6xxx/chip.h    |  3 +
 drivers/net/dsa/mv88e6xxx/global1.c | 58 ++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/global1.h |  3 +
 4 files changed, 127 insertions(+), 31 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 1cebde80b101..df92fed44674 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -1104,6 +1104,25 @@ static void mv88e6xxx_port_stp_state_set(struct dsa_switch *ds, int port,
 		dev_err(ds->dev, "p%d: failed to update state\n", port);
 }
 
+static int mv88e6xxx_pri_setup(struct mv88e6xxx_chip *chip)
+{
+	int err;
+
+	if (chip->info->ops->ieee_pri_map) {
+		err = chip->info->ops->ieee_pri_map(chip);
+		if (err)
+			return err;
+	}
+
+	if (chip->info->ops->ip_pri_map) {
+		err = chip->info->ops->ip_pri_map(chip);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static int mv88e6xxx_devmap_setup(struct mv88e6xxx_chip *chip)
 {
 	int target, port;
@@ -2252,37 +2271,6 @@ static int mv88e6xxx_g1_setup(struct mv88e6xxx_chip *chip)
 {
 	int err;
 
-	/* Configure the IP ToS mapping registers. */
-	err = mv88e6xxx_g1_write(chip, MV88E6XXX_G1_IP_PRI_0, 0x0000);
-	if (err)
-		return err;
-	err = mv88e6xxx_g1_write(chip, MV88E6XXX_G1_IP_PRI_1, 0x0000);
-	if (err)
-		return err;
-	err = mv88e6xxx_g1_write(chip, MV88E6XXX_G1_IP_PRI_2, 0x5555);
-	if (err)
-		return err;
-	err = mv88e6xxx_g1_write(chip, MV88E6XXX_G1_IP_PRI_3, 0x5555);
-	if (err)
-		return err;
-	err = mv88e6xxx_g1_write(chip, MV88E6XXX_G1_IP_PRI_4, 0xaaaa);
-	if (err)
-		return err;
-	err = mv88e6xxx_g1_write(chip, MV88E6XXX_G1_IP_PRI_5, 0xaaaa);
-	if (err)
-		return err;
-	err = mv88e6xxx_g1_write(chip, MV88E6XXX_G1_IP_PRI_6, 0xffff);
-	if (err)
-		return err;
-	err = mv88e6xxx_g1_write(chip, MV88E6XXX_G1_IP_PRI_7, 0xffff);
-	if (err)
-		return err;
-
-	/* Configure the IEEE 802.1p priority mapping register. */
-	err = mv88e6xxx_g1_write(chip, MV88E6XXX_G1_IEEE_PRI, 0xfa41);
-	if (err)
-		return err;
-
 	/* Initialize the statistics unit */
 	err = mv88e6xxx_stats_set_histogram(chip);
 	if (err)
@@ -2365,6 +2353,10 @@ static int mv88e6xxx_setup(struct dsa_switch *ds)
 	if (err)
 		goto unlock;
 
+	err = mv88e6xxx_pri_setup(chip);
+	if (err)
+		goto unlock;
+
 	/* Setup PTP Hardware Clock and timestamping */
 	if (chip->info->ptp_support) {
 		err = mv88e6xxx_ptp_setup(chip);
@@ -2592,6 +2584,8 @@ static int mv88e6xxx_set_eeprom(struct dsa_switch *ds,
 
 static const struct mv88e6xxx_ops mv88e6085_ops = {
 	/* MV88E6XXX_FAMILY_6097 */
+	.ieee_pri_map = mv88e6085_g1_ieee_pri_map,
+	.ip_pri_map = mv88e6085_g1_ip_pri_map,
 	.irl_init_all = mv88e6352_g2_irl_init_all,
 	.set_switch_mac = mv88e6xxx_g1_set_switch_mac,
 	.phy_read = mv88e6185_phy_ppu_read,
@@ -2628,6 +2622,8 @@ static const struct mv88e6xxx_ops mv88e6085_ops = {
 
 static const struct mv88e6xxx_ops mv88e6095_ops = {
 	/* MV88E6XXX_FAMILY_6095 */
+	.ieee_pri_map = mv88e6085_g1_ieee_pri_map,
+	.ip_pri_map = mv88e6085_g1_ip_pri_map,
 	.set_switch_mac = mv88e6xxx_g1_set_switch_mac,
 	.phy_read = mv88e6185_phy_ppu_read,
 	.phy_write = mv88e6185_phy_ppu_write,
@@ -2652,6 +2648,8 @@ static const struct mv88e6xxx_ops mv88e6095_ops = {
 
 static const struct mv88e6xxx_ops mv88e6097_ops = {
 	/* MV88E6XXX_FAMILY_6097 */
+	.ieee_pri_map = mv88e6085_g1_ieee_pri_map,
+	.ip_pri_map = mv88e6085_g1_ip_pri_map,
 	.irl_init_all = mv88e6352_g2_irl_init_all,
 	.set_switch_mac = mv88e6xxx_g2_set_switch_mac,
 	.phy_read = mv88e6xxx_g2_smi_phy_read,
@@ -2686,6 +2684,8 @@ static const struct mv88e6xxx_ops mv88e6097_ops = {
 
 static const struct mv88e6xxx_ops mv88e6123_ops = {
 	/* MV88E6XXX_FAMILY_6165 */
+	.ieee_pri_map = mv88e6085_g1_ieee_pri_map,
+	.ip_pri_map = mv88e6085_g1_ip_pri_map,
 	.irl_init_all = mv88e6352_g2_irl_init_all,
 	.set_switch_mac = mv88e6xxx_g2_set_switch_mac,
 	.phy_read = mv88e6xxx_g2_smi_phy_read,
@@ -2714,6 +2714,8 @@ static const struct mv88e6xxx_ops mv88e6123_ops = {
 
 static const struct mv88e6xxx_ops mv88e6131_ops = {
 	/* MV88E6XXX_FAMILY_6185 */
+	.ieee_pri_map = mv88e6085_g1_ieee_pri_map,
+	.ip_pri_map = mv88e6085_g1_ip_pri_map,
 	.set_switch_mac = mv88e6xxx_g1_set_switch_mac,
 	.phy_read = mv88e6185_phy_ppu_read,
 	.phy_write = mv88e6185_phy_ppu_write,
@@ -2747,6 +2749,8 @@ static const struct mv88e6xxx_ops mv88e6131_ops = {
 
 static const struct mv88e6xxx_ops mv88e6141_ops = {
 	/* MV88E6XXX_FAMILY_6341 */
+	.ieee_pri_map = mv88e6085_g1_ieee_pri_map,
+	.ip_pri_map = mv88e6085_g1_ip_pri_map,
 	.irl_init_all = mv88e6352_g2_irl_init_all,
 	.get_eeprom = mv88e6xxx_g2_get_eeprom8,
 	.set_eeprom = mv88e6xxx_g2_set_eeprom8,
@@ -2784,6 +2788,8 @@ static const struct mv88e6xxx_ops mv88e6141_ops = {
 
 static const struct mv88e6xxx_ops mv88e6161_ops = {
 	/* MV88E6XXX_FAMILY_6165 */
+	.ieee_pri_map = mv88e6085_g1_ieee_pri_map,
+	.ip_pri_map = mv88e6085_g1_ip_pri_map,
 	.irl_init_all = mv88e6352_g2_irl_init_all,
 	.set_switch_mac = mv88e6xxx_g2_set_switch_mac,
 	.phy_read = mv88e6xxx_g2_smi_phy_read,
@@ -2817,6 +2823,8 @@ static const struct mv88e6xxx_ops mv88e6161_ops = {
 
 static const struct mv88e6xxx_ops mv88e6165_ops = {
 	/* MV88E6XXX_FAMILY_6165 */
+	.ieee_pri_map = mv88e6085_g1_ieee_pri_map,
+	.ip_pri_map = mv88e6085_g1_ip_pri_map,
 	.irl_init_all = mv88e6352_g2_irl_init_all,
 	.set_switch_mac = mv88e6xxx_g2_set_switch_mac,
 	.phy_read = mv88e6165_phy_read,
@@ -2843,6 +2851,8 @@ static const struct mv88e6xxx_ops mv88e6165_ops = {
 
 static const struct mv88e6xxx_ops mv88e6171_ops = {
 	/* MV88E6XXX_FAMILY_6351 */
+	.ieee_pri_map = mv88e6085_g1_ieee_pri_map,
+	.ip_pri_map = mv88e6085_g1_ip_pri_map,
 	.irl_init_all = mv88e6352_g2_irl_init_all,
 	.set_switch_mac = mv88e6xxx_g2_set_switch_mac,
 	.phy_read = mv88e6xxx_g2_smi_phy_read,
@@ -2877,6 +2887,8 @@ static const struct mv88e6xxx_ops mv88e6171_ops = {
 
 static const struct mv88e6xxx_ops mv88e6172_ops = {
 	/* MV88E6XXX_FAMILY_6352 */
+	.ieee_pri_map = mv88e6085_g1_ieee_pri_map,
+	.ip_pri_map = mv88e6085_g1_ip_pri_map,
 	.irl_init_all = mv88e6352_g2_irl_init_all,
 	.get_eeprom = mv88e6xxx_g2_get_eeprom16,
 	.set_eeprom = mv88e6xxx_g2_set_eeprom16,
@@ -2916,6 +2928,8 @@ static const struct mv88e6xxx_ops mv88e6172_ops = {
 
 static const struct mv88e6xxx_ops mv88e6175_ops = {
 	/* MV88E6XXX_FAMILY_6351 */
+	.ieee_pri_map = mv88e6085_g1_ieee_pri_map,
+	.ip_pri_map = mv88e6085_g1_ip_pri_map,
 	.irl_init_all = mv88e6352_g2_irl_init_all,
 	.set_switch_mac = mv88e6xxx_g2_set_switch_mac,
 	.phy_read = mv88e6xxx_g2_smi_phy_read,
@@ -2951,6 +2965,8 @@ static const struct mv88e6xxx_ops mv88e6175_ops = {
 
 static const struct mv88e6xxx_ops mv88e6176_ops = {
 	/* MV88E6XXX_FAMILY_6352 */
+	.ieee_pri_map = mv88e6085_g1_ieee_pri_map,
+	.ip_pri_map = mv88e6085_g1_ip_pri_map,
 	.irl_init_all = mv88e6352_g2_irl_init_all,
 	.get_eeprom = mv88e6xxx_g2_get_eeprom16,
 	.set_eeprom = mv88e6xxx_g2_set_eeprom16,
@@ -2990,6 +3006,8 @@ static const struct mv88e6xxx_ops mv88e6176_ops = {
 
 static const struct mv88e6xxx_ops mv88e6185_ops = {
 	/* MV88E6XXX_FAMILY_6185 */
+	.ieee_pri_map = mv88e6085_g1_ieee_pri_map,
+	.ip_pri_map = mv88e6085_g1_ip_pri_map,
 	.set_switch_mac = mv88e6xxx_g1_set_switch_mac,
 	.phy_read = mv88e6185_phy_ppu_read,
 	.phy_write = mv88e6185_phy_ppu_write,
@@ -3129,6 +3147,8 @@ static const struct mv88e6xxx_ops mv88e6191_ops = {
 
 static const struct mv88e6xxx_ops mv88e6240_ops = {
 	/* MV88E6XXX_FAMILY_6352 */
+	.ieee_pri_map = mv88e6085_g1_ieee_pri_map,
+	.ip_pri_map = mv88e6085_g1_ip_pri_map,
 	.irl_init_all = mv88e6352_g2_irl_init_all,
 	.get_eeprom = mv88e6xxx_g2_get_eeprom16,
 	.set_eeprom = mv88e6xxx_g2_set_eeprom16,
@@ -3208,6 +3228,8 @@ static const struct mv88e6xxx_ops mv88e6290_ops = {
 
 static const struct mv88e6xxx_ops mv88e6320_ops = {
 	/* MV88E6XXX_FAMILY_6320 */
+	.ieee_pri_map = mv88e6085_g1_ieee_pri_map,
+	.ip_pri_map = mv88e6085_g1_ip_pri_map,
 	.irl_init_all = mv88e6352_g2_irl_init_all,
 	.get_eeprom = mv88e6xxx_g2_get_eeprom16,
 	.set_eeprom = mv88e6xxx_g2_set_eeprom16,
@@ -3244,6 +3266,8 @@ static const struct mv88e6xxx_ops mv88e6320_ops = {
 
 static const struct mv88e6xxx_ops mv88e6321_ops = {
 	/* MV88E6XXX_FAMILY_6320 */
+	.ieee_pri_map = mv88e6085_g1_ieee_pri_map,
+	.ip_pri_map = mv88e6085_g1_ip_pri_map,
 	.irl_init_all = mv88e6352_g2_irl_init_all,
 	.get_eeprom = mv88e6xxx_g2_get_eeprom16,
 	.set_eeprom = mv88e6xxx_g2_set_eeprom16,
@@ -3278,6 +3302,8 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 
 static const struct mv88e6xxx_ops mv88e6341_ops = {
 	/* MV88E6XXX_FAMILY_6341 */
+	.ieee_pri_map = mv88e6085_g1_ieee_pri_map,
+	.ip_pri_map = mv88e6085_g1_ip_pri_map,
 	.irl_init_all = mv88e6352_g2_irl_init_all,
 	.get_eeprom = mv88e6xxx_g2_get_eeprom8,
 	.set_eeprom = mv88e6xxx_g2_set_eeprom8,
@@ -3316,6 +3342,8 @@ static const struct mv88e6xxx_ops mv88e6341_ops = {
 
 static const struct mv88e6xxx_ops mv88e6350_ops = {
 	/* MV88E6XXX_FAMILY_6351 */
+	.ieee_pri_map = mv88e6085_g1_ieee_pri_map,
+	.ip_pri_map = mv88e6085_g1_ip_pri_map,
 	.irl_init_all = mv88e6352_g2_irl_init_all,
 	.set_switch_mac = mv88e6xxx_g2_set_switch_mac,
 	.phy_read = mv88e6xxx_g2_smi_phy_read,
@@ -3350,6 +3378,8 @@ static const struct mv88e6xxx_ops mv88e6350_ops = {
 
 static const struct mv88e6xxx_ops mv88e6351_ops = {
 	/* MV88E6XXX_FAMILY_6351 */
+	.ieee_pri_map = mv88e6085_g1_ieee_pri_map,
+	.ip_pri_map = mv88e6085_g1_ip_pri_map,
 	.irl_init_all = mv88e6352_g2_irl_init_all,
 	.set_switch_mac = mv88e6xxx_g2_set_switch_mac,
 	.phy_read = mv88e6xxx_g2_smi_phy_read,
@@ -3385,6 +3415,8 @@ static const struct mv88e6xxx_ops mv88e6351_ops = {
 
 static const struct mv88e6xxx_ops mv88e6352_ops = {
 	/* MV88E6XXX_FAMILY_6352 */
+	.ieee_pri_map = mv88e6085_g1_ieee_pri_map,
+	.ip_pri_map = mv88e6085_g1_ip_pri_map,
 	.irl_init_all = mv88e6352_g2_irl_init_all,
 	.get_eeprom = mv88e6xxx_g2_get_eeprom16,
 	.set_eeprom = mv88e6xxx_g2_set_eeprom16,
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index a1bedb0a888b..83d6a8531eaa 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -293,6 +293,9 @@ struct mv88e6xxx_mdio_bus {
 };
 
 struct mv88e6xxx_ops {
+	int (*ieee_pri_map)(struct mv88e6xxx_chip *chip);
+	int (*ip_pri_map)(struct mv88e6xxx_chip *chip);
+
 	/* Ingress Rate Limit unit (IRL) operations */
 	int (*irl_init_all)(struct mv88e6xxx_chip *chip, int port);
 
diff --git a/drivers/net/dsa/mv88e6xxx/global1.c b/drivers/net/dsa/mv88e6xxx/global1.c
index 0f2b05342c18..d721ccf7d8be 100644
--- a/drivers/net/dsa/mv88e6xxx/global1.c
+++ b/drivers/net/dsa/mv88e6xxx/global1.c
@@ -241,6 +241,64 @@ int mv88e6185_g1_ppu_disable(struct mv88e6xxx_chip *chip)
 	return mv88e6185_g1_wait_ppu_disabled(chip);
 }
 
+/* Offset 0x10: IP-PRI Mapping Register 0
+ * Offset 0x11: IP-PRI Mapping Register 1
+ * Offset 0x12: IP-PRI Mapping Register 2
+ * Offset 0x13: IP-PRI Mapping Register 3
+ * Offset 0x14: IP-PRI Mapping Register 4
+ * Offset 0x15: IP-PRI Mapping Register 5
+ * Offset 0x16: IP-PRI Mapping Register 6
+ * Offset 0x17: IP-PRI Mapping Register 7
+ */
+
+int mv88e6085_g1_ip_pri_map(struct mv88e6xxx_chip *chip)
+{
+	int err;
+
+	/* Reset the IP TOS/DiffServ/Traffic priorities to defaults */
+	err = mv88e6xxx_g1_write(chip, MV88E6XXX_G1_IP_PRI_0, 0x0000);
+	if (err)
+		return err;
+
+	err = mv88e6xxx_g1_write(chip, MV88E6XXX_G1_IP_PRI_1, 0x0000);
+	if (err)
+		return err;
+
+	err = mv88e6xxx_g1_write(chip, MV88E6XXX_G1_IP_PRI_2, 0x5555);
+	if (err)
+		return err;
+
+	err = mv88e6xxx_g1_write(chip, MV88E6XXX_G1_IP_PRI_3, 0x5555);
+	if (err)
+		return err;
+
+	err = mv88e6xxx_g1_write(chip, MV88E6XXX_G1_IP_PRI_4, 0xaaaa);
+	if (err)
+		return err;
+
+	err = mv88e6xxx_g1_write(chip, MV88E6XXX_G1_IP_PRI_5, 0xaaaa);
+	if (err)
+		return err;
+
+	err = mv88e6xxx_g1_write(chip, MV88E6XXX_G1_IP_PRI_6, 0xffff);
+	if (err)
+		return err;
+
+	err = mv88e6xxx_g1_write(chip, MV88E6XXX_G1_IP_PRI_7, 0xffff);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+/* Offset 0x18: IEEE-PRI Register */
+
+int mv88e6085_g1_ieee_pri_map(struct mv88e6xxx_chip *chip)
+{
+	/* Reset the IEEE Tag priorities to defaults */
+	return mv88e6xxx_g1_write(chip, MV88E6XXX_G1_IEEE_PRI, 0xfa41);
+}
+
 /* Offset 0x1a: Monitor Control */
 /* Offset 0x1a: Monitor & MGMT Control on some devices */
 
diff --git a/drivers/net/dsa/mv88e6xxx/global1.h b/drivers/net/dsa/mv88e6xxx/global1.h
index c357b3ca9a09..7c791c1da4b9 100644
--- a/drivers/net/dsa/mv88e6xxx/global1.h
+++ b/drivers/net/dsa/mv88e6xxx/global1.h
@@ -277,6 +277,9 @@ int mv88e6095_g1_set_cpu_port(struct mv88e6xxx_chip *chip, int port);
 int mv88e6390_g1_set_cpu_port(struct mv88e6xxx_chip *chip, int port);
 int mv88e6390_g1_mgmt_rsvd2cpu(struct mv88e6xxx_chip *chip);
 
+int mv88e6085_g1_ip_pri_map(struct mv88e6xxx_chip *chip);
+int mv88e6085_g1_ieee_pri_map(struct mv88e6xxx_chip *chip);
+
 int mv88e6185_g1_set_cascade_port(struct mv88e6xxx_chip *chip, int port);
 
 int mv88e6085_g1_rmu_disable(struct mv88e6xxx_chip *chip);
-- 
2.17.0
