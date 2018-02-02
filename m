Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752071AbeBBOHH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 09:07:07 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:59747 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752177AbeBBOEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 09:04:51 -0500
From: <gabriel.fernandez@st.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Gabriel Fernandez <gabriel.fernandez@st.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <gabriel.fernandez.st@gmail.com>, <olivier.bideau@st.com>
Subject: [PATCH 03/14] clk: stm32mp1: Introduce STM32MP1 clock driver
Date: Fri, 2 Feb 2018 15:03:31 +0100
Message-ID: <1517580222-23301-4-git-send-email-gabriel.fernandez@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1517580222-23301-1-git-send-email-gabriel.fernandez@st.com>
References: <1517580222-23301-1-git-send-email-gabriel.fernandez@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG8NODE1.st.com (10.75.127.22) To SFHDAG4NODE2.st.com
 (10.75.127.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-02_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

This patch introduces the mechanism to probe stm32mp1 driver.

It also defines registers and clocks source definition.

This patch also introduces the generic mechanism to register
a clock (a simple gate).

All clocks will be defined in one table.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/clk/Kconfig        |   6 +
 drivers/clk/Makefile       |   1 +
 drivers/clk/clk-stm32mp1.c | 513 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 520 insertions(+)
 create mode 100644 drivers/clk/clk-stm32mp1.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 1c4e1aa..517c4b3 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -226,6 +226,12 @@ config COMMON_CLK_VC5
 	  This driver supports the IDT VersaClock 5 and VersaClock 6
 	  programmable clock generators.
 
+config COMMON_CLK_STM32MP157
+	def_bool COMMON_CLK && MACH_STM32MP157
+	help
+	---help---
+	  Support for stm32mp157 SoC family clocks
+
 source "drivers/clk/bcm/Kconfig"
 source "drivers/clk/hisilicon/Kconfig"
 source "drivers/clk/imgtec/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index f7f761b..69f6f59 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -46,6 +46,7 @@ obj-$(CONFIG_COMMON_CLK_SI514)		+= clk-si514.o
 obj-$(CONFIG_COMMON_CLK_SI570)		+= clk-si570.o
 obj-$(CONFIG_ARCH_STM32)		+= clk-stm32f4.o
 obj-$(CONFIG_ARCH_STM32)		+= clk-stm32h7.o
+obj-$(CONFIG_COMMON_CLK_STM32MP157)	+= clk-stm32mp1.o
 obj-$(CONFIG_ARCH_TANGO)		+= clk-tango4.o
 obj-$(CONFIG_CLK_TWL6040)		+= clk-twl6040.o
 obj-$(CONFIG_ARCH_U300)			+= clk-u300.o
diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
new file mode 100644
index 0000000..6e39e85
--- /dev/null
+++ b/drivers/clk/clk-stm32mp1.c
@@ -0,0 +1,513 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) STMicroelectronics 2018 - All Rights Reserved
+ * Author: Olivier Bideau <olivier.bideau@st.com> for STMicroelectronics.
+ * Author: Gabriel Fernandez <gabriel.fernandez@st.com> for STMicroelectronics.
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+#include <dt-bindings/clock/stm32mp1-clks.h>
+
+static DEFINE_SPINLOCK(rlock);
+
+#define RCC_OCENSETR		0x0C
+#define RCC_OCENCLRR		0x10
+#define RCC_OCRDYR		0x808
+#define RCC_HSICFGR		0x18
+#define RCC_RDLSICR		0x144
+#define RCC_PLL1CR		0x80
+#define RCC_PLL1CFGR1		0x84
+#define RCC_PLL1CFGR2		0x88
+#define RCC_PLL2CR		0x94
+#define RCC_PLL2CFGR1		0x98
+#define RCC_PLL2CFGR2		0x9C
+#define RCC_PLL3CR		0x880
+#define RCC_PLL3CFGR1		0x884
+#define RCC_PLL3CFGR2		0x888
+#define RCC_PLL4CR		0x894
+#define RCC_PLL4CFGR1		0x898
+#define RCC_PLL4CFGR2		0x89C
+#define RCC_APB1ENSETR		0xA00
+#define RCC_APB2ENSETR		0xA08
+#define RCC_APB3ENSETR		0xA10
+#define RCC_APB4ENSETR		0x200
+#define RCC_APB5ENSETR		0x208
+#define RCC_AHB2ENSETR		0xA18
+#define RCC_AHB3ENSETR		0xA20
+#define RCC_AHB4ENSETR		0xA28
+#define RCC_AHB5ENSETR		0x210
+#define RCC_AHB6ENSETR		0x218
+#define RCC_AHB6LPENSETR	0x318
+#define RCC_RCK12SELR		0x28
+#define RCC_RCK3SELR		0x820
+#define RCC_RCK4SELR		0x824
+#define RCC_MPCKSELR		0x20
+#define RCC_ASSCKSELR		0x24
+#define RCC_MSSCKSELR		0x48
+#define RCC_SPI6CKSELR		0xC4
+#define RCC_SDMMC12CKSELR	0x8F4
+#define RCC_SDMMC3CKSELR	0x8F8
+#define RCC_FMCCKSELR		0x904
+#define RCC_I2C4CKSELR		0xC0
+#define RCC_I2C12CKSELR		0x8C0
+#define RCC_I2C35CKSELR		0x8C4
+#define RCC_UART1CKSELR		0xC8
+#define RCC_QSPICKSELR		0x900
+#define RCC_ETHCKSELR		0x8FC
+#define RCC_RNG1CKSELR		0xCC
+#define RCC_RNG2CKSELR		0x920
+#define RCC_GPUCKSELR		0x938
+#define RCC_USBCKSELR		0x91C
+#define RCC_STGENCKSELR		0xD4
+#define RCC_SPDIFCKSELR		0x914
+#define RCC_SPI2S1CKSELR	0x8D8
+#define RCC_SPI2S23CKSELR	0x8DC
+#define RCC_SPI2S45CKSELR	0x8E0
+#define RCC_CECCKSELR		0x918
+#define RCC_LPTIM1CKSELR	0x934
+#define RCC_LPTIM23CKSELR	0x930
+#define RCC_LPTIM45CKSELR	0x92C
+#define RCC_UART24CKSELR	0x8E8
+#define RCC_UART35CKSELR	0x8EC
+#define RCC_UART6CKSELR		0x8E4
+#define RCC_UART78CKSELR	0x8F0
+#define RCC_DFSDMCKSELR		0x910
+#define RCC_FDCANCKSELR		0x90C
+#define RCC_SAI1CKSELR		0x8C8
+#define RCC_SAI2CKSELR		0x8CC
+#define RCC_SAI3CKSELR		0x8D0
+#define RCC_SAI4CKSELR		0x8D4
+#define RCC_ADCCKSELR		0x928
+#define RCC_MPCKDIVR		0x2C
+#define RCC_DSICKSELR		0x924
+#define RCC_CPERCKSELR		0xD0
+#define RCC_GRSTCSETR		0x404
+#define RCC_MCO1CFGR		0x800
+#define RCC_MCO2CFGR		0x804
+#define RCC_BDCR		0x140
+#define RCC_AXIDIVR		0x30
+#define RCC_MCUDIVR		0x830
+#define RCC_APB1DIVR		0x834
+#define RCC_APB2DIVR		0x838
+#define RCC_APB3DIVR		0x83C
+#define RCC_APB4DIVR		0x3C
+#define RCC_APB5DIVR		0x40
+#define RCC_TIMG1PRER		0x828
+#define RCC_TIMG2PRER		0x82C
+#define RCC_RTCDIVR		0x44
+#define RCC_DBGCFGR		0x80C
+
+#define RCC_CLR	0x4
+
+static const char * const ref12_parents[] = {
+	"ck_hsi", "ck_hse"
+};
+
+static const char * const ref3_parents[] = {
+	"ck_hsi", "ck_hse", "ck_csi"
+};
+
+static const char * const ref4_parents[] = {
+	"ck_hsi", "ck_hse", "ck_csi"
+};
+
+static const char * const cpu_src[] = {
+	"ck_hsi", "ck_hse", "pll1_p"
+};
+
+static const char * const axi_src[] = {
+	"ck_hsi", "ck_hse", "pll2_p", "pll3_p"
+};
+
+static const char * const per_src[] = {
+	"ck_hsi", "ck_csi", "ck_hse"
+};
+
+static const char * const mcu_src[] = {
+	"ck_hsi", "ck_hse", "ck_csi", "pll3_p"
+};
+
+static const char * const sdmmc1_src[] = {
+	"ck_axi", "pll3_r", "pll4_p", "ck_hsi"
+};
+
+static const char * const sdmmc2_src[] = {
+	"ck_axi", "pll3_r", "pll4_p", "ck_hsi"
+};
+
+static const char * const sdmmc3_src[] = {
+	"ck_mcu", "pll3_r", "pll4_p", "ck_hsi"
+};
+
+static const char * const fmc_src[] = {
+	"ck_axi", "pll3_r", "pll4_p", "ck_per"
+};
+
+static const char * const qspi_src[] = {
+	"ck_axi", "pll3_r", "pll4_p", "ck_per"
+};
+
+static const char * const eth_src[] = {
+	"pll4_p", "pll3_q"
+};
+
+static const char * const rng_src[] = {
+	"ck_csi", "pll4_r", "ck_lse", "ck_lsi"
+};
+
+static const char * const usbphy_src[] = {
+	"ck_hse", "pll4_r", "clk-hse-div2"
+};
+
+static const char * const usbo_src[] = {
+	"pll4_r", "ck_usbo_48m"
+};
+
+static const char * const stgen_src[] = {
+	"ck_hsi", "ck_hse"
+};
+
+static const char * const spdif_src[] = {
+	"pll4_p", "pll3_q", "ck_hsi"
+};
+
+static const char * const spi1_src[] = {
+	"pll4_p", "pll3_q", "i2s_ckin", "ck_per"
+};
+
+static const char * const spi2_src[] = {
+	"pll4_p", "pll3_q", "i2s_ckin", "ck_per"
+};
+
+static const char * const spi3_src[] = {
+	"pll4_p", "pll3_q", "i2s_ckin", "ck_per"
+};
+
+static const char * const spi4_src[] = {
+	"pclk2", "pll4_q", "ck_hsi", "ck_csi", "ck_hse"
+};
+
+const char * const spi5_src[] = {
+	"pclk2", "pll4_q", "ck_hsi", "ck_csi", "ck_hse"
+};
+
+static const char * const spi6_src[] = {
+	"pclk5", "pll4_q", "ck_hsi", "ck_csi", "ck_hse", "pll3_q"
+};
+
+static const char * const cec_src[] = {
+	"ck_lse", "ck_lsi", "ck_csi"
+};
+
+static const char * const i2c1_src[] = {
+	"pclk1", "pll4_r", "ck_hsi", "ck_csi"
+};
+
+static const char * const i2c2_src[] = {
+	"pclk1", "pll4_r", "ck_hsi", "ck_csi"
+};
+
+static const char * const i2c3_src[] = {
+	"pclk1", "pll4_r", "ck_hsi", "ck_csi"
+};
+
+static const char * const i2c4_src[] = {
+	"pclk5", "pll3_q", "ck_hsi", "ck_csi"
+};
+
+static const char * const i2c5_src[] = {
+	"pclk1", "pll4_r", "ck_hsi", "ck_csi"
+};
+
+static const char * const i2c6_src[] = {
+	"pclk5", "pll3_q", "ck_hsi", "ck_csi"
+};
+
+static const char * const lptim1_src[] = {
+	"pclk1", "pll4_p", "pll3_q", "ck_lse", "ck_lsi", "ck_per"
+};
+
+static const char * const lptim2_src[] = {
+	"pclk3", "pll4_q", "ck_per", "ck_lse", "ck_lsi"
+};
+
+static const char * const lptim3_src[] = {
+	"pclk3", "pll4_q", "ck_per", "ck_lse", "ck_lsi"
+};
+
+static const char * const lptim4_src[] = {
+	"pclk3", "pll4_p", "pll3_q", "ck_lse", "ck_lsi", "ck_per"
+};
+
+static const char * const lptim5_src[] = {
+	"pclk3", "pll4_p", "pll3_q", "ck_lse", "ck_lsi", "ck_per"
+};
+
+static const char * const usart1_src[] = {
+	"pclk5", "pll3_q", "ck_hsi", "ck_csi", "pll4_q", "ck_hse"
+};
+
+const char * const usart2_src[] = {
+	"pclk1", "pll4_q", "ck_hsi", "ck_csi", "ck_hse"
+};
+
+static const char * const usart3_src[] = {
+	"pclk1", "pll4_q", "ck_hsi", "ck_csi", "ck_hse"
+};
+
+static const char * const uart4_src[] = {
+	"pclk1", "pll4_q", "ck_hsi", "ck_csi", "ck_hse"
+};
+
+static const char * const uart5_src[] = {
+	"pclk1", "pll4_q", "ck_hsi", "ck_csi", "ck_hse"
+};
+
+static const char * const usart6_src[] = {
+	"pclk2", "pll4_q", "ck_hsi", "ck_csi", "ck_hse"
+};
+
+static const char * const uart7_src[] = {
+	"pclk1", "pll4_q", "ck_hsi", "ck_csi", "ck_hse"
+};
+
+static const char * const uart8_src[] = {
+	"pclk1", "pll4_q", "ck_hsi", "ck_csi", "ck_hse"
+};
+
+static const char * const adfsdm_src[] = {
+	"pll4_q", "pll3_q", "i2s_ckin", "ck_per"
+};
+
+static const char * const dfsdm_src[] = {
+	"pclk2", "ck_mcu"
+};
+
+static const char * const fdcan_src[] = {
+	"ck_hse", "pll3_q", "pll4_q"
+};
+
+static const char * const sai_src[] = {
+	"pll4_q", "pll3_q", "i2s_ckin", "ck_per"
+};
+
+static const char * const sai2_src[] = {
+	"pll4_q", "pll3_q", "i2s_ckin", "ck_per", "spdif_ck_symb"
+};
+
+static const char * const adc12_src[] = {
+	"pll4_q", "ck_per"
+};
+
+static const char * const dsi_src[] = {
+	"ck_dsi_phy", "pll4_p"
+};
+
+static const char * const rtc_src[] = {
+	"off", "ck_lse", "ck_lsi", "ck_hse_rtc"
+};
+
+static const char * const ltdc_src[] = {
+	"pll4_q"
+};
+
+static const char * const ck_trace_src[] = {
+	"ck_axi"
+};
+
+static const char * const mco1_src[] = {
+	"ck_hsi", "ck_hse", "ck_csi", "ck_lsi", "ck_lse"
+};
+
+static const char * const mco2_src[] = {
+	"ck_mpu", "ck_axi", "ck_mcu", "pll4_p", "ck_hse", "ck_hsi"
+};
+
+struct clock_config {
+	u32 id;
+	const char *name;
+	union {
+		const char *parent_name;
+		const char * const *parent_names;
+	};
+	int num_parents;
+	unsigned long flags;
+	void *cfg;
+	struct clk_hw * (*func)(struct device *dev,
+				struct clk_hw_onecell_data *clk_data,
+				void __iomem *base, spinlock_t *lock,
+				const struct clock_config *cfg);
+};
+
+#define NO_ID ~0
+
+struct gate_cfg {
+	u32 reg_off;
+	u8 bit_idx;
+	u8 gate_flags;
+};
+
+static struct clk_hw *
+_clk_hw_register_gate(struct device *dev,
+		      struct clk_hw_onecell_data *clk_data,
+		      void __iomem *base, spinlock_t *lock,
+		      const struct clock_config *cfg)
+{
+	struct gate_cfg *gate_cfg = cfg->cfg;
+
+	return clk_hw_register_gate(dev,
+				    cfg->name,
+				    cfg->parent_name,
+				    cfg->flags,
+				    gate_cfg->reg_off + base,
+				    gate_cfg->bit_idx,
+				    gate_cfg->gate_flags,
+				    lock);
+}
+
+#define GATE(_id, _name, _parent, _flags, _offset, _bit_idx, _gate_flags)\
+{\
+	.id		= _id,\
+	.name		= _name,\
+	.parent_name	= _parent,\
+	.flags		= _flags,\
+	.cfg		=  &(struct gate_cfg) {\
+		.reg_off	= _offset,\
+		.bit_idx	= _bit_idx,\
+		.gate_flags	= _gate_flags,\
+	},\
+	.func		= _clk_hw_register_gate,\
+}
+
+static const struct clock_config stm32mp1_clock_cfg[] = {
+	/*  External / Internal Oscillators */
+	GATE(CK_LSI, "ck_lsi", "clk-lsi", 0, RCC_RDLSICR, 0, 0),
+	GATE(CK_LSE, "ck_lse", "clk-lse", 0, RCC_BDCR, 0, 0),
+};
+
+struct stm32_clock_match_data {
+	const struct clock_config *cfg;
+	unsigned int num;
+	unsigned int maxbinding;
+};
+
+static struct stm32_clock_match_data stm32mp1_data = {
+	.cfg		= stm32mp1_clock_cfg,
+	.num		= ARRAY_SIZE(stm32mp1_clock_cfg),
+	.maxbinding	= STM32MP1_LAST_CLK,
+};
+
+static const struct of_device_id stm32mp1_match_data[] = {
+	{
+		.compatible = "st,stm32mp1-rcc-clk",
+		.data = &stm32mp1_data,
+	},
+	{ }
+};
+
+static int stm32_register_hw_clk(struct device *dev,
+				 struct clk_hw_onecell_data *clk_data,
+				 void __iomem *base, spinlock_t *lock,
+				 const struct clock_config *cfg)
+{
+	static struct clk_hw **hws;
+	struct clk_hw *hw = ERR_PTR(-ENOENT);
+
+	hws = clk_data->hws;
+
+	if (cfg->func)
+		hw = (*cfg->func)(dev, clk_data, base, lock, cfg);
+
+	if (IS_ERR(hw)) {
+		pr_err("Unable to register %s\n", cfg->name);
+		return  PTR_ERR(hw);
+	}
+
+	if (cfg->id != NO_ID)
+		hws[cfg->id] = hw;
+
+	return 0;
+}
+
+static int stm32_rcc_init(struct device_node *np,
+			  void __iomem *base,
+			  const struct of_device_id *match_data)
+{
+	struct clk_hw_onecell_data *clk_data;
+	struct clk_hw **hws;
+	const struct of_device_id *match;
+	const struct stm32_clock_match_data *data;
+	int err, n, max_binding;
+
+	match = of_match_node(match_data, np);
+	if (!match) {
+		pr_err("%s: match data not found\n", __func__);
+		return -ENODEV;
+	}
+
+	data = match->data;
+
+	max_binding =  data->maxbinding;
+
+	clk_data = kzalloc(sizeof(*clk_data) +
+				  sizeof(*clk_data->hws) * max_binding,
+				  GFP_KERNEL);
+	if (!clk_data)
+		return -ENOMEM;
+
+	clk_data->num = max_binding;
+
+	hws = clk_data->hws;
+
+	for (n = 0; n < max_binding; n++)
+		hws[n] = ERR_PTR(-ENOENT);
+
+	for (n = 0; n < data->num; n++) {
+		err = stm32_register_hw_clk(NULL, clk_data, base, &rlock,
+					    &data->cfg[n]);
+		if (err) {
+			pr_err("%s: can't register  %s\n", __func__,
+			       data->cfg[n].name);
+
+			kfree(clk_data);
+
+			return err;
+		}
+	}
+
+	return of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_data);
+}
+
+static void stm32mp1_rcc_init(struct device_node *np)
+{
+	struct device_node *parent;
+	void __iomem *base;
+
+	parent = of_get_parent(np);
+	if (!parent) {
+		pr_err("%s: parent should be syscon node\n", __func__);
+		return;
+	}
+
+	base = of_iomap(parent, 0);
+	if (!base) {
+		pr_err("%s: unable to map resource", parent->name);
+		of_node_put(parent);
+		return;
+	}
+
+	if (stm32_rcc_init(np, base, stm32mp1_match_data)) {
+		iounmap(base);
+		of_node_put(parent);
+	}
+}
+
+CLK_OF_DECLARE(stm32mp1_rcc, "st,stm32mp1-rcc-clk", stm32mp1_rcc_init);
-- 
1.9.1
