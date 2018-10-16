Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3920C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8DD32086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:23:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8DD32086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbeJPWOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:14:35 -0400
Received: from mail.bootlin.com ([62.4.15.54]:48182 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727386AbeJPWNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:13:07 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id F325A20E0A; Tue, 16 Oct 2018 16:22:22 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4A2FA20DD8;
        Tue, 16 Oct 2018 16:22:03 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 10/22] clk: at91: add sama5d4 pmc driver
Date:   Tue, 16 Oct 2018 16:21:48 +0200
Message-Id: <20181016142200.19741-11-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016142200.19741-1-alexandre.belloni@bootlin.com>
References: <20181016142200.19741-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver for the PMC clocks of the sama5d4

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clk/at91/Makefile  |   1 +
 drivers/clk/at91/sama5d4.c | 264 +++++++++++++++++++++++++++++++++++++
 2 files changed, 265 insertions(+)
 create mode 100644 drivers/clk/at91/sama5d4.c

diff --git a/drivers/clk/at91/Makefile b/drivers/clk/at91/Makefile
index facc169ebb68..7cdb762f3e2e 100644
--- a/drivers/clk/at91/Makefile
+++ b/drivers/clk/at91/Makefile
@@ -14,3 +14,4 @@ obj-$(CONFIG_HAVE_AT91_SMD)		+= clk-smd.o
 obj-$(CONFIG_HAVE_AT91_H32MX)		+= clk-h32mx.o
 obj-$(CONFIG_HAVE_AT91_GENERATED_CLK)	+= clk-generated.o
 obj-$(CONFIG_HAVE_AT91_I2S_MUX_CLK)	+= clk-i2s-mux.o
