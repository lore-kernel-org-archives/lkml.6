Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37281C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAACD214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XQjGvZNL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAACD214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbeJJPI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 11:08:28 -0400
Received: from mail-he1eur01on0049.outbound.protection.outlook.com ([104.47.0.49]:18219
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726717AbeJJPI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 11:08:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGO8qQYqxBnKUaaCuGg584oitskS/rOtJF/GdWLp+Y4=;
 b=XQjGvZNL2Z18I10Yb5QWGfUAt1roJbCiV9nWObovKlw3jwqZljql8LJcCPtoIwtn1glMI4iTVpJ3LnEcRuMQzJFTVMrjrbpWY12ywBYdWC7+dkFRZKlw43Oe5MwlU0Z3PXrbFn0w4QwzeQsi1xiNkqBq0KalhwGSW7T8IfVLTCE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
Received: from fsr-ub1664-175.ro-buh02.nxp.com (95.76.156.53) by
 AM4PR04MB1601.eurprd04.prod.outlook.com (2a01:111:e400:59e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1207.27; Wed, 10 Oct
 2018 07:47:04 +0000
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
Subject: [PATCH v11 5/5] clk: imx: add clock driver for i.MX8MQ CCM
Date:   Wed, 10 Oct 2018 10:45:20 +0300
Message-Id: <1539157520-25081-6-git-send-email-abel.vesa@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: f8f72fa8-c413-4ce2-a8fe-08d62e849360
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM4PR04MB1601;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB1601;3:HyIRFMsDrqnfSxj88qW3GqZSo+SIsVeIog29xzhOZwjKfWiK9E3khvEguLLamCYgkY4VZUJxanzfbleCqehMyF6oErQnzv7V5JHP5PcItSmIarT9d1h7R14iJE/NE+uGh6fu06vW3PjjTFOXc0gD89iW3vzXR7dNQS8JMaGTbod1fonsh3exgYXajkKM2dryq0A941/soZFioSV517ND5Cx+wNRNsf/LRcDgyvU+52ylp+7cJV/qend9d9XSkudb;25:dOvbqU9x7PGgYt+lMT8/rzkMcaJqTSbLmfceQE7PoY3fM/CCX2tEZ8CTcwY3i3m2QuM57YRjkuG0AzOYEXbOjA8n74/VoMUUvbPtBy8sa3FeXOQF2CpqSRpOf4iDLU3sPVXmuqka0a2m5Fn9LzouenC6oL1Rdrv4qyyY3X+AmvrP3Vbhzaa1OCavEzFCFHKNGUCpzRo2XODJ0Y184ivJB6b82XiXFKIWNCygEvutgXKgM8PWItn29O9rgrMB6OXN4b+HSweq1CyhILHWQO0S4sq1eJSAbkQ06JTxCnSaB8JjuMAgY01NwsL5n0EGrAizoCUcRJX6LZGI2BQ8JOZ+RciLEwv8rIR+PNbgk4/I3AA=;31:ta2pbTE92gDw4b6+Kgnwe8DVbLLPYtp0WyXtXU4zG8I987YJW4iS/Dd/maIDHOSqm3yYYuIV/hqSk+E7cHg8VTxadgi/T2Hk2z8YhVS4503682Q53TF3pPeEgrDbXLI/F0XBJwyBnzBPFvdlLrUP/xpNbqw5NKnA2BuOobQpWUiTJpJo4y+4RCxEgB3c0EKOYgpTStENmglH0u11Y4EUptU8XwzYkFvRNRneyq20/o4=
X-MS-TrafficTypeDiagnostic: AM4PR04MB1601:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB1601;20:aJ26KccXKbTMwwvpwesGwYDOvaB2drreQ0LLUhIwDmuJuX8StkTu1qxhfCyOzN0fV2ldtWBUlgd3hxIJCCIDi4lg56Y1bNQTe28/A+jYICdAqrcjyvhYreiq+Pat7VnjGasEvEKbrD4j0yxxjfaMojgtR/+6iL6yMgy7qR7JF8tHHQRiOYMrKS9nHvCXmYNmu3T1s2lAvt1GwA41umdefHo8l/WEfRJt+DIO8ZOSvRoC8tMaoCPqWkzAMJyor9dDwE1+OBxIXaLF2CeMDEwRnAirAoUVWpH53lAh7dtsuMntzLBmOx78dgbtyAiDtzdIPQi1ACP+3Ov9mwxqO2cPajCUgDM06iEteeLZTnXlvnR2KRLtB5Yrb3xj95u+KpHgkfsiuNCY+iYSVpr+yF2bLF5g0vQj0V7dy9ZaRBAzpLLasiNWnptFybNgD28tjU9NF8yfqcEYNaNh4NnsomCrhDbSfG6pu2RHeVde7QCLjbIkWDTU89xMO+GQXJYMz8uQ;4:sMO4zPmCxdXm+7iFYDCT3Ay7ewxvSBC+favnKFa/jKRR//2wfaHT/XOU8ipmqYUu5N6Fx90SyznU9R6bVs5kipnOvEIcGUeUEHUsOuHSqneb7E3hIBBBMW2/r2UtfyP81AfgIp0OLlkqPfwKnQdhjAcydutpU00nG0C35N4Di9k0m3QWpcWD0z6SxLuVKEM758rt7O7JfxcVYQzgV2YnFFhcnrQ4D1WDOlQgY2N1OC9uFx/9G7CVu4agmZW2xRT4EbG8SojHSHTD9RoIDa8IayU0NVQ7UwcH8YfvyS7BLBZ5xSi0k4Gby6/ZAFNSaByY
X-Microsoft-Antispam-PRVS: <AM4PR04MB1601A3EA66317898D9371497F6E00@AM4PR04MB1601.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:AM4PR04MB1601;BCL:0;PCL:0;RULEID:;SRVR:AM4PR04MB1601;
X-Forefront-PRVS: 08213D42D3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(346002)(396003)(376002)(189003)(199004)(7696005)(51416003)(52116002)(48376002)(4326008)(6486002)(76176011)(105586002)(50466002)(25786009)(16586007)(478600001)(11346002)(86362001)(186003)(386003)(486006)(16526019)(44832011)(97736004)(26005)(14444005)(106356001)(446003)(68736007)(2616005)(4744004)(2906002)(956004)(476003)(53946003)(47776003)(7416002)(50226002)(66066001)(7736002)(53936002)(81166006)(81156014)(8676002)(110136005)(36756003)(54906003)(316002)(6636002)(6666003)(3846002)(305945005)(8936002)(5660300001)(6116002)(579004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR04MB1601;H:fsr-ub1664-175.ro-buh02.nxp.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR04MB1601;23:frxQ5CIxJuviiGq23bGCX4N7svG3AOHdanQLuY1Ep?=
 =?us-ascii?Q?KHnIp97plCLkVNEG6RGUqS55eNdpxHNRPYphlcKjUjcxJ4ZLy3b0wvC2nygk?=
 =?us-ascii?Q?bS9s9OjRvGTRLOFlvfNZfbRNnugkhva3WdWXUzQXg1d2FJBfrkijI4MFdvJI?=
 =?us-ascii?Q?ZCXpQzyCeIZyFaTOJRBrKNTO5xCvLrpyca6MpRy4paarKAVx42J9Stakf7Xp?=
 =?us-ascii?Q?BIQgMb2peFIOFfNXKF4X7MmjwALxKe2xW/0L5hLSZocMvWC8AxfPZHyOLg1T?=
 =?us-ascii?Q?uZvkcVinzDkyuUiPTWtCeFqpnuyO5DHgaoy7LkEMg5z/biYGk/yGbMghNIbT?=
 =?us-ascii?Q?Zyb5G9Va2IUX4gDs7LyzGqhf0ashcTBI7HMxOt807lP+w+Au8p89z/OGpbOi?=
 =?us-ascii?Q?R5qE4zSz+7BBx7AdE8rGlUt7KPZu61gHDByP0vrGr7x3WCwZ6+0ZFHEiguP4?=
 =?us-ascii?Q?Q1dTnbcZmzLyXQ4cnTB7S0bXWlmuGyskcS79p9+p9I7SfD0c3odVrZXzWheY?=
 =?us-ascii?Q?gG6KcV/viPMWELSJk0DAkkUEHWKsw6cQ0Uv6UZ904oAXFVSM+BKLdLxCPV/G?=
 =?us-ascii?Q?xxx3AVnf3Be9T6nMG9sQibywn80dbilce5q6Te/pWn6gJb5Kj21ESY6An1lN?=
 =?us-ascii?Q?8/tYUpXkq2H5rWdOu/UPc+aq5ZOT4ChtFrE+1Q0eGscREiYczTflCs/is4vc?=
 =?us-ascii?Q?hntFjvr12fTaGDcL65hDwHxO5immIMvFaF/1A/HJZLZGSu7LJZMKMxRlq2H/?=
 =?us-ascii?Q?028sJaLK2ybF1H4yP55ofjpw8wzDRqGomoOF9dXZOdA9njpFr8ImrVZb41ve?=
 =?us-ascii?Q?4iiGl2msZF9y3IdXd47kwyflaMYdURf0QHkxha93S43SR2PY7LQNUoMH4+cP?=
 =?us-ascii?Q?SDpe7wA0Kqg0tJ5n6F7CwKJkdPUbnd5Yw0lm+Ws0+e3Xb9pJlivOexTFYZyn?=
 =?us-ascii?Q?z1MyYW/GwdwpJXRsj5YKhillxs7bOTMSSuuoVPRbHOrxUAVw823/ZBVnpqHX?=
 =?us-ascii?Q?M9j7hsZmDuCjv20DBYutJ4oOrGIbLazV4W/p+PAYQgS+LeoQxiFkT54I6Pjt?=
 =?us-ascii?Q?ZO3nPLIlySqTnLdNzren/hRx+2O5C8ypGcSwHp9xdo8Ais15DTUGsejAMo8i?=
 =?us-ascii?Q?1LwSNTRlE+ITvi/HNjGPx0VEk7in/X2Si3uaJkvwnbSB1w/baZNGLIGZ2VU4?=
 =?us-ascii?Q?p/3CcEoJwad3rbJd6q0qh+cefjH/e9ly4+aQ97ahXh/rQpmjZn2vpclkrfhB?=
 =?us-ascii?Q?AO7mXg9xa0+8l2K9+Ag8S+kccX+mBoFKn+68WRlVWQUOthe5fM4YwVXGnTsh?=
 =?us-ascii?Q?EFJvEEMp5U886v83m2VeOA=3D?=
X-Microsoft-Antispam-Message-Info: s56xjRjj670LGi2ZplvgiJSmM6tsVRLub3qCLUqGBGXy5jmgGvlK91uW2FRhBJKYr72HZpFwfjKy/3iHGRFEvDxptT2DN0mMGiCfWrkuX1IOWIH5hnR/49X9szczGJ0TEuHK7TVR4S23+8wC/But/z8RIDJaowlPeqC+5YiRl7uKfgii9SR8ZBbpnWvA/gfPvidUYhE/Fa4B/U/fAek3upBjszTlrnzMTE4MASikjHCJz3cwj6OhK3uSon28H9CWEGBWUES6P/xKvvc+7kF+5lebSo8pgzCKI0ZWKe2wusQ1hQQ7RRNX5UmcRAwyiIcdDU+91Vhe24yq+wzCZpZ73jEy9gI3c0NEPak9SA/klV8=
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB1601;6:HEebVNO+atPKfuXhP14JEpccecFyrIcsCEZGDBRFCY+DvtYqtAX0nJMO8YNEgaq/3i1yDnJGl4Gx1ojWSt8//EcGFGyrm9cMp435uM3VPicGx8RVAFS1UjwQ+KUcEfcxEAOvU95uGPcAYmAd1hMa6H/uNs9rJQJsZSbz0aXMdrDeQdzukPFfVy6jIDu2fR6lNpmVYG/S/+JJHqwhHL4wiWonA1bm3prNmSmXVy5j9F0oj8wED38MXOePlQ3k5Vz4KfAfIs2g9iOMD0VnEjOr7FyHc4qAzTQSe5LoDhOEZMzFcj786itzir/osY9BuwNz/qKfj59plnylDJWlIvUMA1JZV9/QPxAJ6z38XYQpWW6xYeIlXI9rdqkXzGow6R4oPOTylQ7eJ/nAe/fIinRclIde6P14YGFn747Adhqei4ynpQ92aVnCZINP4Q1yQt3CMK5ksjXdmvacdcW/bt0H3Q==;5:CjVJfViMFPGAtTsPLP/ir00YQTmMurYrEdL0Qgq9+XGpct/2rjbUWqXRvO9+ApjCIlc9PkSTMa47bnotYtiAlmKogvH9V0Whu5RbMj3S1LttohpWibSlxDTWJtwi6jMhOB1cno45af+ZIA1+GKMqQfqUgfmlQ2G8Tiu7j+WHSmw=;7:sC+fEKoRZMx+G2tXO4leh39oWpExPfDQ5o8UJOnKFlcI5g1GWy5AOtSMaPaLod4D7U0ESW5MXE4kfa9fwIWCGSP8SZIbcZ93cKYFa/xJVcz2uk+DwWU1vsSqBDyQwvoezx8BlXbbZg34dzyikYIj36kWlUhfNRA7gEkoxGAvx5H/a8nCmZAZPXeb3ZG+roXESQz7ranH7LSlkfWAaFjDVpLHWnKwXAzIbWgpCxV5KUaVozYzSk6dkLOMdIo7oL+8
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2018 07:47:04.8788
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8f72fa8-c413-4ce2-a8fe-08d62e849360
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR04MB1601
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

Add driver for the Clock Control Module found on i.MX8MQ.

This is largely based on the downstream driver from Anson Huang and
Bai Ping at NXP, plus the imx composite clock from Abel Vesa at NXP,
with only some small adaptions to mainline from me.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/clk/imx/Makefile     |   1 +
 drivers/clk/imx/clk-imx8mq.c | 602 +++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/imx/clk.h        |  36 +++
 3 files changed, 639 insertions(+)
 create mode 100644 drivers/clk/imx/clk-imx8mq.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 237444b..428548a 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -30,3 +30,4 @@ obj-$(CONFIG_SOC_IMX6SX) += clk-imx6sx.o
 obj-$(CONFIG_SOC_IMX6UL) += clk-imx6ul.o
 obj-$(CONFIG_SOC_IMX7D)  += clk-imx7d.o
 obj-$(CONFIG_SOC_VF610)  += clk-vf610.o
+obj-$(CONFIG_SOC_IMX8MQ) += clk-imx8mq.o
diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
new file mode 100644
index 0000000..cef080a
--- /dev/null
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -0,0 +1,602 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2018 NXP.
+ * Copyright (C) 2017 Pengutronix, Lucas Stach <kernel@pengutronix.de>
+ */
+
+#include <dt-bindings/clock/imx8mq-clock.h>
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/types.h>
+
+#include "clk.h"
+
+static u32 share_count_sai1;
+static u32 share_count_sai2;
+static u32 share_count_sai3;
+static u32 share_count_sai4;
+static u32 share_count_sai5;
+static u32 share_count_sai6;
+static u32 share_count_dcss;
+static u32 share_count_nand;
+
+static struct clk *clks[IMX8MQ_CLK_END];
+
+static const char *pll_ref_sels[] = { "osc_25m", "osc_27m", "dummy", "dummy", };
+static const char *arm_pll_bypass_sels[] = {"arm_pll", "arm_pll_ref_sel", };
+static const char *gpu_pll_bypass_sels[] = {"gpu_pll", "gpu_pll_ref_sel", };
+static const char *vpu_pll_bypass_sels[] = {"vpu_pll", "vpu_pll_ref_sel", };
+static const char *audio_pll1_bypass_sels[] = {"audio_pll1", "audio_pll1_ref_sel", };
+static const char *audio_pll2_bypass_sels[] = {"audio_pll2", "audio_pll2_ref_sel", };
+static const char *video_pll1_bypass_sels[] = {"video_pll1", "video_pll1_ref_sel", };
+
+static const char *sys1_pll1_out_sels[] = {"sys1_pll1", "sys1_pll1_ref_sel", };
+static const char *sys2_pll1_out_sels[] = {"sys2_pll1", "sys1_pll1_ref_sel", };
+static const char *sys3_pll1_out_sels[] = {"sys3_pll1", "sys3_pll1_ref_sel", };
+static const char *dram_pll1_out_sels[] = {"dram_pll1", "dram_pll1_ref_sel", };
+
+static const char *sys1_pll2_out_sels[] = {"sys1_pll2_div", "sys1_pll1_ref_sel", };
+static const char *sys2_pll2_out_sels[] = {"sys2_pll2_div", "sys2_pll1_ref_sel", };
+static const char *sys3_pll2_out_sels[] = {"sys3_pll2_div", "sys2_pll1_ref_sel", };
+static const char *dram_pll2_out_sels[] = {"dram_pll2_div", "dram_pll1_ref_sel", };
+
+/* CCM ROOT */
+static const char *imx8mq_a53_sels[] = {"osc_25m", "arm_pll_out", "sys2_pll_500m", "sys2_pll_1000m",
+					"sys1_pll_800m", "sys1_pll_400m", "audio_pll1_out", "sys3_pll2_out", };
+
+static const char *imx8mq_vpu_sels[] = {"osc_25m", "arm_pll_out", "sys2_pll_500m", "sys2_pll_1000m",
+					"sys1_pll_800m", "sys1_pll_400m", "audio_pll1_out", "vpu_pll_out", };
+
+static const char *imx8mq_gpu_core_sels[] = {"osc_25m", "gpu_pll_out", "sys1_pll_800m", "sys3_pll2_out",
+					     "sys2_pll_1000m", "audio_pll1_out", "video_pll1_out", "audio_pll2_out", };
+
+static const char *imx8mq_gpu_shader_sels[] = {"osc_25m", "gpu_pll_out", "sys1_pll_800m", "sys3_pll2_out",
+					       "sys2_pll_1000m", "audio_pll1_out", "video_pll1_out", "audio_pll2_out", };
+
+static const char *imx8mq_main_axi_sels[] = {"osc_25m", "sys2_pll_333m", "sys1_pll_800m", "sys2_pll_250m",
+					     "sys2_pll_1000m", "audio_pll1_out", "video_pll1_out", "sys1_pll_100m",};
+
+static const char *imx8mq_enet_axi_sels[] = {"osc_25m", "sys1_pll_266m", "sys1_pll_800m", "sys2_pll_250m",
+					     "sys2_pll_200m", "audio_pll1_out", "video_pll1_out", "sys3_pll2_out", };
+
+static const char *imx8mq_nand_usdhc_sels[] = {"osc_25m", "sys1_pll_266m", "sys1_pll_800m", "sys2_pll_200m",
+					       "sys1_pll_133m", "sys3_pll2_out", "sys2_pll_250m", "audio_pll1_out", };
+
+static const char *imx8mq_vpu_bus_sels[] = {"osc_25m", "sys1_pll_800m", "vpu_pll_out", "audio_pll2_out", "sys3_pll2_out", "sys2_pll_1000m", "sys2_pll_200m", "sys1_pll_100m", };
+
+static const char *imx8mq_disp_axi_sels[] = {"osc_25m", "sys2_pll_125m", "sys1_pll_800m", "sys3_pll2_out", "sys1_pll_400m", "audio_pll2_out", "clk_ext1", "clk_ext4", };
+
+static const char *imx8mq_disp_apb_sels[] = {"osc_25m", "sys2_pll_125m", "sys1_pll_800m", "sys3_pll2_out",
+					     "sys1_pll_40m", "audio_pll2_out", "clk_ext1", "clk_ext3", };
+
+static const char *imx8mq_disp_rtrm_sels[] = {"osc_25m", "sys1_pll_800m", "sys2_pll_200m", "sys1_pll_400m",
+					      "audio_pll1_out", "video_pll1_out", "clk_ext2", "clk_ext3", };
+
+static const char *imx8mq_usb_bus_sels[] = {"osc_25m", "sys2_pll_500m", "sys1_pll_800m", "sys2_pll_100m",
+					    "sys2_pll_200m", "clk_ext2", "clk_ext4", "audio_pll2_out", };
+
+static const char *imx8mq_gpu_axi_sels[] = {"osc_25m", "sys1_pll_800m", "gpu_pll_out", "sys3_pll2_out", "sys2_pll_1000m",
+					    "audio_pll1_out", "video_pll1_out", "audio_pll2_out", };
+
+static const char *imx8mq_gpu_ahb_sels[] = {"osc_25m", "sys1_pll_800m", "gpu_pll_out", "sys3_pll2_out", "sys2_pll_1000m",
+					    "audio_pll1_out", "video_pll1_out", "audio_pll2_out", };
+
+static const char *imx8mq_noc_sels[] = {"osc_25m", "sys1_pll_800m", "sys3_pll2_out", "sys2_pll_1000m", "sys2_pll_500m",
+					"audio_pll1_out", "video_pll1_out", "audio_pll2_out", };
+
+static const char *imx8mq_noc_apb_sels[] = {"osc_25m", "sys1_pll_400m", "sys3_pll2_out", "sys2_pll_333m", "sys2_pll_200m",
+					    "sys1_pll_800m", "audio_pll1_out", "video_pll1_out", };
+
+static const char *imx8mq_ahb_sels[] = {"osc_25m", "sys1_pll_133m", "sys1_pll_800m", "sys1_pll_400m",
+					"sys2_pll_125m", "sys3_pll2_out", "audio_pll1_out", "video_pll1_out", };
+
+static const char *imx8mq_audio_ahb_sels[] = {"osc_25m", "sys2_pll_500m", "sys1_pll_800m", "sys2_pll_1000m",
+						  "sys2_pll_166m", "sys3_pll2_out", "audio_pll1_out", "video_pll1_out", };
+
+static const char *imx8mq_dsi_ahb_sels[] = {"osc_25m", "sys2_pll_100m", "sys1_pll_80m", "sys1_pll_800m",
+						"sys2_pll_1000m", "sys3_pll2_out", "clk_ext3", "audio_pll2_out"};
+
+static const char *imx8mq_dram_alt_sels[] = {"osc_25m", "sys1_pll_800m", "sys1_pll_100m", "sys2_pll_500m",
+						"sys2_pll_250m", "sys1_pll_400m", "audio_pll1_out", "sys1_pll_266m", };
+
+static const char *imx8mq_dram_apb_sels[] = {"osc_25m", "sys2_pll_200m", "sys1_pll_40m", "sys1_pll_160m",
+						"sys1_pll_800m", "sys3_pll2_out", "sys2_pll_250m", "audio_pll2_out", };
+
+static const char *imx8mq_vpu_g1_sels[] = {"osc_25m", "vpu_pll_out", "sys1_pll_800m", "sys2_pll_1000m", "sys1_pll_100m", "sys2_pll_125m", "sys3_pll2_out", "audio_pll1_out", };
+
+static const char *imx8mq_vpu_g2_sels[] = {"osc_25m", "vpu_pll_out", "sys1_pll_800m", "sys2_pll_1000m", "sys1_pll_100m", "sys2_pll_125m", "sys3_pll2_out", "audio_pll1_out", };
+
+static const char *imx8mq_disp_dtrc_sels[] = {"osc_25m", "vpu_pll_out", "sys1_pll_800m", "sys2_pll_1000m", "sys1_pll_160m", "sys2_pll_100m", "sys3_pll2_out", "audio_pll2_out", };
+
+static const char *imx8mq_disp_dc8000_sels[] = {"osc_25m", "vpu_pll_out", "sys1_pll_800m", "sys2_pll_1000m", "sys1_pll_160m", "sys2_pll_100m", "sys3_pll2_out", "audio_pll2_out", };
+
+static const char *imx8mq_pcie1_ctrl_sels[] = {"osc_25m", "sys2_pll_250m", "sys2_pll_200m", "sys1_pll_266m",
+					       "sys1_pll_800m", "sys2_pll_500m", "sys2_pll_250m", "sys3_pll2_out", };
+
+static const char *imx8mq_pcie1_phy_sels[] = {"osc_25m", "sys2_pll_100m", "sys2_pll_500m", "clk_ext1", "clk_ext2",
+					      "clk_ext3", "clk_ext4", };
+
+static const char *imx8mq_pcie1_aux_sels[] = {"osc_25m", "sys2_pll_200m", "sys2_pll_500m", "sys3_pll2_out",
+					      "sys2_pll_100m", "sys1_pll_80m", "sys1_pll_160m", "sys1_pll_200m", };
+
+static const char *imx8mq_dc_pixel_sels[] = {"osc_25m", "video_pll1_out", "audio_pll2_out", "audio_pll1_out", "sys1_pll_800m", "sys2_pll_1000m", "sys3_pll2_out", "clk_ext4", };
+
+static const char *imx8mq_lcdif_pixel_sels[] = {"osc_25m", "video_pll1_out", "audio_pll2_out", "audio_pll1_out", "sys1_pll_800m", "sys2_pll_1000m", "sys3_pll2_out", "clk_ext4", };
+
+static const char *imx8mq_sai1_sels[] = {"osc_25m", "audio_pll1_out", "audio_pll2_out", "video_pll1_out", "sys1_pll_133m", "osc_27m", "clk_ext1", "clk_ext2", };
+
+static const char *imx8mq_sai2_sels[] = {"osc_25m", "audio_pll1_out", "audio_pll2_out", "video_pll1_out", "sys1_pll_133m", "osc_27m", "clk_ext2", "clk_ext3", };
+
+static const char *imx8mq_sai3_sels[] = {"osc_25m", "audio_pll1_out", "audio_pll2_out", "video_pll1_out", "sys1_pll_133m", "osc_27m", "clk_ext3", "clk_ext4", };
+
+static const char *imx8mq_sai4_sels[] = {"osc_25m", "audio_pll1_out", "audio_pll2_out", "video_pll1_out", "sys1_pll_133m", "osc_27m", "clk_ext1", "clk_ext2", };
+
+static const char *imx8mq_sai5_sels[] = {"osc_25m", "audio_pll1_out", "audio_pll2_out", "video_pll1_out", "sys1_pll_133m", "osc_27m", "clk_ext2", "clk_ext3", };
+
+static const char *imx8mq_sai6_sels[] = {"osc_25m", "audio_pll1_out", "audio_pll2_out", "video_pll1_out", "sys1_pll_133m", "osc_27m", "clk_ext3", "clk_ext4", };
+
+static const char *imx8mq_spdif1_sels[] = {"osc_25m", "audio_pll1_out", "audio_pll2_out", "video_pll1_out", "sys1_pll_133m", "osc_27m", "clk_ext2", "clk_ext3", };
+
+static const char *imx8mq_spdif2_sels[] = {"osc_25m", "audio_pll1_out", "audio_pll2_out", "video_pll1_out", "sys1_pll_133m", "osc_27m", "clk_ext3", "clk_ext4", };
+
+static const char *imx8mq_enet_ref_sels[] = {"osc_25m", "sys2_pll_125m", "sys2_pll_500m", "sys2_pll_100m",
+					     "sys1_pll_160m", "audio_pll1_out", "video_pll1_out", "clk_ext4", };
+
+static const char *imx8mq_enet_timer_sels[] = {"osc_25m", "sys2_pll_100m", "audio_pll1_out", "clk_ext1", "clk_ext2",
+					       "clk_ext3", "clk_ext4", "video_pll1_out", };
+
+static const char *imx8mq_enet_phy_sels[] = {"osc_25m", "sys2_pll_50m", "sys2_pll_125m", "sys2_pll_500m",
+					     "audio_pll1_out", "video_pll1_out", "audio_pll2_out", };
+
+static const char *imx8mq_nand_sels[] = {"osc_25m", "sys2_pll_500m", "audio_pll1_out", "sys1_pll_400m",
+					 "audio_pll2_out", "sys3_pll2_out", "sys2_pll_250m", "video_pll1_out", };
+
+static const char *imx8mq_qspi_sels[] = {"osc_25m", "sys1_pll_400m", "sys1_pll_800m", "sys2_pll_500m",
+					 "audio_pll2_out", "sys1_pll_266m", "sys3_pll2_out", "sys1_pll_100m", };
+
+static const char *imx8mq_usdhc1_sels[] = {"osc_25m", "sys1_pll_400m", "sys1_pll_800m", "sys2_pll_500m",
+					 "audio_pll2_out", "sys1_pll_266m", "sys3_pll2_out", "sys1_pll_100m", };
+
+static const char *imx8mq_usdhc2_sels[] = {"osc_25m", "sys1_pll_400m", "sys1_pll_800m", "sys2_pll_500m",
+					 "audio_pll2_out", "sys1_pll_266m", "sys3_pll2_out", "sys1_pll_100m", };
+
+static const char *imx8mq_i2c1_sels[] = {"osc_25m", "sys1_pll_160m", "sys2_pll_50m", "sys3_pll2_out", "audio_pll1_out",
+					 "video_pll1_out", "audio_pll2_out", "sys1_pll_133m", };
+
+static const char *imx8mq_i2c2_sels[] = {"osc_25m", "sys1_pll_160m", "sys2_pll_50m", "sys3_pll2_out", "audio_pll1_out",
+					 "video_pll1_out", "audio_pll2_out", "sys1_pll_133m", };
+
+static const char *imx8mq_i2c3_sels[] = {"osc_25m", "sys1_pll_160m", "sys2_pll_50m", "sys3_pll2_out", "audio_pll1_out",
+					 "video_pll1_out", "audio_pll2_out", "sys1_pll_133m", };
+
+static const char *imx8mq_i2c4_sels[] = {"osc_25m", "sys1_pll_160m", "sys2_pll_50m", "sys3_pll2_out", "audio_pll1_out",
+					 "video_pll1_out", "audio_pll2_out", "sys1_pll_133m", };
+
+static const char *imx8mq_uart1_sels[] = {"osc_25m", "sys1_pll_80m", "sys2_pll_200m", "sys2_pll_100m",
+					  "sys3_pll2_out", "clk_ext2", "clk_ext4", "audio_pll2_out", };
+
+static const char *imx8mq_uart2_sels[] = {"osc_25m", "sys1_pll_80m", "sys2_pll_200m", "sys2_pll_100m",
+					  "sys3_pll2_out", "clk_ext2", "clk_ext3", "audio_pll2_out", };
+
+static const char *imx8mq_uart3_sels[] = {"osc_25m", "sys1_pll_80m", "sys2_pll_200m", "sys2_pll_100m",
+					  "sys3_pll2_out", "clk_ext2", "clk_ext4", "audio_pll2_out", };
+
+static const char *imx8mq_uart4_sels[] = {"osc_25m", "sys1_pll_80m", "sys2_pll_200m", "sys2_pll_100m",
+					  "sys3_pll2_out", "clk_ext2", "clk_ext3", "audio_pll2_out", };
+
+static const char *imx8mq_usb_core_sels[] = {"osc_25m", "sys1_pll_100m", "sys1_pll_40m", "sys2_pll_100m",
+					     "sys2_pll_200m", "clk_ext2", "clk_ext3", "audio_pll2_out", };
+
+static const char *imx8mq_usb_phy_sels[] = {"osc_25m", "sys1_pll_100m", "sys1_pll_40m", "sys2_pll_100m",
+					     "sys2_pll_200m", "clk_ext2", "clk_ext3", "audio_pll2_out", };
+
+static const char *imx8mq_ecspi1_sels[] = {"osc_25m", "sys2_pll_200m", "sys1_pll_40m", "sys1_pll_160m",
+					   "sys1_pll_800m", "sys3_pll2_out", "sys2_pll_250m", "audio_pll2_out", };
+
+static const char *imx8mq_ecspi2_sels[] = {"osc_25m", "sys2_pll_200m", "sys1_pll_40m", "sys1_pll_160m",
+					   "sys1_pll_800m", "sys3_pll2_out", "sys2_pll_250m", "audio_pll2_out", };
+
+static const char *imx8mq_pwm1_sels[] = {"osc_25m", "sys2_pll_100m", "sys1_pll_160m", "sys1_pll_40m",
+					 "sys3_pll2_out", "clk_ext1", "sys1_pll_80m", "video_pll1_out", };
+
+static const char *imx8mq_pwm2_sels[] = {"osc_25m", "sys2_pll_100m", "sys1_pll_160m", "sys1_pll_40m",
+					 "sys3_pll2_out", "clk_ext1", "sys1_pll_80m", "video_pll1_out", };
+
+static const char *imx8mq_pwm3_sels[] = {"osc_25m", "sys2_pll_100m", "sys1_pll_160m", "sys1_pll_40m",
+					 "sys3_pll2_out", "clk_ext2", "sys1_pll_80m", "video_pll1_out", };
+
+static const char *imx8mq_pwm4_sels[] = {"osc_25m", "sys2_pll_100m", "sys1_pll_160m", "sys1_pll_40m",
+					 "sys3_pll2_out", "clk_ext2", "sys1_pll_80m", "video_pll1_out", };
+
+static const char *imx8mq_gpt1_sels[] = {"osc_25m", "sys2_pll_100m", "sys1_pll_400m", "sys1_pll_40m",
+					 "sys1_pll_80m", "audio_pll1_out", "clk_ext1", };
+
+static const char *imx8mq_wdog_sels[] = {"osc_25m", "sys1_pll_133m", "sys1_pll_160m", "vpu_pll_out",
+					 "sys2_pll_125m", "sys3_pll2_out", "sys1_pll_80m", "sys2_pll_166m", };
+
+static const char *imx8mq_wrclk_sels[] = {"osc_25m", "sys1_pll_40m", "vpu_pll_out", "sys3_pll2_out", "sys2_pll_200m",
+					  "sys1_pll_266m", "sys2_pll_500m", "sys1_pll_100m", };
+
+static const char *imx8mq_dsi_core_sels[] = {"osc_25m", "sys1_pll_266m", "sys2_pll_250m", "sys1_pll_800m",
+					     "sys2_pll_1000m", "sys3_pll2_out", "audio_pll2_out", "video_pll1_out", };
+
+static const char *imx8mq_dsi_phy_sels[] = {"osc_25m", "sys2_pll_125m", "sys2_pll_100m", "sys1_pll_800m",
+					    "sys2_pll_1000m", "clk_ext2", "audio_pll2_out", "video_pll1_out", };
+
+static const char *imx8mq_dsi_dbi_sels[] = {"osc_25m", "sys1_pll_266m", "sys2_pll_100m", "sys1_pll_800m",
+					    "sys2_pll_1000m", "sys3_pll2_out", "audio_pll2_out", "video_pll1_out", };
+
+static const char *imx8mq_dsi_esc_sels[] = {"osc_25m", "sys2_pll_100m", "sys1_pll_80m", "sys1_pll_800m",
+					    "sys2_pll_1000m", "sys3_pll2_out", "clk_ext3", "audio_pll2_out", };
+
+static const char *imx8mq_csi1_core_sels[] = {"osc_25m", "sys1_pll_266m", "sys2_pll_250m", "sys1_pll_800m",
+					      "sys2_pll_1000m", "sys3_pll2_out", "audio_pll2_out", "video_pll1_out", };
+
+static const char *imx8mq_csi1_phy_sels[] = {"osc_25m", "sys2_pll_125m", "sys2_pll_100m", "sys1_pll_800m",
+					     "sys2_pll_1000m", "clk_ext2", "audio_pll2_out", "video_pll1_out", };
+
+static const char *imx8mq_csi1_esc_sels[] = {"osc_25m", "sys2_pll_100m", "sys1_pll_80m", "sys1_pll_800m",
+					     "sys2_pll_1000m", "sys3_pll2_out", "clk_ext3", "audio_pll2_out", };
+
+static const char *imx8mq_csi2_core_sels[] = {"osc_25m", "sys1_pll_266m", "sys2_pll_250m", "sys1_pll_800m",
+					      "sys2_pll_1000m", "sys3_pll2_out", "audio_pll2_out", "video_pll1_out", };
+
+static const char *imx8mq_csi2_phy_sels[] = {"osc_25m", "sys2_pll_125m", "sys2_pll_100m", "sys1_pll_800m",
+					     "sys2_pll_1000m", "clk_ext2", "audio_pll2_out", "video_pll1_out", };
+
+static const char *imx8mq_csi2_esc_sels[] = {"osc_25m", "sys2_pll_100m", "sys1_pll_80m", "sys1_pll_800m",
+					     "sys2_pll_1000m", "sys3_pll2_out", "clk_ext3", "audio_pll2_out", };
+
+static const char *imx8mq_pcie2_ctrl_sels[] = {"osc_25m", "sys2_pll_250m", "sys2_pll_200m", "sys1_pll_266m",
+					       "sys1_pll_800m", "sys2_pll_500m", "sys2_pll_333m", "sys3_pll2_out", };
+
+static const char *imx8mq_pcie2_phy_sels[] = {"osc_25m", "sys2_pll_100m", "sys2_pll_500m", "clk_ext1",
+					      "clk_ext2", "clk_ext3", "clk_ext4", "sys1_pll_400m", };
+
+static const char *imx8mq_pcie2_aux_sels[] = {"osc_25m", "sys2_pll_200m", "sys2_pll_50m", "sys3_pll2_out",
+					      "sys2_pll_100m", "sys1_pll_80m", "sys1_pll_160m", "sys1_pll_200m", };
+
+static const char *imx8mq_ecspi3_sels[] = {"osc_25m", "sys2_pll_200m", "sys1_pll_40m", "sys1_pll_160m",
+					   "sys1_pll_800m", "sys3_pll2_out", "sys2_pll_250m", "audio_pll2_out", };
+static const char *imx8mq_dram_core_sels[] = {"dram_pll_out", "dram_alt_root", };
+
+static const char *imx8mq_clko2_sels[] = {"osc_25m", "sys2_pll_200m", "sys1_pll_400m", "sys2_pll_166m", "audio_pll1_out",
+					 "video_pll1_out", "ckil", };
+
+static struct clk_onecell_data clk_data;
+
+static void __init imx8mq_clocks_init(struct device_node *ccm_node)
+{
+	struct device_node *np;
+	void __iomem *base;
+	int i;
+
+	clks[IMX8MQ_CLK_DUMMY] = imx_clk_fixed("dummy", 0);
+	clks[IMX8MQ_CLK_32K] = of_clk_get_by_name(ccm_node, "ckil");
+	clks[IMX8MQ_CLK_25M] = of_clk_get_by_name(ccm_node, "osc_25m");
+	clks[IMX8MQ_CLK_27M] = of_clk_get_by_name(ccm_node, "osc_27m");
+	clks[IMX8MQ_CLK_EXT1] = of_clk_get_by_name(ccm_node, "clk_ext1");
+	clks[IMX8MQ_CLK_EXT2] = of_clk_get_by_name(ccm_node, "clk_ext2");
+	clks[IMX8MQ_CLK_EXT3] = of_clk_get_by_name(ccm_node, "clk_ext3");
+	clks[IMX8MQ_CLK_EXT4] = of_clk_get_by_name(ccm_node, "clk_ext4");
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mq-anatop");
+	base = of_iomap(np, 0);
+	WARN_ON(!base);
+
+	clks[IMX8MQ_ARM_PLL_REF_SEL] = imx_clk_mux("arm_pll_ref_sel", base + 0x28, 16, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
+	clks[IMX8MQ_GPU_PLL_REF_SEL] = imx_clk_mux("gpu_pll_ref_sel", base + 0x18, 16, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
+	clks[IMX8MQ_VPU_PLL_REF_SEL] = imx_clk_mux("vpu_pll_ref_sel", base + 0x20, 16, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
+	clks[IMX8MQ_AUDIO_PLL1_REF_SEL] = imx_clk_mux("audio_pll1_ref_sel", base + 0x0, 16, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
+	clks[IMX8MQ_AUDIO_PLL2_REF_SEL] = imx_clk_mux("audio_pll2_ref_sel", base + 0x8, 16, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
+	clks[IMX8MQ_VIDEO_PLL1_REF_SEL] = imx_clk_mux("video_pll1_ref_sel", base + 0x10, 16, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
+	clks[IMX8MQ_SYS1_PLL1_REF_SEL]	= imx_clk_mux("sys1_pll1_ref_sel", base + 0x30, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
+	clks[IMX8MQ_SYS2_PLL1_REF_SEL]	= imx_clk_mux("sys2_pll1_ref_sel", base + 0x3c, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
+	clks[IMX8MQ_SYS3_PLL1_REF_SEL]	= imx_clk_mux("sys3_pll1_ref_sel", base + 0x48, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
+	clks[IMX8MQ_DRAM_PLL1_REF_SEL]	= imx_clk_mux("dram_pll1_ref_sel", base + 0x60, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
+
+	clks[IMX8MQ_ARM_PLL_REF_DIV]	= imx_clk_divider("arm_pll_ref_div", "arm_pll_ref_sel", base + 0x28, 5, 6);
+	clks[IMX8MQ_GPU_PLL_REF_DIV]	= imx_clk_divider("gpu_pll_ref_div", "gpu_pll_ref_sel", base + 0x18, 5, 6);
+	clks[IMX8MQ_VPU_PLL_REF_DIV]	= imx_clk_divider("vpu_pll_ref_div", "vpu_pll_ref_sel", base + 0x20, 5, 6);
+	clks[IMX8MQ_AUDIO_PLL1_REF_DIV] = imx_clk_divider("audio_pll1_ref_div", "audio_pll1_ref_sel", base + 0x0, 5, 6);
+	clks[IMX8MQ_AUDIO_PLL2_REF_DIV] = imx_clk_divider("audio_pll2_ref_div", "audio_pll2_ref_sel", base + 0x8, 5, 6);
+	clks[IMX8MQ_VIDEO_PLL1_REF_DIV] = imx_clk_divider("video_pll1_ref_div", "video_pll1_ref_sel", base + 0x10, 5, 6);
+	clks[IMX8MQ_SYS1_PLL1_REF_DIV]	= imx_clk_divider("sys1_pll1_ref_div", "sys1_pll1_ref_sel", base + 0x38, 25, 3);
+	clks[IMX8MQ_SYS2_PLL1_REF_DIV]	= imx_clk_divider("sys2_pll1_ref_div", "sys2_pll1_ref_sel", base + 0x44, 25, 3);
+	clks[IMX8MQ_SYS3_PLL1_REF_DIV]	= imx_clk_divider("sys3_pll1_ref_div", "sys3_pll1_ref_sel", base + 0x50, 25, 3);
+	clks[IMX8MQ_DRAM_PLL1_REF_DIV]	= imx_clk_divider("dram_pll1_ref_div", "dram_pll1_ref_sel", base + 0x68, 25, 3);
+
+	clks[IMX8MQ_ARM_PLL] = imx_clk_frac_pll("arm_pll", "arm_pll_ref_div", base + 0x28);
+	clks[IMX8MQ_GPU_PLL] = imx_clk_frac_pll("gpu_pll", "gpu_pll_ref_div", base + 0x18);
+	clks[IMX8MQ_VPU_PLL] = imx_clk_frac_pll("vpu_pll", "vpu_pll_ref_div", base + 0x20);
+	clks[IMX8MQ_AUDIO_PLL1] = imx_clk_frac_pll("audio_pll1", "audio_pll1_ref_div", base + 0x0);
+	clks[IMX8MQ_AUDIO_PLL2] = imx_clk_frac_pll("audio_pll2", "audio_pll2_ref_div", base + 0x8);
+	clks[IMX8MQ_VIDEO_PLL1] = imx_clk_frac_pll("video_pll1", "video_pll1_ref_div", base + 0x10);
+	clks[IMX8MQ_SYS1_PLL1] = imx_clk_sccg_pll("sys1_pll1", "sys1_pll1_ref_div", base + 0x30, SCCG_PLL1);
+	clks[IMX8MQ_SYS2_PLL1] = imx_clk_sccg_pll("sys2_pll1", "sys2_pll1_ref_div", base + 0x3c, SCCG_PLL1);
+	clks[IMX8MQ_SYS3_PLL1] = imx_clk_sccg_pll("sys3_pll1", "sys3_pll1_ref_div", base + 0x48, SCCG_PLL1);
+	clks[IMX8MQ_DRAM_PLL1] = imx_clk_sccg_pll("dram_pll1", "dram_pll1_ref_div", base + 0x60, SCCG_PLL1);
+
+	clks[IMX8MQ_SYS1_PLL2] = imx_clk_sccg_pll("sys1_pll2", "sys1_pll1_out_div", base + 0x30, SCCG_PLL2);
+	clks[IMX8MQ_SYS2_PLL2] = imx_clk_sccg_pll("sys2_pll2", "sys2_pll1_out_div", base + 0x3c, SCCG_PLL2);
+	clks[IMX8MQ_SYS3_PLL2] = imx_clk_sccg_pll("sys3_pll2", "sys3_pll1_out_div", base + 0x48, SCCG_PLL2);
+	clks[IMX8MQ_DRAM_PLL2] = imx_clk_sccg_pll("dram_pll2", "dram_pll1_out_div", base + 0x60, SCCG_PLL2);
+
+	/* PLL divs */
+	clks[IMX8MQ_SYS1_PLL1_OUT_DIV] = imx_clk_divider("sys1_pll1_out_div", "sys1_pll1_out", base + 0x38, 19, 6);
+	clks[IMX8MQ_SYS2_PLL1_OUT_DIV] = imx_clk_divider("sys2_pll1_out_div", "sys2_pll1_out", base + 0x44, 19, 6);
+	clks[IMX8MQ_SYS3_PLL1_OUT_DIV] = imx_clk_divider("sys3_pll1_out_div", "sys3_pll1_out", base + 0x50, 19, 6);
+	clks[IMX8MQ_DRAM_PLL1_OUT_DIV] = imx_clk_divider("dram_pll1_out_div", "dram_pll1_out", base + 0x68, 19, 6);
+	clks[IMX8MQ_SYS1_PLL2_DIV] = imx_clk_divider("sys1_pll2_div", "sys1_pll2", base + 0x38, 1, 6);
+	clks[IMX8MQ_SYS2_PLL2_DIV] = imx_clk_divider("sys2_pll2_div", "sys2_pll2", base + 0x44, 1, 6);
+	clks[IMX8MQ_SYS3_PLL2_DIV] = imx_clk_divider("sys3_pll2_div", "sys3_pll2", base + 0x50, 1, 6);
+	clks[IMX8MQ_DRAM_PLL2_DIV] = imx_clk_divider("dram_pll2_div", "dram_pll2", base + 0x68, 1, 6);
+
+	/* PLL bypass out */
+	clks[IMX8MQ_ARM_PLL_BYPASS] = imx_clk_mux("arm_pll_bypass", base + 0x28, 14, 1, arm_pll_bypass_sels, ARRAY_SIZE(arm_pll_bypass_sels));
+	clks[IMX8MQ_GPU_PLL_BYPASS] = imx_clk_mux("gpu_pll_bypass", base + 0x18, 14, 1, gpu_pll_bypass_sels, ARRAY_SIZE(gpu_pll_bypass_sels));
+	clks[IMX8MQ_VPU_PLL_BYPASS] = imx_clk_mux("vpu_pll_bypass", base + 0x20, 14, 1, vpu_pll_bypass_sels, ARRAY_SIZE(vpu_pll_bypass_sels));
+	clks[IMX8MQ_AUDIO_PLL1_BYPASS] = imx_clk_mux("audio_pll1_bypass", base + 0x0, 14, 1, audio_pll1_bypass_sels, ARRAY_SIZE(audio_pll1_bypass_sels));
+	clks[IMX8MQ_AUDIO_PLL2_BYPASS] = imx_clk_mux("audio_pll2_bypass", base + 0x8, 14, 1, audio_pll2_bypass_sels, ARRAY_SIZE(audio_pll2_bypass_sels));
+	clks[IMX8MQ_VIDEO_PLL1_BYPASS] = imx_clk_mux("video_pll1_bypass", base + 0x10, 14, 1, video_pll1_bypass_sels, ARRAY_SIZE(video_pll1_bypass_sels));
+
+	clks[IMX8MQ_SYS1_PLL1_OUT] = imx_clk_mux("sys1_pll1_out", base + 0x30, 5, 1, sys1_pll1_out_sels, ARRAY_SIZE(sys1_pll1_out_sels));
+	clks[IMX8MQ_SYS2_PLL1_OUT] = imx_clk_mux("sys2_pll1_out", base + 0x3c, 5, 1, sys2_pll1_out_sels, ARRAY_SIZE(sys2_pll1_out_sels));
+	clks[IMX8MQ_SYS3_PLL1_OUT] = imx_clk_mux("sys3_pll1_out", base + 0x48, 5, 1, sys3_pll1_out_sels, ARRAY_SIZE(sys3_pll1_out_sels));
+	clks[IMX8MQ_DRAM_PLL1_OUT] = imx_clk_mux("dram_pll1_out", base + 0x60, 5, 1, dram_pll1_out_sels, ARRAY_SIZE(dram_pll1_out_sels));
+	clks[IMX8MQ_SYS1_PLL2_OUT] = imx_clk_mux("sys1_pll2_out", base + 0x30, 4, 1, sys1_pll2_out_sels, ARRAY_SIZE(sys1_pll2_out_sels));
+	clks[IMX8MQ_SYS2_PLL2_OUT] = imx_clk_mux("sys2_pll2_out", base + 0x3c, 4, 1, sys2_pll2_out_sels, ARRAY_SIZE(sys2_pll2_out_sels));
+	clks[IMX8MQ_SYS3_PLL2_OUT] = imx_clk_mux("sys3_pll2_out", base + 0x48, 4, 1, sys3_pll2_out_sels, ARRAY_SIZE(sys3_pll2_out_sels));
+	clks[IMX8MQ_DRAM_PLL2_OUT] = imx_clk_mux("dram_pll2_out", base + 0x60, 4, 1, dram_pll2_out_sels, ARRAY_SIZE(dram_pll2_out_sels));
+
+	/* unbypass all the plls */
+	clk_set_parent(clks[IMX8MQ_GPU_PLL_BYPASS], clks[IMX8MQ_GPU_PLL]);
+	clk_set_parent(clks[IMX8MQ_VPU_PLL_BYPASS], clks[IMX8MQ_VPU_PLL]);
+	clk_set_parent(clks[IMX8MQ_AUDIO_PLL1_BYPASS], clks[IMX8MQ_AUDIO_PLL1]);
+	clk_set_parent(clks[IMX8MQ_AUDIO_PLL2_BYPASS], clks[IMX8MQ_AUDIO_PLL2]);
+	clk_set_parent(clks[IMX8MQ_VIDEO_PLL1_BYPASS], clks[IMX8MQ_VIDEO_PLL1]);
+	clk_set_parent(clks[IMX8MQ_SYS3_PLL1_OUT], clks[IMX8MQ_SYS3_PLL1]);
+	clk_set_parent(clks[IMX8MQ_SYS3_PLL2_OUT], clks[IMX8MQ_SYS3_PLL2_DIV]);
+
+	/* PLL OUT GATE */
+	clks[IMX8MQ_ARM_PLL_OUT] = imx_clk_gate("arm_pll_out", "arm_pll_bypass", base + 0x28, 21);
+	clks[IMX8MQ_GPU_PLL_OUT] = imx_clk_gate("gpu_pll_out", "gpu_pll_bypass", base + 0x18, 21);
+	clks[IMX8MQ_VPU_PLL_OUT] = imx_clk_gate("vpu_pll_out", "vpu_pll_bypass", base + 0x20, 21);
+	clks[IMX8MQ_AUDIO_PLL1_OUT] = imx_clk_gate("audio_pll1_out", "audio_pll1_bypass", base + 0x0, 21);
+	clks[IMX8MQ_AUDIO_PLL2_OUT] = imx_clk_gate("audio_pll2_out", "audio_pll2_bypass", base + 0x8, 21);
+	clks[IMX8MQ_VIDEO_PLL1_OUT] = imx_clk_gate("video_pll1_out", "video_pll1_bypass", base + 0x10, 21);
+	clks[IMX8MQ_SYS1_PLL_OUT] = imx_clk_gate("sys1_pll_out", "sys1_pll2_out", base + 0x30, 9);
+	clks[IMX8MQ_SYS2_PLL_OUT] = imx_clk_gate("sys2_pll_out", "sys2_pll2_out", base + 0x3c, 9);
+	clks[IMX8MQ_SYS3_PLL_OUT] = imx_clk_gate("sys3_pll_out", "sys3_pll2_out", base + 0x48, 9);
+	clks[IMX8MQ_DRAM_PLL_OUT] = imx_clk_gate("dram_pll_out", "dram_pll2_out", base + 0x60, 9);
+
+	/* SYS PLL fixed output */
+	clks[IMX8MQ_SYS1_PLL_40M] = imx_clk_fixed_factor("sys1_pll_40m", "sys1_pll_out", 1, 20);
+	clks[IMX8MQ_SYS1_PLL_80M] = imx_clk_fixed_factor("sys1_pll_80m", "sys1_pll_out", 1, 10);
+	clks[IMX8MQ_SYS1_PLL_100M] = imx_clk_fixed_factor("sys1_pll_100m", "sys1_pll_out", 1, 8);
+	clks[IMX8MQ_SYS1_PLL_133M] = imx_clk_fixed_factor("sys1_pll_133m", "sys1_pll_out", 1, 6);
+	clks[IMX8MQ_SYS1_PLL_160M] = imx_clk_fixed_factor("sys1_pll_160m", "sys1_pll_out", 1, 5);
+	clks[IMX8MQ_SYS1_PLL_200M] = imx_clk_fixed_factor("sys1_pll_200m", "sys1_pll_out", 1, 4);
+	clks[IMX8MQ_SYS1_PLL_266M] = imx_clk_fixed_factor("sys1_pll_266m", "sys1_pll_out", 1, 3);
+	clks[IMX8MQ_SYS1_PLL_400M] = imx_clk_fixed_factor("sys1_pll_400m", "sys1_pll_out", 1, 2);
+	clks[IMX8MQ_SYS1_PLL_800M] = imx_clk_fixed_factor("sys1_pll_800m", "sys1_pll_out", 1, 1);
+
+	clks[IMX8MQ_SYS2_PLL_50M] = imx_clk_fixed_factor("sys2_pll_50m", "sys2_pll_out", 1, 20);
+	clks[IMX8MQ_SYS2_PLL_100M] = imx_clk_fixed_factor("sys2_pll_100m", "sys2_pll_out", 1, 10);
+	clks[IMX8MQ_SYS2_PLL_125M] = imx_clk_fixed_factor("sys2_pll_125m", "sys2_pll_out", 1, 8);
+	clks[IMX8MQ_SYS2_PLL_166M] = imx_clk_fixed_factor("sys2_pll_166m", "sys2_pll_out", 1, 6);
+	clks[IMX8MQ_SYS2_PLL_200M] = imx_clk_fixed_factor("sys2_pll_200m", "sys2_pll_out", 1, 5);
+	clks[IMX8MQ_SYS2_PLL_250M] = imx_clk_fixed_factor("sys2_pll_250m", "sys2_pll_out", 1, 4);
+	clks[IMX8MQ_SYS2_PLL_333M] = imx_clk_fixed_factor("sys2_pll_333m", "sys2_pll_out", 1, 3);
+	clks[IMX8MQ_SYS2_PLL_500M] = imx_clk_fixed_factor("sys2_pll_500m", "sys2_pll_out", 1, 2);
+	clks[IMX8MQ_SYS2_PLL_1000M] = imx_clk_fixed_factor("sys2_pll_1000m", "sys2_pll_out", 1, 1);
+
+	np = ccm_node;
+	base = of_iomap(np, 0);
+	WARN_ON(!base);
+	/* CORE */
+	clks[IMX8MQ_CLK_A53_SRC] = imx_clk_mux2("arm_a53_src", base + 0x8000, 24, 3, imx8mq_a53_sels, ARRAY_SIZE(imx8mq_a53_sels));
+	clks[IMX8MQ_CLK_VPU_SRC] = imx_clk_mux2("vpu_src", base + 0x8100, 24, 3, imx8mq_vpu_sels, ARRAY_SIZE(imx8mq_vpu_sels));
+	clks[IMX8MQ_CLK_GPU_CORE_SRC] = imx_clk_mux2("gpu_core_src", base + 0x8180, 24, 3,  imx8mq_gpu_core_sels, ARRAY_SIZE(imx8mq_gpu_core_sels));
+	clks[IMX8MQ_CLK_GPU_SHADER_SRC] = imx_clk_mux2("gpu_shader_src", base + 0x8200, 24, 3, imx8mq_gpu_shader_sels,  ARRAY_SIZE(imx8mq_gpu_shader_sels));
+	clks[IMX8MQ_CLK_A53_CG] = imx_clk_gate3_flags("arm_a53_cg", "arm_a53_src", base + 0x8000, 28, CLK_IS_CRITICAL);
+	clks[IMX8MQ_CLK_VPU_CG] = imx_clk_gate3("vpu_cg", "vpu_src", base + 0x8100, 28);
+	clks[IMX8MQ_CLK_GPU_CORE_CG] = imx_clk_gate3("gpu_core_cg", "gpu_core_src", base + 0x8180, 28);
+	clks[IMX8MQ_CLK_GPU_SHADER_CG] = imx_clk_gate3("gpu_shader_cg", "gpu_shader_src", base + 0x8200, 28);
+
+	clks[IMX8MQ_CLK_A53_DIV] = imx_clk_divider2("arm_a53_div", "arm_a53_cg", base + 0x8000, 0, 3);
+	clks[IMX8MQ_CLK_VPU_DIV] = imx_clk_divider2("vpu_div", "vpu_cg", base + 0x8100, 0, 3);
+	clks[IMX8MQ_CLK_GPU_CORE_DIV] = imx_clk_divider2("gpu_core_div", "gpu_core_cg", base + 0x8180, 0, 3);
+	clks[IMX8MQ_CLK_GPU_SHADER_DIV] = imx_clk_divider2("gpu_shader_div", "gpu_shader_cg", base + 0x8200, 0, 3);
+
+	/* BUS */
+	clks[IMX8MQ_CLK_MAIN_AXI] = imx8m_clk_composite_critical("main_axi", imx8mq_main_axi_sels, base + 0x8800);
+	clks[IMX8MQ_CLK_ENET_AXI] = imx8m_clk_composite("enet_axi", imx8mq_enet_axi_sels, base + 0x8880);
+	clks[IMX8MQ_CLK_NAND_USDHC_BUS] = imx8m_clk_composite("nand_usdhc_bus", imx8mq_nand_usdhc_sels, base + 0x8900);
+	clks[IMX8MQ_CLK_VPU_BUS] = imx8m_clk_composite("vpu_bus", imx8mq_vpu_bus_sels, base + 0x8980);
+	clks[IMX8MQ_CLK_DISP_AXI] = imx8m_clk_composite("disp_axi", imx8mq_disp_axi_sels, base + 0x8a00);
+	clks[IMX8MQ_CLK_DISP_APB] = imx8m_clk_composite("disp_apb", imx8mq_disp_apb_sels, base + 0x8a80);
+	clks[IMX8MQ_CLK_DISP_RTRM] = imx8m_clk_composite("disp_rtrm", imx8mq_disp_rtrm_sels, base + 0x8b00);
+	clks[IMX8MQ_CLK_USB_BUS] = imx8m_clk_composite("usb_bus", imx8mq_usb_bus_sels, base + 0x8b80);
+	clks[IMX8MQ_CLK_GPU_AXI] = imx8m_clk_composite("gpu_axi", imx8mq_gpu_axi_sels, base + 0x8c00);
+	clks[IMX8MQ_CLK_GPU_AHB] = imx8m_clk_composite("gpu_ahb", imx8mq_gpu_ahb_sels, base + 0x8c80);
+	clks[IMX8MQ_CLK_NOC] = imx8m_clk_composite_critical("noc", imx8mq_noc_sels, base + 0x8d00);
+	clks[IMX8MQ_CLK_NOC_APB] = imx8m_clk_composite_critical("noc_apb", imx8mq_noc_apb_sels, base + 0x8d80);
+
+	/* AHB */
+	clks[IMX8MQ_CLK_AHB] = imx8m_clk_composite("ahb", imx8mq_ahb_sels, base + 0x9000);
+	clks[IMX8MQ_CLK_AUDIO_AHB] = imx8m_clk_composite("audio_ahb", imx8mq_audio_ahb_sels, base + 0x9100);
+
+	/* IPG */
+	clks[IMX8MQ_CLK_IPG_ROOT] = imx_clk_divider2("ipg_root", "ahb", base + 0x9080, 0, 1);
+	clks[IMX8MQ_CLK_IPG_AUDIO_ROOT] = imx_clk_divider2("ipg_audio_root", "audio_ahb", base + 0x9180, 0, 1);
+
+	/* IP */
+	clks[IMX8MQ_CLK_DRAM_CORE] = imx_clk_mux2_flags("dram_core_clk", base + 0x9800, 24, 1, imx8mq_dram_core_sels, ARRAY_SIZE(imx8mq_dram_core_sels), CLK_IS_CRITICAL);
+
+	clks[IMX8MQ_CLK_DRAM_ALT] = imx8m_clk_composite("dram_alt", imx8mq_dram_alt_sels, base + 0xa000);
+	clks[IMX8MQ_CLK_DRAM_APB] = imx8m_clk_composite_critical("dram_apb", imx8mq_dram_apb_sels, base + 0xa080);
+	clks[IMX8MQ_CLK_VPU_G1] = imx8m_clk_composite("vpu_g1", imx8mq_vpu_g1_sels, base + 0xa100);
+	clks[IMX8MQ_CLK_VPU_G2] = imx8m_clk_composite("vpu_g2", imx8mq_vpu_g2_sels, base + 0xa180);
+	clks[IMX8MQ_CLK_DISP_DTRC] = imx8m_clk_composite("disp_dtrc", imx8mq_disp_dtrc_sels, base + 0xa200);
+	clks[IMX8MQ_CLK_DISP_DC8000] = imx8m_clk_composite("disp_dc8000", imx8mq_disp_dc8000_sels, base + 0xa280);
+	clks[IMX8MQ_CLK_PCIE1_CTRL] = imx8m_clk_composite("pcie1_ctrl", imx8mq_pcie1_ctrl_sels, base + 0xa300);
+	clks[IMX8MQ_CLK_PCIE1_PHY] = imx8m_clk_composite("pcie1_phy", imx8mq_pcie1_phy_sels, base + 0xa380);
+	clks[IMX8MQ_CLK_PCIE1_AUX] = imx8m_clk_composite("pcie1_aux", imx8mq_pcie1_aux_sels, base + 0xa400);
+	clks[IMX8MQ_CLK_DC_PIXEL] = imx8m_clk_composite("dc_pixel", imx8mq_dc_pixel_sels, base + 0xa480);
+	clks[IMX8MQ_CLK_LCDIF_PIXEL] = imx8m_clk_composite("lcdif_pixel", imx8mq_lcdif_pixel_sels, base + 0xa500);
+	clks[IMX8MQ_CLK_SAI1] = imx8m_clk_composite("sai1", imx8mq_sai1_sels, base + 0xa580);
+	clks[IMX8MQ_CLK_SAI2] = imx8m_clk_composite("sai2", imx8mq_sai2_sels, base + 0xa600);
+	clks[IMX8MQ_CLK_SAI3] = imx8m_clk_composite("sai3", imx8mq_sai3_sels, base + 0xa680);
+	clks[IMX8MQ_CLK_SAI4] = imx8m_clk_composite("sai4", imx8mq_sai4_sels, base + 0xa700);
+	clks[IMX8MQ_CLK_SAI5] = imx8m_clk_composite("sai5", imx8mq_sai5_sels, base + 0xa780);
+	clks[IMX8MQ_CLK_SAI6] = imx8m_clk_composite("sai6", imx8mq_sai6_sels, base + 0xa800);
+	clks[IMX8MQ_CLK_SPDIF1] = imx8m_clk_composite("spdif1", imx8mq_spdif1_sels, base + 0xa880);
+	clks[IMX8MQ_CLK_SPDIF2] = imx8m_clk_composite("spdif2", imx8mq_spdif2_sels, base + 0xa900);
+	clks[IMX8MQ_CLK_ENET_REF] = imx8m_clk_composite("enet_ref", imx8mq_enet_ref_sels, base + 0xa980);
+	clks[IMX8MQ_CLK_ENET_TIMER] = imx8m_clk_composite("enet_timer", imx8mq_enet_timer_sels, base + 0xaa00);
+	clks[IMX8MQ_CLK_ENET_PHY_REF] = imx8m_clk_composite("enet_phy", imx8mq_enet_phy_sels, base + 0xaa80);
+	clks[IMX8MQ_CLK_NAND] = imx8m_clk_composite("nand", imx8mq_nand_sels, base + 0xab00);
+	clks[IMX8MQ_CLK_QSPI] = imx8m_clk_composite("qspi", imx8mq_qspi_sels, base + 0xab80);
+	clks[IMX8MQ_CLK_USDHC1] = imx8m_clk_composite("usdhc1", imx8mq_usdhc1_sels, base + 0xac00);
+	clks[IMX8MQ_CLK_USDHC2] = imx8m_clk_composite("usdhc2", imx8mq_usdhc2_sels, base + 0xac80);
+	clks[IMX8MQ_CLK_I2C1] = imx8m_clk_composite("i2c1", imx8mq_i2c1_sels, base + 0xad00);
+	clks[IMX8MQ_CLK_I2C2] = imx8m_clk_composite("i2c2", imx8mq_i2c2_sels, base + 0xad80);
+	clks[IMX8MQ_CLK_I2C3] = imx8m_clk_composite("i2c3", imx8mq_i2c3_sels, base + 0xae00);
+	clks[IMX8MQ_CLK_I2C4] = imx8m_clk_composite("i2c4", imx8mq_i2c4_sels, base + 0xae80);
+	clks[IMX8MQ_CLK_UART1] = imx8m_clk_composite("uart1", imx8mq_uart1_sels, base + 0xaf00);
+	clks[IMX8MQ_CLK_UART2] = imx8m_clk_composite("uart2", imx8mq_uart2_sels, base + 0xaf80);
+	clks[IMX8MQ_CLK_UART3] = imx8m_clk_composite("uart3", imx8mq_uart3_sels, base + 0xb000);
+	clks[IMX8MQ_CLK_UART4] = imx8m_clk_composite("uart4", imx8mq_uart4_sels, base + 0xb080);
+	clks[IMX8MQ_CLK_USB_CORE_REF] = imx8m_clk_composite("usb_core_ref", imx8mq_usb_core_sels, base + 0xb100);
+	clks[IMX8MQ_CLK_USB_PHY_REF] = imx8m_clk_composite("usb_phy_ref", imx8mq_usb_phy_sels, base + 0xb180);
+	clks[IMX8MQ_CLK_ECSPI1] = imx8m_clk_composite("ecspi1", imx8mq_ecspi1_sels, base + 0xb280);
+	clks[IMX8MQ_CLK_ECSPI2] = imx8m_clk_composite("ecspi2", imx8mq_ecspi2_sels, base + 0xb300);
+	clks[IMX8MQ_CLK_PWM1] = imx8m_clk_composite("pwm1", imx8mq_pwm1_sels, base + 0xb380);
+	clks[IMX8MQ_CLK_PWM2] = imx8m_clk_composite("pwm2", imx8mq_pwm2_sels, base + 0xb400);
+	clks[IMX8MQ_CLK_PWM3] = imx8m_clk_composite("pwm3", imx8mq_pwm3_sels, base + 0xb480);
+	clks[IMX8MQ_CLK_PWM4] = imx8m_clk_composite("pwm4", imx8mq_pwm4_sels, base + 0xb500);
+	clks[IMX8MQ_CLK_GPT1] = imx8m_clk_composite("gpt1", imx8mq_gpt1_sels, base + 0xb580);
+	clks[IMX8MQ_CLK_WDOG] = imx8m_clk_composite("wdog", imx8mq_wdog_sels, base + 0xb900);
+	clks[IMX8MQ_CLK_WRCLK] = imx8m_clk_composite("wrclk", imx8mq_wrclk_sels, base + 0xb980);
+	clks[IMX8MQ_CLK_CLKO2] = imx8m_clk_composite("clko2", imx8mq_clko2_sels, base + 0xba80);
+	clks[IMX8MQ_CLK_DSI_CORE] = imx8m_clk_composite("dsi_core", imx8mq_dsi_core_sels, base + 0xbb00);
+	clks[IMX8MQ_CLK_DSI_PHY_REF] = imx8m_clk_composite("dsi_phy_ref", imx8mq_dsi_phy_sels, base + 0xbb80);
+	clks[IMX8MQ_CLK_DSI_DBI] = imx8m_clk_composite("dsi_dbi", imx8mq_dsi_dbi_sels, base + 0xbc00);
+	clks[IMX8MQ_CLK_DSI_ESC] = imx8m_clk_composite("dsi_esc", imx8mq_dsi_esc_sels, base + 0xbc80);
+	clks[IMX8MQ_CLK_DSI_AHB] = imx8m_clk_composite("dsi_ahb", imx8mq_dsi_ahb_sels, base + 0x9200);
+	clks[IMX8MQ_CLK_CSI1_CORE] = imx8m_clk_composite("csi1_core", imx8mq_csi1_core_sels, base + 0xbd00);
+	clks[IMX8MQ_CLK_CSI1_PHY_REF] = imx8m_clk_composite("csi1_phy_ref", imx8mq_csi1_phy_sels, base + 0xbd80);
+	clks[IMX8MQ_CLK_CSI1_ESC] = imx8m_clk_composite("csi1_esc", imx8mq_csi1_esc_sels, base + 0xbe00);
+	clks[IMX8MQ_CLK_CSI2_CORE] = imx8m_clk_composite("csi2_core", imx8mq_csi2_core_sels, base + 0xbe80);
+	clks[IMX8MQ_CLK_CSI2_PHY_REF] = imx8m_clk_composite("csi2_phy_ref", imx8mq_csi2_phy_sels, base + 0xbf00);
+	clks[IMX8MQ_CLK_CSI2_ESC] = imx8m_clk_composite("csi2_esc", imx8mq_csi2_esc_sels, base + 0xbf80);
+	clks[IMX8MQ_CLK_PCIE2_CTRL] = imx8m_clk_composite("pcie2_ctrl", imx8mq_pcie2_ctrl_sels, base + 0xc000);
+	clks[IMX8MQ_CLK_PCIE2_PHY] = imx8m_clk_composite("pcie2_phy", imx8mq_pcie2_phy_sels, base + 0xc080);
+	clks[IMX8MQ_CLK_PCIE2_AUX] = imx8m_clk_composite("pcie2_aux", imx8mq_pcie2_aux_sels, base + 0xc100);
+	clks[IMX8MQ_CLK_ECSPI3] = imx8m_clk_composite("ecspi3", imx8mq_ecspi3_sels, base + 0xc180);
+
+	/*FIXME, the doc is not ready now */
+	clks[IMX8MQ_CLK_ECSPI1_ROOT] = imx_clk_gate4("ecspi1_root_clk", "ecspi1", base + 0x4070, 0);
+	clks[IMX8MQ_CLK_ECSPI2_ROOT] = imx_clk_gate4("ecspi2_root_clk", "ecspi2", base + 0x4080, 0);
+	clks[IMX8MQ_CLK_ECSPI3_ROOT] = imx_clk_gate4("ecspi3_root_clk", "ecspi3", base + 0x4090, 0);
+	clks[IMX8MQ_CLK_ENET1_ROOT] = imx_clk_gate4("enet1_root_clk", "enet_axi", base + 0x40a0, 0);
+	clks[IMX8MQ_CLK_GPT1_ROOT] = imx_clk_gate4("gpt1_root_clk", "gpt1", base + 0x4100, 0);
+	clks[IMX8MQ_CLK_I2C1_ROOT] = imx_clk_gate4("i2c1_root_clk", "i2c1", base + 0x4170, 0);
+	clks[IMX8MQ_CLK_I2C2_ROOT] = imx_clk_gate4("i2c2_root_clk", "i2c2", base + 0x4180, 0);
+	clks[IMX8MQ_CLK_I2C3_ROOT] = imx_clk_gate4("i2c3_root_clk", "i2c3", base + 0x4190, 0);
+	clks[IMX8MQ_CLK_I2C4_ROOT] = imx_clk_gate4("i2c4_root_clk", "i2c4", base + 0x41a0, 0);
+	clks[IMX8MQ_CLK_MU_ROOT] = imx_clk_gate4("mu_root_clk", "ipg_root", base + 0x4210, 0);
+	clks[IMX8MQ_CLK_OCOTP_ROOT] = imx_clk_gate4("ocotp_root_clk", "ipg_root", base + 0x4220, 0);
+	clks[IMX8MQ_CLK_PCIE1_ROOT] = imx_clk_gate4("pcie1_root_clk", "pcie1_ctrl", base + 0x4250, 0);
+	clks[IMX8MQ_CLK_PCIE2_ROOT] = imx_clk_gate4("pcie2_root_clk", "pcie2_ctrl", base + 0x4640, 0);
+	clks[IMX8MQ_CLK_PWM1_ROOT] = imx_clk_gate4("pwm1_root_clk", "pwm1", base + 0x4280, 0);
+	clks[IMX8MQ_CLK_PWM2_ROOT] = imx_clk_gate4("pwm2_root_clk", "pwm2", base + 0x4290, 0);
+	clks[IMX8MQ_CLK_PWM3_ROOT] = imx_clk_gate4("pwm3_root_clk", "pwm3", base + 0x42a0, 0);
+	clks[IMX8MQ_CLK_PWM4_ROOT] = imx_clk_gate4("pwm4_root_clk", "pwm4", base + 0x42b0, 0);
+	clks[IMX8MQ_CLK_QSPI_ROOT] = imx_clk_gate4("qspi_root_clk", "qspi", base + 0x42f0, 0);
+	clks[IMX8MQ_CLK_RAWNAND_ROOT] = imx_clk_gate2_shared2("nand_root_clk", "nand", base + 0x4300, 0, &share_count_nand);
+	clks[IMX8MQ_CLK_NAND_USDHC_BUS_RAWNAND_CLK] = imx_clk_gate2_shared2("nand_usdhc_rawnand_clk", "nand_usdhc_bus", base + 0x4300, 0, &share_count_nand);
+	clks[IMX8MQ_CLK_SAI1_ROOT] = imx_clk_gate2_shared2("sai1_root_clk", "sai1", base + 0x4330, 0, &share_count_sai1);
+	clks[IMX8MQ_CLK_SAI1_IPG] = imx_clk_gate2_shared2("sai1_ipg_clk", "ipg_audio_root", base + 0x4330, 0, &share_count_sai1);
+	clks[IMX8MQ_CLK_SAI2_ROOT] = imx_clk_gate2_shared2("sai2_root_clk", "sai2", base + 0x4340, 0, &share_count_sai2);
+	clks[IMX8MQ_CLK_SAI2_IPG] = imx_clk_gate2_shared2("sai2_ipg_clk", "ipg_root", base + 0x4340, 0, &share_count_sai2);
+	clks[IMX8MQ_CLK_SAI3_ROOT] = imx_clk_gate2_shared2("sai3_root_clk", "sai3", base + 0x4350, 0, &share_count_sai3);
+	clks[IMX8MQ_CLK_SAI3_IPG] = imx_clk_gate2_shared2("sai3_ipg_clk", "ipg_root", base + 0x4350, 0, &share_count_sai3);
+	clks[IMX8MQ_CLK_SAI4_ROOT] = imx_clk_gate2_shared2("sai4_root_clk", "sai4", base + 0x4360, 0, &share_count_sai4);
+	clks[IMX8MQ_CLK_SAI4_IPG] = imx_clk_gate2_shared2("sai4_ipg_clk", "ipg_audio_root", base + 0x4360, 0, &share_count_sai4);
+	clks[IMX8MQ_CLK_SAI5_ROOT] = imx_clk_gate2_shared2("sai5_root_clk", "sai5", base + 0x4370, 0, &share_count_sai5);
+	clks[IMX8MQ_CLK_SAI5_IPG] = imx_clk_gate2_shared2("sai5_ipg_clk", "ipg_audio_root", base + 0x4370, 0, &share_count_sai5);
+	clks[IMX8MQ_CLK_SAI6_ROOT] = imx_clk_gate2_shared2("sai6_root_clk", "sai6", base + 0x4380, 0, &share_count_sai6);
+	clks[IMX8MQ_CLK_SAI6_IPG] = imx_clk_gate2_shared2("sai6_ipg_clk", "ipg_audio_root", base + 0x4380, 0, &share_count_sai6);
+	clks[IMX8MQ_CLK_UART1_ROOT] = imx_clk_gate4("uart1_root_clk", "uart1", base + 0x4490, 0);
+	clks[IMX8MQ_CLK_UART2_ROOT] = imx_clk_gate4("uart2_root_clk", "uart2", base + 0x44a0, 0);
+	clks[IMX8MQ_CLK_UART3_ROOT] = imx_clk_gate4("uart3_root_clk", "uart3", base + 0x44b0, 0);
+	clks[IMX8MQ_CLK_UART4_ROOT] = imx_clk_gate4("uart4_root_clk", "uart4", base + 0x44c0, 0);
+	clks[IMX8MQ_CLK_USB1_CTRL_ROOT] = imx_clk_gate4("usb1_ctrl_root_clk", "usb_core_ref", base + 0x44d0, 0);
+	clks[IMX8MQ_CLK_USB2_CTRL_ROOT] = imx_clk_gate4("usb2_ctrl_root_clk", "usb_core_ref", base + 0x44e0, 0);
+	clks[IMX8MQ_CLK_USB1_PHY_ROOT] = imx_clk_gate4("usb1_phy_root_clk", "usb_phy_ref", base + 0x44f0, 0);
+	clks[IMX8MQ_CLK_USB2_PHY_ROOT] = imx_clk_gate4("usb2_phy_root_clk", "usb_phy_ref", base + 0x4500, 0);
+	clks[IMX8MQ_CLK_USDHC1_ROOT] = imx_clk_gate4("usdhc1_root_clk", "usdhc1", base + 0x4510, 0);
+	clks[IMX8MQ_CLK_USDHC2_ROOT] = imx_clk_gate4("usdhc2_root_clk", "usdhc2", base + 0x4520, 0);
+	clks[IMX8MQ_CLK_WDOG1_ROOT] = imx_clk_gate4("wdog1_root_clk", "wdog", base + 0x4530, 0);
+	clks[IMX8MQ_CLK_WDOG2_ROOT] = imx_clk_gate4("wdog2_root_clk", "wdog", base + 0x4540, 0);
+	clks[IMX8MQ_CLK_WDOG3_ROOT] = imx_clk_gate4("wdog3_root_clk", "wdog", base + 0x4550, 0);
+	clks[IMX8MQ_CLK_VPU_G1_ROOT] = imx_clk_gate2_flags("vpu_g1_root_clk", "vpu_g1", base + 0x4560, 0, CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE);
+	clks[IMX8MQ_CLK_GPU_ROOT] = imx_clk_gate4("gpu_root_clk", "gpu_core_div", base + 0x4570, 0);
+	clks[IMX8MQ_CLK_VPU_G2_ROOT] = imx_clk_gate2_flags("vpu_g2_root_clk", "vpu_g2", base + 0x45a0, 0, CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE);
+	clks[IMX8MQ_CLK_DISP_ROOT] = imx_clk_gate2_shared2("disp_root_clk", "disp_dc8000", base + 0x45d0, 0, &share_count_dcss);
+	clks[IMX8MQ_CLK_DISP_AXI_ROOT]  = imx_clk_gate2_shared2("disp_axi_root_clk", "disp_axi", base + 0x45d0, 0, &share_count_dcss);
+	clks[IMX8MQ_CLK_DISP_APB_ROOT]  = imx_clk_gate2_shared2("disp_apb_root_clk", "disp_apb", base + 0x45d0, 0, &share_count_dcss);
+	clks[IMX8MQ_CLK_DISP_RTRM_ROOT] = imx_clk_gate2_shared2("disp_rtrm_root_clk", "disp_rtrm", base + 0x45d0, 0, &share_count_dcss);
+	clks[IMX8MQ_CLK_TMU_ROOT] = imx_clk_gate4_flags("tmu_root_clk", "ipg_root", base + 0x4620, 0, CLK_IS_CRITICAL);
+	clks[IMX8MQ_CLK_VPU_DEC_ROOT] = imx_clk_gate2_flags("vpu_dec_root_clk", "vpu_bus", base + 0x4630, 0, CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE);
+	clks[IMX8MQ_CLK_CSI1_ROOT] = imx_clk_gate4("csi1_root_clk", "csi1_core", base + 0x4650, 0);
+	clks[IMX8MQ_CLK_CSI2_ROOT] = imx_clk_gate4("csi2_root_clk", "csi2_core", base + 0x4660, 0);
+	clks[IMX8MQ_CLK_SDMA1_ROOT] = imx_clk_gate4("sdma1_clk", "ipg_root", base + 0x43a0, 0);
+	clks[IMX8MQ_CLK_SDMA2_ROOT] = imx_clk_gate4("sdma2_clk", "ipg_audio_root", base + 0x43b0, 0);
+
+	clks[IMX8MQ_GPT_3M_CLK] = imx_clk_fixed_factor("gpt_3m", "osc_25m", 1, 8);
+	clks[IMX8MQ_CLK_DRAM_ALT_ROOT] = imx_clk_fixed_factor("dram_alt_root", "dram_alt", 1, 4);
+
+	for (i = 0; i < IMX8MQ_CLK_END; i++)
+		if (IS_ERR(clks[i]))
+			pr_err("i.MX8mq clk %u register failed with %ld\n",
+			       i, PTR_ERR(clks[i]));
+
+	clk_data.clks = clks;
+	clk_data.clk_num = ARRAY_SIZE(clks);
+	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
+
+	clk_set_parent(clks[IMX8MQ_CLK_AHB], clks[IMX8MQ_SYS1_PLL_133M]);
+	clk_set_parent(clks[IMX8MQ_CLK_NAND_USDHC_BUS], clks[IMX8MQ_SYS1_PLL_266M]);
+	clk_set_parent(clks[IMX8MQ_CLK_AUDIO_AHB], clks[IMX8MQ_SYS2_PLL_500M]);
+
+	/* config video_pll1 clock */
+	clk_set_parent(clks[IMX8MQ_VIDEO_PLL1_REF_SEL], clks[IMX8MQ_CLK_27M]);
+	clk_set_rate(clks[IMX8MQ_VIDEO_PLL1], 593999999);
+
+	/* increase NOC clock to achieve best DDR access performance */
+	clk_set_rate(clks[IMX8MQ_CLK_NOC], clk_get_rate(clks[IMX8MQ_SYS1_PLL_800M]));
+
+	/* set pcie root's parent clk source */
+	clk_set_parent(clks[IMX8MQ_CLK_PCIE1_CTRL], clks[IMX8MQ_SYS2_PLL_250M]);
+	clk_set_parent(clks[IMX8MQ_CLK_PCIE1_PHY], clks[IMX8MQ_SYS2_PLL_100M]);
+	clk_set_parent(clks[IMX8MQ_CLK_PCIE2_CTRL], clks[IMX8MQ_SYS2_PLL_250M]);
+	clk_set_parent(clks[IMX8MQ_CLK_PCIE2_PHY], clks[IMX8MQ_SYS2_PLL_100M]);
+
+	clk_set_parent(clks[IMX8MQ_CLK_CSI1_CORE], clks[IMX8MQ_SYS1_PLL_266M]);
+	clk_set_parent(clks[IMX8MQ_CLK_CSI1_PHY_REF], clks[IMX8MQ_SYS2_PLL_1000M]);
+	clk_set_parent(clks[IMX8MQ_CLK_CSI1_ESC], clks[IMX8MQ_SYS1_PLL_800M]);
+	clk_set_parent(clks[IMX8MQ_CLK_CSI2_CORE], clks[IMX8MQ_SYS1_PLL_266M]);
+	clk_set_parent(clks[IMX8MQ_CLK_CSI2_PHY_REF], clks[IMX8MQ_SYS2_PLL_1000M]);
+	clk_set_parent(clks[IMX8MQ_CLK_CSI2_ESC], clks[IMX8MQ_SYS1_PLL_800M]);
+}
+
+CLK_OF_DECLARE(imx8mq, "fsl,imx8mq-ccm", imx8mq_clocks_init);
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 282fe74..77141004 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -128,6 +128,15 @@ static inline struct clk *imx_clk_divider2(const char *name, const char *parent,
 			reg, shift, width, 0, &imx_ccm_lock);
 }
 
+static inline struct clk *imx_clk_divider2_flags(const char *name,
+		const char *parent, void __iomem *reg, u8 shift, u8 width,
+		unsigned long flags)
+{
+	return clk_register_divider(NULL, name, parent,
+			flags | CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
+			reg, shift, width, 0, &imx_ccm_lock);
+}
+
 static inline struct clk *imx_clk_gate(const char *name, const char *parent,
 		void __iomem *reg, u8 shift)
 {
@@ -195,6 +204,15 @@ static inline struct clk *imx_clk_gate3(const char *name, const char *parent,
 			reg, shift, 0, &imx_ccm_lock);
 }
 
+static inline struct clk *imx_clk_gate3_flags(const char *name,
+		const char *parent, void __iomem *reg, u8 shift,
+		unsigned long flags)
+{
+	return clk_register_gate(NULL, name, parent,
+			flags | CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
+			reg, shift, 0, &imx_ccm_lock);
+}
+
 static inline struct clk *imx_clk_gate4(const char *name, const char *parent,
 		void __iomem *reg, u8 shift)
 {
@@ -203,6 +221,15 @@ static inline struct clk *imx_clk_gate4(const char *name, const char *parent,
 			reg, shift, 0x3, 0, &imx_ccm_lock, NULL);
 }
 
+static inline struct clk *imx_clk_gate4_flags(const char *name,
+		const char *parent, void __iomem *reg, u8 shift,
+		unsigned long flags)
+{
+	return clk_register_gate2(NULL, name, parent,
+			flags | CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
+			reg, shift, 0x3, 0, &imx_ccm_lock, NULL);
+}
+
 static inline struct clk *imx_clk_mux(const char *name, void __iomem *reg,
 		u8 shift, u8 width, const char **parents, int num_parents)
 {
@@ -228,6 +255,15 @@ static inline struct clk *imx_clk_mux_flags(const char *name,
 			&imx_ccm_lock);
 }
 
+static inline struct clk *imx_clk_mux2_flags(const char *name,
+		void __iomem *reg, u8 shift, u8 width, const char **parents,
+		int num_parents, unsigned long flags)
+{
+	return clk_register_mux(NULL, name, parents, num_parents,
+			flags | CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE,
+			reg, shift, width, 0, &imx_ccm_lock);
+}
+
 struct clk *imx_clk_cpu(const char *name, const char *parent_name,
 		struct clk *div, struct clk *mux, struct clk *pll,
 		struct clk *step);
-- 
2.7.4

