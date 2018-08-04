Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19CEC28CF6
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 01:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88CA7216FE
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 01:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Ejs5dVIF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88CA7216FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732199AbeHDDsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 23:48:51 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45194 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731986AbeHDDsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 23:48:51 -0400
Received: by mail-pg1-f195.google.com with SMTP id f1-v6so3611053pgq.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 18:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:date:message-id:cc:from:to;
        bh=tQtY9Y39XTaQW+2EzTmwnC+CoPrvK+Z5UtDsqEnm6hI=;
        b=Ejs5dVIFsWvXi7FSqa0iOSJLvGgteZv/r+ubTb3cRAWod2lSwyEPUMm+xWsOO6dceN
         vUHAtYpyRhjiHZ+pTWyhiqsKAQJcdtv5Mj9A3OvAVch9yE4LMr15VrYRmdwsdVefUqA8
         KGVhOrZ8Wt+j7XEuWAOzarkxY9CTHFM2juyRrxCbbwDuTuIPeZZyyOVPNHVBVSjuVHN3
         Mwgmv0Yd/hLUUxko65+vN3Q5gbY7hnQd09DyUL7g9GSnJf/X0nII5XLxmlwTJcAMnRDP
         Bp+615a+CPLkKSIxEGkTjFtTXSsnyZ0MD0nC0wLifVUv4bSLYZoy1MAKDRNKbBZsvEcq
         ab4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:cc:from:to;
        bh=tQtY9Y39XTaQW+2EzTmwnC+CoPrvK+Z5UtDsqEnm6hI=;
        b=SlBFN4rHpoINEGwrSNFQJyWRZSq6qIw92Hnh4ibKe+k9x6w+UuWs1JpOSuk2MtBwfX
         VaDb86Tj44eIu/UvY1g5dlMiNQ5yA2PnUcZTIRUrFie5ce4Exr+3ZdGzP9HY4aOtl8Am
         fSgNBMh/MRPXfHxtAWHkW1u0B11UhMcnetnYVmmRgPzChI3Cq7qdwP4W3LkZWLLzQguJ
         wHoBPTqd3/sOKfWWcCfBNzPSqA7oj371bru/9B54KdLHLzjFCdYqa3fOZBNmLahQ9CQs
         LbI6zdoQfyzZ2/80HTtldXpurT3xVrElkGcVqVtLNqsqjvxqmIuIiaawSnsn4VTeUXh2
         3dHA==
X-Gm-Message-State: AOUpUlFeco1OrsFW9En2KYFzUNk0ZvRN5F2jnz2EDdslxCFJ9CgNh2sM
        ppi3Acdh1wnXrOa1o8Nn6WAqfg==
X-Google-Smtp-Source: AAOMgpejsuC9kuEVmLkhYXw753sFWQXEcbCVWyPKNwIZ2li6CQMNpM8wd9wXXcbs09VwTfpXxm5BUQ==
X-Received: by 2002:a62:4083:: with SMTP id f3-v6mr7021533pfd.229.1533347403360;
        Fri, 03 Aug 2018 18:50:03 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id o27-v6sm9146360pfj.35.2018.08.03.18.50.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 18:50:02 -0700 (PDT)
Subject: [PATCH] spi-nor: add support for is25wp256d
Date:   Fri,  3 Aug 2018 18:49:47 -0700
Message-Id: <20180804014947.24601-1-palmer@sifive.com>
X-Mailer: git-send-email 2.16.4
Cc:     marek.vasut@gmail.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, boris.brezillon@bootlin.com,
        richard@nod.at, linux-kernel@vger.kernel.org,
        "Wesley W. Terpstra" <wesley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>
From:   Palmer Dabbelt <palmer@sifive.com>
To:     linux-mtd@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Wesley W. Terpstra" <wesley@sifive.com>

