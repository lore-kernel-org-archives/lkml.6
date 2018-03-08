Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936069AbeCHQ50 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 11:57:26 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:57405 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932131AbeCHQyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 11:54:47 -0500
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
Subject: [PATCH v2 04/12] clk: stm32mp1: add Source Clocks for PLLs
Date: Thu, 8 Mar 2018 17:53:57 +0100
Message-ID: <1520528045-18330-5-git-send-email-gabriel.fernandez@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520528045-18330-1-git-send-email-gabriel.fernandez@st.com>
References: <1520528045-18330-1-git-send-email-gabriel.fernandez@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG4NODE2.st.com
 (10.75.127.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-08_10:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

This patch adds source clocks for PLLs
This patch also introduces MUX clock API.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/clk/clk-stm32mp1.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
index 56b738e..47984f3 100644
--- a/drivers/clk/clk-stm32mp1.c
+++ b/drivers/clk/clk-stm32mp1.c
@@ -103,6 +103,18 @@
 
 #define RCC_CLR	0x4
 
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
 struct clock_config {
 	u32 id;
 	const char *name;
@@ -140,6 +152,14 @@ struct div_cfg {
 	const struct clk_div_table *table;
 };
 
+struct mux_cfg {
+	u32 reg_off;
+	u8 shift;
+	u8 width;
+	u8 mux_flags;
+	u32 *table;
+};
+
 struct stm32_gate_cfg {
 	struct gate_cfg		*gate;
 	const struct clk_ops	*ops;
@@ -196,6 +216,20 @@ struct stm32_gate_cfg {
 					     lock);
 }
 
+static struct clk_hw *
+_clk_hw_register_mux(struct device *dev,
+		     struct clk_hw_onecell_data *clk_data,
+		     void __iomem *base, spinlock_t *lock,
+		     const struct clock_config *cfg)
+{
+	struct mux_cfg *mux_cfg = cfg->cfg;
+
+	return clk_hw_register_mux(dev, cfg->name, cfg->parent_names,
+				   cfg->num_parents, cfg->flags,
+				   mux_cfg->reg_off + base, mux_cfg->shift,
+				   mux_cfg->width, mux_cfg->mux_flags, lock);
+}
+
 /* MP1 Gate clock with set & clear registers */
 
 static int mp1_gate_clk_enable(struct clk_hw *hw)
@@ -350,6 +384,22 @@ static void mp1_gate_clk_disable(struct clk_hw *hw)
 	DIV_TABLE(_id, _name, _parent, _flags, _offset, _shift, _width,\
 		  _div_flags, NULL)
 
+#define MUX(_id, _name, _parents, _flags, _offset, _shift, _width, _mux_flags)\
+{\
+	.id		= _id,\
+	.name		= _name,\
+	.parent_names	= _parents,\
+	.num_parents	= ARRAY_SIZE(_parents),\
+	.flags		= _flags,\
+	.cfg		=  &(struct mux_cfg) {\
+		.reg_off	= _offset,\
+		.shift		= _shift,\
+		.width		= _width,\
+		.mux_flags	= _mux_flags,\
+	},\
+	.func		= _clk_hw_register_mux,\
+}
+
 /* STM32 GATE */
 #define STM32_GATE(_id, _name, _parent, _flags, _gate)\
 {\
@@ -392,6 +442,16 @@ static void mp1_gate_clk_disable(struct clk_hw *hw)
 	GATE(CK_LSE, "ck_lse", "clk-lse", 0, RCC_BDCR, 0, 0),
 
 	FIXED_FACTOR(CK_HSE_DIV2, "clk-hse-div2", "ck_hse", 0, 1, 2),
+
+	/* ref clock pll */
+	MUX(NO_ID, "ref1", ref12_parents, CLK_OPS_PARENT_ENABLE, RCC_RCK12SELR,
+	    0, 2, CLK_MUX_READ_ONLY),
+
+	MUX(NO_ID, "ref3", ref3_parents, CLK_OPS_PARENT_ENABLE, RCC_RCK3SELR,
+	    0, 2, CLK_MUX_READ_ONLY),
+
+	MUX(NO_ID, "ref4", ref4_parents, CLK_OPS_PARENT_ENABLE, RCC_RCK4SELR,
+	    0, 2, CLK_MUX_READ_ONLY),
 };
 
 struct stm32_clock_match_data {
-- 
1.9.1
