Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6EFC282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 23:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD4192084A
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 23:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="SyD72S2Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbfBBXUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 18:20:40 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:53730 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbfBBXUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 18:20:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1549149634; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=QiGHz2BcCWNpT2xNGWkZQ1dV4Mt886eIE/pPY7QKGQw=;
        b=SyD72S2Zd3wFpqe7FKZXGouwvBWKFYM5QBt0rmRJq1ff05UmpEPcO0r8QHxmBVUOJPIZ4s
        qx9joZpoT/8mEweIho33NEZqE/0g9WqDX1Q19W98YwQY9LGtduDOyKjZd7umCWfkqcYqq2
        eABzF613pWMDnvmTg6XG7RLQM6x30X8=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 9/9] mtd: rawnand: jz4780-bch: Add support for the JZ4740
Date:   Sat,  2 Feb 2019 20:19:26 -0300
Message-Id: <20190202231926.2444-10-paul@crapouillou.net>
In-Reply-To: <20190202231926.2444-1-paul@crapouillou.net>
References: <20190202231926.2444-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the backend code for the jz4780-bch driver to support the JZ4740
SoC from Ingenic.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Changes:

v2: New patch

 drivers/mtd/nand/raw/ingenic/Makefile         |   2 +-
 drivers/mtd/nand/raw/ingenic/jz4740_bch.c     | 173 ++++++++++++++++++
 .../mtd/nand/raw/ingenic/jz4780_bch_common.c  |   1 +
 .../nand/raw/ingenic/jz4780_bch_internal.h    |   1 +
 4 files changed, 176 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mtd/nand/raw/ingenic/jz4740_bch.c

diff --git a/drivers/mtd/nand/raw/ingenic/Makefile b/drivers/mtd/nand/raw/ingenic/Makefile
index f38b467490cf..d16c96113a93 100644
--- a/drivers/mtd/nand/raw/ingenic/Makefile
+++ b/drivers/mtd/nand/raw/ingenic/Makefile
@@ -1,3 +1,3 @@
 obj-$(CONFIG_MTD_NAND_JZ4740) += jz4740_nand.o
 obj-$(CONFIG_MTD_NAND_JZ4780) += jz4780_nand.o jz4780_bch_common.o \
