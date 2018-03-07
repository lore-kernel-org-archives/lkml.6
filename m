Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934000AbeCGQgS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 11:36:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54792 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933576AbeCGQgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 11:36:16 -0500
From: Eddie James <eajames@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: linux-clk@vger.kernel.org, joel@jms.id.au, mturquette@baylibre.com,
        sboyd@kernel.org, Eddie James <eajames@linux.vnet.ibm.com>
Subject: [PATCH] clk: aspeed: Prevent reset if clock is enabled
Date: Wed,  7 Mar 2018 10:36:10 -0600
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 18030716-0028-0000-0000-000009450F2B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008629; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00999643; UDB=6.00508487; IPR=6.00779049;
 MB=3.00019895; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-07 16:36:14
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030716-0029-0000-0000-000039E006AD
Message-Id: <1520440570-25280-1-git-send-email-eajames@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-07_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803070190
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

Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
---
 drivers/clk/clk-aspeed.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c
index 9f7f931..a13054d 100644
--- a/drivers/clk/clk-aspeed.c
+++ b/drivers/clk/clk-aspeed.c
@@ -212,6 +212,12 @@ static int aspeed_clk_enable(struct clk_hw *hw)
 	u32 clk = BIT(gate->clock_idx);
 	u32 rst = BIT(gate->reset_idx);
 	u32 enval;
+	u32 reg;
+
+	/* Only reset/enable/unreset if clock is stopped */
+	regmap_read(gate->map, ASPEED_CLK_STOP_CTRL, &reg);
+	if (!(reg & clk))
+		return 0;
 
 	spin_lock_irqsave(gate->lock, flags);
 
-- 
1.8.3.1
