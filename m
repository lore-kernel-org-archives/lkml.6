Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751752AbeC0UJi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 16:09:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52368 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751375AbeC0UJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 16:09:35 -0400
From: Eddie James <eajames@linux.vnet.ibm.com>
To: linux-watchdog@vger.kernel.org
Cc: openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        wim@linux-watchdog.org, linux@roeck-us.net, joel@jms.id.au,
        Eddie James <eajames@linux.vnet.ibm.com>
Subject: [PATCH v2] aspeed: watchdog: Set bootstatus during probe
Date: Tue, 27 Mar 2018 15:09:27 -0500
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 18032720-0024-0000-0000-0000033CBEFB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008754; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000255; SDB=6.01009292; UDB=6.00514137; IPR=6.00788574;
 MB=3.00020274; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-27 20:09:32
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032720-0025-0000-0000-00004776CB39
Message-Id: <1522181367-11231-1-git-send-email-eajames@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-27_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803270201
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check the aspeed timeout status register to see if the system has booted
from the secondary boot source. If so, set the watchdog device
bootstatus flag for "Card previously reset the CPU."

Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
---
Changes since v1:
 - use bootstatus instead of status
 - use WDIOF_CARDRESET instead of raw register contents

 drivers/watchdog/aspeed_wdt.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index a5b8eb2..1abe4d0 100644
--- a/drivers/watchdog/aspeed_wdt.c
+++ b/drivers/watchdog/aspeed_wdt.c
@@ -55,6 +55,8 @@ struct aspeed_wdt_config {
 #define   WDT_CTRL_WDT_INTR		BIT(2)
 #define   WDT_CTRL_RESET_SYSTEM		BIT(1)
 #define   WDT_CTRL_ENABLE		BIT(0)
+#define WDT_TIMEOUT_STATUS	0x10
+#define   WDT_TIMEOUT_STATUS_BOOT_SECONDARY	BIT(1)
 
 /*
  * WDT_RESET_WIDTH controls the characteristics of the external pulse (if
@@ -192,6 +194,7 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 	struct device_node *np;
 	const char *reset_type;
 	u32 duration;
+	u32 status;
 	int ret;
 
 	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
@@ -307,6 +310,10 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 		writel(duration - 1, wdt->base + WDT_RESET_WIDTH);
 	}
 
+	status = readl(wdt->base + WDT_TIMEOUT_STATUS);
+	if (status & WDT_TIMEOUT_STATUS_BOOT_SECONDARY)
+		wdt->wdd.bootstatus = WDIOF_CARDRESET;
+
 	ret = devm_watchdog_register_device(&pdev->dev, &wdt->wdd);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register\n");
-- 
1.8.3.1
