Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995F8C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 09:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B1682077B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 09:33:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B1682077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbeICNxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 09:53:03 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54519 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727434AbeICNxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 09:53:03 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1532C22A54; Mon,  3 Sep 2018 11:33:44 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id 966AD22A3D;
        Mon,  3 Sep 2018 11:33:24 +0200 (CEST)
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, kishon@ti.com,
        andrew@lunn.ch, f.fainelli@gmail.com
Cc:     allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH net-next v2 03/11] net: mscc: ocelot: get HSIO regmap from syscon
Date:   Mon,  3 Sep 2018 11:33:00 +0200
Message-Id: <20180903093308.24366-4-quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180903093308.24366-1-quentin.schulz@bootlin.com>
References: <20180903093308.24366-1-quentin.schulz@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HSIO address space was moved to a syscon, hence we need to get the
regmap of this address space from there and no more from the device
node.

Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 drivers/net/ethernet/mscc/ocelot_board.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mscc/ocelot_board.c b/drivers/net/ethernet/mscc/ocelot_board.c
index 26bb3b18f3be..b7d755b90117 100644
--- a/drivers/net/ethernet/mscc/ocelot_board.c
+++ b/drivers/net/ethernet/mscc/ocelot_board.c
@@ -9,6 +9,7 @@
 #include <linux/netdevice.h>
 #include <linux/of_mdio.h>
 #include <linux/of_platform.h>
+#include <linux/mfd/syscon.h>
 #include <linux/skbuff.h>
 
 #include "ocelot.h"
@@ -162,6 +163,7 @@ static int mscc_ocelot_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct device_node *ports, *portnp;
 	struct ocelot *ocelot;
+	struct regmap *hsio;
 	u32 val;
 
 	struct {
@@ -173,7 +175,6 @@ static int mscc_ocelot_probe(struct platform_device *pdev)
 		{ QSYS, "qsys" },
 		{ ANA, "ana" },
 		{ QS, "qs" },
-		{ HSIO, "hsio" },
 	};
 
 	if (!np && !pdev->dev.platform_data)
@@ -196,6 +197,14 @@ static int mscc_ocelot_probe(struct platform_device *pdev)
 		ocelot->targets[res[i].id] = target;
 	}
 
+	hsio = syscon_regmap_lookup_by_compatible("mscc,ocelot-hsio");
+	if (IS_ERR(hsio)) {
+		dev_err(&pdev->dev, "missing hsio syscon\n");
+		return PTR_ERR(hsio);
+	}
+
+	ocelot->targets[HSIO] = hsio;
+
 	err = ocelot_chip_init(ocelot);
 	if (err)
 		return err;
-- 
2.17.1

