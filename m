Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDEF6ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91CDE204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:16:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91CDE204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388274AbeGTQEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 12:04:55 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54639 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388254AbeGTQEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 12:04:55 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9C6B6209CA; Fri, 20 Jul 2018 17:16:09 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-78-122.w90-88.abo.wanadoo.fr [90.88.20.122])
        by mail.bootlin.com (Postfix) with ESMTPSA id 139AE209D0;
        Fri, 20 Jul 2018 17:15:48 +0200 (CEST)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Wenyou Yang <wenyou.yang@microchip.com>,
        Josh Wu <rainyfeeling@outlook.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Han Xu <han.xu@nxp.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Xiaolei Li <xiaolei.li@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>, Stefan Agner <stefan@agner.ch>
Cc:     linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v4 34/35] mtd: rawnand: allocate model parameter dynamically
Date:   Fri, 20 Jul 2018 17:15:26 +0200
Message-Id: <20180720151527.16038-35-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180720151527.16038-1-miquel.raynal@bootlin.com>
References: <20180720151527.16038-1-miquel.raynal@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to the migration of all drivers to use nand_scan() and the
related nand_controller_ops, we can now allocate data during the
detection phase. Let's do it first for the NAND model parameter which
is allocated in nand_detect().

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/nand_base.c | 52 +++++++++++++++++++++++++++++++---------
 include/linux/mtd/rawnand.h      |  2 +-
 2 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index da99232702a4..8645f655e5b0 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -5225,8 +5225,11 @@ static int nand_flash_detect_onfi(struct nand_chip *chip)
 
 	sanitize_string(p->manufacturer, sizeof(p->manufacturer));
 	sanitize_string(p->model, sizeof(p->model));
-	strncpy(chip->parameters.model, p->model,
-		sizeof(chip->parameters.model) - 1);
+	chip->parameters.model = kstrdup(p->model, GFP_KERNEL);
+	if (!chip->parameters.model) {
+		ret = -ENOMEM;
+		goto free_onfi_param_page;
+	}
 
 	mtd->writesize = le32_to_cpu(p->byte_per_page);
 
@@ -5356,8 +5359,11 @@ static int nand_flash_detect_jedec(struct nand_chip *chip)
 
 	sanitize_string(p->manufacturer, sizeof(p->manufacturer));
 	sanitize_string(p->model, sizeof(p->model));
-	strncpy(chip->parameters.model, p->model,
-		sizeof(chip->parameters.model) - 1);
+	chip->parameters.model = kstrdup(p->model, GFP_KERNEL);
+	if (!chip->parameters.model) {
+		ret = -ENOMEM;
+		goto free_jedec_param_page;
+	}
 
 	mtd->writesize = le32_to_cpu(p->byte_per_page);
 
@@ -5546,8 +5552,9 @@ static bool find_full_id_nand(struct nand_chip *chip,
 		chip->onfi_timing_mode_default =
 					type->onfi_timing_mode_default;
 
-		strncpy(chip->parameters.model, type->name,
-			sizeof(chip->parameters.model) - 1);
+		chip->parameters.model = kstrdup(type->name, GFP_KERNEL);
+		if (!chip->parameters.model)
+			return false;
 
 		return true;
 	}
@@ -5706,8 +5713,9 @@ static int nand_detect(struct nand_chip *chip, struct nand_flash_dev *type)
 	if (!type->name)
 		return -ENODEV;
 
-	strncpy(chip->parameters.model, type->name,
-		sizeof(chip->parameters.model) - 1);
+	chip->parameters.model = kstrdup(type->name, GFP_KERNEL);
+	if (!chip->parameters.model)
+		return -ENOMEM;
 
 	chip->chipsize = (uint64_t)type->chipsize << 20;
 
@@ -5737,7 +5745,9 @@ static int nand_detect(struct nand_chip *chip, struct nand_flash_dev *type)
 			mtd->name);
 		pr_warn("bus width %d instead of %d bits\n", busw ? 16 : 8,
 			(chip->options & NAND_BUSWIDTH_16) ? 16 : 8);
-		return -EINVAL;
+		ret = -EINVAL;
+
+		goto free_detect_allocation;
 	}
 
 	nand_decode_bbm_options(chip);
@@ -5774,6 +5784,11 @@ static int nand_detect(struct nand_chip *chip, struct nand_flash_dev *type)
 		(int)(chip->chipsize >> 20), nand_is_slc(chip) ? "SLC" : "MLC",
 		mtd->erasesize >> 10, mtd->writesize, mtd->oobsize);
 	return 0;
+
+free_detect_allocation:
+	kfree(chip->parameters.model);
+
+	return ret;
 }
 
 static const char * const nand_ecc_modes[] = {
@@ -6021,6 +6036,11 @@ static int nand_scan_ident(struct mtd_info *mtd, int maxchips,
 	return 0;
 }
 
+static void nand_scan_ident_cleanup(struct nand_chip *chip)
+{
+	kfree(chip->parameters.model);
+}
+
 static int nand_set_ecc_soft_ops(struct mtd_info *mtd)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
@@ -6764,11 +6784,18 @@ int nand_scan_with_ids(struct mtd_info *mtd, int maxchips,
 
 	ret = nand_attach(chip);
 	if (ret)
-		return ret;
+		goto cleanup_ident;
 
 	ret = nand_scan_tail(mtd);
 	if (ret)
-		nand_detach(chip);
+		goto detach_chip;
+
+	return 0;
+
+detach_chip:
+	nand_detach(chip);
+cleanup_ident:
+	nand_scan_ident_cleanup(chip);
 
 	return ret;
 }
@@ -6800,6 +6827,9 @@ void nand_cleanup(struct nand_chip *chip)
 
 	/* Free controller specific allocations after chip identification */
 	nand_detach(chip);
+
+	/* Free identification phase allocations */
+	nand_scan_ident_cleanup(chip);
 }
 
 EXPORT_SYMBOL_GPL(nand_cleanup);
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index a928771a7ae4..5723d940a47d 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -482,7 +482,7 @@ struct onfi_params {
  */
 struct nand_parameters {
 	/* Generic parameters */
-	char model[100];
+	const char *model;
 	bool supports_set_get_features;
 	DECLARE_BITMAP(set_feature_list, ONFI_FEATURE_NUMBER);
 	DECLARE_BITMAP(get_feature_list, ONFI_FEATURE_NUMBER);
-- 
2.14.1

