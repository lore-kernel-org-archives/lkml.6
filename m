Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C84BC43615
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 13:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE5452086E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 13:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="IJcep0lj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE5452086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730331AbeHWQrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 12:47:43 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:55084 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727563AbeHWQrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 12:47:43 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     od@zcrc.me, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 4/4] clk: Add Ingenic jz4725b CGU driver
Date:   Thu, 23 Aug 2018 15:17:44 +0200
Message-Id: <20180823131744.744-4-paul@crapouillou.net>
In-Reply-To: <20180823131744.744-1-paul@crapouillou.net>
References: <20180823131744.744-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1535030280; bh=viyIbXr4SdGYl7Ww1wT4lpAmCuejXMEI4GMV0+lVpsg=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=IJcep0lj2ZWj5bOZBqcuRuBoR5QFLeFtYQbqkvTqbEfAtH/ovtwK11ghlZBk157Tvzw1H556o3T4OBcS7+iKfp/+/3f8rLFpZuwsBOXMdNVigh6SHDgVwzSnoZmfi/gy+nUu3Hi4N/BBuGamqPVMIb3UW+Q3ARycLhsLR0tB1S8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the clocks provided by the CGU in the Ingenic JZ4725B
SoC.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    No change

 drivers/clk/ingenic/Kconfig       |  10 ++
 drivers/clk/ingenic/Makefile      |   1 +
 drivers/clk/ingenic/jz4725b-cgu.c | 225 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 236 insertions(+)
 create mode 100644 drivers/clk/ingenic/jz4725b-cgu.c

diff --git a/drivers/clk/ingenic/Kconfig b/drivers/clk/ingenic/Kconfig
index 2445437f8286..34dc0da79c39 100644
--- a/drivers/clk/ingenic/Kconfig
+++ b/drivers/clk/ingenic/Kconfig
@@ -14,6 +14,16 @@ config INGENIC_CGU_JZ4740
 
 	  If building for a JZ4740 SoC, you want to say Y here.
 
+config INGENIC_CGU_JZ4725B
+	bool "Ingenic JZ4725B CGU driver"
+	default MACH_JZ4725B
+	select INGENIC_CGU_COMMON
+	help
+	  Support the clocks provided by the CGU hardware on Ingenic JZ4725B
+	  and compatible SoCs.
+
+	  If building for a JZ4725B SoC, you want to say Y here.
+
 config INGENIC_CGU_JZ4770
 	bool "Ingenic JZ4770 CGU driver"
 	default MACH_JZ4770
diff --git a/drivers/clk/ingenic/Makefile b/drivers/clk/ingenic/Makefile
index 8b8dc79c7ce6..00a79b2fba10 100644
--- a/drivers/clk/ingenic/Makefile
+++ b/drivers/clk/ingenic/Makefile
@@ -1,4 +1,5 @@
 obj-$(CONFIG_INGENIC_CGU_COMMON)	+= cgu.o
 obj-$(CONFIG_INGENIC_CGU_JZ4740)	+= jz4740-cgu.o
+obj-$(CONFIG_INGENIC_CGU_JZ4725B)	+= jz4725b-cgu.o
 obj-$(CONFIG_INGENIC_CGU_JZ4770)	+= jz4770-cgu.o
 obj-$(CONFIG_INGENIC_CGU_JZ4780)	+= jz4780-cgu.o
