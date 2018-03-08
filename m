Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935988AbeCHQzZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 11:55:25 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:1341 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932076AbeCHQzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 11:55:21 -0500
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
Subject: [PATCH v2 09/12] clk: stm32mp1: add Peripheral & Kernel Clocks
Date: Thu, 8 Mar 2018 17:54:02 +0100
Message-ID: <1520528045-18330-10-git-send-email-gabriel.fernandez@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520528045-18330-1-git-send-email-gabriel.fernandez@st.com>
References: <1520528045-18330-1-git-send-email-gabriel.fernandez@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG4NODE2.st.com
 (10.75.127.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-08_10:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

Each peripheral requires a bus interface clock.
Some peripherals need also a dedicated clock for their communication
interface, this clock is generally asynchronous with respect to the bus
interface clock (peripheral clock), and is named kernel clock.

For each IP, Peripheral clock and Kernel are generally gating with same
gate. Also, Kernel clocks can share a same multiplexer.
This patch introduces a mechanism to manage a gate with several
clocks and to manage a shared multiplexer (mgate and mmux).

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/clk/clk-stm32mp1.c | 847 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 820 insertions(+), 27 deletions(-)

diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
index 0470a13..b5379a2 100644
--- a/drivers/clk/clk-stm32mp1.c
+++ b/drivers/clk/clk-stm32mp1.c
@@ -132,6 +132,122 @@
 	"ck_hsi", "ck_hse", "ck_csi", "pll3_p"
 };
 
