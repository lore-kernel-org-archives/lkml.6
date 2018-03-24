Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751541AbeCXHOG (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 03:14:06 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:32839 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750769AbeCXHOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 03:14:04 -0400
X-Google-Smtp-Source: AG47ELuz/6Q/u9jKuXzMEwe0nJyz70b4PXbcasgpGqQF33+qz6bB5YI89Co5LRLF4Wesgr+r0Tmu3A==
Date: Sat, 24 Mar 2018 12:43:05 +0530
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: dwmw2@infradead.org
Cc: Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Subject: [PATCH] mtd: switch to mtd_device_register()
Message-ID: <20180324071305.GA6446@seema-Inspiron-15-3567>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use mtd_device_register() instead of mtd_device_parse_register() to
eliminate two unused parameters.

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
 drivers/mtd/devices/sst25l.c        | 5 ++---
 drivers/mtd/lpddr/lpddr2_nvm.c      | 2 +-
 drivers/mtd/maps/impa7.c            | 5 ++---
 drivers/mtd/maps/intel_vr_nor.c     | 2 +-
 drivers/mtd/maps/latch-addr-flash.c | 5 ++---
 drivers/mtd/maps/rbtx4939-flash.c   | 4 ++--
 drivers/mtd/nand/cmx270_nand.c      | 4 ++--
 drivers/mtd/nand/cs553x_nand.c      | 3 +--
 drivers/mtd/nand/davinci_nand.c     | 4 ++--
 drivers/mtd/nand/jz4740_nand.c      | 5 ++---
 drivers/mtd/nand/mtk_nand.c         | 2 +-
 drivers/mtd/nand/s3c2410.c          | 4 ++--
 drivers/mtd/nand/txx9ndfmc.c        | 2 +-
 drivers/mtd/onenand/generic.c       | 5 ++---
 drivers/mtd/onenand/samsung.c       | 5 ++---
 drivers/mtd/spi-nor/intel-spi.c     | 2 +-
 16 files changed, 26 insertions(+), 33 deletions(-)

diff --git a/drivers/mtd/devices/sst25l.c b/drivers/mtd/devices/sst25l.c
index 5b84d71..bc14aca 100644
--- a/drivers/mtd/devices/sst25l.c
+++ b/drivers/mtd/devices/sst25l.c
@@ -397,9 +397,8 @@ static int sst25l_probe(struct spi_device *spi)
 	      flash->mtd.numeraseregions);
 
 
-	ret = mtd_device_parse_register(&flash->mtd, NULL, NULL,
-					data ? data->parts : NULL,
-					data ? data->nr_parts : 0);
+	ret = mtd_device_register(&flash->mtd, data ? data->parts : NULL,
+				  data ? data->nr_parts : 0);
 	if (ret)
 		return -ENODEV;
 
diff --git a/drivers/mtd/lpddr/lpddr2_nvm.c b/drivers/mtd/lpddr/lpddr2_nvm.c
index 2342277..3a60316 100644
--- a/drivers/mtd/lpddr/lpddr2_nvm.c
+++ b/drivers/mtd/lpddr/lpddr2_nvm.c
@@ -482,7 +482,7 @@ static int lpddr2_nvm_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 	/* Parse partitions and register the MTD device */
-	return mtd_device_parse_register(mtd, NULL, NULL, NULL, 0);
+	return mtd_device_register(mtd, NULL, 0);
 }
 
 /*
diff --git a/drivers/mtd/maps/impa7.c b/drivers/mtd/maps/impa7.c
index a0b8fa7..815e2db 100644
--- a/drivers/mtd/maps/impa7.c
+++ b/drivers/mtd/maps/impa7.c
@@ -88,9 +88,8 @@ static int __init init_impa7(void)
 		if (impa7_mtd[i]) {
 			impa7_mtd[i]->owner = THIS_MODULE;
 			devicesfound++;
-			mtd_device_parse_register(impa7_mtd[i], NULL, NULL,
-						  partitions,
-						  ARRAY_SIZE(partitions));
+			mtd_device_register(impa7_mtd[i], partitions,
+					    ARRAY_SIZE(partitions));
 		} else {
 			iounmap((void __iomem *)impa7_map[i].virt);
 		}
diff --git a/drivers/mtd/maps/intel_vr_nor.c b/drivers/mtd/maps/intel_vr_nor.c
index dd5d685..69503ae 100644
--- a/drivers/mtd/maps/intel_vr_nor.c
+++ b/drivers/mtd/maps/intel_vr_nor.c
@@ -71,7 +71,7 @@ static int vr_nor_init_partitions(struct vr_nor_mtd *p)
 {
 	/* register the flash bank */
 	/* partition the flash bank */
