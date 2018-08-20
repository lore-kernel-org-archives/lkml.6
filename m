Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E435C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 07:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E218421536
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 07:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ALsg+OPI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E218421536
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbeHTKbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 06:31:06 -0400
Received: from mail-eopbgr00087.outbound.protection.outlook.com ([40.107.0.87]:40384
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726030AbeHTKbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 06:31:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXf7qO38vaYskqGDfbVulsm2QujivvVj2Ne8jKVWVAk=;
 b=ALsg+OPI8KZVCdHARLHKnBPA1GD2bpOAj+HkmZ2IVV5zq9olZ++G+0ez1Tewo0+QRxv6YSXDlLvOUCpH56n5Oqsup8Lrk7VCTU/0y3nPLvSpb8uT6HU/NWqcAVWDSOAcGjTjORQOvpAF5NTEdImRuiIslB42VWn+SUz5pYTUtes=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
Received: from fsr-ub1664-175.ea.freescale.net (95.76.156.53) by
 DB5PR04MB1608.eurprd04.prod.outlook.com (2a01:111:e400:5994::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.22; Mon, 20 Aug
 2018 07:16:25 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>
Cc:     linux-clk@vger.kernel.org, linux-imx@nxp.com,
        Shawn Guo <shawnguo@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [RESEND v5 3/5] clk: imx: add SCCG PLL type
Date:   Mon, 20 Aug 2018 10:16:05 +0300
Message-Id: <1534749367-31085-4-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534749367-31085-1-git-send-email-abel.vesa@nxp.com>
References: <1534749367-31085-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: HE1P190CA0037.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::26)
 To DB5PR04MB1608.eurprd04.prod.outlook.com (2a01:111:e400:5994::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cfd836bb-31c1-418f-64cf-08d6066cd864
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1608;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1608;3:JAMvf5vHDp7GVWzBLY/lH+bHoVCj5LM9Ka60JjMqe5LbaBXVjws2rMnr8h6khqv4r7PJOTvQemSSk8vHhc2vQJ/J1lKZVLxurMUm/IfE31oWm8L59uNb/ax1bD/RfAgFtdxZ7VcrlR9KRfxx60UoPjIxMJxFaFpcavLjUIuJ7mQDlX+jnK8Tv+EeBYqEtnPRFIlkHPnPgFNr6eObyqND1qTI4QX+V7y1caLFNqCun1DQNkRl+F9XGpEm9D/5EE4D;25:eT0ErAmcrwAlPfbjqB4ETCB+Ddc/q3QPOdtdRI1S+iXgdmQdt4+dtxytV30x0ZQchvoU2wq1lNBLJJ5gIIPXCHSyK/eZMu8/JRPlzJwm0xg3RkOpsEGvMAYuyAkK1dZ9yXGLBDep7/9sWwnpdoayLXSATtevgVqW4wOfBN04CRkHbalBBnRiuLhFOnd+ld3txttEmhPqStkDTt/uXINBUIFW15HMZtAVKoXOZSLZlJQH66MSXFDtbv6Um7GLouxFIPM3XFLxQloyOB5kqmjkc1qHEvV535PN0o1CidiwkaRwK+APPlfWya9mZuUxH8JDUDJ27Vgm8d3pvaEvBigWsw==;31:CeXJVhPbCJJRPzHPSVPndVS+IgO5mLSjX0PyzatxDOMj3m//3j8qNjI8KbsElWwkJT9aPvqJ94T9AbYoBC6HAO+gWUxyBBynZMudwlWNpp9v/hmrJkZbgvTjV9ZukBfxupz7UpicYyARTEKYkJdOxHVfLwzjvMrn0JENOBbz/edNgHtX4wE5gyKcDKXo1MYVPOHliA3eLgo65oIRCwktmhCqmF5YtxnzsrjBAPDvBKM=
X-MS-TrafficTypeDiagnostic: DB5PR04MB1608:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1608;20:OJ2g1xS+3y03gZFNRuC1smaoiDg3n346oM5x98Xa7Oexk/70G4xa7zHqq7ycNakQ3gmQFeuK/UHM07reIAvDmtTBfwS+GYQEpv+d3Ixk058Q5QowZ3L7y4jVF7VvujtYlErxAfpBVIuI46CxVf37ORIt8tX5vdFLdLWLy1pcgaFqrL3GV99Cgd7jjlpryMND41GC3KwOJaAYCjJ/nJcMqn831jbEKZtr//V395coE7CpszX+CK9QQitiZbl422tUV82ZnG76oE868k2RBt4Ig3NbramWTIlQ0dxBu6hcDWzgCz2nBRYiOJcUBYb82BNFIAPCnu0WZfFjb3qHuMhfee/awUKgk2I44CTUznAlJLXTAm8OUPQNV3/IOPwh+vtX2GPKTK6n8go8aZRg9BItD8Fr4DiqK42AdNmOKPKCR8JzucXR7P46W61RItfYfP8gykalt/tYFrivQZb3zVrxkZQg9pOEsz1YtGwwuzqNhsiWGa7ewwLJNm6s1B3/fVgQ;4:SMm9PRFwZzcXzc7wRi7ie1X/m+59MzAlloWgg35xNKEe9PT8Yv4f1LN1JeHO20qe07I/u6I4Le+azwn7fJnz8IYjwcXe5/zh6lqVsIN4HJhrHgJ40CvNLKdW+lll8LKBiHdQlmBmmovwVlwmsyvrLjXiBGRZpUINLXpY2TYGaFwWqiwMhpvb8dynKtXzDdHyrdYvru2efywOD/jZibHSEHa9uofFwFcRFwWmnMdrRbfzay6ChL2+AqqyqHssPBTFCgrONyMMBOw4XuADX4LUhPyj2Ezarh0lNkhrbRQe0nUpyUnwcVThIl+p3l2eG8dN
X-Microsoft-Antispam-PRVS: <DB5PR04MB1608B20F17DE75C53B887E1BF6320@DB5PR04MB1608.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699016);SRVR:DB5PR04MB1608;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1608;
X-Forefront-PRVS: 0770F75EA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(366004)(346002)(39860400002)(189003)(199004)(5660300001)(7416002)(50466002)(6636002)(6666003)(305945005)(217873002)(6486002)(14444005)(48376002)(4326008)(25786009)(86362001)(51416003)(66066001)(81156014)(81166006)(316002)(76176011)(7736002)(47776003)(44832011)(16586007)(110136005)(52116002)(54906003)(8676002)(16526019)(478600001)(386003)(186003)(6506007)(6116002)(97736004)(106356001)(68736007)(53936002)(105586002)(3846002)(2906002)(36756003)(8936002)(50226002)(446003)(6512007)(2616005)(476003)(486006)(26005)(11346002)(956004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1608;H:fsr-ub1664-175.ea.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR04MB1608;23:eXa5PKFErQUQ6WnxTZqWdQM6rEr2eL0huUHzqtwjQ?=
 =?us-ascii?Q?27XPdOIn6U8pPLBzfEogPB3OjChAEvFlX1IHlhmbLId5ZfP6AehNm9TAz3b7?=
 =?us-ascii?Q?bAQyl5hx+gY5WIc2MKCcwhiRw8RKF7YvW9+CPE9zitWXepuNDmNaASCGlvg6?=
 =?us-ascii?Q?xgau6UeVavOqTKvzrhLr3kWrrG91kaRjZu/htLpI9cEFvE25ajysGrGWRJSs?=
 =?us-ascii?Q?KLU6jKXYJlA9r6F/RxVZpttk3vZ0HsJfZIUBWfhY4g1T4uYgY8NHdl3KD5xI?=
 =?us-ascii?Q?GcWLLXt5mdEuOjZg31bXQMmQerpFZmp0B5nZ30rT77WB3qkAp8nMuzYm9T9L?=
 =?us-ascii?Q?B2nrRLKWtn9ZCkp8cj7NloNoK8FHfOvKLo55F9hrGVNVrkkwyPhRF0iwbNJH?=
 =?us-ascii?Q?GnpFDc+LAC9D0K5AH3oureOCvAq4CeG2xj2JE2Ua1chFRNrAnlqd1ALM10y7?=
 =?us-ascii?Q?Aitjyy7xDaP600Fh8PSgs8sicABW+5tD2uadf4NW/WWchUeskJYLDVprMPAE?=
 =?us-ascii?Q?JiPEpFa6R6/CtNIJaZF3g9wHhlYIC5qK31WdzMzcgjvHr6EwoWJKcUUA+zK+?=
 =?us-ascii?Q?ahsLbrBPbZ7QUyB2XUTFD7RsJldWlvBSqZA75escH1z3p2WTn4hnB0VZEtRs?=
 =?us-ascii?Q?0kdq2bHYcVqUZtt+pg3j3KjLGM9NQZFnbW/x+gpDccAgwj93+0BOVHtKsddx?=
 =?us-ascii?Q?NawFx3DvRuQ0Kxgp5sMtitawvB8dPBPhe4OY/bOPDVmraY20mEr2uoxwCah8?=
 =?us-ascii?Q?kfsIlKO/jeEBk3Z0UYgg03OhiEJpCsu+UUoezM1NbdgLa1fu83WZnTJom7h2?=
 =?us-ascii?Q?5ui4/YBxiNa6VVliw43MW/1UuYdoHjRkqHGCaQO3hWqpDO5tlAMAlqCuEbSz?=
 =?us-ascii?Q?Igzm0cuNe38CjSut8duhHc19+t3CXXML04EBng+qNEfs32IXqAjNHeq0CeNp?=
 =?us-ascii?Q?DOrN3aTZMJ2JuQUMm+2SfZY8vsXWIiqMPHwJCahOWen+Zlr21ZEerZoZPoO8?=
 =?us-ascii?Q?yP+nouxUxDetQs+hKcU3oO920NIitkValKv53XcDYSEw8opYcZmCDWWTLmzA?=
 =?us-ascii?Q?Y52EMlJXcv32zByY+CMPfpoMn3WpUB7sprEs9OXxiGu+BxVB+Eay2qf0gE5o?=
 =?us-ascii?Q?5hGvdltNik5GCVIqiQAk6BSU/HKjqp+devw9nbq1A9UgtuPElZ5+JlkHOmZT?=
 =?us-ascii?Q?RxtFQPmH0fX/fgQMKVEuVOX/87agmlgIL/uegwqo2dOf5B0iHyjTUlmK9yl1?=
 =?us-ascii?Q?zpIwytI1YXt0A/aSpa85Afr/gS4tfOi0XeIN3yBgpUK/BTfoiQe1rwpTURuq?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: em0txJULkMdxKMVOpOhiemLUUaFVWgoNuDHeTooOvwKkxFaPAF5KDV5//8dxpNPuJyc94830UsC1x68E96qlxkDysiUcKUYCcISHEXzhmCqN0ahWQXbYaD3JM2nuTI4dUHZzU4XHaCrGfYLvQXtYcQaFcwkNDAuA62Efk2rMzQMXL1GvAoiaivH3Yzu/lmS0VZBTK0bQ4BNV9m1zwyKQIbPuzCXjqR36zqfZ4gdmTymYHlTXXKOEs+JBjbmU/OgYRwPTQfJc2X/hyUxCc4t+PxAGd/fmurt6oLpNxs+hF04PIWMICdNGW+Xi7KurkpW7S39qq9ebN/di5k18Cr6o8Q1aw8xh0MMU5TRuAnZy8MQ=
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1608;6:9aLxtuUIT4ZqHtwnRBvwsBIbg/DN3j93IovjMfsOkgt6mKpQp8uBkOegvan2mxxdD/w3OxXRh1yLYZ2o3oTjs/J97Bzn7Xsu1X9oCUXZYV7KVCapvIEcBBeAVlNnMUrXenjKUbciQJ4hpq2zl4T7plodyPYf1TkXgNIb4+jQm0DEApXGuqQ2dzKa0JY+lxJsjWEqdfBIzbvkuHdORPpH09iV4M76E2zhkBlAj8yxLX8k0Ttmu98UKBy9FAM84kNbTO6JzxE/4P+CRkuQ1oBsM8grtI60kHErAYOnXQAuirV7vrH5ljFionlMEe0Q1IwTbfhAufgxIoQ/dTefrEBQed6ecqTEonocNk8N75CHZ8Iz4Mke8aTr8yRmQndXHBUHbYYC5CaZ+T9utc2fVseEGJJzCxa7TYOJ5mt0akN+lvRBknp0rIT0/AlN3usSgGKDopOMOb56T1SGwmBsbSjZQA==;5:zk/Qr8af3pFCvwuGHX+lxlaNAbCf4w6tvv2hTvgwnAxjgy5JFZHbVXCBHZcYXuKcTWBQXJMbLvDnnuLWhciHziV8sVSGME58+aCJPLGG10gYvg48QK01h4MEBoDKM5TAxqntVtv/xVDj2GrXphAfnVrR5LREMY5GN5YGCO+x57g=;7:k4MSkNqZjGA2k4W2W3QfzT5OU1VTTmN17zqMi5RQ/sYqY0uonuqM5yFAz8c722Tlw5khyPgrjJrkQdcSXTOZ4NkLZKhC9xAepXg2UjYcDgg2pBpP6iKvt8wo9oLYIXL32pe2Ehw5huM5BWjZ/A2ygYqEGCSYktAu3mifsa85LeoJ/uqjfKt1vt9kjINft3H0mIoRU3vLQvdsGpF1J5xpwTrH8bU1HZDWz1XXdEm6cCGWRmmSZuJLmJ3MACnkhqbe
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2018 07:16:25.7445
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfd836bb-31c1-418f-64cf-08d6066cd864
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1608
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

