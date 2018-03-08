Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936015AbeCHQ4i (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 11:56:38 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:45552 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934349AbeCHQyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 11:54:53 -0500
From: <gabriel.fernandez@st.com>
To: <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Gabriel Fernandez <gabriel.fernandez@st.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <gabriel.fernandez.st@gmail.com>, <olivier.bideau@st.com>,
        Loic PALLARDY <loic.pallardy@st.com>,
        benjamin GAIGNARD <benjamin.gaignard@st.com>
Subject: [PATCH v2 02/12] clk: stm32mp1: Introduce STM32MP1 clock driver
Date: Thu, 8 Mar 2018 17:53:55 +0100
Message-ID: <1520528045-18330-3-git-send-email-gabriel.fernandez@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520528045-18330-1-git-send-email-gabriel.fernandez@st.com>
References: <1520528045-18330-1-git-send-email-gabriel.fernandez@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG4NODE2.st.com
 (10.75.127.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-08_10:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

This patch introduces the mechanism to probe stm32mp1 driver.
It also defines registers definition.
This patch also introduces the generic mechanism to register
a clock (a simple gate, divider and fixed factor).

All clocks will be defined in one table.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/clk/Kconfig                       |   6 +
 drivers/clk/Makefile                      |   1 +
 drivers/clk/clk-stm32mp1.c                | 364 ++++++++++++++++++++++++++++++
 include/dt-bindings/clock/stm32mp1-clks.h | 254 +++++++++++++++++++++
 4 files changed, 625 insertions(+)
 create mode 100644 drivers/clk/clk-stm32mp1.c
 create mode 100644 include/dt-bindings/clock/stm32mp1-clks.h

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
index 0000000..6261a92
--- /dev/null
+++ b/drivers/clk/clk-stm32mp1.c
@@ -0,0 +1,364 @@
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
+#define RCC_I2C46CKSELR		0xC0
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
+#define RCC_FDCANCKSELR		0x90C
+#define RCC_SAI1CKSELR		0x8C8
+#define RCC_SAI2CKSELR		0x8CC
+#define RCC_SAI3CKSELR		0x8D0
+#define RCC_SAI4CKSELR		0x8D4
+#define RCC_ADCCKSELR		0x928
+#define RCC_MPCKDIVR		0x2C
+#define RCC_DSICKSELR		0x924
+#define RCC_CPERCKSELR		0xD0
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
+struct fixed_factor_cfg {
+	unsigned int mult;
+	unsigned int div;
+};
+
+struct div_cfg {
+	u32 reg_off;
+	u8 shift;
+	u8 width;
+	u8 div_flags;
+	const struct clk_div_table *table;
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
+static struct clk_hw *
+_clk_hw_register_fixed_factor(struct device *dev,
+			      struct clk_hw_onecell_data *clk_data,
+			      void __iomem *base, spinlock_t *lock,
+			      const struct clock_config *cfg)
+{
+	struct fixed_factor_cfg *ff_cfg = cfg->cfg;
+
+	return clk_hw_register_fixed_factor(dev, cfg->name, cfg->parent_name,
+					    cfg->flags, ff_cfg->mult,
+					    ff_cfg->div);
+}
+
+static struct clk_hw *
+_clk_hw_register_divider_table(struct device *dev,
+			       struct clk_hw_onecell_data *clk_data,
+			       void __iomem *base, spinlock_t *lock,
+			       const struct clock_config *cfg)
+{
+	struct div_cfg *div_cfg = cfg->cfg;
+
+	return clk_hw_register_divider_table(dev,
+					     cfg->name,
+					     cfg->parent_name,
+					     cfg->flags,
+					     div_cfg->reg_off + base,
+					     div_cfg->shift,
+					     div_cfg->width,
+					     div_cfg->div_flags,
+					     div_cfg->table,
+					     lock);
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
+#define FIXED_FACTOR(_id, _name, _parent, _flags, _mult, _div)\
+{\
+	.id		= _id,\
+	.name		= _name,\
+	.parent_name	= _parent,\
+	.flags		= _flags,\
+	.cfg		=  &(struct fixed_factor_cfg) {\
+		.mult = _mult,\
+		.div = _div,\
+	},\
+	.func		= _clk_hw_register_fixed_factor,\
+}
+
+#define DIV_TABLE(_id, _name, _parent, _flags, _offset, _shift, _width,\
+		  _div_flags, _div_table)\
+{\
+	.id		= _id,\
+	.name		= _name,\
+	.parent_name	= _parent,\
+	.flags		= _flags,\
+	.cfg		=  &(struct div_cfg) {\
+		.reg_off	= _offset,\
+		.shift		= _shift,\
+		.width		= _width,\
+		.div_flags	= _div_flags,\
+		.table		= _div_table,\
+	},\
+	.func		= _clk_hw_register_divider_table,\
+}
+
+#define DIV(_id, _name, _parent, _flags, _offset, _shift, _width, _div_flags)\
+	DIV_TABLE(_id, _name, _parent, _flags, _offset, _shift, _width,\
+		  _div_flags, NULL)
+
+static const struct clock_config stm32mp1_clock_cfg[] = {
+	/* Oscillator divider */
+	DIV(NO_ID, "clk-hsi-div", "clk-hsi", 0, RCC_HSICFGR, 0, 2,
+	    CLK_DIVIDER_READ_ONLY),
+
+	/*  External / Internal Oscillators */
+	GATE(CK_LSI, "ck_lsi", "clk-lsi", 0, RCC_RDLSICR, 0, 0),
+	GATE(CK_LSE, "ck_lse", "clk-lse", 0, RCC_BDCR, 0, 0),
+
+	FIXED_FACTOR(CK_HSE_DIV2, "clk-hse-div2", "ck_hse", 0, 1, 2),
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
+		.compatible = "st,stm32mp1-rcc",
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
+	void __iomem *base;
+
+	base = of_iomap(np, 0);
+	if (!base) {
+		pr_err("%s: unable to map resource", np->name);
+		of_node_put(np);
+		return;
+	}
+
+	if (stm32_rcc_init(np, base, stm32mp1_match_data)) {
+		iounmap(base);
+		of_node_put(np);
+	}
+}
+
+CLK_OF_DECLARE_DRIVER(stm32mp1_rcc, "st,stm32mp1-rcc", stm32mp1_rcc_init);
diff --git a/include/dt-bindings/clock/stm32mp1-clks.h b/include/dt-bindings/clock/stm32mp1-clks.h
new file mode 100644
index 0000000..86e3ec6
--- /dev/null
+++ b/include/dt-bindings/clock/stm32mp1-clks.h
@@ -0,0 +1,254 @@
+/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/*
+ * Copyright (C) STMicroelectronics 2018 - All Rights Reserved
+ * Author: Gabriel Fernandez <gabriel.fernandez@st.com> for STMicroelectronics.
+ */
+
+#ifndef _DT_BINDINGS_STM32MP1_CLKS_H_
+#define _DT_BINDINGS_STM32MP1_CLKS_H_
+
+/* OSCILLATOR clocks */
+#define CK_HSE		0
+#define CK_CSI		1
+#define CK_LSI		2
+#define CK_LSE		3
+#define CK_HSI		4
+#define CK_HSE_DIV2	5
+
+/* Bus clocks */
+#define TIM2		6
+#define TIM3		7
+#define TIM4		8
+#define TIM5		9
+#define TIM6		10
+#define TIM7		11
+#define TIM12		12
+#define TIM13		13
+#define TIM14		14
+#define LPTIM1		15
+#define SPI2		16
+#define SPI3		17
+#define USART2		18
+#define USART3		19
+#define UART4		20
+#define UART5		21
+#define UART7		22
+#define UART8		23
+#define I2C1		24
+#define I2C2		25
+#define I2C3		26
+#define I2C5		27
+#define SPDIF		28
+#define CEC		29
+#define DAC12		30
+#define MDIO		31
+#define TIM1		32
+#define TIM8		33
+#define TIM15		34
+#define TIM16		35
+#define TIM17		36
+#define SPI1		37
+#define SPI4		38
+#define SPI5		39
+#define USART6		40
+#define SAI1		41
+#define SAI2		42
+#define SAI3		43
+#define DFSDM		44
+#define FDCAN		45
+#define LPTIM2		46
+#define LPTIM3		47
+#define LPTIM4		48
+#define LPTIM5		49
+#define SAI4		50
+#define SYSCFG		51
+#define VREF		52
+#define TMPSENS		53
+#define PMBCTRL		54
+#define HDP		55
+#define LTDC		56
+#define DSI		57
+#define IWDG2		58
+#define USBPHY		59
+#define STGENRO		60
+#define SPI6		61
+#define I2C4		62
+#define I2C6		63
+#define USART1		64
+#define RTCAPB		65
+#define TZC		66
+#define TZPC		67
+#define IWDG1		68
+#define BSEC		69
+#define STGEN		70
+#define DMA1		71
+#define DMA2		72
+#define DMAMUX		73
+#define ADC12		74
+#define USBO		75
+#define SDMMC3		76
+#define DCMI		77
+#define CRYP2		78
+#define HASH2		79
+#define RNG2		80
+#define CRC2		81
+#define HSEM		82
+#define IPCC		83
+#define GPIOA		84
+#define GPIOB		85
+#define GPIOC		86
+#define GPIOD		87
+#define GPIOE		88
+#define GPIOF		89
+#define GPIOG		90
+#define GPIOH		91
+#define GPIOI		92
+#define GPIOJ		93
+#define GPIOK		94
+#define GPIOZ		95
+#define CRYP1		96
+#define HASH1		97
+#define RNG1		98
+#define BKPSRAM		99
+#define MDMA		100
+#define GPU		101
+#define ETHCK		102
+#define ETHTX		103
+#define ETHRX		104
+#define ETHMAC		105
+#define FMC		106
+#define QSPI		107
+#define SDMMC1		108
+#define SDMMC2		109
+#define CRC1		110
+#define USBH		111
+#define ETHSTP		112
+
+/* Kernel clocks */
+#define SDMMC1_K	118
+#define SDMMC2_K	119
+#define SDMMC3_K	120
+#define FMC_K		121
+#define QSPI_K		122
+#define ETHCK_K		123
+#define RNG1_K		124
+#define RNG2_K		125
+#define GPU_K		126
+#define USBPHY_K	127
+#define STGEN_K		128
+#define SPDIF_K		129
+#define SPI1_K		130
+#define SPI2_K		131
+#define SPI3_K		132
+#define SPI4_K		133
+#define SPI5_K		134
+#define SPI6_K		135
+#define CEC_K		136
+#define I2C1_K		137
+#define I2C2_K		138
+#define I2C3_K		139
+#define I2C4_K		140
+#define I2C5_K		141
+#define I2C6_K		142
+#define LPTIM1_K	143
+#define LPTIM2_K	144
+#define LPTIM3_K	145
+#define LPTIM4_K	146
+#define LPTIM5_K	147
+#define USART1_K	148
+#define USART2_K	149
+#define USART3_K	150
+#define UART4_K		151
+#define UART5_K		152
+#define USART6_K	153
+#define UART7_K		154
+#define UART8_K		155
+#define DFSDM_K		156
+#define FDCAN_K		157
+#define SAI1_K		158
+#define SAI2_K		159
+#define SAI3_K		160
+#define SAI4_K		161
+#define ADC12_K		162
+#define DSI_K		163
+#define DSI_PX		164
+#define ADFSDM_K	165
+#define USBO_K		166
+#define LTDC_PX		167
+#define DAC12_K		168
+#define ETHPTP_K	169
+
+/* PLL */
+#define PLL1		176
+#define PLL2		177
+#define PLL3		178
+#define PLL4		179
+
+/* ODF */
+#define PLL1_P		180
+#define PLL1_Q		181
+#define PLL1_R		182
+#define PLL2_P		183
+#define PLL2_Q		184
+#define PLL2_R		185
+#define PLL3_P		186
+#define PLL3_Q		187
+#define PLL3_R		188
+#define PLL4_P		189
+#define PLL4_Q		190
+#define PLL4_R		191
+
+/* AUX */
+#define RTC		192
+
+/* MCLK */
+#define CK_PER		193
+#define CK_MPU		194
+#define CK_AXI		195
+#define CK_MCU		196
+
+/* Time base */
+#define TIM2_K		197
+#define TIM3_K		198
+#define TIM4_K		199
+#define TIM5_K		200
+#define TIM6_K		201
+#define TIM7_K		202
+#define TIM12_K		203
+#define TIM13_K		204
+#define TIM14_K		205
+#define TIM1_K		206
+#define TIM8_K		207
+#define TIM15_K		208
+#define TIM16_K		209
+#define TIM17_K		210
+
+/* MCO clocks */
+#define CK_MCO1		211
+#define CK_MCO2		212
+
+/* TRACE & DEBUG clocks */
+#define DBG		213
+#define CK_DBG		214
+#define CK_TRACE	215
+
+/* DDR */
+#define DDRC1		220
+#define DDRC1LP		221
+#define DDRC2		222
+#define DDRC2LP		223
+#define DDRPHYC		224
+#define DDRPHYCLP	225
+#define DDRCAPB		226
+#define DDRCAPBLP	227
+#define AXIDCG		228
+#define DDRPHYCAPB	229
+#define DDRPHYCAPBLP	230
+#define DDRPERFM	231
+
+#define STM32MP1_LAST_CLK 232
+
+#define LTDC_K		LTDC_PX
+#define ETHMAC_K	ETHCK_K
+
+#endif /* _DT_BINDINGS_STM32MP1_CLKS_H_ */
-- 
1.9.1
