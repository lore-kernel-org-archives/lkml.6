Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74CBC0044C
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98C4B223C8
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LIZT52PL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98C4B223C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731038AbeKNCSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 21:18:53 -0500
Received: from mail-eopbgr60045.outbound.protection.outlook.com ([40.107.6.45]:37052
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726948AbeKNCSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 21:18:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HN1e2uUskDJo8htlV/Mi03KUGF4FUOr9gZ5dqDDZ3mY=;
 b=LIZT52PLV9t0J5iI0hfvI3fjjRYWfrlUyD9oi9QkNG4sj2zso6Eu7WlA8l50ON14C3mFCJKj+OB4aiovD3iWzojnQ14LrPLTqhYqsobXCNT3RfHVpB7iH9wZDcJaR/ass/e1N8WBJ4BCSxZXAFD8a3jl/HiA9X8ZKSKOsVI3lLY=
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com (52.133.28.145) by
 AM6PR0402MB3750.eurprd04.prod.outlook.com (52.133.29.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Tue, 13 Nov 2018 16:19:58 +0000
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::5195:5e4c:be83:408b]) by AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::5195:5e4c:be83:408b%4]) with mapi id 15.20.1294.045; Tue, 13 Nov 2018
 16:19:58 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        "A.s. Dong" <aisheng.dong@nxp.com>, Stephen Boyd <sboyd@kernel.org>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v13 2/5] clk: imx: add fractional PLL output clock
Thread-Topic: [PATCH v13 2/5] clk: imx: add fractional PLL output clock
Thread-Index: AQHUe2y4GlCwaf3TJEa+AcKG+BBmig==
Date:   Tue, 13 Nov 2018 16:19:58 +0000
Message-ID: <1542125975-8448-3-git-send-email-abel.vesa@nxp.com>
References: <1542125975-8448-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1542125975-8448-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR0202CA0065.eurprd02.prod.outlook.com
 (2603:10a6:20b:3a::42) To AM6PR0402MB3654.eurprd04.prod.outlook.com
 (2603:10a6:209:19::17)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3750;6:PvWEgI1Ka+arSjv1KbinoKbsYs9CDXHvDgFGXzE63ja/uuCRKWUk4BdRNA6+oYrrVbhpSRYZV/LmSe3k/L+Qj0ev2cVB+NOqFG+xuDOnFrPoaRcFY4VdhQo0T9GLj3FggSbP4Ic1vA8QQ1Yx+TBUbwAQydsiR1f2G3xTyjvxHlbco73JVwGDuZlhmr98s76ayYfWAocNCu36j3FND5a/dkS1qjyiwtxTErnV26m6X39ko4+Z+QnTkV8GrsjlUUPolAkS7R+9Cj4XJFcjVS+j+k/hlfhjXPvnCHuV/yqeW76HGX+h9iSiAuyQ74IpPTa4A6hNnIahFTz8e8z5Lgt0Piya9E1odWp+Lqb4/BhaHH79gVXvMLIFo8fPJfKlQzxRtiY2mk1OcjcnlPKQ1m5qKRi3yHhar/lvus452W/yixucq0blnI7PmRC6YPa5f5pNAw3WSiOQuwMI5/BODv3xGw==;5:ez1u4M5bRCsWCRjsqelhoxOZ1gbe8squDBHNwZWUtpktlCxQXC9jeQ5HrxKfmFfP7y6aC+VyzcphMR+1UWVjbM0pWU20WUFmAmOzf8ZLBDd5qwrXnnJU2ArgSIHcKxDt3O3Jm2XH7yIqhITQl8TZ1V3DnLo0GscVtUTyR6tEIVo=;7:xXgN879PkE/gACpOZTRBCpFT9f+ReopUtyRHBofEZ+oJrkUnciY31YgVf5OUxMP7yy4/YJepwkeGOecJzZ2L5U32TUMo2fplTwQ6yAq9Sal3oNVKGAZh09UWW17RUMgQ9iqMCuQWiWgMShFnJx09cQ==
