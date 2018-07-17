Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBBFECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 22:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEDAB206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 22:29:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEDAB206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731625AbeGQXDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 19:03:17 -0400
Received: from mail.bootlin.com ([62.4.15.54]:59116 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731445AbeGQXDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 19:03:17 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9973320908; Wed, 18 Jul 2018 00:28:27 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id AD1192091A;
        Wed, 18 Jul 2018 00:28:09 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 12/16] clk: at91: add at91sam9x5 PMCs driver
Date:   Wed, 18 Jul 2018 00:27:53 +0200
Message-Id: <20180717222757.10253-13-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180717222757.10253-1-alexandre.belloni@bootlin.com>
References: <20180717222757.10253-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver for the PMC clocks of the at91sam9x5 SoCs

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clk/at91/Makefile     |   1 +
 drivers/clk/at91/at91sam9x5.c | 302 ++++++++++++++++++++++++++++++++++
 2 files changed, 303 insertions(+)
 create mode 100644 drivers/clk/at91/at91sam9x5.c

diff --git a/drivers/clk/at91/Makefile b/drivers/clk/at91/Makefile
index 1e7c70dda723..1802c00b56ca 100644
--- a/drivers/clk/at91/Makefile
+++ b/drivers/clk/at91/Makefile
@@ -14,5 +14,6 @@ obj-$(CONFIG_HAVE_AT91_SMD)		+= clk-smd.o
 obj-$(CONFIG_HAVE_AT91_H32MX)		+= clk-h32mx.o
 obj-$(CONFIG_HAVE_AT91_GENERATED_CLK)	+= clk-generated.o
 obj-$(CONFIG_HAVE_AT91_I2S_MUX_CLK)	+= clk-i2s-mux.o
+obj-$(CONFIG_SOC_AT91SAM9) += at91sam9x5.o
 obj-$(CONFIG_SOC_SAMA5D4) += sama5d4.o
 obj-$(CONFIG_SOC_SAMA5D2) += sama5d2.o
