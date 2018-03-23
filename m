Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752518AbeCWJUJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 05:20:09 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:46348 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752003AbeCWJPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 05:15:30 -0400
X-UUID: d30cda85e63346e1a9ec81b26bd15002-20180323
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <sre@kernel.org>,
        <lee.jones@linaro.org>, <a.zummo@towertech.it>,
        <alexandre.belloni@free-electrons.com>, <eddie.huang@mediatek.com>
CC: <devicetree@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v1 04/16] mfd: mt6397: add MT6323 RTC support into MT6397 driver
Date: Fri, 23 Mar 2018 17:15:01 +0800
Message-ID: <90320622cb491b9d3251e2ce9d0501422f47660f.1521794177.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1521794176.git.sean.wang@mediatek.com>
References: <cover.1521794176.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-12.5.0.5042-8.2.9001-23736.004
X-TM-AS-Result: No-4.555200-8.000000-10
X-TMASE-MatchedRID: yFGXaP8bkQMxFdXyW/P+XWMGiV639iF0moKXVHfiMM9cU0dNErOD+opb
        wG9fIuIT5IXjmeRXhnCJEz4Y6DI4oJsYdIGP6PlZndu3heVAxaNzd7C7BtJobgqiCYa6w8tv8tM
        WbtVzWkjt4ariHb3sbHv+mmMQs+2yHxPMjOKY7A+6vVBUUydJCsRB0bsfrpPInxMyeYT53RkbSW
        746/XYMKCgeSTuE21HV901T3m/1GcuA5kq+A5t08V4uyloxhpwLZhSe8r+c9RWpF6VpTLhEY2q0
        akcUk4Qw99bu/x2/ZGTdSRXlCnjBIjjlF305EnAWUm8SESyzd+8353hqEyjk1Zca9RSYo/b
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.555200-8.000000
X-TMASE-Version: SMEX-12.5.0.5042-8.2.9001-23736.004
X-TMASE-POSTMAN: 2-d;
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Add compatible string as "mt6323-rtc" that will make the OF core spawn
child devices for the RTC subnode of that MT6323 MFD node.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/mfd/mt6397-core.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
index 77b64bd..f71874a 100644
--- a/drivers/mfd/mt6397-core.c
+++ b/drivers/mfd/mt6397-core.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2014 MediaTek Inc.
+ * Copyright (c) 2014-2018 MediaTek Inc.
  * Author: Flora Fu, MediaTek
  *
  * This program is free software; you can redistribute it and/or modify
@@ -23,6 +23,9 @@
 #include <linux/mfd/mt6397/registers.h>
 #include <linux/mfd/mt6323/registers.h>
 
+#define MT6323_RTC_BASE		0x8000
+#define MT6323_RTC_SIZE		0x3e
+
 #define MT6397_RTC_BASE		0xe000
 #define MT6397_RTC_SIZE		0x3e
 
@@ -30,6 +33,19 @@
 #define MT6391_CID_CODE		0x91
 #define MT6397_CID_CODE		0x97
 
+static const struct resource mt6323_rtc_resources[] = {
+	{
+		.start = MT6323_RTC_BASE,
+		.end   = MT6323_RTC_BASE + MT6323_RTC_SIZE,
+		.flags = IORESOURCE_MEM,
+	},
+	{
+		.start = MT6323_IRQ_STATUS_RTC,
+		.end   = MT6323_IRQ_STATUS_RTC,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
 static const struct resource mt6397_rtc_resources[] = {
 	{
 		.start = MT6397_RTC_BASE,
@@ -55,6 +71,11 @@ static const struct resource mt6397_keys_resources[] = {
 
 static const struct mfd_cell mt6323_devs[] = {
 	{
+		.name = "mt6323-rtc",
+		.num_resources = ARRAY_SIZE(mt6323_rtc_resources),
+		.resources = mt6323_rtc_resources,
+		.of_compatible = "mediatek,mt6323-rtc",
+	}, {
 		.name = "mt6323-regulator",
 		.of_compatible = "mediatek,mt6323-regulator"
 	}, {
-- 
2.7.4
