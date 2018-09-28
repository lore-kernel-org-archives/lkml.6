Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D304EC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 04:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86F01216FE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 04:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="kfe9FpKV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86F01216FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbeI1KkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 06:40:20 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:37807 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbeI1KkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 06:40:20 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id w8S4GAxq019811;
        Fri, 28 Sep 2018 13:16:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w8S4GAxq019811
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1538108171;
        bh=XL2TtXqIYxPVBf8vNRR9UfPcC/SEkEpUo0i1xrrDfZ8=;
        h=From:To:Cc:Subject:Date:From;
        b=kfe9FpKViw5nw7359ws71cnd97aOKlI0elNs03FjGK5e+1ar32HFgAGDpiM7wgZ/f
         HFSB97gBGBfl4ckdRWkuCZ1LGvBu6wsIhAdh0cPgFLhQJoM8LvGLK2/ymYQjM6wBuy
         v30Ms2fp2Urt04NIrONqxsCLHSaLGM6NnyK+ola+rArI43ZRnsny/XmUJp4uY+M+NM
         e2faTQtevwcvyHabAgifk1MuHhzw1dffm1PT6z8vySbddLhPudT8l/LfKxv3Y3Qg4O
         4vdA7H3U/R7xlekDkrVFEwgYXldAYzxYDjcps65tHj5EOEkUmVStV2bpotaSQA2B49
         rtB6N5yoZvvNA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Dinh Nguyen <dinguyen@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH v2] mtd: rawnand: denali: set SPARE_AREA_SKIP_BYTES register to 8 if unset
Date:   Fri, 28 Sep 2018 13:16:01 +0900
Message-Id: <1538108161-6174-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NAND devices need additional data area (OOB) for error correction,
but it is also used for Bad Block Marker (BBM).  In many cases, the
first byte in OOB is used for BBM, but the location actually depends
on chip vendors.  The NAND controller should preserve the precious
BBM to keep track of bad blocks.

In Denali IP, the SPARE_AREA_SKIP_BYTES register is used to specify
the number of bytes to skip from the start of OOB.  The ECC engine
will automatically skip the specified number of bytes when it gets
access to OOB area.

The same value for SPARE_AREA_SKIP_BYTES should be used between
firmware and the operating system if you intend to use the NAND
device across the control hand-off.

In fact, the current denali.c code expects firmware to have already
set the SPARE_AREA_SKIP_BYTES register, then reads the value out.

If no firmware (or bootloader) has initialized the controller, the
register value is zero, which is the default after power-on-reset.
In other words, the Linux driver cannot initialize the controller
by itself.

Some possible solutions are:

 [1] Add a DT property to specify the skipped bytes in OOB
 [2] Associate the preferred value with compatible
 [3] Hard-code the default value in the driver

My first attempt was [1], but in the review process, [3] was suggested
as a counter-implementation.
(https://lore.kernel.org/patchwork/patch/983055/)

The default value 8 was chosen to match to the boot ROM of the UniPhier
platform.  The preferred value may vary by platform.  If so, please
trade up to a different solution.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Change approach from a DT-property to a hard-coded dafault

 drivers/mtd/nand/raw/denali.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
index aaab121..18bbfc8 100644
--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -21,6 +21,7 @@
 #include "denali.h"
 
 #define DENALI_NAND_NAME    "denali-nand"
+#define DENALI_DEFAULT_OOB_SKIP_BYTES	8
 
 /* for Indexed Addressing */
 #define DENALI_INDEXED_CTRL	0x00
@@ -1056,12 +1057,17 @@ static void denali_hw_init(struct denali_nand_info *denali)
 		denali->revision = swab16(ioread32(denali->reg + REVISION));
 
 	/*
-	 * tell driver how many bit controller will skip before
-	 * writing ECC code in OOB, this register may be already
-	 * set by firmware. So we read this value out.
-	 * if this value is 0, just let it be.
+	 * Set how many bytes should be skipped before writing data in OOB.
+	 * If a non-zero value has already been set (by firmware or something),
+	 * just use it.  Otherwise, set the driver default.
 	 */
 	denali->oob_skip_bytes = ioread32(denali->reg + SPARE_AREA_SKIP_BYTES);
+	if (!denali->oob_skip_bytes) {
+		denali->oob_skip_bytes = DENALI_DEFAULT_OOB_SKIP_BYTES;
+		iowrite32(denali->oob_skip_bytes,
+			  denali->reg + SPARE_AREA_SKIP_BYTES);
+	}
+
 	denali_detect_max_banks(denali);
 	iowrite32(0x0F, denali->reg + RB_PIN_ENABLED);
 	iowrite32(CHIP_EN_DONT_CARE__FLAG, denali->reg + CHIP_ENABLE_DONT_CARE);
-- 
2.7.4

