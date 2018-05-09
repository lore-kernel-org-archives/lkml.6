Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965112AbeEIPjv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 11:39:51 -0400
Received: from mail.savoirfairelinux.com ([208.88.110.44]:36132 "EHLO
        mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935362AbeEIPjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 11:39:48 -0400
From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel@savoirfairelinux.com,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        davem@davemloft.net, andrew@lunn.ch, f.fainelli@gmail.com
Subject: [PATCH net-next 2/3] net: dsa: mv88e6xxx: set device number
Date: Wed,  9 May 2018 11:38:50 -0400
Message-Id: <20180509153851.10207-3-vivien.didelot@savoirfairelinux.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180509153851.10207-1-vivien.didelot@savoirfairelinux.com>
References: <20180509153851.10207-1-vivien.didelot@savoirfairelinux.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All Marvell switches supported by mv88e6xxx have to set their device
number in the Global Control 2 register. Extract this in a read then
write function, called from the device mapping setup code.

Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c    | 11 ++++-------
 drivers/net/dsa/mv88e6xxx/global1.c |  7 +++++++
 drivers/net/dsa/mv88e6xxx/global1.h |  3 +++
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 04453440a139..b4e27f9fd3af 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -1053,6 +1053,10 @@ static int mv88e6xxx_devmap_setup(struct mv88e6xxx_chip *chip)
 			return err;
 	}
 
+	err = mv88e6xxx_g1_set_device_number(chip, chip->ds->index);
+	if (err)
+		return err;
+
 	return 0;
 }
 
@@ -2160,15 +2164,8 @@ static int mv88e6xxx_set_ageing_time(struct dsa_switch *ds,
 
 static int mv88e6xxx_g1_setup(struct mv88e6xxx_chip *chip)
 {
-	struct dsa_switch *ds = chip->ds;
 	int err;
 
-	/* Disable remote management, and set the switch's DSA device number. */
-	err = mv88e6xxx_g1_write(chip, MV88E6XXX_G1_CTL2,
-				 (ds->index & 0x1f));
-	if (err)
-		return err;
-
 	/* Configure the IP ToS mapping registers. */
 	err = mv88e6xxx_g1_write(chip, MV88E6XXX_G1_IP_PRI_0, 0x0000);
 	if (err)
diff --git a/drivers/net/dsa/mv88e6xxx/global1.c b/drivers/net/dsa/mv88e6xxx/global1.c
index 6eb4eca7ca5b..89c6330c53eb 100644
--- a/drivers/net/dsa/mv88e6xxx/global1.c
+++ b/drivers/net/dsa/mv88e6xxx/global1.c
@@ -389,6 +389,13 @@ int mv88e6390_g1_stats_set_histogram(struct mv88e6xxx_chip *chip)
 	return err;
 }
 
+int mv88e6xxx_g1_set_device_number(struct mv88e6xxx_chip *chip, int index)
+{
+	return mv88e6xxx_g1_ctl2_mask(chip,
+				      MV88E6XXX_G1_CTL2_DEVICE_NUMBER_MASK,
+				      index);
+}
+
 /* Offset 0x1d: Statistics Operation 2 */
 
 int mv88e6xxx_g1_stats_wait(struct mv88e6xxx_chip *chip)
diff --git a/drivers/net/dsa/mv88e6xxx/global1.h b/drivers/net/dsa/mv88e6xxx/global1.h
index bcbb8046ad63..8b043e813761 100644
--- a/drivers/net/dsa/mv88e6xxx/global1.h
+++ b/drivers/net/dsa/mv88e6xxx/global1.h
@@ -207,6 +207,7 @@
 #define MV88E6185_G1_CTL2_CASCADE_PORT_MASK	0xf000
 #define MV88E6185_G1_CTL2_CASCADE_PORT_NONE	0xe000
 #define MV88E6185_G1_CTL2_CASCADE_PORT_MULTI	0xf000
+#define MV88E6XXX_G1_CTL2_DEVICE_NUMBER_MASK	0x001f
 
 /* Offset 0x1D: Stats Operation Register */
 #define MV88E6XXX_G1_STATS_OP			0x1d
@@ -256,6 +257,8 @@ int mv88e6390_g1_mgmt_rsvd2cpu(struct mv88e6xxx_chip *chip);
 
 int mv88e6185_g1_set_cascade_port(struct mv88e6xxx_chip *chip, int port);
 
+int mv88e6xxx_g1_set_device_number(struct mv88e6xxx_chip *chip, int index);
+
 int mv88e6xxx_g1_atu_set_learn2all(struct mv88e6xxx_chip *chip, bool learn2all);
 int mv88e6xxx_g1_atu_set_age_time(struct mv88e6xxx_chip *chip,
 				  unsigned int msecs);
-- 
2.17.0
