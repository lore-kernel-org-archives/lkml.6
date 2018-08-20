Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6BCC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 07:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDAFE20BED
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 07:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="h0Xljhqp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDAFE20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbeHTKbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 06:31:18 -0400
Received: from mail-eopbgr00087.outbound.protection.outlook.com ([40.107.0.87]:40384
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726030AbeHTKbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 06:31:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cuIFmK7CuDjdxtHvMI88Ny+V3DOwdLSxF/udZeqxlQ8=;
 b=h0XljhqpfWYmw2S4U7ov9USGJQx4gfAwNdcq4N1awPjj1pantNqmofg3+/YQGwW38t1tSoQ2CUHTiQ4mOv/CEfwhTZr1P/aDpC5sQSeavMnlpIVqTAsScZt6/04/EUuoTsp747/0wSoZGCkYcOyVrAxnrXUTxOQRRHZ1UGS3FLU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
Received: from fsr-ub1664-175.ea.freescale.net (95.76.156.53) by
 DB5PR04MB1608.eurprd04.prod.outlook.com (2a01:111:e400:5994::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.22; Mon, 20 Aug
 2018 07:16:31 +0000
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
Subject: [RESEND v5 5/5] clk: imx: add clock driver for i.MX8MQ CCM
Date:   Mon, 20 Aug 2018 10:16:07 +0300
Message-Id: <1534749367-31085-6-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534749367-31085-1-git-send-email-abel.vesa@nxp.com>
References: <1534749367-31085-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: HE1P190CA0037.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::26)
 To DB5PR04MB1608.eurprd04.prod.outlook.com (2a01:111:e400:5994::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9723fbf0-26ac-42c4-9528-08d6066cdbf5
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1608;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1608;3:QnSuEDOKvCoLdyNYxvyU4zlUhPYQXd0J8Q2/NRGtqkkcCrwLfSBAhqDVPPv7PqogkHIFLNzo6zuTr/6ebfAnZGpK5nqKYZxL4PiyUoyDtr/t7qL/A7QG8RcSPTAkfb9XvtFKA0Z9XZdpadw6iSJ7ccJRjKNKNjaTFSGpLckGIPzR3qN4hWMZVOmN+eg+95tdR2jOz7LN5gGUAjKz/yagE1fCJ+aMwoQkE5urAnQaaX46LEFmPzTU/28X/HTNaRFy;25:JmqsQvEL0jcp+/QqAghKMcJ04WfmEC6bEkzm/qQdetL/ceyLcZkILfzPHueQatJOn6agcjdoFXdn9KPXOz4dnkRpMDHsVaZFUyeQ1+z0leCJNAajL1HSx5Amcn6Fz/LDMPm9/m5segBFaI0ik4I00jyTSFq+FVL4lHFLml2V5eVYTNQlFg+4BsS9VlxGvP2pPeqHEHdJYmPEvvZDCZVlqUhGc+v0q01ak95k6ZHbkZjcBVh1urhYXBAlyJsKQ6fc9lDqz9AzU6JKxPKoSQyQIOf/d1M3yeeuhFqvdfrppEb+RHQG7YqVX1tFpA4HKupsBeKrR0w5yPvHDZOe5svYVg==;31:/HzwpBdUgGyhRKWvDP/XgzUKaiTEy7k1Vn8lgRtd7qckRwraqEsv0qk6zPJHT1GIbwi3Sd3OvSy9qpVT53pPjGtIM5uRHrFNoPR6ADNlGOrnqwezaT7uVkmYQ828vvuGoH6EsmSAo1nR52tRmmKsbgvmE+fCyOBFeOAGhgo52tQ0C7z9AffCaDkd/4QFYNCK+jamObi4dDjEIkOMdpQ6q9/5RMZNNFv6viYgaEeqkZs=
X-MS-TrafficTypeDiagnostic: DB5PR04MB1608:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1608;20:JETDYW74ZejRINc5sXfZZAK28fFbpJeq/gEBgfbP7tIozjuascPicBIqqugzGyN5WNxsNK6lPeNm8Iq+eFPLrQFnsSYf8IOU1P38Ywp2dcNE3lCBmbikwoPIfVcrk02QW9K35lQcAjnZXMSDt216MgrRXg83ZHAg29y/lH/NMRO9tgvqE2okzkM063VO0AT+zzGQEupM+ocM422TkYuJsVjQ4X+/mHB+iA+2w7neUi7cJIO0vQBj2UYdi2Uc4BOSTzkcEmFc1BSV6Yz4n56iH5qVpgW1xtQKYujvnkasQSMtL21Wjy+EyILJACiCWZ49cyYd/Mr8gnkI7AAlgVxEcyMIZQrUcYR/i/wrQ1z+l3B7CRl9OHTch3YrzZB1eSQueeczcNOr6Seskz0IXtSRbzmRVpAjLO+WEeH6FqFN/yn1yDpYKSD/vYaVCCHxpVXtb3o+dCt9djf91RJwm5xHGAbYZ6TAJGDTnkxZqEag4GNCd+iL1tsYaHvo+FCUfDSw;4:7qVOOO/DfFh0okgWZQ1iguU/DJ0wxOw4qVwgHFr46z1e2O2CgQ9grO3uYymYn37uh8avFwFiM1P9TwcOv1V+n4/7XC0/VY+ICNxl/UrL3P3TvfCzdn/dH7qV0xoXtfAB+GbB+6yuGILcyQHkBHASQV66ZLhYm+fSh0MSgOqLd3qhm9zZQrD4l0rX8B3cSrlSwSawIQvrPKNQypDw5MGU+mt6Ohj74IWmT8wXC2AwBBHXEPwrWlkyMVb07SJeAJJs2Pn9zszfFKN2JrxkM8Sk+vmOQ2r6AKwREv5/QWPRfAbvnnqSvBYmHJGzA6cB3j6B
X-Microsoft-Antispam-PRVS: <DB5PR04MB1608DEFE37F778844B0F99F6F6320@DB5PR04MB1608.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699016);SRVR:DB5PR04MB1608;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1608;
X-Forefront-PRVS: 0770F75EA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(366004)(346002)(39860400002)(189003)(199004)(5660300001)(7416002)(50466002)(6636002)(6666003)(305945005)(6486002)(14444005)(48376002)(4326008)(25786009)(86362001)(51416003)(66066001)(81156014)(81166006)(316002)(575784001)(76176011)(7736002)(47776003)(44832011)(16586007)(110136005)(52116002)(54906003)(8676002)(16526019)(478600001)(386003)(186003)(6506007)(6116002)(97736004)(106356001)(68736007)(53936002)(105586002)(3846002)(2906002)(36756003)(8936002)(53946003)(50226002)(446003)(6512007)(2616005)(476003)(486006)(26005)(11346002)(956004)(579004)(559001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1608;H:fsr-ub1664-175.ea.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR04MB1608;23:8AE2LzVHMFSUe6ZSXYT8YGCjWZLIKMqbzFVQ9o4oP?=
 =?us-ascii?Q?vdntizaKDDFJOJiC9dpTLS9uGJsoA8OF5gFJ0Ru1b+HDPbjK23zsY9UqQSDL?=
 =?us-ascii?Q?fk0XTHChLyiDWywSAFbWaBjsgAi0XtaxBUzJts+XQXpgo/XnhnI0/bLWCa2i?=
 =?us-ascii?Q?WqGY5nPn7q6ciCCeJlPE6RCrcvm4aWs6sF1Lly6rucJlS5WCt6Olbj5KmcXK?=
 =?us-ascii?Q?fOFXmnd9kdRQaXPCN+szIjItTCd1u2ME7FEZWgsaTwIVOMbNHsqnDcMnKv3P?=
 =?us-ascii?Q?J3vZt1rR9N81Q6bXko9pPsCj84/sTcu/8+bp7j8RxsWPI0zgYi1/gyrTykmP?=
 =?us-ascii?Q?AYjZepTVblekxy44LlsQ6Q4jqGxc2yQ1SreuFQnEWj0JKDdxVxHZKyTCbKCw?=
 =?us-ascii?Q?UI/YjoGoucQSUVYTkiuEziETdUJhg9cTH27XuRVeTS44+Y6wXBACHRxzwCs2?=
 =?us-ascii?Q?cwlbPka9SVbudV7Q+sFKQgBzviBTJb+yCRP3qsEis0OKrN3ZGD7K80x2SNjL?=
 =?us-ascii?Q?8Hg59tFLpNA1t/gOuOfHoSIXkmYqWwkaKA7vYy/kLdzi3SOeYbhKY/ne4iWk?=
 =?us-ascii?Q?z7w7QHxwYpZLUJweGI3kI3CcbDLfwatt08quMDUW+TMr5+H31vSq/MwA7WDH?=
 =?us-ascii?Q?bVLvhLpI5lHhe2TVgfwcDI0sfiVJdsg2J1Egy6GQIFiThmxLj2BB0Nf40N0p?=
 =?us-ascii?Q?QzmbFU0/15lby600P9qBv0vJ3AqhBOs2kLv0JywLW6JFkaUOz/ZH7ERRTXbN?=
 =?us-ascii?Q?YW5OUT59XmowHOrhAcUSuj/utENnT8eL8keZxoIyiS0ahJPg7iflS+Mscxra?=
 =?us-ascii?Q?5l9caH8o24PcKTYKVJfwvJrWlS93QhTY3ekzH7qt5MnPtQ7JYcAC3iV7/nul?=
 =?us-ascii?Q?Gd6gPsDw52rQFYlUMOmrJukJ+ehZlyoLtiFoP+MoGCiLaH9xQlv/g3D2+6UG?=
 =?us-ascii?Q?Jh7OPPn/mZPNvPjVNt0OHxYkvgAK6QjaZhOh9ssf/advpC6EBLra13em59xH?=
 =?us-ascii?Q?dWZ0m0d8wxpAOG8gj21m+tYmP9O2NKE7yPLSEaewrKJXXzRMXBuU2msLkkL+?=
 =?us-ascii?Q?zuYZ3uA+oOT/bOOPkPgIMOO5M/6W/+uIBgpdeeozAV5y2Lb4bg702TIyvFDK?=
 =?us-ascii?Q?BmTnluspVJzzHoh7u/l+ozSEm47OFgk/qwvksIuU1Scz9BUnz0JYXwpx80lB?=
 =?us-ascii?Q?iADhYyl02Yu1wZ24uO2y85hBOr5ivoNIJRCRuY0GlBq7BiMs0XyObKFY5iTX?=
 =?us-ascii?Q?6uBQ3ly6xTUtD7/SwxbFP15wCUcX9Zqc/ikt6syo6lsYjVCsVGMrLm4O33F3?=
 =?us-ascii?Q?JBry5eEW2sacMqN5bLy568SrHVLXvtfAl0wrh4E/vvPRuwRTaAI526M8jUZU?=
 =?us-ascii?Q?+h5LA=3D=3D?=
X-Microsoft-Antispam-Message-Info: 6WHRlfwcVjStmxznCeikEBdd2CF9K45+BTMFU/OjasVa0LMpfrSYZjA32H7/hSXQ2o1AXauSB5kPRaw1HwoEmAe8Xzqs1G8H9psXiLv/7yj9HqjrVlNTSD9HSE0/siAqDiWLydBZpFMm5dT23LXEIKOSXiGmY7eastUieoHvBHIeP9ay2E3TRLYtvwx7IXPPznwMhQxn8UeAVwsZPsR5TyaWea1gGkfhU20j88P1sXd770fmEZzsvgMS7Q4qOhTTM+c3WCJDNk6pZA4GbVkPa1QX/On2jQH1Zq0CTmuvAqbdCFFSvfQ7S6iDJpBARd9JgX6Jt6M3fNmPvn8L2wfyuarKm3t+RiUglkhw9nqjttI=
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1608;6:mBKXyJZPKWnTEKgL7jWR3Bs8n/Fvrn51AIVxLfC+/Na8ZIOypgaKSZfSV3TE6KksQLiY7ObTTy2wMwCTpHMPkf0VL1oT52+7ErkFiusOAqcLCCSm3iIRR/jWMMQduVhyFTZwMlSJPnBy5EadAQtTxkehKwiMQ6x7qEXa9SRJx6/Y3ElVdxCBExU1LxAxXojBR+Pn+1MdYRHzAg3ulZBCsCbMFr0XDza3GpA8MK3ucwe/FDTi3fK0QNWz5Qflf+dGiPZ5qKvkzoP4Nw0XFkOJMpPF15iw5wpLUBOEmzxKZjVI5Paq/1y6Zb4IYuVemh4zjcU63JHEoI1yc+8l8VD3hQhD5iIx8IyFsQzvWPFV/FHdtfCm8EFclcu6SPVrQhKzwyPV9n8JIqF3gQIE4c2sjB0tS4sPH+iEvrXLqo53lltyFMxUBnBX508H+djVNEPGZ7t04d5xHyPw5v9Gcq2EoA==;5:4ZyPMssZFR3EvALW3gfywSaM5iqS4XFN7Td7Er/7mKQS/WtI3tzC2Qs7JZjIryCGbfL3oxKp07Lu1lBxDvOTZawMSQoIf/wMzd2deeZASKk/mICNMMKjfAWnYRZjIhKqgco3DzMmqTnd4NbFn3bIsVc6JzRWsP7829XBTaIKtDA=;7:ZHrECLGNKsIUCyYyXDyqZ/24Q8q54NuL2yx51jxAp8WPNCRXWypmx/fD40ziC+GCS8BEUL9z8N1tCpV+HNn13qx1wTovyjq6jLZDHIGDQtrhTUzKbH3PaVyKp4BdCrpZZAQZkA6jFvcTrVVn87Z+/VpLpq3tpRoDV1iJra+GlGEvfJr50VOq6UzlUKZswS2J+piSU7PW3LSmxOz0NI/X3XGXprzfUs+OESVk+BirogJ2fAbALsOKXxGFTmB7R1hY
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2018 07:16:31.7448
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9723fbf0-26ac-42c4-9528-08d6066cdbf5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1608
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

Add driver for the Clock Control Module found on i.MX8MQ.

This is largely based on the downstream driver from Anson Huang and
Bai Ping at NXP, with only some small adaptions to mainline from me.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/Makefile     |   1 +
 drivers/clk/imx/clk-imx8mq.c | 631 +++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/imx/clk.h        |  36 +++
 3 files changed, 668 insertions(+)
 create mode 100644 drivers/clk/imx/clk-imx8mq.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 4fabb0a..64e695c 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -30,3 +30,4 @@ obj-$(CONFIG_SOC_IMX6SX) += clk-imx6sx.o
 obj-$(CONFIG_SOC_IMX6UL) += clk-imx6ul.o
 obj-$(CONFIG_SOC_IMX7D)  += clk-imx7d.o
 obj-$(CONFIG_SOC_VF610)  += clk-vf610.o
+obj-$(CONFIG_SOC_IMX8MQ) += clk-imx8mq.o
diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
new file mode 100644
index 0000000..d3a9e31
--- /dev/null
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -0,0 +1,631 @@
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
+static const char *video2_pll1_out_sels[] = {"video2_pll1", "video2_pll1_ref_sel", };
+
+static const char *sys1_pll2_out_sels[] = {"sys1_pll2_div", "sys1_pll1_ref_sel", };
+static const char *sys2_pll2_out_sels[] = {"sys2_pll2_div", "sys2_pll1_ref_sel", };
+static const char *sys3_pll2_out_sels[] = {"sys3_pll2_div", "sys2_pll1_ref_sel", };
+static const char *dram_pll2_out_sels[] = {"dram_pll2_div", "dram_pll1_ref_sel", };
+static const char *video2_pll2_out_sels[] = {"video2_pll2_div", "video2_pll1_ref_sel", };
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
+static int const clks_init_on[] __initconst = {
+	IMX8MQ_CLK_DRAM_CORE, IMX8MQ_CLK_AHB_CG,
+	IMX8MQ_CLK_NOC, IMX8MQ_CLK_NOC_APB,
+	IMX8MQ_CLK_USB_BUS, IMX8MQ_CLK_NAND_USDHC_BUS,
+	IMX8MQ_CLK_MAIN_AXI, IMX8MQ_CLK_A53_CG,
+	IMX8MQ_CLK_AUDIO_AHB_DIV, IMX8MQ_CLK_TMU_ROOT,
+	IMX8MQ_CLK_DRAM_APB,
+};
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
+	clks[IMX8MQ_VIDEO2_PLL1_REF_SEL] = imx_clk_mux("video2_pll1_ref_sel", base + 0x54, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
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
+	clks[IMX8MQ_VIDEO2_PLL1_REF_DIV]  = imx_clk_divider("video2_pll1_ref_div", "video2_pll1_ref_sel", base + 0x5c, 25, 3);
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
+	clks[IMX8MQ_VIDEO2_PLL1] = imx_clk_sccg_pll("video2_pll1", "video2_pll1_ref_div", base + 0x5c, 3);
+
+	clks[IMX8MQ_SYS1_PLL2] = imx_clk_sccg_pll("sys1_pll2", "sys1_pll1_out_div", base + 0x30, SCCG_PLL2);
+	clks[IMX8MQ_SYS2_PLL2] = imx_clk_sccg_pll("sys2_pll2", "sys2_pll1_out_div", base + 0x3c, SCCG_PLL2);
+	clks[IMX8MQ_SYS3_PLL2] = imx_clk_sccg_pll("sys3_pll2", "sys3_pll1_out_div", base + 0x48, SCCG_PLL2);
+	clks[IMX8MQ_DRAM_PLL2] = imx_clk_sccg_pll("dram_pll2", "dram_pll1_out_div", base + 0x60, SCCG_PLL2);
+	clks[IMX8MQ_VIDEO2_PLL2] = imx_clk_sccg_pll("video2_pll2", "video2_pll1_out_div", base + 0x54, SCCG_PLL2);
+
+	/* PLL divs */
+	clks[IMX8MQ_SYS1_PLL1_OUT_DIV] = imx_clk_divider("sys1_pll1_out_div", "sys1_pll1_out", base + 0x38, 19, 6);
+	clks[IMX8MQ_SYS2_PLL1_OUT_DIV] = imx_clk_divider("sys2_pll1_out_div", "sys2_pll1_out", base + 0x44, 19, 6);
+	clks[IMX8MQ_SYS3_PLL1_OUT_DIV] = imx_clk_divider("sys3_pll1_out_div", "sys3_pll1_out", base + 0x50, 19, 6);
+	clks[IMX8MQ_DRAM_PLL1_OUT_DIV] = imx_clk_divider("dram_pll1_out_div", "dram_pll1_out", base + 0x68, 19, 6);
+	clks[IMX8MQ_VIDEO2_PLL1_OUT_DIV] = imx_clk_divider("video2_pll1_out_div", "video2_pll1_out", base + 0x5c, 19, 6);
+	clks[IMX8MQ_SYS1_PLL2_DIV] = imx_clk_divider("sys1_pll2_div", "sys1_pll2", base + 0x38, 1, 6);
+	clks[IMX8MQ_SYS2_PLL2_DIV] = imx_clk_divider("sys2_pll2_div", "sys2_pll2", base + 0x44, 1, 6);
+	clks[IMX8MQ_SYS3_PLL2_DIV] = imx_clk_divider("sys3_pll2_div", "sys3_pll2", base + 0x50, 1, 6);
+	clks[IMX8MQ_DRAM_PLL2_DIV] = imx_clk_divider("dram_pll2_div", "dram_pll2", base + 0x68, 1, 6);
+	clks[IMX8MQ_VIDEO2_PLL2_DIV] = imx_clk_divider("video2_pll2_div", "video2_pll2", base + 0x5c, 1, 6);
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
+	clks[IMX8MQ_VIDEO2_PLL1_OUT] = imx_clk_mux("video2_pll1_out", base + 0x54, 5, 1, video2_pll1_out_sels, ARRAY_SIZE(video2_pll1_out_sels));
+	clks[IMX8MQ_SYS1_PLL2_OUT] = imx_clk_mux("sys1_pll2_out", base + 0x30, 4, 1, sys1_pll2_out_sels, ARRAY_SIZE(sys1_pll2_out_sels));
+	clks[IMX8MQ_SYS2_PLL2_OUT] = imx_clk_mux("sys2_pll2_out", base + 0x3c, 4, 1, sys2_pll2_out_sels, ARRAY_SIZE(sys2_pll2_out_sels));
+	clks[IMX8MQ_SYS3_PLL2_OUT] = imx_clk_mux("sys3_pll2_out", base + 0x48, 4, 1, sys3_pll2_out_sels, ARRAY_SIZE(sys3_pll2_out_sels));
+	clks[IMX8MQ_DRAM_PLL2_OUT] = imx_clk_mux("dram_pll2_out", base + 0x60, 4, 1, dram_pll2_out_sels, ARRAY_SIZE(dram_pll2_out_sels));
+	clks[IMX8MQ_VIDEO2_PLL2_OUT] = imx_clk_mux("video2_pll2_out", base + 0x54, 4, 1, video2_pll2_out_sels, ARRAY_SIZE(video2_pll2_out_sels));
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
+	clks[IMX8MQ_VIDEO2_PLL_OUT] = imx_clk_gate("video2_pll_out", "video2_pll2_out", base + 0x54, 9);
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
+	clks[IMX8MQ_CLK_MAIN_AXI] = imx_clk_composite_critical("main_axi", imx8mq_main_axi_sels, base + 0x8800);
+	clks[IMX8MQ_CLK_ENET_AXI] = imx_clk_composite("enet_axi", imx8mq_enet_axi_sels, base + 0x8880);
+	clks[IMX8MQ_CLK_NAND_USDHC_BUS] = imx_clk_composite_critical("nand_usdhc_bus", imx8mq_nand_usdhc_sels, base + 0x8900);
+	clks[IMX8MQ_CLK_VPU_BUS] = imx_clk_composite("vpu_bus", imx8mq_vpu_bus_sels, base + 0x8980);
+	clks[IMX8MQ_CLK_DISP_AXI] = imx_clk_composite("disp_axi", imx8mq_disp_axi_sels, base + 0x8a00);
+	clks[IMX8MQ_CLK_DISP_APB] = imx_clk_composite("disp_apb", imx8mq_disp_apb_sels, base + 0x8a80);
+	clks[IMX8MQ_CLK_DISP_RTRM] = imx_clk_composite("disp_rtrm", imx8mq_disp_rtrm_sels, base + 0x8b00);
+	clks[IMX8MQ_CLK_USB_BUS] = imx_clk_composite_critical("usb_bus", imx8mq_usb_bus_sels, base + 0x8b80);
+	clks[IMX8MQ_CLK_GPU_AXI] = imx_clk_composite("gpu_axi", imx8mq_gpu_axi_sels, base + 0x8c00);
+	clks[IMX8MQ_CLK_GPU_AHB] = imx_clk_composite("gpu_ahb", imx8mq_gpu_ahb_sels, base + 0x8c80);
+	clks[IMX8MQ_CLK_NOC] = imx_clk_composite_critical("noc", imx8mq_noc_sels, base + 0x8d00);
+	clks[IMX8MQ_CLK_NOC_APB] = imx_clk_composite_critical("noc_apb", imx8mq_noc_apb_sels, base + 0x8d80);
+
+	/* AHB */
+	clks[IMX8MQ_CLK_AHB_SRC] = imx_clk_mux2("ahb_src", base + 0x9000, 24, 3, imx8mq_ahb_sels, ARRAY_SIZE(imx8mq_ahb_sels));
+	clks[IMX8MQ_CLK_AUDIO_AHB_SRC] = imx_clk_mux2("audio_ahb_src", base + 0x9100, 24, 3, imx8mq_audio_ahb_sels, ARRAY_SIZE(imx8mq_audio_ahb_sels));
+	clks[IMX8MQ_CLK_AHB_CG] = imx_clk_gate3_flags("ahb_cg", "ahb_src", base + 0x9000, 28, CLK_IS_CRITICAL);
+	clks[IMX8MQ_CLK_AUDIO_AHB_CG] = imx_clk_gate3("audio_ahb_cg", "audio_ahb_src", base + 0x9100, 28);
+	clks[IMX8MQ_CLK_AHB_PRE_DIV] = imx_clk_divider2("ahb_pre_div", "ahb_cg", base + 0x9000, 16, 3);
+	clks[IMX8MQ_CLK_AUDIO_AHB_PRE_DIV] = imx_clk_divider2("audio_ahb_pre_div", "audio_ahb_cg", base + 0x9100, 16, 3);
+	clks[IMX8MQ_CLK_AHB_DIV] = imx_clk_divider_flags("ahb_div", "ahb_pre_div", base + 0x9000, 0, 6, CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE);
+	clks[IMX8MQ_CLK_AUDIO_AHB_DIV] = imx_clk_divider2_flags("audio_ahb_div", "audio_ahb_pre_div", base + 0x9100, 0, 6, CLK_IS_CRITICAL);
+
+	/* IPG */
+	clks[IMX8MQ_CLK_IPG_ROOT] = imx_clk_divider2("ipg_root", "ahb_div", base + 0x9080, 0, 1);
+	clks[IMX8MQ_CLK_IPG_AUDIO_ROOT] = imx_clk_divider2("ipg_audio_root", "audio_ahb_div", base + 0x9180, 0, 1);
+
+	/* IP */
+	clks[IMX8MQ_CLK_DRAM_CORE] = imx_clk_mux2_flags("dram_core_clk", base + 0x9800, 24, 1, imx8mq_dram_core_sels, ARRAY_SIZE(imx8mq_dram_core_sels), CLK_IS_CRITICAL);
+
+	clks[IMX8MQ_CLK_DRAM_ALT] = imx_clk_composite("dram_alt", imx8mq_dram_alt_sels, base + 0xa000);
+	clks[IMX8MQ_CLK_DRAM_APB] = imx_clk_composite_critical("dram_apb", imx8mq_dram_apb_sels, base + 0xa080);
+	clks[IMX8MQ_CLK_VPU_G1] = imx_clk_composite("vpu_g1", imx8mq_vpu_g1_sels, base + 0xa100);
+	clks[IMX8MQ_CLK_VPU_G2] = imx_clk_composite("vpu_g2", imx8mq_vpu_g2_sels, base + 0xa180);
+	clks[IMX8MQ_CLK_DISP_DTRC] = imx_clk_composite("disp_dtrc", imx8mq_disp_dtrc_sels, base + 0xa200);
+	clks[IMX8MQ_CLK_DISP_DC8000] = imx_clk_composite("disp_dc8000", imx8mq_disp_dc8000_sels, base + 0xa280);
+	clks[IMX8MQ_CLK_PCIE1_CTRL] = imx_clk_composite("pcie1_ctrl", imx8mq_pcie1_ctrl_sels, base + 0xa300);
+	clks[IMX8MQ_CLK_PCIE1_PHY] = imx_clk_composite("pcie1_phy", imx8mq_pcie1_phy_sels, base + 0xa380);
+	clks[IMX8MQ_CLK_PCIE1_AUX] = imx_clk_composite("pcie1_aux", imx8mq_pcie1_aux_sels, base + 0xa400);
+	clks[IMX8MQ_CLK_DC_PIXEL] = imx_clk_composite("dc_pixel", imx8mq_dc_pixel_sels, base + 0xa480);
+	clks[IMX8MQ_CLK_LCDIF_PIXEL] = imx_clk_composite("lcdif_pixel", imx8mq_lcdif_pixel_sels, base + 0xa500);
+	clks[IMX8MQ_CLK_SAI1] = imx_clk_composite("sai1", imx8mq_sai1_sels, base + 0xa580);
+	clks[IMX8MQ_CLK_SAI2] = imx_clk_composite("sai2", imx8mq_sai2_sels, base + 0xa600);
+	clks[IMX8MQ_CLK_SAI3] = imx_clk_composite("sai3", imx8mq_sai3_sels, base + 0xa680);
+	clks[IMX8MQ_CLK_SAI4] = imx_clk_composite("sai4", imx8mq_sai4_sels, base + 0xa700);
+	clks[IMX8MQ_CLK_SAI5] = imx_clk_composite("sai5", imx8mq_sai5_sels, base + 0xa780);
+	clks[IMX8MQ_CLK_SAI6] = imx_clk_composite("sai6", imx8mq_sai6_sels, base + 0xa800);
+	clks[IMX8MQ_CLK_SPDIF1] = imx_clk_composite("spdif1", imx8mq_spdif1_sels, base + 0xa880);
+	clks[IMX8MQ_CLK_SPDIF2] = imx_clk_composite("spdif2", imx8mq_spdif2_sels, base + 0xa900);
+	clks[IMX8MQ_CLK_ENET_REF] = imx_clk_composite("enet_ref", imx8mq_enet_ref_sels, base + 0xa980);
+	clks[IMX8MQ_CLK_ENET_TIMER] = imx_clk_composite("enet_timer", imx8mq_enet_timer_sels, base + 0xaa00);
+	clks[IMX8MQ_CLK_ENET_PHY_REF] = imx_clk_composite("enet_phy", imx8mq_enet_phy_sels, base + 0xaa80);
+	clks[IMX8MQ_CLK_NAND] = imx_clk_composite("nand", imx8mq_nand_sels, base + 0xab00);
+	clks[IMX8MQ_CLK_QSPI] = imx_clk_composite("qspi", imx8mq_qspi_sels, base + 0xab80);
+	clks[IMX8MQ_CLK_USDHC1] = imx_clk_composite("usdhc1", imx8mq_usdhc1_sels, base + 0xac00);
+	clks[IMX8MQ_CLK_USDHC2] = imx_clk_composite("usdhc2", imx8mq_usdhc2_sels, base + 0xac80);
+	clks[IMX8MQ_CLK_I2C1] = imx_clk_composite("i2c1", imx8mq_i2c1_sels, base + 0xad00);
+	clks[IMX8MQ_CLK_I2C2] = imx_clk_composite("i2c2", imx8mq_i2c2_sels, base + 0xad80);
+	clks[IMX8MQ_CLK_I2C3] = imx_clk_composite("i2c3", imx8mq_i2c3_sels, base + 0xae00);
+	clks[IMX8MQ_CLK_I2C4] = imx_clk_composite("i2c4", imx8mq_i2c4_sels, base + 0xae80);
+	clks[IMX8MQ_CLK_UART1] = imx_clk_composite("uart1", imx8mq_uart1_sels, base + 0xaf00);
+	clks[IMX8MQ_CLK_UART2] = imx_clk_composite("uart2", imx8mq_uart2_sels, base + 0xaf80);
+	clks[IMX8MQ_CLK_UART3] = imx_clk_composite("uart3", imx8mq_uart3_sels, base + 0xb000);
+	clks[IMX8MQ_CLK_UART4] = imx_clk_composite("uart4", imx8mq_uart4_sels, base + 0xb080);
+	clks[IMX8MQ_CLK_USB_CORE_REF] = imx_clk_composite("usb_core_ref", imx8mq_usb_core_sels, base + 0xb100);
+	clks[IMX8MQ_CLK_USB_PHY_REF] = imx_clk_composite("usb_phy_ref", imx8mq_usb_phy_sels, base + 0xb180);
+	clks[IMX8MQ_CLK_ECSPI1] = imx_clk_composite("ecspi1", imx8mq_ecspi1_sels, base + 0xb280);
+	clks[IMX8MQ_CLK_ECSPI2] = imx_clk_composite("ecspi2", imx8mq_ecspi2_sels, base + 0xb300);
+	clks[IMX8MQ_CLK_PWM1] = imx_clk_composite("pwm1", imx8mq_pwm1_sels, base + 0xb380);
+	clks[IMX8MQ_CLK_PWM2] = imx_clk_composite("pwm2", imx8mq_pwm2_sels, base + 0xb400);
+	clks[IMX8MQ_CLK_PWM3] = imx_clk_composite("pwm3", imx8mq_pwm3_sels, base + 0xb480);
+	clks[IMX8MQ_CLK_PWM4] = imx_clk_composite("pwm4", imx8mq_pwm4_sels, base + 0xb500);
+	clks[IMX8MQ_CLK_GPT1] = imx_clk_composite("gpt1", imx8mq_gpt1_sels, base + 0xb580);
+	clks[IMX8MQ_CLK_WDOG] = imx_clk_composite("wdog", imx8mq_wdog_sels, base + 0xb900);
+	clks[IMX8MQ_CLK_WRCLK] = imx_clk_composite("wrclk", imx8mq_wrclk_sels, base + 0xb980);
+	clks[IMX8MQ_CLK_CLKO2] = imx_clk_composite("clko2", imx8mq_clko2_sels, base + 0xba80);
+	clks[IMX8MQ_CLK_DSI_CORE] = imx_clk_composite("dsi_core", imx8mq_dsi_core_sels, base + 0xbb00);
+	clks[IMX8MQ_CLK_DSI_PHY_REF] = imx_clk_composite("dsi_phy_ref", imx8mq_dsi_phy_sels, base + 0xbb80);
+	clks[IMX8MQ_CLK_DSI_DBI] = imx_clk_composite("dsi_dbi", imx8mq_dsi_dbi_sels, base + 0xbc00);
+	clks[IMX8MQ_CLK_DSI_ESC] = imx_clk_composite("dsi_esc", imx8mq_dsi_esc_sels, base + 0xbc80);
+	clks[IMX8MQ_CLK_DSI_AHB] = imx_clk_composite("dsi_ahb", imx8mq_dsi_ahb_sels, base + 0x9200);
+	clks[IMX8MQ_CLK_CSI1_CORE] = imx_clk_composite("csi1_core", imx8mq_csi1_core_sels, base + 0xbd00);
+	clks[IMX8MQ_CLK_CSI1_PHY_REF] = imx_clk_composite("csi1_phy_ref", imx8mq_csi1_phy_sels, base + 0xbd80);
+	clks[IMX8MQ_CLK_CSI1_ESC] = imx_clk_composite("csi1_esc", imx8mq_csi1_esc_sels, base + 0xbe00);
+	clks[IMX8MQ_CLK_CSI2_CORE] = imx_clk_composite("csi2_core", imx8mq_csi2_core_sels, base + 0xbe80);
+	clks[IMX8MQ_CLK_CSI2_PHY_REF] = imx_clk_composite("csi2_phy_ref", imx8mq_csi2_phy_sels, base + 0xbf00);
+	clks[IMX8MQ_CLK_CSI2_ESC] = imx_clk_composite("csi2_esc", imx8mq_csi2_esc_sels, base + 0xbf80);
+	clks[IMX8MQ_CLK_PCIE2_CTRL] = imx_clk_composite("pcie2_ctrl", imx8mq_pcie2_ctrl_sels, base + 0xc000);
+	clks[IMX8MQ_CLK_PCIE2_PHY] = imx_clk_composite("pcie2_phy", imx8mq_pcie2_phy_sels, base + 0xc080);
+	clks[IMX8MQ_CLK_PCIE2_AUX] = imx_clk_composite("pcie2_aux", imx8mq_pcie2_aux_sels, base + 0xc100);
+	clks[IMX8MQ_CLK_ECSPI3] = imx_clk_composite("ecspi3", imx8mq_ecspi3_sels, base + 0xc180);
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
+	clk_set_parent(clks[IMX8MQ_VIDEO2_PLL1_OUT], clks[IMX8MQ_VIDEO2_PLL1]);
+	clk_set_parent(clks[IMX8MQ_VIDEO2_PLL2_OUT], clks[IMX8MQ_VIDEO2_PLL2_DIV]);
+
+	clk_set_parent(clks[IMX8MQ_CLK_AHB_SRC], clks[IMX8MQ_SYS1_PLL_133M]);
+	clk_set_parent(clks[IMX8MQ_CLK_NAND_USDHC_BUS], clks[IMX8MQ_SYS1_PLL_266M]);
+	clk_set_parent(clks[IMX8MQ_CLK_AUDIO_AHB_SRC], clks[IMX8MQ_SYS2_PLL_500M]);
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
index 9dbb680..e89c3a7 100644
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