This is used of the HiFive Unleashed development board.

Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 47 ++++++++++++++++++++++++++++++++++++++++++-
 include/linux/mtd/spi-nor.h   |  2 ++
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index d9c368c44194..e9a3557a3c23 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1072,6 +1072,9 @@ static const struct flash_info spi_nor_ids[] = {
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "is25wp128",  INFO(0x9d7018, 0, 64 * 1024, 256,
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ "is25wp256d", INFO(0x9d7019, 0, 32 * 1024, 1024,
+	                SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES)
+	},
 
 	/* Macronix */
 	{ "mx25l512e",   INFO(0xc22010, 0, 64 * 1024,   1, SECT_4K) },
@@ -1515,6 +1518,45 @@ static int macronix_quad_enable(struct spi_nor *nor)
 	return 0;
 }
 
+/**
+ * issi_unlock() - clear BP[0123] write-protection.
+ * @nor:	pointer to a 'struct spi_nor'
+ *
+ * Bits [2345] of the Status Register are BP[0123].
+ * ISSI chips use a different block protection scheme than other chips.
+ * Just disable the write-protect unilaterally.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int issi_unlock(struct spi_nor *nor)
+{
+	int ret, val;
+	u8 mask = SR_BP0 | SR_BP1 | SR_BP2 | SR_BP3;
+
+	val = read_sr(nor);
+	if (val < 0)
+		return val;
+	if (!(val & mask))
+		return 0;
+
+	write_enable(nor);
+
+	write_sr(nor, val & ~mask);
+
+	ret = spi_nor_wait_till_ready(nor);
+	if (ret)
+		return ret;
+
+	ret = read_sr(nor);
+	if (ret > 0 && !(ret & mask)) {
+		dev_info(nor->dev, "ISSI Block Protection Bits cleared\n");
+		return 0;
+	} else {
+		dev_err(nor->dev, "ISSI Block Protection Bits not cleared\n");
+		return -EINVAL;
+	}
+}
+
 /*
  * Write status Register and configuration register with 2 bytes
  * The first byte will be written to the status register, while the
@@ -2747,6 +2789,9 @@ static int spi_nor_init(struct spi_nor *nor)
 		spi_nor_wait_till_ready(nor);
 	}
 
+	if (JEDEC_MFR(nor->info) == SNOR_MFR_ISSI)
+		issi_unlock(nor);
+
 	if (nor->quad_enable) {
 		err = nor->quad_enable(nor);
 		if (err) {
@@ -2926,7 +2971,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
 	if (ret)
 		return ret;
 
-	if (nor->addr_width) {
+	if (nor->addr_width && JEDEC_MFR(info) != SNOR_MFR_ISSI) {
 		/* already configured from SFDP */
 	} else if (info->addr_width) {
 		nor->addr_width = info->addr_width;
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index e60da0d34cc1..da422a37d383 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -23,6 +23,7 @@
 #define SNOR_MFR_ATMEL		CFI_MFR_ATMEL
 #define SNOR_MFR_GIGADEVICE	0xc8
 #define SNOR_MFR_INTEL		CFI_MFR_INTEL
+#define SNOR_MFR_ISSI		0x9d
 #define SNOR_MFR_MICRON		CFI_MFR_ST /* ST Micro <--> Micron */
 #define SNOR_MFR_MACRONIX	CFI_MFR_MACRONIX
 #define SNOR_MFR_SPANSION	CFI_MFR_AMD
@@ -121,6 +122,7 @@
 #define SR_BP0			BIT(2)	/* Block protect 0 */
 #define SR_BP1			BIT(3)	/* Block protect 1 */
 #define SR_BP2			BIT(4)	/* Block protect 2 */
+#define SR_BP3			BIT(5)  /* Block protect 3 (on ISSI chips) */
 #define SR_TB			BIT(5)	/* Top/Bottom protect */
 #define SR_SRWD			BIT(7)	/* SR write protect */
 /* Spansion/Cypress specific status bits */
-- 
2.16.4

