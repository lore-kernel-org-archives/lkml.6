Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95559C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 592DE2184A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="F13MjZmx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbfBLHOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 02:14:41 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:37568 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfBLHOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 02:14:36 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x1C7DPdU019269;
        Tue, 12 Feb 2019 16:13:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x1C7DPdU019269
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1549955611;
        bh=0G9g6BzHFdBZ8N7j/ak6EoadsuEhODUjvRjxPSQclEk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F13MjZmxcDB0wIv0YOF6QVzKcYPLcLW3dKltOEAEG5zjRg+4uGCw3oOLACge8hb2s
         EJBlzD0lZ3ly4JSOiYsryNak9NH9uL1RlTO/U3sEDj854668OUAUGEWBZ/SBLZMO4F
         Cbl+JMX20vHpeqjUX4jW/sZ6We+NpU2h8z6slLQQ59upMd0aEZX7ILHbufPmrAD0ky
         vphw5cHQGCK7xycABUOeBP6gSYzKPBBVpoQudLjcPJYTu5N/LIzhOl0O8VdNEUvtji
         BPW68xUOmk57AayVHOTlkxUGNHNd+YFcMQgcs0nE00iyQV8PzzTDmvh/tFaXmv/Qq9
         /FSewYcWg3X5g==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH v2 06/10] mtd: rawnand: denali: use bool type instead of int where appropriate
