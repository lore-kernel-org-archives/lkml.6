Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB02C31D63
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58531217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="BZDt5m8Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbfAUHLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:11:01 -0500
Received: from condef-06.nifty.com ([202.248.20.71]:33850 "EHLO
        condef-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfAUHLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:11:00 -0500
Received: from conuserg-07.nifty.com ([10.126.8.70])by condef-06.nifty.com with ESMTP id x0L6XASA002631
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 15:33:10 +0900
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x0L6WCPC003098;
        Mon, 21 Jan 2019 15:32:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x0L6WCPC003098
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1548052333;
        bh=qrh/ZcVeEBRczMZx/DNnPsCU/3ppDsvTOZXlUv3uS90=;
        h=From:To:Cc:Subject:Date:From;
        b=BZDt5m8ZX+oGTcNyNLj6dly8ZyqgwpbvGocWGu5X8myzZosRQGKmXE5hp+6CFcyKG
         sjovxM/VtDF+Pqe3U4dDOQ7JDYm/cKuuoLElr4hb36/B3w2Rn1avvFPB8jesJzrEbU
         enEuwao6qwfXcErDo18UjbMFYRaCQVQQ8yHVsb7S4yIkJ5RvcRFRKg5fj6oKNoVnVg
         2CXMYsZuKTCMMJlBJRKFqZTlXMZj/2bW8AmABLpwuui0EwyEa5DsEbiYZLVPu7iVAf
         xTWhyFyiTdx6DANV8NzwxZHAnnK+4VVG5qwIk+TjPcfA3SNu275K658A7MzyNA7xqT
         j/BgSva9Sjv+w==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Boris Brezillon <bbrezillon@kernel.org>
Subject: [PATCH v2] mtd: rawnand: remove ->legacy.erase and single_erase()
Date:   Mon, 21 Jan 2019 15:32:07 +0900
Message-Id: <1548052327-26483-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the last user of this hook, denali.c, stopped using it,
we can remove the erase hook from nand_legacy.

I squashed single_erase() because only the difference between
single_erase() and nand_erase_op() is the number of bit shifts.

The status/ret conversion in nand_erase_nand() is unneeded since
commit eb94555e9e97 ("mtd: nand: use usual return values for the
->erase() hook"). Cleaned it up now.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

This depends on the denali patch:
http://patchwork.ozlabs.org/patch/1028264/


Changes in v2:
  - I noticed the masking by chip->pagemask is still needed

 drivers/mtd/nand/raw/nand_base.c | 31 ++++---------------------------
 include/linux/mtd/rawnand.h      |  2 --
 2 files changed, 4 insertions(+), 29 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index cca4b24..7ea3f10 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -4155,23 +4155,6 @@ static int nand_write_oob(struct mtd_info *mtd, loff_t to,
 }
 
 /**
- * single_erase - [GENERIC] NAND standard block erase command function
- * @chip: NAND chip object
- * @page: the page address of the block which will be erased
- *
- * Standard erase command for NAND chips. Returns NAND status.
- */
-static int single_erase(struct nand_chip *chip, int page)
-{
-	unsigned int eraseblock;
-
-	/* Send commands to erase a block */
-	eraseblock = page >> (chip->phys_erase_shift - chip->page_shift);
-
-	return nand_erase_op(chip, eraseblock);
-}
-
-/**
  * nand_erase - [MTD Interface] erase block(s)
  * @mtd: MTD device structure
  * @instr: erase instruction
@@ -4194,7 +4177,7 @@ static int nand_erase(struct mtd_info *mtd, struct erase_info *instr)
 int nand_erase_nand(struct nand_chip *chip, struct erase_info *instr,
 		    int allowbbt)
 {
-	int page, status, pages_per_block, ret, chipnr;
+	int page, pages_per_block, ret, chipnr;
 	loff_t len;
 
 	pr_debug("%s: start = 0x%012llx, len = %llu\n",
@@ -4246,17 +4229,11 @@ int nand_erase_nand(struct nand_chip *chip, struct erase_info *instr,
 		    (page + pages_per_block))
 			chip->pagebuf = -1;
 
-		if (chip->legacy.erase)
-			status = chip->legacy.erase(chip,
-						    page & chip->pagemask);
-		else
-			status = single_erase(chip, page & chip->pagemask);
-
-		/* See if block erase succeeded */
-		if (status) {
+		ret = nand_erase_op(chip, (page & chip->pagemask) >>
+				    (chip->phys_erase_shift - chip->page_shift));
+		if (ret) {
 			pr_debug("%s: failed erase, page 0x%08x\n",
 					__func__, page);
-			ret = -EIO;
 			instr->fail_addr =
 				((loff_t)page << chip->page_shift);
 			goto erase_exit;
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 33e240a..5e37534 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -936,7 +936,6 @@ static inline void nand_controller_init(struct nand_controller *nfc)
  * @waitfunc: hardware specific function for wait on ready.
  * @block_bad: check if a block is bad, using OOB markers
  * @block_markbad: mark a block bad
- * @erase: erase function
  * @set_features: set the NAND chip features
  * @get_features: get the NAND chip features
  * @chip_delay: chip dependent delay for transferring data from array to read
@@ -962,7 +961,6 @@ struct nand_legacy {
 	int (*waitfunc)(struct nand_chip *chip);
 	int (*block_bad)(struct nand_chip *chip, loff_t ofs);
 	int (*block_markbad)(struct nand_chip *chip, loff_t ofs);
-	int (*erase)(struct nand_chip *chip, int page);
 	int (*set_features)(struct nand_chip *chip, int feature_addr,
 			    u8 *subfeature_para);
 	int (*get_features)(struct nand_chip *chip, int feature_addr,
-- 
2.7.4

