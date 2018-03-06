Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753363AbeCFLK6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 06:10:58 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34285 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbeCFLK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 06:10:57 -0500
X-Google-Smtp-Source: AG47ELuNvffyXFRvkfk/zUTiqq50gt4+CsD4lqaAffis3aEXy3yz3/85Lm6+A/xkKQ82M9lYU4qE0g==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
Subject: [PATCH net-next] net: phy: mdio-mux: slience probe defer error
Date: Tue,  6 Mar 2018 12:10:45 +0100
Message-Id: <20180306111045.19315-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we fail to register the mdio bus due to probe defer, we should not
print an error message. Just be silent in this case.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/net/phy/mdio-mux-mmioreg.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/mdio-mux-mmioreg.c b/drivers/net/phy/mdio-mux-mmioreg.c
index 2573ab012f16..70f6115530af 100644
--- a/drivers/net/phy/mdio-mux-mmioreg.c
+++ b/drivers/net/phy/mdio-mux-mmioreg.c
@@ -163,8 +163,9 @@ static int mdio_mux_mmioreg_probe(struct platform_device *pdev)
 			    mdio_mux_mmioreg_switch_fn,
 			    &s->mux_handle, s, NULL);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to register mdio-mux bus %pOF\n",
-			np);
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev,
+				"failed to register mdio-mux bus %pOF\n", np);
 		return ret;
 	}
 
-- 
2.14.3
