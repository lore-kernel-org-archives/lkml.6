Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D395DECDFBD
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89AB620684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:02:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89AB620684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731996AbeGSXrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 19:47:13 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54624 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730456AbeGSXrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 19:47:13 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id ACB722093A; Fri, 20 Jul 2018 01:01:55 +0200 (CEST)
Received: from localhost.localdomain (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id D83E6209CF;
        Fri, 20 Jul 2018 01:01:26 +0200 (CEST)
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
Subject: [PATCH v3 32/33] mtd: rawnand: do not export nand_scan_[ident|tail]() anymore
Date:   Fri, 20 Jul 2018 01:00:25 +0200
Message-Id: <20180719230026.8741-33-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180719230026.8741-1-miquel.raynal@bootlin.com>
References: <20180719230026.8741-1-miquel.raynal@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both nand_scan_ident() and nand_scan_tail() helpers used to be called
directly from controller drivers that needed to tweak some ECC-related
parameters before nand_scan_tail(). This separation prevented dynamic
allocations during the phase of NAND identification, which was
inconvenient.

All controller drivers have been moved to use nand_scan(), in
conjunction with the chip->ecc.[attach|detach]_chip() hooks that
actually do the required tweaking sequence between both ident/tail
calls, allowing programmers to use dynamic allocation as they need all
across the scanning sequence.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/nand_base.c | 60 +++++++++++++++++++++++++++++++---------
 include/linux/mtd/rawnand.h      | 11 ++------
 2 files changed, 50 insertions(+), 21 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index dea41fa25be1..dfee2556a8a8 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -5151,6 +5151,7 @@ static int nand_flash_detect_onfi(struct nand_chip *chip)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct nand_onfi_params *p;
+	char *model;
 	char id[4];
 	int i, ret, val;
 
@@ -5225,8 +5226,15 @@ static int nand_flash_detect_onfi(struct nand_chip *chip)
 
 	sanitize_string(p->manufacturer, sizeof(p->manufacturer));
 	sanitize_string(p->model, sizeof(p->model));
-	strncpy(chip->parameters.model, p->model,
-		sizeof(chip->parameters.model) - 1);
+	model = kmemdup(p->model, sizeof(p->model), GFP_KERNEL);
+	if (!model) {
+		ret = -ENOMEM;
+		goto free_onfi_param_page;
+	}
+
+	chip->parameters.model = model;
+	if (!mtd->name)
+		mtd->name = chip->parameters.model;
 
 	mtd->writesize = le32_to_cpu(p->byte_per_page);
 
@@ -5306,6 +5314,7 @@ static int nand_flash_detect_jedec(struct nand_chip *chip)
 	struct nand_jedec_params *p;
 	struct jedec_ecc_info *ecc;
 	int jedec_version = 0;
+	char *model;
 	char id[5];
 	int i, val, ret;
 
@@ -5356,8 +5365,16 @@ static int nand_flash_detect_jedec(struct nand_chip *chip)
 
 	sanitize_string(p->manufacturer, sizeof(p->manufacturer));
 	sanitize_string(p->model, sizeof(p->model));
-	strncpy(chip->parameters.model, p->model,
-		sizeof(chip->parameters.model) - 1);
+	model = kzalloc(sizeof(p->model), GFP_KERNEL);
+	if (!p) {
+		ret = -ENOMEM;
+		goto free_jedec_param_page;
+	}
+
+	strncpy(model, p->model, sizeof(model) - 1);
+	chip->parameters.model = model;
+	if (!mtd->name)
+		mtd->name = chip->parameters.model;
 
 	mtd->writesize = le32_to_cpu(p->byte_per_page);
 
@@ -5924,7 +5941,7 @@ static int nand_dt_init(struct nand_chip *chip)
 }
 
 /**
- * nand_scan_ident - [NAND Interface] Scan for the NAND device
+ * nand_scan_ident - Scan for the NAND device
  * @mtd: MTD device structure
  * @maxchips: number of chips to scan for
  * @table: alternative NAND ID table
@@ -5932,9 +5949,13 @@ static int nand_dt_init(struct nand_chip *chip)
  * This is the first phase of the normal nand_scan() function. It reads the
  * flash ID and sets up MTD fields accordingly.
  *
+ * This helper used to be called directly from controller drivers that needed
+ * to tweak some ECC-related parameters before nand_scan_tail(). This separation
+ * prevented dynamic allocations during this phase which was unconvenient and
+ * as been banned for the benefit of the ->init_ecc()/cleanup_ecc() hooks.
  */
-int nand_scan_ident(struct mtd_info *mtd, int maxchips,
-		    struct nand_flash_dev *table)
+static int nand_scan_ident(struct mtd_info *mtd, int maxchips,
+			   struct nand_flash_dev *table)
 {
 	int i, nand_maf_id, nand_dev_id;
 	struct nand_chip *chip = mtd_to_nand(mtd);
@@ -6008,7 +6029,11 @@ int nand_scan_ident(struct mtd_info *mtd, int maxchips,
 
 	return 0;
 }
-EXPORT_SYMBOL(nand_scan_ident);
+
+static void nand_scan_ident_cleanup(struct nand_chip *chip)
+{
+	kfree(chip->parameters.model);
+}
 
 static int nand_set_ecc_soft_ops(struct mtd_info *mtd)
 {
@@ -6385,14 +6410,14 @@ static bool nand_ecc_strength_good(struct mtd_info *mtd)
 }
 
 /**
- * nand_scan_tail - [NAND Interface] Scan for the NAND device
+ * nand_scan_tail - Scan for the NAND device
  * @mtd: MTD device structure
  *
  * This is the second phase of the normal nand_scan() function. It fills out
  * all the uninitialized function pointers with the defaults and scans for a
  * bad block table if appropriate.
  */
-int nand_scan_tail(struct mtd_info *mtd)
+static int nand_scan_tail(struct mtd_info *mtd)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
@@ -6716,7 +6741,6 @@ int nand_scan_tail(struct mtd_info *mtd)
 
 	return ret;
 }
-EXPORT_SYMBOL(nand_scan_tail);
 
 static int nand_attach(struct nand_chip *chip)
 {
@@ -6754,11 +6778,18 @@ int nand_scan_with_ids(struct mtd_info *mtd, int maxchips,
 
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
@@ -6790,6 +6821,9 @@ void nand_cleanup(struct nand_chip *chip)
 
 	/* Free controller specific allocations after chip identification */
 	nand_detach(chip);
+
+	/* Free identification phase allocations */
+	nand_scan_ident_cleanup(chip);
 }
 
 EXPORT_SYMBOL_GPL(nand_cleanup);
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index a20c78e25878..5723d940a47d 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -36,14 +36,9 @@ static inline int nand_scan(struct mtd_info *mtd, int max_chips)
 }
 
 /*
- * Separate phases of nand_scan(), allowing board driver to intervene
- * and override command or ECC setup according to flash type.
+ * Unregister the MTD device and free resources held by the NAND device, must be
+ * called on error after a successful nand_scan().
  */
-int nand_scan_ident(struct mtd_info *mtd, int max_chips,
-			   struct nand_flash_dev *table);
-int nand_scan_tail(struct mtd_info *mtd);
-
-/* Unregister the MTD device and free resources held by the NAND device */
 void nand_release(struct mtd_info *mtd);
 
 /* Internal helper for board drivers which need to override command function */
@@ -487,7 +482,7 @@ struct onfi_params {
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

