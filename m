Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA57C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 06:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB8520854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 06:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="edS5DDnB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB8520854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbeIMLJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 07:09:04 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:32912 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbeIMLJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 07:09:04 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id w8D5wsjd002858;
        Thu, 13 Sep 2018 14:58:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w8D5wsjd002858
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1536818335;
        bh=Zzz6TfVv4KOjT4SlS07cnGQiDxiJTQwq6CquERnGz1Y=;
        h=From:To:Cc:Subject:Date:From;
        b=edS5DDnBL8jPnK/UBkiK82hNjaZ8uEmzPtUArvhnKXF/6aPLzehcTql3eGBXpIFwM
         FiL4a+1MBNs4M0uVx0RrxmPjkYHdCY0VCQrhaqWSTDw+Txj7HdcpV5YgHy+vzG+Rdf
         WjNVrpjlkfjjonpxarD3YOto6FxiVMne7npQoj6TS/phh6vBY9kINpurK5YZusxaxl
         AvyLfPr46jZQBvth97R1bwjGnYO2nq6Y2JoUpITBj93GquWLkv+twtEUBA1Cttl1AA
         ZGTdErOqbRrbz3SMoI8Eu4ocfyHsBnXbSGoj1fCv3iAUVObULDeOPsFiHpmr5UET3O
         7vUd1a5cucXYw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH] mtd: rawnand: denali: fix a race condition when DMA is kicked
Date:   Thu, 13 Sep 2018 14:58:49 +0900
Message-Id: <1536818329-11068-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I thought the read-back of the DMA_ENABLE register was unnecessary
(at least it is working on my boards), then deleted it in commit
586a2c52909d ("mtd: nand: denali: squash denali_enable_dma() helper
into caller").  Sorry, I was wrong - it caused a timing issue on
Cyclone5 SoCFPGAs.

Revive the register read-back, commenting why this is necessary.

Fixes: 586a2c52909d ("mtd: nand: denali: squash denali_enable_dma() helper into caller")
Reported-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mtd/nand/raw/denali.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
index 67b2065..b864b93 100644
--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -596,6 +596,12 @@ static int denali_dma_xfer(struct denali_nand_info *denali, void *buf,
 	}
 
 	iowrite32(DMA_ENABLE__FLAG, denali->reg + DMA_ENABLE);
+	/*
+	 * The ->setup_dma() hook kicks DMA by using the data/command
+	 * interface, which belongs to a different AXI port from the
+	 * register interface.  Read back the register to avoid a race.
+	 */
+	ioread32(denali->reg + DMA_ENABLE);
 
 	denali_reset_irq(denali);
 	denali->setup_dma(denali, dma_addr, page, write);
-- 
2.7.4