x-ms-office365-filtering-correlation-id: 20f9c8e1-a887-4941-2a32-08d64983dabd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390060)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3750;
x-ms-traffictypediagnostic: AM6PR0402MB3750:
x-microsoft-antispam-prvs: <AM6PR0402MB37501269309E57AED99383D6F6C20@AM6PR0402MB3750.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(264314650089876)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231406)(944501410)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM6PR0402MB3750;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3750;
x-forefront-prvs: 085551F5A8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(346002)(396003)(136003)(199004)(189003)(966005)(105586002)(2906002)(44832011)(7416002)(386003)(6116002)(106356001)(26005)(3846002)(76176011)(446003)(5660300001)(11346002)(316002)(4326008)(478600001)(68736007)(14454004)(186003)(7736002)(110136005)(54906003)(305945005)(52116002)(2616005)(476003)(102836004)(6506007)(486006)(14444005)(71190400001)(71200400001)(53936002)(86362001)(2900100001)(6486002)(575784001)(99286004)(25786009)(6306002)(6436002)(6512007)(8936002)(256004)(97736004)(81166006)(36756003)(66066001)(81156014)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3750;H:AM6PR0402MB3654.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ZZJcFQ8Oy9NMZH058u6NKmbicOQOpGYvZYoAWGYsUzUqkkU/LW4BTCi1uqZ64DCggLrRkvW0VEHK5KVnFXy5rxhnuzQZ++bYIjaVAp7Itf72TwUb4RPyPUfFTdYKPFlBO5rQA5IKUmz4GoNUOOCve7WIfo9vrzzmJeupZydMrGmBEby+vgfkCf6tpFw3IIh7g0PepEfFYelIqzWShfXCkZl0HfZrrOvc1g7fAkXx9su8+FET06uU3/5QD+c6V5nGaSLkY7KcupLmk/ClrT+fnbyUTa9ulMhVMYJfxxv+OLzaYtL5HceNfl1iK8hWNRNPEWY5ywf6Q/naqoL2dT0AZR8oIIfYlm/8bwDfQ5U1UPA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20f9c8e1-a887-4941-2a32-08d64983dabd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2018 16:19:58.0868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3750
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

This is a new fractional clock type introduced on i.MX8.

The description of this fractional clock can be found here:

https://www.nxp.com/docs/en/reference-manual/IMX8MDQLQRM.pdf#page=3D834

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/clk/imx/Makefile       |   1 +
 drivers/clk/imx/clk-frac-pll.c | 221 +++++++++++++++++++++++++++++++++++++=
++++
 drivers/clk/imx/clk.h          |   3 +
 3 files changed, 225 insertions(+)
 create mode 100644 drivers/clk/imx/clk-frac-pll.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 8c3baa7..4893c1f 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -6,6 +6,7 @@ obj-y +=3D \
 	clk-cpu.o \
 	clk-fixup-div.o \
 	clk-fixup-mux.o \
+	clk-frac-pll.o \
 	clk-gate-exclusive.o \
 	clk-gate2.o \
 	clk-pllv1.o \
