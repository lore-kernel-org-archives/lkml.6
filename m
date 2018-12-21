Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9893CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53E8121920
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="YCqmwU+R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388191AbeLUQDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 11:03:10 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39238 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387900AbeLUQC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 11:02:58 -0500
Received: by mail-wr1-f66.google.com with SMTP id t27so5786347wra.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 08:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oay3dNHx3zGjqTDx0d26uYNVovZw3lp2tF84PLuBl+s=;
        b=YCqmwU+RkuHPEyrZTjPvFVJHLLTAweYr6GOmfRLWFE78dujOLm4nbtr/y4DBhVLe/a
         p/ehLNF9IJAsaZZyesT/KPYM1McAKUlxciP9H2qQXI98AxarS53q71UXXPHVfBsIIpm2
         CrYxTKPSSG2ztaxh67SyGoynSKMix+fvMekMhO5si+52DCPJ2NxcL+ufLgtYYiH6NCzH
         zz2iX2JsTZi1C66BsGbGqfWiMsj72LZ9s7VYEVTaBR/DTmXc2tRc0RrAdEboobjzItun
         6SzihAAjE8lc5lsxcNXqSGXVdYT4CoN6Dm0AvSqZqI1Fn+uRntR8ookwUICHH629jY8r
         Ge7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oay3dNHx3zGjqTDx0d26uYNVovZw3lp2tF84PLuBl+s=;
        b=ojdymsJBe10ojAhMWTbJvjOJn7qA8F6P6o2PUfYn/m7hk/8bXICYIOqz61uEPmZWaf
         fAwXe0KCnGdMgIwbieHtZygzOZrUo3Jt4p7f3fFUN6OxEVEgwfvzP1NqnefF5d2bKnHm
         rnWwVAQezZgJdnmv8yv+tEI4jNCqqCHKc0+B3DURlMdMa5HU/YtVeNXsJb+Afa9/xcsI
         PPt9rtTHfqLKQoTmlCF20lolsHUn8MnUSrDbCG5iXWB+58iUmrFTG6sSysJjxFR8FB4j
         lBuCEZBQjaZrUFh6fTgUbYi9BV0pnAQBCIDMD/z2ZL3ndu1Hlic8upfdL7BBHKVHaN7i
         MpOQ==
X-Gm-Message-State: AJcUukcDeStQMbUGu9zcFH3nbHK8es4z51Bj58WRbGAKYWwmex7HasjY
        VslZ+qT8xHWboceBS1251JfJpw==
X-Google-Smtp-Source: ALg8bN7nkdgiZLgoJzfG1W0s8hVJoHZtJweCRgqdVHzsx2YoG7fN4xTYS77AhKHsQh7D76YAhv30zQ==
X-Received: by 2002:a5d:6187:: with SMTP id j7mr3221059wru.300.1545408175893;
        Fri, 21 Dec 2018 08:02:55 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id y138sm13044021wmc.16.2018.12.21.08.02.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 08:02:55 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 4/5] clk: meson: gxbb-ao: replace cec-32k with the dual divider
Date:   Fri, 21 Dec 2018 17:02:38 +0100
Message-Id: <20181221160239.26265-5-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181221160239.26265-1-jbrunet@baylibre.com>
References: <20181221160239.26265-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the cec-32k clock of gxbb-ao with the simpler dual divider
driver. The dual divider implements only the dividing part. All the
other bits are now exposed using simple elements, such as gates and
muxes

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/Makefile         |   2 +-
 drivers/clk/meson/gxbb-aoclk-32k.c | 193 ----------------------
 drivers/clk/meson/gxbb-aoclk.c     | 251 +++++++++++++++++++++++------
 drivers/clk/meson/gxbb-aoclk.h     |  20 +--
 4 files changed, 204 insertions(+), 262 deletions(-)
 delete mode 100644 drivers/clk/meson/gxbb-aoclk-32k.c

diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index f1fcafc046d5..8234e92eea38 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -7,7 +7,7 @@ obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-input.o clk-dualdiv.o
 obj-$(CONFIG_COMMON_CLK_AMLOGIC_AUDIO)	+= clk-triphase.o sclk-div.o
 obj-$(CONFIG_COMMON_CLK_MESON_AO) += meson-aoclk.o
 obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
