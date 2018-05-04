Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751417AbeEDPPE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 11:15:04 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35757 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750707AbeEDPPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 11:15:03 -0400
From: Antoine Tenart <antoine.tenart@bootlin.com>
To: davem@davemloft.net, linux@armlinux.org.uk
Cc: Antoine Tenart <antoine.tenart@bootlin.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: [PATCH net] net: phy: sfp: fix the BR,min computation
Date: Fri,  4 May 2018 17:10:54 +0200
Message-Id: <20180504151054.17525-1-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In an SFP EEPROM values can be read to get information about a given SFP
module. One of those is the bitrate, which can be determined using a
nominal bitrate in addition with min and max values (in %). The SFP code
currently compute both BR,min and BR,max values thanks to this nominal
and min,max values.

This patch fixes the BR,min computation as the min value should be
subtracted to the nominal one, not added.

Fixes: 9962acf7fb8c ("sfp: add support for 1000Base-PX and 1000Base-BX10")
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/phy/sfp-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/sfp-bus.c b/drivers/net/phy/sfp-bus.c
index 0381da78d228..fd6c23f69c2f 100644
--- a/drivers/net/phy/sfp-bus.c
+++ b/drivers/net/phy/sfp-bus.c
@@ -125,7 +125,7 @@ void sfp_parse_support(struct sfp_bus *bus, const struct sfp_eeprom_id *id,
 	if (id->base.br_nominal) {
 		if (id->base.br_nominal != 255) {
 			br_nom = id->base.br_nominal * 100;
-			br_min = br_nom + id->base.br_nominal * id->ext.br_min;
+			br_min = br_nom - id->base.br_nominal * id->ext.br_min;
 			br_max = br_nom + id->base.br_nominal * id->ext.br_max;
 		} else if (id->ext.br_max) {
 			br_nom = 250 * id->ext.br_max;
-- 
2.17.0
