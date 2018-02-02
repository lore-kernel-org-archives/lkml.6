Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751787AbeBBOE6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 09:04:58 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:48655 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751774AbeBBOEl (ORCPT
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
Subject: [PATCH 14/14] clk: stm32mp1: add Debug clocks
Date: Fri, 2 Feb 2018 15:03:42 +0100
Message-ID: <1517580222-23301-15-git-send-email-gabriel.fernandez@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1517580222-23301-1-git-send-email-gabriel.fernandez@st.com>
References: <1517580222-23301-1-git-send-email-gabriel.fernandez@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG8NODE3.st.com (10.75.127.24) To SFHDAG4NODE2.st.com
 (10.75.127.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-02_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

RCC manages clock for debug and trace.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/clk/clk-stm32mp1.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
index 0402a0e..eafc95a 100644
--- a/drivers/clk/clk-stm32mp1.c
+++ b/drivers/clk/clk-stm32mp1.c
@@ -352,6 +352,12 @@
 	{ 0 },
 };
 
+static const struct clk_div_table ck_trace_div_table[] = {
+	{ 0, 1 }, { 1, 2 }, { 2, 4 }, { 3, 8 },
+	{ 4, 16 }, { 5, 16 }, { 6, 16 }, { 7, 16 },
+	{ 0 },
+};
+
 struct clock_config {
 	u32 id;
 	const char *name;
@@ -1566,6 +1572,17 @@ static struct clk_hw *_clk_register_cktim(struct device *dev,
 		  _GATEMUXDIV(RCC_MCO2CFGR, 12,
 			      RCC_MCO2CFGR, 0, 3,
 			      RCC_MCO2CFGR, 4, 4)),
+
+	/* Debug clocks */
+	FIXED_FACTOR(NO_ID, "ck_axi_div2", "ck_axi", 0, 1, 2),
+
+	GATE(DBG, "ck_apb_dbg", "ck_axi_div2", 0, RCC_DBGCFGR, 8, 0),
+
+	GATE(CK_DBG, "ck_sys_dbg", "ck_axi", 0, RCC_DBGCFGR, 8, 0),
+
+	COMPOSITE(CK_TRACE, "ck_trace", ck_trace_src, CLK_OPS_PARENT_ENABLE,
+		  _GATEDIV(RCC_DBGCFGR, 9,
+			   RCC_DBGCFGR, 0, 3, ck_trace_div_table)),
 };
 
 struct stm32_clock_match_data {
-- 
1.9.1