-obj-$(CONFIG_COMMON_CLK_GXBB)	 += gxbb.o gxbb-aoclk.o gxbb-aoclk-32k.o
+obj-$(CONFIG_COMMON_CLK_GXBB)	 += gxbb.o gxbb-aoclk.o
 obj-$(CONFIG_COMMON_CLK_AXG)	 += axg.o axg-aoclk.o
 obj-$(CONFIG_COMMON_CLK_AXG_AUDIO)	+= axg-audio.o
 obj-$(CONFIG_COMMON_CLK_REGMAP_MESON)	+= clk-regmap.o
diff --git a/drivers/clk/meson/gxbb-aoclk-32k.c b/drivers/clk/meson/gxbb-aoclk-32k.c
deleted file mode 100644
index 680467141a1d..000000000000
--- a/drivers/clk/meson/gxbb-aoclk-32k.c
+++ /dev/null
@@ -1,193 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (c) 2017 BayLibre, SAS.
- * Author: Neil Armstrong <narmstrong@baylibre.com>
- */
-
-#include <linux/clk-provider.h>
-#include <linux/bitfield.h>
-#include <linux/regmap.h>
-#include "gxbb-aoclk.h"
-
-/*
- * The AO Domain embeds a dual/divider to generate a more precise
- * 32,768KHz clock for low-power suspend mode and CEC.
- *                      ______   ______
- *                     |      | |      |
- *         ______      | Div1 |-| Cnt1 |       ______
- *        |      |    /|______| |______|\     |      |
- * Xtal-->| Gate |---|  ______   ______  X-X--| Gate |-->
- *        |______| |  \|      | |      |/  |  |______|
- *                 |   | Div2 |-| Cnt2 |   |
- *                 |   |______| |______|   |
- *                 |_______________________|
- *
- * The dividing can be switched to single or dual, with a counter
- * for each divider to set when the switching is done.
- * The entire dividing mechanism can be also bypassed.
- */
-
-#define CLK_CNTL0_N1_MASK	GENMASK(11, 0)
-#define CLK_CNTL0_N2_MASK	GENMASK(23, 12)
-#define CLK_CNTL0_DUALDIV_EN	BIT(28)
-#define CLK_CNTL0_OUT_GATE_EN	BIT(30)
-#define CLK_CNTL0_IN_GATE_EN	BIT(31)
-
-#define CLK_CNTL1_M1_MASK	GENMASK(11, 0)
-#define CLK_CNTL1_M2_MASK	GENMASK(23, 12)
-#define CLK_CNTL1_BYPASS_EN	BIT(24)
-#define CLK_CNTL1_SELECT_OSC	BIT(27)
-
-#define PWR_CNTL_ALT_32K_SEL	GENMASK(13, 10)
-
-struct cec_32k_freq_table {
-	unsigned long parent_rate;
-	unsigned long target_rate;
-	bool dualdiv;
-	unsigned int n1;
-	unsigned int n2;
-	unsigned int m1;
-	unsigned int m2;
-};
-
-static const struct cec_32k_freq_table aoclk_cec_32k_table[] = {
-	[0] = {
-		.parent_rate = 24000000,
-		.target_rate = 32768,
-		.dualdiv = true,
-		.n1 = 733,
-		.n2 = 732,
-		.m1 = 8,
-		.m2 = 11,
-	},
-};
-
-/*
- * If CLK_CNTL0_DUALDIV_EN == 0
- *  - will use N1 divider only
- * If CLK_CNTL0_DUALDIV_EN == 1
- *  - hold M1 cycles of N1 divider then changes to N2
- *  - hold M2 cycles of N2 divider then changes to N1
- * Then we can get more accurate division.
- */
-static unsigned long aoclk_cec_32k_recalc_rate(struct clk_hw *hw,
-					       unsigned long parent_rate)
-{
-	struct aoclk_cec_32k *cec_32k = to_aoclk_cec_32k(hw);
-	unsigned long n1;
-	u32 reg0, reg1;
-
-	regmap_read(cec_32k->regmap, AO_RTC_ALT_CLK_CNTL0, &reg0);
-	regmap_read(cec_32k->regmap, AO_RTC_ALT_CLK_CNTL1, &reg1);
-
-	if (reg1 & CLK_CNTL1_BYPASS_EN)
-		return parent_rate;
-
-	if (reg0 & CLK_CNTL0_DUALDIV_EN) {
-		unsigned long n2, m1, m2, f1, f2, p1, p2;
-
-		n1 = FIELD_GET(CLK_CNTL0_N1_MASK, reg0) + 1;
-		n2 = FIELD_GET(CLK_CNTL0_N2_MASK, reg0) + 1;
-
-		m1 = FIELD_GET(CLK_CNTL1_M1_MASK, reg1) + 1;
-		m2 = FIELD_GET(CLK_CNTL1_M2_MASK, reg1) + 1;
-
-		f1 = DIV_ROUND_CLOSEST(parent_rate, n1);
-		f2 = DIV_ROUND_CLOSEST(parent_rate, n2);
-
-		p1 = DIV_ROUND_CLOSEST(100000000 * m1, f1 * (m1 + m2));
-		p2 = DIV_ROUND_CLOSEST(100000000 * m2, f2 * (m1 + m2));
-
-		return DIV_ROUND_UP(100000000, p1 + p2);
-	}
-
-	n1 = FIELD_GET(CLK_CNTL0_N1_MASK, reg0) + 1;
-
-	return DIV_ROUND_CLOSEST(parent_rate, n1);
-}
-
-static const struct cec_32k_freq_table *find_cec_32k_freq(unsigned long rate,
-							  unsigned long prate)
-{
-	int i;
-
-	for (i = 0 ; i < ARRAY_SIZE(aoclk_cec_32k_table) ; ++i)
-		if (aoclk_cec_32k_table[i].parent_rate == prate &&
-		    aoclk_cec_32k_table[i].target_rate == rate)
-			return &aoclk_cec_32k_table[i];
-
-	return NULL;
-}
-
-static long aoclk_cec_32k_round_rate(struct clk_hw *hw, unsigned long rate,
-				     unsigned long *prate)
-{
-	const struct cec_32k_freq_table *freq = find_cec_32k_freq(rate,
-								  *prate);
-
-	/* If invalid return first one */
-	if (!freq)
-		return aoclk_cec_32k_table[0].target_rate;
-
-	return freq->target_rate;
-}
-
-/*
- * From the Amlogic init procedure, the IN and OUT gates needs to be handled
- * in the init procedure to avoid any glitches.
- */
-
-static int aoclk_cec_32k_set_rate(struct clk_hw *hw, unsigned long rate,
-				  unsigned long parent_rate)
-{
-	const struct cec_32k_freq_table *freq = find_cec_32k_freq(rate,
-								  parent_rate);
-	struct aoclk_cec_32k *cec_32k = to_aoclk_cec_32k(hw);
-	u32 reg = 0;
-
-	if (!freq)
-		return -EINVAL;
-
-	/* Disable clock */
-	regmap_update_bits(cec_32k->regmap, AO_RTC_ALT_CLK_CNTL0,
-			   CLK_CNTL0_IN_GATE_EN | CLK_CNTL0_OUT_GATE_EN, 0);
-
-	reg = FIELD_PREP(CLK_CNTL0_N1_MASK, freq->n1 - 1);
-	if (freq->dualdiv)
-		reg |= CLK_CNTL0_DUALDIV_EN |
-		       FIELD_PREP(CLK_CNTL0_N2_MASK, freq->n2 - 1);
-
-	regmap_write(cec_32k->regmap, AO_RTC_ALT_CLK_CNTL0, reg);
-
-	reg = FIELD_PREP(CLK_CNTL1_M1_MASK, freq->m1 - 1);
-	if (freq->dualdiv)
-		reg |= FIELD_PREP(CLK_CNTL1_M2_MASK, freq->m2 - 1);
-
-	regmap_write(cec_32k->regmap, AO_RTC_ALT_CLK_CNTL1, reg);
-
-	/* Enable clock */
-	regmap_update_bits(cec_32k->regmap, AO_RTC_ALT_CLK_CNTL0,
-			   CLK_CNTL0_IN_GATE_EN, CLK_CNTL0_IN_GATE_EN);
-
-	udelay(200);
-
-	regmap_update_bits(cec_32k->regmap, AO_RTC_ALT_CLK_CNTL0,
-			   CLK_CNTL0_OUT_GATE_EN, CLK_CNTL0_OUT_GATE_EN);
-
-	regmap_update_bits(cec_32k->regmap, AO_CRT_CLK_CNTL1,
-			   CLK_CNTL1_SELECT_OSC, CLK_CNTL1_SELECT_OSC);
-
-	/* Select 32k from XTAL */
-	regmap_update_bits(cec_32k->regmap,
-			  AO_RTI_PWR_CNTL_REG0,
-			  PWR_CNTL_ALT_32K_SEL,
-			  FIELD_PREP(PWR_CNTL_ALT_32K_SEL, 4));
-
-	return 0;
-}
-
-const struct clk_ops meson_aoclk_cec_32k_ops = {
-	.recalc_rate = aoclk_cec_32k_recalc_rate,
-	.round_rate = aoclk_cec_32k_round_rate,
-	.set_rate = aoclk_cec_32k_set_rate,
-};
diff --git a/drivers/clk/meson/gxbb-aoclk.c b/drivers/clk/meson/gxbb-aoclk.c
index 42ed61d3c3fb..5fa57b623b8f 100644
--- a/drivers/clk/meson/gxbb-aoclk.c
+++ b/drivers/clk/meson/gxbb-aoclk.c
@@ -5,10 +5,19 @@
  */
 #include <linux/platform_device.h>
 #include <linux/mfd/syscon.h>
