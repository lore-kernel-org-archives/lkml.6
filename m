Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBAFECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 078FB2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jp4zzjsf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 078FB2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbeIXQmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 12:42:55 -0400
Received: from mail-eopbgr50067.outbound.protection.outlook.com ([40.107.5.67]:14880
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726072AbeIXQmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 12:42:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYnsxzx8+u2/NB+qR8nsrdqebMlyvbM5dffhCsbk/Ow=;
 b=jp4zzjsfg1pHMruIg89wKS12diyqxvR3I4f8uVGJLPbhv0r4/sycElazXMYdjcf3Fv5LRZH6zvV0EvtANWzijcGi6rVigCVqPPOZwDg6nd+DSPw4kd0LQ/K6c+wTs2DQHoif2lr2SFk/7v0bwIY5VuPZj6iFNIfCkcKc6tESMPQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
Received: from fsr-ub1664-175.ea.freescale.net (95.76.156.53) by
 VI1PR04MB1616.eurprd04.prod.outlook.com (2a01:111:e400:596b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.22; Mon, 24 Sep
 2018 10:40:45 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Rob Herring <robh@kernel.org>
Cc:     linux-imx@nxp.com, Abel Vesa <abelvesa@linux.com>,
        Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-kernel@vger.kernel.org (open list),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE),
        linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK)
