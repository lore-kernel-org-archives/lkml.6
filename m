Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5034ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A17B21480
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TIpptwUA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A17B21480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbeIXQm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 12:42:58 -0400
Received: from mail-eopbgr50067.outbound.protection.outlook.com ([40.107.5.67]:14880
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728100AbeIXQm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 12:42:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slBA9PFtR5weZ6Q+vyULpdbIoS5mfGSDNDiCKxldOJE=;
 b=TIpptwUAeTM7kSrSu5tELnIm8LpKHWKL0SBA4YB1iXXE3z8x3BLzj0cWiQ+v/rxrLszD/f3uQc68zas0/5+KB+DkFHgxVQlVMWx4pTw0x5qm+adHGnaAf9vzJzFWN6r9aLbEHgjyPni/KWmxT/xYZqmC0HD8QiPRI3cqkHHpjeY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
Received: from fsr-ub1664-175.ea.freescale.net (95.76.156.53) by
 VI1PR04MB1616.eurprd04.prod.outlook.com (2a01:111:e400:596b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.22; Mon, 24 Sep
 2018 10:40:48 +0000
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
Subject: [PATCH v9 4/5] clk: imx: add imx composite clock
Date:   Mon, 24 Sep 2018 13:39:56 +0300
Message-Id: <1537785597-26499-5-git-send-email-abel.vesa@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 60ea690f-038e-4050-88c5-08d6220a3114
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1616;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1616;3:9H9V3Kdlma6VNdtlMg4slJkG1nnXPNyyqN2o7u79znL875JGQhEY3ErAz97+oaOkgbJRpkFdq9kuY5aqC1sMuNxHVaiIkCzAn896xHZr6FReGe8iqjrYfQSn+XsrXIFnFBKbzeWqpuqMGyDMka8JgGrTYsjTzFvmnQqmuticruemoemFsNHcYaNG3mJdLRjnGk7dtWEVmmb81m9I5FH3sKNuf2fSnw498WkLz04d+YpdpiwBg+FvF9jK9MIgLQbp;25:9yiCOi7P5d1mZ++v5yMNmhlmiDyroQasWX/NyJ/9JoFJNNPuU/aa6xVx1bgFFMR57j8zIS9zA454ZvnqVpwYJbH4Tr2uk7o/JJH2QgbF8t0v+cyE4Ahf1fHp4TUIhEXVeSAg0cihlNuzw8EDs2OiduTvldzMsgL7ldyiTj5WmL3+62akh2yLuLFmHorH6L3kSUOUwU41YK4LXakZ3ZVABubVVLNLL4jX0eGMNym5aQ4hB0KKqpthjYP+ufgDwawW9BLU05qlzi1WuVnzn9Qx7Vg0s0Xbs+IaiSLBavO10vu11VQ7gwZFuLRI+/1YJTF4ngxxAceDL/uICOPtKV9YsA==;31:L8SDEIMk8+ZQeQ4OuZMEty6sv5Qy24jJ5jJyH2oPL1XP+ry/QsYZulXz1EQwE8ICobY8ym+SPVCtMGYqosdrqKh3QonTKmePmQcbNMrKqWscIXWhl9C0LzpJHvA4i+H9gicbmUhWkdcE0zOEW68z6xDNtdQlUk7sjKpDYdwA/KZo1phqTKsidyh03N7+m/bIzqh9qBezc0ag6gCgclSs87n4C1pRrxVySP0Lm4/+TlM=
X-MS-TrafficTypeDiagnostic: VI1PR04MB1616:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1616;20:6ivC6CKXREymNuZfD5lLcy+HGnvGHxhUDtxXnBImzLxHEKN6GalJyALqH+WuiIaWtTRlXIyzUI3fjespVvIlp9dkHTXqAwxE9OGa4afcSfPyxLFTgz31JoZSDVVwNFC/iv/jRDFgzEnE/UW32nFrXtgn6SiJyj/GO4b1CbvzogbOKUWbgo7NLt7bj8SI99PaZK9tULOfA6TRoen1FjeGWsu6m2P69u5nvLD535Hgyo+ky8zDvRQzd1/+4Emjb8314qlP7uibEHv5e78OqNKVvnSA8MkszgujIc8nUhULW7JeA+GFX1CI/XjtRROTasXkY+Jz2jdNywlgGxyOKZSsP5nai2Eb5/SP646XtaB2LM2lmeh/hm9XeZysGdud+/Y8A/yE4cRctbT/iDc77PG54QFHYndB5hZF/GWht+5xbguJ9eGEtCluKvt30Va5wM8mZErtyquHogVQxjh1oSQkAjXcvgFwc3qF+hlflAdQByFGJ9SwcgaSeNjq0QJDqpVk;4:eaAQu+R/qWXIBkODHwXsN7kM4XMxseNQMwOYF7pFf25b892DKLfMrjnVyqyJV5/1cuPaY7GXP+bgOyWm3nrMpRpoqzXCHMfv2cpE6VH/E0dTnmb4gofynB4sjP/iSz3z/+Jlj/hzj4Nn79N2qiZ9Bw8SJ9w5QsrtiMIrfVWzLEilsojkXiIkZKLcByjBfZ0rBr6TdhcIMrE9FDWhy4pyOa39drDllj1+bDcGUaYjY93AiTLpaTi+nRmYKUYKzPQdxpQ7bNI69Y9Nu4zSRLU+8WuOE6qCIKjTIAlj0l1ruRNzTFgdvjbTI2MTy/rInCKn
X-Microsoft-Antispam-PRVS: <VI1PR04MB1616367BA3333C5221AA1C1AF6170@VI1PR04MB1616.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(10201501046)(3002001)(6055026)(149066)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051);SRVR:VI1PR04MB1616;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1616;
X-Forefront-PRVS: 0805EC9467
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(136003)(346002)(376002)(199004)(189003)(52116002)(51416003)(14444005)(48376002)(50466002)(36756003)(76176011)(53936002)(6506007)(478600001)(44832011)(4326008)(6486002)(6512007)(25786009)(26005)(186003)(16526019)(386003)(11346002)(446003)(486006)(476003)(2616005)(956004)(8936002)(50226002)(2906002)(68736007)(81156014)(7416002)(81166006)(575784001)(8676002)(47776003)(66066001)(105586002)(6116002)(3846002)(305945005)(106356001)(97736004)(5660300001)(39060400002)(110136005)(6666003)(54906003)(316002)(86362001)(16586007)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1616;H:fsr-ub1664-175.ea.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB1616;23:zuq4tTFAPSVUVwBwm7nfkYcfWZ8ujc++EWidB2gJs?=
 =?us-ascii?Q?YyrBLN6rL5pJfNwxmfsnNljNn+HR8/YsNzbsmheC6/7sziiby0uCqjveA+Bj?=
 =?us-ascii?Q?f0EC+YCdvR8Dn5RXIBnCjBGUZNBE30KKHWbENwY7IzDYy6KGTnTGzxVOKlSf?=
 =?us-ascii?Q?txN2fMPTFCuebqRwX3QbQBnihhqODMpdxESqHVcUtQNiExUdDnM1XtFcdMem?=
 =?us-ascii?Q?jbvjcQnDrPeyhwjp0MWSn5Jd2MxJgixVYn+l6CgpkQgtOTgxvbpnGKBQvdkC?=
 =?us-ascii?Q?pEvVzjkwHfq3qUQiX63rHvOTbRU1s0Ad1QmozBBp+bnm+XYE0TA4G34Gv6ED?=
 =?us-ascii?Q?lYglgvH2tO/efawUQ29xKnwrRmeI6rPSygoATV7Bo+GtVIssdfrKN/q4HONz?=
 =?us-ascii?Q?MkFJlCS/3ljgfFOoSxd95iQjdU2k0MyCiofMcNsUnMXzJYXKiGKaImBXYuLW?=
 =?us-ascii?Q?dq/SBobGcSFSfjbtSpI24DAgn8LBGHIzP0jdK4gQoH2WBG7bfoJgZ75Y7mXg?=
 =?us-ascii?Q?xnZinVzH5qiRcTgu++DtVuXE9Nc1MYtYPubCLUBOrpVwAkURGGYIGtGGIbjQ?=
 =?us-ascii?Q?6J8MGu3gYs6o+mmldIDgbJvNAPwPAFp4iHQ/2fY2MK9o2J1FSZdjKnuKka3d?=
 =?us-ascii?Q?euCJBiwMaC2AsTfl25Bpm+T0F/hzyfSNpBL6nweMl/YG3BYjGqMobajq/pNP?=
 =?us-ascii?Q?63H3FFNVWC6Hp2L1gUtEea/bsdqfO+FRnVLdyDI9UNUw1IyMYX044qD7IaLU?=
 =?us-ascii?Q?xNbiBcy66hltp1IomMu2PhiYDC41wJxKbJi4kiOQfp8GS0IILzxki0uQsM4w?=
 =?us-ascii?Q?5QNYN/m/GaB0mdXlwtEdt74SNvX3fpI52UaIjzcxO+INaafD4tulTvqgT4+G?=
 =?us-ascii?Q?4cV0aoqMEeOqOYu6kNP8mqPH+WRYVE7V7BEbUCnh6t6BiAGCKrccoh5UTVMZ?=
 =?us-ascii?Q?7U5PXzdRXTiT6GmCeGeM9t21DSS6W5TWaEt7c0RF4JbqYeC1cfsu2n3sQgRB?=
 =?us-ascii?Q?W9tRRvG+gx1pTGqo9qMsMyJ3TKwU6XZntWYL9ZDcad8cy+XjM0Wgx8RQk+fu?=
 =?us-ascii?Q?1hFW5aSSvNi2tOOErElIx1tdCiy6oTNXgc3I6C3H4nmosDhB04rdRFhLCCXW?=
 =?us-ascii?Q?3dRyI+u2dr1TLWdiC3DmKebmcmJiGkvC1P7ambBuuDQQ389vOTqMqnzRFy6E?=
 =?us-ascii?Q?5Yfa1/61QFT1mMK1aPc1EJCbyj8QCDHvEYjltNYYWAl/7UjOWILWsDMlYL5t?=
 =?us-ascii?Q?qDvdNcAHmhnpYaZjE2ATfbAB5pfsFxESF+vn6Vp0AFyQ2lItO4hrPWbdj+jE?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: EznE7NS+oMJocEGGT265j75biAOYhESCpAotupj+FcTETcRh0BlCBebh//mjlQ8uFAa0yyiKHB/mbYmEuko9iZllKM/cTZJID7SDBlpwHFH0tZRo7GPfQ2Xamese53jyGjIAXh/CVs+Y1yOITY1rvA34SlKuIVfta1kFYSdf+J68Lm0wEBvkUFKs+3fI3uXQTHa0lTtT7wzfVVpLK8mOY5OBYDr6d0iiWX8eKteGtD9Mf2dRkLaF+GewRU7ZC5JhSKoKEM2BJmfdOzB0F+GsuezhjmUiWb2m7k746rCuBctVECuult2upiUmHxaw4nwHVEPfLff+Hf//RH4ZlWgdTk4qUpwZhZXdoPDM76jSNsI=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1616;6:EuV7T6dEzKbOLmyljGsujw/+EGGW7gOWrkNVvZuM3s2RHcpYkmSbYHOnUkIu4tHFytHP836e40ezSxA7W/2o/DI7H/MWvibG9WHcwAiXNKSriXQ54jzGIrrELkUgY+XNppKITOzYPh+1NVmSWhVJPSpXcheGjBlkOKX/epfMofsmY8dbL98PMq8HzqaA4qfu8VD8+nQLvX8awRRQ4zi7MPwyzO7kFVf9xZRJsIhrUx5g16E74MyMjB/1hOHDXkuztFhOFs+kfqFh/73kaRmOEuSQq1c6yotreTyz8D0xHZkHJt0JYR44QcLY3WfW+FpnHYEUn8Sy0dFk+w8hUTq+WhEJhxVXS0e9AumJUsA1TZ/rBibxnQk8QXyaSQkgbYvtqF6yTo2Ga602f5P1Fu41N87jlK6khmxFHa/vijGvrvCct0y4/FkGGTbi3OgPbar1uei4DTevei4rnHN+qOEErA==;5:xje7i6iyWf/1ofrMqYgcvdVYPU6hapN3hXHzDrchrJqrt07hFu9D3ELcJzMc8DXN2mgPDwJBfHpx+1VnZ5YbYx+vb91g1KzgoJDYtb3DkkpTDLo0FeuDsqbLb+Rc4ag02Q4zxXWvKM1h/p1DhFT6wfsQDC/8404OOBaP/NwrFW4=;7:/BPR/jDYf8i3IIcrpwLgp1pPi28U6xgd9TbBLvpbDKV6eJEYPk6ymPgrcJa3gpDRGGlIbxIcNsAhQk9NEwT7f3IPqdhFoL+lAKbHqi7xpQvfbpAcoAcdMn59X4L0VwYbfHrIYuhHTgOieVgonsJXVh0LtbQgzDZS3t+5BRw1lztgUx2LzCPPD4tHV+hJn1kJygX46eblJ+McGPwF2dCXJGdNdEpU8VNlt6MGquSbwTESvvWEiCQpHEZ7d5P35dne
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2018 10:40:48.1084
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60ea690f-038e-4050-88c5-08d6220a3114
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1616
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since a lot of clocks on imx8 are formed by a mux, gate, predivider and
divider, the idea here is to combine all of those into one composite clock,
but we need to deal with both predivider and divider at the same time and
therefore we add the imx_clk_composite_divider_ops and register
the composite clock with those.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Suggested-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/clk/imx/Makefile        |   1 +
 drivers/clk/imx/clk-composite.c | 181 ++++++++++++++++++++++++++++++++++++++++
 drivers/clk/imx/clk.h           |  14 ++++
 3 files changed, 196 insertions(+)
 create mode 100644 drivers/clk/imx/clk-composite.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index b87513c..4fabb0a 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -3,6 +3,7 @@
 obj-y += \
 	clk.o \
 	clk-busy.o \
+	clk-composite.o \
 	clk-cpu.o \
 	clk-fixup-div.o \
 	clk-fixup-mux.o \
diff --git a/drivers/clk/imx/clk-composite.c b/drivers/clk/imx/clk-composite.c
new file mode 100644
index 0000000..4b03107
--- /dev/null
+++ b/drivers/clk/imx/clk-composite.c
@@ -0,0 +1,181 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2018 NXP
+ */
+
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/clk-provider.h>
+#include <linux/clk.h>
+
+#include "clk.h"
+
+#define PCG_PREDIV_SHIFT	16
+#define PCG_PREDIV_WIDTH	3
+#define PCG_PREDIV_MAX		8
+
+#define PCG_DIV_SHIFT		0
+#define PCG_DIV_WIDTH		6
+#define PCG_DIV_MAX		64
+
+#define PCG_PCS_SHIFT		24
+#define PCG_PCS_MASK		0x7
+
+#define PCG_CGC_SHIFT		28
+
+static unsigned long imx_clk_composite_divider_recalc_rate(struct clk_hw *hw,
+						unsigned long parent_rate)
+{
+	struct clk_divider *divider = to_clk_divider(hw);
+	unsigned long prediv_rate;
+	unsigned int prediv_value;
+	unsigned int div_value;
+
+	prediv_value = clk_readl(divider->reg) >> divider->shift;
+	prediv_value &= clk_div_mask(divider->width);
+
+	prediv_rate = divider_recalc_rate(hw, parent_rate, prediv_value,
+						NULL, divider->flags,
+						divider->width);
+
+	div_value = clk_readl(divider->reg) >> PCG_DIV_SHIFT;
+	div_value &= clk_div_mask(PCG_DIV_WIDTH);
+
+	return divider_recalc_rate(hw, prediv_rate, div_value, NULL,
+				   divider->flags, PCG_DIV_WIDTH);
+}
+
+static int imx_clk_composite_compute_dividers(unsigned long rate,
+						unsigned long parent_rate,
+						int *prediv, int *postdiv)
+{
+	int div1, div2;
+	int error = INT_MAX;
+	int ret = -EINVAL;
+
+	/* default values */
+	*prediv = 1;
+	*postdiv = 1;
+
+	for (div1 = 1; div1 <= PCG_PREDIV_MAX; div1++) {
+		for (div2 = 1; div2 <= PCG_DIV_MAX; div2++) {
+			int new_error = ((parent_rate / div1) / div2) - rate;
+
+			if (abs(new_error) < abs(error)) {
+				*prediv = div1;
+				*postdiv = div2;
+				error = new_error;
+				ret = 0;
+			}
+		}
+	}
+	return ret;
+}
+
+static long imx_clk_composite_divider_round_rate(struct clk_hw *hw,
+						unsigned long rate,
+						unsigned long *prate)
+{
+	int prediv_value;
+	int div_value;
+
+	imx_clk_composite_compute_dividers(rate, *prate,
+						&prediv_value, &div_value);
+
+	rate = DIV_ROUND_UP_ULL((u64)*prate, prediv_value);
+	rate = DIV_ROUND_UP_ULL((u64)rate, div_value);
+
+	return rate;
+}
+
+static int imx_clk_composite_divider_set_rate(struct clk_hw *hw,
+					unsigned long rate,
+					unsigned long parent_rate)
+{
+	struct clk_divider *divider = to_clk_divider(hw);
+	unsigned long flags = 0;
+	int prediv_value;
+	int div_value;
+	int ret = 0;
+	u32 val;
+
+	ret = imx_clk_composite_compute_dividers(rate, parent_rate,
+						&prediv_value, &div_value);
+	if (ret)
+		return -EINVAL;
+
+	spin_lock_irqsave(divider->lock, flags);
+
+	val = clk_readl(divider->reg);
+	val &= ~((clk_div_mask(divider->width) << divider->shift) |
+			(clk_div_mask(PCG_DIV_WIDTH) << PCG_DIV_SHIFT));
+
+	val |= (u32)(prediv_value  - 1) << divider->shift;
+	val |= (u32)(div_value - 1) << PCG_DIV_SHIFT;
+	clk_writel(val, divider->reg);
+
+	spin_unlock_irqrestore(divider->lock, flags);
+
+	return ret;
+}
+
+static const struct clk_ops imx_clk_composite_divider_ops = {
+	.recalc_rate = imx_clk_composite_divider_recalc_rate,
+	.round_rate = imx_clk_composite_divider_round_rate,
+	.set_rate = imx_clk_composite_divider_set_rate,
+};
+
+struct clk *imx_clk_composite_flags(const char *name,
+					const char **parent_names,
+					int num_parents, void __iomem *reg,
+					unsigned long flags)
+{
+	struct clk_hw *mux_hw = NULL, *div_hw = NULL, *gate_hw = NULL;
+	struct clk_divider *div = NULL;
+	struct clk_gate *gate = NULL;
+	struct clk_mux *mux = NULL;
+	struct clk *clk = ERR_PTR(-ENOMEM);
+
+	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
+	if (!mux)
+		goto fail;
+
+	mux_hw = &mux->hw;
+	mux->reg = reg;
+	mux->shift = PCG_PCS_SHIFT;
+	mux->mask = PCG_PCS_MASK;
+
+	div = kzalloc(sizeof(*div), GFP_KERNEL);
+	if (!div)
+		goto fail;
+
+	div_hw = &div->hw;
+	div->reg = reg;
+	div->shift = PCG_PREDIV_SHIFT;
+	div->width = PCG_PREDIV_WIDTH;
+	div->lock = &imx_ccm_lock;
+	div->flags = CLK_DIVIDER_ROUND_CLOSEST;
+
+	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
+	if (!gate)
+		goto fail;
+
+	gate_hw = &gate->hw;
+	gate->reg = reg;
+	gate->bit_idx = PCG_CGC_SHIFT;
+
+	clk = clk_register_composite(NULL, name, parent_names, num_parents,
+					mux_hw, &clk_mux_ops, div_hw,
+					&imx_clk_composite_divider_ops, gate_hw,
+					&clk_gate_ops, flags);
+	if (IS_ERR(clk))
+		goto fail;
+
+	return clk;
+
+fail:
+	kfree(gate);
+	kfree(div);
+	kfree(mux);
+	return clk;
+}
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 12b3fd6..9d7c9c8 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -232,4 +232,18 @@ struct clk *imx_clk_cpu(const char *name, const char *parent_name,
 		struct clk *div, struct clk *mux, struct clk *pll,
 		struct clk *step);
 
+struct clk *imx_clk_composite_flags(const char *name, const char **parent_names,
+		int num_parents, void __iomem *reg, unsigned long flags);
+
+#define __imx_clk_composite(name, parent_names, reg, flags) \
+	imx_clk_composite_flags(name, parent_names, \
+		ARRAY_SIZE(parent_names), reg, \
+		flags | CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE)
+
+#define imx_clk_composite(name, parent_names, reg) \
+	__imx_clk_composite(name, parent_names, reg, 0)
+
+#define imx_clk_composite_critical(name, parent_names, reg) \
+	__imx_clk_composite(name, parent_names, reg, CLK_IS_CRITICAL)
+
 #endif
-- 
2.7.4

