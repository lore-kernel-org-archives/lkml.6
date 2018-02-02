Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752366AbeBBOF4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 09:05:56 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:58383 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751856AbeBBOEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 09:04:49 -0500
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
Subject: [PATCH 08/14] clk: stm32mp1: add Sub System clocks
Date: Fri, 2 Feb 2018 15:03:36 +0100
Message-ID: <1517580222-23301-9-git-send-email-gabriel.fernandez@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1517580222-23301-1-git-send-email-gabriel.fernandez@st.com>
References: <1517580222-23301-1-git-send-email-gabriel.fernandez@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG5NODE2.st.com (10.75.127.14) To SFHDAG4NODE2.st.com
 (10.75.127.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-02_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

The RCC handles three sub-system clocks: ck_mpuss, ck_axiss and ck_mcuss.
This patch adds also some MUX system and several prescalers.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/clk/clk-stm32mp1.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
index 15cd488..d85c619 100644
--- a/drivers/clk/clk-stm32mp1.c
+++ b/drivers/clk/clk-stm32mp1.c
@@ -332,6 +332,26 @@
 	"ck_mpu", "ck_axi", "ck_mcu", "pll4_p", "ck_hse", "ck_hsi"
 };
 
+static const struct clk_div_table axi_div_table[] = {
+	{ 0, 1 }, { 1, 2 }, { 2, 3 }, { 3, 4 },
+	{ 4, 4 }, { 5, 4 }, { 6, 4 }, { 7, 4 },
+	{ 0 },
+};
+
+static const struct clk_div_table mcu_div_table[] = {
+	{ 0, 1 }, { 1, 2 }, { 2, 4 }, { 3, 8 },
+	{ 4, 16 }, { 5, 32 }, { 6, 64 }, { 7, 128 },
+	{ 8, 512 }, { 9, 512 }, { 10, 512}, { 11, 512 },
+	{ 12, 512 }, { 13, 512 }, { 14, 512}, { 15, 512 },
+	{ 0 },
+};
+
+static const struct clk_div_table apb_div_table[] = {
+	{ 0, 1 }, { 1, 2 }, { 2, 4 }, { 3, 8 },
+	{ 4, 16 }, { 5, 16 }, { 6, 16 }, { 7, 16 },
+	{ 0 },
+};
+
 struct clock_config {
 	u32 id;
 	const char *name;
@@ -1001,6 +1021,15 @@ struct clk_hw *_clk_register_pll(struct device *dev,
 	_NO_MUX,\
 }
 
+#define _MUXDIV(_mux_offset, _mux_bit, _mux_width,\
+		_div_offset, _div_shift, _div_width,\
+		_div_table)\
+{\
+	_DIV_TABLE(_div_offset, _div_shift, _div_width, 0, _div_table),\
+	_NO_GATE,\
+	_MUX(_mux_offset, _mux_bit, _mux_width, 0),\
+}
+
 #define MP1_GATE(_id, _name, _parent, _flags, _offset, _bit_idx, _gate_flags)\
 {\
 	.id		= _id,\
@@ -1091,6 +1120,38 @@ struct clk_hw *_clk_register_pll(struct device *dev,
 	COMPOSITE(PLL4_R, "pll4_r", PARENT("pll4"), 0,
 		  _GATEDIV(RCC_PLL4CR, 6,
 			   RCC_PLL4CFGR2, 16, 7, NULL)),
+
+	/* MUX system clocks */
+	MUX(CK_PER, "ck_per", per_src, CLK_OPS_PARENT_ENABLE,
+	    RCC_CPERCKSELR, 0, 2, 0),
+
+	MUX(CK_MPU, "ck_mpu", cpu_src, CLK_OPS_PARENT_ENABLE | CLK_IS_CRITICAL,
+	    RCC_MPCKSELR, 0, 2, 0),
+
+	COMPOSITE(CK_AXI, "ck_axi", axi_src, CLK_IS_CRITICAL |
+		  CLK_OPS_PARENT_ENABLE,
+		  _MUXDIV(RCC_ASSCKSELR, 0, 2,
+			  RCC_AXIDIVR, 0, 3, axi_div_table)),
+
+	COMPOSITE(CK_MCU, "ck_mcu", mcu_src, CLK_IS_CRITICAL |
+		  CLK_OPS_PARENT_ENABLE,
+		  _MUXDIV(RCC_MSSCKSELR, 0, 2,
+			  RCC_MCUDIVR, 0, 4, mcu_div_table)),
+
+	DIV_TABLE(NO_ID, "pclk1", "ck_mcu", CLK_IGNORE_UNUSED, RCC_APB1DIVR, 0,
+		  3, CLK_DIVIDER_READ_ONLY, apb_div_table),
+
+	DIV_TABLE(NO_ID, "pclk2", "ck_mcu", CLK_IGNORE_UNUSED, RCC_APB2DIVR, 0,
+		  3, CLK_DIVIDER_READ_ONLY, apb_div_table),
+
+	DIV_TABLE(NO_ID, "pclk3", "ck_mcu", CLK_IGNORE_UNUSED, RCC_APB3DIVR, 0,
+		  3, CLK_DIVIDER_READ_ONLY, apb_div_table),
+
+	DIV_TABLE(NO_ID, "pclk4", "ck_axi", CLK_IGNORE_UNUSED, RCC_APB4DIVR, 0,
+		  3, CLK_DIVIDER_READ_ONLY, apb_div_table),
+
+	DIV_TABLE(NO_ID, "pclk5", "ck_axi", CLK_IGNORE_UNUSED, RCC_APB5DIVR, 0,
+		  3, CLK_DIVIDER_READ_ONLY, apb_div_table),
 };
 
 struct stm32_clock_match_data {
-- 
1.9.1
