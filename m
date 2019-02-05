Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC502C282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A589B2083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbfBELHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 06:07:35 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:59851 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728419AbfBELHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 06:07:34 -0500
X-Originating-IP: 90.88.147.226
Received: from localhost.localdomain (aaubervilliers-681-1-27-226.w90-88.abo.wanadoo.fr [90.88.147.226])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id D3ECA40003;
        Tue,  5 Feb 2019 11:07:29 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH net-next v3] net: dsa: mv88e6xxx: Prevent suspend to RAM
Date:   Tue,  5 Feb 2019 12:07:28 +0100
Message-Id: <20190205110728.11451-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On one hand, the mv88e6xxx driver has a work queue called in loop
which will attempt register accesses after MDIO bus suspension, that
entirely freezes the platform during suspend.

On the other hand, the DSA core is not ready yet to support suspend to
RAM operation because so far there is no way to recover reliably the
switch configuration.

To avoid the kernel to freeze when suspending with a switch driven by
the mv88e6xxx driver, we choose to prevent the driver suspension and
in the same way, the whole platform.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---

Changes since v1/v2
===================
* After having discussed with Vivien and Andrew, it seems that
  preventing the mv88e6xxx driver to suspend is the best option we
  have as of today. I removed the code saving the switch rules at
  driver level, I forgot about saving them at DSA level, so here are
  just two dummy PM hooks that prevent suspension.
  For people interested in picking-up what has been written and
  continue working on it, my initial proposal is available there:
  https://lore.kernel.org/netdev/20190130104606.31639abb@xps13/T/


 drivers/net/dsa/mv88e6xxx/chip.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 8a517d8fb9d1..28764d6d7388 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -4651,6 +4651,21 @@ static const void *pdata_device_get_match_data(struct device *dev)
 	return NULL;
 }
 
+/* There is no suspend to RAM support at DSA level yet, the switch configuration
+ * would be lost after a power cycle so prevent it to be suspended.
+ */
+static int __maybe_unused mv88e6xxx_suspend(struct device *dev)
+{
+	return -EOPNOTSUPP;
+}
+
+static int __maybe_unused mv88e6xxx_resume(struct device *dev)
+{
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(mv88e6xxx_pm_ops, mv88e6xxx_suspend, mv88e6xxx_resume);
+
 static int mv88e6xxx_probe(struct mdio_device *mdiodev)
 {
 	struct dsa_mv88e6xxx_pdata *pdata = mdiodev->dev.platform_data;
@@ -4835,6 +4850,7 @@ static struct mdio_driver mv88e6xxx_driver = {
 	.mdiodrv.driver = {
 		.name = "mv88e6085",
 		.of_match_table = mv88e6xxx_of_match,
+		.pm = &mv88e6xxx_pm_ops,
 	},
 };
 
-- 
2.19.1

