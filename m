Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935300AbeEIO44 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 10:56:56 -0400
Received: from mail.ispras.ru ([83.149.199.45]:34924 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934331AbeEIO4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 10:56:55 -0400
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
To: Joachim Eastwood <manabian@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Richard Weinberger <richard@nod.at>,
        linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org,
        Julia Lawall <julia.lawall@lip6.fr>, sil2review@lists.osadl.org
Subject: [PATCH v2] mtd: nxp-spifi: release flash_np in nxp_spifi_probe()
Date: Wed,  9 May 2018 17:56:46 +0300
Message-Id: <1525877806-21148-1-git-send-email-khoroshilov@ispras.ru>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20180509163920.67a5f203@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nxp_spifi_probe() increments refcnt of SPI flash device node by
of_get_next_available_child() and leaves it undecremented on both
successful and error paths.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/mtd/spi-nor/nxp-spifi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/nxp-spifi.c b/drivers/mtd/spi-nor/nxp-spifi.c
index 15374216d4d9..7b047951d0a2 100644
--- a/drivers/mtd/spi-nor/nxp-spifi.c
+++ b/drivers/mtd/spi-nor/nxp-spifi.c
@@ -438,11 +438,15 @@ static int nxp_spifi_probe(struct platform_device *pdev)
 	ret = nxp_spifi_setup_flash(spifi, flash_np);
 	if (ret) {
 		dev_err(&pdev->dev, "unable to setup flash chip\n");
-		goto dis_clks;
+		goto put_np;
 	}
 
+	of_node_put(flash_np);
+
 	return 0;
 
+put_np:
+	of_node_put(flash_np);
 dis_clks:
 	clk_disable_unprepare(spifi->clk_spifi);
 dis_clk_reg:
-- 
2.7.4
