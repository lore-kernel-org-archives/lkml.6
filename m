Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965123AbeEIPkI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 11:40:08 -0400
Received: from mail.savoirfairelinux.com ([208.88.110.44]:36166 "EHLO
        mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935403AbeEIPjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 11:39:49 -0400
From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel@savoirfairelinux.com,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        davem@davemloft.net, andrew@lunn.ch, f.fainelli@gmail.com
Subject: [PATCH net-next 1/3] net: dsa: mv88e6xxx: add a cascade port op
Date: Wed,  9 May 2018 11:38:49 -0400
Message-Id: <20180509153851.10207-2-vivien.didelot@savoirfairelinux.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180509153851.10207-1-vivien.didelot@savoirfairelinux.com>
References: <20180509153851.10207-1-vivien.didelot@savoirfairelinux.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only the 88E6185 family has bits 15:12 Cascade Port bits in the Global
Control 2 register. Hence inconsistent values are actually written in
this register for other families.

Add a .set_cascade_port operation to isolate the 88E6185 case, and call
it from the device mapping setup function.

Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c    | 10 +++++++++-
 drivers/net/dsa/mv88e6xxx/chip.h    |  6 ++++++
 drivers/net/dsa/mv88e6xxx/global1.c | 23 +++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/global1.h |  7 +++++--
 4 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 9d62e4acc01b..04453440a139 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -1046,6 +1046,13 @@ static int mv88e6xxx_devmap_setup(struct mv88e6xxx_chip *chip)
 			return err;
 	}
 
+	if (chip->info->ops->set_cascade_port) {
+		port = MV88E6XXX_CASCADE_PORT_MULTIPLE;
+		err = chip->info->ops->set_cascade_port(chip, port);
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
 
@@ -2158,7 +2165,6 @@ static int mv88e6xxx_g1_setup(struct mv88e6xxx_chip *chip)
 
 	/* Disable remote management, and set the switch's DSA device number. */
 	err = mv88e6xxx_g1_write(chip, MV88E6XXX_G1_CTL2,
-				 MV88E6XXX_G1_CTL2_MULTIPLE_CASCADE |
 				 (ds->index & 0x1f));
 	if (err)
 		return err;
@@ -2642,6 +2648,7 @@ static const struct mv88e6xxx_ops mv88e6131_ops = {
 	.watchdog_ops = &mv88e6097_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6185_g2_mgmt_rsvd2cpu,
 	.ppu_enable = mv88e6185_g1_ppu_enable,
+	.set_cascade_port = mv88e6185_g1_set_cascade_port,
 	.ppu_disable = mv88e6185_g1_ppu_disable,
 	.reset = mv88e6185_g1_reset,
 	.vtu_getnext = mv88e6185_g1_vtu_getnext,
@@ -2909,6 +2916,7 @@ static const struct mv88e6xxx_ops mv88e6185_ops = {
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6097_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6185_g2_mgmt_rsvd2cpu,
+	.set_cascade_port = mv88e6185_g1_set_cascade_port,
 	.ppu_enable = mv88e6185_g1_ppu_enable,
 	.ppu_disable = mv88e6185_g1_ppu_disable,
 	.reset = mv88e6185_g1_reset,
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 4163c8099d0b..62234c2287a2 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -401,6 +401,12 @@ struct mv88e6xxx_ops {
 			       uint64_t *data);
 	int (*set_cpu_port)(struct mv88e6xxx_chip *chip, int port);
 	int (*set_egress_port)(struct mv88e6xxx_chip *chip, int port);
+
+#define MV88E6XXX_CASCADE_PORT_NONE		0xe
+#define MV88E6XXX_CASCADE_PORT_MULTIPLE		0xf
+
+	int (*set_cascade_port)(struct mv88e6xxx_chip *chip, int port);
+
 	const struct mv88e6xxx_irq_ops *watchdog_ops;
 
 	int (*mgmt_rsvd2cpu)(struct mv88e6xxx_chip *chip);
diff --git a/drivers/net/dsa/mv88e6xxx/global1.c b/drivers/net/dsa/mv88e6xxx/global1.c
index b43bd6476632..6eb4eca7ca5b 100644
--- a/drivers/net/dsa/mv88e6xxx/global1.c
+++ b/drivers/net/dsa/mv88e6xxx/global1.c
@@ -350,6 +350,29 @@ int mv88e6390_g1_mgmt_rsvd2cpu(struct mv88e6xxx_chip *chip)
 
 /* Offset 0x1c: Global Control 2 */
 
+static int mv88e6xxx_g1_ctl2_mask(struct mv88e6xxx_chip *chip, u16 mask,
+				  u16 val)
+{
+	u16 reg;
+	int err;
+
+	err = mv88e6xxx_g1_read(chip, MV88E6XXX_G1_CTL2, &reg);
+	if (err)
+		return err;
+
+	reg &= ~mask;
+	reg |= val & mask;
+
+	return mv88e6xxx_g1_write(chip, MV88E6XXX_G1_CTL2, reg);
+}
+
+int mv88e6185_g1_set_cascade_port(struct mv88e6xxx_chip *chip, int port)
+{
+	const u16 mask = MV88E6185_G1_CTL2_CASCADE_PORT_MASK;
+
+	return mv88e6xxx_g1_ctl2_mask(chip, mask, port << __bf_shf(mask));
+}
+
 int mv88e6390_g1_stats_set_histogram(struct mv88e6xxx_chip *chip)
 {
 	u16 val;
diff --git a/drivers/net/dsa/mv88e6xxx/global1.h b/drivers/net/dsa/mv88e6xxx/global1.h
index 6aee7316fea6..bcbb8046ad63 100644
--- a/drivers/net/dsa/mv88e6xxx/global1.h
+++ b/drivers/net/dsa/mv88e6xxx/global1.h
@@ -201,11 +201,12 @@
 
 /* Offset 0x1C: Global Control 2 */
 #define MV88E6XXX_G1_CTL2			0x1c
-#define MV88E6XXX_G1_CTL2_NO_CASCADE		0xe000
-#define MV88E6XXX_G1_CTL2_MULTIPLE_CASCADE	0xf000
 #define MV88E6XXX_G1_CTL2_HIST_RX		0x0040
 #define MV88E6XXX_G1_CTL2_HIST_TX		0x0080
 #define MV88E6XXX_G1_CTL2_HIST_RX_TX		0x00c0
+#define MV88E6185_G1_CTL2_CASCADE_PORT_MASK	0xf000
+#define MV88E6185_G1_CTL2_CASCADE_PORT_NONE	0xe000
+#define MV88E6185_G1_CTL2_CASCADE_PORT_MULTI	0xf000
 
 /* Offset 0x1D: Stats Operation Register */
 #define MV88E6XXX_G1_STATS_OP			0x1d
@@ -253,6 +254,8 @@ int mv88e6095_g1_set_cpu_port(struct mv88e6xxx_chip *chip, int port);
 int mv88e6390_g1_set_cpu_port(struct mv88e6xxx_chip *chip, int port);
 int mv88e6390_g1_mgmt_rsvd2cpu(struct mv88e6xxx_chip *chip);
 
+int mv88e6185_g1_set_cascade_port(struct mv88e6xxx_chip *chip, int port);
+
 int mv88e6xxx_g1_atu_set_learn2all(struct mv88e6xxx_chip *chip, bool learn2all);
 int mv88e6xxx_g1_atu_set_age_time(struct mv88e6xxx_chip *chip,
 				  unsigned int msecs);
-- 
2.17.0
