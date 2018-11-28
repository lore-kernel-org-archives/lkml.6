Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8EDAC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 05:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 707182081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 05:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="P00Y/blW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 707182081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbeK1Q3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 11:29:55 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:19159 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbeK1Q3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 11:29:55 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id wAS5RnF5025853;
        Wed, 28 Nov 2018 14:27:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com wAS5RnF5025853
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1543382872;
        bh=/RxbxpNU/Lt1yZysKIu6X8rRWnyhVqc9ghtqFZ+IFik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P00Y/blWCmUgBgzQp0Rx1kGot6VVVMgHlAPy7fRXUU00sfohEY85HZdFMIQNU3d4D
         j+Jy7KNaPKEVBuBDxuytiN4ReqhX//cFNoenbE+9YiB8tp9RJA2nkA2DYgKf+sQ3Km
         ha6dx+T5dHrhes87t/vo/qbFCTeQDmRr1sp9aqDw1HoCL/efqFq/5N1B7Ignzc5uPL
         VV3CVk4Pr/ocWACqOM2ARVGPIu198D9Qu7V0FRYQkOUHTEuCkFvKzcyCMli9GpyARi
         wEWz4kAUbQaouuWXsNYcx1z8su91SxzXLsZP1Uur8HExzMeCTqCezjaHUANnrv9SQI
         l/1X+pDT0KmFA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH v2 2/2] mtd: rawnand: denali: remove denali_reset_banks()
Date:   Wed, 28 Nov 2018 14:27:37 +0900
Message-Id: <1543382857-30827-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543382857-30827-1-git-send-email-yamada.masahiro@socionext.com>
References: <1543382857-30827-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In nand_scan_ident(), the controller driver resets every NAND chip.
This is done by sending NAND_CMD_RESET. The Denali IP provides
another way to do the equivalent thing; if a bit is set in the
DEVICE_RESET register, the controller sends the RESET command to
the corresponding device. denali_reset_banks() uses it to reset
all devices beforehand.

This redundant reset sequence was needed to know the actual number
of chips before calling nand_scan_ident(); if DEVICE_RESET fails,
there is no chip in that chip select. Then, denali_reset_banks()
sets denali->max_banks to the number of detected chips.

As commit f486287d2372 ("mtd: nand: denali: fix bank reset function
to detect the number of chips") explained, nand_scan_ident() issued
Set Features (0xEF) command to all CS lines, some of which may not be
connected with a chip. Then, the driver would wait for R/B# response,
which never happens.

This problem was solved by commit 107b7d6a7ad4 ("mtd: rawnand: avoid
setting again the timings to mode 0 after a reset"). In the current
code, nand_setup_data_interface() is called from nand_scan_tail(),
which is invoked after the chip detection.

Now, we can really remove the redundant denali_nand_banks() by simply
passing the maximum number of chip selects supported by this IP
(typically 4 or 8) to nand_scan(). Let's leave all the chip detection
process to nand_scan_ident().

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2: None

 drivers/mtd/nand/raw/denali.c | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
index ead6e60..2302010 100644
--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -1045,29 +1045,6 @@ static int denali_setup_data_interface(struct nand_chip *chip, int chipnr,
 	return 0;
 }
 
-static void denali_reset_banks(struct denali_nand_info *denali)
-{
-	u32 irq_status;
-	int i;
-
-	for (i = 0; i < denali->max_banks; i++) {
-		denali->active_bank = i;
-
-		denali_reset_irq(denali);
-
-		iowrite32(DEVICE_RESET__BANK(i),
-			  denali->reg + DEVICE_RESET);
-
-		irq_status = denali_wait_for_irq(denali,
-			INTR__RST_COMP | INTR__INT_ACT | INTR__TIME_OUT);
-		if (!(irq_status & INTR__INT_ACT))
-			break;
-	}
-
-	dev_dbg(denali->dev, "%d chips connected\n", i);
-	denali->max_banks = i;
-}
-
 static void denali_hw_init(struct denali_nand_info *denali)
 {
 	/*
@@ -1321,12 +1298,6 @@ int denali_init(struct denali_nand_info *denali)
 	}
 
 	denali_enable_irq(denali);
-	denali_reset_banks(denali);
-	if (!denali->max_banks) {
-		/* Error out earlier if no chip is found for some reasons. */
-		ret = -ENODEV;
-		goto disable_irq;
-	}
 
 	denali->active_bank = DENALI_INVALID_BANK;
 
-- 
2.7.4

