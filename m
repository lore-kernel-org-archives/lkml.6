Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23411C169D4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDE6720881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:23:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDE6720881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbeJPWOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:14:16 -0400
Received: from mail.bootlin.com ([62.4.15.54]:48217 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727401AbeJPWNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:13:15 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id DE3FC20719; Tue, 16 Oct 2018 16:22:30 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id D6C2C20DE6;
        Tue, 16 Oct 2018 16:22:03 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 12/22] clk: at91: add at91sam9260 PMC driver
Date:   Tue, 16 Oct 2018 16:21:50 +0200
Message-Id: <20181016142200.19741-13-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016142200.19741-1-alexandre.belloni@bootlin.com>
References: <20181016142200.19741-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver for the PMC clocks of the at91sam9260, at91sam9261,
at91am9263 and at91sam9g20 SoCs.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/clk/at91/Makefile      |   1 +
 drivers/clk/at91/at91sam9260.c | 494 +++++++++++++++++++++++++++++++++
 2 files changed, 495 insertions(+)
 create mode 100644 drivers/clk/at91/at91sam9260.c

diff --git a/drivers/clk/at91/Makefile b/drivers/clk/at91/Makefile
index 1e7c70dda723..08399003c752 100644
--- a/drivers/clk/at91/Makefile
+++ b/drivers/clk/at91/Makefile
@@ -14,5 +14,6 @@ obj-$(CONFIG_HAVE_AT91_SMD)		+= clk-smd.o
 obj-$(CONFIG_HAVE_AT91_H32MX)		+= clk-h32mx.o
 obj-$(CONFIG_HAVE_AT91_GENERATED_CLK)	+= clk-generated.o
 obj-$(CONFIG_HAVE_AT91_I2S_MUX_CLK)	+= clk-i2s-mux.o
+obj-$(CONFIG_SOC_AT91SAM9) += at91sam9260.o
 obj-$(CONFIG_SOC_SAMA5D4) += sama5d4.o
 obj-$(CONFIG_SOC_SAMA5D2) += sama5d2.o
