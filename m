Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA80EC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C5282086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:22:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C5282086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbeJPWNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:13:15 -0400
Received: from mail.bootlin.com ([62.4.15.54]:48219 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727524AbeJPWNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:13:15 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E62FA20DE8; Tue, 16 Oct 2018 16:22:30 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6F6A020DEE;
        Tue, 16 Oct 2018 16:22:04 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 14/22] clk: at91: add at91sam9rl PMC driver
Date:   Tue, 16 Oct 2018 16:21:52 +0200
Message-Id: <20181016142200.19741-15-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016142200.19741-1-alexandre.belloni@bootlin.com>
References: <20181016142200.19741-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver for the PMC clocks of the at91sam9rl SoC.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clk/at91/Makefile     |   2 +-
 drivers/clk/at91/at91sam9rl.c | 171 ++++++++++++++++++++++++++++++++++
 2 files changed, 172 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/at91/at91sam9rl.c

diff --git a/drivers/clk/at91/Makefile b/drivers/clk/at91/Makefile
index 78dc71d653de..0752def6271a 100644
--- a/drivers/clk/at91/Makefile
+++ b/drivers/clk/at91/Makefile
@@ -14,6 +14,6 @@ obj-$(CONFIG_HAVE_AT91_SMD)		+= clk-smd.o
 obj-$(CONFIG_HAVE_AT91_H32MX)		+= clk-h32mx.o
 obj-$(CONFIG_HAVE_AT91_GENERATED_CLK)	+= clk-generated.o
 obj-$(CONFIG_HAVE_AT91_I2S_MUX_CLK)	+= clk-i2s-mux.o
-obj-$(CONFIG_SOC_AT91SAM9) += at91sam9260.o at91sam9x5.o
+obj-$(CONFIG_SOC_AT91SAM9) += at91sam9260.o at91sam9rl.o at91sam9x5.o
 obj-$(CONFIG_SOC_SAMA5D4) += sama5d4.o
 obj-$(CONFIG_SOC_SAMA5D2) += sama5d2.o
