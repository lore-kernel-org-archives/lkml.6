Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F7EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 05:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 453342081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 05:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="vgVJuzxd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 453342081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbeK1QaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 11:30:02 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:19158 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbeK1Q3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 11:29:55 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id wAS5RnF4025853;
        Wed, 28 Nov 2018 14:27:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com wAS5RnF4025853
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1543382871;
        bh=z11Hg5eC7Hyy5ve5za+67F0BpV3LZ3Xu5vPK1lusvmA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vgVJuzxdBj4QJHiEpg1iufdwUw30sTs8SQSUfm/ZPVu+vl2CZW89BiyQM2stIy0DU
         DSpMSuBWeTdPYxQf94xn7pGJb1Nn8nZm/C5PCW8lyocQIP+iCEbJvvNsD7rhExXvus
         7wikFzpOEf7xBTpXDLIjUWqQHUcpz7eeVwnuIqoFLFMBsZGT+KpQSjFdpkDiF0lIPr
         gtMaBsli11eG20FJK0rj6rjB6FHcTiYuRmDkrEw+bSPD2PVh7Ypjw5SPFLpwAZ+vxk
         fHN86w5GqWSMYU3v0fsMvW4SZb6W/ZOHmMTAeWU49XtGp30Kqz4JwlN0H2NUmyStKT
         P6xwZSUVpM6sg==
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
Subject: [PATCH v2 1/2] mtd: rawnand: denali: remove ->dev_ready() hook
Date:   Wed, 28 Nov 2018 14:27:36 +0900
Message-Id: <1543382857-30827-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543382857-30827-1-git-send-email-yamada.masahiro@socionext.com>
References: <1543382857-30827-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Denali NAND IP has no way to read out the current signal level
of the R/B# pin. Instead, denali_dev_ready() checks if the R/B#
transition has already happened. (The INTR__INT_ACT interrupt is
asserted at the rising edge of the R/B# pin.) It is not a correct
way to implement the ->dev_ready() hook.

In fact, it has a drawback; in the nand_scan_ident phase, the chip
detection iterates over maxchips until it fails to find a homogeneous
chip. For the last loop, nand_reset() fails if no chip is there.

If ->dev_ready hook exists, nand_command(_lp) calls nand_wait_ready()
after NAND_CMD_RESET. However, we know denali_dev_ready() never
returns 1 unless there exists a chip that toggles R/B# in that chip
select. Then, nand_wait_ready() just ends up with wasting 400 msec,
in the end, shows the "timeout while waiting for chip to become ready"
warning.

Let's remove the mis-implemented dev_ready hook, and fallback to
sending the NAND_CMD_STATUS and nand_wait_status_ready(), which
bails out more quickly.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Rebase

 drivers/mtd/nand/raw/denali.c | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
index 830ea24..ead6e60 100644
--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -204,18 +204,6 @@ static uint32_t denali_wait_for_irq(struct denali_nand_info *denali,
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
 static void denali_read_buf(struct nand_chip *chip, uint8_t *buf, int len)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
@@ -288,8 +276,7 @@ static void denali_cmd_ctrl(struct nand_chip *chip, int dat, unsigned int ctrl)
 		return;
 
 	/*
-	 * Some commands are followed by chip->legacy.dev_ready or
-	 * chip->legacy.waitfunc.
+	 * Some commands are followed by chip->legacy.waitfunc.
 	 * irq_status must be cleared here to catch the R/B# interrupt later.
 	 */
 	if (ctrl & NAND_CTRL_CHANGE)
@@ -298,13 +285,6 @@ static void denali_cmd_ctrl(struct nand_chip *chip, int dat, unsigned int ctrl)
 	denali->host_write(denali, DENALI_BANK(denali) | type, dat);
 }
 
-static int denali_dev_ready(struct nand_chip *chip)
-{
-	struct denali_nand_info *denali = mtd_to_denali(nand_to_mtd(chip));
-
-	return !!(denali_check_irq(denali) & INTR__INT_ACT);
-}
-
 static int denali_check_erased_page(struct mtd_info *mtd,
 				    struct nand_chip *chip, uint8_t *buf,
 				    unsigned long uncor_ecc_flags,
@@ -1359,7 +1339,6 @@ int denali_init(struct denali_nand_info *denali)
 	chip->legacy.read_byte = denali_read_byte;
 	chip->legacy.write_byte = denali_write_byte;
 	chip->legacy.cmd_ctrl = denali_cmd_ctrl;
-	chip->legacy.dev_ready = denali_dev_ready;
 	chip->legacy.waitfunc = denali_waitfunc;
 
 	if (features & FEATURES__INDEX_ADDR) {
-- 
2.7.4

