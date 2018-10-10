Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E57C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99071214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="v0rj39fC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99071214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbeJJPIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 11:08:14 -0400
Received: from mail-he1eur01on0049.outbound.protection.outlook.com ([104.47.0.49]:18219
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726717AbeJJPIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 11:08:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUOvtEU1LxY3W944PsNrtPPTqFKZZRy2QTvBIn4p0IM=;
 b=v0rj39fC9BIVo19wtd64SrdPxGZ0nSLZZRlPgD3hfDd1gOyRYk/71OBKAlP64CzzghWjlEVnSHuXCSxkrTAjlP4iw/eN85PpayqiLdr1gK1/aD/zc9G0KW3N7flnGSsucRgAahvrOwDgK/MpmDcuz1JRI2jiiGuk1pml44kTfR4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
Received: from fsr-ub1664-175.ro-buh02.nxp.com (95.76.156.53) by
 AM4PR04MB1601.eurprd04.prod.outlook.com (2a01:111:e400:59e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1207.27; Wed, 10 Oct
 2018 07:47:02 +0000
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
Subject: [PATCH v11 3/5] clk: imx: add SCCG PLL type
Date:   Wed, 10 Oct 2018 10:45:18 +0300
Message-Id: <1539157520-25081-4-git-send-email-abel.vesa@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6bc553f5-3760-451e-0164-08d62e84917f
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM4PR04MB1601;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB1601;3:SvsNrCfFYDS+F2K9GaKEGWyxb8n6jhRS1VEiJbMlpCJcwzjZGT3oPbOVHd09ctFGsk1O4+AX/RtorP+irOo7TIOJmLpSNpWd3223xBv64hxC3OO+XDj1RRkZQibaAdFwzk5OI8fDFt0QN1T5y+RulfWlbR2iW5fQmi0byeCOKVFJil/unDuSUQ5n4v8fjXKorpcxyHpTOKcTIQWfbLjFXNt+jcLOywHwhhBTlc8anDH3+MBex1lfco89e+HPc3e9;25:4hoVZSOpvd4ijUb1qY2YF2aUmEGkGnr4bYMD+cvDsDP8eykMWvuN301FBhNHDqUpCYIXgl3egqgBV1rrK3OcYIR5sv8BGxODoMblnp3++V9NIV/Cx+68gNL5cqG4IdibXNxUbHnVdBSM6pXyz3WaniNlTlQJBEF7m2QgJOmoX2a1qjizcFYOoKL0qurX9LuFUZzfEmk7oSEYE7QLceJpNcU9Tte4EsCt8FWiWdWSkjQj7JM3hNyC7O5CT5mZxMngaUey6fs09e3r7mS5OxhOoCCH1El9S9E/TlAd1spDbruN4KEvfgUKKE/ofeSogBhZPDrHKHhtUcwWzyd1JKZtEA==;31:iHRxsdBCbRe2Qo3aZ4VJqjiRNKuVOJZmILWQ53OUYTRJLKHVbcJk7F1OKJqMRANt9QEd0/Ipmk0BR0mxd7umr7GHgEFEtqN6DPDs0tySQhMafa6KSXz5//1IcW2TaXnhoLIA2buIFoxVJKwt8yyqQG1FYAwe6hzhc7rnhXmK3ue90v6RpD8ECLHznZkChOHlO4xstmXGVUYl2dKcTBvhU6yC7XsnFbOP4Af15Irss38=
X-MS-TrafficTypeDiagnostic: AM4PR04MB1601:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB1601;20:XBbT1Jl1LpNWV9TOMmcdptaoOS2PngIqmgoDvqeRsBNOwj31gEtZJBaXvNhktwgsR87LqkwMVXIBq5t4MhaQiIzKYoH8KQwR9OOFQEOo3YyEeJC0Rdlq4pGiZi39reed2IkXKQhC8J96pyIPJOQLZnEW3ZinF+5tvlbwelXx/Ks7IG0cvcdvye5jhrA6RfTgktMZmPjdnfBzqnrDTBzuB6nbOD4BAB0wUe/7h+eGQSLZX5LMTbzOwiUotU4uHiZ09/g/NSMlBC4Dk4Do9rwPS4kZ76bD+xTIlvJ7ZMiR+23DeNCD52VuJB1EWS3VkDLVHNqGwG+oBgLT8lXhnDWbcjCy+ejd6kq+MG6TwLlaadnpTKQLumHkqUdzqX2mftWV6cQpWwYHjduISb+gUSrzWtLWf/9MbzKxC99HRgHf6cukgocgOG9b1KKubbS5PsrysWthFjEIkX4glOCm7X743E0Ei2ftP2WFC7VEELB+csRtGSPgJq+qbOu5pnW18Eje;4:4Wy9qSm4fgubmMjsj9YqVbkZaOVh7lPdvg1zBDfJPi7lgXVEE5jDoY8Guh1O2sUSWY2YmsnbuAW/qFnFLUgmjbwaa5wiCKQIFp4Z7HS0nUgS3VftnbFTcSRYsoxOF9vJCpaPL5qBHy7XvAPhgnSy8/WnYMdQLYoW0hpwfQS6AqTU2V5mpXOm6JkJyU/nt/uArdUy09VLIMfqoOCr4kIWQHCLFHpgHvBGxzb9PslD6jStVdS88tkAj3Co4MTfHpD+o3LM1Uhwif4ObbIo+TDGAlnLLtd29g5occBJW7E3egRRPe8DFAT4NMwGaHEg8zNM
X-Microsoft-Antispam-PRVS: <AM4PR04MB16010C8487C209423FB32CEDF6E00@AM4PR04MB1601.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:AM4PR04MB1601;BCL:0;PCL:0;RULEID:;SRVR:AM4PR04MB1601;
X-Forefront-PRVS: 08213D42D3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(346002)(396003)(376002)(189003)(199004)(7696005)(51416003)(52116002)(48376002)(4326008)(6486002)(76176011)(105586002)(50466002)(25786009)(16586007)(478600001)(11346002)(86362001)(186003)(386003)(486006)(16526019)(44832011)(97736004)(26005)(217873002)(14444005)(106356001)(446003)(68736007)(2616005)(2906002)(956004)(476003)(47776003)(7416002)(50226002)(66066001)(7736002)(53936002)(81166006)(81156014)(8676002)(110136005)(36756003)(54906003)(316002)(6636002)(6666003)(3846002)(305945005)(8936002)(5660300001)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR04MB1601;H:fsr-ub1664-175.ro-buh02.nxp.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR04MB1601;23:EcI3ZXALay3t+lXp3+ttT4VYeeXVqGF60fp9l4wjF?=
 =?us-ascii?Q?85tzlBFfLjud/lWYcA0rzZybE13/hTnC3hfkEtx1dm0PpPKCZpoY6bTOqDz6?=
 =?us-ascii?Q?OAIluLdrRyLRxisxk70yqwgowa1jn6JgOogTt+lbsXuOn17VSi1zn3VZP9Ra?=
 =?us-ascii?Q?iqMl/JCB5rBM5+6UPqSAuzvdCEPh7rzXMR05mxjpQvQZVf3v34/zeqfyhR4b?=
 =?us-ascii?Q?XkpplsiVib/Am+ALc3QUOIZTbDrZAbsJKEjZt3U7gE1MAhmXmYghEpjFiHfe?=
 =?us-ascii?Q?26F+ZQoFasj6NRLa95HPTyDqU94s3YfF2eo5r+eVurrISPzJa7zyffDuIe+W?=
 =?us-ascii?Q?Jx9jXBsLcz3JiB/E1k/5hmdfAdc1XYAxPVm/4grku3LTnCSOS+aOj5rUm7DC?=
 =?us-ascii?Q?lp9BgBpQr69dGyulH9K8nrr4ZKDAuk3daXffe/uz71GRwzqXvFWbX9MWahpE?=
 =?us-ascii?Q?tVGe1R4EW/NfaeJ3PhO4H79/ZJj6rX9Rw3IZjviWcERIgYQ1Za4PYbPCnE63?=
 =?us-ascii?Q?VFNeB2vT/pGDYX+pvh10dXGC30ZQoJb5JnCXKE0KVzU1bouKfpyep8e7gurZ?=
 =?us-ascii?Q?Gb8wPwaXNuOYpYyj8IUT8jz6X9UOZz5wlJzvC1NR8W4uSH7dbd/StX/ri13E?=
 =?us-ascii?Q?hoYZnyKpV+joEVdo7juA9QwW9ouR+PEeUBMJYcQjVu3rpUelrZlD39377jAx?=
 =?us-ascii?Q?zsaINOww9YgHaBVNwWQYmYkX71EQD51qevGYAohm6GL2tVcSqwYpr0XZ/ADD?=
 =?us-ascii?Q?agKCyvZHZDlWuN8vfAY+4JkDwJp4EbyrTvtsNfO8U3H1tuLrc41+8kMFxAkS?=
 =?us-ascii?Q?QfSJDwtywJZpYTq9jZmDfhvKNKGfCeP58YTtQu8HGwrNariRwDsK4gGcTvsn?=
 =?us-ascii?Q?7ASYaQV6FhruQVzJWnGfgMsNd6T+ez33/A+0DVpZBdBOmzMz/L1nVzyh+tEk?=
 =?us-ascii?Q?FC+QQHfgk4yTkkqpB29fFr/mZiOSQ2AlC0zenrlk+gabKw/+0/5CtifbnDTh?=
 =?us-ascii?Q?C6hntE/fTbxf4MWWdZIPdTdmRnvIw8iHw++AAM19naTEGk9+fAU82MejZ2a/?=
 =?us-ascii?Q?3lIhemDCfr9gCWywPfc/msdxjMLo5z3kEugOjtPa9gSnAADZi60ggTrS7B/6?=
 =?us-ascii?Q?2PLGtt2wJRI3H89bqJyfYGB7oNc6EibjwohYFHV8ORkkyESoaJI9Ua3z4DZD?=
 =?us-ascii?Q?BFyIhPJMVF3IspmAJ0SooVV5ZRugkTZo/Hj/xhYPIc3GTaIkMJBAnygwBnRO?=
 =?us-ascii?Q?UEGSWAfOexZWE1BSYXy7S29c3tmZ7Bz0Ff/FHAJ?=
X-Microsoft-Antispam-Message-Info: jUrul+UxSdHB/26vlAACN7mcu+BfSw8AionYK2tN1j8ZJCObVEsb8H5xdOBLsb86DYBjVwpNqTDdeiASjRh54IFkBLMjYcUInE+7DU3BjsmZDMhC5ECpxa5+TFVW5Te1Rg7YXlGzPO0UtGH9XghIKNmnl9/gT9n8BUAM0s2Tx9LH757NK64SvOV2b478XNTeJHYTFvqYVLHp9Brw+EGp2+OMWnS08gDVNcd9X82GJFvf/2Ow48Fha4YU+JZh6FUdM8rT0SxyUArAFSB9c8Vb3AlVhS8hP8bt1fE+n4v/gyXZb5hiB9wKIcagzwqFsKlhJcLF6yOVf9Qo9gzribyRZw==
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB1601;6:+ioziPzoX8epOE2DjGdPTKcRe75CV72VNx3ZzGSY4BF4CjPhWO5VXq0tQFKNSWDdlK9Wk2P8Xr/aJfu6WD/KK+9xi/NXH6vqNij+LqH5nCODilIuej0wJi8d0rggJZXlYZEsD2/9DInW5XHf82xp1Br9IvlsMP4B2GLEFzUJ8Fkuwry2J1miObIzGGMGuEitUgCzJUmUZnfB7LRQGANzTSi75C56W4+iy276HhmUX/W7vWYubocCL07aVB4OS8WLIkf/wuFcabsY1ExTvBcuAjS+fTO8BPpyWSJAHFdonvLeqeIaS94LKxi972mo8hJ7AxAzXXWsKoAC+RqAsgjLKqXP6UrQKO31Cxp6IfJEWBQJEpyqzIIOVkWvImgzUndGut4WljU8LtaOQYBgIiWmzcZy3bnYNcicU3V69UC4F7okUPZaBu172a9njgKF4qhv890WzJOmHjezhhEPJcubqw==;5:r2Wc/VGb56eiHIs92deUC2khRD/t7BoEBF1J69Hc31RpCAdy5Do/3om70gnNVsSmhxmxqKYgnSxavmqpIJFFgKUj85CXePCnxtphE+1qwmjmyeljrbiy+UH787iPqd0IXVT1yBl2FX6UjBqGa+bA+MDHfI7lOHZkbKFHGovE6Xc=;7:ZymP6weSZGjNf8ZeD1opcYWvYmviCdCbr5NlPhjvttaX3CJe/0cSTZbXp9tfkUFXQa6d/U+MyuDLqgV7DgDFKl1v4d3ToPVf8pMpNMPkEc1Qkuwvv5Eu73Hg5QPKbuYFH773dMAxokujW5nEy8PuxnQo/eICw2Jo0aWYYL1fQsPwX7kGvjbvmRBvllJWUwZBPQVA8YuulrvpOr7aOYHG79NViqJqtDyEx+ldQO07tNR1gaP4zBp5HUfU4QA/7Qqk
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2018 07:47:02.0415
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bc553f5-3760-451e-0164-08d62e84917f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR04MB1601
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
Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
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

