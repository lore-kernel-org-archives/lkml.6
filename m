Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E61C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDDEF20675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404947AbfAPPe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:34:27 -0500
Received: from mail.bootlin.com ([62.4.15.54]:36817 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394084AbfAPPe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 10:34:26 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B4F77207AC; Wed, 16 Jan 2019 16:34:23 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
        by mail.bootlin.com (Postfix) with ESMTPSA id 62017206F9;
        Wed, 16 Jan 2019 16:34:23 +0100 (CET)
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
Subject: [PATCH net-next] net: dsa: mv88e6xxx: Add suspend/resume callbacks
Date:   Wed, 16 Jan 2019 16:34:19 +0100
Message-Id: <20190116153419.3208-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.19.1
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
 drivers/net/dsa/mv88e6xxx/chip.c | 52 ++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 8a517d8fb9d1..b88efa9b86e0 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -442,15 +442,21 @@ static int mv88e6xxx_g1_irq_setup(struct mv88e6xxx_chip *chip)
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
@@ -4651,6 +4657,45 @@ static const void *pdata_device_get_match_data(struct device *dev)
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
+	return dsa_switch_resume(ds);
+}
+
+static SIMPLE_DEV_PM_OPS(mv88e6xxx_pm_ops, mv88e6xxx_suspend, mv88e6xxx_resume);
+
 static int mv88e6xxx_probe(struct mdio_device *mdiodev)
 {
 	struct dsa_mv88e6xxx_pdata *pdata = mdiodev->dev.platform_data;
@@ -4835,6 +4880,7 @@ static struct mdio_driver mv88e6xxx_driver = {
 	.mdiodrv.driver = {
 		.name = "mv88e6085",
 		.of_match_table = mv88e6xxx_of_match,
+		.pm = &mv88e6xxx_pm_ops,
 	},
 };
 
-- 
2.19.1

