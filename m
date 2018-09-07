Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AC9C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C9572075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ZD5Mk4AG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C9572075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbeIGMKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 08:10:01 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:51324 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbeIGMJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 08:09:56 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id w877Sg3x001106;
        Fri, 7 Sep 2018 16:28:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w877Sg3x001106
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1536305323;
        bh=lyWnOAp3I+3UJW0TfDWy3SsWLcOJ5PwhrpW6yH3rIYQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZD5Mk4AG2IYEWLrH47wdL0zqDSUVj39uiK8xGUqvwh8TG0NRU9uJmjy5ZgJWc2WqA
         OQACpERxspIo84K+vFJ9euqbEqxR7xzkXrDgvo/UKG7FWRsSzgq/H2usHcHGh+6RF0
         zAidLrQ5GhyoPwCm3IZy81QodmwaICKOkr2OFFoH4Bemem7tT3Ms032f6KZqsD0dYN
         MaBFGM4J3zOXSTAlWC7SDu3Kbs+Oh1MurQ6hn2vSBG9IxQTCVt4PuJpZcSx54MaUs3
         qx7Nqrn0+uXSnyNhTqH+hc8dMu2g3viEd1MYRe4/AeFEYO0Hv1pu8xb1iqnDuld15+
         K0aX6beCoJeag==
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
Subject: [PATCH 1/2] mtd: rawnand: denali: remove ->dev_ready() hook
Date:   Fri,  7 Sep 2018 16:28:28 +0900
Message-Id: <1536305309-28026-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536305309-28026-1-git-send-email-yamada.masahiro@socionext.com>
References: <1536305309-28026-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Denali NAND IP has no way to read out the current signal level
of the R/B# pin.  Instead, denali_dev_ready() checks if the R/B#
transition has already happened. (The INTR__INT_ACT interrupt is
asserted at the rising edge of the R/B# pin.)  It is not a correct
way to implement the ->dev_ready() hook.

In fact, it has a drawback; in the nand_scan_ident phase, the chip
detection iterates over maxchips until it fails to find a homogeneous
chip.  For the last loop, nand_reset() fails if no chip is there.

If ->dev_ready hook exists, nand_command(_lp) calls nand_wait_ready()
after NAND_CMD_RESET.  However, we know denali_dev_ready() never
returns 1 unless there exists a chip that toggles R/B# in that chip
select.  Then, nand_wait_ready() just ends up with wasting 400 msec,
in the end, shows the "timeout while waiting for chip to become ready"
warning.

Let's remove the mis-implemented dev_ready hook, and fallback to
sending the NAND_CMD_STATUS and nand_wait_status_ready(), which
bails out more quickly.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mtd/nand/raw/denali.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
index f88a5dc..f069184 100644
--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -203,18 +203,6 @@ static uint32_t denali_wait_for_irq(struct denali_nand_info *denali,
 	return denali->irq_status;
 }
 
-static uint32_t denali_check_irq(struct denali_nand_info *denali)
-{
-	unsigned long flags;
-	uint32_t irq_status;
-
-	spin_lock_irqsave(&denali->irq_lock, flags);
-	irq_status = denali->irq_status;
-	spin_unlock_irqrestore(&denali->irq_lock, flags);
-
-	return irq_status;
-}
-
 static void denali_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
 {
 	struct denali_nand_info *denali = mtd_to_denali(mtd);
@@ -294,7 +282,7 @@ static void denali_cmd_ctrl(struct mtd_info *mtd, int dat, unsigned int ctrl)
 		return;
 
 	/*
-	 * Some commands are followed by chip->dev_ready or chip->waitfunc.
+	 * Some commands are followed by chip->waitfunc.
 	 * irq_status must be cleared here to catch the R/B# interrupt later.
 	 */
 	if (ctrl & NAND_CTRL_CHANGE)
@@ -303,13 +291,6 @@ static void denali_cmd_ctrl(struct mtd_info *mtd, int dat, unsigned int ctrl)
 	denali->host_write(denali, DENALI_BANK(denali) | type, dat);
 }
 
-static int denali_dev_ready(struct mtd_info *mtd)
-{
-	struct denali_nand_info *denali = mtd_to_denali(mtd);
-
-	return !!(denali_check_irq(denali) & INTR__INT_ACT);
-}
-
 static int denali_check_erased_page(struct mtd_info *mtd,
 				    struct nand_chip *chip, uint8_t *buf,
 				    unsigned long uncor_ecc_flags,
@@ -1349,7 +1330,6 @@ int denali_init(struct denali_nand_info *denali)
 	chip->write_byte = denali_write_byte;
 	chip->read_word = denali_read_word;
 	chip->cmd_ctrl = denali_cmd_ctrl;
-	chip->dev_ready = denali_dev_ready;
 	chip->waitfunc = denali_waitfunc;
 
 	if (features & FEATURES__INDEX_ADDR) {
-- 
2.7.4

