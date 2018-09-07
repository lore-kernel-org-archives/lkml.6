Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D2BC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABACD2075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="StSHcmxl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABACD2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbeIGMJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 08:09:56 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:51329 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbeIGMJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 08:09:56 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id w877Sg40001106;
        Fri, 7 Sep 2018 16:28:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w877Sg40001106
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1536305324;
        bh=flu3fp1o58/XFwJIPc3xfkUEHKLiSuaT8QXkx1DBVyA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=StSHcmxlR/gB9a3vbwTen17SA+Vjdz1l6JHLdpEGPE8PDH6wi47WGSt+C/2JqId4R
         gL5oispWOEzOxXt/Uc0KgNS5YAmHmAhJiEoW7vJA5PHt2gySsZWlmRRUxosW7awJ2P
         0/jKYcAksmLj5767+ZAm9j48Y+0mNBU+JMOBhjiEYhTX18ASTmWi0rN6rKDRDqA/tu
         C+tYcXD6ckp8eTNj46n+GPgG0PJXq5G9OCykfNECWq/PcbRUKMd7i5RP52FxvKAprE
         OX7EEM4T4fKoRRMSgMXsACfTySQEnflvKslrbyWGeNZEVdhpsI5ey/QFVoyx/wVvGY
         1xCrUOyqZELyg==
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
Subject: [PATCH 2/2] mtd: rawnand: denali: remove denali_reset_banks()
Date:   Fri,  7 Sep 2018 16:28:29 +0900
Message-Id: <1536305309-28026-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536305309-28026-1-git-send-email-yamada.masahiro@socionext.com>
References: <1536305309-28026-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In nand_scan_ident(), the controller driver resets every NAND chip.
This is done by sending NAND_CMD_RESET.  The Denali IP provides
another way to do the equivalent thing; if a bit is set in the
DEVICE_RESET register, the controller sends the RESET command to
the corresponding device.  denali_reset_banks() uses it to reset
all devices beforehand.

This redundant reset sequence was needed to know the actual number
of chips before calling nand_scan_ident(); if DEVICE_RESET fails,
there is no chip in that chip select.  Then, denali_reset_banks()
sets denali->max_banks to the number of detected chips.

As commit f486287d2372 ("mtd: nand: denali: fix bank reset function
to detect the number of chips") explained, nand_scan_ident() issued
Set Features (0xEF) command to all CS lines, some of which may not be
connected with a chip. Then, the driver would wait for R/B# response,
which never happens.

This problem was solved by commit 107b7d6a7ad4 ("mtd: rawnand: avoid
setting again the timings to mode 0 after a reset").  In the current
code, nand_setup_data_interface() is called from nand_scan_tail(),
which is invoked after the chip detection.

Now, we can really remove the redundant denali_nand_banks() by simply
passing the maximum number of chip selects supported by this IP
(typically 4 or 8) to nand_scan().  Let's leave all the chip detection
process to nand_scan_ident().

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mtd/nand/raw/denali.c | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
index f069184..d1ae968 100644
--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -1040,29 +1040,6 @@ static int denali_setup_data_interface(struct mtd_info *mtd, int chipnr,
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
@@ -1311,12 +1288,6 @@ int denali_init(struct denali_nand_info *denali)
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

