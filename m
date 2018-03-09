Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932724AbeCIV6w (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 16:58:52 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50722 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932371AbeCIV62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 16:58:28 -0500
From: Eddie James <eajames@linux.vnet.ibm.com>
To: linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, joel@jms.id.au, wim@linux-watchdog.org,
        linux@roeck-us.net, Milton Miller <miltonm@us.ibm.com>,
        Eddie James <eajames@linux.vnet.ibm.com>
Subject: [PATCH 1/2] watchdog: aspeed: Fix translation of reset mode to ctrl register
Date: Fri,  9 Mar 2018 15:58:19 -0600
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1520632700-25800-1-git-send-email-eajames@linux.vnet.ibm.com>
References: <1520632700-25800-1-git-send-email-eajames@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18030921-0008-0000-0000-000002E2C9BB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008643; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01000701; UDB=6.00509032; IPR=6.00780031;
 MB=3.00019945; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-09 21:58:26
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030921-0009-0000-0000-000038837DEE
Message-Id: <1520632700-25800-2-git-send-email-eajames@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-09_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803090259
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Milton Miller <miltonm@us.ibm.com>

Assert RESET_SYSTEM bit for any reset and set MODE field from reset
type.

The watchdog control register has a RESET_SYSTEM bit that is really
closer to activate a reset, and RESET_SYSTEM_MODE field that chooses
how much to reset.

Before this patch, a node without these optional property would do a
SOC reset, but a node with properties requesting a cpu or SOC reset
would do nothing and a node requesting a system reset would do a
SOC reset.

Fixes: b7f0b8ad25f3 ("drivers/watchdog: ASPEED reference dev tree properties for config")
Signed-off-by: Milton Miller <miltonm@us.ibm.com>
Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
---
 drivers/watchdog/aspeed_wdt.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index ca5b91e..d1987d6 100644
--- a/drivers/watchdog/aspeed_wdt.c
+++ b/drivers/watchdog/aspeed_wdt.c
@@ -232,11 +232,14 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 		wdt->ctrl |= WDT_CTRL_RESET_MODE_SOC | WDT_CTRL_RESET_SYSTEM;
 	} else {
 		if (!strcmp(reset_type, "cpu"))
-			wdt->ctrl |= WDT_CTRL_RESET_MODE_ARM_CPU;
+			wdt->ctrl |= WDT_CTRL_RESET_MODE_ARM_CPU |
+				     WDT_CTRL_RESET_SYSTEM;
 		else if (!strcmp(reset_type, "soc"))
-			wdt->ctrl |= WDT_CTRL_RESET_MODE_SOC;
+			wdt->ctrl |= WDT_CTRL_RESET_MODE_SOC |
+				     WDT_CTRL_RESET_SYSTEM;
 		else if (!strcmp(reset_type, "system"))
-			wdt->ctrl |= WDT_CTRL_RESET_SYSTEM;
+			wdt->ctrl |= WDT_CTRL_RESET_MODE_FULL_CHIP |
+				     WDT_CTRL_RESET_SYSTEM;
 		else if (strcmp(reset_type, "none"))
 			return -EINVAL;
 	}
-- 
1.8.3.1
