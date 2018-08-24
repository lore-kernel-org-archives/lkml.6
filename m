Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2C6C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE1E221477
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 15:07:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE1E221477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbeHXSmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 14:42:39 -0400
Received: from smtprz14.163.net ([106.3.154.247]:61670 "EHLO smtp.tom.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726374AbeHXSmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 14:42:39 -0400
Received: from antispam1.tom.com (unknown [172.25.16.55])
        by freemail01.tom.com (Postfix) with ESMTP id 3E75D1C80DFB
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 22:41:46 +0800 (CST)
Received: from antispam1.tom.com (antispam1.tom.com [127.0.0.1])
        by antispam1.tom.com (Postfix) with ESMTP id 3813F10013B3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 22:41:46 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at antispam1.tom.com
Received: from antispam1.tom.com ([127.0.0.1])
        by antispam1.tom.com (antispam1.tom.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Sd3S8B3zsEtD for <linux-kernel@vger.kernel.org>;
        Fri, 24 Aug 2018 22:41:45 +0800 (CST)
Received: from localhost (unknown [222.209.17.121])
        by antispam1.tom.com (Postfix) with ESMTPA id 7308410012D0;
        Fri, 24 Aug 2018 22:41:44 +0800 (CST)
From:   Liu Xiang <liu.xiang6@zte.com.cn>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, marek.vasut@gmail.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        boris.brezillon@bootlin.com, richard@nod.at, liuxiang_1999@126.com,
        Liu Xiang <liu.xiang6@zte.com.cn>
Subject: [PATCH] mtd: spi-nor: Add 4-byte address support for is25lp256
Date:   Fri, 24 Aug 2018 22:41:41 +0800
Message-Id: <1535121701-2925-1-git-send-email-liu.xiang6@zte.com.cn>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The is25lp256 supports 4-byte opcodes and quad output.
In is25lp256, the DWORD1 of JEDEC Basic Flash Parameter Header
is 0xfff920e5. So the DWORD1[18:17] Address Bytes bits are 0b00,
means that 3-Byte only addressing. Now this limits nor->addr_width
to 3 and makes it inpossible to access the address above 16MB.
I think the size of flash is the most important judgement for
nor->addr_width. Once the size is larger than 16MB, nor->addr_width
must be 4. This can avoid the bad situation that manufacturer sets
incorrect value of register.

Signed-off-by: Liu Xiang <liu.xiang6@zte.com.cn>
---
 drivers/mtd/spi-nor/spi-nor.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index d9c368c..0203b09 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1065,7 +1065,7 @@ static int spi_nor_is_locked(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 	{ "is25lp128",  INFO(0x9d6018, 0, 64 * 1024, 256,
 			SECT_4K | SPI_NOR_DUAL_READ) },
 	{ "is25lp256",  INFO(0x9d6019, 0, 64 * 1024, 512,
-			SECT_4K | SPI_NOR_DUAL_READ) },
+			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ "is25wp032",  INFO(0x9d7016, 0, 64 * 1024,  64,
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "is25wp064",  INFO(0x9d7017, 0, 64 * 1024, 128,
@@ -2926,16 +2926,16 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
 	if (ret)
 		return ret;
 
-	if (nor->addr_width) {
-		/* already configured from SFDP */
-	} else if (info->addr_width) {
-		nor->addr_width = info->addr_width;
-	} else if (mtd->size > 0x1000000) {
+	if (mtd->size > 0x1000000) {
 		/* enable 4-byte addressing if the device exceeds 16MiB */
 		nor->addr_width = 4;
 		if (JEDEC_MFR(info) == SNOR_MFR_SPANSION ||
-		    info->flags & SPI_NOR_4B_OPCODES)
+			info->flags & SPI_NOR_4B_OPCODES)
 			spi_nor_set_4byte_opcodes(nor, info);
+	} else if (nor->addr_width) {
+		/* already configured from SFDP */
+	} else if (info->addr_width) {
+		nor->addr_width = info->addr_width;
 	} else {
 		nor->addr_width = 3;
 	}
-- 
1.9.1