diff --git a/drivers/clk/at91/at91sam9x5.c b/drivers/clk/at91/at91sam9x5.c
new file mode 100644
index 000000000000..f6934ee23724
--- /dev/null
+++ b/drivers/clk/at91/at91sam9x5.c
@@ -0,0 +1,302 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/clk-provider.h>
+#include <linux/mfd/syscon.h>
+#include <linux/slab.h>
+
+#include <dt-bindings/clock/at91.h>
+
+#include "pmc.h"
+
+static const struct clk_master_characteristics mck_characteristics = {
+	.output = { .min = 0, .max = 133333333 },
+	.divisors = { 1, 2, 4, 3 },
+	.have_div3_pres = 1,
+};
+
+static u8 plla_out[] = { 0, 1, 2, 3, 0, 1, 2, 3 };
+
+static u16 plla_icpll[] = { 0, 0, 0, 0, 1, 1, 1, 1 };
+
+static struct clk_range plla_outputs[] = {
+	{ .min = 745000000, .max = 800000000 },
+	{ .min = 695000000, .max = 750000000 },
+	{ .min = 645000000, .max = 700000000 },
+	{ .min = 595000000, .max = 650000000 },
+	{ .min = 545000000, .max = 600000000 },
+	{ .min = 495000000, .max = 555000000 },
+	{ .min = 445000000, .max = 500000000 },
+	{ .min = 400000000, .max = 450000000 },
+};
+
+static const struct clk_pll_characteristics plla_characteristics = {
+	.input = { .min = 2000000, .max = 32000000 },
+	.num_output = ARRAY_SIZE(plla_outputs),
+	.output = plla_outputs,
+	.icpll = plla_icpll,
+	.out = plla_out,
+};
+
+static const struct {
+	char *n;
+	char *p;
+	u8 id;
+} at91sam9x5_systemck[] = {
+	{ .n = "ddrck", .p = "masterck", .id = 2 },
+	{ .n = "smdck", .p = "smdclk",   .id = 4 },
+	{ .n = "uhpck", .p = "usbck",    .id = 6 },
+	{ .n = "udpck", .p = "usbck",    .id = 7 },
+	{ .n = "pck0",  .p = "prog0",    .id = 8 },
+	{ .n = "pck1",  .p = "prog1",    .id = 9 },
+};
+
+struct pck {
+	char *n;
+	u8 id;
+};
+
+static const struct pck at91sam9x5_periphck[] = {
+	{ .n = "pioAB_clk",  .id = 2, },
+	{ .n = "pioCD_clk",  .id = 3, },
+	{ .n = "smd_clk",    .id = 4, },
+	{ .n = "usart0_clk", .id = 5, },
+	{ .n = "usart1_clk", .id = 6, },
+	{ .n = "usart2_clk", .id = 7, },
+	{ .n = "twi0_clk",   .id = 9, },
+	{ .n = "twi1_clk",   .id = 10, },
+	{ .n = "twi2_clk",   .id = 11, },
+	{ .n = "mci0_clk",   .id = 12, },
+	{ .n = "spi0_clk",   .id = 13, },
+	{ .n = "spi1_clk",   .id = 14, },
+	{ .n = "uart0_clk",  .id = 15, },
+	{ .n = "uart1_clk",  .id = 16, },
+	{ .n = "tcb0_clk",   .id = 17, },
+	{ .n = "pwm_clk",    .id = 18, },
+	{ .n = "adc_clk",    .id = 19, },
+	{ .n = "dma0_clk",   .id = 20, },
+	{ .n = "dma1_clk",   .id = 21, },
+	{ .n = "uhphs_clk",  .id = 22, },
+	{ .n = "udphs_clk",  .id = 23, },
+	{ .n = "mci1_clk",   .id = 26, },
+	{ .n = "ssc0_clk",   .id = 28, },
+};
+
+static const struct pck at91sam9g15_periphck[] = {
+	{ .n = "lcdc_clk", .id = 25, },
+	{ /* sentinel */}
+};
+
+static const struct pck at91sam9g25_periphck[] = {
+	{ .n = "usart3_clk", .id = 8, },
+	{ .n = "macb0_clk", .id = 24, },
+	{ .n = "isi_clk", .id = 25, },
+	{ /* sentinel */}
+};
+
+static const struct pck at91sam9g35_periphck[] = {
+	{ .n = "macb0_clk", .id = 24, },
+	{ .n = "lcdc_clk", .id = 25, },
+	{ /* sentinel */}
+};
+
+static const struct pck at91sam9x25_periphck[] = {
+	{ .n = "usart3_clk", .id = 8, },
+	{ .n = "macb0_clk", .id = 24, },
+	{ .n = "macb1_clk", .id = 27, },
+	{ .n = "can0_clk", .id = 29, },
+	{ .n = "can1_clk", .id = 30, },
+	{ /* sentinel */}
+};
+
+static const struct pck at91sam9x35_periphck[] = {
+	{ .n = "macb0_clk", .id = 24, },
+	{ .n = "lcdc_clk", .id = 25, },
+	{ .n = "can0_clk", .id = 29, },
+	{ .n = "can1_clk", .id = 30, },
+	{ /* sentinel */}
+};
+
+static void __init at91sam9x5_pmc_setup(struct device_node *np,
+					const struct pck *extra_pcks,
+					bool has_lcdck)
+{
+	struct clk_range range = CLK_RANGE(0, 0);
+	const char *slck_name, *mainxtal_name;
+	struct pmc_data *at91sam9x5_pmc;
+	const char *parent_names[6];
+	struct regmap *regmap;
+	struct clk_hw *hw;
+	unsigned int i;
+	bool bypass;
+
+	i = of_property_match_string(np, "clock-names", "slow_clk");
+	if (i < 0)
+		return;
+
+	slck_name = of_clk_get_parent_name(np, i);
+
+	i = of_property_match_string(np, "clock-names", "main_xtal");
+	if (i < 0)
+		return;
+	mainxtal_name = of_clk_get_parent_name(np, i);
+
+	regmap = syscon_node_to_regmap(np);
+	if (IS_ERR(regmap))
+		return;
+
+	at91sam9x5_pmc = pmc_data_allocate(4, 10, 29, 0);
+	if (!at91sam9x5_pmc)
+		return;
+
+	hw = at91_clk_register_main_rc_osc(regmap, "main_rc_osc", 12000000,
+					   50000000);
+	if (IS_ERR(hw))
+		goto err_free;
+
+	bypass = of_property_read_bool(np, "atmel,osc-bypass");
+
+	hw = at91_clk_register_main_osc(regmap, "main_osc", mainxtal_name,
+					bypass);
+	if (IS_ERR(hw))
+		goto err_free;
+
+	parent_names[0] = "main_rc_osc";
+	parent_names[1] = "main_osc";
+	hw = at91_clk_register_sam9x5_main(regmap, "mainck", parent_names, 2);
+	if (IS_ERR(hw))
+		goto err_free;
+
+	at91sam9x5_pmc->chws[PMC_MAIN] = hw;
+
+	hw = at91_clk_register_pll(regmap, "pllack", "mainck", 0,
+				   &at91rm9200_pll_layout, &plla_characteristics);
+	if (IS_ERR(hw))
+		goto err_free;
+
+	hw = at91_clk_register_plldiv(regmap, "plladivck", "pllack");
+	if (IS_ERR(hw))
+		goto err_free;
+
+	hw = at91_clk_register_utmi(regmap, NULL, "utmick", "mainck");
+	if (IS_ERR(hw))
+		goto err_free;
+
+	at91sam9x5_pmc->chws[PMC_UTMI] = hw;
+
+	parent_names[0] = slck_name;
+	parent_names[1] = "mainck";
+	parent_names[2] = "plladivck";
+	parent_names[3] = "utmick";
+	hw = at91_clk_register_master(regmap, "masterck", 4, parent_names,
+				      &at91sam9x5_master_layout,
+				      &mck_characteristics);
+	if (IS_ERR(hw))
+		goto err_free;
+
+	at91sam9x5_pmc->chws[PMC_MCK] = hw;
+
+	parent_names[0] = "plladivck";
+	parent_names[1] = "utmick";
+	hw = at91sam9x5_clk_register_usb(regmap, "usbck", parent_names, 2);
+	if (IS_ERR(hw))
+		goto err_free;
+
+	hw = at91sam9x5_clk_register_smd(regmap, "smdclk", parent_names, 2);
+	if (IS_ERR(hw))
+		goto err_free;
+
+	parent_names[0] = slck_name;
+	parent_names[1] = "mainck";
+	parent_names[2] = "plladivck";
+	parent_names[3] = "utmick";
+	parent_names[4] = "mck";
+	for (i = 0; i < 2; i++) {
+		char name[6];
+
+		snprintf(name, sizeof(name), "prog%d", i);
+
+		hw = at91_clk_register_programmable(regmap, name,
+						    parent_names, 5, i,
+						    &at91sam9x5_programmable_layout);
+		if (IS_ERR(hw))
+			goto err_free;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(at91sam9x5_systemck); i++) {
+		hw = at91_clk_register_system(regmap, at91sam9x5_systemck[i].n,
+					      at91sam9x5_systemck[i].p,
+					      at91sam9x5_systemck[i].id);
+		if (IS_ERR(hw))
+			goto err_free;
+
+		at91sam9x5_pmc->shws[at91sam9x5_systemck[i].id] = hw;
+	}
+
+	if (has_lcdck) {
+		hw = at91_clk_register_system(regmap, "lcdck", "masterck", 3);
+		if (IS_ERR(hw))
+			goto err_free;
+
+		at91sam9x5_pmc->shws[3] = hw;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(at91sam9x5_periphck); i++) {
+		hw = at91_clk_register_sam9x5_peripheral(regmap, &pmc_pcr_lock,
+							 at91sam9x5_periphck[i].n,
+							 "masterck",
+							 at91sam9x5_periphck[i].id,
+							 &range);
+		if (IS_ERR(hw))
+			goto err_free;
+
+		at91sam9x5_pmc->phws[at91sam9x5_periphck[i].id] = hw;
+	}
+
+	for (i = 0; extra_pcks[i].id; i++) {
+		hw = at91_clk_register_sam9x5_peripheral(regmap, &pmc_pcr_lock,
+							 extra_pcks[i].n,
+							 "masterck",
+							 extra_pcks[i].id,
+							 &range);
+		if (IS_ERR(hw))
+			goto err_free;
+
+		at91sam9x5_pmc->phws[extra_pcks[i].id] = hw;
+	}
+
+	of_clk_add_hw_provider(np, of_clk_hw_pmc_get, at91sam9x5_pmc);
+
+	return;
+
+err_free:
+	pmc_data_free(at91sam9x5_pmc);
+}
+
+static void __init at91sam9g15_pmc_setup(struct device_node *np)
+{
+	at91sam9x5_pmc_setup(np, at91sam9g15_periphck, true);
+}
+CLK_OF_DECLARE(at91sam9g15_pmc, "atmel,at91sam9g15-pmc", at91sam9g15_pmc_setup);
+
+static void __init at91sam9g25_pmc_setup(struct device_node *np)
+{
+	at91sam9x5_pmc_setup(np, at91sam9g25_periphck, false);
+}
+CLK_OF_DECLARE(at91sam9g25_pmc, "atmel,at91sam9g25-pmc", at91sam9g25_pmc_setup);
+
+static void __init at91sam9g35_pmc_setup(struct device_node *np)
+{
+	at91sam9x5_pmc_setup(np, at91sam9g35_periphck, true);
+}
+CLK_OF_DECLARE(at91sam9g35_pmc, "atmel,at91sam9g35-pmc", at91sam9g35_pmc_setup);
+
+static void __init at91sam9x25_pmc_setup(struct device_node *np)
+{
+	at91sam9x5_pmc_setup(np, at91sam9x25_periphck, false);
+}
+CLK_OF_DECLARE(at91sam9x25_pmc, "atmel,at91sam9x25-pmc", at91sam9x25_pmc_setup);
+
+static void __init at91sam9x35_pmc_setup(struct device_node *np)
+{
+	at91sam9x5_pmc_setup(np, at91sam9x35_periphck, true);
+}
+CLK_OF_DECLARE(at91sam9x35_pmc, "atmel,at91sam9x35-pmc", at91sam9x35_pmc_setup);
-- 
2.18.0

