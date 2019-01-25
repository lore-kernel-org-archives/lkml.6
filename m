Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBCFC282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E83432084A
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbfAYJzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 04:55:15 -0500
Received: from mail.bootlin.com ([62.4.15.54]:42768 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728007AbfAYJzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 04:55:13 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D9D9D207AD; Fri, 25 Jan 2019 10:55:09 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr [90.88.29.206])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8E6CD20798;
        Fri, 25 Jan 2019 10:55:09 +0100 (CET)
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
Subject: [PATCH net-next v2 2/2] net: dsa: mv88e6xxx: Add suspend to RAM support
Date:   Fri, 25 Jan 2019 10:55:07 +0100
Message-Id: <20190125095507.29334-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190125095507.29334-1-miquel.raynal@bootlin.com>
References: <20190125095507.29334-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bring S2RAM support to the mv88e6xxx DSA driver.

The content of the *_irq_poll() helper is moved in *_do_irq_poll() so
that that the function can be called from the ->resume() callback
without using the *work pointer.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---

Changes since v1:
=================
* Added the logic to replay rules.
* Did not add any port_disable/enable() calls as this will be taken
  care of by Vivien's patches.

 drivers/net/dsa/mv88e6xxx/chip.c | 89 ++++++++++++++++++++++++++++++--
 1 file changed, 86 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 428177f80abd..e83c02aaca49 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -547,15 +547,21 @@ static int mv88e6xxx_g1_irq_setup(struct mv88e6xxx_chip *chip)
 	return err;
 }
 
+static void mv88e6xxx_do_irq_poll(struct mv88e6xxx_chip *chip)
+{
+	mv88e6xxx_g1_irq_thread_work(chip);
+
+	kthread_queue_delayed_work(chip->kworker, &chip->irq_poll_work,
+				   msecs_to_jiffies(100));
+}
+
 static void mv88e6xxx_irq_poll(struct kthread_work *work)
 {
 	struct mv88e6xxx_chip *chip = container_of(work,
 						   struct mv88e6xxx_chip,
 						   irq_poll_work.work);
-	mv88e6xxx_g1_irq_thread_work(chip);
 
-	kthread_queue_delayed_work(chip->kworker, &chip->irq_poll_work,
-				   msecs_to_jiffies(100));
+	mv88e6xxx_do_irq_poll(chip);
 }
 
 static int mv88e6xxx_irq_poll_setup(struct mv88e6xxx_chip *chip)
@@ -4855,6 +4861,82 @@ static const void *pdata_device_get_match_data(struct device *dev)
 	return NULL;
 }
 
+static int __maybe_unused mv88e6xxx_suspend(struct device *dev)
+{
+	struct dsa_switch *ds = dev_get_drvdata(dev);
+	struct mv88e6xxx_chip *chip = ds->priv;
+
+	kthread_cancel_delayed_work_sync(&chip->irq_poll_work);
+
+	return dsa_switch_suspend(ds);
+}
+
+static int __maybe_unused mv88e6xxx_resume(struct device *dev)
+{
+	struct dsa_switch *ds = dev_get_drvdata(dev);
+	struct mv88e6xxx_chip *chip = ds->priv;
+	struct mv88e6xxx_rule *rule;
+	int ret;
+
+	mv88e6xxx_phy_init(chip);
+
+	mutex_lock(&chip->reg_lock);
+	ret = mv88e6xxx_switch_reset(chip);
+	mutex_unlock(&chip->reg_lock);
+	if (ret) {
+		dev_err(dev, "Failed to reset the switch\n");
+		return ret;
+	}
+
+	ret = mv88e6xxx_setup(ds);
+	if (ret) {
+		dev_err(dev, "Failed to setup the switch\n");
+		return ret;
+	}
+
+	mv88e6xxx_do_irq_poll(chip);
+
+	list_for_each_entry(rule, &chip->rules, node) {
+		switch (rule->type) {
+		case FDB_RULE:
+			ret = _mv88e6xxx_port_fdb_add(chip, rule->port,
+						      rule->params.db.addr,
+						      rule->params.db.vid);
+			break;
+		case MDB_RULE:
+			ret = _mv88e6xxx_port_mdb_add(chip, rule->port,
+						      rule->params.db.addr,
+						      rule->params.db.vid);
+			break;
+		case VLAN_RULE:
+			ret = _mv88e6xxx_port_vlan_add(chip, rule->port,
+						       &rule->params.vlan);
+			break;
+		case BRIDGE_RULE:
+			ret = _mv88e6xxx_port_bridge_join(chip, rule->port,
+							  rule->params.br);
+			break;
+		case CC_BRIDGE_RULE:
+			ret = _mv88e6xxx_crosschip_bridge_join(chip,
+							       rule->params.crosschip.dev,
+							       rule->port,
+							       rule->params.crosschip.br);
+			break;
+		default:
+			dev_warn(chip->dev, "Unknown rule type (%d)\n",
+				 rule->type);
+			continue;
+		}
+
+		if (ret)
+			dev_warn(chip->dev, "Cannot re-apply rule\n");
+	}
+
+	return dsa_switch_resume(ds);
+}
+
+static SIMPLE_DEV_PM_OPS(mv88e6xxx_pm_ops, mv88e6xxx_suspend, mv88e6xxx_resume);
+
 static int mv88e6xxx_probe(struct mdio_device *mdiodev)
 {
 	struct dsa_mv88e6xxx_pdata *pdata = mdiodev->dev.platform_data;
@@ -5041,6 +5123,7 @@ static struct mdio_driver mv88e6xxx_driver = {
 	.mdiodrv.driver = {
 		.name = "mv88e6085",
 		.of_match_table = mv88e6xxx_of_match,
+		.pm = &mv88e6xxx_pm_ops,
 	},
 };
 
-- 
2.19.1

