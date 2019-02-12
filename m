Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B89C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 297E62184A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="qbt9Ky2x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbfBLHOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 02:14:37 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:37573 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbfBLHOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 02:14:36 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x1C7DPdR019269;
        Tue, 12 Feb 2019 16:13:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x1C7DPdR019269
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1549955609;
        bh=HYckDXuas8pq71xyZdmaNUVL9TtZH+n6gMwrrO1jxis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qbt9Ky2xDyQGdz88W/Sj6ZBspI2TphsqEV+kskQDTYR4VmUuHPhB4xPLdYi+v7lSM
         DTuISCkrU9MtBHR4Sk8c9EJAYXtCZ534xIpiLEfMmXxGuir24j86N90z/Ukp40kNR1
         YLxaybUNFcSSGNfydSV1rWVuqCchnnp9QIqP465U37aR2imWHcnQCVEnGBkaqUiVQZ
         LJFImwKm70HYqib6gSaTcoPJlfSBs4tSRiJ3HD0Sri7d9XehajPkMrn2Mdhbw8JC8e
         boU5fzB5bs27Pml0tIF/VJjhg1SEu88igO42NXsTbTHGorl4QvKgwUUTOG9Ym768DQ
         8YTZp9W/qQFCw==
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
Subject: [PATCH v2 03/10] mtd: rawnand: denali: remove unneeded casts in denali_{read,write}_pio
Date:   Tue, 12 Feb 2019 16:12:55 +0900
Message-Id: <1549955582-30346-4-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549955582-30346-1-git-send-email-yamada.masahiro@socionext.com>
References: <1549955582-30346-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since (u32 *) can accept an opaque pointer, the explicit casting
from (void *) to (u32 *) is redundant. Change the function argument type
to remove the casts.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2: None

 drivers/mtd/nand/raw/denali.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
index 9287f4f..a2fe2ff 100644
--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -478,11 +478,10 @@ static void denali_setup_dma32(struct denali_nand_info *denali,
 	denali->host_write(denali, mode | 0x14000, 0x2400);
 }
 
-static int denali_pio_read(struct denali_nand_info *denali, void *buf,
+static int denali_pio_read(struct denali_nand_info *denali, u32 *buf,
 			   size_t size, int page)
 {
 	u32 addr = DENALI_MAP01 | DENALI_BANK(denali) | page;
-	uint32_t *buf32 = (uint32_t *)buf;
 	uint32_t irq_status, ecc_err_mask;
 	int i;
 
@@ -494,7 +493,7 @@ static int denali_pio_read(struct denali_nand_info *denali, void *buf,
 	denali_reset_irq(denali);
 
 	for (i = 0; i < size / 4; i++)
-		*buf32++ = denali->host_read(denali, addr);
+		buf[i] = denali->host_read(denali, addr);
 
 	irq_status = denali_wait_for_irq(denali, INTR__PAGE_XFER_INC);
 	if (!(irq_status & INTR__PAGE_XFER_INC))
@@ -506,18 +505,17 @@ static int denali_pio_read(struct denali_nand_info *denali, void *buf,
 	return irq_status & ecc_err_mask ? -EBADMSG : 0;
 }
 
-static int denali_pio_write(struct denali_nand_info *denali,
-			    const void *buf, size_t size, int page)
+static int denali_pio_write(struct denali_nand_info *denali, const u32 *buf,
+			    size_t size, int page)
 {
 	u32 addr = DENALI_MAP01 | DENALI_BANK(denali) | page;
-	const uint32_t *buf32 = (uint32_t *)buf;
 	uint32_t irq_status;
 	int i;
 
 	denali_reset_irq(denali);
 
 	for (i = 0; i < size / 4; i++)
-		denali->host_write(denali, addr, *buf32++);
+		denali->host_write(denali, addr, buf[i]);
 
 	irq_status = denali_wait_for_irq(denali,
 				INTR__PROGRAM_COMP | INTR__PROGRAM_FAIL);
-- 
2.7.4

