Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752069AbeEDOAV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 10:00:21 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60392 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751572AbeEDOAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 10:00:13 -0400
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: davem@davemloft.net, kishon@ti.com, linux@armlinux.org.uk,
        gregory.clement@bootlin.com, andrew@lunn.ch, jason@lakedaemon.net,
        sebastian.hesselbarth@gmail.com
Cc: Antoine Tenart <antoine.tenart@bootlin.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com, linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next v2 02/13] net: phy: sfp: handle non-wired SFP connectors
Date: Fri,  4 May 2018 15:56:32 +0200
Message-Id: <20180504135643.23466-3-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180504135643.23466-1-antoine.tenart@bootlin.com>
References: <20180504135643.23466-1-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SFP connectors can be solder on a board without having any of their pins
(LOS, i2c...) wired. In such cases the SFP link state cannot be guessed,
and the overall link status reporting is left to other layers.

In order to achieve this, a new SFP_DEV status is added, named UNKNOWN.
This mode is set when it is not possible for the SFP code to get the
link status and as a result the link status is reported to be always UP
from the SFP point of view.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/phy/sfp.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 4686c443fc22..8e323a4b70da 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -48,6 +48,7 @@ enum {
 
 	SFP_DEV_DOWN = 0,
 	SFP_DEV_UP,
+	SFP_DEV_UNKNOWN,
 
 	SFP_S_DOWN = 0,
 	SFP_S_INIT,
@@ -737,6 +738,15 @@ static void sfp_sm_event(struct sfp *sfp, unsigned int event)
 			sfp->sm_dev_state = SFP_DEV_DOWN;
 		}
 		break;
+
+	case SFP_DEV_UNKNOWN:
+		/* We can't know the state of the SFP link. Report the
+		 * link as being up as its status has to be guessed by
+		 * other layers.
+		 */
+		if (event != SFP_E_DEV_UP)
+			sfp_link_up(sfp->sfp_bus);
+		break;
 	}
 
 	/* Some events are global */
@@ -1077,6 +1087,12 @@ static int sfp_probe(struct platform_device *pdev)
 	if (poll)
 		mod_delayed_work(system_wq, &sfp->poll, poll_jiffies);
 
+	/* We won't be able to know the state of the SFP link, report it as
+	 * unknown.
+	 */
+	if (!sfp->gpio[GPIO_MODDEF0] && !sfp->gpio[GPIO_LOS])
+		sfp->sm_dev_state = SFP_DEV_UNKNOWN;
+
 	return 0;
 }
 
-- 
2.17.0
