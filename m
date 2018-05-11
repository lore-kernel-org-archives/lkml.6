Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752077AbeEKVRU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 17:17:20 -0400
Received: from mail.savoirfairelinux.com ([208.88.110.44]:37236 "EHLO
        mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751705AbeEKVQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 17:16:55 -0400
From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel@savoirfairelinux.com,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        davem@davemloft.net, andrew@lunn.ch, f.fainelli@gmail.com
Subject: [PATCH net-next 1/3] net: dsa: mv88e6xxx: use helper for 6390 histogram
Date: Fri, 11 May 2018 17:16:34 -0400
Message-Id: <20180511211636.25995-2-vivien.didelot@savoirfairelinux.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180511211636.25995-1-vivien.didelot@savoirfairelinux.com>
References: <20180511211636.25995-1-vivien.didelot@savoirfairelinux.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Marvell 88E6390 model has its histogram mode bits moved in the
Global 1 Control 2 register. Use the previously introduced
mv88e6xxx_g1_ctl2_mask helper to set them.

At the same time complete the documentation of the said register.

Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
---
 drivers/net/dsa/mv88e6xxx/global1.c | 15 +++------------
 drivers/net/dsa/mv88e6xxx/global1.h | 12 +++++++++---
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/global1.c b/drivers/net/dsa/mv88e6xxx/global1.c
index 244ee1ff9edc..0f2b05342c18 100644
--- a/drivers/net/dsa/mv88e6xxx/global1.c
+++ b/drivers/net/dsa/mv88e6xxx/global1.c
@@ -393,18 +393,9 @@ int mv88e6390_g1_rmu_disable(struct mv88e6xxx_chip *chip)
 
 int mv88e6390_g1_stats_set_histogram(struct mv88e6xxx_chip *chip)
 {
-	u16 val;
-	int err;
-
-	err = mv88e6xxx_g1_read(chip, MV88E6XXX_G1_CTL2, &val);
-	if (err)
-		return err;
-
-	val |= MV88E6XXX_G1_CTL2_HIST_RX_TX;
-
-	err = mv88e6xxx_g1_write(chip, MV88E6XXX_G1_CTL2, val);
-
-	return err;
+	return mv88e6xxx_g1_ctl2_mask(chip, MV88E6390_G1_CTL2_HIST_MODE_MASK,
+				      MV88E6390_G1_CTL2_HIST_MODE_RX |
+				      MV88E6390_G1_CTL2_HIST_MODE_TX);
 }
 
 int mv88e6xxx_g1_set_device_number(struct mv88e6xxx_chip *chip, int index)
diff --git a/drivers/net/dsa/mv88e6xxx/global1.h b/drivers/net/dsa/mv88e6xxx/global1.h
index e186a026e1b1..c357b3ca9a09 100644
--- a/drivers/net/dsa/mv88e6xxx/global1.h
+++ b/drivers/net/dsa/mv88e6xxx/global1.h
@@ -201,12 +201,13 @@
 
 /* Offset 0x1C: Global Control 2 */
 #define MV88E6XXX_G1_CTL2			0x1c
-#define MV88E6XXX_G1_CTL2_HIST_RX		0x0040
-#define MV88E6XXX_G1_CTL2_HIST_TX		0x0080
-#define MV88E6XXX_G1_CTL2_HIST_RX_TX		0x00c0
 #define MV88E6185_G1_CTL2_CASCADE_PORT_MASK	0xf000
 #define MV88E6185_G1_CTL2_CASCADE_PORT_NONE	0xe000
 #define MV88E6185_G1_CTL2_CASCADE_PORT_MULTI	0xf000
+#define MV88E6352_G1_CTL2_HEADER_TYPE_MASK	0xc000
+#define MV88E6352_G1_CTL2_HEADER_TYPE_ORIG	0x0000
+#define MV88E6352_G1_CTL2_HEADER_TYPE_MGMT	0x4000
+#define MV88E6390_G1_CTL2_HEADER_TYPE_LAG	0x8000
 #define MV88E6352_G1_CTL2_RMU_MODE_MASK		0x3000
 #define MV88E6352_G1_CTL2_RMU_MODE_DISABLED	0x0000
 #define MV88E6352_G1_CTL2_RMU_MODE_PORT_4	0x1000
@@ -223,6 +224,11 @@
 #define MV88E6390_G1_CTL2_RMU_MODE_PORT_10	0x0300
 #define MV88E6390_G1_CTL2_RMU_MODE_ALL_DSA	0x0600
 #define MV88E6390_G1_CTL2_RMU_MODE_DISABLED	0x0700
+#define MV88E6390_G1_CTL2_HIST_MODE_MASK	0x00c0
+#define MV88E6390_G1_CTL2_HIST_MODE_RX		0x0040
+#define MV88E6390_G1_CTL2_HIST_MODE_TX		0x0080
+#define MV88E6352_G1_CTL2_CTR_MODE_MASK		0x0060
+#define MV88E6390_G1_CTL2_CTR_MODE		0x0020
 #define MV88E6XXX_G1_CTL2_DEVICE_NUMBER_MASK	0x001f
 
 /* Offset 0x1D: Stats Operation Register */
-- 
2.17.0