diff --git a/drivers/clk/at91/at91sam9rl.c b/drivers/clk/at91/at91sam9rl.c
new file mode 100644
index 000000000000..5532fba5825b
--- /dev/null
+++ b/drivers/clk/at91/at91sam9rl.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/clk-provider.h>
+#include <linux/mfd/syscon.h>
+#include <linux/slab.h>
+
+#include <dt-bindings/clock/at91.h>
+
+#include "pmc.h"
+
+static const struct clk_master_characteristics sam9rl_mck_characteristics = {
+	.output = { .min = 0, .max = 94000000 },
+	.divisors = { 1, 2, 4, 0 },
+};
+
+static u8 sam9rl_plla_out[] = { 0, 2 };
+
+static struct clk_range sam9rl_plla_outputs[] = {
+	{ .min = 80000000, .max = 200000000 },
+	{ .min = 190000000, .max = 240000000 },
+};
+
+static const struct clk_pll_characteristics sam9rl_plla_characteristics = {
+	.input = { .min = 1000000, .max = 32000000 },
+	.num_output = ARRAY_SIZE(sam9rl_plla_outputs),
+	.output = sam9rl_plla_outputs,
+	.out = sam9rl_plla_out,
+};
+
+static const struct {
+	char *n;
+	char *p;
+	u8 id;
+} at91sam9rl_systemck[] = {
+	{ .n = "pck0",  .p = "prog0",    .id = 8 },
+	{ .n = "pck1",  .p = "prog1",    .id = 9 },
+};
+
+static const struct {
+	char *n;
+	u8 id;
+} at91sam9rl_periphck[] = {
+	{ .n = "pioA_clk",   .id = 2, },
+	{ .n = "pioB_clk",   .id = 3, },
+	{ .n = "pioC_clk",   .id = 4, },
+	{ .n = "pioD_clk",   .id = 5, },
+	{ .n = "usart0_clk", .id = 6, },
+	{ .n = "usart1_clk", .id = 7, },
+	{ .n = "usart2_clk", .id = 8, },
+	{ .n = "usart3_clk", .id = 9, },
+	{ .n = "mci0_clk",   .id = 10, },
+	{ .n = "twi0_clk",   .id = 11, },
+	{ .n = "twi1_clk",   .id = 12, },
+	{ .n = "spi0_clk",   .id = 13, },
+	{ .n = "ssc0_clk",   .id = 14, },
+	{ .n = "ssc1_clk",   .id = 15, },
+	{ .n = "tc0_clk",    .id = 16, },
+	{ .n = "tc1_clk",    .id = 17, },
+	{ .n = "tc2_clk",    .id = 18, },
+	{ .n = "pwm_clk",    .id = 19, },
+	{ .n = "adc_clk",    .id = 20, },
+	{ .n = "dma0_clk",   .id = 21, },
+	{ .n = "udphs_clk",  .id = 22, },
+	{ .n = "lcd_clk",    .id = 23, },
+};
+
+static void __init at91sam9rl_pmc_setup(struct device_node *np)
+{
+	const char *slck_name, *mainxtal_name;
+	struct pmc_data *at91sam9rl_pmc;
+	const char *parent_names[6];
+	struct regmap *regmap;
+	struct clk_hw *hw;
+	unsigned int i;
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
+	at91sam9rl_pmc = pmc_data_allocate(PMC_MAIN + 1,
+					   nck(at91sam9rl_systemck),
+					   nck(at91sam9rl_periphck), 0);
+	if (!at91sam9rl_pmc)
+		return;
+
+	hw = at91_clk_register_rm9200_main(regmap, "mainck", mainxtal_name);
+	if (IS_ERR(hw))
+		goto err_free;
+
+	at91sam9rl_pmc->chws[PMC_MAIN] = hw;
+
+	hw = at91_clk_register_pll(regmap, "pllack", "mainck", 0,
+				   &at91rm9200_pll_layout,
+				   &sam9rl_plla_characteristics);
+	if (IS_ERR(hw))
+		goto err_free;
+
+	hw = at91_clk_register_utmi(regmap, NULL, "utmick", "mainck");
+	if (IS_ERR(hw))
+		goto err_free;
+
+	at91sam9rl_pmc->chws[PMC_UTMI] = hw;
+
+	parent_names[0] = slck_name;
+	parent_names[1] = "mainck";
+	parent_names[2] = "pllack";
+	parent_names[3] = "utmick";
+	hw = at91_clk_register_master(regmap, "masterck", 4, parent_names,
+				      &at91rm9200_master_layout,
+				      &sam9rl_mck_characteristics);
+	if (IS_ERR(hw))
+		goto err_free;
+
+	at91sam9rl_pmc->chws[PMC_MCK] = hw;
+
+	parent_names[0] = slck_name;
+	parent_names[1] = "mainck";
+	parent_names[2] = "pllack";
+	parent_names[3] = "utmick";
+	parent_names[4] = "masterck";
+	for (i = 0; i < 2; i++) {
+		char name[6];
+
+		snprintf(name, sizeof(name), "prog%d", i);
+
+		hw = at91_clk_register_programmable(regmap, name,
+						    parent_names, 5, i,
+						    &at91rm9200_programmable_layout);
+		if (IS_ERR(hw))
+			goto err_free;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(at91sam9rl_systemck); i++) {
+		hw = at91_clk_register_system(regmap, at91sam9rl_systemck[i].n,
+					      at91sam9rl_systemck[i].p,
+					      at91sam9rl_systemck[i].id);
+		if (IS_ERR(hw))
+			goto err_free;
+
+		at91sam9rl_pmc->shws[at91sam9rl_systemck[i].id] = hw;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(at91sam9rl_periphck); i++) {
+		hw = at91_clk_register_peripheral(regmap,
+						  at91sam9rl_periphck[i].n,
+						  "masterck",
+						  at91sam9rl_periphck[i].id);
+		if (IS_ERR(hw))
+			goto err_free;
+
+		at91sam9rl_pmc->phws[at91sam9rl_periphck[i].id] = hw;
+	}
+
+	of_clk_add_hw_provider(np, of_clk_hw_pmc_get, at91sam9rl_pmc);
+
+	return;
+
+err_free:
+	pmc_data_free(at91sam9rl_pmc);
+}
+CLK_OF_DECLARE_DRIVER(at91sam9rl_pmc, "atmel,at91sam9rl-pmc", at91sam9rl_pmc_setup);
-- 
2.19.1

