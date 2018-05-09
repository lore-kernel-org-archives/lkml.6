Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935436AbeEIPk6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 11:40:58 -0400
Received: from mail.savoirfairelinux.com ([208.88.110.44]:36154 "EHLO
        mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935397AbeEIPjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 11:39:48 -0400
From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel@savoirfairelinux.com,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        davem@davemloft.net, andrew@lunn.ch, f.fainelli@gmail.com
Subject: [PATCH net-next 3/3] net: dsa: mv88e6xxx: add RMU disable op
Date: Wed,  9 May 2018 11:38:51 -0400
Message-Id: <20180509153851.10207-4-vivien.didelot@savoirfairelinux.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180509153851.10207-1-vivien.didelot@savoirfairelinux.com>
References: <20180509153851.10207-1-vivien.didelot@savoirfairelinux.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RMU mode bits moved a lot within the Global Control 2 register of
the Marvell switch families. Add an .rmu_disable op to support at least
3 known alternatives.

Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c    | 24 ++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/chip.h    |  3 +++
 drivers/net/dsa/mv88e6xxx/global1.c | 18 ++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/global1.h | 20 ++++++++++++++++++++
 4 files changed, 65 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index b4e27f9fd3af..9c3cb6079b40 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -1069,6 +1069,14 @@ static int mv88e6xxx_trunk_setup(struct mv88e6xxx_chip *chip)
 	return 0;
 }
 
