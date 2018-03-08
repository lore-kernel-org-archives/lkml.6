Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751215AbeCHU5c (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 15:57:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55462 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751085AbeCHU53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 15:57:29 -0500
From: Eddie James <eajames@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: linux-clk@vger.kernel.org, joel@jms.id.au, mturquette@baylibre.com,
        sboyd@kernel.org, eajames@linux.vnet.ibm.com, mine260309@gmail.com,
        ryan_chen@aspeedtech.com
Subject: [PATCH v2 1/2] clk: aspeed: Fix is_enabled for certain clocks
Date: Thu,  8 Mar 2018 14:57:19 -0600
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1520542640-9185-1-git-send-email-eajames@linux.vnet.ibm.com>
References: <1520542640-9185-1-git-send-email-eajames@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18030820-0020-0000-0000-00000D901798
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008636; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01000201; UDB=6.00508735; IPR=6.00779530;
 MB=3.00019921; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-08 20:57:28
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030820-0021-0000-0000-0000606AF2BB
Message-Id: <1520542640-9185-2-git-send-email-eajames@linux.vnet.ibm.com>
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

Some of the Aspeed clocks are disabled by setting the relevant bit in
the "clock stop control" register to one, while others are disabled by
setting their bit to zero. The driver already uses a flag per gate  to
identify this behavior, but doesn't apply it in the clock is_enabled
function.

Use the existing gate flag to correctly return whether or not a clock
is enabled in the aspeed_clk_is_enabled function.

Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
---
 drivers/clk/clk-aspeed.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c
index 9f7f931..1687771 100644
--- a/drivers/clk/clk-aspeed.c
+++ b/drivers/clk/clk-aspeed.c
@@ -259,11 +259,12 @@ static int aspeed_clk_is_enabled(struct clk_hw *hw)
 {
 	struct aspeed_clk_gate *gate = to_aspeed_clk_gate(hw);
 	u32 clk = BIT(gate->clock_idx);
+	u32 enval = (gate->flags & CLK_GATE_SET_TO_DISABLE) ? 0 : clk;
 	u32 reg;
 
 	regmap_read(gate->map, ASPEED_CLK_STOP_CTRL, &reg);
 
-	return (reg & clk) ? 0 : 1;
+	return ((reg & clk) == enval) ? 1 : 0;
 }
 
 static const struct clk_ops aspeed_clk_gate_ops = {
-- 
1.8.3.1
