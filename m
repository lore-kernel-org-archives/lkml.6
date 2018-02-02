Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752332AbeBBOHZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 09:07:25 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:36225 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752154AbeBBOEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 09:04:43 -0500
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
Subject: [PATCH 12/14] clk: stm32mp1: add RTC clock
Date: Fri, 2 Feb 2018 15:03:40 +0100
Message-ID: <1517580222-23301-13-git-send-email-gabriel.fernandez@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1517580222-23301-1-git-send-email-gabriel.fernandez@st.com>
References: <1517580222-23301-1-git-send-email-gabriel.fernandez@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG5NODE2.st.com (10.75.127.14) To SFHDAG4NODE2.st.com
 (10.75.127.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-02_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

This patch adds the RTC clock.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/clk/clk-stm32mp1.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
index 5a1142c..1cb06b0 100644
--- a/drivers/clk/clk-stm32mp1.c
+++ b/drivers/clk/clk-stm32mp1.c
@@ -1179,6 +1179,15 @@ static struct clk_hw *_clk_register_cktim(struct device *dev,
 	_MUX(_mux_offset, _mux_bit, _mux_width, 0),\
 }
 
+#define _GATEMUX(_gate_offset,\
+		 _bit_idx,\
+		 _mux_offset, _mux_bit, _mux_width)\
+{\
+	_NO_DIV,\
+	_GATE(_gate_offset, _bit_idx, 0),\
+	_MUX(_mux_offset, _mux_bit, _mux_width, 0),\
+}
+
 #define _MP1_GATE(_gate_offset, _bit_idx, _flags)\
 		  _GATE_OPS(_gate_offset, _bit_idx, _flags, &mp1_gate_clk_ops)
 
@@ -1526,6 +1535,14 @@ static struct clk_hw *_clk_register_cktim(struct device *dev,
 		 RCC_APB4ENSETR, 0, 0),
 
 	MP1_GATE(GPU_K, "gpu_k", "pll2_q", 0, RCC_AHB6ENSETR, 5, 0),
+
+	/* RTC clock */
+	DIV(NO_ID, "ck_hse_rtc", "ck_hse", 0, RCC_RTCDIVR, 0, 7,
+	    CLK_DIVIDER_ALLOW_ZERO),
+
+	COMPOSITE(RTC, "ck_rtc", rtc_src, CLK_OPS_PARENT_ENABLE |
+		  CLK_SET_RATE_PARENT,
+		  _GATEMUX(RCC_BDCR, 20, RCC_BDCR, 16, 2)),
 };
 
 struct stm32_clock_match_data {
-- 
1.9.1
