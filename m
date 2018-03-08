Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934266AbeCHQys (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 11:54:48 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:48087 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932076AbeCHQyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 11:54:43 -0500
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
Subject: [PATCH v2 12/12] clk: stm32mp1: add Debug clocks
Date: Thu, 8 Mar 2018 17:54:05 +0100
Message-ID: <1520528045-18330-13-git-send-email-gabriel.fernandez@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520528045-18330-1-git-send-email-gabriel.fernandez@st.com>
References: <1520528045-18330-1-git-send-email-gabriel.fernandez@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG4NODE2.st.com
 (10.75.127.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-08_10:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

RCC manages clock for debug and trace.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/clk/clk-stm32mp1.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
index b3a6ec4..f1d5967 100644
--- a/drivers/clk/clk-stm32mp1.c
+++ b/drivers/clk/clk-stm32mp1.c
@@ -260,6 +260,10 @@
 	"ck_mpu", "ck_axi", "ck_mcu", "pll4_p", "ck_hse", "ck_hsi"
 };
 
+static const char * const ck_trace_src[] = {
+	"ck_axi"
+};
+
 static const struct clk_div_table axi_div_table[] = {
 	{ 0, 1 }, { 1, 2 }, { 2, 3 }, { 3, 4 },
 	{ 4, 4 }, { 5, 4 }, { 6, 4 }, { 7, 4 },
@@ -280,6 +284,12 @@
 	{ 0 },
 };
 
+static const struct clk_div_table ck_trace_div_table[] = {
+	{ 0, 1 }, { 1, 2 }, { 2, 4 }, { 3, 8 },
+	{ 4, 16 }, { 5, 16 }, { 6, 16 }, { 7, 16 },
+	{ 0 },
+};
+
 #define MAX_MUX_CLK 2
 
 struct stm32_mmux {
@@ -1980,6 +1990,18 @@ enum {
 		  _GATE(RCC_MCO2CFGR, 12, 0),
 		  _MUX(RCC_MCO2CFGR, 0, 3, 0),
 		  _DIV(RCC_MCO2CFGR, 4, 4, 0, NULL)),
+
+	/* Debug clocks */
+	FIXED_FACTOR(NO_ID, "ck_axi_div2", "ck_axi", 0, 1, 2),
+
+	GATE(DBG, "ck_apb_dbg", "ck_axi_div2", 0, RCC_DBGCFGR, 8, 0),
+
+	GATE(CK_DBG, "ck_sys_dbg", "ck_axi", 0, RCC_DBGCFGR, 8, 0),
+
+	COMPOSITE(CK_TRACE, "ck_trace", ck_trace_src, CLK_OPS_PARENT_ENABLE,
+		  _GATE(RCC_DBGCFGR, 9, 0),
+		  _NO_MUX,
+		  _DIV(RCC_DBGCFGR, 0, 3, 0, ck_trace_div_table)),
 };
 
 struct stm32_clock_match_data {
-- 
1.9.1
