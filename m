Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF81C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 13:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7CF3214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 13:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TXcEvT14"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7CF3214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbeHVROK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 13:14:10 -0400
Received: from mail-he1eur01on0051.outbound.protection.outlook.com ([104.47.0.51]:19992
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729131AbeHVROJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 13:14:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7UoHKzRUM4Rc1K65M2cWPvUaeNiIh/eVzAHvLglLFMc=;
 b=TXcEvT1472cLpC1q4iw7tC3XtWhM9XQufzK5lMb4pXmGCXEeioOWEzm9O+IoZYuenOHEfMBKhYMNkQS0G6/ea/GHXYwvNMQK4D01XpUy2S9yPe8rYExMDa+L7xPegRyy9fKPrJdFwFh6Sq7V01yyONzgDDz1N42Zm8S8wmtC1Tg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
Received: from fsr-ub1664-175.ea.freescale.net (95.76.156.53) by
 HE1PR04MB1612.eurprd04.prod.outlook.com (2a01:111:e400:59a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.21; Wed, 22 Aug
 2018 13:48:38 +0000
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
Subject: [PATCH v6 2/5] clk: imx: add fractional PLL output clock
Date:   Wed, 22 Aug 2018 16:48:20 +0300
Message-Id: <1534945703-4730-3-git-send-email-abel.vesa@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7f3b6446-2424-48b3-cbd7-08d60835f733
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1612;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1612;3:YWzSaJ4slr+ytF5pnsoWcHDDXHLOyiB2phNlvf2QigVPSOdK9voDwekOz4EAnONmne4RGiDOxUavXtmk6bVnM7QpT2OzdOcmxzvCGJxkg1bnwmucKBYsxjx+neMazIyAzvKLcpAz0Khg39pwbt5qUUspUqApEZIcckN1G9AnVpICne+3J3EVO2cruyr2WZBRs6PnRuAD6cC4KgSBlsO5zElgKU4hgpNzWvQjvbU85TVQWtPbXGH9Oe/HGjukxQfY;25:gxtPmlbzD+FI2cmhvR3hjuSqk6+xIdg/JROsjIEWJ0OmOC+ZSdUDmgoQffj5utR84Mn8Xzbs3PrScveXmAYQhbrlkz7iI/46E1liAgBEqdCWycW31MTLQWWK7NORs+ItEb6Uy31H/E2C5QimmfoiEe1SDasweldoD79SRiIW9d68SGwsgULM6tyTf5AiyEaEzgn8lrAYbDpYV3OOyYYJLanBMgfX3H6gmwAB0OX3ybph9FW/GZxtFD+ya76XqepeeZ9l8d19vnBulP3NU/cHv3LZkhC7DWOBOi411APT6Dc10CP5ob0BAl/4R1A5Gwg1dJ2pW46fMdEpEomAntkaOA==;31:/dlf0loOec7xGB3cDc+axTs0SUbJR3tt5FgGUsV42n5k8jHfeZixrJMewcNcXdSNfZFtKFZO4sTHKgijaaFKzaxxpmBTCHER8b6Rspa7hUK3AU03eq5bhhWbpqtFTQeh0JJMBHaMYXIrvRdYn4/oitMZ8lTUTR/ln8XJSKEvoQvnkr5w6NJp3RkpMMVdtgJZZ2uSpKLTlG9nz1X5/jO/8jMb6i7RCIeaAIgEe7EXM74=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1612:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1612;20:gyRcvxsuMnSVwl8J5C6qX9S/3prAr3+rnI8KiZGN5OOABGwIlmKjKr+8nTfaxxcxBX8Z8qzbMWnKp7wwrdifsy+6xQQwcBy0w1GO89dHOY5jYC7x+7KvQTQ2SdOpiw/QMa/cPETiGGi27hlSg3FkC+/1ksd/8Nt0eJtX6eC4LdaAqKKdnjzYGxPFuG15YaWIjCvCAlaNDp/LBX9WqP7IOKz9xnjhdiM++446RxzX3HyFeKFAZolvSWnc5emxn81khXrTaCHOk+tHINR1xJXAV2iXkK27ilJUMKHGz/nb2+5u3+yi/idiu8EfUH4gbvMRfDWqwWpMGiZp2YUP2P7LCdu1Ly2X2BX2y+iSMWtdMEQ7YE8P7jfggwl3TAFW8WdG+N6tq0WTIp1rP+yow+LnY3YnM65XsDQkVeb7DTa8IJS+IAQsvq4lB9gmD35PvwvIhUhwnCifoQnyl2ymvaTSbfrusn8W2XHADkrhnB3v+xUgZFPQT0N5n1NwDVDvaQMM;4:ErNXbx1viJUvOQGyoZqOWr6UEnhMgAtphslkyIK0rSf54Re1P0tBSOuxtUZFpg2/R6VrIOaGoAL220ZrGzz61WiPpQmvh2Jk4DhzATKz7NBfQx9hOm86FcYGeOKjMpVXVq06OD80L5mjFkB3LXPJTkF3P+rcOvbpBa17KhBHKj9s18lF5L0OYeTT3vZ2VsbVJ1xezqq3ckhcRtVPoqrHvKj591d40B9E09uLaLDj+CA9NEDWCp9LS4xaVEXQPKKdWePdXvd/Rnxxo/8NyMbLLPAfBfWQLJ1dde2AA/MNL41RIyfd01tPeeyuQ185Bma0
X-Microsoft-Antispam-PRVS: <HE1PR04MB1612C66F0E042BC51C9F9236F6300@HE1PR04MB1612.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3002001)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:HE1PR04MB1612;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1612;
X-Forefront-PRVS: 0772E5DAD5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39860400002)(366004)(136003)(189003)(199004)(36756003)(14444005)(6116002)(186003)(26005)(16526019)(51416003)(386003)(52116002)(316002)(47776003)(66066001)(110136005)(6506007)(50466002)(76176011)(48376002)(8936002)(54906003)(97736004)(478600001)(16586007)(44832011)(105586002)(25786009)(5660300001)(446003)(86362001)(2906002)(11346002)(3846002)(6636002)(50226002)(106356001)(6666003)(476003)(486006)(4326008)(7736002)(8676002)(81156014)(68736007)(53936002)(7416002)(2616005)(956004)(81166006)(6512007)(6486002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1612;H:fsr-ub1664-175.ea.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1612;23:Qb1mw6wi1w3aOuq/7H8b3fll+tVuuH3Zdprt1cR+e?=
 =?us-ascii?Q?zK6KmmWjJSjq9N3uDKPoH1zWlbVzAjyZ/4T91U/sYRCc303RSBJvVL1EdWNw?=
 =?us-ascii?Q?yGKY/QoRawz0CEJzcgnztWpriWVBbu/EGDl6IdiWdF+9GQk5NGJfOQ7A7Zu3?=
 =?us-ascii?Q?oH6rtd0MObAV8+Rx5C85BsH35S9XxyrAXf9OTpWl2gm+33Q8+uoaR/GTfE1L?=
 =?us-ascii?Q?W2ORn7R5R4+X0E3ldom02JS/8t7RsLPLwEYviRtALJGQQuEuIqxsmwCmSUJi?=
 =?us-ascii?Q?l50nQc1O8S9cuAcAFg++ydfFG1hS98frs/kjrsnleDlBf5Lsd9ZVQZpVxwbm?=
 =?us-ascii?Q?s8q1/byqqxmIVW6PsaBoiAZTAeQtf5BPbMaHK+JULuXL1dn5AqHZ2z2kKssc?=
 =?us-ascii?Q?VZmF9cmygjjRcFVMrKNcjKRFMENCdyUb796nLprJ8+E/sVR7dLq8G8sX+h2M?=
 =?us-ascii?Q?/UEV9g54TVfj8doPb+VYUwQgEEAXy9jMCBApcIUgaGJCz8UMpTy5bPDDpjGV?=
 =?us-ascii?Q?9Il/PZgFDKxoY/t46m8VdqFYa0C+grIx69A9WYDosqwATbg98JQpotdYigxp?=
 =?us-ascii?Q?X2hZV9rwYhAT5uIIL+MXJnm/ZO63WZYEb5kHV0QT4x/6SFv8pTlCJyNd4o+a?=
 =?us-ascii?Q?sYJGFiuxUrDkuc/Mz8vd03KtAHdTHJWEzsHthVarPW8zZ8vbxGYcn8/RxqBV?=
 =?us-ascii?Q?gMhp1fwHnVPHLmhLL3thSORMqg0VOAEa1riCrpwLuWcCJOv1G1KKYJilqLzB?=
 =?us-ascii?Q?siaMK8vIh9Qt7IBOD+LH5yLmTFlpY+6n7ToqK8S2YBhu/zd3dBcQuLf/wmQo?=
 =?us-ascii?Q?LHI4dSu63gsGooLVCPhHruDhOLHWP6CsvU2AqVD2UqyKfKai1OxIiEpA9jG7?=
 =?us-ascii?Q?HuFBKRl4gokL63Is4hwtNY2k7jJQAGxzP7pUph5qQ2uLcBGxhRUAhyvoMdyc?=
 =?us-ascii?Q?SQU/h5mrMer8DXjUuUdPFiaSTi7v8yqrpjn9X3VilIk0TBJ2e/cHlRLdS55Y?=
 =?us-ascii?Q?757FO+HBLFiVTFeXwjSK0g60jNhe32I68Pp3qVhCkk8G9gS7XGkV9Bqpbufh?=
 =?us-ascii?Q?QVyU/WZCUAZ/cp1/BABLU5CH5ceH/YXdJhoLS+M06qM70vwgTyEWYfgpIMbz?=
 =?us-ascii?Q?idnWhrhZJGvXn7izB44T8sJHFsCCYZuADeQwNloTkQVBw5PKjbR5SMp/ZNwD?=
 =?us-ascii?Q?glIqaKYvWcEiaobth58OLH0uRX0xHae7sMmLWT+w+p1g54lAcJ+UrkZ5jBsj?=
 =?us-ascii?Q?McyW25NWioze6TRIASTuLvD3GJVecXypi1nDTpO?=
X-Microsoft-Antispam-Message-Info: m0ZztwfHqmJnab7GNsbwqPDWff+I+mBiKDUZvMetdvFLEDfkcvlLUUdr7LR9SYUe9bStPmTlzC66AZliUkrtQVsBN4jlEOsfMU/J7lIJGT2adEk4KC8zbRWxMqV0Zc7HPEATelnWQzujHv6h7eRh/OPU7wSo9xSDdWNElEq/awktL6J1Y0++b7t+PBY7jJUqBnDdID9Z1oJnz4zaK03/ipwLw+VBCT/snawxQFkE0/UuthDu5k9zninTpNJyfzSZgbe+4qk+7LdJTs4x2cLdnZA13TfXYG4WJcFKMtLivdPKDRMRJxDxE8aC1Mq3xKkWIkNEFunwqd/1P0Adzye6SG8tENr385tPbeSQon3MvfU=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1612;6:I2Wdv1FylDl7EQo+H3WlB/h/tl8KoZwykz1VXxdVHIaqhpFQPboCdDzSTR1px+nTUpvf5KPiWFOmDMflVzg9tSgvNtuJ2XfyhH8pql4oOhMoq9SGhs4NooKBgjCXXlXLNKvofxKsmomusunv5wRqPFathlukjnY2ZGgPyPDbxedd9Dlf9UL8iQT+B12LahKQPLaeA3XjQT7Uv17TIZ1f3NTpSvrHhnNIAtHUnp139W2eSfE+0YUrHpVWIj7vmLUSo9NVi7NuKM9/2iBeRGaF3cIMOZ4Wypnbn4N2ToDfQgdg06U+4KIc91tNNvWJM/6aBkF6/drcrct7xQ0wICu3PeH9YqQayOhhaqHNqNNKbG09YL4YpMvlM3JmRogcMJdchofa9xsKH4/R8haRplMv+dJW74OUGENvX2zsYGOOfdQXXdixgoD4q1hwxoyMH59AjG472oeeiEIkUdcsnQ9UJw==;5:6YdY3dmWTErn+/yjdQ+fqZuI9HxKZzCZ6yuIbHeymz23kYBSfI71Lz1tk4zL8/O5A7BWorD6+QhvPwOhGWGQ5O1l+7FOTZWgYX64jsiDT3HfDH4LKlS/zyKXhwTrtzn5piq+U8pNhm8ma3qbDOkREOdCMbgHBJnGXEPHwQ/BrK4=;7:PF+w4rKciF6gg1Ak90LyooTudFwspW85o781+LORF5v5JyNDrMPqELGrAXXbuoW6jpRHNORFpDx4wrCip4tOvmIK8dygp+yYmsWUaKkAJin/3bRfb6OLFT4VAwWigB7nrvkZ8pcT+6+g+M3CyXOCsNBy3w6AKptj4OeBOwExpGqjIoHnkuOIz4uXEE1uGcHAYrp9FsPnO5vwSDyihDvwhXPno8Mnfkhxgg53h3BLiTkO5BrDaZ0/BxLYBOIi725h
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2018 13:48:38.1630
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f3b6446-2424-48b3-cbd7-08d60835f733
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1612
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

This is a new clock type introduced on i.MX8.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/Makefile       |   1 +
 drivers/clk/imx/clk-frac-pll.c | 230 +++++++++++++++++++++++++++++++++++++++++
 drivers/clk/imx/clk.h          |   3 +
 3 files changed, 234 insertions(+)
 create mode 100644 drivers/clk/imx/clk-frac-pll.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 8c3baa7..4893c1f 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -6,6 +6,7 @@ obj-y += \
 	clk-cpu.o \
 	clk-fixup-div.o \
 	clk-fixup-mux.o \
+	clk-frac-pll.o \
 	clk-gate-exclusive.o \
 	clk-gate2.o \
 	clk-pllv1.o \
diff --git a/drivers/clk/imx/clk-frac-pll.c b/drivers/clk/imx/clk-frac-pll.c
new file mode 100644
index 0000000..c80c6ed
--- /dev/null
+++ b/drivers/clk/imx/clk-frac-pll.c
@@ -0,0 +1,230 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2018 NXP.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/jiffies.h>
+#include <linux/slab.h>
+
+#include "clk.h"
+
+#define PLL_CFG0		0x0
+#define PLL_CFG1		0x4
+
+#define PLL_LOCK_STATUS		BIT(31)
+#define PLL_PD			19
+#define PLL_PD_MASK		BIT(PLL_PD)
+#define PLL_BYPASS		14
+#define PLL_BYPASS_MASK		BIT(PLL_BYPASS)
+#define PLL_NEWDIV_VAL		BIT(12)
+#define PLL_NEWDIV_ACK		BIT(11)
+#define PLL_FRAC_DIV_MASK	0xffffff
+#define PLL_INT_DIV_MASK	0x7f
+#define PLL_OUTPUT_DIV_MASK	0x1f
+#define PLL_FRAC_DENOM		0x1000000
+
+struct clk_frac_pll {
+	struct clk_hw	hw;
+	void __iomem	*base;
+};
+
+#define to_clk_frac_pll(_hw) container_of(_hw, struct clk_frac_pll, hw)
+
+static int clk_wait_lock(struct clk_frac_pll *pll)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(10);
+	u32 val;
+
+	/* Wait for PLL to lock */
+	do {
+		if (readl_relaxed(pll->base) & PLL_LOCK_STATUS)
+			break;
+		if (time_after(jiffies, timeout))
+			break;
+	} while (1);
+
+	return readl_poll_timeout(pll->base, val,
+					val & PLL_LOCK_STATUS, 0, 1000);
+}
+
+static int clk_wait_ack(struct clk_frac_pll *pll)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(50);
+	u32 val;
+
+	/* return directly if the pll is in powerdown or in bypass */
+	if (readl_relaxed(pll->base) & (PLL_PD_MASK | PLL_BYPASS_MASK))
+		return 0;
+
+	/* Wait for the pll's divfi and divff to be reloaded */
+	do {
+		if (readl_relaxed(pll->base) & PLL_NEWDIV_ACK)
+			break;
+		if (time_after(jiffies, timeout))
+			break;
+	} while (1);
+
+	return readl_poll_timeout(pll->base, val,
+					val & PLL_NEWDIV_ACK, 0, 1000);
+}
+
+static int clk_pll_prepare(struct clk_hw *hw)
+{
+	struct clk_frac_pll *pll = to_clk_frac_pll(hw);
+	u32 val;
+
+	val = readl_relaxed(pll->base + PLL_CFG0);
+	val &= ~PLL_PD_MASK;
+	writel_relaxed(val, pll->base + PLL_CFG0);
+
+	return clk_wait_lock(pll);
+}
+
+static void clk_pll_unprepare(struct clk_hw *hw)
+{
+	struct clk_frac_pll *pll = to_clk_frac_pll(hw);
+	u32 val;
+
+	val = readl_relaxed(pll->base + PLL_CFG0);
+	val |= PLL_PD_MASK;
+	writel_relaxed(val, pll->base + PLL_CFG0);
+}
+
+static int clk_pll_is_prepared(struct clk_hw *hw)
+{
+	struct clk_frac_pll *pll = to_clk_frac_pll(hw);
+	u32 val;
+
+	val = readl_relaxed(pll->base + PLL_CFG0);
+	return (val & PLL_PD_MASK) ? 0 : 1;
+}
+
+static unsigned long clk_pll_recalc_rate(struct clk_hw *hw,
+					 unsigned long parent_rate)
+{
+	struct clk_frac_pll *pll = to_clk_frac_pll(hw);
+	u32 val, divff, divfi, divq;
+	u64 temp64;
+
+	val = readl_relaxed(pll->base + PLL_CFG0);
+	divq = ((val & PLL_OUTPUT_DIV_MASK) + 1) * 2;
+	val = readl_relaxed(pll->base + PLL_CFG1);
+	divff = (val >> 7) & PLL_FRAC_DIV_MASK;
+	divfi = (val & PLL_INT_DIV_MASK);
+
+	temp64 = (u64)parent_rate * 8;
+	temp64 *= divff;
+	do_div(temp64, PLL_FRAC_DENOM);
+	temp64 /= divq;
+
+	return parent_rate * 8 * (divfi + 1) / divq + (unsigned long)temp64;
+}
+
+static long clk_pll_round_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long *prate)
+{
+	unsigned long parent_rate = *prate;
+	u32 divff, divfi;
+	u64 temp64;
+
+	parent_rate *= 8;
+	rate *= 2;
+	divfi = rate / parent_rate;
+	temp64 = (u64)(rate - divfi * parent_rate);
+	temp64 *= PLL_FRAC_DENOM;
+	do_div(temp64, parent_rate);
+	divff = temp64;
+
+	temp64 = (u64)parent_rate;
+	temp64 *= divff;
+	do_div(temp64, PLL_FRAC_DENOM);
+
+	return (parent_rate * divfi + (unsigned long)temp64) / 2;
+}
+
+/*
+ * To simplify the clock calculation, we can keep the 'PLL_OUTPUT_VAL' at zero
+ * (means the PLL output will be divided by 2). So the PLL output can use
+ * the below formula:
+ * pllout = parent_rate * 8 / 2 * DIVF_VAL;
+ * where DIVF_VAL = 1 + DIVFI + DIVFF / 2^24.
+ */
+static int clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
+			    unsigned long parent_rate)
+{
+	struct clk_frac_pll *pll = to_clk_frac_pll(hw);
+	u32 val, divfi, divff;
+	u64 temp64;
+	int ret;
+
+	parent_rate *= 8;
+	rate *= 2;
+	divfi = rate / parent_rate;
+	temp64 = (u64) (rate - divfi * parent_rate);
+	temp64 *= PLL_FRAC_DENOM;
+	do_div(temp64, parent_rate);
+	divff = temp64;
+
+	val = readl_relaxed(pll->base + PLL_CFG1);
+	val &= ~((PLL_FRAC_DIV_MASK << 7) | (PLL_INT_DIV_MASK));
+	val |= ((divff << 7) | (divfi - 1));
+	writel_relaxed(val, pll->base + PLL_CFG1);
+
+	val = readl_relaxed(pll->base + PLL_CFG0);
+	val &= ~0x1f;
+	writel_relaxed(val, pll->base + PLL_CFG0);
+
+	/* Set the NEV_DIV_VAL to reload the DIVFI and DIVFF */
+	val = readl_relaxed(pll->base + PLL_CFG0);
+	val |= PLL_NEWDIV_VAL;
+	writel_relaxed(val, pll->base + PLL_CFG0);
+
+	ret = clk_wait_ack(pll);
+
+	/* clear the NEV_DIV_VAL */
+	val = readl_relaxed(pll->base + PLL_CFG0);
+	val &= ~PLL_NEWDIV_VAL;
+	writel_relaxed(val, pll->base + PLL_CFG0);
+
+	return ret;
+}
+
+static const struct clk_ops clk_frac_pll_ops = {
+	.prepare	= clk_pll_prepare,
+	.unprepare	= clk_pll_unprepare,
+	.is_prepared	= clk_pll_is_prepared,
+	.recalc_rate	= clk_pll_recalc_rate,
+	.round_rate	= clk_pll_round_rate,
+	.set_rate	= clk_pll_set_rate,
+};
+
+struct clk *imx_clk_frac_pll(const char *name, const char *parent_name,
+			     void __iomem *base)
+{
+	struct clk_init_data init;
+	struct clk_frac_pll *pll;
+	struct clk *clk;
+
+	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
+	if (!pll)
+		return ERR_PTR(-ENOMEM);
+
+	pll->base = base;
+	init.name = name;
+	init.ops = &clk_frac_pll_ops;
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
index 8076ec0..13daf1c 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -27,6 +27,9 @@ struct clk *imx_clk_pllv1(enum imx_pllv1_type type, const char *name,
 struct clk *imx_clk_pllv2(const char *name, const char *parent,
 		void __iomem *base);
 
+struct clk *imx_clk_frac_pll(const char *name, const char *parent_name,
+			     void __iomem *base);
+
 enum imx_pllv3_type {
 	IMX_PLLV3_GENERIC,
 	IMX_PLLV3_SYS,
-- 
2.7.4

