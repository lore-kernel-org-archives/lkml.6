Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC524ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 613492075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="xwT0RTJA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 613492075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731753AbeGROSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:18:44 -0400
Received: from mail-eopbgr10071.outbound.protection.outlook.com ([40.107.1.71]:46816
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731133AbeGROSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:18:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2f40JGegZF0DEbuG7+wdHAi5vqi+iVap9PH+Bu+kSo=;
 b=xwT0RTJAl3KjvN366YslgaVQCqPUCkNwEUBYzxyca01e6wGz9/MYTb4reSsyodTV9o8lveM3zm1kZrYSV7kKVrd3akZa4Ga308lQ7o5p/aJ9jcgb890r91jgeAWqvmntVsF1oDeNFMBGjeHdR9KL9k+rkNcTX0V4CLT0gk1ez9M=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
Received: from b29396-OptiPlex-7040.ap.freescale.net (119.31.174.66) by
 DB7PR04MB4219.eurprd04.prod.outlook.com (2603:10a6:5:27::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.19; Wed, 18 Jul 2018 13:40:30 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        Anson.Huang@nxp.com, ping.bai@nxp.com, linux-imx@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH V4 9/9] clk: imx: add imx7ulp clk driver
Date:   Wed, 18 Jul 2018 21:37:03 +0800
Message-Id: <1531921023-18497-10-git-send-email-aisheng.dong@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: fa030611-b84c-4809-80a5-08d5ecb40a1a
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4219;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4219;3:SFOm5t8MVKXBRMwUEuihM0gwO47uJqVq6sTX32UQNOkpKsJlJFdiymMWvInzo9PqNlJJKzcuY8FNsqBtB/FUNG7k4ubrriJQg9eHESTpzwLtM5QMTbrJ7idsg4dFfeWMt8om/gc+ITVEDd1LcNhMFOOCN/OkAuUK50lx1zOgTc1gwC4BlZZpxzpNSf11sXL3POdkTlSo2V9s1BLZ8QQ3vngAT1wEAz+hFjeGO/7WVriMgml9DZOPf6k9M0Of9oqx;25:0gSu8ON+ZH7xK98AsUTJb8ds3OQKkrf8zaR25v07R6rrQGMotezicRwOu66G1r4Gra0zGv+Dr42vEZwkLzcZpOSKmFakcVXtr6RiM1CsqjP3wWK1SLfbz+2E01PqBRf93D4YqF6A3cdC29BbPSheBDGr/obMxJAoNyWbayLGFM4UaoSzNQn+cqNfXf2EQI4Ixma55t1g7Fws7Ho3pjsgP9rCBMN/W5/1Z2nSIQxGmxXgfr64XRfAZPFwmjix80mRi7MCSRvy/NldijuVJgMCncOv+c03VlRZvs9RsnPWbz6CsGf0B4NRFVRewaEMFOdkt95A0h7IL3cN6YGOPVkHMw==;31:IXt2u3B3hZ1Ja2zqu/3Stvv6auh6orrIhJsW1QDdxDAE14DUc2UIA+9eWMwYgGGKIso2kpQK4MJLcxI9WibZkDO49s91FLvykn9QdEuSUagGJCmlGhc0MAS3P89WiGJVWsqGG/6duCZBjPb76wQWlS6LMOQ9yxE5vg2DYhWV0taPy4ZO0ZIsExEGKImFKY/trEMH9CMddX+YY5C7RP3aOhz+cUGxYpkDF/6MpmgjVns=
X-MS-TrafficTypeDiagnostic: DB7PR04MB4219:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4219;20:AsBlUZFXsvVesE3zQ1W8Jw62ZyqhXQPp2FRSzvVgF5txAIJB2dFxXtXMThWGdPtCcOuyAAtMaGWXqnBDEQ0Exa0uXbsnqBzK5Q3FvqhhTZwnonJz70GweY34OzMGivTCzhM8oP4RsmhoKRjRkhszBSz89lXWQsoOUmnu8rvw2UtGHeLh9ezr0CqfgtCkv3sJ+THTw6bOrkfr239UwBmpXk6uc/OmaG39PJPlr14VaUPrKnuh1qKonI3b+5KmKGzX/qzBuD+i+A05H23ok+uLUd81XmFUHH7ahONxejasLvJK14yngyUNGHufa/QwrBgfh5pTsCmJm77BhE3Baz01S19Pp4RzW67p4yYNnr045eX72lltvqNx2FM606wNtZjmKGr+nfCMZW2TGue/rjf2SC/JM41cQkBkf7PzqsjS2LcakyTKtFgbMHoqNBxzEsgY/G9p5NP/68RcrmgDAQ6asipyt5E8Nas+pz2tTlkpzh7EBglxws8BHbZOD4I5AAUv;4:kmI1XO3z4smtykpEnGf4XApPjEY0lPA4H2jF+FFrRLOlI5znuzY2MWKJY3C/lzpxBPIhxeMtv4uE6chPdgjqTU5zgVSIfki5ceDC2jliBg8qsyxBRLmVNJAfsoVHTuQflYvk3aPnbvL0aGL84/LtCzNUyYteJ5fPclRl1jn+wfnFvr/mA+D6ns6SPPXWH5biPE+RyzzdeJkx6KUZiqu7rljsaeT0gHu04eEupuYBX4LLO2kzhgq0wXgVvsHsDjGnNgEYLsgb3c5HaaKIkilrIiXzJbGB5gisjwM9FO+ArAX149drkaVzTIJjhH4zaI7T
X-Microsoft-Antispam-PRVS: <DB7PR04MB42195B93B5424814491E7B9C80530@DB7PR04MB4219.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DB7PR04MB4219;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4219;
X-Forefront-PRVS: 0737B96801
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(376002)(346002)(366004)(189003)(199004)(54534003)(47776003)(486006)(2361001)(6116002)(3846002)(14444005)(68736007)(76176011)(186003)(97736004)(50226002)(11346002)(476003)(956004)(2616005)(575784001)(86362001)(446003)(36756003)(16586007)(25786009)(6666003)(81166006)(6916009)(54906003)(8936002)(105586002)(2351001)(7736002)(52116002)(81156014)(66066001)(51416003)(8676002)(305945005)(316002)(478600001)(4326008)(6486002)(106356001)(16526019)(26005)(48376002)(386003)(6506007)(5660300001)(2906002)(6512007)(50466002)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4219;H:b29396-OptiPlex-7040.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR04MB4219;23:z53vTzta+fwRuK0IRLyVcrkvyXPigf5TxJK1o8u+1?=
 =?us-ascii?Q?z6s5Z/PGxADyW3WU2ygu7JFjAW6QHHSXd9yoxsR+9ypKgp1WN9QHsf+lZ/zt?=
 =?us-ascii?Q?LrBHo/nt8DHR3rroFt8JN4h5g9yyoBC3MDrYyNrnNlf1LQ8MOAA0+N2A57cL?=
 =?us-ascii?Q?t7n+QKJ86aEUwZqRoxF4mrMOljMZiePMEAlWLcXIQ0z8n2XzppsIPdP9vO0Z?=
 =?us-ascii?Q?Mj9EFVNLmkbgfWpI3tz0nK1UBNXUuhpZMGPkayFaG6CeG4M+1OaZXa9NYoBH?=
 =?us-ascii?Q?lt9Z2fQD9/ITx71a0QVnO6JeTXTrY8piBtVjP2n0F53ynKXFyKbze7dLMUWt?=
 =?us-ascii?Q?52vut9Nm8/lL6xm3wxvhp+7fbTpuRGLmtqVFC9B8pEekD1IsdkcODXHxQEcl?=
 =?us-ascii?Q?MWTwh2ocq3phv1p5R8inQOMy3lLSDM9fmPXFtfCFt9uXHHkBoSd5HQ3pP1AT?=
 =?us-ascii?Q?5jL3OEYuR+hpp0kuxjF/dABc/TCKocEcHTdJA3PtxpcVy2t20R/Wo7PWa/SB?=
 =?us-ascii?Q?t8jK/FKXLOFB7Xd8y9mpTintNpnkkTRhdbT26KkaIrUqOvcRyTbahyaORJ81?=
 =?us-ascii?Q?qHhinKzFtlIEli23R2gKJ6WTafzt/l28hQZpIDvCm4Ll2K+CdVl4iSk312wy?=
 =?us-ascii?Q?+SyOpX5U/rEtxBv6vylF/0w7FIV2L6HT6wKvpikU8u2gprIg8Gj9xVAbjEpE?=
 =?us-ascii?Q?HiBPGT+Q2H0UXE+cugZIIzHsukLjO+Q7GrWHWZOac8hZWFhKCPSwVg0myRiI?=
 =?us-ascii?Q?L+K7V2Hr+miXAN2h9YavNi4CaXER2dLexCYTKzS3/EIm/IcJMyL/+ARErwaw?=
 =?us-ascii?Q?rnpMC4xP4zrqjN9UIyUhCfW0bWrNIUDNiNUPEiAum2bIlXO4u3gGgUo7ei8V?=
 =?us-ascii?Q?w/G97LJ7ogYyBL5K9d04GFoBfRBI0k9rP0R7AsQ/0tQB47AY3Gmyuz3pjuXC?=
 =?us-ascii?Q?R7nx+TTv0O2blo/0e9buOukyjrB9kg+0+BibRU8lFShua7Vj5bmQkjzke1Mi?=
 =?us-ascii?Q?CIxJe3ioS/SSDAlkQLl6MFMkpDlRksVXpfbYFA0OvMhy7ctJJiBxzTCSolvj?=
 =?us-ascii?Q?hQJYrN4UOeTwspBpAD3Bip9/3nWjgbxhlN/wm+V1UMnvoj7rLLLWLw2LwhkS?=
 =?us-ascii?Q?65d8aLgMIai50yZMQLQplFOu2tIMIgUFoNjyGmbGz9Y887O2qfbCDX0U2hLM?=
 =?us-ascii?Q?Di8FnLfrvGc6bp0Ds39u8mQUkAg/qpsZylw4pfU3AttoD2WHpTtM5wuRBwKf?=
 =?us-ascii?Q?BPS4D7Z/ffozEv5gr2LT497q9cO1dlfUAvGWnOtPMn/9xISiilvsJJDELI3t?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: R16JR5eJCLpWMci28KZ1A583DmjROI/9XVIi6LLI09vUcY4xfzVWZ96MvI6Q6QxHuTtgjbtBVUIhsWGXfmIlrh6aZsGc8LCIm9rQpmN5V/UtPbX5pIklFhocIS8LItwChm1XTiD68YAYfkQRZLGQuOPGmcN+35qEreUbZOmf2Mq/EUSkkWQzgM3N+2SjMmpC1UehegXr10otWHoCSnQlJdqDe+gfFht1s8EWjFdmKtreRlnDpladqogmDDVJQgPuA+f41KqOvF7k8HPtHKa33V1J3iOCG8oGz2DwW8m/6QcqFnSAlfrjJuHAHgFi63lVXVgxr8RDXdtWMKEnVFgFgPqh/hnve9twUCdXvkCTVTM=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4219;6:T57iopuAZ7prgMY+aIAhZ84R5V9K2c8mSjALj63WQe9xPToEYW2dfiWFv5EMGseQskOJUmar26UW6g2cszK22RBv1qlSGeErmamELuPY0iITstho+aLKzIU6W5Z9ska2qq9v7UhD8DzW2RO2d5FXf6ISxLHOmbEO8EHEXtJ7d4/GlvjJeZF5L0Ol5ptv3PI3Mlxs8bICLF3DatMIqGSjehpnmvht9gvntmCQi9j/WJnCmzuLMrrcYwqZEtkQKWnBztjkHzYxcUHhvrzGzyhYnxjaV7Hcg9EZmgf5Wa6ET80Y4xHhvRBGPf59RkdfPi+jtl05xJFwPIoKWW87IBE1x3cFYthM1YxySgt2Z3bXPMjFS+h2jARZq8jahjHd/+EmHC1qiJGDf0mgoYsKYcXEDWf0a5udbjghvfSCBXhQK/jiR/ISx5fp+pLKoIgoZYQX9u+xio4ijr+5OH2tWt7ZCg==;5:MmqLpTGMUzMb3QCAqyjJM+idSlnGsJtNolGRUCVD4ggYw77G883Ni3QhJq+AN5LSyuwGuYubseKsqlWHAGSpVpSk+dKNfuAE3u954CwKDqaGbddhYtyPlwqcPVNGyMRv+X4KCSVDA1Bx0bRmsIG/aDfZi1IxImyNZHV0deS4uHA=;24:IBc7lh1ShNq3r1WyHKTHc4i9UTUO7MtVAUXr480WQ/yUz7U7jS4kcfBYQzCl2OnviQra9yXAkg+u03ByUD4YecMUOi7g2EOW0e3xA36OZpk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4219;7:ZjUDKwSML9B1OZkIC64ePq5vHqvgECc969TOXdzI40KEM2eRrKPAc0iT25AzijzN+RA4prvGTW6aZUn6qmDVybDXmCu532PVaNhE8zcxfI5QYnxwX+LVhpxciuOOuoctvlyejrAYsCyMH6ekOJh7SsFzWslPH50w6Xt6TY+LFWRZSFUlpAbseu54CNjt5hw/LBxn2TIibhQO1c2PH1D1w3e9CPBzqpu/Bv7tbzmbLeSQ95QqM1yL5J+CwhrlnwHZ
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2018 13:40:30.9163
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa030611-b84c-4809-80a5-08d5ecb40a1a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4219
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX7ULP Clock functions are under joint control of the System
Clock Generation (SCG) modules, Peripheral Clock Control (PCC)
modules, and Core Mode Controller (CMC)1 blocks

The clocking scheme provides clear separation between M4 domain
and A7 domain. Except for a few clock sources shared between two
domains, such as the System Oscillator clock, the Slow IRC (SIRC),
and and the Fast IRC clock (FIRCLK), clock sources and clock
management are separated and contained within each domain.

M4 clock management consists of SCG0, PCC0, PCC1, and CMC0 modules.
A7 clock management consists of SCG1, PCC2, PCC3, and CMC1 modules.

This driver only adds clock support in A7 domain.

Note that most clocks required to be operated when gated, e.g. pll,
pfd, pcc. And more special cases that scs/ddr/nic mux selecting
different clock source requires that clock to be enabled first,
then we need set CLK_OPS_PARENT_ENABLE flag for them properly.

Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Anson Huang <Anson.Huang@nxp.com>
Cc: Bai Ping <ping.bai@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

---
ChangeLog:
v3->v4:
 * update after changing scg and pcc into separete nodes according to
   Rob's suggestion
v2->v3:
 * no changes
v1->v2:
 * use of_clk_add_hw_provider instead
 * split the clocks register process into two parts: early part for possible
   timers clocks registered by CLK_OF_DECLARE_DRIVER and the later part for
   the left normal peripheral clocks registered by a platform driver.
---
 drivers/clk/imx/Makefile      |   1 +
 drivers/clk/imx/clk-imx7ulp.c | 209 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 210 insertions(+)
 create mode 100644 drivers/clk/imx/clk-imx7ulp.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index f4da12c..983c0a5 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -29,4 +29,5 @@ obj-$(CONFIG_SOC_IMX6SLL) += clk-imx6sll.o
 obj-$(CONFIG_SOC_IMX6SX) += clk-imx6sx.o
 obj-$(CONFIG_SOC_IMX6UL) += clk-imx6ul.o
 obj-$(CONFIG_SOC_IMX7D)  += clk-imx7d.o
+obj-$(CONFIG_SOC_IMX7ULP) += clk-imx7ulp.o
 obj-$(CONFIG_SOC_VF610)  += clk-vf610.o
diff --git a/drivers/clk/imx/clk-imx7ulp.c b/drivers/clk/imx/clk-imx7ulp.c
new file mode 100644
index 0000000..33dedca
--- /dev/null
+++ b/drivers/clk/imx/clk-imx7ulp.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017~2018 NXP
+ *
+ * Author: Dong Aisheng <aisheng.dong@nxp.com>
+ *
+ */
+
+#include <dt-bindings/clock/imx7ulp-clock.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include "clk.h"
+
+static const char * const pll_pre_sels[]	= { "sosc", "firc", };
+static const char * const spll_pfd_sels[]	= { "spll_pfd0", "spll_pfd1", "spll_pfd2", "spll_pfd3", };
+static const char * const spll_sels[]		= { "spll", "spll_pfd_sel", };
+static const char * const apll_pfd_sels[]	= { "apll_pfd0", "apll_pfd1", "apll_pfd2", "apll_pfd3", };
+static const char * const apll_sels[]		= { "apll", "apll_pfd_sel", };
+static const char * const scs_sels[]		= { "dummy", "sosc", "sirc", "firc", "dummy", "apll_sel", "spll_sel", "upll", };
+static const char * const ddr_sels[]		= { "apll_pfd_sel", "upll", };
+static const char * const nic_sels[]		= { "firc", "ddr_clk", };
+static const char * const periph_plat_sels[]	= { "dummy", "nic1_bus_clk", "nic1_clk", "ddr_clk", "apll_pfd2", "apll_pfd1", "apll_pfd0", "upll", };
+static const char * const periph_bus_sels[]	= { "dummy", "sosc_bus_clk", "mpll", "firc_bus_clk", "rosc", "nic1_bus_clk", "nic1_clk", "spll_bus_clk", };
+
+static void __init imx7ulp_clk_scg1_init(struct device_node *np)
+{
+	struct clk_hw_onecell_data *clk_data;
+	struct clk_hw **clks;
+	void __iomem *base;
+
+	clk_data = kzalloc(sizeof(*clk_data) + sizeof(*clk_data->hws) *
+			   IMX7ULP_CLK_SCG1_END, GFP_KERNEL);
+	if (!clk_data)
+		return;
+
+	clk_data->num = IMX7ULP_CLK_SCG1_END;
+	clks = clk_data->hws;
+
+	clks[IMX7ULP_CLK_DUMMY]		= imx_clk_hw_fixed("dummy", 0);
+
+	clks[IMX7ULP_CLK_ROSC]		= imx_obtain_fixed_clk_hw(np, "rosc");
+	clks[IMX7ULP_CLK_SOSC]		= imx_obtain_fixed_clk_hw(np, "sosc");
+	clks[IMX7ULP_CLK_SIRC]		= imx_obtain_fixed_clk_hw(np, "sirc");
+	clks[IMX7ULP_CLK_FIRC]		= imx_obtain_fixed_clk_hw(np, "firc");
+	clks[IMX7ULP_CLK_MIPI_PLL]	= imx_obtain_fixed_clk_hw(np, "mpll");
+	clks[IMX7ULP_CLK_UPLL]		= imx_obtain_fixed_clk_hw(np, "upll");
+
+	/* SCG1 */
+	base = of_iomap(np, 0);
+	WARN_ON(!base);
+
+	/* NOTE: xPLL config can't be changed when xPLL is enabled */
+	clks[IMX7ULP_CLK_APLL_PRE_SEL]	= imx_clk_hw_mux_flags("apll_pre_sel", base + 0x508, 0, 1, pll_pre_sels, ARRAY_SIZE(pll_pre_sels), CLK_SET_PARENT_GATE);
+	clks[IMX7ULP_CLK_SPLL_PRE_SEL]	= imx_clk_hw_mux_flags("spll_pre_sel", base + 0x608, 0, 1, pll_pre_sels, ARRAY_SIZE(pll_pre_sels), CLK_SET_PARENT_GATE);
+
+	/*							   name		    parent_name	   reg			shift	width	flags */
+	clks[IMX7ULP_CLK_APLL_PRE_DIV]	= imx_clk_hw_divider_flags("apll_pre_div", "apll_pre_sel", base + 0x508,	8,	3,	CLK_SET_RATE_GATE);
+	clks[IMX7ULP_CLK_SPLL_PRE_DIV]	= imx_clk_hw_divider_flags("spll_pre_div", "spll_pre_sel", base + 0x608,	8,	3,	CLK_SET_RATE_GATE);
+
+	/*						name	 parent_name	 base */
+	clks[IMX7ULP_CLK_APLL]		= imx_clk_pllv4("apll",  "apll_pre_div", base + 0x500);
+	clks[IMX7ULP_CLK_SPLL]		= imx_clk_pllv4("spll",  "spll_pre_div", base + 0x600);
+
+	/* APLL PFDs */
+	clks[IMX7ULP_CLK_APLL_PFD0]	= imx_clk_pfdv2("apll_pfd0", "apll", base + 0x50c, 0);
+	clks[IMX7ULP_CLK_APLL_PFD1]	= imx_clk_pfdv2("apll_pfd1", "apll", base + 0x50c, 1);
+	clks[IMX7ULP_CLK_APLL_PFD2]	= imx_clk_pfdv2("apll_pfd2", "apll", base + 0x50c, 2);
+	clks[IMX7ULP_CLK_APLL_PFD3]	= imx_clk_pfdv2("apll_pfd3", "apll", base + 0x50c, 3);
+
+	/* SPLL PFDs */
+	clks[IMX7ULP_CLK_SPLL_PFD0]	= imx_clk_pfdv2("spll_pfd0", "spll", base + 0x60C, 0);
+	clks[IMX7ULP_CLK_SPLL_PFD1]	= imx_clk_pfdv2("spll_pfd1", "spll", base + 0x60C, 1);
+	clks[IMX7ULP_CLK_SPLL_PFD2]	= imx_clk_pfdv2("spll_pfd2", "spll", base + 0x60C, 2);
+	clks[IMX7ULP_CLK_SPLL_PFD3]	= imx_clk_pfdv2("spll_pfd3", "spll", base + 0x60C, 3);
+
+	/* PLL Mux */
+	clks[IMX7ULP_CLK_APLL_PFD_SEL]	= imx_clk_hw_mux_flags("apll_pfd_sel", base + 0x508, 14, 2, apll_pfd_sels, ARRAY_SIZE(apll_pfd_sels), CLK_SET_RATE_PARENT | CLK_SET_PARENT_GATE);
+	clks[IMX7ULP_CLK_SPLL_PFD_SEL]	= imx_clk_hw_mux_flags("spll_pfd_sel", base + 0x608, 14, 2, spll_pfd_sels, ARRAY_SIZE(spll_pfd_sels), CLK_SET_RATE_PARENT | CLK_SET_PARENT_GATE);
+	clks[IMX7ULP_CLK_APLL_SEL]	= imx_clk_hw_mux_flags("apll_sel", base + 0x508, 1, 1, apll_sels, ARRAY_SIZE(apll_sels), CLK_SET_RATE_PARENT | CLK_SET_PARENT_GATE);
+	clks[IMX7ULP_CLK_SPLL_SEL]	= imx_clk_hw_mux_flags("spll_sel", base + 0x608, 1, 1, spll_sels, ARRAY_SIZE(spll_sels), CLK_SET_RATE_PARENT | CLK_SET_PARENT_GATE);
+
+	clks[IMX7ULP_CLK_SPLL_BUS_CLK]	= clk_hw_register_divider(NULL, "spll_bus_clk", "spll_sel", CLK_SET_RATE_GATE, base + 0x604, 8, 3, CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ZERO_GATE, &imx_ccm_lock);
+
+	/* scs/ddr/nic select different clock source requires that clock to be enabled first */
+	clks[IMX7ULP_CLK_SYS_SEL]	= imx_clk_hw_mux2("scs_sel", base + 0x14, 24, 4, scs_sels, ARRAY_SIZE(scs_sels));
+	clks[IMX7ULP_CLK_NIC_SEL]	= imx_clk_hw_mux2("nic_sel", base + 0x40, 28, 1, nic_sels, ARRAY_SIZE(nic_sels));
+	clks[IMX7ULP_CLK_DDR_SEL]	= imx_clk_hw_mux_flags("ddr_sel", base + 0x30, 24, 1, ddr_sels, ARRAY_SIZE(ddr_sels), CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE);
+
+	clks[IMX7ULP_CLK_CORE_DIV]	= imx_clk_hw_divider_flags("divcore",	"scs_sel",  base + 0x14, 16, 4, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
+
+	clks[IMX7ULP_CLK_DDR_DIV]	= clk_hw_register_divider(NULL, "ddr_clk", "ddr_sel", CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, base + 0x30, 0, 3,
+								  CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ZERO_GATE, &imx_ccm_lock);
+
+	clks[IMX7ULP_CLK_NIC0_DIV]	= imx_clk_hw_divider_flags("nic0_clk",		"nic_sel",  base + 0x40, 24, 4, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
+	clks[IMX7ULP_CLK_NIC1_DIV]	= imx_clk_hw_divider_flags("nic1_clk",		"nic0_clk", base + 0x40, 16, 4, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
+	clks[IMX7ULP_CLK_NIC1_BUS_DIV]	= imx_clk_hw_divider_flags("nic1_bus_clk",	"nic1_clk", base + 0x40, 4,  4, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
+
+	clks[IMX7ULP_CLK_GPU_DIV]	= imx_clk_hw_divider("gpu_clk", "nic0_clk", base + 0x40, 20, 4);
+
+	clks[IMX7ULP_CLK_SOSC_BUS_CLK]	= clk_hw_register_divider(NULL, "sosc_bus_clk", "sosc", 0, base + 0x104, 8, 3,
+								  CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ZERO_GATE, &imx_ccm_lock);
+	clks[IMX7ULP_CLK_FIRC_BUS_CLK]	= clk_hw_register_divider(NULL, "firc_bus_clk", "firc", 0, base + 0x304, 8, 3,
+								  CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ZERO_GATE, &imx_ccm_lock);
+
+	imx_check_clk_hws(clks, clk_data->num);
+
+	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_data);
+}
+CLK_OF_DECLARE(imx7ulp_clk_scg1, "fsl,imx7ulp-scg1", imx7ulp_clk_scg1_init);
+
+static void __init imx7ulp_clk_pcc2_init(struct device_node *np)
+{
+	struct clk_hw_onecell_data *clk_data;
+	struct clk_hw **clks;
+	void __iomem *base;
+
+	clk_data = kzalloc(sizeof(*clk_data) + sizeof(*clk_data->hws) *
+			   IMX7ULP_CLK_SCG1_END, GFP_KERNEL);
+	if (!clk_data)
+		return;
+
+	clk_data->num = IMX7ULP_CLK_PCC2_END;
+	clks = clk_data->hws;
+
+	/* PCC2 */
+	base = of_iomap(np, 0);
+	WARN_ON(!base);
+
+	clks[IMX7ULP_CLK_DMA1]		= imx_clk_hw_gate("dma1", "nic1_clk", base + 0x20, 30);
+	clks[IMX7ULP_CLK_RGPIO2P1]	= imx_clk_hw_gate("rgpio2p1", "nic1_bus_clk", base + 0x3c, 30);
+	clks[IMX7ULP_CLK_DMA_MUX1]	= imx_clk_hw_gate("dma_mux1", "nic1_bus_clk", base + 0x84, 30);
+	clks[IMX7ULP_CLK_SNVS]		= imx_clk_hw_gate("snvs", "nic1_bus_clk", base + 0x8c, 30);
+	clks[IMX7ULP_CLK_CAAM]		= imx_clk_hw_gate("caam", "nic1_clk", base + 0x90, 30);
+	clks[IMX7ULP_CLK_LPTPM4]	= imx_clk_composite("lptpm4",  periph_bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x94);
+	clks[IMX7ULP_CLK_LPTPM5]	= imx_clk_composite("lptpm5",  periph_bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x98);
+	clks[IMX7ULP_CLK_LPIT1]		= imx_clk_composite("lpit1",   periph_bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x9c);
+	clks[IMX7ULP_CLK_LPSPI2]	= imx_clk_composite("lpspi2",  periph_bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xa4);
+	clks[IMX7ULP_CLK_LPSPI3]	= imx_clk_composite("lpspi3",  periph_bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xa8);
+	clks[IMX7ULP_CLK_LPI2C4]	= imx_clk_composite("lpi2c4",  periph_bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xac);
+	clks[IMX7ULP_CLK_LPI2C5]	= imx_clk_composite("lpi2c5",  periph_bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xb0);
+	clks[IMX7ULP_CLK_LPUART4]	= imx_clk_composite("lpuart4", periph_bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xb4);
+	clks[IMX7ULP_CLK_LPUART5]	= imx_clk_composite("lpuart5", periph_bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xb8);
+	clks[IMX7ULP_CLK_FLEXIO1]	= imx_clk_composite("flexio1", periph_bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xc4);
+	clks[IMX7ULP_CLK_USB0]		= imx_clk_composite("usb0",    periph_plat_sels, ARRAY_SIZE(periph_plat_sels), true, true,  true, base + 0xcc);
+	clks[IMX7ULP_CLK_USB1]		= imx_clk_composite("usb1",    periph_plat_sels, ARRAY_SIZE(periph_plat_sels), true, true,  true, base + 0xd0);
+	clks[IMX7ULP_CLK_USB_PHY]	= imx_clk_hw_gate("usb_phy", "nic1_bus_clk", base + 0xd4, 30);
+	clks[IMX7ULP_CLK_USDHC0]	= imx_clk_composite("usdhc0",  periph_plat_sels, ARRAY_SIZE(periph_plat_sels), true, true,  true, base + 0xdc);
+	clks[IMX7ULP_CLK_USDHC1]	= imx_clk_composite("usdhc1",  periph_plat_sels, ARRAY_SIZE(periph_plat_sels), true, true,  true, base + 0xe0);
+	clks[IMX7ULP_CLK_WDG1]		= imx_clk_composite("wdg1",    periph_bus_sels, ARRAY_SIZE(periph_bus_sels), true, true,  true, base + 0xf4);
+	clks[IMX7ULP_CLK_WDG2]		= imx_clk_composite("sdg2",    periph_bus_sels, ARRAY_SIZE(periph_bus_sels), true, true,  true, base + 0x10c);
+
+	imx_check_clk_hws(clks, clk_data->num);
+
+	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_data);
+}
+CLK_OF_DECLARE(imx7ulp_clk_pcc2, "fsl,imx7ulp-pcc2", imx7ulp_clk_pcc2_init);
+
+static void __init imx7ulp_clk_pcc3_init(struct device_node *np)
+{
+	struct clk_hw_onecell_data *clk_data;
+	struct clk_hw **clks;
+	void __iomem *base;
+
+	clk_data = kzalloc(sizeof(*clk_data) + sizeof(*clk_data->hws) *
+			   IMX7ULP_CLK_SCG1_END, GFP_KERNEL);
+	if (!clk_data)
+		return;
+
+	clk_data->num = IMX7ULP_CLK_PCC3_END;
+	clks = clk_data->hws;
+
+	/* PCC3 */
+	base = of_iomap(np, 0);
+	WARN_ON(!base);
+
+	clks[IMX7ULP_CLK_LPTPM6]	= imx_clk_composite("lptpm6",  periph_bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x84);
+	clks[IMX7ULP_CLK_LPTPM7]	= imx_clk_composite("lptpm7",  periph_bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x88);
+
+	clks[IMX7ULP_CLK_MMDC]		= clk_hw_register_gate(NULL, "mmdc", "nic1_clk", CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
+							       base + 0xac, 30, 0, &imx_ccm_lock);
+	clks[IMX7ULP_CLK_LPI2C6]	= imx_clk_composite("lpi2c6",  periph_bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x90);
+	clks[IMX7ULP_CLK_LPI2C7]	= imx_clk_composite("lpi2c7",  periph_bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x94);
+	clks[IMX7ULP_CLK_LPUART6]	= imx_clk_composite("lpuart6", periph_bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x98);
+	clks[IMX7ULP_CLK_LPUART7]	= imx_clk_composite("lpuart7", periph_bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x9c);
+	clks[IMX7ULP_CLK_DSI]		= imx_clk_composite("dsi",     periph_bus_sels, ARRAY_SIZE(periph_bus_sels), true, true,  true, base + 0xa4);
+	clks[IMX7ULP_CLK_LCDIF]		= imx_clk_composite("lcdif",   periph_plat_sels, ARRAY_SIZE(periph_plat_sels), true, true,  true, base + 0xa8);
+
+	clks[IMX7ULP_CLK_VIU]		= imx_clk_hw_gate("viu",   "nic1_clk",	   base + 0xa0, 30);
+	clks[IMX7ULP_CLK_PCTLC]		= imx_clk_hw_gate("pctlc", "nic1_bus_clk", base + 0xb8, 30);
+	clks[IMX7ULP_CLK_PCTLD]		= imx_clk_hw_gate("pctld", "nic1_bus_clk", base + 0xbc, 30);
+	clks[IMX7ULP_CLK_PCTLE]		= imx_clk_hw_gate("pctle", "nic1_bus_clk", base + 0xc0, 30);
+	clks[IMX7ULP_CLK_PCTLF]		= imx_clk_hw_gate("pctlf", "nic1_bus_clk", base + 0xc4, 30);
+
+	clks[IMX7ULP_CLK_GPU3D]		= imx_clk_composite("gpu3d",   periph_plat_sels, ARRAY_SIZE(periph_plat_sels), true, false, true, base + 0x140);
+	clks[IMX7ULP_CLK_GPU2D]		= imx_clk_composite("gpu2d",   periph_plat_sels, ARRAY_SIZE(periph_plat_sels), true, false, true, base + 0x144);
+
+	imx_check_clk_hws(clks, clk_data->num);
+
+	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_data);
+}
+CLK_OF_DECLARE(imx7ulp_clk_pcc3, "fsl,imx7ulp-pcc3", imx7ulp_clk_pcc3_init);
-- 
2.7.4

