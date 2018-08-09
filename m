Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D3FC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5F8721E97
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="x6qtUfn2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5F8721E97
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732479AbeHIRL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:11:27 -0400
Received: from mail-eopbgr60044.outbound.protection.outlook.com ([40.107.6.44]:32576
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732423AbeHIRL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:11:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7UoHKzRUM4Rc1K65M2cWPvUaeNiIh/eVzAHvLglLFMc=;
 b=x6qtUfn2GtN0ANbqutfAciuMMz/CMbmzYicA8+/r2DW4Cck5yadSqxIOjlywAoux6cZrc90/d2rcnVDtoCf1dGKgx3b2hAtV8GMa5x3YD6x5GxrIJXFvwtgTVPX1mFbo1pr7v4QGZuwjqV6J7IB7xmgwcZHu8BIQ2tdS280fSvM=
Received: from fsr-ub1664-175.ea.freescale.net (95.76.156.53) by
 HE1PR04MB1611.eurprd04.prod.outlook.com (2a01:111:e400:59a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.18; Thu, 9 Aug
 2018 14:46:00 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v3 2/4] clk: imx: add fractional PLL output clock
Date:   Thu,  9 Aug 2018 17:45:39 +0300
Message-Id: <1533825941-17224-3-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533825941-17224-1-git-send-email-abel.vesa@nxp.com>
References: <1533825941-17224-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: AM3PR04CA0141.eurprd04.prod.outlook.com (2603:10a6:207::25)
 To HE1PR04MB1611.eurprd04.prod.outlook.com (2a01:111:e400:59a9::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1569b7f0-75e8-4074-6d0f-08d5fe06d36b
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1611;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1611;3:FkkmknK4Cya3rkT3ji8t0jAocdH+VlpC3S2yCT3D1J+XZ74tvRZENkwOUzQf3Ck6FQMjLeUN7vF+7JsNK4IrfGW9ZtEbB3snFW6da40fg36LoGypwIR1LOv6/R6+pC9uH9ErbNCuDeNIXWBDmhAe3muD/TA6iPlTEjgQgnwMt2EFBPoP9JEHNDlGGJXs/GBE/O2gqq56//3+h1zP+vcSZbSgelA3U5P4usbmQb/BCrLd9gwqu0UHDwBf9OD7++Is;25:R0BXg7kTiwOSaeve1t1h2mKp0e2JIyh7o22fPngBQJ61MZSKJNAYf1yLdy6WkNAYfCVjMuhNY7yV3hYrwi33dYUGwFLCXbd1c6Hhj4NtiFpcQWvXlLImvEnf+utt0F/bkJbxxr9vtWvMFR03wQ9uOB6J0cpU40ewvcfrKjstUGRTaKs+GiDP/yZBVzNiLWfNQ+Fm4Xv+Pe+X60aX9AIkI7qFCYU0Gp1l/tYR/GYtr6mOuXjiy0Ey5bEC5MVOWClisNmxRFPGRSt18Mqi1IsKZ7dlVUTX3Rte1J/pZ4l7nKiKWzvwmP0ESbGYGT4qdo7qpq7T47sCYwhWGfG5qJvalw==;31:B9LkDKGKi4woarukbtbHhh5SYlOAoNOylZGLlibfkRC5ceb/nE9FBbfTMtp+7X0qiqTStTWoTCixsEglafK60+8ey3wX/ld4n6yQ8175tA1ium6gpmqcXvRDwvEi9PJ7j9zWIakqPTIqwhLCgksN0KFB5V8Eg7tlsrU/h7RrJiqZLx3NdVv7SKiEK1iX9cKpTnBDYKy/Kq3El6DyjdiFt0KLoh84jdnFJXMpkIgr+xE=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1611:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1611;20:SdDqRFcOrok6CiACsRRQt9JkLfolDfQCZaWZtz9kLIzoqjnkfinS0TaWzTsJpwSvFizjVIh0hiDIz6qUYSFxeSZiL57cicactsTLMIAtJa6P9NmVwHGEFmugbpBUd/Qq+ecKSmctUZGNNvzwY1gz9UjSLaD3ILTZOxPZRrafRLhY/64N+7lZ8knIdJi0O6Mw5h77k7/YcjgAy5On5wav/vymwfXiRkT4I1OXT5JXwccbtt0lHM30FjV4QTsVXfwfbCI9sLo7HS6SLVaUCjA4QxrdRfZXn1ZxitWjUMOqtKHBD6uwJ96TFAcA9QFCUlnpLBbTU2mC0g/dVrTs9ACGt1L0vALAv/eFZ2Xz6q1ToLlUqv9uiEQ8TLZI5AmXr2hm3Q5k5P57nZCKrsS+8gie3357yKTCwi8KrVcyPih5DH/vsq/UlSOjJYreMukh20q3Q0Y9/hSMvKBCHW2NIpIobEHwM6XUtPYVNcoqbxCJFsjneBZ5efGvHhtFCf3wRqJW;4:8ftXwBzIcXfgQk9AIb/k3MHH7CaQDNuq51RGnDBuqIOxow4hRJmrKXCehwWwhgUnDdwVPV3h1+MX7tLA4MiJpaxVCtQPcE1CI4VSmVxXyWhAMmz32sBo/1aUYOg20Dlw+4xfGcJhs/K1TRX+NNlRBeCx7GuZaLNd2JYLjfHDAKqhmYXfPF9eVRqLpHAxN+MjxhCg13OaE/DMg7nOyTbWuYYiw3/XnKYDQon5zadhuDXJhcTCKFCckPAAaYGxWZWq6EjcQRAQDzOkiSQmKuSMuc3e7pObOh7rQgrC4wh/ANUU62P5nIwfL07Er5co9Im0
X-Microsoft-Antispam-PRVS: <HE1PR04MB16111C3ABB87A6393902D756F6250@HE1PR04MB1611.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:HE1PR04MB1611;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1611;
X-Forefront-PRVS: 0759F7A50A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(366004)(346002)(136003)(189003)(199004)(8936002)(47776003)(50226002)(53936002)(6116002)(81156014)(54906003)(110136005)(81166006)(8676002)(16586007)(5660300001)(68736007)(316002)(7736002)(305945005)(14444005)(6666003)(7416002)(51416003)(66066001)(52116002)(76176011)(36756003)(3846002)(25786009)(105586002)(97736004)(6506007)(386003)(106356001)(48376002)(6512007)(186003)(2906002)(16526019)(26005)(4326008)(50466002)(478600001)(476003)(446003)(44832011)(2616005)(6486002)(11346002)(956004)(86362001)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1611;H:fsr-ub1664-175.ea.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1611;23:wycS8/8tdqAjPSU98Hqp4eDJbHTjShs0dQu3g7WpA?=
 =?us-ascii?Q?fghCb6IB8kRXtODHNEz96lGcuADUirt3/U/e5Ux6aiKKITeIxbxR08BiyxVM?=
 =?us-ascii?Q?7dhtpG1jAiTwzKgFq/S/Vi0vBZbyDlTHd66uf57UQKapBdE76oMh1r49MJHf?=
 =?us-ascii?Q?gMLLiDp/CxKwVEDiePQ13Ah14ZpapUgh/blfYYtAE8DUhoCAjPLYj/g2+6YR?=
 =?us-ascii?Q?6niuKqZgvF8xoXvFmGKGxa4w/lKZko666IJE/C28FSPc3d9jJHKtDrnFcoba?=
 =?us-ascii?Q?6KAEqslaOLdqDyjEf9Npd9ZjM8vKNSQtw0ss9MCtz2Aqv90ST1d4QHqFb5sb?=
 =?us-ascii?Q?VpfL2PVvhBuUGcpYz9S61sjfNOmqLREuLaaNerQK6pyKBM2rp/ApdlP2+jjd?=
 =?us-ascii?Q?QEuNp1mhj/aXA1oBUyhVWIs3pCqtVSE3n6u9YbF8/f0V5dg/QBgLJ4gw4bd2?=
 =?us-ascii?Q?GSRv/M0YqPA7qDjtS/N94DKtLkwq21WRoJDY3xYNQd40rZpCJ0xlrD2QHS9v?=
 =?us-ascii?Q?jgpBNCiXiJsgs6R93yGnkiUDLnYffcl1pj2FslzWWjlA3vxl7kheF6w9CmNl?=
 =?us-ascii?Q?qjtQ8R+HBtU/vUGdeUWqAviH0FdJseQ8VuoWDlO8omPStbQXQXdiNKCr1res?=
 =?us-ascii?Q?VQ2hq0AMwa65EVpb+Y762Daa+W1VgJp9kLwwOfBrMjo4uO55l5qyp2ULmI9j?=
 =?us-ascii?Q?G8+JaJV5CFM9WtemeiNxCTJarAakI4Ysjl6CMggmRwmRffilJae1GJM1e325?=
 =?us-ascii?Q?8T4HZmhYAH/to/Xop80MAkt+gXJRz9SivpQBLWM4ptjy7rYc17y3swBxf9au?=
 =?us-ascii?Q?N02YiUScb9IN9MzrlQXTySmJRz2LxxQ0is/7DDe/PX8g4iy7q8vBlDd9lamt?=
 =?us-ascii?Q?fg+XIZURqLoBK5F3PrBqzAwY7UQP+IptEci2t6hFbQWK4InhO3Eub+tKdEBM?=
 =?us-ascii?Q?CyxqO1sM0qLIz1mMnvRZ3dF/M+7YGqBmpAunqSqf0Na3fkYE/YzF9Qcq7r51?=
 =?us-ascii?Q?6SJD7G3p3bUM1wTxwaKd/s5fgn49dRKZyDjmH8UNCPfcJEK1vPHuSP6fNVH0?=
 =?us-ascii?Q?g3QbFYwPAxytEtpnxjkJH3fZxdI5uP3poqq9qUAQvqVMI/74PO4Q+wcuFycC?=
 =?us-ascii?Q?6LpkalfTLV36b142UZG0XYsPxN8SWBZaTutV21JVnm9yXrqbhxyoEHr/hzBd?=
 =?us-ascii?Q?XbqpN1WY98hzhwxRttXxWa85GWdDE2B50y0mm6apPY/4P4Gtu55FDeRWwvyu?=
 =?us-ascii?Q?hwvyG6gB6Jmj2i1NII=3D?=
X-Microsoft-Antispam-Message-Info: z7hNm5cljwcrmoQ5/8uILxZcbFTwu8aUpnNFBtHbiN3hwqnOrGtvGbhxyCoRBqzajnL4AwP06D01nFHPAbwm3D8dlpjkgawW8nHe7iALT/yposO4I0wklRG8dPc7tpvs9p3x02Vv20A32CQexy3n1qL2C4r6sgDB/z9V0Re8MF5FyoPY4B6OJclWFco05MYTRxMu9euqYYGxSMmA60hNvaKpM0BnmPIDiSITW0urXFneCJzkHvdW9K4rKUoIvl+ped8Gw5O62dyIqHGzK5PuBkv//nfR6MoQQvD31JvonSI72V525h3S9LB66Tzd1u+KFwS/sdyQGjWDajB1a2Inf5TB0RMT1oY2hs4ljACT8k4=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1611;6:XhxPu8KyHWfsmYnfj+IGO3diYGSCLY3+GYUW8ge/adCdF9WTnHcdMtLb7STEK2aj6MAGEvFpqxFnkDbuZLT0sdgNg2AdPBBRdzVJQ94L0UxARt2jbLV4PQQHiPqmrWIHlkiQbKmZqX9tUbpvDt61zezV8eVF3KzDckjByTyw3LVfuUTZiTaTFiIabcDbrLIPs6fjrYl4F7QWN/7tNskktcNDxmjz4jhZWYLFa6ffbQXWGBH8OGVrR/60fE5Ln9uqTIqIB7MUHjZKqkPuxttCxKl+vd8p1ZOXcZwgGSuPSR8dEvosQMMMLHWKSVQ5rIccbKUJUs/Xiho1H0WiDOYulWHXCw8cNGRPYf/kQYPgOjyez+bpGZhaUweI2Ei1HPmyxWvMLZ58lEnZkJHB2OERGmrkWFUl4we9UCRNAekOrc4dIv3QeAS7HxPJNl3P3sAnuNbHd1gwMO3putj61hkxFQ==;5:VRg61xo3YKomvu3m4HeFreQdcuJOBfsThbdeLQMByJPyXq9hVmXjLm1U0V3yNeVHMkoGALVRmYJw3cRF2PPf0ggqtCoRccWQdoJf+dPA6B3JBhw9vfCZTOMVs+pPN9/dQkOVzJpqkWa7GzUxi4o7wQY7v41tnoigUPSDPgkn6T0=;7:HcRh9pYgFDyIDVIFn7yCDwciVUgDSCeQkN6BxlryVMUSHhu35SKSsdhg8njfyDOif37FF6o0qzPU/NtymnmVdKuATfxyyw2PHuwKd9z/mXds4eLmFbLVpyS/vLmKEz4y345lJb4dVNt76xCB5QREM2TX8sT2mT07asJeCd+Vs3TnRFJTrpxXVtbB5vBzVCjeNIHzJuNmH168AQ41iLhLHfNj1GX4wuEzj1Av9GeXXXq5O1f72/RlWRuMPuimHJn2
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2018 14:46:00.0584 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1569b7f0-75e8-4074-6d0f-08d5fe06d36b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1611
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

