Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A465BC04AB9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40288208EB
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QiycX+t6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40288208EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392027AbeHPS1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 14:27:00 -0400
Received: from mail-eopbgr20085.outbound.protection.outlook.com ([40.107.2.85]:13040
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725808AbeHPS07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 14:26:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7UoHKzRUM4Rc1K65M2cWPvUaeNiIh/eVzAHvLglLFMc=;
 b=QiycX+t6GN0ldjZRfS5zLfOWgDImGZGNAOuPKrcYQn94QlqXXtUNDZqf6eMRpOtB38axhdP69EvLrn+12Fluw56aH00mi64nBYgxN0quAHEjM4tYdTQxcXlAreNrsHyFiwaMUP+7Ea67xQoz+GtvWzNcKYEOgV3mkKIAxmKq5oQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
Received: from fsr-ub1664-175.ea.freescale.net (95.76.156.53) by
 DB5PR04MB1608.eurprd04.prod.outlook.com (2a01:111:e400:5994::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.21; Thu, 16 Aug
 2018 15:27:39 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>
Cc:     linux-gpio@vger.kernel.org, linux-imx@nxp.com,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v4 2/5] clk: imx: add fractional PLL output clock
Date:   Thu, 16 Aug 2018 18:27:13 +0300
Message-Id: <1534433236-8925-3-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534433236-8925-1-git-send-email-abel.vesa@nxp.com>
References: <1534433236-8925-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: VI1P194CA0020.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:800:be::30) To DB5PR04MB1608.eurprd04.prod.outlook.com
 (2a01:111:e400:5994::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5cd6b9f9-bd17-42b3-2e62-08d6038ccdc4
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1608;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1608;3:VeZLMURQ8oGo3uw37s+UIClK47T/dqxBpt8YhB5//wu/JYoatHuKHN2kZsCKCAktzYvIJvb9Q3Z0y/BmwKgbFLFnTCiGuw9MABj0zKGA/WE1yEn9YjFtNSUBuVtM6PgYXOAhygPb+ly1nURfR1M99eO8X+JTngiBzIAFVVVMyyX2Iz4Cyaii1/IDxYScbtqiH3uDnqxYkrfH0ybg9JUQXB75t9iA7a2Eo7iFrdQ/2HRVLgmrHZhA+I5cjPQHu9UY;25:oC+85r7qVvzgJr7BDyOJysJMqAJD1HA2efYY++fVf9adpjtqnUwA2rRKCOn5OQTEfnLkql1SPzMZMSqFucAMsrr74lixbNUiSOLJwhRlp7MFGoYR0p5FRnlskdRxVQBrkfphoL+jBzihAj29eTeSD6kcTdge9BJBN3ah+gHGtQg/tB0lY/vDZSawJOHSK2WX0aYCGdHrW/5T0jm9LqTHrCmMnqNMNnWO7O3l5H4HfALp2OPNYabT1xoDqXlu/i5KL0Wo88hM4uFlK+wy1M6kJB4l1eqlsraNhCcUFfTjdTuN9hY5jKgFcG72kDWtuNn5YDBUK4n+p3vmt8ozW9Gr0Q==;31:0lUvnWWIy7ZqmhQoSlMl7DEFjKVUhJMy1aeZwcrul0lr/HciyfmeAu9FmDIp4YgNnKqAJYzkXENMC4s33vgeMOjLRk6IQUFrjgfyMQQXTTesvpqrsnfD/1VR8Xg5RwW3hP9svQJw9w94kdN+1GvgyNT1YFxVfdg48MpQ9Z+GYPdLue8reIwcidZtCofIdSFoUfITJqSmrxSE5phzaCZLG2MGBrmkNKJlqYgsqkPflkk=
X-MS-TrafficTypeDiagnostic: DB5PR04MB1608:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1608;20:j0kAyg5ABUu9PeEbqKUvrY7Nw2ziEw6muIEN1meP32vua8MUrKlxpWec8dN/Qly0cYbhhCiOTvs8SMIKQ7ReM+jUSECjq+36M3/mjxzAZPVAtf9b33awHu/gNe44OUgPWiqLhMe3ROQBOeY/1dIaRs1N2FsSW5UfqMjG/7k4pCNZCn6fSp3s0RMkKkoNyYO6JsU5HUZi2984azjzm7T4VIxTn16REMAk+14+PfC/hhvJwYSEt2DQviAyiR4pexjGejUWkV2+AGks9uibCgVg0eZQLMb/0oY479LbVGnt2TmPpuT3fNB/XyIPN3RJSTTH5eIhwpyMZWh0j+PBXa4MHDQX3peJwrak+mgAbtwbJK5OB9uR/j3Lu6VvIK+maFgYAyP9CjSs3OYjlkbEwNPuBOsmVvMg0F/9Qz7xxieeHMVJf3Kvr3K3AklGIV0XKVevNgnH82tKb7dB7IgG9kmt8apixMGTW8yVBY+QfTuD0sV0IgFoCBvkRFFDExXK/lnz;4:LUpjQhzLkwoegY2Li22TS7kAFWzmCphCl/5LEsp2RneHjI5YZgRNi2UYfZkrISajwuJVSXM6C3F3NQsmYB3P7pSYblhQl2+PNBggA1xNwVq6YCuQ7ngDWqiG2tBFv7/FT4w1CN+W9G9mP24ctR7jrzdeudtO059YT8JlWG2udkj8jmAILJQBa4kq2Ws/981E59TAhBIi7PqcHVR+inbSunnbJ9Q4/nq70jxDXsh7s1PHqkjoVB5da4vgYPE+O3/qmJPHZ99YI6um/HdPNQ9mtA+aM5pGyy2H6/7P39c5+o7rxrTVW1nPIpwwObNEh0+e
X-Microsoft-Antispam-PRVS: <DB5PR04MB1608150D20D3E95DE6E90FA1F63E0@DB5PR04MB1608.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699016);SRVR:DB5PR04MB1608;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1608;
X-Forefront-PRVS: 07665BE9D1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(136003)(39860400002)(366004)(396003)(376002)(189003)(199004)(11346002)(36756003)(446003)(14444005)(476003)(47776003)(53936002)(956004)(386003)(6506007)(6512007)(6116002)(105586002)(106356001)(486006)(2616005)(2906002)(3846002)(305945005)(5660300001)(7416002)(6666003)(6636002)(48376002)(50466002)(7736002)(16526019)(76176011)(6486002)(44832011)(26005)(81156014)(81166006)(316002)(8936002)(8676002)(66066001)(51416003)(25786009)(16586007)(86362001)(68736007)(110136005)(54906003)(4326008)(52116002)(50226002)(186003)(478600001)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1608;H:fsr-ub1664-175.ea.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR04MB1608;23:Bo2rv7Sn4eviYB8cQYprXKzKTVsUR8sg/wo8/awEf?=
 =?us-ascii?Q?DNCTjhuaWycHBMUIkeEhDYIiRiCGr75BDTkvQnNuB2YWHYGa2yWvImO8H+su?=
 =?us-ascii?Q?4Cb+SHAQKYMcTwgh4LBkLkUGaAcjJjsjYnhq8AsIims7gxwK2d30it9mKo2H?=
 =?us-ascii?Q?03cIdpjqycA3Igt2oxhq2VdVRKZk/cqxJea3y+qNH2ej9zV/EZyLQLBp42kD?=
 =?us-ascii?Q?eUUr4llJFxfyq398rC5+rr7fU+YpO2bIGwZh538Dl363RsjffpgHkJs+3c9M?=
 =?us-ascii?Q?IhnqqNXoNYQ20hR8ME2ERfO+DAAYbhH+WZ2eMZCV16sm5W45tlSeXllRVmKM?=
 =?us-ascii?Q?kG8LgmUmppmsDFI0emDwZYJNJIwaZ40TRQ671iGnqMPzCL38Aoz2x/zSLrY2?=
 =?us-ascii?Q?QBJJARgAtPY1yxR5FGu5BMkFa41bPIM4/UsPLChY2v50avgHKOBFeB8WHmlV?=
 =?us-ascii?Q?09CKnvtxE8ypqnJcSx+9sxUx/hGs1K7QUWD5T71i5ZBufLF8qA/pobnHDmpG?=
 =?us-ascii?Q?lX83uaLKLiFHq8JxNl468RkdUMdzM0WfiRRtnLGrrQm/qTxdf4/SOXdh0Wtl?=
 =?us-ascii?Q?RpdW5A++v57HlhMEBGPQCewzYX0RkEEtRbNejqD/Bxi6eqwWCG/C1N3jBDKk?=
 =?us-ascii?Q?W2T2iknCiHxiNRhnYLxm7xFdVaH7rx0/d4gaviQJIo3dz3YI4qonOoHj8MKd?=
 =?us-ascii?Q?JCEb1RjA9m0VvHFpZ6XLDdEPrXqnhRG0XrJxpyn+PEdQu7hfIel/6F81DT0F?=
 =?us-ascii?Q?kYBPjp1hjclJ/qlEDgZNwkX+cL9C5KDMjnJAnF4eRrQowaYgeQCHIo9aaWcl?=
 =?us-ascii?Q?gmE7PCJ/5cGLv1A0IyhQP91L5YayJZI/5yyRxzsH1NNLcmPLFgeHn4QJ9/yQ?=
 =?us-ascii?Q?EyPze9ubmZ5JsVUlqGleqXTmqSt2TGvDHTfhremyvb8iT8Gw9TXcRhNf3wG0?=
 =?us-ascii?Q?mx1PH/XoF1bIXBcc1AKOcQfjgRaOLyAShpfIx+efd0Gf5pM24tZG2X6bG5zO?=
 =?us-ascii?Q?tlc9IGOVQFryzd1vHDdWyifHRDUaN2Z32nwh7hr6I8SgodZDoorovejYmV1W?=
 =?us-ascii?Q?FEV8KkMw4mSIxPLrYT434le7JKZ0tecsU9hLOOWoUREqbZk6dZYsgcSRmmGm?=
 =?us-ascii?Q?pyYIXbXxlH2ilrP748lVBMoe+RIj5kWMeJwW7Cr4Bjj/kdkthnbt/ivdLqdn?=
 =?us-ascii?Q?oSiHOAIUziHsff2z45oqFhYV617QTcvJxyaXaVIwZlgWxt5oX6+Nrlu0ybGD?=
 =?us-ascii?Q?TAX2pUENGefT2MYkklQAL3zdk2srugiyfybjEIh?=
