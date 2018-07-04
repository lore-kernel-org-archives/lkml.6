Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0710BC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B43AC23DC3
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:20:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B43AC23DC3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934045AbeGDIUd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 04:20:33 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50410 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S932319AbeGDIUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 04:20:30 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0E53332EC4B82;
        Wed,  4 Jul 2018 16:20:27 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.382.0; Wed, 4 Jul 2018 16:20:21 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        "David Woodhouse" <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Peter Pan <peterpandong@micron.com>,
        Frieder Schrempf <frieder.schrempf@exceet.de>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] mtd: spinand: Fix missing unlock on error path
Date:   Wed, 4 Jul 2018 08:29:39 +0000
Message-ID: <1530692979-6274-1-git-send-email-weiyongjun1@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing unlock before return from function
spinand_mtd_(read|write) in the error handling case.

Fixes: c898e0526fb6 ("mtd: nand: Add core infrastructure to support SPI NANDs")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/mtd/nand/spi/core.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 17d207a..8ac1ba95 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -560,12 +560,16 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 
 	nanddev_io_for_each_page(nand, from, ops, &iter) {
 		ret = spinand_select_target(spinand, iter.req.pos.target);
-		if (ret)
+		if (ret) {
+			mutex_unlock(&spinand->lock);
 			return ret;
+		}
 
 		ret = spinand_ecc_enable(spinand, enable_ecc);
-		if (ret)
+		if (ret) {
+			mutex_unlock(&spinand->lock);
 			return ret;
+		}
 
 		ret = spinand_read_page(spinand, &iter.req, enable_ecc);
 		if (ret < 0 && ret != -EBADMSG)
@@ -609,11 +613,11 @@ static int spinand_mtd_write(struct mtd_info *mtd, loff_t to,
 	nanddev_io_for_each_page(nand, to, ops, &iter) {
 		ret = spinand_select_target(spinand, iter.req.pos.target);
 		if (ret)
-			return ret;
+			break;
 
 		ret = spinand_ecc_enable(spinand, enable_ecc);
 		if (ret)
-			return ret;
+			break;
 
 		ret = spinand_write_page(spinand, &iter.req);
 		if (ret)

