Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4297FC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 07:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6BBB208FA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 07:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="j0bfKEim"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6BBB208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbeHTKbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 06:31:03 -0400
Received: from mail-eopbgr00087.outbound.protection.outlook.com ([40.107.0.87]:40384
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726026AbeHTKbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 06:31:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7UoHKzRUM4Rc1K65M2cWPvUaeNiIh/eVzAHvLglLFMc=;
 b=j0bfKEimKZD+66zimdC28p6JZX46fGhn+vj5pBwT8u+9Q8d+mzMU4qgV9oCcPCIE8S+XZE/FvdIgU1SRgYk9oB2ypIwqMowuohBB6Ee9zmO486WzLXD7nfv4xwGqqZWQfPGWl4SqAKnVQYY+PsYc7k0bGz+byyWsyaWYRdjBdjc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
Received: from fsr-ub1664-175.ea.freescale.net (95.76.156.53) by
 DB5PR04MB1608.eurprd04.prod.outlook.com (2a01:111:e400:5994::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.22; Mon, 20 Aug
 2018 07:16:23 +0000
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
Subject: [RESEND v5 2/5] clk: imx: add fractional PLL output clock
Date:   Mon, 20 Aug 2018 10:16:04 +0300
Message-Id: <1534749367-31085-3-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534749367-31085-1-git-send-email-abel.vesa@nxp.com>
References: <1534749367-31085-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: HE1P190CA0037.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::26)
 To DB5PR04MB1608.eurprd04.prod.outlook.com (2a01:111:e400:5994::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fa6c7b4-5b95-4d54-d287-08d6066cd711
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1608;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1608;3:ZhGJ2immBZ08fs7U58pRPF5f/n7dq7mtGy+xLMgkdAcQtpU7uST/9MhaC6HtmuqNha1sbgn/vMUCO5F+u8QbiL70FHimVcCptcx38gQ1W+CdfqhnUjBYpzUeYpLix9RBwTEROMGLwkySTH1EAJHLrQXstKL5QLFB1puZRmRwAQtck+3z+6RUaSio1Fp5gk7xFpMk2WPMVHfHRAdjCDq4y1xBxzdrlDGajgD0e/Jyhy/6JCpYynXDZGb07zL/I401;25:R8GNzqTDvDGTdoOGevY+yOJ7CYBmdCR3vUw/bUzanaE891+djoVoycSbybgfYIXfCIvNs7Tvaak3LtPbu0E5fSLk0ytccka9nowIomyLOU9GuNE0GupZArBWpCBW6xVbMxnL6c2ib6aJcG0wvYqgwl2b6HD/BZ7UkD5VK7Zy73lMri4Xn6/H65zCzzG4eJIT8uqCGhIpxs8hbkGe4bjDNnv3q4pzhhnJKo4Rvx9fRjsARDjlJrb3ILp60XUtyxYXIivTkK6F63lRBjITeTHhKjw/jJuJt33pUr7Ih1cOVDxJulYGReA1bH6AP7m7w6jxyM6WxL762SyLUFrtMx2wwg==;31:nkkg3Ev8APOri7NEykLL0COU10OtjwoU8BobInWxIH2F7BOzPyfGc6OVJja/Buv6kZZMOT8Wyl6KacHTncgJu97410rYyY8ncbZaGPlWBxhRcQfgLlfKznNaUzV9Pukv8HrXdjktd0Z+GHwZRlq00kotuOaeBW4xsFxUuF/1zP8a4lCgARL5AaLPp34xftzwbruHpwKpcwgdc1XAZaLpTCMwaOO9IkkIinlyPzwSkYo=
X-MS-TrafficTypeDiagnostic: DB5PR04MB1608:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1608;20:jgwrRoLKNufmeA5vQcASQZHrseAPC965oOdXS1SwLMgFjN2PtfYAW7mNPCYasd6dRUsKvI7FNIdZun60mOYL+cu5V7AJnIlBRf/AoEQyWlxxya2X00tv34HUkt46MN4nGZZkiT/6SL6ksyiaEbKVvB6Ju4V/eGiUmkP+zMbImxaRP+J3jM8GTEk1BvmLwvlQzyZmFgzOIv/3kB3w5hzhy62NJGY26y3dhCPg4f0kJJVWvU0KmurwJyt+EE5Ye3PC8nW8CUFeEa/nosUrY1GUY/rC581RQjbSkfcE7ekMfYG7kQsGnEpaIjG9qgVYP0LnZ/dk9Rc/hTARGPlrRgdrn1QV9T1k5FbigUzkR05/dK+vgxqFJWBwpvzfNTy35rZdI8k3H+/DmHN4kB+hKZ9Y52yeTFFcHYDukSyd3FzN+b6X+gyQ0TGrE0vzH1qqujNuTrhyGWh04PCrW5OjNprRskPN5fCynuwBO5v30DR7sg1Ht1a9X+ns/ai7cLu1bPUi;4:+YcWqGd6UJuVBpPM0aFmgNiMwLSmq0y4XiH+F/EtEIIIRzEDKPh3FXuBbLcUlJQvqIqO3we2RTjh7pL6+w5S93Xl506L9k74DNbSEJGG7/Y33QrwlZiBFNyVorNsEXwFGaP3jaI3zHZuMiZscpKrBjxeMmgQ25mxLvc28TPrMvoX3mGAE/FkqJC/vK2g87Eg1Az4gG/Zg84XG7LjrVm+PQHToRtb1dCtk7IL69H+mias3V+vJOPoU+TFlO1TtCI96TUJBiOLln+75w9MPvGoeR+ldUIVUYNKzfLCMva/rIwESJOrRDLCkqmH7G3ehNKd
X-Microsoft-Antispam-PRVS: <DB5PR04MB16085508FB4B27FFF8863986F6320@DB5PR04MB1608.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699016);SRVR:DB5PR04MB1608;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1608;
X-Forefront-PRVS: 0770F75EA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(366004)(346002)(39860400002)(189003)(199004)(5660300001)(7416002)(50466002)(6636002)(6666003)(305945005)(6486002)(14444005)(48376002)(4326008)(25786009)(86362001)(51416003)(66066001)(81156014)(81166006)(316002)(76176011)(7736002)(47776003)(44832011)(16586007)(110136005)(52116002)(54906003)(8676002)(16526019)(478600001)(386003)(186003)(6506007)(6116002)(97736004)(106356001)(68736007)(53936002)(105586002)(3846002)(2906002)(36756003)(8936002)(50226002)(446003)(6512007)(2616005)(476003)(486006)(26005)(11346002)(956004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1608;H:fsr-ub1664-175.ea.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR04MB1608;23:iy4lUy/R3IepAbh/437yRTtRgYIwsssWaDSnwm0uf?=
 =?us-ascii?Q?S8+HU3yMUnGCu0Wrlun+XIXdXeQLgmQr5KZe2ltqwMRJe84TGqkIBGmtIfcX?=
 =?us-ascii?Q?pHjw10B3QJAKT2sCQLW6n7fj++vOk2lHtrk4WBZdsUkYpZKZhcWX9oqvz5c2?=
 =?us-ascii?Q?JNQuj3aSpvAuBHVGz9Zpy1WNyHP+1hMWRj22E1a7AjFmqfN5nBHnfTZL3Cyc?=
 =?us-ascii?Q?saRUsX3tDIa9N3yigddj8dCP7afgvx/B8Aq9YUNDYj105i/OZsefEbwzti7u?=
 =?us-ascii?Q?khZOATBBb6oXNU7jVr3POFozMT8y2e+Kes6n6MrIP9ajYJ1kBfXSRyFEkqyi?=
 =?us-ascii?Q?hnqZpmhOEC15/LADvF66LoKRhrbcHBPgaLc299jxClvLEGG7XzrR+5KExUbF?=
 =?us-ascii?Q?h4qjqrqlKUJkj+glDmNV/pNEOz03nfUOwgysP/vsGk9W0DJL0RT4PilgVodg?=
 =?us-ascii?Q?73SA90eKi9Q59zRq3KFN38smjaBcHYHiPqOQh//B8Mv0cPfkNPHybRWrnk90?=
 =?us-ascii?Q?/eOBNVq4WWrZYffjs8HLI2mdACuTQPONMr0Nicrz7/OxjjaC4HLcTdIpW1Qq?=
 =?us-ascii?Q?t9jmaP+wiNPY3gA8oeh7K+XTSTd3fTNDfT2tcIfkOotgCwDRyQii+d/ZSYD9?=
 =?us-ascii?Q?BeNQGqosHdBu/Hz0ngSdt2F+zio9VQNgJp6FBQsxAGC1zMhXbxzjjzPq6r8s?=
 =?us-ascii?Q?eda+Re6Z7FJ4wdIizELFrYROz6ObyYJ++4xoNti4CJ/QG+2bYVxwT0B3K//d?=
 =?us-ascii?Q?1opxOrEfDOjmrpjbu5AvLKyOh+sXlLaZiy2inqRotA21GYoj27M6usqdTtSX?=
 =?us-ascii?Q?BJu/HKCiG2ty3NbWVFrDCv9lcbYOa259LrBh3peMZPe+1pdxo2HJGGW5dz2J?=
 =?us-ascii?Q?PHHvAHGrEfHm2cRnBPf3+6JIn6ut/1a8xYDjPmKF7jsKcclaB3xsGSrKD6Ii?=
 =?us-ascii?Q?7eTO3aKU5xvJRVr19dyZj9EkDX1oLFrHeBxiJfxSL8N1j6ymTa4/ZmUWOqHC?=
 =?us-ascii?Q?fn39RGDmxJHMtejWd2QYjcy1udTImnzGIIlTYMdlylZNcpAOGHDTcSiXVe3Q?=
 =?us-ascii?Q?pPaONffhBttVAPMOEOcFm0lw9p1o26oFkR7C/CkCWAjBZuNCzD0ULOtLuye/?=
 =?us-ascii?Q?Fw24m3dZm+gRCLAthackWGeRbsdPpWeM/kAxJZ9kj5wwC+8nK3hE07vFZLcV?=
 =?us-ascii?Q?5+TwXxMWLWYTZmT8c3BDC9kZMmZj+537i5eGeTMu01OmeeG8MDm3efOAAezE?=
 =?us-ascii?Q?HdZ459hsu/saU+LxEud9PMxBzp7qzykq31lR7ke?=
X-Microsoft-Antispam-Message-Info: +FhJzayUxxoaL8XIJqaAPCWgGL/psWjuf3vz6eFq7ZaCyGVHCE4N/ZeoJcGZFfClGQ8Vs/FpnJYRkFnPFvQU+eiCdHda5YXD8iTnaAkB6rEbFRXG9wSFaV8i6VkFHmYjVpxB+SNSpo1MCcpaADChlz8OLTjgY8OmVhgiXkdxz/2vg0WO/GV0mIVgaOdpsUNMwbSxVV0oPeykqVQuCCN6KYrHB/A56ZDYcfvd3wAkS2ZzCLBDbTRA7cNaLuzXagLdyc1c+ycNtUKvlJlQ4xn48IIf20403NBdofG9CFgnXzYQdTo/Yb5SiV6MnVB2wHZkA93fn9RXnf5Mi/GPgVEA+F8sU/gLrE4vQ8JLmTal9fs=
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1608;6:g6yDnVYqPNYcFBwhv0Z6Eo3zIFizKylhUctByzzV7Dvr/6EJ9xMZtk15ysSccJvCwU1gAr3w5wNmgdm7WrbGjqtzy2MuOOL9MUQdGtS87hIhzVEQzfrAveQtCPMovoQOMOG5pJmmkJfoA2qSUwC36U241Ce3Wzuu1GE5dfaUjcTN2H99to9LuaCXT4gAivebenpwCEqexlzzmXs7Z8ERVxYfNN7/IrG2kEtA+mh2Ur8ckUmG8idU/oCN1WrLTXEOXtKUy2UqlHqBqmHwHLXH0+ugW27oWoP97+gX30CkY9W12p+3sxNEFf6Eh07niTlNj77qfI5IVtOEMOALxPB7O8/IMnQix+1ut/OnuttrxgjY/WKt0JV5T3FwLWvfd6D9Ujy5boZOBaymO83DIwnJr+9/tqUa8ciQ9X/8Q+DJlJj9ASH7fXzWnaa2EgdGrVrJ1VAbIu4mzeqEHEkZD/AsAA==;5:MX2M8QXk0jgJUIOssxld6VucOr5g4VXGyuqSKzenQa07WxdnDCktkXy9XWzdu+64eVKaheBcTv5IMAkgWLTcoC9V8CuWU8d8uyxwR+R/EtFtgJr631ZfF84NYHIZ2LVWkl2LxmT1SlMoP+LqUuDr5knUtPCYmg2VCzgRvJSWH7c=;7:zR8VUFzIx+e742PQoxtmNAMi5dKnDU250hAa/cjlsx69N6JEnZ48SqLKl9Dm2XhceIf16J2IYDxS6K5Ss4nWRkcEss/Bc2mHqiFnvnDO1YM6McnvrD5mAMiHkl+ksPOKgkAmqkyQovDVrW4yHAAnD2lXVYAGAAgVyPSEmuEC9S0aMZW7uz5GDgedbuNFOZEsmXrksRZ2bbUmgmSiOpC2I83gAk5OaFyFNVHCKuIpwZqRWsCY+AbHsrVa2qmhqZ0v
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2018 07:16:23.5256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa6c7b4-5b95-4d54-d287-08d6066cd711
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

