Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB9DECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01630204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:16:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01630204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388290AbeGTQE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 12:04:56 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54628 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388058AbeGTQEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 12:04:55 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 99C4D20A9A; Fri, 20 Jul 2018 17:16:09 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-78-122.w90-88.abo.wanadoo.fr [90.88.20.122])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7C4D9209CA;
        Fri, 20 Jul 2018 17:15:47 +0200 (CEST)
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
Subject: [PATCH v4 33/35] mtd: rawnand: do not export nand_scan_[ident|tail]() anymore
Date:   Fri, 20 Jul 2018 17:15:25 +0200
Message-Id: <20180720151527.16038-34-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180720151527.16038-1-miquel.raynal@bootlin.com>
References: <20180720151527.16038-1-miquel.raynal@bootlin.com>
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

Declare nand_scan_[ident|tail]() statically now.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/nand_base.c | 16 +++++++++-------
 include/linux/mtd/rawnand.h      |  9 ++-------
 2 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index e7f135c100c2..da99232702a4 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -5924,7 +5924,7 @@ static int nand_dt_init(struct nand_chip *chip)
 }
 
 /**
- * nand_scan_ident - [NAND Interface] Scan for the NAND device
+ * nand_scan_ident - Scan for the NAND device
  * @mtd: MTD device structure
  * @maxchips: number of chips to scan for, returns immediately if 0
  * @table: alternative NAND ID table
@@ -5932,9 +5932,13 @@ static int nand_dt_init(struct nand_chip *chip)
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
@@ -6016,7 +6020,6 @@ int nand_scan_ident(struct mtd_info *mtd, int maxchips,
 
 	return 0;
 }
-EXPORT_SYMBOL(nand_scan_ident);
 
 static int nand_set_ecc_soft_ops(struct mtd_info *mtd)
 {
@@ -6393,14 +6396,14 @@ static bool nand_ecc_strength_good(struct mtd_info *mtd)
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
@@ -6724,7 +6727,6 @@ int nand_scan_tail(struct mtd_info *mtd)
 
 	return ret;
 }
-EXPORT_SYMBOL(nand_scan_tail);
 
 static int nand_attach(struct nand_chip *chip)
 {
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index a20c78e25878..a928771a7ae4 100644
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
-- 
2.14.1

