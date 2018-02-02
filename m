Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751931AbeBBOFI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 09:05:08 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:51480 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751915AbeBBOEl (ORCPT
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
Subject: [PATCH 13/14] clk: stm32mp1: add MCO clocks
Date: Fri, 2 Feb 2018 15:03:41 +0100
Message-ID: <1517580222-23301-14-git-send-email-gabriel.fernandez@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1517580222-23301-1-git-send-email-gabriel.fernandez@st.com>
References: <1517580222-23301-1-git-send-email-gabriel.fernandez@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG4NODE2.st.com
 (10.75.127.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-02_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

Two micro-controller clock output (MCO) pins are available: MCO1 and MCO2.
For each output, it is possible to select a clock source.
The selected clock can be divided thanks to configurable prescaler.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/clk/clk-stm32mp1.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
index 1cb06b0..0402a0e 100644
--- a/drivers/clk/clk-stm32mp1.c
+++ b/drivers/clk/clk-stm32mp1.c
@@ -1188,6 +1188,16 @@ static struct clk_hw *_clk_register_cktim(struct device *dev,
 	_MUX(_mux_offset, _mux_bit, _mux_width, 0),\
 }
 
+#define _GATEMUXDIV(_gate_offset, _bit_idx,\
+		    _mux_offset, _mux_bit, _mux_width,\
+		    _div_offset, _div_bit, _div_width\
+		)\
+{\
+	_DIV(_div_offset, _div_bit, _div_width, 0),\
+	_GATE(_gate_offset, _bit_idx, 0),\
+	_MUX(_mux_offset, _mux_bit, _mux_width, 0),\
+}
+
 #define _MP1_GATE(_gate_offset, _bit_idx, _flags)\
 		  _GATE_OPS(_gate_offset, _bit_idx, _flags, &mp1_gate_clk_ops)
 
@@ -1543,6 +1553,19 @@ static struct clk_hw *_clk_register_cktim(struct device *dev,
 	COMPOSITE(RTC, "ck_rtc", rtc_src, CLK_OPS_PARENT_ENABLE |
 		  CLK_SET_RATE_PARENT,
 		  _GATEMUX(RCC_BDCR, 20, RCC_BDCR, 16, 2)),
+
+	/* MCO clocks */
+	COMPOSITE(CK_MCO1, "ck_mco1", mco1_src, CLK_OPS_PARENT_ENABLE |
+		  CLK_SET_RATE_NO_REPARENT,
+		  _GATEMUXDIV(RCC_MCO1CFGR, 12,
+			      RCC_MCO1CFGR, 0, 3,
+			      RCC_MCO1CFGR, 4, 4)),
+
+	COMPOSITE(CK_MCO2, "ck_mco2", mco2_src, CLK_OPS_PARENT_ENABLE |
+		  CLK_SET_RATE_NO_REPARENT,
+		  _GATEMUXDIV(RCC_MCO2CFGR, 12,
+			      RCC_MCO2CFGR, 0, 3,
+			      RCC_MCO2CFGR, 4, 4)),
 };
 
 struct stm32_clock_match_data {
-- 
1.9.1
