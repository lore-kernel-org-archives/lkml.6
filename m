Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751880AbeEDOAU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 10:00:20 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60405 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751651AbeEDOAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 10:00:14 -0400
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: davem@davemloft.net, kishon@ti.com, linux@armlinux.org.uk,
        gregory.clement@bootlin.com, andrew@lunn.ch, jason@lakedaemon.net,
        sebastian.hesselbarth@gmail.com
Cc: Antoine Tenart <antoine.tenart@bootlin.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com, linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next v2 03/13] net: phy: sfp: warn the user when no tx_disable pin is available
Date: Fri,  4 May 2018 15:56:33 +0200
Message-Id: <20180504135643.23466-4-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180504135643.23466-1-antoine.tenart@bootlin.com>
References: <20180504135643.23466-1-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case no Tx disable pin is available the SFP modules will always be
emitting. This could be an issue when using modules using laser as their
light source as we would have no way to disable it when the fiber is
removed. This patch adds a warning when registering an SFP cage which do
not have its tx_disable pin wired or available.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/phy/sfp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 8e323a4b70da..d4f503b2e3e2 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -1093,6 +1093,15 @@ static int sfp_probe(struct platform_device *pdev)
 	if (!sfp->gpio[GPIO_MODDEF0] && !sfp->gpio[GPIO_LOS])
 		sfp->sm_dev_state = SFP_DEV_UNKNOWN;
 
+	/* We could have an issue in cases no Tx disable pin is available or
+	 * wired as modules using a laser as their light source will continue to
+	 * be active when the fiber is removed. This could be a safety issue and
+	 * we should at least warn the user about that.
+	 */
+	if (!sfp->gpio[GPIO_TX_DISABLE])
+		dev_warn(sfp->dev,
+			 "No tx_disable pin: SFP modules will always be emitting.\n");
+
 	return 0;
 }
 
-- 
2.17.0
