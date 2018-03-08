Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751371AbeCHU5i (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 15:57:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53530 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751231AbeCHU5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 15:57:32 -0500
From: Eddie James <eajames@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: linux-clk@vger.kernel.org, joel@jms.id.au, mturquette@baylibre.com,
        sboyd@kernel.org, eajames@linux.vnet.ibm.com, mine260309@gmail.com,
        ryan_chen@aspeedtech.com
Subject: [PATCH v2 2/2] clk: aspeed: Prevent reset if clock is enabled
Date: Thu,  8 Mar 2018 14:57:20 -0600
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1520542640-9185-1-git-send-email-eajames@linux.vnet.ibm.com>
References: <1520542640-9185-1-git-send-email-eajames@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18030820-0024-0000-0000-0000180D6480
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008636; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01000201; UDB=6.00508735; IPR=6.00779530;
 MB=3.00019921; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-08 20:57:29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030820-0025-0000-0000-00004F06C4AD
Message-Id: <1520542640-9185-3-git-send-email-eajames@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-08_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803080226
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the Aspeed specification, the reset and enable sequence
should be done when the clock is stopped. The specification doesn't
define behavior if the reset is done while the clock is enabled.

>From testing on the AST2500, the LPC Controller has problems if the
clock is reset while enabled.

Therefore, check whether the clock is enabled or not before performing
the reset and enable sequence in the Aspeed clock driver.

Root-caused-by: Lei Yu <mine260309@gmail.com>
Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
---
 drivers/clk/clk-aspeed.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c
index 1687771..5eb50c3 100644
--- a/drivers/clk/clk-aspeed.c
+++ b/drivers/clk/clk-aspeed.c
@@ -205,6 +205,18 @@ struct aspeed_clk_soc_data {
 	.calc_pll = aspeed_ast2400_calc_pll,
 };
 
+static int aspeed_clk_is_enabled(struct clk_hw *hw)
+{
+	struct aspeed_clk_gate *gate = to_aspeed_clk_gate(hw);
+	u32 clk = BIT(gate->clock_idx);
+	u32 enval = (gate->flags & CLK_GATE_SET_TO_DISABLE) ? 0 : clk;
+	u32 reg;
+
+	regmap_read(gate->map, ASPEED_CLK_STOP_CTRL, &reg);
+
+	return ((reg & clk) == enval) ? 1 : 0;
+}
+
 static int aspeed_clk_enable(struct clk_hw *hw)
 {
 	struct aspeed_clk_gate *gate = to_aspeed_clk_gate(hw);
@@ -215,6 +227,11 @@ static int aspeed_clk_enable(struct clk_hw *hw)
 
 	spin_lock_irqsave(gate->lock, flags);
 
+	if (aspeed_clk_is_enabled(hw)) {
+		spin_unlock_irqrestore(gate->lock, flags);
+		return 0;
+	}
+
 	if (gate->reset_idx >= 0) {
 		/* Put IP in reset */
 		regmap_update_bits(gate->map, ASPEED_RESET_CTRL, rst, rst);
@@ -255,18 +272,6 @@ static void aspeed_clk_disable(struct clk_hw *hw)
 	spin_unlock_irqrestore(gate->lock, flags);
 }
 
-static int aspeed_clk_is_enabled(struct clk_hw *hw)
-{
-	struct aspeed_clk_gate *gate = to_aspeed_clk_gate(hw);
-	u32 clk = BIT(gate->clock_idx);
-	u32 enval = (gate->flags & CLK_GATE_SET_TO_DISABLE) ? 0 : clk;
-	u32 reg;
-
-	regmap_read(gate->map, ASPEED_CLK_STOP_CTRL, &reg);
-
-	return ((reg & clk) == enval) ? 1 : 0;
-}
-
 static const struct clk_ops aspeed_clk_gate_ops = {
 	.enable = aspeed_clk_enable,
 	.disable = aspeed_clk_disable,
-- 
1.8.3.1