-	return mtd_device_parse_register(p->info, NULL, NULL, NULL, 0);
+	return mtd_device_register(p->info, NULL, 0);
 }
 
 static void vr_nor_destroy_mtd_setup(struct vr_nor_mtd *p)
diff --git a/drivers/mtd/maps/latch-addr-flash.c b/drivers/mtd/maps/latch-addr-flash.c
index 6dc97aa..51db24b 100644
--- a/drivers/mtd/maps/latch-addr-flash.c
+++ b/drivers/mtd/maps/latch-addr-flash.c
@@ -197,9 +197,8 @@ static int latch_addr_flash_probe(struct platform_device *dev)
 	}
 	info->mtd->dev.parent = &dev->dev;
 
-	mtd_device_parse_register(info->mtd, NULL, NULL,
-				  latch_addr_data->parts,
-				  latch_addr_data->nr_parts);
+	mtd_device_register(info->mtd, latch_addr_data->parts,
+			    latch_addr_data->nr_parts);
 	return 0;
 
 iounmap:
diff --git a/drivers/mtd/maps/rbtx4939-flash.c b/drivers/mtd/maps/rbtx4939-flash.c
index 3a06ecf..7a91533 100644
--- a/drivers/mtd/maps/rbtx4939-flash.c
+++ b/drivers/mtd/maps/rbtx4939-flash.c
@@ -97,8 +97,8 @@ static int rbtx4939_flash_probe(struct platform_device *dev)
 		goto err_out;
 	}
 	info->mtd->dev.parent = &dev->dev;
-	err = mtd_device_parse_register(info->mtd, NULL, NULL, pdata->parts,
-					pdata->nr_parts);
+	err = mtd_device_register(info->mtd, pdata->parts,
+				  pdata->nr_parts);
 
 	if (err)
 		goto err_out;
diff --git a/drivers/mtd/nand/cmx270_nand.c b/drivers/mtd/nand/cmx270_nand.c
index b01c980..05d73920 100644
--- a/drivers/mtd/nand/cmx270_nand.c
+++ b/drivers/mtd/nand/cmx270_nand.c
@@ -202,8 +202,8 @@ static int __init cmx270_init(void)
 	}
 
 	/* Register the partitions */
-	ret = mtd_device_parse_register(cmx270_nand_mtd, NULL, NULL,
-					partition_info, NUM_PARTITIONS);
+	ret = mtd_device_register(cmx270_nand_mtd, partition_info,
+				  NUM_PARTITIONS);
 	if (ret)
 		goto err_scan;
 
diff --git a/drivers/mtd/nand/cs553x_nand.c b/drivers/mtd/nand/cs553x_nand.c
index d488775..5913638 100644
--- a/drivers/mtd/nand/cs553x_nand.c
+++ b/drivers/mtd/nand/cs553x_nand.c
@@ -311,8 +311,7 @@ static int __init cs553x_init(void)
 	for (i = 0; i < NR_CS553X_CONTROLLERS; i++) {
 		if (cs553x_mtd[i]) {
 			/* If any devices registered, return success. Else the last error. */
-			mtd_device_parse_register(cs553x_mtd[i], NULL, NULL,
-						  NULL, 0);
+			mtd_device_register(cs553x_mtd[i], NULL, 0);
 			err = 0;
 		}
 	}
diff --git a/drivers/mtd/nand/davinci_nand.c b/drivers/mtd/nand/davinci_nand.c
index ccc8c43..0ef4d46 100644
--- a/drivers/mtd/nand/davinci_nand.c
+++ b/drivers/mtd/nand/davinci_nand.c
@@ -821,8 +821,8 @@ static int nand_davinci_probe(struct platform_device *pdev)
 		goto err;
 
 	if (pdata->parts)
-		ret = mtd_device_parse_register(mtd, NULL, NULL,
-					pdata->parts, pdata->nr_parts);
+		ret = mtd_device_register(mtd, pdata->parts,
+					  pdata->nr_parts);
 	else
 		ret = mtd_device_register(mtd, NULL, 0);
 	if (ret < 0)
diff --git a/drivers/mtd/nand/jz4740_nand.c b/drivers/mtd/nand/jz4740_nand.c
index 613b00a..e04597a 100644
--- a/drivers/mtd/nand/jz4740_nand.c
+++ b/drivers/mtd/nand/jz4740_nand.c
@@ -466,9 +466,8 @@ static int jz_nand_probe(struct platform_device *pdev)
 		goto err_unclaim_banks;
 	}
 
