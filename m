Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752973AbeCMShQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 14:37:16 -0400
Received: from smtp11.smtpout.orange.fr ([80.12.242.133]:27393 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752262AbeCMShO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 14:37:14 -0400
X-ME-Helo: linux.numericable.fr
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 13 Mar 2018 19:37:11 +0100
X-ME-IP: 77.198.79.136
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: broonie@kernel.org, f.fainelli@gmail.com
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] spi: bcm-qspi: fIX some error handling paths
Date: Tue, 13 Mar 2018 19:36:58 +0100
Message-Id: <20180313183658.10641-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some reason, commit c0368e4db4a3 ("spi: bcm-qspi: Fix use after free
in bcm_qspi_probe() in error path") has updated some gotos, but not all of
them.

This looks spurious, so fix it.

Fixes: fa236a7ef240 ("spi: bcm-qspi: Add Broadcom MSPI driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
I've added the same Fixes: tag as in commit c0368e4db4a3 even if the patch
would not cleanly apply on top of it.
At least commit 4e3b2d236fe0 ("spi: bcm-qspi: Add BSPI spi-nor flash
controller driver") would also be needed.

Also the label names could be improved. But this goes beyond the scope of
this patch.
---
 drivers/spi/spi-bcm-qspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index a172ab299e80..1596d35498c5 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -1247,7 +1247,7 @@ int bcm_qspi_probe(struct platform_device *pdev,
 		qspi->base[MSPI]  = devm_ioremap_resource(dev, res);
 		if (IS_ERR(qspi->base[MSPI])) {
 			ret = PTR_ERR(qspi->base[MSPI]);
-			goto qspi_probe_err;
+			goto qspi_resource_err;
 		}
 	} else {
 		goto qspi_resource_err;
@@ -1258,7 +1258,7 @@ int bcm_qspi_probe(struct platform_device *pdev,
 		qspi->base[BSPI]  = devm_ioremap_resource(dev, res);
 		if (IS_ERR(qspi->base[BSPI])) {
 			ret = PTR_ERR(qspi->base[BSPI]);
-			goto qspi_probe_err;
+			goto qspi_resource_err;
 		}
 		qspi->bspi_mode = true;
 	} else {
-- 
2.14.1
