Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932643AbeCIV6f (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 16:58:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36142 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932108AbeCIV6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 16:58:31 -0500
From: Eddie James <eajames@linux.vnet.ibm.com>
To: linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, joel@jms.id.au, wim@linux-watchdog.org,
        linux@roeck-us.net, Milton Miller <miltonm@us.ibm.com>,
        Eddie James <eajames@linux.vnet.ibm.com>
Subject: [PATCH 2/2] watchdog: aspeed: Allow configuring for alternate boot
Date: Fri,  9 Mar 2018 15:58:20 -0600
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1520632700-25800-1-git-send-email-eajames@linux.vnet.ibm.com>
References: <1520632700-25800-1-git-send-email-eajames@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18030921-0048-0000-0000-00000247AED3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008643; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01000701; UDB=6.00509032; IPR=6.00780031;
 MB=3.00019945; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-09 21:58:28
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030921-0049-0000-0000-000044636508
Message-Id: <1520632700-25800-3-git-send-email-eajames@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-09_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803090259
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Milton Miller <miltonm@us.ibm.com>

Allow the device tree to specify a watchdog to fallover to
the alternate boot source.

The aspeeed watchdog can set a latch directing flash chip select 0 to
chip select 1, allowing boot from an alternate media if the watchdog
is not reset in time.  On the ast2400 bank 1 also goes to flash bank 1,
while on the ast2500 the chip selects are swapped.

Signed-off-by: Milton Miller <miltonm@us.ibm.com>
Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
---
 drivers/watchdog/aspeed_wdt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index d1987d6..f41d246 100644
--- a/drivers/watchdog/aspeed_wdt.c
+++ b/drivers/watchdog/aspeed_wdt.c
@@ -46,6 +46,7 @@ struct aspeed_wdt_config {
 #define WDT_RELOAD_VALUE	0x04
 #define WDT_RESTART		0x08
 #define WDT_CTRL		0x0C
+#define   WDT_CTRL_BOOT_SECONDARY	BIT(7)
 #define   WDT_CTRL_RESET_MODE_SOC	(0x00 << 5)
 #define   WDT_CTRL_RESET_MODE_FULL_CHIP	(0x01 << 5)
 #define   WDT_CTRL_RESET_MODE_ARM_CPU	(0x10 << 5)
@@ -245,6 +246,8 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 	}
 	if (of_property_read_bool(np, "aspeed,external-signal"))
 		wdt->ctrl |= WDT_CTRL_WDT_EXT;
+	if (of_property_read_bool(np, "aspeed,alt-boot"))
+		wdt->ctrl |= WDT_CTRL_BOOT_SECONDARY;
 
 	if (readl(wdt->base + WDT_CTRL) & WDT_CTRL_ENABLE)  {
 		/*
-- 
1.8.3.1
