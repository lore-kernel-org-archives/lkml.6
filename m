Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751623AbeEVKSp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 06:18:45 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51489 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751199AbeEVKSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 06:18:35 -0400
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: davem@davemloft.net, linux@armlinux.org.uk
Cc: Antoine Tenart <antoine.tenart@bootlin.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: [PATCH net-next v2 2/3] net: phy: sfp: make the i2c-bus dt property mandatory
Date: Tue, 22 May 2018 12:18:00 +0200
Message-Id: <20180522101801.18947-3-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180522101801.18947-1-antoine.tenart@bootlin.com>
References: <20180522101801.18947-1-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the i2c-bus property mandatory when using a device
tree. If the sfp i2c bus isn't described it's impossible to guess the
protocol to use for a given module, and the sfp module would then not
work in most cases.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/phy/sfp.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index a91d12209a81..c4c92db86dfa 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -976,6 +976,7 @@ static int sfp_probe(struct platform_device *pdev)
 	if (pdev->dev.of_node) {
 		struct device_node *node = pdev->dev.of_node;
 		const struct of_device_id *id;
+		struct i2c_adapter *i2c;
 		struct device_node *np;
 
 		id = of_match_node(sfp_of_match, node);
@@ -985,19 +986,20 @@ static int sfp_probe(struct platform_device *pdev)
 		sff = sfp->type = id->data;
 
 		np = of_parse_phandle(node, "i2c-bus", 0);
-		if (np) {
-			struct i2c_adapter *i2c;
-
-			i2c = of_find_i2c_adapter_by_node(np);
-			of_node_put(np);
-			if (!i2c)
-				return -EPROBE_DEFER;
-
-			err = sfp_i2c_configure(sfp, i2c);
-			if (err < 0) {
-				i2c_put_adapter(i2c);
-				return err;
-			}
+		if (!np) {
+			dev_err(sfp->dev, "missing 'i2c-bus' property\n");
+			return -ENODEV;
+		}
+
+		i2c = of_find_i2c_adapter_by_node(np);
+		of_node_put(np);
+		if (!i2c)
+			return -EPROBE_DEFER;
+
+		err = sfp_i2c_configure(sfp, i2c);
+		if (err < 0) {
+			i2c_put_adapter(i2c);
+			return err;
 		}
 	}
 
-- 
2.17.0
