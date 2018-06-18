Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EBBC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E69208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:14:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41E69208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935080AbeFROOV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 10:14:21 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:7247 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934853AbeFRONe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 10:13:34 -0400
X-IronPort-AV: E=Sophos;i="5.51,239,1526367600"; 
   d="scan'208";a="15039461"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 18 Jun 2018 07:13:34 -0700
Received: from rob-ult-m19940.microchip.com (10.10.76.4) by
 chn-sv-exch06.mchp-main.com (10.10.76.107) with Microsoft SMTP Server id
 14.3.352.0; Mon, 18 Jun 2018 07:13:33 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <nicolas.ferre@microchip.com>, <boris.brezillon@bootlin.com>,
        <alexandre.belloni@bootlin.com>, <robh+dt@kernel.org>,
        <broonie@kernel.org>, <sboyd@kernel.org>
CC:     <Cristian.Birsan@microchip.com>
Subject: [PATCH v5 2/5] clk: at91: add I2S clock mux driver
Date:   Mon, 18 Jun 2018 17:12:36 +0300
Message-ID: <20180618141239.10892-3-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618141239.10892-1-codrin.ciubotariu@microchip.com>
References: <20180618141239.10892-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is a simple muxing driver that controls the
I2S's clock input by using syscon/regmap to change the parent.
The available inputs can be peripheral clock and generated clock.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---

Changes in v5:
	- removed CLK_IGNORE_UNUSED flag;
	- fixed typo in patch description;
	- fixed letter case in patch description;
	- reduced size of 'bus_id' member of struct clk_i2s_mux from 32b to 8b,
	  and all the other changes that come with it;
	- made 'clk_i2s_mux_ops' static;

 arch/arm/mach-at91/Kconfig     |   4 ++
 drivers/clk/at91/Makefile      |   1 +
 drivers/clk/at91/clk-i2s-mux.c | 116 +++++++++++++++++++++++++++++++++
 3 files changed, 121 insertions(+)
 create mode 100644 drivers/clk/at91/clk-i2s-mux.c

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 1254bf9d91b4..903f23c309df 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -27,6 +27,7 @@ config SOC_SAMA5D2
 	select HAVE_AT91_H32MX
 	select HAVE_AT91_GENERATED_CLK
 	select HAVE_AT91_AUDIO_PLL
+	select HAVE_AT91_I2S_MUX_CLK
 	select PINCTRL_AT91PIO4
 	help
 	  Select this if ou are using one of Microchip's SAMA5D2 family SoC.
@@ -129,6 +130,9 @@ config HAVE_AT91_GENERATED_CLK
 config HAVE_AT91_AUDIO_PLL
 	bool
 
+config HAVE_AT91_I2S_MUX_CLK
+	bool
+
 config SOC_SAM_V4_V5
 	bool
 
diff --git a/drivers/clk/at91/Makefile b/drivers/clk/at91/Makefile
index 082596f37c1d..facc169ebb68 100644
--- a/drivers/clk/at91/Makefile
+++ b/drivers/clk/at91/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_HAVE_AT91_USB_CLK)		+= clk-usb.o
 obj-$(CONFIG_HAVE_AT91_SMD)		+= clk-smd.o
 obj-$(CONFIG_HAVE_AT91_H32MX)		+= clk-h32mx.o
 obj-$(CONFIG_HAVE_AT91_GENERATED_CLK)	+= clk-generated.o
+obj-$(CONFIG_HAVE_AT91_I2S_MUX_CLK)	+= clk-i2s-mux.o
diff --git a/drivers/clk/at91/clk-i2s-mux.c b/drivers/clk/at91/clk-i2s-mux.c
new file mode 100644
index 000000000000..ab834c4a605b
--- /dev/null
+++ b/drivers/clk/at91/clk-i2s-mux.c
@@ -0,0 +1,116 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  Copyright (C) 2018 Microchip Technology Inc,
+ *                     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
+ *
+ *
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/of.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#include <soc/at91/atmel-sfr.h>
+
+#define	I2S_BUS_NR	2
+
+struct clk_i2s_mux {
+	struct clk_hw hw;
+	struct regmap *regmap;
+	u8 bus_id;
+};
+
+#define to_clk_i2s_mux(hw) container_of(hw, struct clk_i2s_mux, hw)
+
+static u8 clk_i2s_mux_get_parent(struct clk_hw *hw)
+{
+	struct clk_i2s_mux *mux = to_clk_i2s_mux(hw);
+	u32 val;
+
+	regmap_read(mux->regmap, AT91_SFR_I2SCLKSEL, &val);
+
+	return (val & BIT(mux->bus_id)) >> mux->bus_id;
+}
+
+static int clk_i2s_mux_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct clk_i2s_mux *mux = to_clk_i2s_mux(hw);
+
+	return regmap_update_bits(mux->regmap, AT91_SFR_I2SCLKSEL,
+				  BIT(mux->bus_id), index << mux->bus_id);
+}
+
+static const struct clk_ops clk_i2s_mux_ops = {
+	.get_parent = clk_i2s_mux_get_parent,
+	.set_parent = clk_i2s_mux_set_parent,
+	.determine_rate = __clk_mux_determine_rate,
+};
+
+static struct clk_hw * __init
+at91_clk_i2s_mux_register(struct regmap *regmap, const char *name,
+			  const char * const *parent_names,
+			  unsigned int num_parents, u8 bus_id)
+{
+	struct clk_init_data init = {};
+	struct clk_i2s_mux *i2s_ck;
+	int ret;
+
+	i2s_ck = kzalloc(sizeof(*i2s_ck), GFP_KERNEL);
+	if (!i2s_ck)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &clk_i2s_mux_ops;
+	init.parent_names = parent_names;
+	init.num_parents = num_parents;
+
+	i2s_ck->hw.init = &init;
+	i2s_ck->bus_id = bus_id;
+	i2s_ck->regmap = regmap;
+
+	ret = clk_hw_register(NULL, &i2s_ck->hw);
+	if (ret) {
+		kfree(i2s_ck);
+		return ERR_PTR(ret);
+	}
+
+	return &i2s_ck->hw;
+}
+
+static void __init of_sama5d2_clk_i2s_mux_setup(struct device_node *np)
+{
+	struct regmap *regmap_sfr;
+	u8 bus_id;
+	const char *parent_names[2];
+	struct device_node *i2s_mux_np;
+	struct clk_hw *hw;
+	int ret;
+
+	regmap_sfr = syscon_regmap_lookup_by_compatible("atmel,sama5d2-sfr");
+	if (IS_ERR(regmap_sfr))
+		return;
+
+	for_each_child_of_node(np, i2s_mux_np) {
+		if (of_property_read_u8(i2s_mux_np, "reg", &bus_id))
+			continue;
+
+		if (bus_id > I2S_BUS_NR)
+			continue;
+
+		ret = of_clk_parent_fill(i2s_mux_np, parent_names, 2);
+		if (ret != 2)
+			continue;
+
+		hw = at91_clk_i2s_mux_register(regmap_sfr, i2s_mux_np->name,
+					       parent_names, 2, bus_id);
+		if (IS_ERR(hw))
+			continue;
+
+		of_clk_add_hw_provider(i2s_mux_np, of_clk_hw_simple_get, hw);
+	}
+}
+
+CLK_OF_DECLARE(sama5d2_clk_i2s_mux, "atmel,sama5d2-clk-i2s-mux",
+	       of_sama5d2_clk_i2s_mux_setup);
-- 
2.17.1

