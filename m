Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD15EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 21:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 506AF2098B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 21:43:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 506AF2098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbeHXBPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 21:15:32 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:41380 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbeHXBPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 21:15:31 -0400
Received: from ramsan.of.borg ([84.194.111.163])
        by xavier.telenet-ops.be with bizsmtp
        id Sljn1y0023XaVaC01ljnHV; Thu, 23 Aug 2018 23:43:52 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fsxOM-0005lo-U3; Thu, 23 Aug 2018 23:43:46 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fsxOM-0005Sy-RW; Thu, 23 Aug 2018 23:43:46 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] mtd: rawnand: docg4: Remove wrong __init annotations
Date:   Thu, 23 Aug 2018 23:43:45 +0200
Message-Id: <20180823214345.20949-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If gcc (e.g. 4.1.2) decides not to inline init_mtd_structs() and
read_id_reg(), this will cause section mismatches, and crashes:

    WARNING: drivers/mtd/nand/raw/docg4.o(.text+0xc10): Section mismatch in reference from the function docg4_attach_chip() to the function .init.text:init_mtd_structs()
    The function docg4_attach_chip() references
    the function __init init_mtd_structs().
    This is often because docg4_attach_chip lacks a __init
    annotation or the annotation of init_mtd_structs is wrong.

    WARNING: drivers/mtd/nand/raw/docg4.o(.text+0xc3e): Section mismatch in reference from the function docg4_attach_chip() to the function .init.text:read_id_reg()
    The function docg4_attach_chip() references
    the function __init read_id_reg().
    This is often because docg4_attach_chip lacks a __init
    annotation or the annotation of read_id_reg is wrong.

Fix this by dropping the now incorrect __init annotations from
init_mtd_structs() and read_id_reg().

Fixes: 66a38478dcc5b5a3 ("mtd: rawnand: docg4: convert driver to nand_scan()")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/mtd/nand/raw/docg4.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/docg4.c b/drivers/mtd/nand/raw/docg4.c
index a3f04315c05c54e6..427fcbc1b71c0551 100644
--- a/drivers/mtd/nand/raw/docg4.c
+++ b/drivers/mtd/nand/raw/docg4.c
@@ -1218,7 +1218,7 @@ static int docg4_resume(struct platform_device *pdev)
 	return 0;
 }
 
-static void __init init_mtd_structs(struct mtd_info *mtd)
+static void init_mtd_structs(struct mtd_info *mtd)
 {
 	/* initialize mtd and nand data structures */
 
@@ -1290,7 +1290,7 @@ static void __init init_mtd_structs(struct mtd_info *mtd)
 
 }
 
-static int __init read_id_reg(struct mtd_info *mtd)
+static int read_id_reg(struct mtd_info *mtd)
 {
 	struct nand_chip *nand = mtd_to_nand(mtd);
 	struct docg4_priv *doc = nand_get_controller_data(nand);
-- 
2.17.1

