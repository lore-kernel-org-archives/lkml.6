Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964832AbeEIPLZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 11:11:25 -0400
Received: from mail.ispras.ru ([83.149.199.45]:35766 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935065AbeEIPLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 11:11:24 -0400
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
To: Joachim Eastwood <manabian@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Richard Weinberger <richard@nod.at>,
        linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org,
        Julia Lawall <julia.lawall@lip6.fr>, sil2review@lists.osadl.org
Subject: [PATCH v3] mtd: nxp-spifi: release flash_np in nxp_spifi_probe()
Date: Wed,  9 May 2018 18:11:20 +0300
Message-Id: <1525878680-22005-1-git-send-email-khoroshilov@ispras.ru>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20180509170310.65d19c49@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nxp_spifi_probe() increments refcnt of SPI flash device node by
of_get_next_available_child() and leaves it undecremented on both
successful and error paths.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
v3: Move of_node_put() before return value check as Boris Brezillon suggested.

 drivers/mtd/spi-nor/nxp-spifi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi-nor/nxp-spifi.c b/drivers/mtd/spi-nor/nxp-spifi.c
index 15374216d4d9..0c9094ec5966 100644
--- a/drivers/mtd/spi-nor/nxp-spifi.c
+++ b/drivers/mtd/spi-nor/nxp-spifi.c
@@ -436,6 +436,7 @@ static int nxp_spifi_probe(struct platform_device *pdev)
 	}
 
 	ret = nxp_spifi_setup_flash(spifi, flash_np);
+	of_node_put(flash_np);
 	if (ret) {
 		dev_err(&pdev->dev, "unable to setup flash chip\n");
 		goto dis_clks;
-- 
2.7.4
