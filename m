Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753197AbeBIW33 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 17:29:29 -0500
Received: from mail.ispras.ru ([83.149.199.45]:44508 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753123AbeBIW3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 17:29:14 -0500
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Stefan Agner <stefan@agner.ch>, Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH v4 2/3] mtd: nand: vf610: improve readability of error label
Date: Sat, 10 Feb 2018 01:28:35 +0300
Message-Id: <1518215316-21504-3-git-send-email-khoroshilov@ispras.ru>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518215316-21504-1-git-send-email-khoroshilov@ispras.ru>
References: <1518215316-21504-1-git-send-email-khoroshilov@ispras.ru>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use clearer error labels as Boris Brezillon suggested.

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/mtd/nand/vf610_nfc.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/mtd/nand/vf610_nfc.c b/drivers/mtd/nand/vf610_nfc.c
index c4568372c3e3..9cc5992e88c8 100644
--- a/drivers/mtd/nand/vf610_nfc.c
+++ b/drivers/mtd/nand/vf610_nfc.c
@@ -682,7 +682,7 @@ static int vf610_nfc_probe(struct platform_device *pdev)
 				dev_err(nfc->dev,
 					"Only one NAND chip supported!\n");
 				err = -EINVAL;
-				goto err_clk;
+				goto err_disable_clk;
 			}
 
 			nand_set_flash_node(chip, child);
@@ -692,7 +692,7 @@ static int vf610_nfc_probe(struct platform_device *pdev)
 	if (!nand_get_flash_node(chip)) {
 		dev_err(nfc->dev, "NAND chip sub-node missing!\n");
 		err = -ENODEV;
-		goto err_clk;
+		goto err_disable_clk;
 	}
 
 	chip->dev_ready = vf610_nfc_dev_ready;
@@ -712,7 +712,7 @@ static int vf610_nfc_probe(struct platform_device *pdev)
 	err = devm_request_irq(nfc->dev, irq, vf610_nfc_irq, 0, DRV_NAME, mtd);
 	if (err) {
 		dev_err(nfc->dev, "Error requesting IRQ!\n");
-		goto err_clk;
+		goto err_disable_clk;
 	}
 
 	vf610_nfc_preinit_controller(nfc);
@@ -720,7 +720,7 @@ static int vf610_nfc_probe(struct platform_device *pdev)
 	/* first scan to find the device and get the page size */
 	err = nand_scan_ident(mtd, 1, NULL);
 	if (err)
-		goto err_clk;
+		goto err_disable_clk;
 
 	vf610_nfc_init_controller(nfc);
 
@@ -732,20 +732,20 @@ static int vf610_nfc_probe(struct platform_device *pdev)
 	if (mtd->writesize + mtd->oobsize > PAGE_2K + OOB_MAX - 8) {
 		dev_err(nfc->dev, "Unsupported flash page size\n");
 		err = -ENXIO;
-		goto err_clk;
+		goto err_disable_clk;
 	}
 
 	if (chip->ecc.mode == NAND_ECC_HW) {
 		if (mtd->writesize != PAGE_2K && mtd->oobsize < 64) {
 			dev_err(nfc->dev, "Unsupported flash with hwecc\n");
 			err = -ENXIO;
-			goto err_clk;
+			goto err_disable_clk;
 		}
 
 		if (chip->ecc.size != mtd->writesize) {
 			dev_err(nfc->dev, "Step size needs to be page size\n");
 			err = -ENXIO;
-			goto err_clk;
+			goto err_disable_clk;
 		}
 
 		/* Only 64 byte ECC layouts known */
@@ -765,7 +765,7 @@ static int vf610_nfc_probe(struct platform_device *pdev)
 		} else {
 			dev_err(nfc->dev, "Unsupported ECC strength\n");
 			err = -ENXIO;
-			goto err_clk;
+			goto err_disable_clk;
 		}
 
 		chip->ecc.read_page = vf610_nfc_read_page;
@@ -777,14 +777,14 @@ static int vf610_nfc_probe(struct platform_device *pdev)
 	/* second phase scan */
 	err = nand_scan_tail(mtd);
 	if (err)
-		goto err_clk;
+		goto err_disable_clk;
 
 	platform_set_drvdata(pdev, mtd);
 
 	/* Register device in MTD */
 	return mtd_device_register(mtd, NULL, 0);
 
-err_clk:
+err_disable_clk:
 	clk_disable_unprepare(nfc->clk);
 	return err;
 }
-- 
2.7.4
