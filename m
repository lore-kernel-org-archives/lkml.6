Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451A7C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 137CF21470
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:59:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 137CF21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbeJJXWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 19:22:05 -0400
Received: from gateway22.websitewelcome.com ([192.185.46.194]:46887 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726503AbeJJXWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 19:22:05 -0400
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 36CEFA417
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 10:59:17 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id AGt2gbB5BRPojAGtCgtGqr; Wed, 10 Oct 2018 10:59:16 -0500
X-Authority-Reason: nr=8
Received: from 57.154.24.109.rev.sfr.net ([109.24.154.57]:48956 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gAGt1-000N6h-P4; Wed, 10 Oct 2018 10:59:00 -0500
Date:   Wed, 10 Oct 2018 17:58:58 +0200
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] mtd: rawnand: fsmc: Fix unchecked return value in
 fsmc_read_page_hwecc
Message-ID: <20181010155857.GA18860@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 109.24.154.57
X-Source-L: No
X-Exim-ID: 1gAGt1-000N6h-P4
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 57.154.24.109.rev.sfr.net (embeddedor) [109.24.154.57]:48956
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 15
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check return value of nand_read_data_op.

Notice that, currently, all instances of nand_read_data_op() are
being checked, with the exception of two of them in marvell_nand
driver, in which the caller function explicitly returns 0 every
time.

Also, notice that I moved the declaration of *ret* to the top of
fsmc_read_page_hwecc().

Addresses-Coverity-ID: 1471968 ("Unchecked return value")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/mtd/nand/raw/fsmc_nand.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/fsmc_nand.c b/drivers/mtd/nand/raw/fsmc_nand.c
index 70ac8d8..41ba76e 100644
--- a/drivers/mtd/nand/raw/fsmc_nand.c
+++ b/drivers/mtd/nand/raw/fsmc_nand.c
@@ -727,7 +727,7 @@ static int fsmc_read_page_hwecc(struct nand_chip *chip, uint8_t *buf,
 	uint8_t *p = buf;
 	uint8_t *ecc_calc = chip->ecc.calc_buf;
 	uint8_t *ecc_code = chip->ecc.code_buf;
-	int off, len, group = 0;
+	int off, len, ret, group = 0;
 	/*
 	 * ecc_oob is intentionally taken as uint16_t. In 16bit devices, we
 	 * end up reading 14 bytes (7 words) from oob. The local array is
@@ -740,11 +740,12 @@ static int fsmc_read_page_hwecc(struct nand_chip *chip, uint8_t *buf,
 	for (i = 0, s = 0; s < eccsteps; s++, i += eccbytes, p += eccsize) {
 		nand_read_page_op(chip, page, s * eccsize, NULL, 0);
 		chip->ecc.hwctl(chip, NAND_ECC_READ);
-		nand_read_data_op(chip, p, eccsize, false);
+		ret = nand_read_data_op(chip, p, eccsize, false);
+		if (ret)
+			return ret;
 
 		for (j = 0; j < eccbytes;) {
 			struct mtd_oob_region oobregion;
-			int ret;
 
 			ret = mtd_ooblayout_ecc(mtd, group++, &oobregion);
 			if (ret)
-- 
2.7.4