-	ret = mtd_device_parse_register(mtd, NULL, NULL,
-					pdata ? pdata->partitions : NULL,
-					pdata ? pdata->num_partitions : 0);
+	ret = mtd_device_register(mtd, pdata ? pdata->partitions : NULL,
+				  pdata ? pdata->num_partitions : 0);
 
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to add mtd device\n");
diff --git a/drivers/mtd/nand/mtk_nand.c b/drivers/mtd/nand/mtk_nand.c
index 6977da3..28ec2c0 100644
--- a/drivers/mtd/nand/mtk_nand.c
+++ b/drivers/mtd/nand/mtk_nand.c
@@ -1357,7 +1357,7 @@ static int mtk_nfc_nand_chip_init(struct device *dev, struct mtk_nfc *nfc,
 	if (ret)
 		return ret;
 
-	ret = mtd_device_parse_register(mtd, NULL, NULL, NULL, 0);
+	ret = mtd_device_register(mtd, NULL, 0);
 	if (ret) {
 		dev_err(dev, "mtd parse partition error\n");
 		nand_release(mtd);
diff --git a/drivers/mtd/nand/s3c2410.c b/drivers/mtd/nand/s3c2410.c
index 4c383ee..4b472aa 100644
--- a/drivers/mtd/nand/s3c2410.c
+++ b/drivers/mtd/nand/s3c2410.c
@@ -805,8 +805,8 @@ static int s3c2410_nand_add_partition(struct s3c2410_nand_info *info,
 
 		mtdinfo->name = set->name;
 
-		return mtd_device_parse_register(mtdinfo, NULL, NULL,
-					 set->partitions, set->nr_partitions);
+		return mtd_device_register(mtdinfo, set->partitions,
+					   set->nr_partitions);
 	}
 
 	return -ENODEV;
diff --git a/drivers/mtd/nand/txx9ndfmc.c b/drivers/mtd/nand/txx9ndfmc.c
index b567d21..fe954e2 100644
--- a/drivers/mtd/nand/txx9ndfmc.c
+++ b/drivers/mtd/nand/txx9ndfmc.c
@@ -366,7 +366,7 @@ static int __init txx9ndfmc_probe(struct platform_device *dev)
 		}
 		mtd->name = txx9_priv->mtdname;
 
-		mtd_device_parse_register(mtd, NULL, NULL, NULL, 0);
+		mtd_device_register(mtd, NULL, 0);
 		drvdata->mtds[i] = mtd;
 	}
 
diff --git a/drivers/mtd/onenand/generic.c b/drivers/mtd/onenand/generic.c
index 125da34..b7f54d4 100644
--- a/drivers/mtd/onenand/generic.c
+++ b/drivers/mtd/onenand/generic.c
@@ -68,9 +68,8 @@ static int generic_onenand_probe(struct platform_device *pdev)
 		goto out_iounmap;
 	}
 
-	err = mtd_device_parse_register(&info->mtd, NULL, NULL,
-					pdata ? pdata->parts : NULL,
-					pdata ? pdata->nr_parts : 0);
+	err = mtd_device_register(&info->mtd, pdata ? pdata->parts : NULL,
+				  pdata ? pdata->nr_parts : 0);
 
 	platform_set_drvdata(pdev, info);
 
diff --git a/drivers/mtd/onenand/samsung.c b/drivers/mtd/onenand/samsung.c
index 2e9d076..b914578 100644
--- a/drivers/mtd/onenand/samsung.c
+++ b/drivers/mtd/onenand/samsung.c
@@ -933,9 +933,8 @@ static int s3c_onenand_probe(struct platform_device *pdev)
 	if (s3c_read_reg(MEM_CFG_OFFSET) & ONENAND_SYS_CFG1_SYNC_READ)
 		dev_info(&onenand->pdev->dev, "OneNAND Sync. Burst Read enabled\n");
 
-	err = mtd_device_parse_register(mtd, NULL, NULL,
-					pdata ? pdata->parts : NULL,
-					pdata ? pdata->nr_parts : 0);
+	err = mtd_device_register(mtd, pdata ? pdata->parts : NULL,
+				  pdata ? pdata->nr_parts : 0);
 	if (err) {
 		dev_err(&pdev->dev, "failed to parse partitions and register the MTD device\n");
 		onenand_release(mtd);
diff --git a/drivers/mtd/spi-nor/intel-spi.c b/drivers/mtd/spi-nor/intel-spi.c
index 6999515..2de7854 100644
--- a/drivers/mtd/spi-nor/intel-spi.c
+++ b/drivers/mtd/spi-nor/intel-spi.c
@@ -850,7 +850,7 @@ struct intel_spi *intel_spi_probe(struct device *dev,
 	if (!ispi->writeable || !writeable)
 		ispi->nor.mtd.flags &= ~MTD_WRITEABLE;
 
-	ret = mtd_device_parse_register(&ispi->nor.mtd, NULL, NULL, &part, 1);
+	ret = mtd_device_register(&ispi->nor.mtd, &part, 1);
 	if (ret)
 		return ERR_PTR(ret);
 
-- 
2.7.4