diff --git a/drivers/clk/imx/clk-frac-pll.c b/drivers/clk/imx/clk-frac-pll.=
c
new file mode 100644
index 0000000..a3732be
--- /dev/null
+++ b/drivers/clk/imx/clk-frac-pll.c
@@ -0,0 +1,221 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2018 NXP.
+ *
+ * This driver supports the fractional plls found in the imx8m SOCs
+ *
+ * Documentation for this fractional pll can be found at:
+ *   https://www.nxp.com/docs/en/reference-manual/IMX8MDQLQRM.pdf#page=3D8=
34
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/iopoll.h>
+#include <linux/slab.h>
+#include <linux/bitfield.h>
+
+#define PLL_CFG0		0x0
+#define PLL_CFG1		0x4
+
+#define PLL_LOCK_STATUS		BIT(31)
+#define PLL_PD_MASK		BIT(19)
+#define PLL_BYPASS_MASK		BIT(14)
+#define PLL_NEWDIV_VAL		BIT(12)
+#define PLL_NEWDIV_ACK		BIT(11)
+#define PLL_FRAC_DIV_MASK	GENMASK(30, 7)
+#define PLL_INT_DIV_MASK	GENMASK(6, 0)
+#define PLL_OUTPUT_DIV_MASK	GENMASK(4, 0)
+#define PLL_FRAC_DENOM		0x1000000
+
+#define PLL_FRAC_LOCK_TIMEOUT	10000
+#define PLL_FRAC_ACK_TIMEOUT	500000
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
+	u32 val;
+
+	return readl_poll_timeout(pll->base, val, val & PLL_LOCK_STATUS, 0,
+					PLL_FRAC_LOCK_TIMEOUT);
+}
+
+static int clk_wait_ack(struct clk_frac_pll *pll)
+{
+	u32 val;
+
+	/* return directly if the pll is in powerdown or in bypass */
+	if (readl_relaxed(pll->base) & (PLL_PD_MASK | PLL_BYPASS_MASK))
+		return 0;
+
+	/* Wait for the pll's divfi and divff to be reloaded */
+	return readl_poll_timeout(pll->base, val, val & PLL_NEWDIV_ACK, 0,
+					PLL_FRAC_ACK_TIMEOUT);
+}
+
+static int clk_pll_prepare(struct clk_hw *hw)
+{
+	struct clk_frac_pll *pll =3D to_clk_frac_pll(hw);
+	u32 val;
+
+	val =3D readl_relaxed(pll->base + PLL_CFG0);
+	val &=3D ~PLL_PD_MASK;
+	writel_relaxed(val, pll->base + PLL_CFG0);
+
+	return clk_wait_lock(pll);
+}
+
+static void clk_pll_unprepare(struct clk_hw *hw)
+{
+	struct clk_frac_pll *pll =3D to_clk_frac_pll(hw);
+	u32 val;
+
+	val =3D readl_relaxed(pll->base + PLL_CFG0);
+	val |=3D PLL_PD_MASK;
+	writel_relaxed(val, pll->base + PLL_CFG0);
+}
+
+static int clk_pll_is_prepared(struct clk_hw *hw)
+{
+	struct clk_frac_pll *pll =3D to_clk_frac_pll(hw);
+	u32 val;
+
+	val =3D readl_relaxed(pll->base + PLL_CFG0);
+	return (val & PLL_PD_MASK) ? 0 : 1;
+}
+
+static unsigned long clk_pll_recalc_rate(struct clk_hw *hw,
+					 unsigned long parent_rate)
+{
+	struct clk_frac_pll *pll =3D to_clk_frac_pll(hw);
+	u32 val, divff, divfi, divq;
+	u64 temp64 =3D parent_rate;
+
+	val =3D readl_relaxed(pll->base + PLL_CFG0);
+	divq =3D ((val & PLL_OUTPUT_DIV_MASK) + 1) * 2;
+	val =3D readl_relaxed(pll->base + PLL_CFG1);
+	divff =3D FIELD_GET(PLL_FRAC_DIV_MASK, val);
+	divfi =3D val & PLL_INT_DIV_MASK;
+
+	temp64 *=3D 8;
+	temp64 *=3D divff;
+	do_div(temp64, PLL_FRAC_DENOM);
+	do_div(temp64, divq);
+
+	return parent_rate * 8 * (divfi + 1) / divq + (unsigned long)temp64;
+}
+
+static long clk_pll_round_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long *prate)
+{
+	u64 parent_rate =3D *prate;
+	u32 divff, divfi;
+	u64 temp64;
+
+	parent_rate *=3D 8;
+	rate *=3D 2;
+	divfi =3D rate / parent_rate;
+	temp64 =3D rate - divfi * parent_rate;
+	temp64 *=3D PLL_FRAC_DENOM;
+	do_div(temp64, parent_rate);
+	divff =3D temp64;
+
+	temp64 =3D parent_rate;
+	temp64 *=3D divff;
+	do_div(temp64, PLL_FRAC_DENOM);
+
+	return (parent_rate * divfi + temp64) / 2;
+}
+
+/*
+ * To simplify the clock calculation, we can keep the 'PLL_OUTPUT_VAL' at =
zero
+ * (means the PLL output will be divided by 2). So the PLL output can use
+ * the below formula:
+ * pllout =3D parent_rate * 8 / 2 * DIVF_VAL;
+ * where DIVF_VAL =3D 1 + DIVFI + DIVFF / 2^24.
+ */
+static int clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
+			    unsigned long parent_rate)
+{
+	struct clk_frac_pll *pll =3D to_clk_frac_pll(hw);
+	u32 val, divfi, divff;
+	u64 temp64 =3D parent_rate;
+	int ret;
+
+	parent_rate *=3D 8;
+	rate *=3D 2;
+	divfi =3D rate / parent_rate;
+	temp64 *=3D rate - divfi;
+	temp64 *=3D PLL_FRAC_DENOM;
+	do_div(temp64, parent_rate);
+	divff =3D temp64;
+
+	val =3D readl_relaxed(pll->base + PLL_CFG1);
+	val &=3D ~(PLL_FRAC_DIV_MASK | PLL_INT_DIV_MASK);
+	val |=3D (divff << 7) | (divfi - 1);
+	writel_relaxed(val, pll->base + PLL_CFG1);
+
+	val =3D readl_relaxed(pll->base + PLL_CFG0);
+	val &=3D ~0x1f;
+	writel_relaxed(val, pll->base + PLL_CFG0);
+
+	/* Set the NEV_DIV_VAL to reload the DIVFI and DIVFF */
+	val =3D readl_relaxed(pll->base + PLL_CFG0);
+	val |=3D PLL_NEWDIV_VAL;
+	writel_relaxed(val, pll->base + PLL_CFG0);
+
+	ret =3D clk_wait_ack(pll);
+
+	/* clear the NEV_DIV_VAL */
+	val =3D readl_relaxed(pll->base + PLL_CFG0);
+	val &=3D ~PLL_NEWDIV_VAL;
+	writel_relaxed(val, pll->base + PLL_CFG0);
+
+	return ret;
+}
+
+static const struct clk_ops clk_frac_pll_ops =3D {
+	.prepare	=3D clk_pll_prepare,
+	.unprepare	=3D clk_pll_unprepare,
+	.is_prepared	=3D clk_pll_is_prepared,
+	.recalc_rate	=3D clk_pll_recalc_rate,
+	.round_rate	=3D clk_pll_round_rate,
+	.set_rate	=3D clk_pll_set_rate,
+};
+
+struct clk *imx_clk_frac_pll(const char *name, const char *parent_name,
+			     void __iomem *base)
+{
+	struct clk_init_data init;
+	struct clk_frac_pll *pll;
+	struct clk_hw *hw;
+	int ret;
+
+	pll =3D kzalloc(sizeof(*pll), GFP_KERNEL);
+	if (!pll)
+		return ERR_PTR(-ENOMEM);
+
+	init.name =3D name;
+	init.ops =3D &clk_frac_pll_ops;
+	init.flags =3D 0;
+	init.parent_names =3D &parent_name;
+	init.num_parents =3D 1;
+
+	pll->base =3D base;
+	pll->hw.init =3D &init;
+
+	hw =3D &pll->hw;
+
+	ret =3D clk_hw_register(NULL, hw);
+	if (ret) {
+		kfree(pll);
+		return ERR_CAST(hw);
+	}
+
+	return hw->clk;
+}
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 5895e223..44a1f14 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -27,6 +27,9 @@ struct clk *imx_clk_pllv1(enum imx_pllv1_type type, const=
 char *name,
 struct clk *imx_clk_pllv2(const char *name, const char *parent,
 		void __iomem *base);
=20
+struct clk *imx_clk_frac_pll(const char *name, const char *parent_name,
+			     void __iomem *base);
+
 enum imx_pllv3_type {
 	IMX_PLLV3_GENERIC,
 	IMX_PLLV3_SYS,
--=20
2.7.4