-				 jz4780_bch.o jz4725b_bch.o
+				 jz4780_bch.o jz4725b_bch.o jz4740_bch.o
diff --git a/drivers/mtd/nand/raw/ingenic/jz4740_bch.c b/drivers/mtd/nand/raw/ingenic/jz4740_bch.c
new file mode 100644
index 000000000000..61ea109cee9d
--- /dev/null
+++ b/drivers/mtd/nand/raw/ingenic/jz4740_bch.c
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * JZ4740 backend code for the jz4780-bch driver
+ * based on jz4740-nand.c
+ *
+ * Copyright (c) 2019 Paul Cercueil <paul@crapouillou.net>
+ */
+
+#include <linux/bitops.h>
+#include <linux/device.h>
+
+#include "jz4780_bch.h"
+#include "jz4780_bch_internal.h"
+
+#define JZ_REG_NAND_ECC_CTRL	0x00
+#define JZ_REG_NAND_DATA	0x04
+#define JZ_REG_NAND_PAR0	0x08
+#define JZ_REG_NAND_PAR1	0x0C
+#define JZ_REG_NAND_PAR2	0x10
+#define JZ_REG_NAND_IRQ_STAT	0x14
+#define JZ_REG_NAND_IRQ_CTRL	0x18
+#define JZ_REG_NAND_ERR(x)	(0x1C + ((x) << 2))
+
+#define JZ_NAND_ECC_CTRL_PAR_READY	BIT(4)
+#define JZ_NAND_ECC_CTRL_ENCODING	BIT(3)
+#define JZ_NAND_ECC_CTRL_RS		BIT(2)
+#define JZ_NAND_ECC_CTRL_RESET		BIT(1)
+#define JZ_NAND_ECC_CTRL_ENABLE		BIT(0)
+
+#define JZ_NAND_STATUS_ERR_COUNT	(BIT(31) | BIT(30) | BIT(29))
+#define JZ_NAND_STATUS_PAD_FINISH	BIT(4)
+#define JZ_NAND_STATUS_DEC_FINISH	BIT(3)
+#define JZ_NAND_STATUS_ENC_FINISH	BIT(2)
+#define JZ_NAND_STATUS_UNCOR_ERROR	BIT(1)
+#define JZ_NAND_STATUS_ERROR		BIT(0)
+
+static const uint8_t empty_block_ecc[] = {
+	0xcd, 0x9d, 0x90, 0x58, 0xf4, 0x8b, 0xff, 0xb7, 0x6f
+};
+
+static void jz4740_bch_init(struct jz4780_bch *bch, bool encode)
+{
+	uint32_t reg;
+
+	/* Clear interrupt status */
+	writel(0, bch->base + JZ_REG_NAND_IRQ_STAT);
+
+	/* Initialize and enable BCH */
+	reg = readl(bch->base + JZ_REG_NAND_ECC_CTRL);
+	reg |= JZ_NAND_ECC_CTRL_RESET;
+	reg |= JZ_NAND_ECC_CTRL_ENABLE;
+	reg |= JZ_NAND_ECC_CTRL_RS;
+	if (encode)
+		reg |= JZ_NAND_ECC_CTRL_ENCODING;
+	else
+		reg &= ~JZ_NAND_ECC_CTRL_ENCODING;
+
+	writel(reg, bch->base + JZ_REG_NAND_ECC_CTRL);
+}
+
+static int jz4740_bch_calculate(struct jz4780_bch *bch,
+				struct jz4780_bch_params *params,
+				const u8 *buf, u8 *ecc_code)
+{
+	uint32_t reg, status;
+	unsigned int timeout = 1000;
+	int i;
+
+	jz4740_bch_init(bch, true);
+
+	do {
+		status = readl(bch->base + JZ_REG_NAND_IRQ_STAT);
+	} while (!(status & JZ_NAND_STATUS_ENC_FINISH) && --timeout);
+
+	if (timeout == 0)
+		return -ETIMEDOUT;
+
+	reg = readl(bch->base + JZ_REG_NAND_ECC_CTRL);
+	reg &= ~JZ_NAND_ECC_CTRL_ENABLE;
+	writel(reg, bch->base + JZ_REG_NAND_ECC_CTRL);
+
+	for (i = 0; i < params->bytes; ++i)
+		ecc_code[i] = readb(bch->base + JZ_REG_NAND_PAR0 + i);
+
+	/* If the written data is completely 0xff, we also want to write 0xff as
+	 * ecc, otherwise we will get in trouble when doing subpage writes.
+	 */
+	if (memcmp(ecc_code, empty_block_ecc, ARRAY_SIZE(empty_block_ecc)) == 0)
+		memset(ecc_code, 0xff, ARRAY_SIZE(empty_block_ecc));
+
+	return 0;
+}
+
+static void jz_nand_correct_data(uint8_t *buf, int index, int mask)
+{
+	int offset = index & 0x7;
+	uint16_t data;
+
+	index += (index >> 3);
+
+	data = buf[index];
+	data |= buf[index + 1] << 8;
+
+	mask ^= (data >> offset) & 0x1ff;
+	data &= ~(0x1ff << offset);
+	data |= (mask << offset);
+
+	buf[index] = data & 0xff;
+	buf[index + 1] = (data >> 8) & 0xff;
+}
+
+static int jz4740_bch_correct(struct jz4780_bch *bch,
+			      struct jz4780_bch_params *params,
+			      u8 *buf, u8 *ecc_code)
+{
+	int i, error_count, index;
+	uint32_t reg, status, error;
+	unsigned int timeout = 1000;
+
+	jz4740_bch_init(bch, false);
+
+	for (i = 0; i < params->bytes; ++i)
+		writeb(ecc_code[i], bch->base + JZ_REG_NAND_PAR0 + i);
+
+	reg = readl(bch->base + JZ_REG_NAND_ECC_CTRL);
+	reg |= JZ_NAND_ECC_CTRL_PAR_READY;
+	writel(reg, bch->base + JZ_REG_NAND_ECC_CTRL);
+
+	do {
+		status = readl(bch->base + JZ_REG_NAND_IRQ_STAT);
+	} while (!(status & JZ_NAND_STATUS_DEC_FINISH) && --timeout);
+
+	if (timeout == 0)
+		return -ETIMEDOUT;
+
+	reg = readl(bch->base + JZ_REG_NAND_ECC_CTRL);
+	reg &= ~JZ_NAND_ECC_CTRL_ENABLE;
+	writel(reg, bch->base + JZ_REG_NAND_ECC_CTRL);
+
+	if (status & JZ_NAND_STATUS_ERROR) {
+		if (status & JZ_NAND_STATUS_UNCOR_ERROR)
+			return -EBADMSG;
+
+		error_count = (status & JZ_NAND_STATUS_ERR_COUNT) >> 29;
+
+		for (i = 0; i < error_count; ++i) {
+			error = readl(bch->base + JZ_REG_NAND_ERR(i));
+			index = ((error >> 16) & 0x1ff) - 1;
+			if (index >= 0 && index < params->size)
+				jz_nand_correct_data(buf, index, error & 0x1ff);
+		}
+
+		return error_count;
+	}
+
+	return 0;
+}
+
+static void jz4740_bch_disable(struct jz4780_bch *bch)
+{
+	u32 reg;
+
+	writel(0, bch->base + JZ_REG_NAND_IRQ_STAT);
+	reg = readl(bch->base + JZ_REG_NAND_ECC_CTRL);
+	reg &= ~JZ_NAND_ECC_CTRL_ENABLE;
+	writel(reg, bch->base + JZ_REG_NAND_ECC_CTRL);
+}
+
+const struct jz4780_bch_ops jz4780_bch_jz4740_ops = {
+	.disable = jz4740_bch_disable,
+	.calculate = jz4740_bch_calculate,
+	.correct = jz4740_bch_correct,
+};
diff --git a/drivers/mtd/nand/raw/ingenic/jz4780_bch_common.c b/drivers/mtd/nand/raw/ingenic/jz4780_bch_common.c
index f505816193a8..c2326286abb2 100644
--- a/drivers/mtd/nand/raw/ingenic/jz4780_bch_common.c
+++ b/drivers/mtd/nand/raw/ingenic/jz4780_bch_common.c
@@ -157,6 +157,7 @@ static int jz4780_bch_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id jz4780_bch_dt_match[] = {
+	{ .compatible = "ingenic,jz4740-bch", .data = &jz4780_bch_jz4740_ops},
 	{ .compatible = "ingenic,jz4725b-bch", .data = &jz4780_bch_jz4725b_ops},
 	{ .compatible = "ingenic,jz4780-bch", .data = &jz4780_bch_jz4780_ops },
 	{},
diff --git a/drivers/mtd/nand/raw/ingenic/jz4780_bch_internal.h b/drivers/mtd/nand/raw/ingenic/jz4780_bch_internal.h
index 462aded811b1..7909a49c57db 100644
--- a/drivers/mtd/nand/raw/ingenic/jz4780_bch_internal.h
+++ b/drivers/mtd/nand/raw/ingenic/jz4780_bch_internal.h
@@ -30,6 +30,7 @@ struct jz4780_bch {
 	struct mutex lock;
 };
 
+extern const struct jz4780_bch_ops jz4780_bch_jz4740_ops;
 extern const struct jz4780_bch_ops jz4780_bch_jz4725b_ops;
 extern const struct jz4780_bch_ops jz4780_bch_jz4780_ops;
 
-- 
2.20.1

