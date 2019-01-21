Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7243BC31D63
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D461217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="YruTm/4N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfAUHLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:11:35 -0500
Received: from condef-07.nifty.com ([202.248.20.72]:49611 "EHLO
        condef-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfAUHLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:11:34 -0500
Received: from conuserg-07.nifty.com ([10.126.8.70])by condef-07.nifty.com with ESMTP id x0L4rHHu014595
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 13:53:23 +0900
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x0L4qBI2028292;
        Mon, 21 Jan 2019 13:52:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x0L4qBI2028292
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1548046332;
        bh=hNK5faw4hFSOBOK912B0tZ/yjjxR6feiPy2LU0UJiOE=;
        h=From:To:Cc:Subject:Date:From;
        b=YruTm/4N0JaW1TJ5H8MfRo+phnImsq6kZw3VDa9/YmoRBEo0Zsq5qmZegsFCO+ujE
         Qgepzvu2Qbj9D9pXR3jnjp41C9O+1ppQhq6u+tAD+M11JRcGvgBDU7ROdxWoFA966Y
         p+dPFuIn7QAeB31VGkgT9/ywm/loqX3SZnH3Qtn8fw5TKjIWsm5IPTQ8Pxsn2q2CYi
         i4H5FtujPIFalAqszEEOucZncKPdOQ/A5KHkgAnyM0b4YLfbliuKKxMSGYqIFRGoCH
         +XhwoeqStvbubOPa3F1HbpdaZzPteEGJiLrowdmp3/5hcR3ij/nFB6eMSh5I1uAYws
         6Y9NCsIVc2SZw==
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
Subject: [PATCH] mtd: rawnand: denali: remove ->erase hook
Date:   Mon, 21 Jan 2019 13:52:06 +0900
Message-Id: <1548046326-26776-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f9ebd1bb4103 ("mtd: rawnand: Deprecate ->erase()") discouraged
the use of this hook, so I am happy to follow the suggestion.

Although the Denali IP provides a special MAP10 command for erasing,
using it would not buy us much. The Denali IP actually works with the
generic erasing by single_erase() + ->cmdfunc hook (nand_command_lp)
+ ->cmd_ctrl hook (denali_cmd_ctrl).

This method is also deprecated, but denali_erase() can go away
irrespective of ->exec_op conversion.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mtd/nand/raw/denali.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
index 6e8edc9..21320b1 100644
--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -37,9 +37,6 @@
 #define DENALI_MAP11_ADDR	((DENALI_MAP11) | 1)	/* address cycle */
 #define DENALI_MAP11_DATA	((DENALI_MAP11) | 2)	/* data cycle */
 
-/* MAP10 commands */
-#define DENALI_ERASE		0x01
-
 #define DENALI_BANK(denali)	((denali)->active_bank << 24)
 
 #define DENALI_INVALID_BANK	-1
@@ -903,23 +900,6 @@ static int denali_waitfunc(struct nand_chip *chip)
 	return irq_status & INTR__INT_ACT ? 0 : NAND_STATUS_FAIL;
 }
 
-static int denali_erase(struct nand_chip *chip, int page)
-{
-	struct denali_nand_info *denali = mtd_to_denali(nand_to_mtd(chip));
-	uint32_t irq_status;
-
-	denali_reset_irq(denali);
-
-	denali->host_write(denali, DENALI_MAP10 | DENALI_BANK(denali) | page,
-			   DENALI_ERASE);
-
-	/* wait for erase to complete or failure to occur */
-	irq_status = denali_wait_for_irq(denali,
-					 INTR__ERASE_COMP | INTR__ERASE_FAIL);
-
-	return irq_status & INTR__ERASE_COMP ? 0 : -EIO;
-}
-
 static int denali_setup_data_interface(struct nand_chip *chip, int chipnr,
 				       const struct nand_data_interface *conf)
 {
@@ -1244,7 +1224,6 @@ static int denali_attach_chip(struct nand_chip *chip)
 	chip->ecc.write_page_raw = denali_write_page_raw;
 	chip->ecc.read_oob = denali_read_oob;
 	chip->ecc.write_oob = denali_write_oob;
-	chip->legacy.erase = denali_erase;
 
 	ret = denali_multidev_fixup(denali);
 	if (ret)
-- 
2.7.4