diff --git a/drivers/clk/ingenic/jz4725b-cgu.c b/drivers/clk/ingenic/jz4725b-cgu.c
new file mode 100644
index 000000000000..584ff4ff81c7
--- /dev/null
+++ b/drivers/clk/ingenic/jz4725b-cgu.c
@@ -0,0 +1,225 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Ingenic JZ4725B SoC CGU driver
+ *
+ * Copyright (C) 2018 Paul Cercueil
+ * Author: Paul Cercueil <paul@crapouillou.net>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/delay.h>
+#include <linux/of.h>
+#include <dt-bindings/clock/jz4725b-cgu.h>
+#include "cgu.h"
+
+/* CGU register offsets */
+#define CGU_REG_CPCCR		0x00
+#define CGU_REG_LCR		0x04
+#define CGU_REG_CPPCR		0x10
+#define CGU_REG_CLKGR		0x20
+#define CGU_REG_OPCR		0x24
+#define CGU_REG_I2SCDR		0x60
+#define CGU_REG_LPCDR		0x64
+#define CGU_REG_MSCCDR		0x68
+#define CGU_REG_SSICDR		0x74
+#define CGU_REG_CIMCDR		0x78
+
+/* bits within the LCR register */
+#define LCR_SLEEP		BIT(0)
+
+static struct ingenic_cgu *cgu;
+
+static const s8 pll_od_encoding[4] = {
+	0x0, 0x1, -1, 0x3,
+};
+
+static const struct ingenic_cgu_clk_info jz4725b_cgu_clocks[] = {
+
+	/* External clocks */
+
+	[JZ4725B_CLK_EXT] = { "ext", CGU_CLK_EXT },
+	[JZ4725B_CLK_OSC32K] = { "osc32k", CGU_CLK_EXT },
+
+	[JZ4725B_CLK_PLL] = {
+		"pll", CGU_CLK_PLL,
+		.parents = { JZ4725B_CLK_EXT, -1, -1, -1 },
+		.pll = {
+			.reg = CGU_REG_CPPCR,
+			.m_shift = 23,
+			.m_bits = 9,
+			.m_offset = 2,
+			.n_shift = 18,
+			.n_bits = 5,
+			.n_offset = 2,
+			.od_shift = 16,
+			.od_bits = 2,
+			.od_max = 4,
+			.od_encoding = pll_od_encoding,
+			.stable_bit = 10,
+			.bypass_bit = 9,
+			.enable_bit = 8,
+		},
+	},
+
+	/* Muxes & dividers */
+
+	[JZ4725B_CLK_PLL_HALF] = {
+		"pll half", CGU_CLK_DIV,
+		.parents = { JZ4725B_CLK_PLL, -1, -1, -1 },
+		.div = { CGU_REG_CPCCR, 21, 1, 1, -1, -1, -1 },
+	},
+
+	[JZ4725B_CLK_CCLK] = {
+		"cclk", CGU_CLK_DIV,
+		.parents = { JZ4725B_CLK_PLL, -1, -1, -1 },
+		.div = { CGU_REG_CPCCR, 0, 1, 4, 22, -1, -1 },
+	},
+
+	[JZ4725B_CLK_HCLK] = {
+		"hclk", CGU_CLK_DIV,
+		.parents = { JZ4725B_CLK_PLL, -1, -1, -1 },
+		.div = { CGU_REG_CPCCR, 4, 1, 4, 22, -1, -1 },
+	},
+
+	[JZ4725B_CLK_PCLK] = {
+		"pclk", CGU_CLK_DIV,
+		.parents = { JZ4725B_CLK_PLL, -1, -1, -1 },
+		.div = { CGU_REG_CPCCR, 8, 1, 4, 22, -1, -1 },
+	},
+
+	[JZ4725B_CLK_MCLK] = {
+		"mclk", CGU_CLK_DIV,
+		.parents = { JZ4725B_CLK_PLL, -1, -1, -1 },
+		.div = { CGU_REG_CPCCR, 12, 1, 4, 22, -1, -1 },
+	},
+
+	[JZ4725B_CLK_IPU] = {
+		"ipu", CGU_CLK_DIV | CGU_CLK_GATE,
+		.parents = { JZ4725B_CLK_PLL, -1, -1, -1 },
+		.div = { CGU_REG_CPCCR, 16, 1, 4, 22, -1, -1 },
+		.gate = { CGU_REG_CLKGR, 13 },
+	},
+
+	[JZ4725B_CLK_LCD] = {
+		"lcd", CGU_CLK_DIV | CGU_CLK_GATE,
+		.parents = { JZ4725B_CLK_PLL_HALF, -1, -1, -1 },
+		.div = { CGU_REG_LPCDR, 0, 1, 11, -1, -1, -1 },
+		.gate = { CGU_REG_CLKGR, 9 },
+	},
+
+	[JZ4725B_CLK_I2S] = {
+		"i2s", CGU_CLK_MUX | CGU_CLK_DIV | CGU_CLK_GATE,
+		.parents = { JZ4725B_CLK_EXT, JZ4725B_CLK_PLL_HALF, -1, -1 },
+		.mux = { CGU_REG_CPCCR, 31, 1 },
+		.div = { CGU_REG_I2SCDR, 0, 1, 9, -1, -1, -1 },
+		.gate = { CGU_REG_CLKGR, 6 },
+	},
+
+	[JZ4725B_CLK_SPI] = {
+		"spi", CGU_CLK_MUX | CGU_CLK_DIV | CGU_CLK_GATE,
+		.parents = { JZ4725B_CLK_EXT, JZ4725B_CLK_PLL, -1, -1 },
+		.mux = { CGU_REG_SSICDR, 31, 1 },
+		.div = { CGU_REG_SSICDR, 0, 1, 4, -1, -1, -1 },
+		.gate = { CGU_REG_CLKGR, 4 },
+	},
+
+	[JZ4725B_CLK_MMC_MUX] = {
+		"mmc_mux", CGU_CLK_DIV,
+		.parents = { JZ4725B_CLK_PLL_HALF, -1, -1, -1 },
+		.div = { CGU_REG_MSCCDR, 0, 1, 5, -1, -1, -1 },
+	},
+
+	[JZ4725B_CLK_UDC] = {
+		"udc", CGU_CLK_MUX | CGU_CLK_DIV,
+		.parents = { JZ4725B_CLK_EXT, JZ4725B_CLK_PLL_HALF, -1, -1 },
+		.mux = { CGU_REG_CPCCR, 29, 1 },
+		.div = { CGU_REG_CPCCR, 23, 1, 6, -1, -1, -1 },
+	},
+
+	/* Gate-only clocks */
+
+	[JZ4725B_CLK_UART] = {
+		"uart", CGU_CLK_GATE,
+		.parents = { JZ4725B_CLK_EXT, -1, -1, -1 },
+		.gate = { CGU_REG_CLKGR, 0 },
+	},
+
+	[JZ4725B_CLK_DMA] = {
+		"dma", CGU_CLK_GATE,
+		.parents = { JZ4725B_CLK_PCLK, -1, -1, -1 },
+		.gate = { CGU_REG_CLKGR, 12 },
+	},
+
+	[JZ4725B_CLK_ADC] = {
+		"adc", CGU_CLK_GATE,
+		.parents = { JZ4725B_CLK_EXT, -1, -1, -1 },
+		.gate = { CGU_REG_CLKGR, 7 },
+	},
+
+	[JZ4725B_CLK_I2C] = {
+		"i2c", CGU_CLK_GATE,
+		.parents = { JZ4725B_CLK_EXT, -1, -1, -1 },
+		.gate = { CGU_REG_CLKGR, 3 },
+	},
+
+	[JZ4725B_CLK_AIC] = {
+		"aic", CGU_CLK_GATE,
+		.parents = { JZ4725B_CLK_EXT, -1, -1, -1 },
+		.gate = { CGU_REG_CLKGR, 5 },
+	},
+
+	[JZ4725B_CLK_MMC0] = {
+		"mmc0", CGU_CLK_GATE,
+		.parents = { JZ4725B_CLK_MMC_MUX, -1, -1, -1 },
+		.gate = { CGU_REG_CLKGR, 6 },
+	},
+
+	[JZ4725B_CLK_MMC1] = {
+		"mmc1", CGU_CLK_GATE,
+		.parents = { JZ4725B_CLK_MMC_MUX, -1, -1, -1 },
+		.gate = { CGU_REG_CLKGR, 16 },
+	},
+
+	[JZ4725B_CLK_BCH] = {
+		"bch", CGU_CLK_GATE,
+		.parents = { JZ4725B_CLK_MCLK/* not sure */, -1, -1, -1 },
+		.gate = { CGU_REG_CLKGR, 11 },
+	},
+
+	[JZ4725B_CLK_TCU] = {
+		"tcu", CGU_CLK_GATE,
+		.parents = { JZ4725B_CLK_EXT/* not sure */, -1, -1, -1 },
+		.gate = { CGU_REG_CLKGR, 1 },
+	},
+
+	[JZ4725B_CLK_EXT512] = {
+		"ext/512", CGU_CLK_FIXDIV,
+		.parents = { JZ4725B_CLK_EXT },
+
+		/* Doc calls it EXT512, but it seems to be /256... */
+		.fixdiv = { 256 },
+	},
+
+	[JZ4725B_CLK_RTC] = {
+		"rtc", CGU_CLK_MUX,
+		.parents = { JZ4725B_CLK_EXT512, JZ4725B_CLK_OSC32K, -1, -1 },
+		.mux = { CGU_REG_OPCR, 2, 1},
+	},
+};
+
+static void __init jz4725b_cgu_init(struct device_node *np)
+{
+	int retval;
+
+	cgu = ingenic_cgu_new(jz4725b_cgu_clocks,
+			      ARRAY_SIZE(jz4725b_cgu_clocks), np);
+	if (!cgu) {
+		pr_err("%s: failed to initialise CGU\n", __func__);
+		return;
+	}
+
+	retval = ingenic_cgu_register_clocks(cgu);
+	if (retval)
+		pr_err("%s: failed to register CGU Clocks\n", __func__);
+}
+CLK_OF_DECLARE(jz4725b_cgu, "ingenic,jz4725b-cgu", jz4725b_cgu_init);
-- 
2.11.0

