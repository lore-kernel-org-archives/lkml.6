Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CFEC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ECED214FE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="p2PXXEuR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ECED214FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbeJJPIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 11:08:18 -0400
Received: from mail-he1eur01on0049.outbound.protection.outlook.com ([104.47.0.49]:18219
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726022AbeJJPIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 11:08:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kAGQnp63D5EMPuDcwG69yjc5CyTfrjoN4Egtmbk03Y=;
 b=p2PXXEuRzqIsGB7wvC7wfFy83RHkLDuZeLHbTlnRXfJYGRFyfp1JmrlFFlU3ImNP2dTJ8c9/8nzWGO3fK1Tagb/zlJQQWwYMB2n19+Np+bhMiE48ggXcR577vBM0tZRelB7lIRZ/bqzWP1w6z5DG4zuNrBeS+xazEmKKo+yfPhE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
Received: from fsr-ub1664-175.ro-buh02.nxp.com (95.76.156.53) by
 AM4PR04MB1601.eurprd04.prod.outlook.com (2a01:111:e400:59e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1207.27; Wed, 10 Oct
 2018 07:47:03 +0000
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
Subject: [PATCH v11 4/5] clk: imx: add imx composite clock
Date:   Wed, 10 Oct 2018 10:45:19 +0300
Message-Id: <1539157520-25081-5-git-send-email-abel.vesa@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 07e1fd93-921e-4e70-1083-08d62e84925b
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM4PR04MB1601;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB1601;3:k9xGQso6ZMLeLXtb8I4fBC+WWP3XJTORfiteMeeN7OTqJHv4yZJ5AgINwBtRLbBcunsKff1dp6vzTDdbtDP6WaJtaynSG12g+no7LpSOmyavUV54N07EWHLnL8jQFEplMQVpzGagkJsgXyMkHPNexQK+/c1U7FpZbg2oBlv/N2Rzq2nr5zshy8Elqse8Wr6w8ROhEsEWE4jnUDAHuT0etkHAmpDZpeQ3D+5oFSnGX5BlLVhqIXjHM1EM/vM0rFfj;25:039TuCk+nUnA6ViMvSFT92ijbHuyphEGT7k+LLHhyJfLBIDK8CLetcqgv6khPjLNDEuMInQkbdl3zFrkwjHNsf8QN+a4j3ZK7VMC/Hf+iZMlJMD79WTK6Fjl7M2i+Zd14vhjYVoPRNC+Mk2PfxGQfPdNhCdjmeioR17llM8NzcjmW7G93T8mmZAVdwB2JerMeoBETd3rDwjMupu7rC5yEg00JTJzc3BMflflLQUcHgP0Hgl09mOKd4wxTrIPXdTtRPdBbjTK0e5aOkq1fEtl2Yp5XQImIkMuc4T2a0P8o8uk2ye5hcEQju6CatjmLfAlU5mE66c30RfSrcySLmJFjQ==;31:j8W04qPODLpQf4/mpnnYCmt6PHHmz8BDcoc6yk6aQ/4VXT5XIY+k3p0/E23dXmKI4ZL3vpiphScFmT2TnkeI+NYgphCyNj3PzEFTQXTmnl09+wMWkre3Jdih/mjD4Ix/PwQIPU9nsJytF0FJTmzmsGDbEO2SzFdHO/vR5fZd8adRMoq4M7tVz0TV4ug37dPY3wHkRr2Rfd3Rb9ou1j45YVTbrPyOoSGdMog+L5orxo0=
X-MS-TrafficTypeDiagnostic: AM4PR04MB1601:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB1601;20:yhhtesUNNEp/OaQY9+Pe2M9Qce0Ef0rLp/Um3oR3s4hAQImrSdBaasaa8/sp8k70+TzEqGDY9ihYQEIyEfBfGPKHtVOl0DNw3NqdsCTfzFvQjnMos/HKV3zmPThckrwsYjilorTsTiNKQ1VfzqgD7/xLoYbG6w5KKndfKTU2MdwupSjN7FqM3aOU69OHMt2i9oNXapQ31KP8+CYaf6/hqY0meRTznlr2d/Iffsl/L0MeCWeCNvDOtQGDqC/xnZmoOvY8DBjKU65anvaoTw9jH+cCWMkQmqBG+z3REHU6KQK20+eWjbCI7vu3aHCZrjFxKgIfA7/pI+4ULdDa7SbyiQDh9vf/hv1NtMi7folB9uuGsfYqR69Hj8lTSkkp14lZ5TbIdWlkiIbXZOrXmFPPecX+uNXsvSG8LW4566Ej8Q5Q9pKE7avtEVWOcpcGTVQToD2jWTrOnN+IFa0LNN5/F1JgOUNnTu5PodqUqR6jU7IoJUdWYoM0ZKlKZ5iPtohC;4:OH2/ZVbk1inQcNKQzHVC0yKKDLsfcZHV8/69XmHkjycSXC3mmUkHh+PuTMp2o+YEwnL50bMOp/nyRwnM43g3mY7AwPOKgfOLU5dTmD9h0Y/3brquubb1k+lRWSWLqFUCb3jOs7dy0pp8FfLAPPnyM/1eG8o3dXo4hrwsG0OD6PXXyQIvDNLueFoAoXhE34TmhexZDikInAqN48KzIKmGTPYI8MpT28UA9vFfLVCSwmvxTyLuxdVpLTxC7ZA5fSfPOtbVsc2vAJWFQ/dSC3U6butvOJWslt73bLgI1CPqFZGkVcbZZUGDA9+fjoUiST6Y
X-Microsoft-Antispam-PRVS: <AM4PR04MB16010BDB98502248F7A02E7EF6E00@AM4PR04MB1601.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:AM4PR04MB1601;BCL:0;PCL:0;RULEID:;SRVR:AM4PR04MB1601;
X-Forefront-PRVS: 08213D42D3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(346002)(396003)(376002)(189003)(199004)(7696005)(51416003)(52116002)(48376002)(4326008)(6486002)(76176011)(105586002)(50466002)(25786009)(16586007)(478600001)(11346002)(86362001)(186003)(386003)(486006)(16526019)(44832011)(97736004)(26005)(14444005)(106356001)(446003)(68736007)(2616005)(2906002)(956004)(476003)(47776003)(7416002)(50226002)(66066001)(7736002)(53936002)(81166006)(81156014)(8676002)(110136005)(36756003)(54906003)(316002)(6636002)(6666003)(3846002)(305945005)(8936002)(5660300001)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR04MB1601;H:fsr-ub1664-175.ro-buh02.nxp.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR04MB1601;23:8n9Pl4lc7zTaNfNpDFGrjffVQ0/TpK3aKSHEVF9pS?=
 =?us-ascii?Q?CsIeXU7pzNwc83cj8o8nf5gxx3KNH3QKILU6G6badqGgZ4wOdAC8IiyYvBQr?=
 =?us-ascii?Q?oo1WAnwDoiccZyTK+p3pEL5pIitfYQB3+GnrFxSvCE7XoYi7N0Iq5ZM1jimS?=
 =?us-ascii?Q?wStflBOHDjn+vKP+NKwDWzR072WIN7BopxvWY91zd6vpYpt3jyYo1kZQrslw?=
 =?us-ascii?Q?rtzzjlqJFFp/b80wHpopqzBAqTyroDhYe9sxPrQR8qlJplqxu4kl9TxOaeWS?=
 =?us-ascii?Q?Y3Bl8ge9Iomj9hYM/bUNecaBVhBXmRLlTLg1TSNCbuvrcal3qoXGpwW1XlpF?=
 =?us-ascii?Q?9YlTVryo33bp2lNLc8HEPzYmZ5KuoO6QtLHW7rHZ91dJ5rzNSoi7nX0Ds/41?=
 =?us-ascii?Q?7OBeq1GVKbRgPawDWyzzcP+X3HpPiqFPwqFW5Fu4P+tmGrpJ4y8rvewSt/Qi?=
 =?us-ascii?Q?w9p9nPbs/WH8feLndZbViyeyPE9vUpZDih8b+QB/2FFiNaZ0JkcquPsxVYVd?=
 =?us-ascii?Q?wPhwE1hVk2hoKJk6NqhUMnz+yIAquzjePn2GO7spFfAqQuAFiUpkoaNP0zup?=
 =?us-ascii?Q?kRjoRFIh+N21M39W/uw3EIt1c2/XZjs4OCoOZ3T91Kup4mTDwcsYPENYV71o?=
 =?us-ascii?Q?pmQhMjYCpf3wYrScopjJZRVJGxlNM1CPZ1E1qTteYAWCAJy+IV9UX5ioJpGr?=
 =?us-ascii?Q?WIzybWwoY+sfUT4aW+y9i+EBHg9S54iC/9qGbiP4yhUScK+C4OVvLt2kz6cC?=
 =?us-ascii?Q?RCuU5wlDLeauHrsjphSRwAYbMNgcl+TIATES1ElEm1pWUYsSyZqlpWIjog5j?=
 =?us-ascii?Q?r9gDE/0jqUX1497v4DCV/WoI6Dc196rs71QDCgkqo0ZxFnzPq/fz5xAt2zYg?=
 =?us-ascii?Q?cPBZr5zTXi+nWZ3Kp6fMjRpSjBpmICMliAH8xxocFQ+UZR3QO7CD1S1OjAWV?=
 =?us-ascii?Q?a4aP2t6FCcjV5P1oEY/TyZG94odn0COAMPNXvuf+yBXjmiQS/NRwFeVWhJli?=
 =?us-ascii?Q?Hh9rxcNlNYRc0ayFnj2C/WxcYyzw4M3T3D+zkw1g+9jNS8IoRSiCIOlFU8bF?=
 =?us-ascii?Q?Hh3rB9nUWZIssy+bwASTCzldn2kAPipxBSIdHsmlQ4Qo+1ZoAnngVeIK3xo8?=
 =?us-ascii?Q?AWoIf3IYterN7+ETaz7SmeEad/HNVDYI+qcvUo9U9po5ZuJdBCiu9I0fs3Es?=
 =?us-ascii?Q?va/JSd+6ZmZ9abr5WQdvf23Mjx7s0If5IaxcTISlUkRpO+6slgBM3fj/vDeN?=
 =?us-ascii?Q?k7YputE18jlI7Ve9wc=3D?=
X-Microsoft-Antispam-Message-Info: pZzPA5IQzLj8Y0vyTnAHFXZPCHahunZ2eRgbkgaEWVemaSfMKXNGQ5gcExjvbr6bCaA/L3drkxn+yOUPqWNaLnXnby/yZMUSYSUNKp8631sCd0d7zFipiN6hcJGa1lqWk9xnJXB5gZ1YzHnJkUINZLCFiQ1u7bmkpvGJZfXT3gRAK4KLcQRudnKiFmIfWfSa+mB1KYj7CCWs/QWVVPcjzDKbEvsdNXrz5QpNU6KU7o0cf62zv2Lwoy6qRc0i/PQ7Mcerc56yqLBQWpYUuYgrRD5oELLA4PgcRFP5+NUcbHH4+eS1KsQaUPP/heO6n7U2S3/DoDpT9CF/orfu5rZ1osFwHadi9znvDqxmetsjwoc=
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB1601;6:OXbcTWe6Hz/wBZ6sbQltTaxRcrToB4/BxWwGUriMFwVa/69dOxncsSdRColwrRsHPEDSxXaQzs7wsJJRuSCrqBMTbZ1ymNmehKoVzZ0tA9PqeDozbE3x7XAV6PVEO6ASOu7jBoFwWsIL6KdBhKWHyy4dsyz4P8wp2gqsDo/TJFBrmfMx1+R33C74HQOsJve226+d/uTrXYWPF4bFhB/lpfw6SskRMSbhErBkbc20f2K7PDWSJI165ncsybIAwEdFV2qI8NIi6RtsItsLC5bYEDelB2i9gm7jD18+KnbmQpC9phl+uGaDPFJYgPDrE4JoYBkYh4o5rZOCFFt300dFBeBEiwOjJvS29CnWnStMt3/WXZ35QWoRafLmqgKjMtIKFcYBBN4JnWl05vpkw1klQJJKooJSsDzx4PQwsMnZhiFuzsdu0OmWemPnKbRteR2lOUTn3yXIhA4Sa6kOroOY0g==;5:Mur1SOHcAYkLla5AEETrUUjzmgoejvfAT0Nbyk82jSG9PB2MpzqrgB7HYNpfyXcjcoEOlyyL/9UBi0LRB8TnfeDvW8Gx91pmMm804splTJfGtGZar4+07VPv296MGPV+3YiI1ZY98eHtenc0X762WzT/hBEL+LQ/H5WlNEIfmR0=;7:L+03A9XjRR5NuOdD7U3UtmAe4MrUTFqT3ykvprW2YejEd0J/2sSEo4/2xo61zSv7MwZWY6Gu/kc8hr4WA/KzvsuLe6BN8/aTNBlR/OGw3GcOXQzGYUcG85uByDA6pUJ164FiV/Jxn2E3uC8doupJx7Tlc1ijYM73FQ7fM0A3aVllEGD4JSAN9hX2Z+zqZbYmjvPG30XiIbbOdu+DEn0pKuJctYtvI9DISqagAwELip0vHcuPKwDyBciwNWCHHZZk
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2018 07:47:03.4457
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e1fd93-921e-4e70-1083-08d62e84925b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR04MB1601
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since a lot of clocks on imx8m are formed by a mux, gate, predivider and
divider, the idea here is to combine all of those into one composite clock,
but we need to deal with both predivider and divider at the same time and
therefore we add the imx8m_clk_composite_divider_ops and register
the composite clock with those.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Suggested-by: Sascha Hauer <s.hauer@pengutronix.de>
Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/clk/imx/Makefile           |   1 +
 drivers/clk/imx/clk-composite-8m.c | 181 +++++++++++++++++++++++++++++++++++++
 drivers/clk/imx/clk.h              |  16 ++++
 3 files changed, 198 insertions(+)
 create mode 100644 drivers/clk/imx/clk-composite-8m.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index b87513c..237444b 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -3,6 +3,7 @@
 obj-y += \
 	clk.o \
 	clk-busy.o \
+	clk-composite-8m.o \
 	clk-cpu.o \
 	clk-fixup-div.o \
 	clk-fixup-mux.o \
diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-composite-8m.c
new file mode 100644
index 0000000..e214812
--- /dev/null
+++ b/drivers/clk/imx/clk-composite-8m.c
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
+static unsigned long imx8m_clk_composite_divider_recalc_rate(struct clk_hw *hw,
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
+static int imx8m_clk_composite_compute_dividers(unsigned long rate,
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
+static long imx8m_clk_composite_divider_round_rate(struct clk_hw *hw,
+						unsigned long rate,
+						unsigned long *prate)
+{
+	int prediv_value;
+	int div_value;
+
+	imx8m_clk_composite_compute_dividers(rate, *prate,
+						&prediv_value, &div_value);
+
+	rate = DIV_ROUND_UP(*prate, prediv_value);
+	rate = DIV_ROUND_UP(rate, div_value);
+
+	return rate;
+}
+
+static int imx8m_clk_composite_divider_set_rate(struct clk_hw *hw,
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
+	ret = imx8m_clk_composite_compute_dividers(rate, parent_rate,
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
+static const struct clk_ops imx8m_clk_composite_divider_ops = {
+	.recalc_rate = imx8m_clk_composite_divider_recalc_rate,
+	.round_rate = imx8m_clk_composite_divider_round_rate,
+	.set_rate = imx8m_clk_composite_divider_set_rate,
+};
+
+struct clk *imx8m_clk_composite_flags(const char *name,
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
+					&imx8m_clk_composite_divider_ops,
+					gate_hw, &clk_gate_ops, flags);
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
index 12b3fd6..282fe74 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -232,4 +232,20 @@ struct clk *imx_clk_cpu(const char *name, const char *parent_name,
 		struct clk *div, struct clk *mux, struct clk *pll,
 		struct clk *step);
 
+struct clk *imx8m_clk_composite_flags(const char *name,
+					const char **parent_names,
+					int num_parents, void __iomem *reg,
+					unsigned long flags);
+
+#define __imx8m_clk_composite(name, parent_names, reg, flags) \
+	imx8m_clk_composite_flags(name, parent_names, \
+		ARRAY_SIZE(parent_names), reg, \
+		flags | CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE)
+
+#define imx8m_clk_composite(name, parent_names, reg) \
+	__imx8m_clk_composite(name, parent_names, reg, 0)
+
+#define imx8m_clk_composite_critical(name, parent_names, reg) \
+	__imx8m_clk_composite(name, parent_names, reg, CLK_IS_CRITICAL)
+
 #endif
-- 
2.7.4

