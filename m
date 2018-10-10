Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F3FC43610
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BB82214FE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TbtugBtK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BB82214FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbeJJPIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 11:08:09 -0400
Received: from mail-he1eur01on0049.outbound.protection.outlook.com ([104.47.0.49]:18219
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726022AbeJJPII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 11:08:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8xN6ELDnhwEuL84Wt4OzFMqBpwn9sd+H1S5qJOsR4s=;
 b=TbtugBtKIjoVtsUKlVs+5wIOJX/tyd/JzwaJJzc4moR6bOLJGAnmmaceHaCZPw/j0C4WZ7fdJ4CB558/2QmfgDVCxMqlbV1YX+1NTaWQYwXHHnIbdWXbZRDP7l85jpzHgClq00aCS8ksR//8HGxCHt8ubb4sAkr/wHrCdW3zt4A=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
Received: from fsr-ub1664-175.ro-buh02.nxp.com (95.76.156.53) by
 AM4PR04MB1601.eurprd04.prod.outlook.com (2a01:111:e400:59e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1207.27; Wed, 10 Oct
 2018 07:47:00 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v11 2/5] clk: imx: add fractional PLL output clock
Date:   Wed, 10 Oct 2018 10:45:17 +0300
Message-Id: <1539157520-25081-3-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539157520-25081-1-git-send-email-abel.vesa@nxp.com>
References: <1539157520-25081-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: CWXP265CA0044.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:2d::32) To AM4PR04MB1601.eurprd04.prod.outlook.com
 (2a01:111:e400:59e5::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb3b3775-4a4b-4bcb-92bc-08d62e8490a1
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM4PR04MB1601;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB1601;3:kqsPZe9xM4yF2uPZMuPlUFuAyUWiDvvK6W7YgqAOXFg3ZpZ/lgcjulY7YenVRCWmI4/ua08Fa3iWzw4e8XuQPVaBU+vm9H8tzyw/+gsl3hcSc1EqNlCXwu3ph/bW4Oe2YrbtczkFi1xDX/XW6VCT5YL9J5t8z77MrDRnFU+G2kCd9B3qVd/qtoM5VBTHRk5bS+iUtcKFDyPLJbPNIxcnqmPOXQ2bqon89BsHuGWlwj1vRKfLhAj3yscnAA+AQFt+;25:AlhFEu5yZlK2ZemDwG2fG5KMuib7hO2iIydCViq+BAuKtEvpi2FGCGbZ7VjQdAw/RlUvw2yZ3KYYoIBPVkjPkKf3WoXX3VCfbyvMMIzjNtlALTIbfFFQBAsbBPlztnRf0hfGG24on0lvB3l3Vaw8mP705FcQZ1DmdWiIc9vbidFBw93VT71N251j9hJRhHQJ/IdB+wKqGtXWYPDk0pR7sz8z3QhogzA5mLVZGPRVLVM6lTBFZ1OCDwG2YFzW+Pg8UmbWKZTg8x1Z4F5Oi84Bw1X8T2sRsigHs2sMQPJ68S94Lbt+sNPR7X3yURn8CMwOAnDaxdz2m1Vy2Fhle14JNt39h77LkMcofC0bGzssQKE=;31:FSMnPRAMCeSrw9o2D4G9tF8v1PEL2Ar2Wbv93gJ5gPIx8egdydDNPju3gU6gFfPZxUCFWuPBcczZ8ZvE2C8xYbOOJ7QHSe5c7gm4zeclQxJQARlSLlE+ktSy36PvleXHlsFhIC/Doooe5rWkxf8kc3+yyRnn6sDANh0vxMBrVXIgMJIBXqODFVTZdxwl9IwJjK6VSGIuyvLSrYPEz7qlX3NrOjev78O848iFndYc7eQ=
X-MS-TrafficTypeDiagnostic: AM4PR04MB1601:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB1601;20:qRscjiFMK+zIKPu/mAKeRoGjnQhu4iF13y9BTv++xdVj1ZjYPZr90tOkllLCSRd+oZj0OV1+E3aVlFNqDCyZHpqfeiIb4TicTX3ihWX6eoZ8U3ZNDTYDrO5cO/sR8bDhdKSljF+aF3Rg5toD54f1ZZIp27MZnMYnJUD0QkS46ba3twhnXDw4mL3KHWuy8eoqEYDQnj6azUVJiuZPtH4gkHSSfXBiWjPSokZycgGEkwrkDPBnSkAhk8l0VgA7XE+WOYOHV9aPyOUEaUCUU6GQTqJUjxRZ5by4uUlqkp4fQeTa4DBYtxFW4Sz8xq2wTA7uddC75V9AJFBA8WSTLOs3roDHCZ2gsM3DZGs8bktpTM5sreYAnKXAhRG67SH7ykkB3b6wiKdzQND1p2l8xMJi8rYLqyZOzPpuzKUMRpRZN6Nqx1goSU84yeXTNCDee52GsT59E9KALPkAY7G3Vkr74vJVNcJZGaoNqbC5KajYZRYVRzm0S4ilaYfRoCicfli+;4:KqbIxF5t1+97a0V5msybhATqEiyREpBnrgBGpDFxdRop3s+aEcUS26MLhAMHSEd86epPVn6pxiHiBfMEubvCmsF5N7IZdzhFNo3kWHAYs9r0dgWlIwGO7dGIvAtCJFFvRqG/trQ4H3g40/pbl377Gi7UTjhSIZ2y3bfzWMhn1opOU85xR3M+2dPEmaGkjo+My2ke2WcrO03ICggi3SYyHP++E2yHvxVcQAt32p5oV5j2L1sNzXOl/azEHHbyV1T+lVuIFSN/LbxQdwkcL0lKMHGLXK4mXC6gQzkSvIz2FNC4Xk+cg96vGR+ZDrktCPnf
X-Microsoft-Antispam-PRVS: <AM4PR04MB16017AE01392555AAFFBB8C5F6E00@AM4PR04MB1601.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:AM4PR04MB1601;BCL:0;PCL:0;RULEID:;SRVR:AM4PR04MB1601;
X-Forefront-PRVS: 08213D42D3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(346002)(396003)(376002)(189003)(199004)(7696005)(51416003)(52116002)(48376002)(4326008)(6486002)(76176011)(105586002)(50466002)(25786009)(16586007)(478600001)(11346002)(86362001)(186003)(386003)(486006)(16526019)(44832011)(97736004)(26005)(14444005)(106356001)(446003)(68736007)(2616005)(2906002)(956004)(476003)(47776003)(7416002)(50226002)(66066001)(7736002)(53936002)(81166006)(81156014)(8676002)(110136005)(36756003)(54906003)(316002)(6636002)(6666003)(3846002)(305945005)(8936002)(5660300001)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR04MB1601;H:fsr-ub1664-175.ro-buh02.nxp.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR04MB1601;23:cm6FkPtOHQczlvU0Usxg82tWeuj+XPy5bqBxKguP/?=
 =?us-ascii?Q?8au/mIEM7swg+KK/UnITa87jkV9PDovofZ20Nxj0nb7a7IZTQWt2zHp+YfeH?=
 =?us-ascii?Q?/ETGhLVzKeJ6TFEakY9BIcW5WuC9aKH4sdWctbJapF6ywlDjWbyox9zt6rk/?=
 =?us-ascii?Q?ElVNOO3NZZV2H+OabXccTlgnI+WRQ4sGgTB+zMRGRCY+zoOmKjFUW/j9b/pF?=
 =?us-ascii?Q?cqsOOPE9uuoGaa9fWiGvOaHEVybHc+zHuw6cTFp5J4ufNXNReYGeWkY0XnpX?=
 =?us-ascii?Q?Dp78squpsQAthMZyVxSJveq/0yEmokYaU3jTvcK8dyMBnO2cK/PmttaUH6s5?=
 =?us-ascii?Q?Z3mtu18yYNxRXq2VRTiheSmV73F3TcBF8njowfACD86YY2gBw9RKiuhV3Rc/?=
 =?us-ascii?Q?poYVagVJrst4ANLgPxsHAw5Mrl9tr2YlGqaRCYke5V3341QoFcBrfBYQnvO3?=
 =?us-ascii?Q?CQ54U3u+9e+oos55v7hQvUP7gh1+00odwpt0N6v/j3YNyQfSCVGLYzfvBcw2?=
 =?us-ascii?Q?R4QGrTq5IQTX9lOZxCfB4NEeuOAQnbtx3R2TKclWEsASoQeRs1bjfxvHnKEs?=
 =?us-ascii?Q?D2HfPpLsyF4Nuha+0u2sZQzFxFiWrNvSHi9x1HK2wmaODfwmVuO7RqnP9Oi6?=
 =?us-ascii?Q?Xr75JY0brWmi40T8EjpoMy4LwS2Jy1uQUbZMWv731FI+BDUdYNIuOrOgsZnM?=
 =?us-ascii?Q?lQgWpsWw4z5jghLH8wP9dGNQvJ2eq8G/4kt4eGah1/IBFh07r9JEEQAEZBh+?=
 =?us-ascii?Q?ANDO7y6o0tx/H+484cD2p7MUFrNPPD8AakEeRw0qruejXAd37h6pb6nkUqhI?=
 =?us-ascii?Q?+qoOKlRnK4zMujng5ZRWzM6AeZushUvfSK9uI3afZ6GEphpdeAhVDBMcZumH?=
 =?us-ascii?Q?UbNuhUo4KZ9W3BQ3a5vp5jtGU5dqXbFg1okfalAEXiuHgIBmPuuyjMMwBm91?=
 =?us-ascii?Q?kCNvL47mDis013H+FFEt9biwcx2tuXSdyPoAMWBTdmtDNDpNtgjjpEiNbGg1?=
 =?us-ascii?Q?bAQGLM02tM3IeX/G01/9zFGqSC2xqkmh36m/aerysqPBS3tMBppP87cOGumj?=
 =?us-ascii?Q?CpDpWtgNkem40/E5cFoiq7Is24aAKAyTOVbM1xymc8jegeK6TgvMQT9Odifl?=
 =?us-ascii?Q?G4lnMsrGk2P00vpey3hcWaWAEDBJSUvrzGFqH3VhDGFfTDgTbCQtZyYweH6o?=
 =?us-ascii?Q?Ca77jAia40S1V64aj5koWmZHJXnDo74ocWv3xIJTAsMk0t17ITaF9xBCTdPf?=
 =?us-ascii?Q?ndIVEatVZv2eavZ5fE=3D?=
X-Microsoft-Antispam-Message-Info: UyIHuhdWkR7b26HcVBa+qEnzLillu52IczsSK/86SQQyM421y5YQ4Y3oK3cx7CIqXQvn96+PJ6ysR8xI+MLEHz6gsgGDkrrtH7kPnRZ+Hiq3fe/iv3+zdCGzdzHuquoWKLX2rqFvtzg/rS98dW/1QJpWZ0aWz73HRP0AM3L+uSCh1BJeXP5MQyPieE+y8x628BBXF6+y5cOHksrm6OSjUMq7uMnD80zvC+HHu8I35uM2jUv6bYZGsu0nHaWq969cNiIsrMKk8hiBUk3xwkRyF8Ffgp72ORlZPPcWy525to4OmEG3enPUr5cPMyNTYaEk/g6CPG1lm4wgGQP1R7yUJGepsKtvebe5x5iwZ+iad4c=
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB1601;6:D69fe0luVNKpvlQuCetKsVLTgo0+ZZ7uxSejx4o3JtFXI1Z2zdNKSIadhQ4nnfeHnJZbfTB5T5UnDY1oFP4X8G9BmkNfI3EZ4PO6CwctQk+jB1cmgO8P6wWZRbJLik0A4EBgLGC3TcyR+rKFNmFVDt2NPS/8WOpU/iW21F5GA2LRQdT3XXwJYcJtFYUrplgV+InnXK/liZ/LuNn+1LvTKlakhxW1sxZbSpPMSHxf36gUkZU8n13rSbObArg+QweIM3PIGGtV/xCfJchDFHevcUpNJGIIQ1NsfE5tww+V0VUtUgavI1bma4fbvdH02FY6tMuDAjyxbpHGStu5EBqLexX6oSd7+bsEhJaPSq7dK9z21A2EjTnPgyIEwHsUKrEYLTcPJnjieHibHJV//W7l19/99kUL7h5pPy1Ecr2y1/mbb6ZJPJLTFMku8o7nAIGUXVrY+QWhHOJY7O1Qtl+tZQ==;5:dMxmkEDIU2zUDgsKv0ZUCbMb1E8FekTxfmv1HDRA7/xzzMEKiZfvmGbpHgFoCQNe7VHn/oLBCbcPz9dCsk8oEglKelQGTBhzYypDpVyv+5FA5nuvG6Syo6l2ngq8rriZVXIzcrYKBkdbyG6xl5KpBDLM18/HGmu6ID4yCVqWuiU=;7:nvZwIG56KKj2+xAvznNQCNMgC1TV/NfgljPXuzc7hIwr5D9FxsjxKqagZYNjdj7TbBXXusZHWyptaYtL4nbB1ZM0YaMZcXp2ciu7ZBHtOUVA7jrNNvecafiCo4/bdtGF/gaY4mBedFJvuKn85jKos/C1Qrh4Eiyf7HLmwVSEFz4yHRCViCMeUhDTbY8Eso7GHDxPItGZC4NdSDJhjf441vI/Pomc2DuO6BrEHgBi7reQ96xwMS/lQsdd0lXgrBHw
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2018 07:47:00.5063
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb3b3775-4a4b-4bcb-92bc-08d62e8490a1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR04MB1601
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

This is a new clock type introduced on i.MX8.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/clk/imx/Makefile       |   1 +
 drivers/clk/imx/clk-frac-pll.c | 215 +++++++++++++++++++++++++++++++++++++++++
 drivers/clk/imx/clk.h          |   3 +
 3 files changed, 219 insertions(+)
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
index 0000000..030df76
--- /dev/null
+++ b/drivers/clk/imx/clk-frac-pll.c
@@ -0,0 +1,215 @@
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
+#include <linux/bitfield.h>
+
+#include "clk.h"
+
+#define PLL_CFG0		0x0
+#define PLL_CFG1		0x4
+
+#define PLL_LOCK_STATUS		BIT(31)
+#define PLL_PD_MASK		BIT(19)
+#define PLL_BYPASS_MASK		BIT(14)
+#define PLL_NEWDIV_VAL		BIT(12)
+#define PLL_NEWDIV_ACK		BIT(11)
+#define PLL_FRAC_DIV_MASK	GENMASK(30, 7)
+#define PLL_INT_DIV_MASK	GENMASK(6, 0)
+#define PLL_OUTPUT_DIV_MASK	GENMASK(4, 0)
+#define PLL_FRAC_DENOM		0x1000000
+
+#define PLL_FRAC_LOCK_TIMEOUT	10000
+#define PLL_FRAC_ACK_TIMEOUT	500000
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
+	u32 val;
+
+	return readl_poll_timeout(pll->base, val, val & PLL_LOCK_STATUS, 0,
+					PLL_FRAC_LOCK_TIMEOUT);
+}
+
+static int clk_wait_ack(struct clk_frac_pll *pll)
+{
+	u32 val;
+
+	/* return directly if the pll is in powerdown or in bypass */
+	if (readl_relaxed(pll->base) & (PLL_PD_MASK | PLL_BYPASS_MASK))
+		return 0;
+
+	/* Wait for the pll's divfi and divff to be reloaded */
+	return readl_poll_timeout(pll->base, val, val & PLL_NEWDIV_ACK, 0,
+					PLL_FRAC_ACK_TIMEOUT);
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
+	divff = FIELD_GET(PLL_FRAC_DIV_MASK, val);
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
+	val &= ~(PLL_FRAC_DIV_MASK | PLL_INT_DIV_MASK);
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