diff --git a/drivers/clk/at91/at91sam9260.c b/drivers/clk/at91/at91sam9260.c
new file mode 100644
index 000000000000..49aeee6c31a6
--- /dev/null
+++ b/drivers/clk/at91/at91sam9260.c
@@ -0,0 +1,494 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/clk-provider.h>
+#include <linux/mfd/syscon.h>
+#include <linux/slab.h>
+
+#include <dt-bindings/clock/at91.h>
+
+#include "pmc.h"
+
+struct sck {
+	char *n;
+	char *p;
+	u8 id;
+};
+
+struct pck {
+	char *n;
+	u8 id;
+};
+
+struct at91sam926x_data {
+	const struct clk_pll_layout *plla_layout;
+	const struct clk_pll_characteristics *plla_characteristics;
+	const struct clk_pll_layout *pllb_layout;
+	const struct clk_pll_characteristics *pllb_characteristics;
+	const struct clk_master_characteristics *mck_characteristics;
+	const struct sck *sck;
+	const struct pck *pck;
+	u8 num_sck;
+	u8 num_pck;
+	u8 num_progck;
+	bool has_slck;
+};
+
+static const struct clk_master_characteristics sam9260_mck_characteristics = {
+	.output = { .min = 0, .max = 105000000 },
+	.divisors = { 1, 2, 4, 0 },
+};
+
+static u8 sam9260_plla_out[] = { 0, 2 };
+
+static u16 sam9260_plla_icpll[] = { 1, 1 };
+
+static struct clk_range sam9260_plla_outputs[] = {
+	{ .min = 80000000, .max = 160000000 },
+	{ .min = 150000000, .max = 240000000 },
+};
+
+static const struct clk_pll_characteristics sam9260_plla_characteristics = {
+	.input = { .min = 1000000, .max = 32000000 },
+	.num_output = ARRAY_SIZE(sam9260_plla_outputs),
+	.output = sam9260_plla_outputs,
+	.icpll = sam9260_plla_icpll,
+	.out = sam9260_plla_out,
+};
+
+static u8 sam9260_pllb_out[] = { 1 };
+
+static u16 sam9260_pllb_icpll[] = { 1 };
+
+static struct clk_range sam9260_pllb_outputs[] = {
+	{ .min = 70000000, .max = 130000000 },
+};
+
+static const struct clk_pll_characteristics sam9260_pllb_characteristics = {
+	.input = { .min = 1000000, .max = 5000000 },
+	.num_output = ARRAY_SIZE(sam9260_pllb_outputs),
+	.output = sam9260_pllb_outputs,
+	.icpll = sam9260_pllb_icpll,
+	.out = sam9260_pllb_out,
+};
+
+static const struct sck at91sam9260_systemck[] = {
+	{ .n = "uhpck", .p = "usbck",    .id = 6 },
+	{ .n = "udpck", .p = "usbck",    .id = 7 },
+	{ .n = "pck0",  .p = "prog0",    .id = 8 },
+	{ .n = "pck1",  .p = "prog1",    .id = 9 },
+};
+
+static const struct pck at91sam9260_periphck[] = {
+	{ .n = "pioA_clk",   .id = 2 },
+	{ .n = "pioB_clk",   .id = 3 },
+	{ .n = "pioC_clk",   .id = 4 },
+	{ .n = "adc_clk",    .id = 5 },
+	{ .n = "usart0_clk", .id = 6 },
+	{ .n = "usart1_clk", .id = 7 },
+	{ .n = "usart2_clk", .id = 8 },
+	{ .n = "mci0_clk",   .id = 9 },
+	{ .n = "udc_clk",    .id = 10 },
+	{ .n = "twi0_clk",   .id = 11 },
+	{ .n = "spi0_clk",   .id = 12 },
+	{ .n = "spi1_clk",   .id = 13 },
+	{ .n = "ssc0_clk",   .id = 14 },
+	{ .n = "tc0_clk",    .id = 17 },
+	{ .n = "tc1_clk",    .id = 18 },
+	{ .n = "tc2_clk",    .id = 19 },
+	{ .n = "ohci_clk",   .id = 20 },
+	{ .n = "macb0_clk",  .id = 21 },
+	{ .n = "isi_clk",    .id = 22 },
+	{ .n = "usart3_clk", .id = 23 },
+	{ .n = "uart0_clk",  .id = 24 },
+	{ .n = "uart1_clk",  .id = 25 },
+	{ .n = "tc3_clk",    .id = 26 },
+	{ .n = "tc4_clk",    .id = 27 },
+	{ .n = "tc5_clk",    .id = 28 },
+};
+
+static struct at91sam926x_data at91sam9260_data = {
+	.plla_layout = &at91rm9200_pll_layout,
+	.plla_characteristics = &sam9260_plla_characteristics,
+	.pllb_layout = &at91rm9200_pll_layout,
+	.pllb_characteristics = &sam9260_pllb_characteristics,
+	.mck_characteristics = &sam9260_mck_characteristics,
+	.sck = at91sam9260_systemck,
+	.num_sck = ARRAY_SIZE(at91sam9260_systemck),
+	.pck = at91sam9260_periphck,
+	.num_pck = ARRAY_SIZE(at91sam9260_periphck),
+	.num_progck = 2,
+	.has_slck = true,
+};
+
+static const struct clk_master_characteristics sam9g20_mck_characteristics = {
+	.output = { .min = 0, .max = 133000000 },
+	.divisors = { 1, 2, 4, 6 },
+};
+
+static u8 sam9g20_plla_out[] = { 0, 1, 2, 3, 0, 1, 2, 3 };
+
+static u16 sam9g20_plla_icpll[] = { 0, 0, 0, 0, 1, 1, 1, 1 };
+
+static struct clk_range sam9g20_plla_outputs[] = {
+	{ .min = 745000000, .max = 800000000 },
+	{ .min = 695000000, .max = 750000000 },
+	{ .min = 645000000, .max = 700000000 },
+	{ .min = 595000000, .max = 650000000 },
+	{ .min = 545000000, .max = 600000000 },
+	{ .min = 495000000, .max = 550000000 },
+	{ .min = 445000000, .max = 500000000 },
+	{ .min = 400000000, .max = 450000000 },
+};
+
+static const struct clk_pll_characteristics sam9g20_plla_characteristics = {
+	.input = { .min = 2000000, .max = 32000000 },
+	.num_output = ARRAY_SIZE(sam9g20_plla_outputs),
+	.output = sam9g20_plla_outputs,
+	.icpll = sam9g20_plla_icpll,
+	.out = sam9g20_plla_out,
+};
+
+static u8 sam9g20_pllb_out[] = { 0 };
+
+static u16 sam9g20_pllb_icpll[] = { 0 };
+
+static struct clk_range sam9g20_pllb_outputs[] = {
+	{ .min = 30000000, .max = 100000000 },
+};
+
+static const struct clk_pll_characteristics sam9g20_pllb_characteristics = {
+	.input = { .min = 2000000, .max = 32000000 },
+	.num_output = ARRAY_SIZE(sam9g20_pllb_outputs),
+	.output = sam9g20_pllb_outputs,
+	.icpll = sam9g20_pllb_icpll,
+	.out = sam9g20_pllb_out,
+};
+
+static struct at91sam926x_data at91sam9g20_data = {
+	.plla_layout = &at91sam9g45_pll_layout,
+	.plla_characteristics = &sam9g20_plla_characteristics,
+	.pllb_layout = &at91sam9g20_pllb_layout,
+	.pllb_characteristics = &sam9g20_pllb_characteristics,
+	.mck_characteristics = &sam9g20_mck_characteristics,
+	.sck = at91sam9260_systemck,
+	.num_sck = ARRAY_SIZE(at91sam9260_systemck),
+	.pck = at91sam9260_periphck,
+	.num_pck = ARRAY_SIZE(at91sam9260_periphck),
+	.num_progck = 2,
+	.has_slck = true,
+};
+
+static const struct clk_master_characteristics sam9261_mck_characteristics = {
+	.output = { .min = 0, .max = 94000000 },
+	.divisors = { 1, 2, 4, 0 },
+};
+
+static struct clk_range sam9261_plla_outputs[] = {
+	{ .min = 80000000, .max = 200000000 },
+	{ .min = 190000000, .max = 240000000 },
+};
+
+static const struct clk_pll_characteristics sam9261_plla_characteristics = {
+	.input = { .min = 1000000, .max = 32000000 },
+	.num_output = ARRAY_SIZE(sam9261_plla_outputs),
+	.output = sam9261_plla_outputs,
+	.icpll = sam9260_plla_icpll,
+	.out = sam9260_plla_out,
+};
+
+static u8 sam9261_pllb_out[] = { 1 };
+
+static u16 sam9261_pllb_icpll[] = { 1 };
+
+static struct clk_range sam9261_pllb_outputs[] = {
+	{ .min = 70000000, .max = 130000000 },
+};
+
+static const struct clk_pll_characteristics sam9261_pllb_characteristics = {
+	.input = { .min = 1000000, .max = 5000000 },
+	.num_output = ARRAY_SIZE(sam9261_pllb_outputs),
+	.output = sam9261_pllb_outputs,
+	.icpll = sam9261_pllb_icpll,
+	.out = sam9261_pllb_out,
+};
+
+static const struct sck at91sam9261_systemck[] = {
+	{ .n = "uhpck", .p = "usbck",    .id = 6 },
+	{ .n = "udpck", .p = "usbck",    .id = 7 },
+	{ .n = "pck0",  .p = "prog0",    .id = 8 },
+	{ .n = "pck1",  .p = "prog1",    .id = 9 },
+	{ .n = "pck2",  .p = "prog2",    .id = 10 },
+	{ .n = "pck3",  .p = "prog3",    .id = 11 },
+	{ .n = "hclk0", .p = "masterck", .id = 16 },
+	{ .n = "hclk1", .p = "masterck", .id = 17 },
+};
+
+static const struct pck at91sam9261_periphck[] = {
+	{ .n = "pioA_clk",   .id = 2, },
+	{ .n = "pioB_clk",   .id = 3, },
+	{ .n = "pioC_clk",   .id = 4, },
+	{ .n = "usart0_clk", .id = 6, },
+	{ .n = "usart1_clk", .id = 7, },
+	{ .n = "usart2_clk", .id = 8, },
+	{ .n = "mci0_clk",   .id = 9, },
+	{ .n = "udc_clk",    .id = 10, },
+	{ .n = "twi0_clk",   .id = 11, },
+	{ .n = "spi0_clk",   .id = 12, },
+	{ .n = "spi1_clk",   .id = 13, },
+	{ .n = "ssc0_clk",   .id = 14, },
+	{ .n = "ssc1_clk",   .id = 15, },
+	{ .n = "ssc2_clk",   .id = 16, },
+	{ .n = "tc0_clk",    .id = 17, },
+	{ .n = "tc1_clk",    .id = 18, },
+	{ .n = "tc2_clk",    .id = 19, },
+	{ .n = "ohci_clk",   .id = 20, },
+	{ .n = "lcd_clk",    .id = 21, },
+};
+
+static struct at91sam926x_data at91sam9261_data = {
+	.plla_layout = &at91rm9200_pll_layout,
+	.plla_characteristics = &sam9261_plla_characteristics,
+	.pllb_layout = &at91rm9200_pll_layout,
+	.pllb_characteristics = &sam9261_pllb_characteristics,
+	.mck_characteristics = &sam9261_mck_characteristics,
+	.sck = at91sam9261_systemck,
+	.num_sck = ARRAY_SIZE(at91sam9261_systemck),
+	.pck = at91sam9261_periphck,
+	.num_pck = ARRAY_SIZE(at91sam9261_periphck),
+	.num_progck = 4,
+};
+
+static const struct clk_master_characteristics sam9263_mck_characteristics = {
+	.output = { .min = 0, .max = 120000000 },
+	.divisors = { 1, 2, 4, 0 },
+};
+
+static struct clk_range sam9263_pll_outputs[] = {
+	{ .min = 80000000, .max = 200000000 },
+	{ .min = 190000000, .max = 240000000 },
+};
+
+static const struct clk_pll_characteristics sam9263_pll_characteristics = {
+	.input = { .min = 1000000, .max = 32000000 },
+	.num_output = ARRAY_SIZE(sam9263_pll_outputs),
+	.output = sam9263_pll_outputs,
+	.icpll = sam9260_plla_icpll,
+	.out = sam9260_plla_out,
+};
+
+static const struct sck at91sam9263_systemck[] = {
+	{ .n = "uhpck", .p = "usbck",    .id = 6 },
+	{ .n = "udpck", .p = "usbck",    .id = 7 },
+	{ .n = "pck0",  .p = "prog0",    .id = 8 },
+	{ .n = "pck1",  .p = "prog1",    .id = 9 },
+	{ .n = "pck2",  .p = "prog2",    .id = 10 },
+	{ .n = "pck3",  .p = "prog3",    .id = 11 },
+};
+
+static const struct pck at91sam9263_periphck[] = {
+	{ .n = "pioA_clk",   .id = 2, },
+	{ .n = "pioB_clk",   .id = 3, },
+	{ .n = "pioCDE_clk", .id = 4, },
+	{ .n = "usart0_clk", .id = 7, },
+	{ .n = "usart1_clk", .id = 8, },
+	{ .n = "usart2_clk", .id = 9, },
+	{ .n = "mci0_clk",   .id = 10, },
+	{ .n = "mci1_clk",   .id = 11, },
+	{ .n = "can_clk",    .id = 12, },
+	{ .n = "twi0_clk",   .id = 13, },
+	{ .n = "spi0_clk",   .id = 14, },
+	{ .n = "spi1_clk",   .id = 15, },
+	{ .n = "ssc0_clk",   .id = 16, },
+	{ .n = "ssc1_clk",   .id = 17, },
+	{ .n = "ac97_clk",   .id = 18, },
+	{ .n = "tcb_clk",    .id = 19, },
+	{ .n = "pwm_clk",    .id = 20, },
+	{ .n = "macb0_clk",  .id = 21, },
+	{ .n = "g2de_clk",   .id = 23, },
+	{ .n = "udc_clk",    .id = 24, },
+	{ .n = "isi_clk",    .id = 25, },
+	{ .n = "lcd_clk",    .id = 26, },
+	{ .n = "dma_clk",    .id = 27, },
+	{ .n = "ohci_clk",   .id = 29, },
+};
+
+static struct at91sam926x_data at91sam9263_data = {
+	.plla_layout = &at91rm9200_pll_layout,
+	.plla_characteristics = &sam9263_pll_characteristics,
+	.pllb_layout = &at91rm9200_pll_layout,
+	.pllb_characteristics = &sam9263_pll_characteristics,
+	.mck_characteristics = &sam9263_mck_characteristics,
+	.sck = at91sam9263_systemck,
+	.num_sck = ARRAY_SIZE(at91sam9263_systemck),
+	.pck = at91sam9263_periphck,
+	.num_pck = ARRAY_SIZE(at91sam9263_periphck),
+	.num_progck = 4,
+};
+
+static void __init at91sam926x_pmc_setup(struct device_node *np,
+					 struct at91sam926x_data *data)
+{
+	const char *slowxtal_name, *mainxtal_name;
+	struct pmc_data *at91sam9260_pmc;
+	u32 usb_div[] = { 1, 2, 4, 0 };
+	const char *parent_names[6];
+	const char *slck_name;
+	struct regmap *regmap;
+	struct clk_hw *hw;
+	unsigned int i;
+	bool bypass;
+
+	i = of_property_match_string(np, "clock-names", "slow_xtal");
+	if (i < 0)
+		return;
+
+	slowxtal_name = of_clk_get_parent_name(np, i);
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
+	at91sam9260_pmc = pmc_data_allocate(PMC_MAIN + 1,
+					    ndck(data->sck, data->num_sck),
+					    ndck(data->pck, data->num_pck), 0);
+	if (!at91sam9260_pmc)
+		return;
+
+	bypass = of_property_read_bool(np, "atmel,osc-bypass");
+
+	hw = at91_clk_register_main_osc(regmap, "main_osc", mainxtal_name,
+					bypass);
+	if (IS_ERR(hw))
+		goto err_free;
+
+	hw = at91_clk_register_rm9200_main(regmap, "mainck", "main_osc");
+	if (IS_ERR(hw))
+		goto err_free;
+
+	at91sam9260_pmc->chws[PMC_MAIN] = hw;
+
+	if (data->has_slck) {
+		hw = clk_hw_register_fixed_rate_with_accuracy(NULL,
+							      "slow_rc_osc",
+							      NULL, 0, 32768,
+							      50000000);
+		if (IS_ERR(hw))
+			goto err_free;
+
+		parent_names[0] = "slow_rc_osc";
+		parent_names[1] = "slow_xtal";
+		hw = at91_clk_register_sam9260_slow(regmap, "slck",
+						    parent_names, 2);
+		if (IS_ERR(hw))
+			goto err_free;
+
+		at91sam9260_pmc->chws[PMC_SLOW] = hw;
+		slck_name = "slck";
+	} else {
+		slck_name = slowxtal_name;
+	}
+
+	hw = at91_clk_register_pll(regmap, "pllack", "mainck", 0,
+				   data->plla_layout,
+				   data->plla_characteristics);
+	if (IS_ERR(hw))
+		goto err_free;
+
+	hw = at91_clk_register_pll(regmap, "pllbck", "mainck", 1,
+				   data->pllb_layout,
+				   data->pllb_characteristics);
+	if (IS_ERR(hw))
+		goto err_free;
+
+	parent_names[0] = slck_name;
+	parent_names[1] = "mainck";
+	parent_names[2] = "pllack";
+	parent_names[3] = "pllbck";
+	hw = at91_clk_register_master(regmap, "masterck", 4, parent_names,
+				      &at91rm9200_master_layout,
+				      data->mck_characteristics);
+	if (IS_ERR(hw))
+		goto err_free;
+
+	at91sam9260_pmc->chws[PMC_MCK] = hw;
+
+	hw = at91rm9200_clk_register_usb(regmap, "usbck", "pllbck", usb_div);
+	if (IS_ERR(hw))
+		goto err_free;
+
+	parent_names[0] = slck_name;
+	parent_names[1] = "mainck";
+	parent_names[2] = "pllack";
+	parent_names[3] = "pllbck";
+	for (i = 0; i < data->num_progck; i++) {
+		char name[6];
+
+		snprintf(name, sizeof(name), "prog%d", i);
+
+		hw = at91_clk_register_programmable(regmap, name,
+						    parent_names, 4, i,
+						    &at91rm9200_programmable_layout);
+		if (IS_ERR(hw))
+			goto err_free;
+	}
+
+	for (i = 0; i < data->num_sck; i++) {
+		hw = at91_clk_register_system(regmap, data->sck[i].n,
+					      data->sck[i].p,
+					      data->sck[i].id);
+		if (IS_ERR(hw))
+			goto err_free;
+
+		at91sam9260_pmc->shws[data->sck[i].id] = hw;
+	}
+
+	for (i = 0; i < data->num_pck; i++) {
+		hw = at91_clk_register_peripheral(regmap,
+						  data->pck[i].n,
+						  "masterck",
+						  data->pck[i].id);
+		if (IS_ERR(hw))
+			goto err_free;
+
+		at91sam9260_pmc->phws[data->pck[i].id] = hw;
+	}
+
+	of_clk_add_hw_provider(np, of_clk_hw_pmc_get, at91sam9260_pmc);
+
+	return;
+
+err_free:
+	pmc_data_free(at91sam9260_pmc);
+}
+
+static void __init at91sam9260_pmc_setup(struct device_node *np)
+{
+	at91sam926x_pmc_setup(np, &at91sam9260_data);
+}
+CLK_OF_DECLARE_DRIVER(at91sam9260_pmc, "atmel,at91sam9260-pmc",
+		      at91sam9260_pmc_setup);
+
+static void __init at91sam9261_pmc_setup(struct device_node *np)
+{
+	at91sam926x_pmc_setup(np, &at91sam9261_data);
+}
+CLK_OF_DECLARE_DRIVER(at91sam9261_pmc, "atmel,at91sam9261-pmc",
+		      at91sam9261_pmc_setup);
+
+static void __init at91sam9263_pmc_setup(struct device_node *np)
+{
+	at91sam926x_pmc_setup(np, &at91sam9263_data);
+}
+CLK_OF_DECLARE_DRIVER(at91sam9263_pmc, "atmel,at91sam9263-pmc",
+		      at91sam9263_pmc_setup);
+
+static void __init at91sam9g20_pmc_setup(struct device_node *np)
+{
+	at91sam926x_pmc_setup(np, &at91sam9g20_data);
+}
+CLK_OF_DECLARE_DRIVER(at91sam9g20_pmc, "atmel,at91sam9g20-pmc",
+		      at91sam9g20_pmc_setup);
-- 
2.19.1

