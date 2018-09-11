Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91377C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5490D20854
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:22:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5490D20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbeIKNU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 09:20:56 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:28328 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbeIKNU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 09:20:56 -0400
X-IronPort-AV: E=Sophos;i="5.53,359,1531810800"; 
   d="scan'208";a="19722857"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 11 Sep 2018 01:22:44 -0700
Received: from localhost.localdomain.com (10.10.76.4) by
 chn-sv-exch07.mchp-main.com (10.10.76.108) with Microsoft SMTP Server id
 14.3.352.0; Tue, 11 Sep 2018 01:22:44 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <marek.vasut@gmail.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <boris.brezillon@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <anuragku@xilinx.com>,
        <cyrille.pitchen@microchip.com>, <nicolas.ferre@microchip.com>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v2 1/3] mtd: spi-nor: add Global Block Unlock support
Date:   Tue, 11 Sep 2018 11:22:30 +0300
Message-ID: <20180911082232.28678-2-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <20180911082232.28678-1-tudor.ambarus@microchip.com>
References: <20180911082232.28678-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can't determine this purely by manufacturer type and it's not
autodetectable by anything like SFDP, so make a new flag for it:
UNLOCK_GLOBAL_BLOCK.

Note that the Global Block Unlock command has different names
depending on the manufacturer, but always the same command value:
0x98. Macronix's MX25U12835F names it Gang Block Unlock,
Winbound's W25Q128FV names it Global Block Unlock and
Microchip's SST26VF064B names it Global Block Protection Unlock.

Based on initial work done by Anurag Kumar Vulisha:
https://lkml.org/lkml/2015/11/13/307

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Cyrille Pitchen <cyrille.pitchen@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 21 +++++++++++++++++++++
 include/linux/mtd/spi-nor.h   |  1 +
 2 files changed, 22 insertions(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index f028277..d3134fd 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -89,6 +89,7 @@ struct flash_info {
 #define NO_CHIP_ERASE		BIT(12) /* Chip does not support chip erase */
 #define SPI_NOR_SKIP_SFDP	BIT(13)	/* Skip parsing of SFDP tables */
 #define USE_CLSR		BIT(14)	/* use CLSR command */
+#define UNLOCK_GLOBAL_BLOCK	BIT(15)	/* Unlock global block protection */
 
 	int	(*quad_enable)(struct spi_nor *nor);
 };
@@ -2730,6 +2731,17 @@ static int spi_nor_setup(struct spi_nor *nor, const struct flash_info *info,
 	return 0;
 }
 
+static int spi_nor_unlock_global_block_protection(struct spi_nor *nor)
+{
+	int ret;
+
+	write_enable(nor);
+	ret = nor->write_reg(nor, SPINOR_OP_GBULK, NULL, 0);
+	if (ret < 0)
+		return ret;
+	return spi_nor_wait_till_ready(nor);
+}
+
 static int spi_nor_init(struct spi_nor *nor)
 {
 	int err;
@@ -2747,6 +2759,15 @@ static int spi_nor_init(struct spi_nor *nor)
 		spi_nor_wait_till_ready(nor);
 	}
 
+	if (nor->info->flags & UNLOCK_GLOBAL_BLOCK) {
+		err = spi_nor_unlock_global_block_protection(nor);
+		if (err) {
+			dev_err(nor->dev,
+				"Cannot unlock the global block protection\n");
+			return err;
+		}
+	}
+
 	if (nor->quad_enable) {
 		err = nor->quad_enable(nor);
 		if (err) {
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index c922e97..09a10fd 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -64,6 +64,7 @@
 #define SPINOR_OP_CLFSR		0x50	/* Clear flag status register */
 #define SPINOR_OP_RDEAR		0xc8	/* Read Extended Address Register */
 #define SPINOR_OP_WREAR		0xc5	/* Write Extended Address Register */
+#define SPINOR_OP_GBULK		0x98	/* Global Block Unlock Protection */
 
 /* 4-byte address opcodes - used on Spansion and some Macronix flashes. */
 #define SPINOR_OP_READ_4B	0x13	/* Read data bytes (low frequency) */
-- 
2.9.4