Date:   Tue, 12 Feb 2019 16:12:58 +0900
Message-Id: <1549955582-30346-7-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549955582-30346-1-git-send-email-yamada.masahiro@socionext.com>
References: <1549955582-30346-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use 'bool' type for the following boolean parameters.

 - write (write or read?)
 - raw (raw access or not?)
 - dma_avail (DMA engine available or not?)

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Use bool for dma_avail as well

 drivers/mtd/nand/raw/denali.c | 27 ++++++++++++++-------------
 drivers/mtd/nand/raw/denali.h |  4 ++--
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
index 7050b1f..f539731 100644
--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -360,7 +360,7 @@ static int denali_sw_ecc_fixup(struct nand_chip *chip,
 }
 
 static void denali_setup_dma64(struct denali_nand_info *denali,
-			       dma_addr_t dma_addr, int page, int write)
+			       dma_addr_t dma_addr, int page, bool write)
 {
 	uint32_t mode;
 	const int page_count = 1;
@@ -374,7 +374,8 @@ static void denali_setup_dma64(struct denali_nand_info *denali,
 	 *    burst len = 64 bytes, the number of pages
 	 */
 	denali->host_write(denali, mode,
-			   0x01002000 | (64 << 16) | (write << 8) | page_count);
+			   0x01002000 | (64 << 16) |
+			   (write ? BIT(8) : 0) | page_count);
 
 	/* 2. set memory low address */
 	denali->host_write(denali, mode, lower_32_bits(dma_addr));
@@ -384,7 +385,7 @@ static void denali_setup_dma64(struct denali_nand_info *denali,
 }
 
 static void denali_setup_dma32(struct denali_nand_info *denali,
-			       dma_addr_t dma_addr, int page, int write)
+			       dma_addr_t dma_addr, int page, bool write)
 {
 	uint32_t mode;
 	const int page_count = 1;
@@ -395,7 +396,7 @@ static void denali_setup_dma32(struct denali_nand_info *denali,
 
 	/* 1. setup transfer type and # of pages */
 	denali->host_write(denali, mode | page,
-			   0x2000 | (write << 8) | page_count);
+			   0x2000 | (write ? BIT(8) : 0) | page_count);
 
 	/* 2. set memory high address bits 23:8 */
 	denali->host_write(denali, mode | ((dma_addr >> 16) << 8), 0x2200);
@@ -457,7 +458,7 @@ static int denali_pio_write(struct denali_nand_info *denali, const u32 *buf,
 }
 
 static int denali_pio_xfer(struct denali_nand_info *denali, void *buf,
-			   size_t size, int page, int write)
+			   size_t size, int page, bool write)
 {
 	if (write)
 		return denali_pio_write(denali, buf, size, page);
@@ -466,7 +467,7 @@ static int denali_pio_xfer(struct denali_nand_info *denali, void *buf,
 }
 
 static int denali_dma_xfer(struct denali_nand_info *denali, void *buf,
-			   size_t size, int page, int write)
+			   size_t size, int page, bool write)
 {
 	dma_addr_t dma_addr;
 	uint32_t irq_mask, irq_status, ecc_err_mask;
@@ -523,7 +524,7 @@ static int denali_dma_xfer(struct denali_nand_info *denali, void *buf,
 }
 
 static int denali_data_xfer(struct nand_chip *chip, void *buf, size_t size,
-			    int page, int raw, int write)
+			    int page, bool raw, bool write)
 {
 	struct denali_nand_info *denali = to_denali(chip);
 
@@ -648,7 +649,7 @@ static int denali_read_page_raw(struct nand_chip *chip, uint8_t *buf,
 	if (!buf)
 		return -EINVAL;
 
-	ret = denali_data_xfer(chip, tmp_buf, size, page, 1, 0);
+	ret = denali_data_xfer(chip, tmp_buf, size, page, true, false);
 	if (ret)
 		return ret;
 
@@ -704,7 +705,7 @@ static int denali_write_page_raw(struct nand_chip *chip, const uint8_t *buf,
 			return ret;
 	}
 
-	return denali_data_xfer(chip, tmp_buf, size, page, 1, 1);
+	return denali_data_xfer(chip, tmp_buf, size, page, true, true);
 }
 
 static int denali_change_read_column_op(void *buf, unsigned int offset,
@@ -756,7 +757,7 @@ static int denali_read_page(struct nand_chip *chip, uint8_t *buf,
 	int stat = 0;
 	int ret;
 
-	ret = denali_data_xfer(chip, buf, mtd->writesize, page, 0, 0);
+	ret = denali_data_xfer(chip, buf, mtd->writesize, page, false, false);
 	if (ret && ret != -EBADMSG)
 		return ret;
 
@@ -786,7 +787,7 @@ static int denali_write_page(struct nand_chip *chip, const uint8_t *buf,
 	struct mtd_info *mtd = nand_to_mtd(chip);
 
 	return denali_data_xfer(chip, (void *)buf, mtd->writesize, page,
-				0, 1);
+				false, true);
 }
 
 static int denali_setup_data_interface(struct nand_chip *chip, int chipnr,
@@ -1042,7 +1043,7 @@ static int denali_attach_chip(struct nand_chip *chip)
 	int ret;
 
 	if (ioread32(denali->reg + FEATURES) & FEATURES__DMA)
-		denali->dma_avail = 1;
+		denali->dma_avail = true;
 
 	if (denali->dma_avail) {
 		int dma_bit = denali->caps & DENALI_CAP_DMA_64BIT ? 64 : 32;
@@ -1051,7 +1052,7 @@ static int denali_attach_chip(struct nand_chip *chip)
 		if (ret) {
 			dev_info(denali->dev,
 				 "Failed to set DMA mask. Disabling DMA.\n");
-			denali->dma_avail = 0;
+			denali->dma_avail = false;
 		}
 	}
 
diff --git a/drivers/mtd/nand/raw/denali.h b/drivers/mtd/nand/raw/denali.h
index c8c2620..8552b3f 100644
--- a/drivers/mtd/nand/raw/denali.h
+++ b/drivers/mtd/nand/raw/denali.h
@@ -304,7 +304,7 @@ struct denali_nand_info {
 	u32 irq_status;			/* interrupts that have happened */
 	int irq;
 	void *buf;			/* for syndrome layout conversion */
-	int dma_avail;			/* can support DMA? */
+	bool dma_avail;			/* can support DMA? */
 	int devs_per_cs;		/* devices connected in parallel */
 	int oob_skip_bytes;		/* number of bytes reserved for BBM */
 	int max_banks;
@@ -314,7 +314,7 @@ struct denali_nand_info {
 	u32 (*host_read)(struct denali_nand_info *denali, u32 addr);
 	void (*host_write)(struct denali_nand_info *denali, u32 addr, u32 data);
 	void (*setup_dma)(struct denali_nand_info *denali, dma_addr_t dma_addr,
-			  int page, int write);
+			  int page, bool write);
 };
 
 #define DENALI_CAP_HW_ECC_FIXUP			BIT(0)
-- 
2.7.4