Subject: [PATCH v9 3/5] clk: imx: add SCCG PLL type
Date:   Mon, 24 Sep 2018 13:39:55 +0300
Message-Id: <1537785597-26499-4-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537785597-26499-1-git-send-email-abel.vesa@nxp.com>
References: <1537785597-26499-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: VI1PR0102CA0003.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::16) To VI1PR04MB1616.eurprd04.prod.outlook.com
 (2a01:111:e400:596b::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75e09263-e4b4-4891-6e0f-08d6220a2f98
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1616;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1616;3:POYG70WxJi9hNooNbaNPAJSox7vbd2a75KpFWjltadkPgGb/HcTg25Avs7/9rEbMU3zE/eouPzmVi9q03tTpCGqCzIl8u4bH6lV3KoOde/spOt0rnlRZJmO341JB6YC0lKTP2mXorvDldluc2UkX+he4sFA9GDh6BFVIrtYFe5AwyWtUiJKKAtGARFhuNd1ZmhnaWyzYNlfucCEx5JaIRQ7937xbQhDcOYtpJgk/yP6EZzRpXk2vlggMZ5YNLpvt;25:UJKKgkwTCEzV4kvoyiCKNGlPFraxinar0H/uQ7LkVeEWRfWavrx9LcJjK/PxEODKD17Bne6DUY/oYThXPdSIuLgtdyArQl+VV6xjIxwRwGooaxBHDx2Go1S10vU3Li/8eZv3AXGfxk9hh1PTULTNJeWIrLdB3GvUCBwgbZ+hxH7jrndM4XQNugVAwrE1/p2tHOoTnbpdmoDdH/+Yn5gAxNvm/38Ayj+r9xVMAofVksfCJOWrEX1PcPa4LuUUAqljyFaidDqOBMkQ65c3xzAMM0i6Zbcx+l4NuDhCDXQZ8lh5x0zfVtdnGL4HFpiUfooHsnH2hhkgFv3b8SgiNERb6w==;31:/IIUDV1XSwo5XzlFGAIcXdmjyex+FYt4uKGVAQpUy40K0EEhTS7vCrTginLcf0/AuzItt0hBPujBZXFm9cirF4VNdotyCAeq+B9CEcMZ34JKndqvQnxWqb8Yvwlv8+V0IvMR1hnbsyHN0VxAZLP8hqtxkdkFlImHphvgirNSkW8M6zh/ME9s7ONr9RopSGe98wY9b0Y2UfUKBi8mfpdMhKDi7C+IiOOicEj5gsbNIQQ=
X-MS-TrafficTypeDiagnostic: VI1PR04MB1616:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1616;20:iqxm1kE+LU4DtnrW9aS3I5SFGmnZ0ZqqkCKfDRWwEieeJyONZNTAvSqSvmiV8FVOedWoP+R+hO2pNfwvebFMIJak6vfD7bGZst1d3SQe/kEoP4mzO8WJ+BicqBe0C+8T/rc2VuR6tRLrGg3iMx8URqAla/Hzs5tYFGzyfjRkXNnBdTOUxZKe4j9Y25AtI1SCso+QpokG523XLMiJ2omp1elWb83P8ZzldeimQ7hHWyynthVVsDHidvx1y7hcJs7FctHdykSlq9WJ6lGjLkm37t0n1FiT9rSW9JXUyh2Kfq+t93KZ0tb9YzOQflwGRpe/fKdVisInnvr4hXVHLRdGXO/qkE25XoZY7H0eEDSMKsWfq/81JY+H1ioFeSYQDa5h1Nu4tkP+4EBJrw8uVMBPtUc8v8wVqCsQVitq8eIEwBrFIQsT4jzN4susg87OD7TFThA0sFgDf/e7lzYi6VUmJZJVzSPi6C8+ydGMwweS8iUnQPrKLJQDnbe3jRHj5wBk;4:ERfphyBELTIfI3gF09a2EiBvBjkIXTP2YVXyn+XRn/CCCyPwNx560Y/AdmPhdl+8HgWwIMGj2Eoh2QRr+2Xd6P1XRFGo9hck49eC6e8V8lZt1QK1yVTgzT/MsjPdDzfShR6YTBJej3+Ge7hqZb7BOZlUu8V+otL3hpMLW3kcrVvoHYoF9GtkSm14lfVi+6xzgdC0vQiLK26tonGqzZWvwGHnMO/TdIYbMDvgpYodHzdsfs9gw21cH0c/xOWD05qjCnSPA1udGy8fz7pxc522vbrSLhzbe3thdfm8sbxwCRXuwcz46qgjBjQXjuvdlIhZ
X-Microsoft-Antispam-PRVS: <VI1PR04MB1616C26B566C95FDDF38D680F6170@VI1PR04MB1616.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(10201501046)(3002001)(6055026)(149066)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051);SRVR:VI1PR04MB1616;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1616;
X-Forefront-PRVS: 0805EC9467
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(136003)(346002)(376002)(199004)(189003)(52116002)(51416003)(14444005)(48376002)(50466002)(36756003)(76176011)(53936002)(6506007)(478600001)(44832011)(4326008)(6486002)(6512007)(25786009)(26005)(186003)(16526019)(386003)(11346002)(446003)(486006)(476003)(2616005)(956004)(8936002)(50226002)(2906002)(68736007)(81156014)(7416002)(81166006)(8676002)(47776003)(66066001)(105586002)(6116002)(3846002)(305945005)(106356001)(97736004)(5660300001)(39060400002)(110136005)(6666003)(54906003)(316002)(86362001)(16586007)(217873002)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1616;H:fsr-ub1664-175.ea.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB1616;23:kEwY5ja1m7hJmbJNZXSUbEQAYjtvxN6MjxtOGevch?=
 =?us-ascii?Q?W7GIsWxSPehs1K8gFquJzLdyUzaQpSMFKgHtF90h23FJtsJFuxPdOoWdhpXt?=
 =?us-ascii?Q?FP9i4ZhqClHSQvhCtT4uIMnVBrb3Cl0j6470Em0QJLCxytQfZxoviiAKdRJ6?=
 =?us-ascii?Q?L1aax+/O+T5XMGkrHztY4mpGMZ7UkTGM5iHKSmjV07DtUwdOP0kiC+z/99Lt?=
 =?us-ascii?Q?DikXrrtg8YV9jRvv/6piflbso8y/2Ccj9rrvHBO14Nyass/RA61aUxo6GCkP?=
 =?us-ascii?Q?9YDwOGSFjc7zx9TfwwkaYa7xVNi/gRq5UTrV7H/ibOdrc1e1Vr+t8b2aS77a?=
 =?us-ascii?Q?5i+4UIuiAIk6pB89IjN0cCJZ+ZHn85dUwnBT8R5inOxBRAVEbsg6HOC8DW6O?=
 =?us-ascii?Q?uF/ZrcWG8q3xXCk7pX5jeXmZ2dKH54AlVA+LqTh58D9IREro4K0Bwhe6HV90?=
 =?us-ascii?Q?TLY75MQu5Owh1lIaeBo4ukgrt26ZhT35k4gXqJeGnmWoXxpWCtDJOaxlxWdz?=
 =?us-ascii?Q?YN3M2JLyPPcPYsBTatAyrIFmTRPeLItl/1xuwV4NnPzbTyRGXScpsGpQq6UE?=
 =?us-ascii?Q?e/2YnsM+bpzOFreK2ugaOftUE9tyBrV+Ob/nkYhTmENEPLGhs4sRlY6qG19W?=
 =?us-ascii?Q?eELil3kM/OFPjTclq8HIioGJhyPJ7k7GPINpfcIVOcqHdSU9xZsYsGr4UPHE?=
 =?us-ascii?Q?EK10EVeUJHPSSxMn1jQioFGzN4ojCnDyIehiUla7mKFBHEl8t+Cj25CZUiuT?=
 =?us-ascii?Q?IqLOvnjEPC5yzNfp9dkHFU616eGPwO7L2JWwQMavb0YSayqnAFopJBf/3/rd?=
 =?us-ascii?Q?NmmUOqZx/2AYNBNFs6uoVYVd/76P+QtZ3ethVSuxdY4Bj6rhMOYfRu4Oh2V5?=
 =?us-ascii?Q?w8ru+eRnTrkwsQabNw3Kis2Yoj0vMebW/80DaqNr72iJR5tObuAbk53ZvSCF?=
 =?us-ascii?Q?rRciA33MZFTusqHmqG+jd3RRNMQ2VAYvkUvCgwdUNLPuikkjaLO3dYulMQJW?=
 =?us-ascii?Q?40OO2islXMJqhM15Ma6/+lPAXmvdKVgb5Hmp7tHHIhbKrthpoz2oLOEY0IG2?=
 =?us-ascii?Q?YLpdBA2gYIWujm58jHpdAuGXwsChHDj9APX+kWHr7uuL3x0qIfnPFOQAhrqm?=
 =?us-ascii?Q?ezS+wy88gqAfRmrqNwJhWI+YRkHkkmlQT7kaofyT0Fw1YHGKaniYWKl6DEQB?=
 =?us-ascii?Q?PFJHNkhPZYZqFSDVu7EaSlw1FGNUxPym5MFGjkib6avbzy2fUiv6KGSG4v5T?=
 =?us-ascii?Q?Q4+asH8JCngMZb77vCHQTP46x5Et0ONYy4X4AfHRYifaMP/NhhKg0X6MZXgr?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: /YczlVRYNlxymX3UhIn2Rkc88X+PQF7cZCo0y1xppjtXCd6ME0FNNWPekEPPD/loLzBHbaSNWH7rtzRZgOvYY70BblkGN936whBvp3ocd43eGqw7pd6ZxC1S80S+CQgDhTfb8w2qfiffbr/Q4qx3lK7D4X1WIqYMyV8cUN5QvI96MFSe6WbU+zgGTK4xKG8mCMdPGa1Pk5qLGu8CBLEnRt6b3/X+Demp4duefh9WfH0e2B0OBntOwJNq+6Xc3z/VEqPKcIa2IDfaJwxfLuGMn8TgGgDid8yTUygDzesvFv1cxPCt2GogF2MlVtVbrLHWn2Dt9QO/heeCUe06Wo1kGw==
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1616;6:Sm7pB3CWUmFDx7Oon28J4U+TpO7T2wQ9y/I9mo4R2d83UtklWxTfsP2G8QEOZiOsAk27W+GegR2DEz0VwSEiCqhTFlR3OzV6K1opjwC87B9g5NmL4FU5Kj9i1LF56aSI90gTL9gkupvH2y9p6BpNMD2sLCpoaRjHsQSCT6o7dCDy9/Oh6iucl/AYKJayW4gAjxhoWu5uy8rrBvFPNT627n8xVBsiIZxReyKCneo8xzv8rQJnRo4midFGyEq/3Vu3wntTFswDepyPO1azzXeMqeqVcy6org8LJ1+M/nkXeH+574P70lZXsTx07MxnJQNC8darls1i8WbiVOpc2wg/3A7VlxiQsIZzf9oooGHOSXW0sTNSH3uoIgIN6eE89Z9f2Vwbdw3PcLdVq1gLn9gxTzSQe+T2tvmpnT5Y+HGilfB1H/ajPcU3SWEcr3+KwDsBgpDH9NoIbTl21KPliI9QmA==;5:QzHjkrDawKts2kxophpmpR4nVGJNKOp9KTGHadU9QI6TPmdb2QaLYlJ+ZTOVLwY5QcIc2Gyxm+9hxsp4LMeSA7bIK+GU91gY1qdqwVFK4RZE2DrmAKwvvPTOGq5bivB0CnXw5pBcgBvu62SlRLRFZzzeynGTg5Y5HjO+fg0CLCc=;7:x4r7hKKhcwWls3j8jCyHfUZZOTntpGOxgj/9tlnazNVkjo80/mxmRoXftVpj1Lbz4KAzmPZcFVLzQDoz1Q3Wj/xsQU4hV8S7U+wfug3xc1BrJdAwHBe87DeFxDhWWsFnqe2n8zu9XbnbwkBHMldwWLxVw+vENflOPf/g9Kith+oALcPoRKYP9JQG1lv44OBMWeuH9A5UB+h/OONR8NQagy3ygFdiR7VflG6/EHh6dC1aduXAFLddoEPfAtUXN62m
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2018 10:40:45.6024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75e09263-e4b4-4891-6e0f-08d6220a2f98
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1616
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
 drivers/clk/imx/clk-sccg-pll.c | 237 +++++++++++++++++++++++++++++++++++++++++
 drivers/clk/imx/clk.h          |   9 ++
 3 files changed, 248 insertions(+), 1 deletion(-)
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
index 0000000..a9837fa
--- /dev/null
+++ b/drivers/clk/imx/clk-sccg-pll.c
@@ -0,0 +1,237 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2018 NXP.
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/bitfield.h>
+
+#include "clk.h"
+
+/* PLL CFGs */
+#define PLL_CFG0		0x0
+#define PLL_CFG1		0x4
+#define PLL_CFG2		0x8
+
+#define PLL_DIVF1_MASK		GENMASK(18, 13)
+#define PLL_DIVF2_MASK		GENMASK(12, 7)
+#define PLL_DIVR1_MASK		GENMASK(27, 25)
+#define PLL_DIVR2_MASK		GENMASK(24, 19)
+#define PLL_REF_MASK		GENMASK(2, 0)
+
+#define PLL_LOCK_MASK		BIT(31)
+#define PLL_PD_MASK		BIT(7)
+
+#define OSC_25M			25000000
+#define OSC_27M			27000000
+
+#define PLL_SCCG_LOCK_TIMEOUT	70
+
+struct clk_sccg_pll {
+	struct clk_hw	hw;
+	void __iomem	*base;
+};
+
+#define to_clk_sccg_pll(_hw) container_of(_hw, struct clk_sccg_pll, hw)
+
+static int clk_pll_wait_lock(struct clk_sccg_pll *pll)
+{
+	u32 val;
+
+	return readl_poll_timeout(pll->base, val, val & PLL_LOCK_MASK, 0,
+					PLL_SCCG_LOCK_TIMEOUT);
+}
+
+static int clk_pll1_is_prepared(struct clk_hw *hw)
+{
+	struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
+	u32 val;
+
+	val = readl_relaxed(pll->base + PLL_CFG0);
+	return (val & PLL_PD_MASK) ? 0 : 1;
+}
+
+static unsigned long clk_pll1_recalc_rate(struct clk_hw *hw,
+					 unsigned long parent_rate)
+{
+	struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
+	u32 val, divf;
+
+	val = readl_relaxed(pll->base + PLL_CFG2);
+	divf = FIELD_GET(PLL_DIVF1_MASK, val);
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
+	val &= ~PLL_DIVF1_MASK;
+	val |= FIELD_PREP(PLL_DIVF1_MASK, divf - 1);
+	writel_relaxed(val, pll->base + PLL_CFG2);
+
+	return clk_pll_wait_lock(pll);
+}
+
+static int clk_pll1_prepare(struct clk_hw *hw)
+{
+	struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
+	u32 val;
+
+	val = readl_relaxed(pll->base + PLL_CFG0);
+	val &= ~PLL_PD_MASK;
+	writel_relaxed(val, pll->base + PLL_CFG0);
+
+	return clk_pll_wait_lock(pll);
+}
+
+static void clk_pll1_unprepare(struct clk_hw *hw)
+{
+	struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
+	u32 val;
+
+	val = readl_relaxed(pll->base + PLL_CFG0);
+	val |= PLL_PD_MASK;
+	writel_relaxed(val, pll->base + PLL_CFG0);
+
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
+	switch (FIELD_GET(PLL_REF_MASK, val)) {
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
+	divr1 = FIELD_GET(PLL_DIVR1_MASK, val);
+	divr2 = FIELD_GET(PLL_DIVR2_MASK, val);
+	divf1 = FIELD_GET(PLL_DIVF1_MASK, val);
+	divf2 = FIELD_GET(PLL_DIVF2_MASK, val);
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
+	val &= ~PLL_DIVF2_MASK;
+	val |= FIELD_PREP(PLL_DIVF2_MASK, divf - 1);
+	writel_relaxed(val, pll->base + PLL_CFG2);
+
+	return clk_pll_wait_lock(pll);
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
+	default:
+		kfree(pll);
+		return ERR_PTR(-EINVAL);
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

