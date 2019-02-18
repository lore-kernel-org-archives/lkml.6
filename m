Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2335C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA2FF2175B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbfBRKmq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 05:42:46 -0500
Received: from skedge03.snt-world.com ([91.208.41.68]:50144 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfBRKmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 05:42:45 -0500
Received: from sntmail14r.snt-is.com (unknown [10.203.32.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id 7967F60376A;
        Mon, 18 Feb 2019 11:42:42 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail14r.snt-is.com
 (10.203.32.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 18 Feb
 2019 11:42:41 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Mon, 18 Feb 2019 11:42:41 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        "Marek Vasut" <marek.vasut@gmail.com>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "Schrempf Frieder" <frieder.schrempf@kontron.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 2/7] mtd: onenand: Store bad block marker position in chip
 struct
Thread-Topic: [PATCH v4 2/7] mtd: onenand: Store bad block marker position in
 chip struct
Thread-Index: AQHUx3asBl+PaSojc0CFv8B5tA994g==
Date:   Mon, 18 Feb 2019 10:42:41 +0000
Message-ID: <20190218104122.18788-3-frieder.schrempf@kontron.de>
References: <20190218104122.18788-1-frieder.schrempf@kontron.de>
In-Reply-To: <20190218104122.18788-1-frieder.schrempf@kontron.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.43]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 7967F60376A.AEE7D
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: bbrezillon@kernel.org, computersforpeace@gmail.com,
        dwmw2@infradead.org, kyungmin.park@samsung.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        marek.vasut@gmail.com, miquel.raynal@bootlin.com, richard@nod.at
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The information about where the manufacturer puts the bad block
markers inside the bad block and in the OOB data is stored in
different places. Let's move this information to the chip struct,
as we did it for rawnand.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/mtd/nand/onenand/onenand_base.c | 5 ++++-
 drivers/mtd/nand/onenand/onenand_bbt.c  | 3 ---
 include/linux/mtd/onenand.h             | 3 +++
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/onenand/onenand_base.c b/drivers/mtd/nand/onenand/onenand_base.c
index 4ca4b194e7d7..f41d76248550 100644
--- a/drivers/mtd/nand/onenand/onenand_base.c
+++ b/drivers/mtd/nand/onenand/onenand_base.c
@@ -2458,7 +2458,7 @@ static int onenand_default_block_markbad(struct mtd_info *mtd, loff_t ofs)
                 bbm->bbt[block >> 2] |= 0x01 << ((block & 0x03) << 1);
 
         /* We write two bytes, so we don't have to mess with 16-bit access */
-        ofs += mtd->oobsize + (bbm->badblockpos & ~0x01);
+        ofs += mtd->oobsize + (this->badblockpos & ~0x01);
 	/* FIXME : What to do when marking SLC block in partition
 	 * 	   with MLC erasesize? For now, it is not advisable to
 	 *	   create partitions containing both SLC and MLC regions.
@@ -3967,6 +3967,9 @@ int onenand_scan(struct mtd_info *mtd, int maxchips)
 	if (!(this->options & ONENAND_SKIP_INITIAL_UNLOCKING))
 		this->unlock_all(mtd);
 
+	/* Set the bad block marker position */
+	this->badblockpos = ONENAND_BADBLOCK_POS;
+
 	ret = this->scan_bbt(mtd);
 	if ((!FLEXONENAND(this)) || ret)
 		return ret;
diff --git a/drivers/mtd/nand/onenand/onenand_bbt.c b/drivers/mtd/nand/onenand/onenand_bbt.c
index dde20487937d..57c31c81be18 100644
--- a/drivers/mtd/nand/onenand/onenand_bbt.c
+++ b/drivers/mtd/nand/onenand/onenand_bbt.c
@@ -190,9 +190,6 @@ static int onenand_scan_bbt(struct mtd_info *mtd, struct nand_bbt_descr *bd)
 	if (!bbm->bbt)
 		return -ENOMEM;
 
-	/* Set the bad block position */
-	bbm->badblockpos = ONENAND_BADBLOCK_POS;
-
 	/* Set erase shift */
 	bbm->bbt_erase_shift = this->erase_shift;
 
diff --git a/include/linux/mtd/onenand.h b/include/linux/mtd/onenand.h
index 0aaa98b219a4..e03aea7f7e61 100644
--- a/include/linux/mtd/onenand.h
+++ b/include/linux/mtd/onenand.h
@@ -94,6 +94,7 @@ struct onenand_chip {
 	unsigned int		technology;
 	unsigned int		density_mask;
 	unsigned int		options;
+	int			badblockpos;
 
 	unsigned int		erase_shift;
 	unsigned int		page_shift;
@@ -188,6 +189,8 @@ struct onenand_chip {
 /* Check byte access in OneNAND */
 #define ONENAND_CHECK_BYTE_ACCESS(addr)		(addr & 0x1)
 
+#define ONENAND_BADBLOCK_POS		0
+
 /*
  * Options bits
  */
-- 
2.17.1
