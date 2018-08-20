Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0830C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 07:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FBD520BED
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 07:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pDGMdxaX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FBD520BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbeHTKbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 06:31:08 -0400
Received: from mail-eopbgr00087.outbound.protection.outlook.com ([40.107.0.87]:40384
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726026AbeHTKbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 06:31:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dV++oeJYvJ+QTsW96ol5AhcKSF+hiBvprwOZ++xwZ2k=;
 b=pDGMdxaXMsEVc8XrCswfC1hlZ0k1RMTzB0QHghC0bSS3MjiFY4FINDl/bQ8FlZ864jHJ6DMZOPhrZuMKyk3kpqWqxsFROWDWonKUYrOPb5YAhmhne87NnB4Z8nSQg9ORbWvEXuA73H6EdOmJRn/3ffBwGvDo+L0DIYzPc9UggfE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
Received: from fsr-ub1664-175.ea.freescale.net (95.76.156.53) by
 DB5PR04MB1608.eurprd04.prod.outlook.com (2a01:111:e400:5994::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.22; Mon, 20 Aug
 2018 07:16:28 +0000
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
Subject: [RESEND v5 4/5] clk: imx: add imx composite clock
Date:   Mon, 20 Aug 2018 10:16:06 +0300
Message-Id: <1534749367-31085-5-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534749367-31085-1-git-send-email-abel.vesa@nxp.com>
References: <1534749367-31085-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: HE1P190CA0037.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::26)
 To DB5PR04MB1608.eurprd04.prod.outlook.com (2a01:111:e400:5994::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2bee727b-84b7-47f5-3e20-08d6066cda9e
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1608;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1608;3:omNpFbAiSF5cUru57vjrGW4qwMnNG6zAWJyneMH5IBWAGjdjPFNjWer7oqG7Jjx1rF4dcbUMGv0s9Jw+OvLPsCNZg6Lc1rPS5H21oRckD7LwUxL+QPsgx2SF1LD3vp3OphhbQktd0XKb3SUZ83V2pKXXNLEkOSwV+aTGMat2jIVJxdK0IVjGNsNOX7jRMrKIK4ni8o256bMIoTs5FiSlrWTm+uRphg4hcrDtk/Uhy7MLCEzRckdR0t3Na9HTXtlx;25:HNhfnQbc6NTNcOvHZrqN6duJga9TWjXCKgKlFaaM0YFE3b/u36iSKRZdHJNBFvGRSwyenV2HrmQoyuciB9qZNcVA7Cfsfap9CtvbWGuR092xvkcOOBwnlhj4a+CI08jwxOKiGuXFnE4F+nicfqRw9X+88gRXS5mRtB+0tpUzZcDBNDFdiy5qsE2ceyk5bYmVYeNpjymfBF2rL6mUfEh7CzXM7wtKOsrHZGbrxsa09m1LgDxh7P++pzWDq6QeqrBQ9eoWAs0V673blC1cyUgY3t5WVjCNvSivCntpyWx4aVOzHA1tUm6mrP/VzDjl5REv476cMnv5LIhZlvoxyp+w6g==;31:nH3waHk9yXjLC8BEFcdx4jhuoqUH/PdBF3oDUUQXwtmm4FhLAA/N/tYHT+2wyz8n4s9v9EkpW8xh/ZtVXb0tBFJtTuVk6UfwWJjAdxb/GXDTWQGBTzq/q4rrtFo/3iSN7twQdUKcDLtMVLAXN/UoZlZ4GOnjmJPQcuIdL0s6HfCrOoXWE3qquGdGc+DAjG4FNl/q/d4sWgiseUBOrQzLY6DOcWQtEJ69HFk/FyhZMFQ=
X-MS-TrafficTypeDiagnostic: DB5PR04MB1608:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1608;20:weTh2LwLihVMplhu3S3SHr8kAIVTvFohUEZ/sGXYssOOCPSQL0uduC36cYA0AN+1/xfxp7sCB30rCDmo4wcSgmTJohJQobbULTfFx4WQYTpxjFrat61dMu9i4SwnCag8hPBHpy+IN4qyhiussqt9aKHHeZDgBNg1PcmTwwzvuQSEFy0M6EFdaIcm+Jvm0/TWxZXnN95maBHUKCN2aicDDh0b+DJx0XdglOk/aIwosiqL8tKkmsS27I2Jvn36obc1iacx5pxq3q9XirAZO6/MoDngoDJ/MjHDlNhmABJy39UuZajwSVO+6ASqT9BLTNPG8oDcy52iXJslCE7spnRnAM4edPaWenxLjjgz6Jd6op7NTG/+6xpCcgbMmmQhEGnH7PEEjHwyqLxlAdaNbiOJtfYscsoPZupp95wu/4LPA6IaJ+yNG44oq4IDXH5cZTv2Vp4RJgyOJXiQ6cLsmn/2+PGjnZBDiu8DAQhT3FeMXdD1KAEIjWvBd/qNso5p7IUG;4:kYqVwcmBFo+9jK0mLOFPeKmLNuFuCsVQ+BdtXueBQmI0dW7NoUaN7RDxeWDmFVz41a9eYfrfZHqO8fJeBHHJBeLebYd9plBKmBZjkNPTrGP7rB5kD2QywtSFyYFcfhzXMOn6L3B5K9mJQ4QzszIXGcPni7IHpOemXAdcqt4w//jRUTh+skxzY1pIxmkry5E8yT5cc2lCZ+lkPxOHEhPxukmQDVMg8jaOD3zgmijpoEVsWoXRy0/JYbUug36mKURg7iDe+KOfHGAGxOJ1hKv9PwQBsy4twVwJihxp+5T+YWVbb5UyqCEBIkWz37abW0/0ceZf1p5Zqu7AKMQ0TnGkb+G+6JnCt0onFn0/4PzyE54=
X-Microsoft-Antispam-PRVS: <DB5PR04MB1608E8BB1E3F74596DF25D80F6320@DB5PR04MB1608.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699016);SRVR:DB5PR04MB1608;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1608;
X-Forefront-PRVS: 0770F75EA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(366004)(346002)(39860400002)(189003)(199004)(5660300001)(7416002)(50466002)(6636002)(6666003)(305945005)(6486002)(14444005)(48376002)(4326008)(25786009)(86362001)(51416003)(66066001)(81156014)(81166006)(316002)(575784001)(76176011)(7736002)(47776003)(44832011)(16586007)(110136005)(52116002)(54906003)(8676002)(16526019)(478600001)(386003)(186003)(6506007)(6116002)(97736004)(106356001)(68736007)(53936002)(105586002)(3846002)(2906002)(36756003)(8936002)(50226002)(446003)(6512007)(2616005)(476003)(486006)(26005)(11346002)(956004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1608;H:fsr-ub1664-175.ea.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR04MB1608;23:gL0A+hXc/vZf+rewX5Bx1P7oBwNc5DkQKDDB1WhK+?=
 =?us-ascii?Q?Vl1JxpzZNL3vovfLEADXw88CQ8XNtEzvH8nnl9j3OuEUyqflVuEb0y2wT5Q9?=
 =?us-ascii?Q?zODxxBcCHSrWg+3O71s9W7ofjIeaipLmaW3MjEF4IjdRetadLRK6LISFjJuM?=
 =?us-ascii?Q?fzXtuvDni5dE+1uOQ8OTHnaP/kEuTGVLMEJBHZ9yUm3QSaeKHd6twDYEOIO9?=
 =?us-ascii?Q?yUkSPWpWK2KXfenEKc5uHBPT57Jynr3dy8FZt9WLik8DGEeo43ZblxgURLxN?=
 =?us-ascii?Q?f44Mu8Hyo3YF+caJNpMvnidquJsUlKgtufV4aUquEyJIVsaiOpUT0Dp9P+nx?=
 =?us-ascii?Q?jztkFCUAw+iREX1QblbIu5rv+TASBUC6g5N+b6ngH9rp83dPD4Q1yfQOcsP1?=
 =?us-ascii?Q?B/AAMvf8jKVhpgMQ8DV2/5Gi7Tfv3ZMaWdOgx98haA/u5vpQAC4xNB629TIC?=
 =?us-ascii?Q?FaVYqzph4bu6tp2QMD14tlgLTTNw81ZCrHraBRmTNWLChMl+EDdfREOXezku?=
 =?us-ascii?Q?S9gssUclRfrL1IK2OpwtyA8wkgW66PVrxZaNP5Ujek/ViNIam6lUeQC6Tah7?=
 =?us-ascii?Q?z31BSAIZbM97mdRZF2GQKJLqZmCWmOIAIxUY2LLxMqlRdC2J1s6lJOR7prcz?=
 =?us-ascii?Q?Jnzt08akkBLaAcp16yJCVWqNUbBjEcWmjhNzJ4z6HqiGzbMetvYJPaDq9ypR?=
 =?us-ascii?Q?DrTfoqp0P2+VPhspzW16NBwwIccYUu+n9r2qG/f+s5FXVhBHDNPJgdA+6Ud9?=
 =?us-ascii?Q?idauoZSHJHPq7+S2vWi+h0XByuBGPBudECO9wu0GgdaKAIfp2O/tyGRtZK55?=
 =?us-ascii?Q?8fcyloF9K2EpHcPrsNKY5EKUWEd/rJJZ2wIF/9W5V/ok3zyTBWqzKqRtmiCf?=
 =?us-ascii?Q?9Iz2vt1SZDAWpxaMJF3mPsK8h8QFaySZmPohO1PlrBGm/+OZWQXLHyBGvCOT?=
 =?us-ascii?Q?IXIgqblrKSSKuDcsL+ltKV/aXqWrGe1LXLJMynn903HD5WOdj/TvMTrDyeLb?=
 =?us-ascii?Q?Aq31H0pmTlwL2VTtsrx4FcPEMi09cRNCTtPR1x4CjkWAaxtae98idWRPL54i?=
 =?us-ascii?Q?ILUSR2+1dhfAmIDbJulJoxBmDQE3h8hL/JSbtpwNEWU3Lud3rdYT5L3Y/ewa?=
 =?us-ascii?Q?Hz9gFTwMu2R4PRGhAZQCsC5oYOho9Esrpx1J99g9paOkDa7Ph8n2A7xSpNUX?=
 =?us-ascii?Q?D/lSYzB6QMrwrQgkpjH/Ama4bUqoS0qhWMjrgxlVTG6EE/CIM8VWWgVBP+1J?=
 =?us-ascii?Q?oV0FMMwSCmrISoLzzc3Zb9H6a9z3Pafa3bjUpBmXd75BgVRYU7OD6OKh2IdR?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: DGw8Jk0B5a4fanXQfwMbO+FFY8ueQWO9j+YTdLliS1pHFcpEcekkIUa3YaFrfz8RhGU9I+zeQ+/y693hAdxhXwPLPwkYF48RkGHrFjtbLLgNUrL2YsczUsUgOa9L3DBIPdDiUQ4v1DLbEoq0+L92Jp/59dFzgcT88twpMFAiqZa9+tM/NwST5XNbHb7bJSo+qIVlSDd+cB39JYQmRsmwHKnWbxoCn+ZqZEyLhRTm0Eba/HRiUJxzMqqLOoIKAazBbGn8PchtIuR19t1V2KH/UF7qTrBVckFBAO9XZBJA1x0zlxdVHhCVn8DdEF/fD8zUPUr0dYv8vSjWFEgjaA14Z9PTkhrVfLT/wg6spQj1/VI=
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1608;6:z/Yr552i/AAx7kuZuqDbWfNGACHP5C/ixoI0B+0S60v/MPzj82d4mzGvb5vOnFjqenvLXitqCDEBJwNcAGgIppE0jee6bes8+630DzTSdSMTTQP0H24LvmR1ve5885oy/xPadjyv87hk8lvmW0R9zxotzm0MtfgDsRHbMJUIjzxpYfEbCIP2W3QUfAUrgsJg8QP1xmRHrr6Nlw2Qe4o60W2sWQ55d2Ib5QlQyQH2ImB+g+HkiGF3Ri7Vt1pQwra2Vg+DlCY7MaWSexBeHRTaC9++x79bU1+1iUwo1tpN2v1lWKgp2RcHEzvS76t83MyPErDUFifoszqnBPwR33CtkJ0QMAEvJJjpIWj0o2xngNfWojliGINoPCHl1dwkko9kkAJ2BD3DBQJPXrzFXVhs+X1OV70Ehjc/M/4PDcoY5iRY9NoQ9RDCa4VpITfcT4qDd02ppnRqbTl17w1F4jc3JA==;5:23QRJJ4tXdj1fpMiElTJpDSz/ShCKycFD7q1t2BN/MGvr6y6rc2M05hoYlttjs4vkZUUX3NNxV4V95ZyY8zQOogUvUcYzwwTypTpJLdk91VjWW8KhMpu9XDPgEJyXwq2d6rfQFAcVmuZ/n19MauR4LR16Ig1YDcHpmDzeRAaRL8=;7:Rp0vAL15nK2fOEZsFCjo+bsWLcSL9HFjPHypLg/vQLr6WgnBYS1fwc9SU2zCiq0SAZuWmvuJFtRY7i7hfsaGiA5PHFtRxVhjUtG71W5gckg5CHtMuI6NnAHzQ/6g9nh5fYduKyDZX7a58faGXub0YWkSPZpHBUULWo5Nechz5JjHky76dzyoCejpWmVzA1qc33At267uO59IwL2gKGnfyYky1T7+BJSgnpAxCMqiWGP0weI7iFI09xbZ0ZEWdRZx
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2018 07:16:28.0415
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bee727b-84b7-47f5-3e20-08d6066cda9e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1608
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since a lot of clocks on imx8 are formed by a mux, gate, predivider and
divider, the idea here is to combine all of those into one more complex
clock type, therefore moving the complexity inside the composite clock and
outside of the SoC specific clock driver.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Suggested-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/clk/imx/Makefile        |   1 +
 drivers/clk/imx/clk-composite.c | 126 ++++++++++++++++++++++++++++++++++++++++
 drivers/clk/imx/clk.h           |   9 +++
 3 files changed, 136 insertions(+)
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
index 0000000..717c6f1
--- /dev/null
+++ b/drivers/clk/imx/clk-composite.c
@@ -0,0 +1,126 @@
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
+
+#define PCG_DIV_SHIFT		0
+#define PCG_DIV_WIDTH		6
+
+#define PCG_PCS_SHIFT		24
+#define PCG_PCS_MASK		0x7
+
+#define PCG_CGC_SHIFT		28
+
+static unsigned long imx_clk_composite_divider_recalc_rate(struct clk_hw *hw,
+						unsigned long parent_rate)
+{
+	return clk_divider_ops.recalc_rate(hw, parent_rate);
+}
+
+static long imx_clk_composite_divider_round_rate(struct clk_hw *hw,
+						unsigned long rate,
+						unsigned long *prate)
+{
+	return clk_divider_ops.round_rate(hw, rate, prate);
+}
+
+static int imx_clk_composite_divider_set_rate(struct clk_hw *hw,
+					unsigned long rate,
+					unsigned long parent_rate)
+{
+	struct clk_divider *divider = to_clk_divider(hw);
+	int value;
+	unsigned long flags = 0;
+	u32 val;
+
+	value = divider_get_val(rate, parent_rate, NULL,
+				PCG_PREDIV_WIDTH, CLK_DIVIDER_ROUND_CLOSEST);
+	if (value < 0)
+		return value;
+
+	spin_lock_irqsave(divider->lock, flags);
+
+	val = clk_readl(divider->reg);
+	val &= ~((clk_div_mask(divider->width) << divider->shift) |
+			(clk_div_mask(PCG_DIV_WIDTH) << PCG_DIV_SHIFT));
+
+	val |= (u32)value << divider->shift;
+	val |= (u32)value << PCG_DIV_SHIFT;
+	clk_writel(val, divider->reg);
+
+	spin_unlock_irqrestore(divider->lock, flags);
+
+	return 0;
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
+	struct clk *clk;
+
+	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
+	if (!mux)
+		return ERR_PTR(-ENOMEM);
+	mux_hw = &mux->hw;
+	mux->reg = reg;
+	mux->shift = PCG_PCS_SHIFT;
+	mux->mask = PCG_PCS_MASK;
+
+	div = kzalloc(sizeof(*div), GFP_KERNEL);
+	if (!div) {
+		kfree(mux);
+		return ERR_PTR(-ENOMEM);
+	}
+	div_hw = &div->hw;
+	div->reg = reg;
+	div->shift = PCG_PREDIV_SHIFT;
+	div->width = PCG_PREDIV_WIDTH;
+	div->lock = &imx_ccm_lock;
+	div->flags = CLK_DIVIDER_ROUND_CLOSEST;
+
+	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
+	if (!gate) {
+		kfree(mux);
+		kfree(div);
+		return ERR_PTR(-ENOMEM);
+	}
+	gate_hw = &gate->hw;
+	gate->reg = reg;
+	gate->bit_idx = PCG_CGC_SHIFT;
+
+	flags |= CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE;
+
+	clk = clk_register_composite(NULL, name, parent_names, num_parents,
+					mux_hw, &clk_mux_ops, div_hw,
+					&imx_clk_composite_divider_ops, gate_hw,
+					&clk_gate_ops, flags);
+	if (IS_ERR(clk)) {
+		kfree(mux);
+		kfree(div);
+		kfree(gate);
+	}
+
+	return clk;
+}
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 12b3fd6..9dbb680 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -232,4 +232,13 @@ struct clk *imx_clk_cpu(const char *name, const char *parent_name,
 		struct clk *div, struct clk *mux, struct clk *pll,
 		struct clk *step);
 
+struct clk *imx_clk_composite_flags(const char *name, const char **parent_names,
+		int num_parents, void __iomem *reg, unsigned long flags);
+
+#define imx_clk_composite(name, parent_names, reg) \
+	imx_clk_composite_flags(name, parent_names, ARRAY_SIZE(parent_names), reg, 0)
+
+#define imx_clk_composite_critical(name, parent_names, reg) \
+	imx_clk_composite_flags(name, parent_names, ARRAY_SIZE(parent_names), reg, CLK_IS_CRITICAL)
+
 #endif
-- 
2.7.4

