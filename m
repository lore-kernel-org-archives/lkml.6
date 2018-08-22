Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5641DC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 13:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD9C2150F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 13:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ebz7GjJ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAD9C2150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbeHVRON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 13:14:13 -0400
Received: from mail-he1eur01on0051.outbound.protection.outlook.com ([104.47.0.51]:19992
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728396AbeHVROM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 13:14:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXf7qO38vaYskqGDfbVulsm2QujivvVj2Ne8jKVWVAk=;
 b=ebz7GjJ88DJZYI/DrUEpq+3zRD+KFh4Y5Xk/5G/nFI5HNX40s8+FXpnomEKRi0XTT4R/v8DtGYObhwLrSs8Sh8KMlr1rNWyzWdR+9OdpdHIrBVOxicODe4aelT9xjcg+1VV5JT56ive0aOks2KygRDU9mtzFQhSEZAAyXxi1nCA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
Received: from fsr-ub1664-175.ea.freescale.net (95.76.156.53) by
 HE1PR04MB1612.eurprd04.prod.outlook.com (2a01:111:e400:59a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.21; Wed, 22 Aug
 2018 13:48:39 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>
Cc:     linux-clk@vger.kernel.org, linux-imx@nxp.com,
        Shawn Guo <shawnguo@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v6 3/5] clk: imx: add SCCG PLL type
Date:   Wed, 22 Aug 2018 16:48:21 +0300
Message-Id: <1534945703-4730-4-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534945703-4730-1-git-send-email-abel.vesa@nxp.com>
References: <1534945703-4730-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: HE1PR0202CA0043.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::29) To HE1PR04MB1612.eurprd04.prod.outlook.com
 (2a01:111:e400:59a9::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06b38f72-8e51-469a-d01b-08d60835f815
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1612;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1612;3:CrKRk8LcV0Qkcj0dBrDu7xGn4Dakg2NmvTl7wNULc2XncQGo+0r7+7jZfLdXzhu3d24WLB+69kd00o3zOVB0NqpHk4HtkF6ZOZlrZ58Cp2JFLo63PHVaUNcCa/G72nakbnBTSmRMjO7OeMQG0z+1ePAZZby0iKPwog5Dh2sRA3F6XszNKf6/FljN258gA2sNj+5OUY/a7KyYSIB0PaZT9mo7s5qygRvmKcM/KvoSHzluOaZdeeQfNy0epPL/9/DD;25:T0P7EDWO6lAwBdSzGEVKHKC365uPjzzujaCZ/h4tVMJr5qqw/DwSl8RawMgQCub91OzrqXSYQEaBUL6iNwMDuvpT9N2O9s7hOlu7ra9Y3SNON51189EpOddmqyokvZ/mazkRRHuM6FTCfT+C2SqMRdhwWbGIhG+WU9EhyXtoYYBFpxIt/VgQIfcszClOEob3jTPqXFDUq2MEtsNgzAOLQlByC2oMEgRh/tJTGICcPDMZzKP/yVTvTFt1fJVtWsRuOCCvBNpXltnrcm70EjCpGtGNczPxcacjil+H8hXejuZ+6qaIn+KaYKvJzz1SL6eZA59sRCwHYXvzEJG2vwgcaQ==;31:DhHq7AzwIXdBu7OsAUC/hjF7WEp5Cfo03D7VmHcesy/oyfZ2/WejEKWRLI51KkIP3whMdAqT3Fa0bsWj9cZHjdnA0/Qx8mzcxWkwAgkKDP+S1aGrXfWFdFgN1lrlRIzIzPn34eWqvo5zmqsChMXGv7TobRdqn2SepZ2ibqNaE3L/OJp2xPus6xsvtq19wJD/eigH9iG+nOZqXJlT9eaMotDgEspDc2TlCYGhamdHKng=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1612:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1612;20:WCjMLQH0Tfp0j/cUHb0GIX2mC2BbKlNqE4lb1vdPVOBOxyqYoWc9vXXNKJoqRTDflqgrObHBu/WSvHCU/HWNY2f/Q1q3Z6HtvTVDC0TwRCN/RhxDZrXPIUmJM+e4RRIO3+HQ94of6TTaOsJUEz1Egng4NbO3eIA0e4t03+AsSmWV2+ESQfM55zeiVaetK9N7GSwLsPuT5h1MXyOSt2u6pHDuX6DX866Gmu/NzYMIVgFwa5fU8BsUx3wapZDxLTuTqNPsZPvv3oMKM0gStFqwJn8Qspn0t2akZbXDhLMb7a9Nj32iD6iWTNeY0+BMN1ZF35H0o0nQmHBZ6jpGROoaYTBEsfkOAw7ht849CFg3hV0c5ccwoP7Hta+uYcvGxB4xZuN9AoeW4oQ7B0ff3okw2STXV8z+NhyDx6vJODsTXF3JRxlNn7r25WT+Iup4N4wdSODaAI74ttq5+GHtM2tQXqSZ4L1V9FyZBo0BxvS+sNQjwocA09NoPQSdjeXWn6+q;4:mJ5CfTCIk/eNZ1UvLt+gcseRJDT0updWCU/2dm8wNTXaYoBhQIerFPx5i4zsa7zh6qhg+GeksDJzJVjxwgidDWMFNXU2Z0R9Pft/zEiuR1NSke1Y2+0+K4e/n8cQ7gsjOkh89zDbRuD6zz2GjeFroTJGrKLkgDTnDgdA5qzdqaZ5h+CefxCpsDJ2Agn0e5jOtLnbAOrlXpeNA2apYxjEn7Ul0kqbsoa120elsM5PXxnduH6nc/XkkoicB2oKiD9yELIQW5z7g6vuglcjGtLj0jDdhc5Qh9sHzLfmE8rnG7zpZ27jQO9fQ3wRBH3fn05W
X-Microsoft-Antispam-PRVS: <HE1PR04MB1612AC9DF3960131BCCEFDB7F6300@HE1PR04MB1612.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3002001)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:HE1PR04MB1612;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1612;
X-Forefront-PRVS: 0772E5DAD5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39860400002)(366004)(136003)(189003)(199004)(36756003)(14444005)(6116002)(186003)(26005)(16526019)(51416003)(386003)(52116002)(316002)(47776003)(66066001)(110136005)(6506007)(50466002)(76176011)(48376002)(8936002)(54906003)(97736004)(478600001)(16586007)(44832011)(105586002)(25786009)(5660300001)(446003)(86362001)(2906002)(11346002)(3846002)(6636002)(217873002)(50226002)(106356001)(6666003)(476003)(486006)(4326008)(7736002)(8676002)(81156014)(68736007)(53936002)(7416002)(2616005)(956004)(81166006)(6512007)(6486002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1612;H:fsr-ub1664-175.ea.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1612;23:HriyLe2WV6Wm8AEEpWl71zZkVHHldMDpnIrDvWpr5?=
 =?us-ascii?Q?k0DUdkD0QOLOmWO6hd+1M1/uYcf/D/1Xre6U4WtQSu8zGk4xMa/OSDD+CgCQ?=
 =?us-ascii?Q?S9yAaopgQMQED+W1FajRS3e9E11pwASxq+jOxa/+PeVy/Lv44qgyDJMsBtJd?=
 =?us-ascii?Q?y1qH9gubzTOyvR2ArdpDX51V6+ztL66bwLIDZ6+PiZo5/c2ehbwLcQfKxzGY?=
 =?us-ascii?Q?5ZphZeX8VswMmYlps7hpxOjzp825KirXyjeTOz1kB0TJ6bk+rWZfT/k6HuAx?=
 =?us-ascii?Q?AMEJm332/3K8/AdZVzXyOqU44OtnWFdly1uaOaYQrX3SvUJ+JcK/2aQu2cIB?=
 =?us-ascii?Q?HYpC7ppduSC4u8HUodkspO48syyDTpuW3YlrPDlVspOQFyMMpMIeBkRMyeNK?=
 =?us-ascii?Q?UJEpBr7Qc4SwuVRGAKJRhlPkToiY6agxJLv+aRCSFHnfaDmRxwMWot/VlALU?=
 =?us-ascii?Q?87XRidkA/ONHv1+bF4wZGqKnAOXdsZ0+3xjUprbAwoTt5gWoDgAvcvUFyHIC?=
 =?us-ascii?Q?bRvteNXt3D1sjMxCtp95iyosqOcZYLAnPbCmR426doA4F8j/ss8rb3FM+jhv?=
 =?us-ascii?Q?8r5NX1lEOi7k56yO8UucaK85zFs4xHzMy83u9XvoAl55GDwbd6lX8p0qeCzc?=
 =?us-ascii?Q?pHvlBdrowpVB1wNZ85SDrstg21SyUNS9mnOMfJbUhmd9S4sj2FUD3RQaHv8z?=
 =?us-ascii?Q?CGooQUM4BW9ImokK/CvqIdtueaRi04MgwKAgzLTQcDR1HCATfZKMRkqbQOB9?=
 =?us-ascii?Q?0/OzgtrTenqvXl0WdGpnVKyclQ+1WFxZYsxqTZslcqCw630A8jzxBbzMmAED?=
 =?us-ascii?Q?jo95eOl2f63BzABZpmNeAOZEQX6DL13ycPq1faK2jVPjeJt7uX/gjc4Y5Z2K?=
 =?us-ascii?Q?Q/oF5LJgta+/j81P3xAe6MGwQEQ3ljzAIad759kCekPOcadya937gKfwmm+p?=
 =?us-ascii?Q?RUvJqfRRkArw2dHPMNzBtcvuU9BXRr10lDqDeL6PxIptdcgeb7cl0ip4fuzg?=
 =?us-ascii?Q?SNQnDwaaLHIeiv4KyA89p1ymPV4S3H7lIXSe/izM9v0N5L/jTb1+tn6eIB5C?=
 =?us-ascii?Q?vh5DPrUo4N/6q9U61MMv+l37PeXPJvv597PVDGxUWr9r+Wn6OaTFlYjktBUC?=
 =?us-ascii?Q?XiNLR4+0xaAQqCxWMZE3FG7lP4lDRJwiqnHyfDFQJm0aurDJNkNEyLy6bltg?=
 =?us-ascii?Q?i6VQGTuvp5qBBL6r1f+qfrN6MYHJSCvimyT/iQzZfR0+b1mBrwd/cmWvz3Tr?=
 =?us-ascii?Q?LiOzsi/HThZUTJMJGC245zQIk4dehUiIkf8WXKFsLY8BEYpgCGpnMi/YGst2?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: +QOTYkNQC1aMMYJc5rwDoLqE/iYFz9LQtV9g6U3s7RTRQxNTU0SscK69U0qjdazJBiok6BCxBp8h4V63k3yz1ki6XhI278UFtjp7FE3bp/GogOBB9XL6WKS9ySPKu1xW5GEjcrVb7j0Jhq9opTDTHPr5WAvU7uVvpnCmgmZAUiMK8443MjF8A9T0LGMDOoZUDR/jAcaCiiW5S5Y7w7XEKavJ1rb3URxgVrx9GLfyCsjy8WOISrBkgE/nNrWV9Dd+7fAeOZs7OZqkdHiQJPaeditag+hq6u6sUtgMWN0yxxf1VaGvFYSujR6d4Jxf+fFvBA0FIUwCanfKV7yHCDa5MzZa9FWwH89tuQGdc/gunhI=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1612;6:SRRHqOSRMliygBnejX+SEUzGDESi0gZ2MR0oaJq6lpdJAKEIfq0C9ZncA1FGrq1VOq1sGAsPTumkx9OjjphdkEjtI1y5IuAZ57klR4tKNSKURE2qu+2KyuXg3TCGv2surOqN9tEzKYGjLygXzHSJisNJ8hFR707lAbKYproNWyyhYiZ1AFPFky6USK5SFqa8BxuAAoYwTxa0vEtCKc+zS6YDEdD/JdvfoZJkCwvZQqktk8I57La6+MYNFZNHALlflZ82KyZ+Q14b8w806i/F1PTeWxyXfmMugDIaWOtQAaFnh2K5Cp9PU44uveuaaTKqqVglj1R/vOB19U0QGa+dLPs/8WE7KWlxkWzuPmQtiqwqif17r5OkogQufPVb0mNKBKnPMPpHDNoodWX5eTiUrTAK1ZvvBnZmZqUbH+Q3Qb5A5AtKWpT1hDIM0PGxZmNkVkcxxQ/4KmAhDuMlIaGoKw==;5:PwITgJUnZFa4ilTFDTyHO58JgWfo3UFaPDQOlcHRaLxUvHSSMG7skS5U1sTWzr0Tj4cZ5UKdhTQfPbxqgZU3DORDCXLXcSaFXhQtXzouuN0l6ESl3/I5BajUm0mTY3j8Y9UpsPG5M7Rrsz25mmla0XLXP5HaTf1OFJz0ksOGDLQ=;7:0rE2xYxZyv9TPbozSTJ5I99uBKThb3IwjfnUbKA9yY9Mrn9fMjBwWGaoo+N8KLbQSHZx6YCPC5ZgEgSPFHw3pmU+6uV0MvELuHgO6Pr13B5i5dHY38Yia27j/YE7AbHaKT/qxhNWReWi4e4RvTxqk7bfOK33OQbaKPJA9aTT+XAd4Bjpb6Bip2fgYV945gksujRn/ob7JLgy7oVOjD+9cf5h8hcsmO5DwsNw3ueRDjR7cDAb9sfnp0aXK1REEGfm
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2018 13:48:39.6592
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06b38f72-8e51-469a-d01b-08d60835f815
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1612
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

The SCCG is a new PLL type introduced on i.MX8. Add support for this.
The driver currently misses the PLL lock check, as the preliminary
documentation mentions lock configurations, but is quiet about where
to find the actual lock status signal.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/Makefile       |   3 +-
 drivers/clk/imx/clk-sccg-pll.c | 231 +++++++++++++++++++++++++++++++++++++++++
 drivers/clk/imx/clk.h          |   9 ++
 3 files changed, 242 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/imx/clk-sccg-pll.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 4893c1f..b87513c 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -12,7 +12,8 @@ obj-y += \
 	clk-pllv1.o \
 	clk-pllv2.o \
 	clk-pllv3.o \
-	clk-pfd.o
+	clk-pfd.o \
+	clk-sccg-pll.o
 
 obj-$(CONFIG_SOC_IMX1)   += clk-imx1.o
 obj-$(CONFIG_SOC_IMX21)  += clk-imx21.o
diff --git a/drivers/clk/imx/clk-sccg-pll.c b/drivers/clk/imx/clk-sccg-pll.c
new file mode 100644
index 0000000..886ae03
--- /dev/null
+++ b/drivers/clk/imx/clk-sccg-pll.c
@@ -0,0 +1,231 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2018 NXP.
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+
+#include "clk.h"
+
+/* PLL CFGs */
+#define PLL_CFG0	0x0
+#define PLL_CFG1	0x4
+#define PLL_CFG2	0x8
+
+#define PLL_DIVF1_SHIFT	13
+#define PLL_DIVF2_SHIFT	7
+#define PLL_DIVF_MASK	0x3f
+
+#define PLL_DIVR1_SHIFT	25
+#define PLL_DIVR2_SHIFT	19
+#define PLL_DIVR1_MASK	0x3
+#define PLL_DIVR2_MASK	0x3f
+#define PLL_REF_SHIFT	0
+#define PLL_REF_MASK	0x3
+
+#define PLL_LOCK	31
+#define PLL_PD		7
+
+#define OSC_25M		25000000
+#define OSC_27M		27000000
+
+struct clk_sccg_pll {
+	struct clk_hw	hw;
+	void __iomem	*base;
+};
+
+#define to_clk_sccg_pll(_hw) container_of(_hw, struct clk_sccg_pll, hw)
+
+static int clk_pll1_is_prepared(struct clk_hw *hw)
+{
+	struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
+	u32 val;
+
+	val = readl_relaxed(pll->base + PLL_CFG0);
+	return (val & (1 << PLL_PD)) ? 0 : 1;
+}
+
+static unsigned long clk_pll1_recalc_rate(struct clk_hw *hw,
+					 unsigned long parent_rate)
+{
+	struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
+	u32 val, divf;
+
+	val = readl_relaxed(pll->base + PLL_CFG2);
+	divf = (val >> PLL_DIVF1_SHIFT) & PLL_DIVF_MASK;
+
+	return parent_rate * 2 * (divf + 1);
+}
+
+static long clk_pll1_round_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long *prate)
+{
+	unsigned long parent_rate = *prate;
+	u32 div;
+
+	div = rate / (parent_rate * 2);
+
+	return parent_rate * div * 2;
+}
+
+static int clk_pll1_set_rate(struct clk_hw *hw, unsigned long rate,
+			    unsigned long parent_rate)
+{
+	struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
+	u32 val;
+	u32 divf;
+
+	divf = rate / (parent_rate * 2);
+
+	val = readl_relaxed(pll->base + PLL_CFG2);
+	val &= ~(PLL_DIVF_MASK << PLL_DIVF1_SHIFT);
+	val |= (divf - 1) << PLL_DIVF1_SHIFT;
+	writel_relaxed(val, pll->base + PLL_CFG2);
+
+	/* FIXME: PLL lock check */
+
+	return 0;
+}
+
+static int clk_pll1_prepare(struct clk_hw *hw)
+{
+	struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
+	u32 val;
+
+	val = readl_relaxed(pll->base);
+	val &= ~(1 << PLL_PD);
+	writel_relaxed(val, pll->base);
+
+	/* FIXME: PLL lock check */
+
+	return 0;
+}
+
+static void clk_pll1_unprepare(struct clk_hw *hw)
+{
+	struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
+	u32 val;
+
+	val = readl_relaxed(pll->base);
+	val |= (1 << PLL_PD);
+	writel_relaxed(val, pll->base);
+}
+
+static unsigned long clk_pll2_recalc_rate(struct clk_hw *hw,
+					 unsigned long parent_rate)
+{
+	struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
+	u32 val, ref, divr1, divf1, divr2, divf2;
+	u64 temp64;
+
+	val = readl_relaxed(pll->base + PLL_CFG0);
+	switch ((val >> PLL_REF_SHIFT) & PLL_REF_MASK) {
+	case 0:
+		ref = OSC_25M;
+		break;
+	case 1:
+		ref = OSC_27M;
+		break;
+	default:
+		ref = OSC_25M;
+		break;
+	}
+
+	val = readl_relaxed(pll->base + PLL_CFG2);
+	divr1 = (val >> PLL_DIVR1_SHIFT) & PLL_DIVR1_MASK;
+	divr2 = (val >> PLL_DIVR2_SHIFT) & PLL_DIVR2_MASK;
+	divf1 = (val >> PLL_DIVF1_SHIFT) & PLL_DIVF_MASK;
+	divf2 = (val >> PLL_DIVF2_SHIFT) & PLL_DIVF_MASK;
+
+	temp64 = ref * 2;
+	temp64 *= (divf1 + 1) * (divf2 + 1);
+
+	do_div(temp64, (divr1 + 1) * (divr2 + 1));
+
+	return (unsigned long)temp64;
+}
+
+static long clk_pll2_round_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long *prate)
+{
+	u32 div;
+	unsigned long parent_rate = *prate;
+
+	div = rate / (parent_rate);
+
+	return parent_rate * div;
+}
+
+static int clk_pll2_set_rate(struct clk_hw *hw, unsigned long rate,
+			    unsigned long parent_rate)
+{
+	u32 val;
+	u32 divf;
+	struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
+
+	divf = rate / (parent_rate);
+
+	val = readl_relaxed(pll->base + PLL_CFG2);
+	val &= ~(PLL_DIVF_MASK << PLL_DIVF2_SHIFT);
+	val |= (divf - 1) << PLL_DIVF2_SHIFT;
+	writel_relaxed(val, pll->base + PLL_CFG2);
+
+	/* FIXME: PLL lock check */
+
+	return 0;
+}
+
+static const struct clk_ops clk_sccg_pll1_ops = {
+	.is_prepared	= clk_pll1_is_prepared,
+	.recalc_rate	= clk_pll1_recalc_rate,
+	.round_rate	= clk_pll1_round_rate,
+	.set_rate	= clk_pll1_set_rate,
+};
+
+static const struct clk_ops clk_sccg_pll2_ops = {
+	.prepare	= clk_pll1_prepare,
+	.unprepare	= clk_pll1_unprepare,
+	.recalc_rate	= clk_pll2_recalc_rate,
+	.round_rate	= clk_pll2_round_rate,
+	.set_rate	= clk_pll2_set_rate,
+};
+
+struct clk *imx_clk_sccg_pll(const char *name,
+				const char *parent_name,
+				void __iomem *base,
+				enum imx_sccg_pll_type pll_type)
+{
+	struct clk_sccg_pll *pll;
+	struct clk *clk;
+	struct clk_init_data init;
+
+	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
+	if (!pll)
+		return ERR_PTR(-ENOMEM);
+
+	pll->base = base;
+	init.name = name;
+	switch (pll_type) {
+	case SCCG_PLL1:
+		init.ops = &clk_sccg_pll1_ops;
+		break;
+	case SCCG_PLL2:
+		init.ops = &clk_sccg_pll2_ops;
+		break;
+	}
+
+	init.flags = 0;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+
+	pll->hw.init = &init;
+
+	clk = clk_register(NULL, &pll->hw);
+	if (IS_ERR(clk))
+		kfree(pll);
+
+	return clk;
+}
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 13daf1c..12b3fd6 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -21,6 +21,11 @@ enum imx_pllv1_type {
 	IMX_PLLV1_IMX35,
 };
 
+enum imx_sccg_pll_type {
+	SCCG_PLL1,
+	SCCG_PLL2,
+};
+
 struct clk *imx_clk_pllv1(enum imx_pllv1_type type, const char *name,
 		const char *parent, void __iomem *base);
 
@@ -30,6 +35,10 @@ struct clk *imx_clk_pllv2(const char *name, const char *parent,
 struct clk *imx_clk_frac_pll(const char *name, const char *parent_name,
 			     void __iomem *base);
 
+struct clk *imx_clk_sccg_pll(const char *name, const char *parent_name,
+			     void __iomem *base,
+			     enum imx_sccg_pll_type pll_type);
+
 enum imx_pllv3_type {
 	IMX_PLLV3_GENERIC,
 	IMX_PLLV3_SYS,
-- 
2.7.4

