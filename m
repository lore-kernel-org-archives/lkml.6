Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751481AbeBVAFV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 19:05:21 -0500
Received: from galahad.ideasonboard.com ([185.26.127.97]:54808 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbeBVAFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 19:05:01 -0500
From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-renesas-soc@vger.kernel.org,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Rob Herring <robh@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
        Matt Porter <mporter@konsulko.com>,
        Koen Kooi <koen@dominion.thruhere.net>,
        Guenter Roeck <linux@roeck-us.net>, Marek Vasut <marex@denx.de>,
        Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: [PATCH v5 6/8] i2c: demux: Use changeset helpers for clarity
Date: Thu, 22 Feb 2018 02:05:29 +0200
Message-Id: <20180222000531.19448-7-laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180222000531.19448-1-laurent.pinchart+renesas@ideasonboard.com>
References: <20180222000531.19448-1-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pantelis Antoniou <pantelis.antoniou@konsulko.com>

The changeset helpers are easier to use, use them instead of
using the static property.

Signed-off-by: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Acked-by: Wolfram Sang <wsa@the-dreams.de>
["okay" -> "ok"]
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/i2c/muxes/i2c-demux-pinctrl.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-demux-pinctrl.c b/drivers/i2c/muxes/i2c-demux-pinctrl.c
index 33ce032cb701..0f0046831492 100644
--- a/drivers/i2c/muxes/i2c-demux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-demux-pinctrl.c
@@ -220,10 +220,7 @@ static int i2c_demux_pinctrl_probe(struct platform_device *pdev)
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv)
 			   + num_chan * sizeof(struct i2c_demux_pinctrl_chan), GFP_KERNEL);
-
-	props = devm_kcalloc(&pdev->dev, num_chan, sizeof(*props), GFP_KERNEL);
-
-	if (!priv || !props)
+	if (!priv)
 		return -ENOMEM;
 
 	err = of_property_read_string(np, "i2c-bus-name", &priv->bus_name);
@@ -241,12 +238,9 @@ static int i2c_demux_pinctrl_probe(struct platform_device *pdev)
 		}
 		priv->chan[i].parent_np = adap_np;
 
-		props[i].name = devm_kstrdup(&pdev->dev, "status", GFP_KERNEL);
-		props[i].value = devm_kstrdup(&pdev->dev, "ok", GFP_KERNEL);
-		props[i].length = 3;
-
 		of_changeset_init(&priv->chan[i].chgset);
-		of_changeset_update_property(&priv->chan[i].chgset, adap_np, &props[i]);
+		of_changeset_update_property_string(&priv->chan[i].chgset,
+						    adap_np, "status", "ok");
 	}
 
 	priv->num_chan = num_chan;
-- 
Regards,

Laurent Pinchart
