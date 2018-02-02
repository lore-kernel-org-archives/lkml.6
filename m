Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752309AbeBBOF3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 09:05:29 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:24368 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752139AbeBBOEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 09:04:41 -0500
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
Subject: [PATCH 11/14] clk: stm32mp1: add Kernel clocks
Date: Fri, 2 Feb 2018 15:03:39 +0100
Message-ID: <1517580222-23301-12-git-send-email-gabriel.fernandez@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1517580222-23301-1-git-send-email-gabriel.fernandez@st.com>
References: <1517580222-23301-1-git-send-email-gabriel.fernandez@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG4NODE2.st.com
 (10.75.127.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-02_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

Some peripherals need also a dedicated clock for their communication
interface, this clock is generally asynchronous with respect to the bus
interface clock (peripheral clock), and is named kernel clock.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/clk/clk-stm32mp1.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
index ea78a6a..5a1142c 100644
--- a/drivers/clk/clk-stm32mp1.c
+++ b/drivers/clk/clk-stm32mp1.c
@@ -1179,6 +1179,17 @@ static struct clk_hw *_clk_register_cktim(struct device *dev,
 	_MUX(_mux_offset, _mux_bit, _mux_width, 0),\
 }
 
+#define _MP1_GATE(_gate_offset, _bit_idx, _flags)\
+		  _GATE_OPS(_gate_offset, _bit_idx, _flags, &mp1_gate_clk_ops)
+
+#define _MP1_GATEMUX(_gate_offset, _bit_idx,\
+		     _mux_offset, _mux_bit, _mux_width)\
+{\
+	_NO_DIV,\
+	_MP1_GATE(_gate_offset, _bit_idx, 0),\
+	_MUX(_mux_offset, _mux_bit, _mux_width, 0),\
+}
+
 #define MP1_GATE(_id, _name, _parent, _flags, _offset, _bit_idx, _gate_flags)\
 {\
 	.id		= _id,\
@@ -1226,6 +1237,11 @@ static struct clk_hw *_clk_register_cktim(struct device *dev,
 	     MP1_GATE(_id, _name, _parent, _flags,\
 		      RCC_##_reg##ENSETR, _gate_idx, 0)
 
+#define KCLK(_reg, _id, _bit_idx, _mux_offset, _name, _parents, _flags)\
+	     COMPOSITE(_id, _name, _parents, CLK_OPS_PARENT_ENABLE | _flags,\
+		       _MP1_GATEMUX(RCC_##_reg##ENSETR, _bit_idx,\
+					   _mux_offset, 0, 3))
+
 static const struct clock_config stm32mp1_clock_cfg[] = {
 	/* Oscillator divider */
 	DIV(NO_ID, "clk-hsi-div", "clk-hsi", 0, RCC_HSICFGR, 0, 2,
@@ -1451,6 +1467,65 @@ static struct clk_hw *_clk_register_cktim(struct device *dev,
 	PCLK(AHB6, CRC1, "crc1", "ck_axi", 20, 0),
 	PCLK(AHB6, USBH, "usbh", "ck_axi", 24, 0),
 	PCLK(AHB6LP, ETHSTP, "ethstp", "ck_axi", 11, 0),
+
+	/* Kernel clocks */
+	KCLK(AHB6, SDMMC1_K, 16, RCC_SDMMC12CKSELR, "sdmmc1_k", sdmmc1_src, 0),
+	KCLK(AHB6, SDMMC2_K, 17, RCC_SDMMC12CKSELR, "sdmmc2_k", sdmmc2_src, 0),
+	KCLK(AHB2, SDMMC3_K, 16, RCC_SDMMC3CKSELR, "sdmmc3_k", sdmmc3_src, 0),
+	KCLK(AHB6, FMC_K, 12, RCC_FMCCKSELR, "fmc_k", fmc_src, 0),
+	KCLK(AHB6, QSPI_K, 14, RCC_QSPICKSELR, "qspi_k", qspi_src, 0),
+	KCLK(AHB6, ETHMAC_K, 10, RCC_ETHCKSELR, "ethmac_k", eth_src, 0),
+	KCLK(AHB5, RNG1_K, 6, RCC_RNG1CKSELR, "rng1_k", rng_src, 0),
+	KCLK(AHB3, RNG2_K, 6, RCC_RNG2CKSELR, "rng2_k", rng_src, 0),
+	KCLK(APB4, USBPHY_K, 16, RCC_USBCKSELR, "usbphy_k", usbphy_src, 0),
+	KCLK(APB5, STGEN_K, 20, RCC_STGENCKSELR, "stgen_k",  stgen_src,
+	     CLK_IGNORE_UNUSED),
+	KCLK(APB1, SPDIF_K, 26, RCC_SPDIFCKSELR, "spdif_k",  spdif_src, 0),
+	KCLK(APB2, SPI1_K, 8, RCC_SPI2S1CKSELR, "spi1_k", spi1_src, 0),
+	KCLK(APB1, SPI2_K, 11, RCC_SPI2S23CKSELR, "spi2_k", spi2_src, 0),
+	KCLK(APB1, SPI3_K, 12, RCC_SPI2S23CKSELR, "spi3_k", spi3_src, 0),
+	KCLK(APB2, SPI4_K, 9, RCC_SPI2S45CKSELR, "spi4_k", spi4_src, 0),
+	KCLK(APB2, SPI5_K, 10, RCC_SPI2S45CKSELR, "spi5_k", spi5_src, 0),
+	KCLK(APB5, SPI6_K, 0, RCC_SPI6CKSELR, "spi6_k", spi6_src, 0),
+	KCLK(APB1, CEC_K, 27, RCC_CECCKSELR, "cec_k", cec_src, 0),
+	KCLK(APB1, I2C1_K, 21, RCC_I2C12CKSELR, "i2c1_k", i2c1_src, 0),
+	KCLK(APB1, I2C2_K, 22, RCC_I2C12CKSELR, "i2c2_k", i2c2_src, 0),
+	KCLK(APB1, I2C3_K, 23, RCC_I2C35CKSELR, "i2c3_k", i2c3_src, 0),
+	KCLK(APB5, I2C4_K, 2, RCC_I2C4CKSELR, "i2c4_k", i2c4_src, 0),
+	KCLK(APB1, I2C5_K, 24, RCC_I2C35CKSELR, "i2c5_k", i2c5_src, 0),
+	KCLK(APB5, I2C6_K, 3, RCC_I2C4CKSELR, "i2c6_k", i2c6_src, 0),
+	KCLK(APB1, LPTIM1_K, 9, RCC_LPTIM1CKSELR, "lptim1_k", lptim1_src, 0),
+	KCLK(APB3, LPTIM2_K, 0, RCC_LPTIM23CKSELR, "lptim2_k", lptim2_src, 0),
+	KCLK(APB3, LPTIM3_K, 1, RCC_LPTIM23CKSELR, "lptim3_k", lptim3_src, 0),
+	KCLK(APB3, LPTIM4_K, 2, RCC_LPTIM45CKSELR, "lptim4_k", lptim4_src, 0),
+	KCLK(APB3, LPTIM5_K, 3, RCC_LPTIM45CKSELR, "lptim5_k", lptim5_src, 0),
+	KCLK(APB5, USART1_K, 4, RCC_UART1CKSELR, "usart1_k", usart1_src, 0),
+	KCLK(APB1, USART2_K, 14, RCC_UART24CKSELR, "usart2_k", usart2_src, 0),
+	KCLK(APB1, USART3_K, 15, RCC_UART35CKSELR, "usart3_k", usart3_src, 0),
+	KCLK(APB1, UART4_K, 16, RCC_UART24CKSELR, "uart4_k", uart4_src, 0),
+	KCLK(APB1, UART5_K, 17, RCC_UART35CKSELR, "uart5_k", uart5_src, 0),
+	KCLK(APB2, USART6_K, 13, RCC_UART6CKSELR, "uart6_k", usart6_src, 0),
+	KCLK(APB1, UART7_K, 18, RCC_UART78CKSELR, "uart7_k",  uart7_src, 0),
+	KCLK(APB1, UART8_K, 19, RCC_UART78CKSELR, "uart8_k",  uart8_src, 0),
+	KCLK(APB2, DFSDM_K, 20, RCC_DFSDMCKSELR, "dfsdm_k", dfsdm_src, 0),
+	KCLK(APB2, FDCAN_K, 24, RCC_FDCANCKSELR, "fdcan_k", fdcan_src, 0),
+	KCLK(APB2, SAI1_K, 16, RCC_SAI1CKSELR, "sai1_k", sai_src, 0),
+	KCLK(APB2, SAI2_K, 17, RCC_SAI2CKSELR, "sai2_k", sai2_src, 0),
+	KCLK(APB2, SAI3_K, 18, RCC_SAI3CKSELR, "sai3_k", sai_src, 0),
+	KCLK(APB3, SAI4_K, 8, RCC_SAI4CKSELR, "sai4_k", sai_src, 0),
+	KCLK(AHB2, ADC12_K, 5, RCC_ADCCKSELR, "adc12_k", adc12_src,
+	     CLK_IGNORE_UNUSED),
+	KCLK(APB4, DSI_K, 4, RCC_DSICKSELR, "dsi_k", dsi_src, 0),
+	KCLK(APB2, ADFSDM_K, 21, RCC_SAI1CKSELR, "adfsdm_k", adfsdm_src, 0),
+
+	/* particulary Kernel clocks */
+	COMPOSITE(USBO_K, "usbo_k", usbo_src, CLK_OPS_PARENT_ENABLE,
+		  _MP1_GATEMUX(RCC_AHB2ENSETR, 8, RCC_USBCKSELR, 4, 1)),
+
+	MP1_GATE(LTDC_K, "ltdc_k", "pll4_q", CLK_SET_RATE_PARENT,
+		 RCC_APB4ENSETR, 0, 0),
+
+	MP1_GATE(GPU_K, "gpu_k", "pll2_q", 0, RCC_AHB6ENSETR, 5, 0),
 };
 
 struct stm32_clock_match_data {
-- 
1.9.1