+static const char * const sdmmc12_src[] = {
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
+static const char * const spi123_src[] = {
+	"pll4_p", "pll3_q", "i2s_ckin", "ck_per", "pll3_r"
+};
+
+static const char * const spi45_src[] = {
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
+static const char * const i2c12_src[] = {
+	"pclk1", "pll4_r", "ck_hsi", "ck_csi"
+};
+
+static const char * const i2c35_src[] = {
+	"pclk1", "pll4_r", "ck_hsi", "ck_csi"
+};
+
+static const char * const i2c46_src[] = {
+	"pclk5", "pll3_q", "ck_hsi", "ck_csi"
+};
+
+static const char * const lptim1_src[] = {
+	"pclk1", "pll4_p", "pll3_q", "ck_lse", "ck_lsi", "ck_per"
+};
+
+static const char * const lptim23_src[] = {
+	"pclk3", "pll4_q", "ck_per", "ck_lse", "ck_lsi"
+};
+
+static const char * const lptim45_src[] = {
+	"pclk3", "pll4_p", "pll3_q", "ck_lse", "ck_lsi", "ck_per"
+};
+
+static const char * const usart1_src[] = {
+	"pclk5", "pll3_q", "ck_hsi", "ck_csi", "pll4_q", "ck_hse"
+};
+
+const char * const usart234578_src[] = {
+	"pclk1", "pll4_q", "ck_hsi", "ck_csi", "ck_hse"
+};
+
+static const char * const usart6_src[] = {
+	"pclk2", "pll4_q", "ck_hsi", "ck_csi", "ck_hse"
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
 static const struct clk_div_table axi_div_table[] = {
 	{ 0, 1 }, { 1, 2 }, { 2, 3 }, { 3, 4 },
 	{ 4, 4 }, { 5, 4 }, { 6, 4 }, { 7, 4 },
@@ -152,6 +268,29 @@
 	{ 0 },
 };
 
+#define MAX_MUX_CLK 2
+
+struct stm32_mmux {
+	u8 nbr_clk;
+	struct clk_hw *hws[MAX_MUX_CLK];
+};
+
+struct stm32_clk_mmux {
+	struct clk_mux mux;
+	struct stm32_mmux *mmux;
+};
+
+struct stm32_mgate {
+	u8 nbr_clk;
+	u32 flag;
+};
+
+struct stm32_clk_mgate {
+	struct clk_gate gate;
+	struct stm32_mgate *mgate;
+	u32 mask;
+};
+
 struct clock_config {
 	u32 id;
 	const char *name;
@@ -199,6 +338,7 @@ struct mux_cfg {
 
 struct stm32_gate_cfg {
 	struct gate_cfg		*gate;
+	struct stm32_mgate	*mgate;
 	const struct clk_ops	*ops;
 };
 
@@ -209,6 +349,7 @@ struct stm32_div_cfg {
 
 struct stm32_mux_cfg {
 	struct mux_cfg		*mux;
+	struct stm32_mmux	*mmux;
 	const struct clk_ops	*ops;
 };
 
@@ -316,22 +457,38 @@ static struct clk_hw *_get_stm32_mux(void __iomem *base,
 				     const struct stm32_mux_cfg *cfg,
 				     spinlock_t *lock)
 {
+	struct stm32_clk_mmux *mmux;
 	struct clk_mux *mux;
 	struct clk_hw *mux_hw;
 
-	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
-	if (!mux)
-		return ERR_PTR(-ENOMEM);
-
-	mux->reg = cfg->mux->reg_off + base;
-	mux->shift = cfg->mux->shift;
-	mux->mask = (1 << cfg->mux->width) - 1;
-	mux->flags = cfg->mux->mux_flags;
-	mux->table = cfg->mux->table;
-
-	mux->lock = lock;
-
-	mux_hw = &mux->hw;
+	if (cfg->mmux) {
+		mmux = kzalloc(sizeof(*mmux), GFP_KERNEL);
+		if (!mmux)
+			return ERR_PTR(-ENOMEM);
+
+		mmux->mux.reg = cfg->mux->reg_off + base;
+		mmux->mux.shift = cfg->mux->shift;
+		mmux->mux.mask = (1 << cfg->mux->width) - 1;
+		mmux->mux.flags = cfg->mux->mux_flags;
+		mmux->mux.table = cfg->mux->table;
+		mmux->mux.lock = lock;
+		mmux->mmux = cfg->mmux;
+		mux_hw = &mmux->mux.hw;
+		cfg->mmux->hws[cfg->mmux->nbr_clk++] = mux_hw;
+
+	} else {
+		mux = kzalloc(sizeof(*mux), GFP_KERNEL);
+		if (!mux)
+			return ERR_PTR(-ENOMEM);
+
+		mux->reg = cfg->mux->reg_off + base;
+		mux->shift = cfg->mux->shift;
+		mux->mask = (1 << cfg->mux->width) - 1;
+		mux->flags = cfg->mux->mux_flags;
+		mux->table = cfg->mux->table;
+		mux->lock = lock;
+		mux_hw = &mux->hw;
+	}
 
 	return mux_hw;
 }
@@ -361,18 +518,37 @@ static struct clk_hw *_get_stm32_div(void __iomem *base,
 _get_stm32_gate(void __iomem *base,
 		const struct stm32_gate_cfg *cfg, spinlock_t *lock)
 {
+	struct stm32_clk_mgate *mgate;
 	struct clk_gate *gate;
 	struct clk_hw *gate_hw;
 
-	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
-	if (!gate)
-		return ERR_PTR(-ENOMEM);
+	if (cfg->mgate) {
+		mgate = kzalloc(sizeof(*mgate), GFP_KERNEL);
+		if (!mgate)
+			return ERR_PTR(-ENOMEM);
+
+		mgate->gate.reg = cfg->gate->reg_off + base;
+		mgate->gate.bit_idx = cfg->gate->bit_idx;
+		mgate->gate.flags = cfg->gate->gate_flags;
+		mgate->gate.lock = lock;
+		mgate->mask = BIT(cfg->mgate->nbr_clk++);
+
+		mgate->mgate = cfg->mgate;
+
+		gate_hw = &mgate->gate.hw;
+
+	} else {
+		gate = kzalloc(sizeof(*gate), GFP_KERNEL);
+		if (!gate)
+			return ERR_PTR(-ENOMEM);
 
-	gate->reg = cfg->gate->reg_off + base;
-	gate->bit_idx = cfg->gate->bit_idx;
-	gate->flags = cfg->gate->gate_flags;
-	gate->lock = lock;
-	gate_hw = &gate->hw;
+		gate->reg = cfg->gate->reg_off + base;
+		gate->bit_idx = cfg->gate->bit_idx;
+		gate->flags = cfg->gate->gate_flags;
+		gate->lock = lock;
+
+		gate_hw = &gate->hw;
+	}
 
 	return gate_hw;
 }
@@ -475,8 +651,72 @@ static struct clk_hw *_get_stm32_div(void __iomem *base,
 				       gate_hw, gate_ops, flags);
 }
 
-/* STM32 PLL */
+#define to_clk_mgate(_gate) container_of(_gate, struct stm32_clk_mgate, gate)
+
+static int mp1_mgate_clk_enable(struct clk_hw *hw)
+{
+	struct clk_gate *gate = to_clk_gate(hw);
+	struct stm32_clk_mgate *clk_mgate = to_clk_mgate(gate);
+
+	clk_mgate->mgate->flag |= clk_mgate->mask;
+
+	mp1_gate_clk_enable(hw);
+
+	return  0;
+}
+
+static void mp1_mgate_clk_disable(struct clk_hw *hw)
+{
+	struct clk_gate *gate = to_clk_gate(hw);
+	struct stm32_clk_mgate *clk_mgate = to_clk_mgate(gate);
+
+	clk_mgate->mgate->flag &= ~clk_mgate->mask;
+
+	if (clk_mgate->mgate->flag == 0)
+		mp1_gate_clk_disable(hw);
+}
+
+const struct clk_ops mp1_mgate_clk_ops = {
+	.enable		= mp1_mgate_clk_enable,
+	.disable	= mp1_mgate_clk_disable,
+	.is_enabled	= clk_gate_is_enabled,
+
+};
+
+#define to_clk_mmux(_mux) container_of(_mux, struct stm32_clk_mmux, mux)
+
+static u8 clk_mmux_get_parent(struct clk_hw *hw)
+{
+	return clk_mux_ops.get_parent(hw);
+}
+
+static int clk_mmux_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct clk_mux *mux = to_clk_mux(hw);
+	struct stm32_clk_mmux *clk_mmux = to_clk_mmux(mux);
+	struct clk_hw *hwp;
+	int ret, n;
+
+	ret = clk_mux_ops.set_parent(hw, index);
+	if (ret)
+		return ret;
+
+	hwp = clk_hw_get_parent(hw);
+
+	for (n = 0; n < clk_mmux->mmux->nbr_clk; n++)
+		if (clk_mmux->mmux->hws[n] != hw)
+			clk_hw_reparent(clk_mmux->mmux->hws[n], hwp);
+
+	return 0;
+}
 
+const struct clk_ops clk_mmux_ops = {
+	.get_parent	= clk_mmux_get_parent,
+	.set_parent	= clk_mmux_set_parent,
+	.determine_rate	= __clk_mux_determine_rate,
+};
+
+/* STM32 PLL */
 struct stm32_pll_obj {
 	/* lock pll enable/disable registers */
 	spinlock_t *lock;
@@ -944,28 +1184,39 @@ static struct clk_hw *_clk_register_cktim(struct device *dev,
 	.func		= _clk_stm32_register_gate,\
 }
 
-#define _STM32_GATE(_gate_offset, _gate_bit_idx, _gate_flags, _ops)\
+#define _STM32_GATE(_gate_offset, _gate_bit_idx, _gate_flags, _mgate, _ops)\
 	(&(struct stm32_gate_cfg) {\
 		&(struct gate_cfg) {\
 			.reg_off	= _gate_offset,\
 			.bit_idx	= _gate_bit_idx,\
 			.gate_flags	= _gate_flags,\
 		},\
+		.mgate		= _mgate,\
 		.ops		= _ops,\
 	})
 
+#define _STM32_MGATE(_mgate)\
+	(&per_gate_cfg[_mgate])
+
 #define _GATE(_gate_offset, _gate_bit_idx, _gate_flags)\
 	_STM32_GATE(_gate_offset, _gate_bit_idx, _gate_flags,\
-		    NULL)\
+		    NULL, NULL)\
 
 #define _GATE_MP1(_gate_offset, _gate_bit_idx, _gate_flags)\
 	_STM32_GATE(_gate_offset, _gate_bit_idx, _gate_flags,\
-		    &mp1_gate_clk_ops)\
+		    NULL, &mp1_gate_clk_ops)\
+
+#define _MGATE_MP1(_mgate)\
+	.gate = &per_gate_cfg[_mgate]
 
 #define GATE_MP1(_id, _name, _parent, _flags, _offset, _bit_idx, _gate_flags)\
 	STM32_GATE(_id, _name, _parent, _flags,\
 		   _GATE_MP1(_offset, _bit_idx, _gate_flags))
 
+#define MGATE_MP1(_id, _name, _parent, _flags, _mgate)\
+	STM32_GATE(_id, _name, _parent, _flags,\
+		   _STM32_MGATE(_mgate))
+
 #define _STM32_DIV(_div_offset, _div_shift, _div_width,\
 		   _div_flags, _div_table, _ops)\
 	.div = &(struct stm32_div_cfg) {\
@@ -983,7 +1234,7 @@ static struct clk_hw *_clk_register_cktim(struct device *dev,
 	_STM32_DIV(_div_offset, _div_shift, _div_width,\
 		   _div_flags, _div_table, NULL)\
 
-#define _STM32_MUX(_offset, _shift, _width, _mux_flags, _ops)\
+#define _STM32_MUX(_offset, _shift, _width, _mux_flags, _mmux, _ops)\
 	.mux = &(struct stm32_mux_cfg) {\
 		&(struct mux_cfg) {\
 			.reg_off	= _offset,\
@@ -992,11 +1243,14 @@ static struct clk_hw *_clk_register_cktim(struct device *dev,
 			.mux_flags	= _mux_flags,\
 			.table		= NULL,\
 		},\
+		.mmux		= _mmux,\
 		.ops		= _ops,\
 	}
 
 #define _MUX(_offset, _shift, _width, _mux_flags)\
-	_STM32_MUX(_offset, _shift, _width, _mux_flags, NULL)\
+	_STM32_MUX(_offset, _shift, _width, _mux_flags, NULL, NULL)\
+
+#define _MMUX(_mmux) .mux = &ker_mux_cfg[_mmux]
 
 #define PARENT(_parent) ((const char *[]) { _parent})
 
@@ -1019,6 +1273,375 @@ static struct clk_hw *_clk_register_cktim(struct device *dev,
 	.func		= _clk_stm32_register_composite,\
 }
 
+#define PCLK(_id, _name, _parent, _flags, _mgate)\
+	MGATE_MP1(_id, _name, _parent, _flags, _mgate)
+
+#define KCLK(_id, _name, _parents, _flags, _mgate, _mmux)\
+	     COMPOSITE(_id, _name, _parents, CLK_OPS_PARENT_ENABLE | _flags,\
+		  _MGATE_MP1(_mgate),\
+		  _MMUX(_mmux),\
+		  _NO_DIV)
+
+enum {
+	G_SAI1,
+	G_SAI2,
+	G_SAI3,
+	G_SAI4,
+	G_SPI1,
+	G_SPI2,
+	G_SPI3,
+	G_SPI4,
+	G_SPI5,
+	G_SPI6,
+	G_SPDIF,
+	G_I2C1,
+	G_I2C2,
+	G_I2C3,
+	G_I2C4,
+	G_I2C5,
+	G_I2C6,
+	G_USART2,
+	G_UART4,
+	G_USART3,
+	G_UART5,
+	G_USART1,
+	G_USART6,
+	G_UART7,
+	G_UART8,
+	G_LPTIM1,
+	G_LPTIM2,
+	G_LPTIM3,
+	G_LPTIM4,
+	G_LPTIM5,
+	G_LTDC,
+	G_DSI,
+	G_QSPI,
+	G_FMC,
+	G_SDMMC1,
+	G_SDMMC2,
+	G_SDMMC3,
+	G_USBO,
+	G_USBPHY,
+	G_RNG1,
+	G_RNG2,
+	G_FDCAN,
+	G_DAC12,
+	G_CEC,
+	G_ADC12,
+	G_GPU,
+	G_STGEN,
+	G_DFSDM,
+	G_ADFSDM,
+	G_TIM2,
+	G_TIM3,
+	G_TIM4,
+	G_TIM5,
+	G_TIM6,
+	G_TIM7,
+	G_TIM12,
+	G_TIM13,
+	G_TIM14,
+	G_MDIO,
+	G_TIM1,
+	G_TIM8,
+	G_TIM15,
+	G_TIM16,
+	G_TIM17,
+	G_SYSCFG,
+	G_VREF,
+	G_TMPSENS,
+	G_PMBCTRL,
+	G_HDP,
+	G_IWDG2,
+	G_STGENRO,
+	G_DMA1,
+	G_DMA2,
+	G_DMAMUX,
+	G_DCMI,
+	G_CRYP2,
+	G_HASH2,
+	G_CRC2,
+	G_HSEM,
+	G_IPCC,
+	G_GPIOA,
+	G_GPIOB,
+	G_GPIOC,
+	G_GPIOD,
+	G_GPIOE,
+	G_GPIOF,
+	G_GPIOG,
+	G_GPIOH,
+	G_GPIOI,
+	G_GPIOJ,
+	G_GPIOK,
+	G_MDMA,
+	G_ETHCK,
+	G_ETHTX,
+	G_ETHRX,
+	G_ETHMAC,
+	G_CRC1,
+	G_USBH,
+	G_ETHSTP,
+	G_RTCAPB,
+	G_TZC,
+	G_TZPC,
+	G_IWDG1,
+	G_BSEC,
+	G_GPIOZ,
+	G_CRYP1,
+	G_HASH1,
+	G_BKPSRAM,
+
+	G_LAST
+};
+
+struct stm32_mgate mp1_mgate[G_LAST];
+
+#define _K_GATE(_id, _gate_offset, _gate_bit_idx, _gate_flags,\
+	       _mgate, _ops)\
+	[_id] = {\
+		&(struct gate_cfg) {\
+			.reg_off	= _gate_offset,\
+			.bit_idx	= _gate_bit_idx,\
+			.gate_flags	= _gate_flags,\
+		},\
+		.mgate		= _mgate,\
+		.ops		= _ops,\
+	}
+
+#define K_GATE(_id, _gate_offset, _gate_bit_idx, _gate_flags)\
+	_K_GATE(_id, _gate_offset, _gate_bit_idx, _gate_flags,\
+	       NULL, &mp1_gate_clk_ops)
+
+#define K_MGATE(_id, _gate_offset, _gate_bit_idx, _gate_flags)\
+	_K_GATE(_id, _gate_offset, _gate_bit_idx, _gate_flags,\
+	       &mp1_mgate[_id], &mp1_mgate_clk_ops)
+
+/* Peripheral gates */
+struct stm32_gate_cfg per_gate_cfg[G_LAST] = {
+	/* Multi gates */
+	K_GATE(G_MDIO,		RCC_APB1ENSETR, 31, 0),
+	K_MGATE(G_DAC12,	RCC_APB1ENSETR, 29, 0),
+	K_MGATE(G_CEC,		RCC_APB1ENSETR, 27, 0),
+	K_MGATE(G_SPDIF,	RCC_APB1ENSETR, 26, 0),
+	K_MGATE(G_I2C5,		RCC_APB1ENSETR, 24, 0),
+	K_MGATE(G_I2C3,		RCC_APB1ENSETR, 23, 0),
+	K_MGATE(G_I2C2,		RCC_APB1ENSETR, 22, 0),
+	K_MGATE(G_I2C1,		RCC_APB1ENSETR, 21, 0),
+	K_MGATE(G_UART8,	RCC_APB1ENSETR, 19, 0),
+	K_MGATE(G_UART7,	RCC_APB1ENSETR, 18, 0),
+	K_MGATE(G_UART5,	RCC_APB1ENSETR, 17, 0),
+	K_MGATE(G_UART4,	RCC_APB1ENSETR, 16, 0),
+	K_MGATE(G_USART3,	RCC_APB1ENSETR, 15, 0),
+	K_MGATE(G_USART2,	RCC_APB1ENSETR, 14, 0),
+	K_MGATE(G_SPI3,		RCC_APB1ENSETR, 12, 0),
+	K_MGATE(G_SPI2,		RCC_APB1ENSETR, 11, 0),
+	K_MGATE(G_LPTIM1,	RCC_APB1ENSETR, 9, 0),
+	K_GATE(G_TIM14,		RCC_APB1ENSETR, 8, 0),
+	K_GATE(G_TIM13,		RCC_APB1ENSETR, 7, 0),
+	K_GATE(G_TIM12,		RCC_APB1ENSETR, 6, 0),
+	K_GATE(G_TIM7,		RCC_APB1ENSETR, 5, 0),
+	K_GATE(G_TIM6,		RCC_APB1ENSETR, 4, 0),
+	K_GATE(G_TIM5,		RCC_APB1ENSETR, 3, 0),
+	K_GATE(G_TIM4,		RCC_APB1ENSETR, 2, 0),
+	K_GATE(G_TIM3,		RCC_APB1ENSETR, 1, 0),
+	K_GATE(G_TIM2,		RCC_APB1ENSETR, 0, 0),
+
+	K_MGATE(G_FDCAN,	RCC_APB2ENSETR, 24, 0),
+	K_GATE(G_ADFSDM,	RCC_APB2ENSETR, 21, 0),
+	K_GATE(G_DFSDM,		RCC_APB2ENSETR, 20, 0),
+	K_MGATE(G_SAI3,		RCC_APB2ENSETR, 18, 0),
+	K_MGATE(G_SAI2,		RCC_APB2ENSETR, 17, 0),
+	K_MGATE(G_SAI1,		RCC_APB2ENSETR, 16, 0),
+	K_MGATE(G_USART6,	RCC_APB2ENSETR, 13, 0),
+	K_MGATE(G_SPI5,		RCC_APB2ENSETR, 10, 0),
+	K_MGATE(G_SPI4,		RCC_APB2ENSETR, 9, 0),
+	K_MGATE(G_SPI1,		RCC_APB2ENSETR, 8, 0),
+	K_GATE(G_TIM17,		RCC_APB2ENSETR, 4, 0),
+	K_GATE(G_TIM16,		RCC_APB2ENSETR, 3, 0),
+	K_GATE(G_TIM15,		RCC_APB2ENSETR, 2, 0),
+	K_GATE(G_TIM8,		RCC_APB2ENSETR, 1, 0),
+	K_GATE(G_TIM1,		RCC_APB2ENSETR, 0, 0),
+
+	K_GATE(G_HDP,		RCC_APB3ENSETR, 20, 0),
+	K_GATE(G_PMBCTRL,	RCC_APB3ENSETR, 17, 0),
+	K_GATE(G_TMPSENS,	RCC_APB3ENSETR, 16, 0),
+	K_GATE(G_VREF,		RCC_APB3ENSETR, 13, 0),
+	K_GATE(G_SYSCFG,	RCC_APB3ENSETR, 11, 0),
+	K_MGATE(G_SAI4,		RCC_APB3ENSETR, 8, 0),
+	K_MGATE(G_LPTIM5,	RCC_APB3ENSETR, 3, 0),
+	K_MGATE(G_LPTIM4,	RCC_APB3ENSETR, 2, 0),
+	K_MGATE(G_LPTIM3,	RCC_APB3ENSETR, 1, 0),
+	K_MGATE(G_LPTIM2,	RCC_APB3ENSETR, 0, 0),
+
+	K_GATE(G_STGENRO,	RCC_APB4ENSETR, 20, 0),
+	K_MGATE(G_USBPHY,	RCC_APB4ENSETR, 16, 0),
+	K_GATE(G_IWDG2,		RCC_APB4ENSETR, 15, 0),
+	K_MGATE(G_DSI,		RCC_APB4ENSETR, 4, 0),
+	K_MGATE(G_LTDC,		RCC_APB4ENSETR, 0, 0),
+
+	K_GATE(G_STGEN,		RCC_APB5ENSETR, 20, 0),
+	K_GATE(G_BSEC,		RCC_APB5ENSETR, 16, 0),
+	K_GATE(G_IWDG1,		RCC_APB5ENSETR, 15, 0),
+	K_GATE(G_TZPC,		RCC_APB5ENSETR, 13, 0),
+	K_GATE(G_TZC,		RCC_APB5ENSETR, 12, 0),
+	K_GATE(G_RTCAPB,	RCC_APB5ENSETR, 8, 0),
+	K_MGATE(G_USART1,	RCC_APB5ENSETR, 4, 0),
+	K_MGATE(G_I2C6,		RCC_APB5ENSETR, 3, 0),
+	K_MGATE(G_I2C4,		RCC_APB5ENSETR, 2, 0),
+	K_MGATE(G_SPI6,		RCC_APB5ENSETR, 0, 0),
+
+	K_MGATE(G_SDMMC3,	RCC_AHB2ENSETR, 16, 0),
+	K_MGATE(G_USBO,		RCC_AHB2ENSETR, 8, 0),
+	K_MGATE(G_ADC12,	RCC_AHB2ENSETR, 5, 0),
+	K_GATE(G_DMAMUX,	RCC_AHB2ENSETR, 2, 0),
+	K_GATE(G_DMA2,		RCC_AHB2ENSETR, 1, 0),
+	K_GATE(G_DMA1,		RCC_AHB2ENSETR, 0, 0),
+
+	K_GATE(G_IPCC,		RCC_AHB3ENSETR, 12, 0),
+	K_GATE(G_HSEM,		RCC_AHB3ENSETR, 11, 0),
+	K_GATE(G_CRC2,		RCC_AHB3ENSETR, 7, 0),
+	K_MGATE(G_RNG2,		RCC_AHB3ENSETR, 6, 0),
+	K_GATE(G_HASH2,		RCC_AHB3ENSETR, 5, 0),
+	K_GATE(G_CRYP2,		RCC_AHB3ENSETR, 4, 0),
+	K_GATE(G_DCMI,		RCC_AHB3ENSETR, 0, 0),
+
+	K_GATE(G_GPIOK,		RCC_AHB4ENSETR, 10, 0),
+	K_GATE(G_GPIOJ,		RCC_AHB4ENSETR, 9, 0),
+	K_GATE(G_GPIOI,		RCC_AHB4ENSETR, 8, 0),
+	K_GATE(G_GPIOH,		RCC_AHB4ENSETR, 7, 0),
+	K_GATE(G_GPIOG,		RCC_AHB4ENSETR, 6, 0),
+	K_GATE(G_GPIOF,		RCC_AHB4ENSETR, 5, 0),
+	K_GATE(G_GPIOE,		RCC_AHB4ENSETR, 4, 0),
+	K_GATE(G_GPIOD,		RCC_AHB4ENSETR, 3, 0),
+	K_GATE(G_GPIOC,		RCC_AHB4ENSETR, 2, 0),
+	K_GATE(G_GPIOB,		RCC_AHB4ENSETR, 1, 0),
+	K_GATE(G_GPIOA,		RCC_AHB4ENSETR, 0, 0),
+
+	K_GATE(G_BKPSRAM,	RCC_AHB5ENSETR, 8, 0),
+	K_MGATE(G_RNG1,		RCC_AHB5ENSETR, 6, 0),
+	K_GATE(G_HASH1,		RCC_AHB5ENSETR, 5, 0),
+	K_GATE(G_CRYP1,		RCC_AHB5ENSETR, 4, 0),
+	K_GATE(G_GPIOZ,		RCC_AHB5ENSETR, 0, 0),
+
+	K_GATE(G_USBH,		RCC_AHB6ENSETR, 24, 0),
+	K_GATE(G_CRC1,		RCC_AHB6ENSETR, 20, 0),
+	K_MGATE(G_SDMMC2,	RCC_AHB6ENSETR, 17, 0),
+	K_MGATE(G_SDMMC1,	RCC_AHB6ENSETR, 16, 0),
+	K_MGATE(G_QSPI,		RCC_AHB6ENSETR, 14, 0),
+	K_MGATE(G_FMC,		RCC_AHB6ENSETR, 12, 0),
+	K_GATE(G_ETHMAC,	RCC_AHB6ENSETR, 10, 0),
+	K_GATE(G_ETHRX,		RCC_AHB6ENSETR, 9, 0),
+	K_GATE(G_ETHTX,		RCC_AHB6ENSETR, 8, 0),
+	K_GATE(G_ETHCK,		RCC_AHB6ENSETR, 7, 0),
+	K_MGATE(G_GPU,		RCC_AHB6ENSETR, 5, 0),
+	K_GATE(G_MDMA,		RCC_AHB6ENSETR, 0, 0),
+	K_GATE(G_ETHSTP,	RCC_AHB6LPENSETR, 11, 0),
+};
+
+enum {
+	M_SDMMC12,
+	M_SDMMC3,
+	M_FMC,
+	M_QSPI,
+	M_RNG1,
+	M_RNG2,
+	M_USBPHY,
+	M_USBO,
+	M_STGEN,
+	M_SPDIF,
+	M_SPI1,
+	M_SPI23,
+	M_SPI45,
+	M_SPI6,
+	M_CEC,
+	M_I2C12,
+	M_I2C35,
+	M_I2C46,
+	M_LPTIM1,
+	M_LPTIM23,
+	M_LPTIM45,
+	M_USART1,
+	M_UART24,
+	M_UART35,
+	M_USART6,
+	M_UART78,
+	M_SAI1,
+	M_SAI2,
+	M_SAI3,
+	M_SAI4,
+	M_DSI,
+	M_FDCAN,
+	M_ADC12,
+	M_ETHCK,
+	M_CKPER,
+	M_LAST
+};
+
+struct stm32_mmux ker_mux[M_LAST];
+
+#define _K_MUX(_id, _offset, _shift, _width, _mux_flags, _mmux, _ops)\
+	[_id] = {\
+		&(struct mux_cfg) {\
+			.reg_off	= _offset,\
+			.shift		= _shift,\
+			.width		= _width,\
+			.mux_flags	= _mux_flags,\
+			.table		= NULL,\
+		},\
+		.mmux		= _mmux,\
+		.ops		= _ops,\
+	}
+
+#define K_MUX(_id, _offset, _shift, _width, _mux_flags)\
+	_K_MUX(_id, _offset, _shift, _width, _mux_flags,\
+			NULL, NULL)
+
+#define K_MMUX(_id, _offset, _shift, _width, _mux_flags)\
+	_K_MUX(_id, _offset, _shift, _width, _mux_flags,\
+			&ker_mux[_id], &clk_mmux_ops)
+
+const struct stm32_mux_cfg ker_mux_cfg[M_LAST] = {
+	/* Kernel multi mux */
+	K_MMUX(M_SDMMC12, RCC_SDMMC12CKSELR, 0, 3, 0),
+	K_MMUX(M_SPI23, RCC_SPI2S23CKSELR, 0, 3, 0),
+	K_MMUX(M_SPI45, RCC_SPI2S45CKSELR, 0, 3, 0),
+	K_MMUX(M_I2C12, RCC_I2C12CKSELR, 0, 3, 0),
+	K_MMUX(M_I2C35, RCC_I2C35CKSELR, 0, 3, 0),
+	K_MMUX(M_LPTIM23, RCC_LPTIM23CKSELR, 0, 3, 0),
+	K_MMUX(M_LPTIM45, RCC_LPTIM45CKSELR, 0, 3, 0),
+	K_MMUX(M_UART24, RCC_UART24CKSELR, 0, 3, 0),
+	K_MMUX(M_UART35, RCC_UART35CKSELR, 0, 3, 0),
+	K_MMUX(M_UART78, RCC_UART78CKSELR, 0, 3, 0),
+	K_MMUX(M_SAI1, RCC_SAI1CKSELR, 0, 3, 0),
+	K_MMUX(M_ETHCK, RCC_ETHCKSELR, 0, 2, 0),
+	K_MMUX(M_I2C46, RCC_I2C46CKSELR, 0, 3, 0),
+
+	/*  Kernel simple mux */
+	K_MUX(M_RNG2, RCC_RNG2CKSELR, 0, 2, 0),
+	K_MUX(M_SDMMC3, RCC_SDMMC3CKSELR, 0, 3, 0),
+	K_MUX(M_FMC, RCC_FMCCKSELR, 0, 2, 0),
+	K_MUX(M_QSPI, RCC_QSPICKSELR, 0, 2, 0),
+	K_MUX(M_USBPHY, RCC_USBCKSELR, 0, 2, 0),
+	K_MUX(M_USBO, RCC_USBCKSELR, 4, 1, 0),
+	K_MUX(M_SPDIF, RCC_SPDIFCKSELR, 0, 2, 0),
+	K_MUX(M_SPI1, RCC_SPI2S1CKSELR, 0, 3, 0),
+	K_MUX(M_CEC, RCC_CECCKSELR, 0, 2, 0),
+	K_MUX(M_LPTIM1, RCC_LPTIM1CKSELR, 0, 3, 0),
+	K_MUX(M_USART6, RCC_UART6CKSELR, 0, 3, 0),
+	K_MUX(M_FDCAN, RCC_FDCANCKSELR, 0, 2, 0),
+	K_MUX(M_SAI2, RCC_SAI2CKSELR, 0, 3, 0),
+	K_MUX(M_SAI3, RCC_SAI3CKSELR, 0, 3, 0),
+	K_MUX(M_SAI4, RCC_SAI4CKSELR, 0, 3, 0),
+	K_MUX(M_ADC12, RCC_ADCCKSELR, 0, 2, 0),
+	K_MUX(M_DSI, RCC_DSICKSELR, 0, 1, 0),
+	K_MUX(M_CKPER, RCC_CPERCKSELR, 0, 2, 0),
+	K_MUX(M_RNG1, RCC_RNG1CKSELR, 0, 2, 0),
+	K_MUX(M_STGEN, RCC_STGENCKSELR, 0, 2, 0),
+	K_MUX(M_USART1, RCC_UART1CKSELR, 0, 3, 0),
+	K_MUX(M_SPI6, RCC_SPI6CKSELR, 0, 3, 0),
+};
+
 static const struct clock_config stm32mp1_clock_cfg[] = {
 	/* Oscillator divider */
 	DIV(NO_ID, "clk-hsi-div", "clk-hsi", 0, RCC_HSICFGR, 0, 2,
@@ -1152,6 +1775,176 @@ static struct clk_hw *_clk_register_cktim(struct device *dev,
 	STM32_TIM(TIM15_K, "tim15_k", "ck2_tim", RCC_APB2ENSETR, 2),
 	STM32_TIM(TIM16_K, "tim16_k", "ck2_tim", RCC_APB2ENSETR, 3),
 	STM32_TIM(TIM17_K, "tim17_k", "ck2_tim", RCC_APB2ENSETR, 4),
+
+	/* Peripheral clocks */
+	PCLK(TIM2, "tim2", "pclk1", CLK_IGNORE_UNUSED, G_TIM2),
+	PCLK(TIM3, "tim3", "pclk1", CLK_IGNORE_UNUSED, G_TIM3),
+	PCLK(TIM4, "tim4", "pclk1", CLK_IGNORE_UNUSED, G_TIM4),
+	PCLK(TIM5, "tim5", "pclk1", CLK_IGNORE_UNUSED, G_TIM5),
+	PCLK(TIM6, "tim6", "pclk1", CLK_IGNORE_UNUSED, G_TIM6),
+	PCLK(TIM7, "tim7", "pclk1", CLK_IGNORE_UNUSED, G_TIM7),
+	PCLK(TIM12, "tim12", "pclk1", CLK_IGNORE_UNUSED, G_TIM12),
+	PCLK(TIM13, "tim13", "pclk1", CLK_IGNORE_UNUSED, G_TIM13),
+	PCLK(TIM14, "tim14", "pclk1", CLK_IGNORE_UNUSED, G_TIM14),
+	PCLK(LPTIM1, "lptim1", "pclk1", 0, G_LPTIM1),
+	PCLK(SPI2, "spi2", "pclk1", 0, G_SPI2),
+	PCLK(SPI3, "spi3", "pclk1", 0, G_SPI3),
+	PCLK(USART2, "usart2", "pclk1", 0, G_USART2),
+	PCLK(USART3, "usart3", "pclk1", 0, G_USART3),
+	PCLK(UART4, "uart4", "pclk1", 0, G_UART4),
+	PCLK(UART5, "uart5", "pclk1", 0, G_UART5),
+	PCLK(UART7, "uart7", "pclk1", 0, G_UART7),
+	PCLK(UART8, "uart8", "pclk1", 0, G_UART8),
+	PCLK(I2C1, "i2c1", "pclk1", 0, G_I2C1),
+	PCLK(I2C2, "i2c2", "pclk1", 0, G_I2C2),
+	PCLK(I2C3, "i2c3", "pclk1", 0, G_I2C3),
+	PCLK(I2C5, "i2c5", "pclk1", 0, G_I2C5),
+	PCLK(SPDIF, "spdif", "pclk1", 0, G_SPDIF),
+	PCLK(CEC, "cec", "pclk1", 0, G_CEC),
+	PCLK(DAC12, "dac12", "pclk1", 0, G_DAC12),
+	PCLK(MDIO, "mdio", "pclk1", 0, G_MDIO),
+	PCLK(TIM1, "tim1", "pclk2", CLK_IGNORE_UNUSED, G_TIM1),
+	PCLK(TIM8, "tim8", "pclk2", CLK_IGNORE_UNUSED, G_TIM8),
+	PCLK(TIM15, "tim15", "pclk2", CLK_IGNORE_UNUSED, G_TIM15),
+	PCLK(TIM16, "tim16", "pclk2", CLK_IGNORE_UNUSED, G_TIM16),
+	PCLK(TIM17, "tim17", "pclk2", CLK_IGNORE_UNUSED, G_TIM17),
+	PCLK(SPI1, "spi1", "pclk2", 0, G_SPI1),
+	PCLK(SPI4, "spi4", "pclk2", 0, G_SPI4),
+	PCLK(SPI5, "spi5", "pclk2", 0, G_SPI5),
+	PCLK(USART6, "usart6", "pclk2", 0, G_USART6),
+	PCLK(SAI1, "sai1", "pclk2", 0, G_SAI1),
+	PCLK(SAI2, "sai2", "pclk2", 0, G_SAI2),
+	PCLK(SAI3, "sai3", "pclk2", 0, G_SAI3),
+	PCLK(DFSDM, "dfsdm", "pclk2", 0, G_DFSDM),
+	PCLK(FDCAN, "fdcan", "pclk2", 0, G_FDCAN),
+	PCLK(LPTIM2, "lptim2", "pclk3", 0, G_LPTIM2),
+	PCLK(LPTIM3, "lptim3", "pclk3", 0, G_LPTIM3),
+	PCLK(LPTIM4, "lptim4", "pclk3", 0, G_LPTIM4),
+	PCLK(LPTIM5, "lptim5", "pclk3", 0, G_LPTIM5),
+	PCLK(SAI4, "sai4", "pclk3", 0, G_SAI4),
+	PCLK(SYSCFG, "syscfg", "pclk3", 0, G_SYSCFG),
+	PCLK(VREF, "vref", "pclk3", 13, G_VREF),
+	PCLK(TMPSENS, "tmpsens", "pclk3", 0, G_TMPSENS),
+	PCLK(PMBCTRL, "pmbctrl", "pclk3", 0, G_PMBCTRL),
+	PCLK(HDP, "hdp", "pclk3", 0, G_HDP),
+	PCLK(LTDC, "ltdc", "pclk4", 0, G_LTDC),
+	PCLK(DSI, "dsi", "pclk4", 0, G_DSI),
+	PCLK(IWDG2, "iwdg2", "pclk4", 0, G_IWDG2),
+	PCLK(USBPHY, "usbphy", "pclk4", 0, G_USBPHY),
+	PCLK(STGENRO, "stgenro", "pclk4", 0, G_STGENRO),
+	PCLK(SPI6, "spi6", "pclk5", 0, G_SPI6),
+	PCLK(I2C4, "i2c4", "pclk5", 0, G_I2C4),
+	PCLK(I2C6, "i2c6", "pclk5", 0, G_I2C6),
+	PCLK(USART1, "usart1", "pclk5", 0, G_USART1),
+	PCLK(RTCAPB, "rtcapb", "pclk5", CLK_IGNORE_UNUSED |
+	     CLK_IS_CRITICAL, G_RTCAPB),
+	PCLK(TZC, "tzc", "pclk5", CLK_IGNORE_UNUSED, G_TZC),
+	PCLK(TZPC, "tzpc", "pclk5", CLK_IGNORE_UNUSED, G_TZPC),
+	PCLK(IWDG1, "iwdg1", "pclk5", 0, G_IWDG1),
+	PCLK(BSEC, "bsec", "pclk5", CLK_IGNORE_UNUSED, G_BSEC),
+	PCLK(STGEN, "stgen", "pclk5", CLK_IGNORE_UNUSED, G_STGEN),
+	PCLK(DMA1, "dma1", "ck_mcu", 0, G_DMA1),
+	PCLK(DMA2, "dma2", "ck_mcu",  0, G_DMA2),
+	PCLK(DMAMUX, "dmamux", "ck_mcu", 0, G_DMAMUX),
+	PCLK(ADC12, "adc12", "ck_mcu", 0, G_ADC12),
+	PCLK(USBO, "usbo", "ck_mcu", 0, G_USBO),
+	PCLK(SDMMC3, "sdmmc3", "ck_mcu", 0, G_SDMMC3),
+	PCLK(DCMI, "dcmi", "ck_mcu", 0, G_DCMI),
+	PCLK(CRYP2, "cryp2", "ck_mcu", 0, G_CRYP2),
+	PCLK(HASH2, "hash2", "ck_mcu", 0, G_HASH2),
+	PCLK(RNG2, "rng2", "ck_mcu", 0, G_RNG2),
+	PCLK(CRC2, "crc2", "ck_mcu", 0, G_CRC2),
+	PCLK(HSEM, "hsem", "ck_mcu", 0, G_HSEM),
+	PCLK(IPCC, "ipcc", "ck_mcu", 0, G_IPCC),
+	PCLK(GPIOA, "gpioa", "ck_mcu", 0, G_GPIOA),
+	PCLK(GPIOB, "gpiob", "ck_mcu", 0, G_GPIOB),
+	PCLK(GPIOC, "gpioc", "ck_mcu", 0, G_GPIOC),
+	PCLK(GPIOD, "gpiod", "ck_mcu", 0, G_GPIOD),
+	PCLK(GPIOE, "gpioe", "ck_mcu", 0, G_GPIOE),
+	PCLK(GPIOF, "gpiof", "ck_mcu", 0, G_GPIOF),
+	PCLK(GPIOG, "gpiog", "ck_mcu", 0, G_GPIOG),
+	PCLK(GPIOH, "gpioh", "ck_mcu", 0, G_GPIOH),
+	PCLK(GPIOI, "gpioi", "ck_mcu", 0, G_GPIOI),
+	PCLK(GPIOJ, "gpioj", "ck_mcu", 0, G_GPIOJ),
+	PCLK(GPIOK, "gpiok", "ck_mcu", 0, G_GPIOK),
+	PCLK(GPIOZ, "gpioz", "ck_axi", CLK_IGNORE_UNUSED, G_GPIOZ),
+	PCLK(CRYP1, "cryp1", "ck_axi", CLK_IGNORE_UNUSED, G_CRYP1),
+	PCLK(HASH1, "hash1", "ck_axi", CLK_IGNORE_UNUSED, G_HASH1),
+	PCLK(RNG1, "rng1", "ck_axi", 0, G_RNG1),
+	PCLK(BKPSRAM, "bkpsram", "ck_axi", CLK_IGNORE_UNUSED, G_BKPSRAM),
+	PCLK(MDMA, "mdma", "ck_axi", 0, G_MDMA),
+	PCLK(GPU, "gpu", "ck_axi", 0, G_GPU),
+	PCLK(ETHTX, "ethtx", "ck_axi", 0, G_ETHTX),
+	PCLK(ETHRX, "ethrx", "ck_axi", 0, G_ETHRX),
+	PCLK(ETHMAC, "ethmac", "ck_axi", 0, G_ETHMAC),
+	PCLK(FMC, "fmc", "ck_axi", CLK_IGNORE_UNUSED, G_FMC),
+	PCLK(QSPI, "qspi", "ck_axi", CLK_IGNORE_UNUSED, G_QSPI),
+	PCLK(SDMMC1, "sdmmc1", "ck_axi", 0, G_SDMMC1),
+	PCLK(SDMMC2, "sdmmc2", "ck_axi", 0, G_SDMMC2),
+	PCLK(CRC1, "crc1", "ck_axi", 0, G_CRC1),
+	PCLK(USBH, "usbh", "ck_axi", 0, G_USBH),
+	PCLK(ETHSTP, "ethstp", "ck_axi", 0, G_ETHSTP),
+
+	/* Kernel clocks */
+	KCLK(SDMMC1_K, "sdmmc1_k", sdmmc12_src, 0, G_SDMMC1, M_SDMMC12),
+	KCLK(SDMMC2_K, "sdmmc2_k", sdmmc12_src, 0, G_SDMMC2, M_SDMMC12),
+	KCLK(SDMMC3_K, "sdmmc3_k", sdmmc3_src, 0, G_SDMMC3, M_SDMMC3),
+	KCLK(FMC_K, "fmc_k", fmc_src, 0, G_FMC, M_FMC),
+	KCLK(QSPI_K, "qspi_k", qspi_src, 0, G_QSPI, M_QSPI),
+	KCLK(RNG1_K, "rng1_k", rng_src, 0, G_RNG1, M_RNG1),
+	KCLK(RNG2_K, "rng2_k", rng_src, 0, G_RNG2, M_RNG2),
+	KCLK(USBPHY_K, "usbphy_k", usbphy_src, 0, G_USBPHY, M_USBPHY),
+	KCLK(STGEN_K, "stgen_k",  stgen_src, CLK_IGNORE_UNUSED,
+	     G_STGEN, M_STGEN),
+	KCLK(SPDIF_K, "spdif_k", spdif_src, 0, G_SPDIF, M_SPDIF),
+	KCLK(SPI1_K, "spi1_k", spi123_src, 0, G_SPI1, M_SPI1),
+	KCLK(SPI2_K, "spi2_k", spi123_src, 0, G_SPI2, M_SPI23),
+	KCLK(SPI3_K, "spi3_k", spi123_src, 0, G_SPI3, M_SPI23),
+	KCLK(SPI4_K, "spi4_k", spi45_src, 0, G_SPI4, M_SPI45),
+	KCLK(SPI5_K, "spi5_k", spi45_src, 0, G_SPI5, M_SPI45),
+	KCLK(SPI6_K, "spi6_k", spi6_src, 0, G_SPI6, M_SPI6),
+	KCLK(CEC_K, "cec_k", cec_src, 0, G_CEC, M_CEC),
+	KCLK(I2C1_K, "i2c1_k", i2c12_src, 0, G_I2C1, M_I2C12),
+	KCLK(I2C2_K, "i2c2_k", i2c12_src, 0, G_I2C2, M_I2C12),
+	KCLK(I2C3_K, "i2c3_k", i2c35_src, 0, G_I2C3, M_I2C35),
+	KCLK(I2C5_K, "i2c5_k", i2c35_src, 0, G_I2C5, M_I2C35),
+	KCLK(I2C4_K, "i2c4_k", i2c46_src, 0, G_I2C4, M_I2C46),
+	KCLK(I2C6_K, "i2c6_k", i2c46_src, 0, G_I2C6, M_I2C46),
+	KCLK(LPTIM1_K, "lptim1_k", lptim1_src, 0, G_LPTIM1, M_LPTIM1),
+	KCLK(LPTIM2_K, "lptim2_k", lptim23_src, 0, G_LPTIM2, M_LPTIM23),
+	KCLK(LPTIM3_K, "lptim3_k", lptim23_src, 0, G_LPTIM3, M_LPTIM23),
+	KCLK(LPTIM4_K, "lptim4_k", lptim45_src, 0, G_LPTIM4, M_LPTIM45),
+	KCLK(LPTIM5_K, "lptim5_k", lptim45_src, 0, G_LPTIM5, M_LPTIM45),
+	KCLK(USART1_K, "usart1_k", usart1_src, 0, G_USART1, M_USART1),
+	KCLK(USART2_K, "usart2_k", usart234578_src, 0, G_USART2, M_UART24),
+	KCLK(USART3_K, "usart3_k", usart234578_src, 0, G_USART3, M_UART35),
+	KCLK(UART4_K, "uart4_k", usart234578_src, 0, G_UART4, M_UART24),
+	KCLK(UART5_K, "uart5_k", usart234578_src, 0, G_UART5, M_UART35),
+	KCLK(USART6_K, "uart6_k", usart6_src, 0, G_USART6, M_USART6),
+	KCLK(UART7_K, "uart7_k", usart234578_src, 0, G_UART7, M_UART78),
+	KCLK(UART8_K, "uart8_k", usart234578_src, 0, G_UART8, M_UART78),
+	KCLK(FDCAN_K, "fdcan_k", fdcan_src, 0, G_FDCAN, M_FDCAN),
+	KCLK(SAI1_K, "sai1_k", sai_src, 0, G_SAI1, M_SAI1),
+	KCLK(SAI2_K, "sai2_k", sai2_src, 0, G_SAI2, M_SAI2),
+	KCLK(SAI3_K, "sai3_k", sai_src, 0, G_SAI2, M_SAI3),
+	KCLK(SAI4_K, "sai4_k", sai_src, 0, G_SAI2, M_SAI4),
+	KCLK(ADC12_K, "adc12_k", adc12_src, 0, G_ADC12, M_ADC12),
+	KCLK(DSI_K, "dsi_k", dsi_src, 0, G_DSI, M_DSI),
+	KCLK(ADFSDM_K, "adfsdm_k", sai_src, 0, G_ADFSDM, M_SAI1),
+	KCLK(USBO_K, "usbo_k", usbo_src, 0, G_USBO, M_USBO),
+	KCLK(ETHCK_K, "ethck_k", eth_src, 0, G_ETHCK, M_ETHCK),
+
+	/* Particulary Kernel Clocks (no mux or no gate) */
+	MGATE_MP1(DFSDM_K, "dfsdm_k", "ck_mcu", 0, G_DFSDM),
+	MGATE_MP1(DSI_PX, "dsi_px", "pll4_q", CLK_SET_RATE_PARENT, G_DSI),
+	MGATE_MP1(LTDC_PX, "ltdc_px", "pll4_q", CLK_SET_RATE_PARENT, G_LTDC),
+	MGATE_MP1(GPU_K, "gpu_k", "pll2_q", 0, G_GPU),
+	MGATE_MP1(DAC12_K, "dac12_k", "ck_lsi", 0, G_DAC12),
+
+	COMPOSITE(ETHPTP_K, "ethptp_k", eth_src, CLK_OPS_PARENT_ENABLE,
+		  _NO_GATE,
+		  _MMUX(M_ETHCK),
+		  _DIV(RCC_ETHCKSELR, 4, 4, CLK_DIVIDER_ALLOW_ZERO, NULL)),
 };
 
 struct stm32_clock_match_data {
-- 
1.9.1