X-Microsoft-Antispam-Message-Info: uMCCibgT8PrccQI1RIWIvM/NtRvcYdiiBGqvnVSSXcR/YDv9bU1ax+MznZTMfve0l3Q+gwMXBMfoF7x8/3py8/cG8Al6wzWX1p5knl0JoxoQnaqAyVWl8ZOUFWmkVSzmDQ/znMj+dHKG/nPDvJIgdupfoXR6wkJD2ygpBA3B9tfBy7AMxDGvzQqKEnpJ6WeYpc0Ie/8UGNlRmC92wucnAOnWUWtB6ksCkvEaiMzWpcLBFJ9eiOp9iSOmx5NQjTMrex/q3KchKeaL8gF9r5mdbhVGdfzJMFp2GlAPe2f1nKhIUut8kFJItWMJlmhFds8xU6R5KA0sHfcarKpX1Szisd4Xmhzh/EkP34r+Jm8+KZ0=
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1608;6:Vj39JL/sasA09AVMOIh2Hvo0Dc94axskaf6JwWVaAAyMMTNcYyG9xn4GJ5+smJUgNQt32vTGUA7YMwOgR/CS7Ixv3LQBfHw+uab8O4PZqTY5QRbtoMd+4sp/Ea6byBjdB3ZqVYZRSOI9sRBy/NybgAarjV5Wj2MSX14vChDRoBtEqyJJfih3Wn0RDOjbIypXgkGNcuaZVoaLp42CfIn084SbolRNkrF+HWicYupc9BZwdbNWMl5Wc2kMBPyxBqZwZY7D93QVfiUgbiT3AXHxv+U0D1WbQ50RjDGqqeIb1B5oUtTvrltqBsb1jdP7YbMc671dxKhY2YMfCtXlF5VMl7Eo6sEs7eTfJihI/FV7nMwN+H0xb8/lm1B9P8Ag5h3UZ1gKJTxCV5qF4aSeqXVMP20uqedDApxe+UBP/zKHf9XqxRQEy9bhEggmcrkWgCnYoA9uhnDDZZWnBggPEfd63w==;5:kCxu9Sm7pIybXRpCxhxMLucBHVUBda+ltXEbCPpYPer/EUH07yvihEjE01dw8IMMpJkug140YnJUgLtW5yDstcB8ZgqWsMKyuTlEPJfWg/b0z93rklAXgpsLizuSH5BtCkaKvIMMvnC+O2Zh+byeQb6RDnhPrl/dvyHqOdBZlxM=;7:Xq3N4Co1hr48iRI+uY4Q78MLl4yq/UEgNeVZkKa6kZg7GoSLpXe/oazFTxk13PYsPbCyhoYLwm0vvgWyqJFYIF1jUGx4y5CxMGOvljC5KZKzIXQ8Y1mTpYixEFoWcGZ/Ht7AiKU49AT82tFHVVgRKsfCsjwbksSHrV9kyNvh9F7loU919iFihrgginel/PM+ZGFTXiVBjQP4nvBq5whkgSr6CMJWVyxcCp/u9AMo1rvXdgL4zUjJ0Ia9ITttwnM1
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2018 15:27:39.0431
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cd6b9f9-bd17-42b3-2e62-08d6038ccdc4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1608
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

