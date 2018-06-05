Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752097AbeFEUh7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 16:37:59 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36986 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751894AbeFEUh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 16:37:57 -0400
X-Google-Smtp-Source: ADUXVKLQ4dPBMs+9zW56Ll/MtFCwzAvi4CWfQo6kkaQkqqX3Gc+RBdgj5EtSu559c/o51THEdQU/0Q==
From: Arun Parameswaran <arun.parameswaran@broadcom.com>
To: Florian Fainelli <f.fainelli@gmail.com>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Arun Parameswaran <arun.parameswaran@broadcom.com>
Subject: [PATCH 1/1] net: dsa: b53: Fix for brcm tag issue in Cygnus SoC
Date: Tue,  5 Jun 2018 13:38:12 -0700
Message-Id: <1528231092-31472-1-git-send-email-arun.parameswaran@broadcom.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the Broadcom Cygnus SoC, the brcm tag needs to be inserted
in between the mac address and the ether type (should use
'DSA_PROTO_TAG_BRCM') for the packets sent to the internal
b53 switch.

Since the Cygnus was added with the BCM58XX device id and the
BCM58XX uses 'DSA_PROTO_TAG_BRCM_PREPEND', the data path is
broken, due to the incorrect brcm tag location.

Add a new b53 device id (BCM583XX) for Cygnus family to fix the
issue. Add the new device id to the BCM58XX family as Cygnus
is similar to the BCM58XX in most other functionalities.

Fixes: 11606039604c ("net: dsa: b53: Support prepended Broadcom tags")

Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>
---
 drivers/net/dsa/b53/b53_common.c | 15 ++++++++++++++-
 drivers/net/dsa/b53/b53_priv.h   |  2 ++
 drivers/net/dsa/b53/b53_srab.c   |  4 ++--
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 3da5fca..bbc6cc6 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -684,7 +684,8 @@ static int b53_switch_reset(struct b53_device *dev)
 	 * still use this driver as a library and need to perform the reset
 	 * earlier.
 	 */
-	if (dev->chip_id == BCM58XX_DEVICE_ID) {
+	if (dev->chip_id == BCM58XX_DEVICE_ID ||
+	    dev->chip_id == BCM583XX_DEVICE_ID) {
 		b53_read8(dev, B53_CTRL_PAGE, B53_SOFTRESET, &reg);
 		reg |= SW_RST | EN_SW_RST | EN_CH_RST;
 		b53_write8(dev, B53_CTRL_PAGE, B53_SOFTRESET, reg);
@@ -1880,6 +1881,18 @@ struct b53_chip_data {
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
 	},
 	{
+		.chip_id = BCM583XX_DEVICE_ID,
+		.dev_name = "BCM583xx/11360",
+		.vlans = 4096,
+		.enabled_ports = 0x103,
+		.arl_entries = 4,
+		.cpu_port = B53_CPU_PORT,
+		.vta_regs = B53_VTA_REGS,
+		.duplex_reg = B53_DUPLEX_STAT_GE,
+		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
+		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
+	},
+	{
 		.chip_id = BCM7445_DEVICE_ID,
 		.dev_name = "BCM7445",
 		.vlans	= 4096,
diff --git a/drivers/net/dsa/b53/b53_priv.h b/drivers/net/dsa/b53/b53_priv.h
index 3b57f47..b232aaa 100644
--- a/drivers/net/dsa/b53/b53_priv.h
+++ b/drivers/net/dsa/b53/b53_priv.h
@@ -62,6 +62,7 @@ enum {
 	BCM53018_DEVICE_ID = 0x53018,
 	BCM53019_DEVICE_ID = 0x53019,
 	BCM58XX_DEVICE_ID = 0x5800,
+	BCM583XX_DEVICE_ID = 0x58300,
 	BCM7445_DEVICE_ID = 0x7445,
 	BCM7278_DEVICE_ID = 0x7278,
 };
@@ -181,6 +182,7 @@ static inline int is5301x(struct b53_device *dev)
 static inline int is58xx(struct b53_device *dev)
 {
 	return dev->chip_id == BCM58XX_DEVICE_ID ||
+		dev->chip_id == BCM583XX_DEVICE_ID ||
 		dev->chip_id == BCM7445_DEVICE_ID ||
 		dev->chip_id == BCM7278_DEVICE_ID;
 }
diff --git a/drivers/net/dsa/b53/b53_srab.c b/drivers/net/dsa/b53/b53_srab.c
index c37ffd1..8247481 100644
--- a/drivers/net/dsa/b53/b53_srab.c
+++ b/drivers/net/dsa/b53/b53_srab.c
@@ -364,7 +364,7 @@ static int b53_srab_write64(struct b53_device *dev, u8 page, u8 reg,
 	{ .compatible = "brcm,bcm53018-srab" },
 	{ .compatible = "brcm,bcm53019-srab" },
 	{ .compatible = "brcm,bcm5301x-srab" },
-	{ .compatible = "brcm,bcm11360-srab", .data = (void *)BCM58XX_DEVICE_ID },
+	{ .compatible = "brcm,bcm11360-srab", .data = (void *)BCM583XX_DEVICE_ID },
 	{ .compatible = "brcm,bcm58522-srab", .data = (void *)BCM58XX_DEVICE_ID },
 	{ .compatible = "brcm,bcm58525-srab", .data = (void *)BCM58XX_DEVICE_ID },
 	{ .compatible = "brcm,bcm58535-srab", .data = (void *)BCM58XX_DEVICE_ID },
@@ -372,7 +372,7 @@ static int b53_srab_write64(struct b53_device *dev, u8 page, u8 reg,
 	{ .compatible = "brcm,bcm58623-srab", .data = (void *)BCM58XX_DEVICE_ID },
 	{ .compatible = "brcm,bcm58625-srab", .data = (void *)BCM58XX_DEVICE_ID },
 	{ .compatible = "brcm,bcm88312-srab", .data = (void *)BCM58XX_DEVICE_ID },
-	{ .compatible = "brcm,cygnus-srab", .data = (void *)BCM58XX_DEVICE_ID },
+	{ .compatible = "brcm,cygnus-srab", .data = (void *)BCM583XX_DEVICE_ID },
 	{ .compatible = "brcm,nsp-srab", .data = (void *)BCM58XX_DEVICE_ID },
 	{ /* sentinel */ },
 };
-- 
1.9.1
