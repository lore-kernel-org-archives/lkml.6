Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751454AbeEVKSi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 06:18:38 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51504 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751390AbeEVKSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 06:18:36 -0400
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: davem@davemloft.net, linux@armlinux.org.uk
Cc: Antoine Tenart <antoine.tenart@bootlin.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: [PATCH net-next v2 1/3] net: phy: sfp: warn the user when no tx_disable pin is available
Date: Tue, 22 May 2018 12:17:59 +0200
Message-Id: <20180522101801.18947-2-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180522101801.18947-1-antoine.tenart@bootlin.com>
References: <20180522101801.18947-1-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case no Tx disable pin is available the SFP modules will always be
emitting. This could be an issue when using modules using laser as their
light source as we would have no way to disable it when the fiber is
removed. This patch adds a warning when registering an SFP cage which do
not have its tx_disable pin wired or available.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/sfp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 4ab6e9a50bbe..a91d12209a81 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -1065,6 +1065,15 @@ static int sfp_probe(struct platform_device *pdev)
 	if (poll)
 		mod_delayed_work(system_wq, &sfp->poll, poll_jiffies);
 
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