-#include "clk-regmap.h"
+#include "clkc.h"
 #include "meson-aoclk.h"
 #include "gxbb-aoclk.h"
 
+/* AO Configuration Clock registers offsets */
+#define AO_RTI_PWR_CNTL_REG1	0x0c
+#define AO_RTI_PWR_CNTL_REG0	0x10
+#define AO_RTI_GEN_CNTL_REG0	0x40
+#define AO_OSCIN_CNTL		0x58
+#define AO_CRT_CLK_CNTL1	0x68
+#define AO_RTC_ALT_CLK_CNTL0	0x94
+#define AO_RTC_ALT_CLK_CNTL1	0x98
+
 #define GXBB_AO_GATE(_name, _bit)					\
 static struct clk_regmap _name##_ao = {					\
 	.data = &(struct clk_regmap_gate_data) {			\
@@ -31,13 +40,174 @@ GXBB_AO_GATE(uart1, 3);
 GXBB_AO_GATE(uart2, 5);
 GXBB_AO_GATE(ir_blaster, 6);
 
-static struct aoclk_cec_32k cec_32k_ao = {
-	.hw.init = &(struct clk_init_data) {
-		.name = "cec_32k_ao",
-		.ops = &meson_aoclk_cec_32k_ops,
+static struct clk_regmap ao_cts_oscin = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = AO_RTI_PWR_CNTL_REG0,
+		.bit_idx = 6,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "ao_cts_oscin",
+		.ops = &clk_regmap_gate_ro_ops,
 		.parent_names = (const char *[]){ "xtal" },
 		.num_parents = 1,
-		.flags = CLK_IGNORE_UNUSED,
+	},
+};
+
+static struct clk_regmap ao_32k_pre = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = AO_RTC_ALT_CLK_CNTL0,
+		.bit_idx = 31,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "ao_32k_pre",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "ao_cts_oscin" },
+		.num_parents = 1,
+	},
+};
+
+static const struct meson_clk_dualdiv_param gxbb_32k_div_table[] = {
+	{
+		.dual	= 1,
+		.n1	= 733,
+		.m1	= 8,
+		.n2	= 732,
+		.m2	= 11,
+	}, {}
+};
+
+static struct clk_regmap ao_32k_div = {
+	.data = &(struct meson_clk_dualdiv_data){
+		.n1 = {
+			.reg_off = AO_RTC_ALT_CLK_CNTL0,
+			.shift   = 0,
+			.width   = 12,
+		},
+		.n2 = {
+			.reg_off = AO_RTC_ALT_CLK_CNTL0,
+			.shift   = 12,
+			.width   = 12,
+		},
+		.m1 = {
+			.reg_off = AO_RTC_ALT_CLK_CNTL1,
+			.shift   = 0,
+			.width   = 12,
+		},
+		.m2 = {
+			.reg_off = AO_RTC_ALT_CLK_CNTL1,
+			.shift   = 12,
+			.width   = 12,
+		},
+		.dual = {
+			.reg_off = AO_RTC_ALT_CLK_CNTL0,
+			.shift   = 28,
+			.width   = 1,
+		},
+		.table = gxbb_32k_div_table,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "ao_32k_div",
+		.ops = &meson_clk_dualdiv_ops,
+		.parent_names = (const char *[]){ "ao_32k_pre" },
+		.num_parents = 1,
+	},
+};
+
+static struct clk_regmap ao_32k_sel = {
+	.data = &(struct clk_regmap_mux_data) {
+		.offset = AO_RTC_ALT_CLK_CNTL1,
+		.mask = 0x1,
+		.shift = 24,
+		.flags = CLK_MUX_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "ao_32k_sel",
+		.ops = &clk_regmap_mux_ops,
+		.parent_names = (const char *[]){ "ao_32k_div",
+						  "ao_32k_pre" },
+		.num_parents = 2,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap ao_32k = {
+	.data = &(struct clk_regmap_gate_data){
+		.offset = AO_RTC_ALT_CLK_CNTL0,
+		.bit_idx = 30,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "ao_32k",
+		.ops = &clk_regmap_gate_ops,
+		.parent_names = (const char *[]){ "ao_32k_sel" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap ao_cts_rtc_oscin = {
+	.data = &(struct clk_regmap_mux_data) {
+		.offset = AO_RTI_PWR_CNTL_REG0,
+		.mask = 0x7,
+		.shift = 10,
+		.table = (u32[]){ 1, 2, 3, 4 },
+		.flags = CLK_MUX_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "ao_cts_rtc_oscin",
+		.ops = &clk_regmap_mux_ops,
+		.parent_names = (const char *[]){ "ext_32k_0",
+						  "ext_32k_1",
+						  "ext_32k_2",
+						  "ao_32k" },
+		.num_parents = 4,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap ao_clk81 = {
+	.data = &(struct clk_regmap_mux_data) {
+		.offset = AO_RTI_PWR_CNTL_REG0,
+		.mask = 0x1,
+		.shift = 0,
+		.flags = CLK_MUX_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "ao_clk81",
+		.ops = &clk_regmap_mux_ro_ops,
+		.parent_names = (const char *[]){ "clk81",
+						  "ao_cts_rtc_oscin" },
+		.num_parents = 2,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_regmap ao_cts_cec = {
+	.data = &(struct clk_regmap_mux_data) {
+		.offset = AO_CRT_CLK_CNTL1,
+		.mask = 0x1,
+		.shift = 27,
+		.flags = CLK_MUX_ROUND_CLOSEST,
+	},
+	.hw.init = &(struct clk_init_data){
+		.name = "ao_cts_cec",
+		.ops = &clk_regmap_mux_ops,
+		/*
+		 * FIXME: The 'fixme' parent obviously does not exist.
+		 *
+		 * ATM, CCF won't call get_parent() if num_parents is 1. It
+		 * does not allow NULL as a parent name either.
+		 *
+		 * On this particular mux, we only know the input #1 parent
+		 * but, on boot, unknown input #0 is set, so it is critical
+		 * to call .get_parent() on it
+		 *
+		 * Until CCF gets fixed, adding this fake parent that won't
+		 * ever be registered should work around the problem
+		 */
+		.parent_names = (const char *[]){ "fixme",
+						  "ao_cts_rtc_oscin" },
+		.num_parents = 2,
+		.flags = CLK_SET_RATE_PARENT,
 	},
 };
 
@@ -50,13 +220,21 @@ static const unsigned int gxbb_aoclk_reset[] = {
 	[RESET_AO_IR_BLASTER] = 23,
 };
 
-static struct clk_regmap *gxbb_aoclk_gate[] = {
-	[CLKID_AO_REMOTE] = &remote_ao,
-	[CLKID_AO_I2C_MASTER] = &i2c_master_ao,
-	[CLKID_AO_I2C_SLAVE] = &i2c_slave_ao,
-	[CLKID_AO_UART1] = &uart1_ao,
-	[CLKID_AO_UART2] = &uart2_ao,
-	[CLKID_AO_IR_BLASTER] = &ir_blaster_ao,
+static struct clk_regmap *gxbb_aoclk[] = {
+	&remote_ao,
+	&i2c_master_ao,
+	&i2c_slave_ao,
+	&uart1_ao,
+	&uart2_ao,
+	&ir_blaster_ao,
+	&ao_cts_oscin,
+	&ao_32k_pre,
+	&ao_32k_div,
+	&ao_32k_sel,
+	&ao_32k,
+	&ao_cts_rtc_oscin,
+	&ao_clk81,
+	&ao_cts_cec,
 };
 
 static const struct clk_hw_onecell_data gxbb_aoclk_onecell_data = {
@@ -67,52 +245,27 @@ static const struct clk_hw_onecell_data gxbb_aoclk_onecell_data = {
 		[CLKID_AO_UART1] = &uart1_ao.hw,
 		[CLKID_AO_UART2] = &uart2_ao.hw,
 		[CLKID_AO_IR_BLASTER] = &ir_blaster_ao.hw,
-		[CLKID_AO_CEC_32K] = &cec_32k_ao.hw,
+		[CLKID_AO_CEC_32K] = &ao_cts_cec.hw,
+		[CLKID_AO_CTS_OSCIN] = &ao_cts_oscin.hw,
+		[CLKID_AO_32K_PRE] = &ao_32k_pre.hw,
+		[CLKID_AO_32K_DIV] = &ao_32k_div.hw,
+		[CLKID_AO_32K_SEL] = &ao_32k_sel.hw,
+		[CLKID_AO_32K] = &ao_32k.hw,
+		[CLKID_AO_CTS_RTC_OSCIN] = &ao_cts_rtc_oscin.hw,
+		[CLKID_AO_CLK81] = &ao_clk81.hw,
 	},
 	.num = NR_CLKS,
 };
 
-static int gxbb_register_cec_ao_32k(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct regmap *regmap;
-	int ret;
-
-	regmap = syscon_node_to_regmap(of_get_parent(dev->of_node));
-	if (IS_ERR(regmap)) {
-		dev_err(dev, "failed to get regmap\n");
-		return PTR_ERR(regmap);
-	}
-
-	/* Specific clocks */
-	cec_32k_ao.regmap = regmap;
-	ret = devm_clk_hw_register(dev, &cec_32k_ao.hw);
-	if (ret) {
-		dev_err(&pdev->dev, "clk cec_32k_ao register failed.\n");
-		return ret;
-	}
-
-	return 0;
-}
-
 static const struct meson_aoclk_data gxbb_aoclkc_data = {
 	.reset_reg	= AO_RTI_GEN_CNTL_REG0,
 	.num_reset	= ARRAY_SIZE(gxbb_aoclk_reset),
 	.reset		= gxbb_aoclk_reset,
-	.num_clks	= ARRAY_SIZE(gxbb_aoclk_gate),
-	.clks		= gxbb_aoclk_gate,
+	.num_clks	= ARRAY_SIZE(gxbb_aoclk),
+	.clks		= gxbb_aoclk,
 	.hw_data	= &gxbb_aoclk_onecell_data,
 };
 
-static int gxbb_aoclkc_probe(struct platform_device *pdev)
-{
-	int ret = gxbb_register_cec_ao_32k(pdev);
-	if (ret)
-		return ret;
-
-	return meson_aoclkc_probe(pdev);
-}
-
 static const struct of_device_id gxbb_aoclkc_match_table[] = {
 	{
 		.compatible	= "amlogic,meson-gx-aoclkc",
@@ -122,7 +275,7 @@ static const struct of_device_id gxbb_aoclkc_match_table[] = {
 };
 
 static struct platform_driver gxbb_aoclkc_driver = {
-	.probe		= gxbb_aoclkc_probe,
+	.probe		= meson_aoclkc_probe,
 	.driver		= {
 		.name	= "gxbb-aoclkc",
 		.of_match_table = gxbb_aoclkc_match_table,
diff --git a/drivers/clk/meson/gxbb-aoclk.h b/drivers/clk/meson/gxbb-aoclk.h
index c514493d989a..1db16f9b37d4 100644
--- a/drivers/clk/meson/gxbb-aoclk.h
+++ b/drivers/clk/meson/gxbb-aoclk.h
@@ -7,25 +7,7 @@
 #ifndef __GXBB_AOCLKC_H
 #define __GXBB_AOCLKC_H
 
-#define NR_CLKS	7
-
-/* AO Configuration Clock registers offsets */
-#define AO_RTI_PWR_CNTL_REG1	0x0c
-#define AO_RTI_PWR_CNTL_REG0	0x10
-#define AO_RTI_GEN_CNTL_REG0	0x40
-#define AO_OSCIN_CNTL		0x58
-#define AO_CRT_CLK_CNTL1	0x68
-#define AO_RTC_ALT_CLK_CNTL0	0x94
-#define AO_RTC_ALT_CLK_CNTL1	0x98
-
-struct aoclk_cec_32k {
-	struct clk_hw hw;
-	struct regmap *regmap;
-};
-
-#define to_aoclk_cec_32k(_hw) container_of(_hw, struct aoclk_cec_32k, hw)
-
-extern const struct clk_ops meson_aoclk_cec_32k_ops;
+#define NR_CLKS	14
 
 #include <dt-bindings/clock/gxbb-aoclkc.h>
 #include <dt-bindings/reset/gxbb-aoclkc.h>
-- 
2.19.2

