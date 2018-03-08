Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936104AbeCHQ6w (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 11:58:52 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:46134 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933717AbeCHQyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 11:54:46 -0500
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
Subject: [PATCH v2 11/12] clk: stm32mp1: add MCO clocks
Date: Thu, 8 Mar 2018 17:54:04 +0100
Message-ID: <1520528045-18330-12-git-send-email-gabriel.fernandez@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520528045-18330-1-git-send-email-gabriel.fernandez@st.com>
References: <1520528045-18330-1-git-send-email-gabriel.fernandez@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG4NODE2.st.com
 (10.75.127.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-08_09:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

Two micro-controller clock output (MCO) pins are available:
MCO1 and MCO2.
For each output, it is possible to select a clock source.
The selected clock can be divided thanks to configurable
prescaler.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/clk/clk-stm32mp1.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
index 51e3e76..b3a6ec4 100644
--- a/drivers/clk/clk-stm32mp1.c
+++ b/drivers/clk/clk-stm32mp1.c
@@ -252,6 +252,14 @@
 	"off", "ck_lse", "ck_lsi", "ck_hse_rtc"
 };
 
+static const char * const mco1_src[] = {
+	"ck_hsi", "ck_hse", "ck_csi", "ck_lsi", "ck_lse"
+};
+
+static const char * const mco2_src[] = {
+	"ck_mpu", "ck_axi", "ck_mcu", "pll4_p", "ck_hse", "ck_hsi"
+};
+
 static const struct clk_div_table axi_div_table[] = {
 	{ 0, 1 }, { 1, 2 }, { 2, 3 }, { 3, 4 },
 	{ 4, 4 }, { 5, 4 }, { 6, 4 }, { 7, 4 },
@@ -1960,6 +1968,18 @@ enum {
 		  _MUX(RCC_BDCR, 16, 2, 0),
 		  _NO_DIV),
 
+	/* MCO clocks */
+	COMPOSITE(CK_MCO1, "ck_mco1", mco1_src, CLK_OPS_PARENT_ENABLE |
+		  CLK_SET_RATE_NO_REPARENT,
+		  _GATE(RCC_MCO1CFGR, 12, 0),
+		  _MUX(RCC_MCO1CFGR, 0, 3, 0),
+		  _DIV(RCC_MCO1CFGR, 4, 4, 0, NULL)),
+
+	COMPOSITE(CK_MCO2, "ck_mco2", mco2_src, CLK_OPS_PARENT_ENABLE |
+		  CLK_SET_RATE_NO_REPARENT,
+		  _GATE(RCC_MCO2CFGR, 12, 0),
+		  _MUX(RCC_MCO2CFGR, 0, 3, 0),
+		  _DIV(RCC_MCO2CFGR, 4, 4, 0, NULL)),
 };
 
 struct stm32_clock_match_data {
-- 
1.9.1