+static int mv88e6xxx_rmu_setup(struct mv88e6xxx_chip *chip)
+{
+	if (chip->info->ops->rmu_disable)
+		return chip->info->ops->rmu_disable(chip);
+
+	return 0;
+}
+
 static int mv88e6xxx_pot_setup(struct mv88e6xxx_chip *chip)
 {
 	if (chip->info->ops->pot_clear)
@@ -2263,6 +2271,10 @@ static int mv88e6xxx_setup(struct dsa_switch *ds)
 	if (err)
 		goto unlock;
 
+	err = mv88e6xxx_rmu_setup(chip);
+	if (err)
+		goto unlock;
+
 	err = mv88e6xxx_rsvd2cpu_setup(chip);
 	if (err)
 		goto unlock;
@@ -2530,6 +2542,7 @@ static const struct mv88e6xxx_ops mv88e6085_ops = {
 	.ppu_enable = mv88e6185_g1_ppu_enable,
 	.ppu_disable = mv88e6185_g1_ppu_disable,
 	.reset = mv88e6185_g1_reset,
+	.rmu_disable = mv88e6085_g1_rmu_disable,
 	.vtu_getnext = mv88e6352_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
 };
@@ -2587,6 +2600,7 @@ static const struct mv88e6xxx_ops mv88e6097_ops = {
 	.mgmt_rsvd2cpu = mv88e6352_g2_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
 	.reset = mv88e6352_g1_reset,
+	.rmu_disable = mv88e6085_g1_rmu_disable,
 	.vtu_getnext = mv88e6352_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
 };
@@ -2814,6 +2828,7 @@ static const struct mv88e6xxx_ops mv88e6172_ops = {
 	.mgmt_rsvd2cpu = mv88e6352_g2_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
 	.reset = mv88e6352_g1_reset,
+	.rmu_disable = mv88e6352_g1_rmu_disable,
 	.vtu_getnext = mv88e6352_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
 	.serdes_power = mv88e6352_serdes_power,
@@ -2886,6 +2901,7 @@ static const struct mv88e6xxx_ops mv88e6176_ops = {
 	.mgmt_rsvd2cpu = mv88e6352_g2_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
 	.reset = mv88e6352_g1_reset,
+	.rmu_disable = mv88e6352_g1_rmu_disable,
 	.vtu_getnext = mv88e6352_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
 	.serdes_power = mv88e6352_serdes_power,
@@ -2951,6 +2967,7 @@ static const struct mv88e6xxx_ops mv88e6190_ops = {
 	.mgmt_rsvd2cpu = mv88e6390_g1_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
 	.reset = mv88e6352_g1_reset,
+	.rmu_disable = mv88e6390_g1_rmu_disable,
 	.vtu_getnext = mv88e6390_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6390_g1_vtu_loadpurge,
 	.serdes_power = mv88e6390_serdes_power,
@@ -2987,6 +3004,7 @@ static const struct mv88e6xxx_ops mv88e6190x_ops = {
 	.mgmt_rsvd2cpu = mv88e6390_g1_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
 	.reset = mv88e6352_g1_reset,
+	.rmu_disable = mv88e6390_g1_rmu_disable,
 	.vtu_getnext = mv88e6390_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6390_g1_vtu_loadpurge,
 	.serdes_power = mv88e6390_serdes_power,
@@ -3023,6 +3041,7 @@ static const struct mv88e6xxx_ops mv88e6191_ops = {
 	.mgmt_rsvd2cpu = mv88e6390_g1_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
 	.reset = mv88e6352_g1_reset,
+	.rmu_disable = mv88e6390_g1_rmu_disable,
 	.vtu_getnext = mv88e6390_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6390_g1_vtu_loadpurge,
 	.serdes_power = mv88e6390_serdes_power,
@@ -3060,6 +3079,7 @@ static const struct mv88e6xxx_ops mv88e6240_ops = {
 	.mgmt_rsvd2cpu = mv88e6352_g2_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
 	.reset = mv88e6352_g1_reset,
+	.rmu_disable = mv88e6352_g1_rmu_disable,
 	.vtu_getnext = mv88e6352_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
 	.serdes_power = mv88e6352_serdes_power,
@@ -3098,6 +3118,7 @@ static const struct mv88e6xxx_ops mv88e6290_ops = {
 	.mgmt_rsvd2cpu = mv88e6390_g1_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
 	.reset = mv88e6352_g1_reset,
+	.rmu_disable = mv88e6390_g1_rmu_disable,
 	.vtu_getnext = mv88e6390_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6390_g1_vtu_loadpurge,
 	.serdes_power = mv88e6390_serdes_power,
@@ -3314,6 +3335,7 @@ static const struct mv88e6xxx_ops mv88e6352_ops = {
 	.mgmt_rsvd2cpu = mv88e6352_g2_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
 	.reset = mv88e6352_g1_reset,
+	.rmu_disable = mv88e6352_g1_rmu_disable,
 	.vtu_getnext = mv88e6352_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
 	.serdes_power = mv88e6352_serdes_power,
@@ -3357,6 +3379,7 @@ static const struct mv88e6xxx_ops mv88e6390_ops = {
 	.mgmt_rsvd2cpu = mv88e6390_g1_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
 	.reset = mv88e6352_g1_reset,
+	.rmu_disable = mv88e6390_g1_rmu_disable,
 	.vtu_getnext = mv88e6390_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6390_g1_vtu_loadpurge,
 	.serdes_power = mv88e6390_serdes_power,
@@ -3397,6 +3420,7 @@ static const struct mv88e6xxx_ops mv88e6390x_ops = {
 	.mgmt_rsvd2cpu = mv88e6390_g1_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
 	.reset = mv88e6352_g1_reset,
+	.rmu_disable = mv88e6390_g1_rmu_disable,
 	.vtu_getnext = mv88e6390_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6390_g1_vtu_loadpurge,
 	.serdes_power = mv88e6390_serdes_power,
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 62234c2287a2..a1bedb0a888b 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -432,6 +432,9 @@ struct mv88e6xxx_ops {
 
 	/* Interface to the AVB/PTP registers */
 	const struct mv88e6xxx_avb_ops *avb_ops;
+
+	/* Remote Management Unit operations */
+	int (*rmu_disable)(struct mv88e6xxx_chip *chip);
 };
 
 struct mv88e6xxx_irq_ops {
diff --git a/drivers/net/dsa/mv88e6xxx/global1.c b/drivers/net/dsa/mv88e6xxx/global1.c
index 89c6330c53eb..244ee1ff9edc 100644
--- a/drivers/net/dsa/mv88e6xxx/global1.c
+++ b/drivers/net/dsa/mv88e6xxx/global1.c
@@ -373,6 +373,24 @@ int mv88e6185_g1_set_cascade_port(struct mv88e6xxx_chip *chip, int port)
 	return mv88e6xxx_g1_ctl2_mask(chip, mask, port << __bf_shf(mask));
 }
 
+int mv88e6085_g1_rmu_disable(struct mv88e6xxx_chip *chip)
+{
+	return mv88e6xxx_g1_ctl2_mask(chip, MV88E6085_G1_CTL2_P10RM |
+				      MV88E6085_G1_CTL2_RM_ENABLE, 0);
+}
+
+int mv88e6352_g1_rmu_disable(struct mv88e6xxx_chip *chip)
+{
+	return mv88e6xxx_g1_ctl2_mask(chip, MV88E6352_G1_CTL2_RMU_MODE_MASK,
+				      MV88E6352_G1_CTL2_RMU_MODE_DISABLED);
+}
+
+int mv88e6390_g1_rmu_disable(struct mv88e6xxx_chip *chip)
+{
+	return mv88e6xxx_g1_ctl2_mask(chip, MV88E6390_G1_CTL2_RMU_MODE_MASK,
+				      MV88E6390_G1_CTL2_RMU_MODE_DISABLED);
+}
+
 int mv88e6390_g1_stats_set_histogram(struct mv88e6xxx_chip *chip)
 {
 	u16 val;
diff --git a/drivers/net/dsa/mv88e6xxx/global1.h b/drivers/net/dsa/mv88e6xxx/global1.h
index 8b043e813761..e186a026e1b1 100644
--- a/drivers/net/dsa/mv88e6xxx/global1.h
+++ b/drivers/net/dsa/mv88e6xxx/global1.h
@@ -207,6 +207,22 @@
 #define MV88E6185_G1_CTL2_CASCADE_PORT_MASK	0xf000
 #define MV88E6185_G1_CTL2_CASCADE_PORT_NONE	0xe000
 #define MV88E6185_G1_CTL2_CASCADE_PORT_MULTI	0xf000
+#define MV88E6352_G1_CTL2_RMU_MODE_MASK		0x3000
+#define MV88E6352_G1_CTL2_RMU_MODE_DISABLED	0x0000
+#define MV88E6352_G1_CTL2_RMU_MODE_PORT_4	0x1000
+#define MV88E6352_G1_CTL2_RMU_MODE_PORT_5	0x2000
+#define MV88E6352_G1_CTL2_RMU_MODE_PORT_6	0x3000
+#define MV88E6085_G1_CTL2_DA_CHECK		0x4000
+#define MV88E6085_G1_CTL2_P10RM			0x2000
+#define MV88E6085_G1_CTL2_RM_ENABLE		0x1000
+#define MV88E6352_G1_CTL2_DA_CHECK		0x0800
+#define MV88E6390_G1_CTL2_RMU_MODE_MASK		0x0700
+#define MV88E6390_G1_CTL2_RMU_MODE_PORT_0	0x0000
+#define MV88E6390_G1_CTL2_RMU_MODE_PORT_1	0x0100
+#define MV88E6390_G1_CTL2_RMU_MODE_PORT_9	0x0200
+#define MV88E6390_G1_CTL2_RMU_MODE_PORT_10	0x0300
+#define MV88E6390_G1_CTL2_RMU_MODE_ALL_DSA	0x0600
+#define MV88E6390_G1_CTL2_RMU_MODE_DISABLED	0x0700
 #define MV88E6XXX_G1_CTL2_DEVICE_NUMBER_MASK	0x001f
 
 /* Offset 0x1D: Stats Operation Register */
@@ -257,6 +273,10 @@ int mv88e6390_g1_mgmt_rsvd2cpu(struct mv88e6xxx_chip *chip);
 
 int mv88e6185_g1_set_cascade_port(struct mv88e6xxx_chip *chip, int port);
 
+int mv88e6085_g1_rmu_disable(struct mv88e6xxx_chip *chip);
+int mv88e6352_g1_rmu_disable(struct mv88e6xxx_chip *chip);
+int mv88e6390_g1_rmu_disable(struct mv88e6xxx_chip *chip);
+
 int mv88e6xxx_g1_set_device_number(struct mv88e6xxx_chip *chip, int index);
 
 int mv88e6xxx_g1_atu_set_learn2all(struct mv88e6xxx_chip *chip, bool learn2all);
-- 
2.17.0
