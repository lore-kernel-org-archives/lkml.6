Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0065BECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 945D42075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="P5U//Qri"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 945D42075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731652AbeGROSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:18:14 -0400
Received: from mail-eopbgr10066.outbound.protection.outlook.com ([40.107.1.66]:37232
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731087AbeGROSN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJHraVc7TgkicXWrG3dGT33cfsTVvQE0wzfDAXDsqmg=;
 b=P5U//QriMl/st5nbYMfShnpp0U7xtzjW0f/JxkG+Q82pglPDxTAbKT1ppkJ+lWU3Q1tp0PxdFPo4atCwbe4jXR1rIVS0oJ0vAcOG9Koa2NnLEGW1GDt2uEDzB/Otr5EjQxSGbMbJiXGM27UJwL7A9L6o3H6ODpXJrLlj1KGeO98=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
Received: from b29396-OptiPlex-7040.ap.freescale.net (119.31.174.66) by
 DB7PR04MB4219.eurprd04.prod.outlook.com (2603:10a6:5:27::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.19; Wed, 18 Jul 2018 13:40:06 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        Anson.Huang@nxp.com, ping.bai@nxp.com, linux-imx@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH V4 4/9] clk: imx: add pfdv2 support
Date:   Wed, 18 Jul 2018 21:36:58 +0800
Message-Id: <1531921023-18497-5-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531921023-18497-1-git-send-email-aisheng.dong@nxp.com>
References: <1531921023-18497-1-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0090.apcprd03.prod.outlook.com
 (2603:1096:203:72::30) To DB7PR04MB4219.eurprd04.prod.outlook.com
 (2603:10a6:5:27::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c65cb6b-aeb4-4f15-c041-08d5ecb3fb84
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4219;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4219;3:Cxc3yyppATHbtrjbFQ+K33YtTjt2CybfVc5CIzNhcyErQeqAVXgAIFkB+r5OakV0par8AtntpB2PHSizq2lUPbfvrasNnV753GOpPJ2uF9nfrM/91Cg7Lubb0qRZnLqXyB/hfCzg4lutHzk1E+iZ2AqI1l8LbGmMXqtxoKgcgY6Iga3rJqVpehIUMiaHrNPgfg41wfmmsTnxIbjfF9Lt43gpL82evhutXYWpTRz8td/XpxS+e18/LS2WcTkNgDbG;25:8QkO8zOitH7PhOf80sRo2qBEMCAobKjleNxPUh734TA7CO35qrbx3RVRIqFhKKpJKBN5NE0A4Sx+DOuNoHWXlCnXcA/Lw5AVR98+zj5wDAIS/Zby1et05SEo0M7Oe26yisKQ307Ts4mHcL0R8BnFnTUZAipTaHGIZ0qC4YwVOqZaMfTc5G/BcE+UaP1aRRnTaARmij6pGmr1oXTDJcNJ+NIXE7EyqpFwE8qZwNAbohPjisjImuSZt3uVi4avBGRH335wyQBJBJcTZXjJyxShou/VQ8s9ylET3yxUwESXx+NkEs74FemNmKxV8QyF3kHllv/escugsF0H6aO/CFZuNA==;31:MLBM2SeuXcFNjJ+bF19kt+YyvQLRCamGutjfzztHbSHiqykVFMeA9M2VWsmY1PO4qJcFA/c9ME6b65Ca+cVtVV8LtNl5ylP6Ge2Hqkra1ugbbUf9BkExFtlu0ACwxhOqzniXSEkqaF/t3OCqTx+cAcMDHujys7UFtaUVOqwTXIoa8MhF7hIUjcG1Gh2jiNLt/ybevkUaVPRx6gkywVUpXQTv2vY8Xd9gHYgvyUtD2x0=
X-MS-TrafficTypeDiagnostic: DB7PR04MB4219:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4219;20:3LuXhYD/ZVm1ivcar06wyPiZlFEkm8zVr/hft9qVaRMAtI048zTEkvg+aDgIBVsV/a0eFYLGsCmZfaI1UAMqlboD8kyumQ2Z92lV5m70s7oGpz6hmTC/7euzJLlQfjGTnvZV2vQMk1d9k+7fVpCV52ZUquBWlnx95kxGV11FFuxUy/4uiDHH6bp/au7rrsewDSr8CAlss3csBcS00S+SpkvTVMtVJ3T72TexVSrahCCTAZ8+NceNvUgxFog/8F1Py18OalX5I8uYRppwfkBOL7GYz+ZVOGOMrzmIbCmIQJrX6HSZ9Nb/sGorWElf5xss3yK6nTsXjC0bJ0lGXUetdQBtcWoDl5oI44OpwLThLTV7O4NYTpWNq8xQb4TEnDweHzMFGtYfSOtIv/gHb1197t2zwn4dbVw3CEOr0wdISmBDsOJUwAy/6s+UPL+PVJs+O2HdnpcJL75T8JV8Rh8XzyXnYInykhf4dzFhWS9M5pTJoWrfyx6diC7t1WLL4k4a;4:HT+sOWtrEsYe+TURUCe+lw7YfdcNWvxu0dSOkU/Il9B52H/s1g6tJhb8YYKEEDWBklTQRNJAZdp/kHqhYJcx7FpJwehjgbdxT8fnPmB2bWZ2BmZPJFxAf4wAjh/AY4GggpLDLc/cVLoeaVt8UW5CbqaQOmTm98ACxJhik7DM5V4Ip1wu9SHd6dTM0118j2B+w+aEfoJ9tDQvp8Hx7JkiRHRFIc5iNoUVWrpmr/UCqYHieiunhzOQLWgulO0botenNqnll8v2mkGT2hZwL25BTyxitoFZGzp+Ydk8HLMaR8wKTuLyxC1UHxAYOBPHJW/U
X-Microsoft-Antispam-PRVS: <DB7PR04MB42197B29558DFBECE1C5A23680530@DB7PR04MB4219.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DB7PR04MB4219;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4219;
X-Forefront-PRVS: 0737B96801
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(376002)(346002)(366004)(189003)(199004)(54534003)(47776003)(486006)(2361001)(6116002)(3846002)(14444005)(68736007)(76176011)(186003)(97736004)(50226002)(11346002)(476003)(956004)(2616005)(575784001)(86362001)(446003)(36756003)(16586007)(25786009)(6666003)(81166006)(6916009)(54906003)(8936002)(105586002)(2351001)(7736002)(52116002)(81156014)(66066001)(51416003)(8676002)(305945005)(316002)(478600001)(4326008)(6486002)(106356001)(16526019)(26005)(48376002)(386003)(6506007)(5660300001)(2906002)(6512007)(50466002)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4219;H:b29396-OptiPlex-7040.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR04MB4219;23:cxpTsHfqea6CN+d5O72Y9ombx3+Nl6/TziMNbw0ab?=
 =?us-ascii?Q?WI84t9c7Gl9CkuFCZNGfY3v7hmz4H7JpjkmZ0Kob1KRMDXUaXXE4//I/bSiv?=
 =?us-ascii?Q?3pOuQu4dN9mWgXiATbHkFey+Z2LUVSP4gMO5l1gwKHi/8FszlpsWY78p3tAK?=
 =?us-ascii?Q?cNiSRWSfglSVi4/BEkEyzDZHJZ5VCY/lsk7MtPgLPqdZS1h2KpSXWg/7p6S4?=
 =?us-ascii?Q?ABR0RU6ZUgdimsfPsZssqY1fOf+nNZlTepyW0ROxth3KJVn4UL5b6YMCjCeM?=
 =?us-ascii?Q?XN40tw18bwpBxFB0jwRh6Gk387eaUi1mKDbldUIryAi0g0i2g/fsIqyfR7VV?=
 =?us-ascii?Q?MyjawOsePhoB8Je75wHQtVWyoWuaQjLUZQRmVdQTtGoQcIXe0DboWdV76PK5?=
 =?us-ascii?Q?XGb4IBG8v6FZggWWAnvmkaw5gQXR2l50BIF0UKAso0iHg1Gc+QP/Y8ZgUQDB?=
 =?us-ascii?Q?kL2npFeY4H43gi014xCE0zOgfHT8rPxs1hUVUdv/4Q+AWov+thRKbnkUX/DQ?=
 =?us-ascii?Q?Ky1rpeNbQ/E3b0gCLWgiRf5qYDO7wSfn89JX7UXWoOOZ4UEc4o44jj/MN5vm?=
 =?us-ascii?Q?Ls0RhfJJCbIgfpoCvuVL4EG6LFI1tU8hZEuIihT8cfB0L1bB3XH7nl3h9fkT?=
 =?us-ascii?Q?6OeJEmCBaSDQUDKioq/VTxtIYB8MvVkMj4r/jZeK1A3AQRT08UXJHbNSFjNm?=
 =?us-ascii?Q?h+WA8hFa4iB63+x3Mzx+qjiJ6uzq6vaWQwKPVhJ51XujhzCl3URBioe/rKPl?=
 =?us-ascii?Q?1j3FtaRPqufJjtsOBor8m898mcbS2j2BhCXFWK9SYJPm7crHvbrpUSJcQL/u?=
 =?us-ascii?Q?2nwDHIHoH3j6Q6T5yICEaOaFvOOm70cNg/j27G/xj/sFPFczlu59YJcCBqwx?=
 =?us-ascii?Q?SksqZwCRcaVL/tBzg45fJj7+zsVXYn7dT1finlLgF9TfWOg6NWbfQmByAdLu?=
 =?us-ascii?Q?dJP1c0La4p38GTGy76PSfsu1I8QBDQWBaQV6VTqXNAke1s5foJzeoJ8AO9OG?=
 =?us-ascii?Q?/772xYnf4SaC2h4YsI3vGoCgFkvlwldsZFqb7ss2+Z4eBiU9l/EK+zWJS7ZL?=
 =?us-ascii?Q?eiWgA89KB8Ms+kXGvYAqurKAe8VRhYvsx0VOfvhi7rQQmHiqAFP//2JF0tFc?=
 =?us-ascii?Q?RoPPlSqsOb1gicCUbMhuNZgVxXD17rxDAdi8+IpO3Ht6HdjKFOmtmxfQgDrk?=
 =?us-ascii?Q?2n+NcEBFzvsw9x9HW3Ez523CfQ16Ubge/Y4qnwHKCb9EkL9ZrsRPJaRi1rbh?=
 =?us-ascii?Q?mUwU/Jmgv8rwYu9+ZRJr8IlI3zDuS3Rb65A4LiLxKSM2tZ3CQUP8JyiCwj1K?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: zXF+BrLZZK0zANKKnq94W+dRUy7FiKOLEB0rRaMmbRTEdc7lHIjPWEvzkMWzJTmUbr45cUv/XSnm2qzNFY8rzGg8l6wDTYf9+ftF8nAjJFyy45KEdXwALS4il+eQUn+LJw5om66NwmjkVuWiAsIHuEEBDKNuiPdFGr/C7CUjE9rFVabXnC4oRj8UEe1qmd9zPq2BiCkFTbUUvIwv3Ufeo1gYWLttFlXtks4UYuaLUtkcUfJ4GAw+pWkykdaxj0+FLucD3eFBj6oFoFSWH89i8YRBw30kKre6f/MjWQ8a9GCvZeFiQULgG41Q/DIEcPZfMQn/nvU/8dtVFSLhsKSApDVUhy8jdLCzj3ulA5sLH/o=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4219;6:iGryVJnsje65zFTk9eGHb972QntRh7T2e0FNU4ecMp+sWnHDXYSPVzQx0Ws7SMOuYIME0FXLhd+VNJMZ2QXK0eRC18WnRt4v4oPKYBRfhJwNK5GNo2Mfbr71PMPmj5eK9pvzkT2PnnPUlc0lnPLCvxkR06v5rz2r3KblfMicwmXGWgRSCkJ8XE19Y0blp3EIbOmjJFfDRKPn29/0zTKKhhJgMUg6G9dtZmxCJ/UoshNK4zI2pj4sopKvS5mgh5Ovx9y5JmV70xMDejn2mY2AR1KE2Q/p00RIqaBRZPAOxhIVvlSVozLYDnOIllBrdYCDc7iY+zJOpazgI0buYyzFEQG7oCm8ZyHCBZovEbPoziWsAl/pqCuFckyL4p1VcBB5nmjDvMPv1P/r3krGppFJ7RtnJJQ8RoDOw+GaZzJRrUKgH8AK++1+fovSqr82fKhOTszXDEhbGQBLCdYWTIEF3g==;5:xlb075voZlSpgDZGCMSlidBCfvdu4SBu+AvhA1loQMA765YVr4d7iRyzO/MbMWulCq2KqCfBpm/4cL+V9tqUZt3vXeA9G5t0+WMib0qAJg7Op0QHDl6WX/nZBZxhoI2oWqbmRIQbb4XbCS+C5iqLNvGAhIcM2EE8ETxuz9UFMfU=;24:GtLN8Mznv/kcxVrjkhuoHrBK5vwF2ZmUSvyoqJBPS0giUSAwFxuGCgjWw8D/gcYQiuRtbkGuRt2Cy3WTw2qL9TWBSE4LK3pUo508gl4FWlw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4219;7:xRb15f5mqE5x+4ajrFVlHU9cuzDop0G2xqnFb1fbhVh+yT5RuQtQ4Vye6+4q1tS0FvNMCwChpldUj9ANsjQcgfxj4V1pZO86icHjBMjm9KXkU7nnhf76fk1N3P6imZiX2wJOIZX3A0ZvKI5OloByd6mn70XthH65nyt9c52dQht2ZWApBU0ivp0CCCF13N5fH8uQYKWJ9bUQ1A/kFqEJDwd9RXgoSRgdUzq4jB1ZZVPy7BKsYTZLmEdasbRu9+gM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2018 13:40:06.4624
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c65cb6b-aeb4-4f15-c041-08d5ecb3fb84
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4219
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pfdv2 is designed for PLL Fractional Divide (PFD) observed in System
Clock Generation (SCG) module in IMX ULP SoC series. e.g. i.MX7ULP.

NOTE pfdv2 can only be operated when clk is gated.

Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Anson Huang <Anson.Huang@nxp.com>
Cc: Bai Ping <ping.bai@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

---
ChangeLog:
v3->v4:
 * no changes
v2->v3:
 * no changes
v1->v2:
 * change to readl_poll_timeout
 * add pfd lock to protect share reg access between rate and enable/disable
   operations and multiple pfd instances.
 * use clk_hw_register
---
 drivers/clk/imx/Makefile    |   3 +-
 drivers/clk/imx/clk-pfdv2.c | 201 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/imx/clk.h       |   3 +
 3 files changed, 206 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/imx/clk-pfdv2.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index bfe31bf..e5b0d42 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -12,7 +12,8 @@ obj-y += \
 	clk-pllv2.o \
 	clk-pllv3.o \
 	clk-pllv4.o \
-	clk-pfd.o
+	clk-pfd.o \
+	clk-pfdv2.o
 
 obj-$(CONFIG_SOC_IMX1)   += clk-imx1.o
 obj-$(CONFIG_SOC_IMX21)  += clk-imx21.o
diff --git a/drivers/clk/imx/clk-pfdv2.c b/drivers/clk/imx/clk-pfdv2.c
new file mode 100644
index 0000000..afb2904
--- /dev/null
+++ b/drivers/clk/imx/clk-pfdv2.c
@@ -0,0 +1,201 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017~2018 NXP
+ *
+ * Author: Dong Aisheng <aisheng.dong@nxp.com>
+ *
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/iopoll.h>
+#include <linux/slab.h>
+
+/**
+ * struct clk_pfdv2 - IMX PFD clock
+ * @clk_hw:	clock source
+ * @reg:	PFD register address
+ * @gate_bit:	Gate bit offset
+ * @vld_bit:	Valid bit offset
+ * @frac_off:	PLL Fractional Divider offset
+ */
+
+struct clk_pfdv2 {
+	struct clk_hw	hw;
+	void __iomem	*reg;
+	u8		gate_bit;
+	u8		vld_bit;
+	u8		frac_off;
+};
+
+#define to_clk_pfdv2(_hw) container_of(_hw, struct clk_pfdv2, hw)
+
+#define CLK_PFDV2_FRAC_MASK 0x3f
+
+#define LOCK_TIMEOUT_US		USEC_PER_MSEC
+
+static DEFINE_SPINLOCK(pfd_lock);
+
+static int clk_pfdv2_wait(struct clk_pfdv2 *pfd)
+{
+	u32 val;
+
+	return readl_poll_timeout(pfd->reg, val, val & pfd->vld_bit,
+				  0, LOCK_TIMEOUT_US);
+}
+
+static int clk_pfdv2_enable(struct clk_hw *hw)
+{
+	struct clk_pfdv2 *pfd = to_clk_pfdv2(hw);
+	unsigned long flags;
+	u32 val;
+
+	spin_lock_irqsave(&pfd_lock, flags);
+	val = readl_relaxed(pfd->reg);
+	val &= ~pfd->gate_bit;
+	writel_relaxed(val, pfd->reg);
+	spin_unlock_irqrestore(&pfd_lock, flags);
+
+	return clk_pfdv2_wait(pfd);
+}
+
+static void clk_pfdv2_disable(struct clk_hw *hw)
+{
+	struct clk_pfdv2 *pfd = to_clk_pfdv2(hw);
+	unsigned long flags;
+	u32 val;
+
+	spin_lock_irqsave(&pfd_lock, flags);
+	val = readl_relaxed(pfd->reg);
+	val |= pfd->gate_bit;
+	writel_relaxed(val, pfd->reg);
+	spin_unlock_irqrestore(&pfd_lock, flags);
+}
+
+static unsigned long clk_pfdv2_recalc_rate(struct clk_hw *hw,
+					   unsigned long parent_rate)
+{
+	struct clk_pfdv2 *pfd = to_clk_pfdv2(hw);
+	u64 tmp = parent_rate;
+	u8 frac;
+
+	frac = (readl_relaxed(pfd->reg) >> pfd->frac_off)
+		& CLK_PFDV2_FRAC_MASK;
+
+	if (!frac) {
+		pr_debug("clk_pfdv2: %s invalid pfd frac value 0\n",
+			 clk_hw_get_name(hw));
+		return 0;
+	}
+
+	tmp *= 18;
+	do_div(tmp, frac);
+
+	return tmp;
+}
+
+static long clk_pfdv2_round_rate(struct clk_hw *hw, unsigned long rate,
+				 unsigned long *prate)
+{
+	u64 tmp = *prate;
+	u8 frac;
+
+	tmp = tmp * 18 + rate / 2;
+	do_div(tmp, rate);
+	frac = tmp;
+
+	if (frac < 12)
+		frac = 12;
+	else if (frac > 35)
+		frac = 35;
+
+	tmp = *prate;
+	tmp *= 18;
+	do_div(tmp, frac);
+
+	return tmp;
+}
+
+static int clk_pfdv2_is_enabled(struct clk_hw *hw)
+{
+	struct clk_pfdv2 *pfd = to_clk_pfdv2(hw);
+
+	if (readl_relaxed(pfd->reg) & pfd->gate_bit)
+		return 0;
+
+	return 1;
+}
+
+static int clk_pfdv2_set_rate(struct clk_hw *hw, unsigned long rate,
+			      unsigned long parent_rate)
+{
+	struct clk_pfdv2 *pfd = to_clk_pfdv2(hw);
+	unsigned long flags;
+	u64 tmp = parent_rate;
+	u32 val;
+	u8 frac;
+
+	tmp = tmp * 18 + rate / 2;
+	do_div(tmp, rate);
+	frac = tmp;
+	if (frac < 12)
+		frac = 12;
+	else if (frac > 35)
+		frac = 35;
+
+	spin_lock_irqsave(&pfd_lock, flags);
+	val = readl_relaxed(pfd->reg);
+	val &= ~(CLK_PFDV2_FRAC_MASK << pfd->frac_off);
+	val |= frac << pfd->frac_off;
+	writel_relaxed(val, pfd->reg);
+	spin_unlock_irqrestore(&pfd_lock, flags);
+
+	return 0;
+}
+
+static const struct clk_ops clk_pfdv2_ops = {
+	.enable		= clk_pfdv2_enable,
+	.disable	= clk_pfdv2_disable,
+	.recalc_rate	= clk_pfdv2_recalc_rate,
+	.round_rate	= clk_pfdv2_round_rate,
+	.set_rate	= clk_pfdv2_set_rate,
+	.is_enabled     = clk_pfdv2_is_enabled,
+};
+
+struct clk_hw *imx_clk_pfdv2(const char *name, const char *parent_name,
+			     void __iomem *reg, u8 idx)
+{
+	struct clk_init_data init;
+	struct clk_pfdv2 *pfd;
+	struct clk_hw *hw;
+	int ret;
+
+	WARN_ON(idx > 3);
+
+	pfd = kzalloc(sizeof(*pfd), GFP_KERNEL);
+	if (!pfd)
+		return ERR_PTR(-ENOMEM);
+
+	pfd->reg = reg;
+	pfd->gate_bit = 1 << ((idx + 1) * 8 - 1);
+	pfd->vld_bit = pfd->gate_bit - 1;
+	pfd->frac_off = idx * 8;
+
+	init.name = name;
+	init.ops = &clk_pfdv2_ops;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+	init.flags = CLK_SET_RATE_GATE;
+
+	pfd->hw.init = &init;
+
+	hw = &pfd->hw;
+	ret = clk_hw_register(NULL, hw);
+	if (ret) {
+		kfree(pfd);
+		hw = ERR_PTR(ret);
+	}
+
+	return hw;
+}
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 2fb4f1d..a5a9374 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -60,6 +60,9 @@ struct clk *imx_clk_gate_exclusive(const char *name, const char *parent,
 struct clk *imx_clk_pfd(const char *name, const char *parent_name,
 		void __iomem *reg, u8 idx);
 
+struct clk_hw *imx_clk_pfdv2(const char *name, const char *parent_name,
+			     void __iomem *reg, u8 idx);
+
 struct clk *imx_clk_busy_divider(const char *name, const char *parent_name,
 				 void __iomem *reg, u8 shift, u8 width,
 				 void __iomem *busy_reg, u8 busy_shift);
-- 
2.7.4