+obj-$(CONFIG_SOC_SAMA5D4) += sama5d4.o
diff --git a/drivers/clk/at91/sama5d4.c b/drivers/clk/at91/sama5d4.c
new file mode 100644
index 000000000000..64b9f438f73b
--- /dev/null
+++ b/drivers/clk/at91/sama5d4.c
@@ -0,0 +1,264 @@
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
+	.output = { .min = 125000000, .max = 200000000 },
+	.divisors = { 1, 2, 4, 3 },
+};
+
+static u8 plla_out[] = { 0 };
+
+static u16 plla_icpll[] = { 0 };
+
+static struct clk_range plla_outputs[] = {
+	{ .min = 600000000, .max = 1200000000 },
+};
+
+static const struct clk_pll_characteristics plla_characteristics = {
+	.input = { .min = 12000000, .max = 12000000 },
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
+} sama5d4_systemck[] = {
+	{ .n = "ddrck", .p = "masterck", .id = 2 },
+	{ .n = "lcdck", .p = "masterck", .id = 3 },
+	{ .n = "smdck", .p = "smdclk",   .id = 4 },
+	{ .n = "uhpck", .p = "usbck",    .id = 6 },
+	{ .n = "udpck", .p = "usbck",    .id = 7 },
+	{ .n = "pck0",  .p = "prog0",    .id = 8 },
+	{ .n = "pck1",  .p = "prog1",    .id = 9 },
+	{ .n = "pck2",  .p = "prog2",    .id = 10 },
+};
+
+static const struct {
+	char *n;
+	u8 id;
+} sama5d4_periph32ck[] = {
+	{ .n = "pioD_clk", .id = 5 },
+	{ .n = "usart0_clk", .id = 6 },
+	{ .n = "usart1_clk", .id = 7 },
+	{ .n = "icm_clk", .id = 9 },
+	{ .n = "aes_clk", .id = 12 },
+	{ .n = "tdes_clk", .id = 14 },
+	{ .n = "sha_clk", .id = 15 },
+	{ .n = "matrix1_clk", .id = 17 },
+	{ .n = "hsmc_clk", .id = 22 },
+	{ .n = "pioA_clk", .id = 23 },
+	{ .n = "pioB_clk", .id = 24 },
+	{ .n = "pioC_clk", .id = 25 },
+	{ .n = "pioE_clk", .id = 26 },
+	{ .n = "uart0_clk", .id = 27 },
+	{ .n = "uart1_clk", .id = 28 },
+	{ .n = "usart2_clk", .id = 29 },
+	{ .n = "usart3_clk", .id = 30 },
+	{ .n = "usart4_clk", .id = 31 },
+	{ .n = "twi0_clk", .id = 32 },
+	{ .n = "twi1_clk", .id = 33 },
+	{ .n = "twi2_clk", .id = 34 },
+	{ .n = "mci0_clk", .id = 35 },
+	{ .n = "mci1_clk", .id = 36 },
+	{ .n = "spi0_clk", .id = 37 },
+	{ .n = "spi1_clk", .id = 38 },
+	{ .n = "spi2_clk", .id = 39 },
+	{ .n = "tcb0_clk", .id = 40 },
+	{ .n = "tcb1_clk", .id = 41 },
+	{ .n = "tcb2_clk", .id = 42 },
+	{ .n = "pwm_clk", .id = 43 },
+	{ .n = "adc_clk", .id = 44 },
+	{ .n = "dbgu_clk", .id = 45 },
+	{ .n = "uhphs_clk", .id = 46 },
+	{ .n = "udphs_clk", .id = 47 },
+	{ .n = "ssc0_clk", .id = 48 },
+	{ .n = "ssc1_clk", .id = 49 },
+	{ .n = "trng_clk", .id = 53 },
+	{ .n = "macb0_clk", .id = 54 },
+	{ .n = "macb1_clk", .id = 55 },
+	{ .n = "fuse_clk", .id = 57 },
+	{ .n = "securam_clk", .id = 59 },
+	{ .n = "smd_clk", .id = 61 },
+	{ .n = "twi3_clk", .id = 62 },
+	{ .n = "catb_clk", .id = 63 },
+};
+
+static const struct {
+	char *n;
+	u8 id;
+} sama5d4_periphck[] = {
+	{ .n = "dma0_clk", .id = 8 },
+	{ .n = "cpkcc_clk", .id = 10 },
+	{ .n = "aesb_clk", .id = 13 },
+	{ .n = "mpddr_clk", .id = 16 },
+	{ .n = "matrix0_clk", .id = 18 },
+	{ .n = "vdec_clk", .id = 19 },
+	{ .n = "dma1_clk", .id = 50 },
+	{ .n = "lcdc_clk", .id = 51 },
+	{ .n = "isi_clk", .id = 52 },
+};
+
+static void __init sama5d4_pmc_setup(struct device_node *np)
+{
+	struct clk_range range = CLK_RANGE(0, 0);
+	const char *slck_name, *mainxtal_name;
+	struct pmc_data *sama5d4_pmc;
+	const char *parent_names[5];
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
+	sama5d4_pmc = pmc_data_allocate(PMC_MCK2 +1,
+					nck(sama5d4_systemck),
+					nck(sama5d4_periph32ck), 0);
+	if (!sama5d4_pmc)
+		return;
+
+	hw = at91_clk_register_main_rc_osc(regmap, "main_rc_osc", 12000000,
+					   100000000);
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
+	hw = at91_clk_register_pll(regmap, "pllack", "mainck", 0,
+				   &sama5d3_pll_layout, &plla_characteristics);
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
+	sama5d4_pmc->chws[PMC_UTMI] = hw;
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
+	sama5d4_pmc->chws[PMC_MCK] = hw;
+
+	hw = at91_clk_register_h32mx(regmap, "h32mxck", "masterck");
+	if (IS_ERR(hw))
+		goto err_free;
+
+	sama5d4_pmc->chws[PMC_MCK2] = hw;
+
+	parent_names[0] = "plladivck";
+	parent_names[1] = "utmick";
+	hw = at91sam9x5_clk_register_usb(regmap, "usbck", parent_names, 2);
+	if (IS_ERR(hw))
+		goto err_free;
+
+	parent_names[0] = "plladivck";
+	parent_names[1] = "utmick";
+	hw = at91sam9x5_clk_register_smd(regmap, "smdclk", parent_names, 2);
+	if (IS_ERR(hw))
+		goto err_free;
+
+	parent_names[0] = slck_name;
+	parent_names[1] = "mainck";
+	parent_names[2] = "plladivck";
+	parent_names[3] = "utmick";
+	parent_names[4] = "mck";
+	for (i = 0; i < 3; i++) {
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
+	for (i = 0; i < ARRAY_SIZE(sama5d4_systemck); i++) {
+		hw = at91_clk_register_system(regmap, sama5d4_systemck[i].n,
+					      sama5d4_systemck[i].p,
+					      sama5d4_systemck[i].id);
+		if (IS_ERR(hw))
+			goto err_free;
+
+		sama5d4_pmc->shws[sama5d4_systemck[i].id] = hw;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(sama5d4_periphck); i++) {
+		hw = at91_clk_register_sam9x5_peripheral(regmap, &pmc_pcr_lock,
+							 sama5d4_periphck[i].n,
+							 "masterck",
+							 sama5d4_periphck[i].id,
+							 &range);
+		if (IS_ERR(hw))
+			goto err_free;
+
+		sama5d4_pmc->phws[sama5d4_periphck[i].id] = hw;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(sama5d4_periph32ck); i++) {
+		hw = at91_clk_register_sam9x5_peripheral(regmap, &pmc_pcr_lock,
+							 sama5d4_periph32ck[i].n,
+							 "h32mxck",
+							 sama5d4_periph32ck[i].id,
+							 &range);
+		if (IS_ERR(hw))
+			goto err_free;
+
+		sama5d4_pmc->phws[sama5d4_periph32ck[i].id] = hw;
+	}
+
+	of_clk_add_hw_provider(np, of_clk_hw_pmc_get, sama5d4_pmc);
+
+	return;
+
+err_free:
+	pmc_data_free(sama5d4_pmc);
+}
+CLK_OF_DECLARE_DRIVER(sama5d4_pmc, "atmel,sama5d4-pmc", sama5d4_pmc_setup);
-- 
2.19.1

