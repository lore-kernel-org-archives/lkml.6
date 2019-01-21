Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EE9C31D63
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B3220880
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="pqr1ZMJQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbfAUHNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:13:37 -0500
Received: from condef-08.nifty.com ([202.248.20.73]:37362 "EHLO
        condef-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbfAUHNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:13:34 -0500
Received: from conuserg-08.nifty.com ([10.126.8.71])by condef-08.nifty.com with ESMTP id x0L6Q2J1003802
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 15:26:03 +0900
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id x0L6OouF008453;
        Mon, 21 Jan 2019 15:24:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com x0L6OouF008453
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1548051891;
        bh=3LVT/OIOW3XpkTEn5pOcQFDy+pugI4n0eFXqWzDArxM=;
        h=From:To:Cc:Subject:Date:From;
        b=pqr1ZMJQPNp+jAzHuRd71HwbVpEvindzk6ns5XzeREQ4g6qcsNTOjJ8RgCQREdhgG
         3/1iO8MBGfrxEnHJBsD6CHCa+IZdZt4HfAflVvBvGZk3lp3nPqGxBG+CfxEo3aFszf
         KjXHHa5Y6iEFxhQ/rQqPNjBISHBTaJEEZ2Odu+SHAnAsTSijxkUD5yjMDAnJti/J2U
         eqZX0m/EqiMk1k4nyQM2g6c80JW8FDK0Tz9ddouM91mwMVJTvJ0sV7HPawImNPmgfN
         VhXFypo5+GMVWW6bRVEG8mgEvkBHeNb03LKuExfCpMcni+0k1e9jkAdN8pULV0Qeyo
         zZxLdQ1zIRkCQ==
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
Subject: [PATCH] mtd: rawnand: remove ->legacy.erase and single_erase()
Date:   Mon, 21 Jan 2019 15:24:43 +0900
Message-Id: <1548051883-8309-1-git-send-email-yamada.masahiro@socionext.com>
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


 drivers/mtd/nand/raw/nand_base.c | 32 +++++---------------------------
 include/linux/mtd/rawnand.h      |  2 --
 2 files changed, 5 insertions(+), 29 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index cca4b24..690900b 100644
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
@@ -4246,17 +4229,12 @@ int nand_erase_nand(struct nand_chip *chip, struct erase_info *instr,
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
+		ret = nand_erase_op(chip,
+				    page >> (chip->phys_erase_shift -
+					     chip->page_shift));
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

