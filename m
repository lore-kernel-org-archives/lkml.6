Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DED6C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 08:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D41821479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 08:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ni1cn6iR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D41821479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbeJIPxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 11:53:25 -0400
Received: from mail-eopbgr00087.outbound.protection.outlook.com ([40.107.0.87]:11264
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725855AbeJIPxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 11:53:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iy6HLD6Jjj0k5P3MoS1GMKROGnx40JAI9Yb2UTqcGb8=;
 b=Ni1cn6iRAh/EKzQyL70xtxUFe4qA1nDtheeEiTWooNhYru5NOMRRkeqVN6CHtFmajDhvlrR8bWUFKPjGIvxRpVXAovCgsfYx7NRFZjfdSVUpvmE3hX/AIyCybXMT2OHx488Q1um342s18NS5xABSm6pHximx2bAX1/mt5qIE3vQ=
Received: from VI1PR04MB1613.eurprd04.prod.outlook.com (10.164.84.147) by
 VI1PR04MB5343.eurprd04.prod.outlook.com (52.134.123.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.26; Tue, 9 Oct 2018 08:37:27 +0000
Received: from VI1PR04MB1613.eurprd04.prod.outlook.com
 ([fe80::f014:635a:bee7:76b3]) by VI1PR04MB1613.eurprd04.prod.outlook.com
 ([fe80::f014:635a:bee7:76b3%3]) with mapi id 15.20.1207.024; Tue, 9 Oct 2018
 08:37:27 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        "A.s. Dong" <aisheng.dong@nxp.com>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
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
Subject: [PATCH v10 2/5] clk: imx: add fractional PLL output clock
Thread-Topic: [PATCH v10 2/5] clk: imx: add fractional PLL output clock
Thread-Index: AQHUX6tPNLKeJgrqOUOKDpMq9zy3Cg==
Date:   Tue, 9 Oct 2018 08:37:27 +0000
Message-ID: <1539074230-27277-3-git-send-email-abel.vesa@nxp.com>
References: <1539074230-27277-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1539074230-27277-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR02CA0058.eurprd02.prod.outlook.com
 (2603:10a6:802:14::29) To VI1PR04MB1613.eurprd04.prod.outlook.com
 (2a01:111:e400:596b::19)
x-originating-ip: [95.76.156.53]
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5343;6:x+LZnIU7ZiPbxBW1H+veZ3DsZTps6iOcrh4hu/ZDZKW3O7Eo5OJB9IXMK0l0Kd2g0e5xxtA8gWRB6XkxyJo10Jb/Fy6cNdF3qwSPoQOfVUm2PeR8MuNjg3KcjUABQkBgF4GuIiWA1wrS3cclPQzkeOSZX4dfaAs4mUAKfsljKz/i+pbSE/rfTv4TdnuG5MaPxtYyYW17tKZj87RAkgFnmIzJau6vtU/RJVSBNKUB3gcjYRE2HdbTkIK07Si2+sf8hC8xvupVodf/6FCrZC0rh8YuKplk6HU7+v4N5mJXfcUuC9JHrSBBMOuSbldkeY5dw9aXNqISF0Q5SrUBU2sgwzJahDSJB5LCKg6JEpN34MR5L9ZBuj6CmEY8xc5xV6V25Cl7O4aQehBS7bGOCtvs7vecAJacZQyU6MtQaam7/TACI/757j60whWr+bShy0C4G2gx3CICNnD44cUQufeuuA==;5:cS2JiNmC6bNfKxSm0AkdNktZDLWHIOLnTfP+/vbIHDuiPJ8it4uaThUP8e2sK4i/2seLqfJiVDTyPu3ndft2EupZq9N7L2roX8g7H6p8kw4VfNcVlpH2S6QWZ8WozYk+lj/1mzFSlX6TzpvLz0/ZUhsfL67AnNemOiakDVsBLmg=;7:A7oiCWOgHlI/qbomKN422nK/812vrn+ZLlwW/tEqL/642XXqiquA8O7UNlaj4IjY2GtV7wD4BgnVxVXsgzneM1WiKExetp6WuQm44sMSFYlt4/hFPMZgrZYYrCNiTzSDz06nXIMfOUAP2ZVJFC2/3qzUO13o7o5Xw+1JVrh25bSpvumlAGPPblNGmPKFnNKv9NN2K17QOc6N8CkPYJTrBkRwrB77jG41P/W3RF8nSnfnqzkQ+PZuZUO7sYU1YV1A
x-ms-office365-filtering-correlation-id: 0cdc2e8f-3e7c-4abf-88a7-08d62dc2717d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5343;
x-ms-traffictypediagnostic: VI1PR04MB5343:
x-microsoft-antispam-prvs: <VI1PR04MB5343DC13FACF83CD4F91FAE3F6E70@VI1PR04MB5343.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991055);SRVR:VI1PR04MB5343;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB5343;
x-forefront-prvs: 08200063E9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(346002)(366004)(376002)(199004)(189003)(476003)(486006)(44832011)(6512007)(446003)(6636002)(36756003)(5660300001)(2906002)(5250100002)(68736007)(2616005)(11346002)(6116002)(3846002)(106356001)(7736002)(305945005)(105586002)(81166006)(81156014)(8676002)(71190400001)(52116002)(110136005)(71200400001)(25786009)(14454004)(478600001)(256004)(86362001)(6486002)(575784001)(2900100001)(14444005)(4326008)(186003)(6436002)(54906003)(6506007)(8936002)(386003)(66066001)(7416002)(102836004)(6346003)(53936002)(97736004)(99286004)(76176011)(316002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5343;H:VI1PR04MB1613.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-microsoft-antispam-message-info: T8SvRm2Luy6K4nAOkU7WpZgwd7ctciYPftly4doZm+6OeLMwCFjd+A1Fl6oPANsXkhaEG/U/uXfn741LY7Yhbf4ka7QWFZBfnYC5+kY6Lt85wcyvgF2DKz7B9gfGI8caKC8M7Yr2W3l7isppTtQbO4O605bN3Nciiz9q/ghdwJ6kOfT0FbOgFudIBpq9l/b+/w9ddFWeQaLsmLy7w5SkTbsuVE4b78CMNJeZGPKQZIyH1b/2UApuWA2T+D1bLydGCSjWhQnKiL5FbZSvAgxvPvlIhDlivQ2AWZRsmZeop0V0hF/I65/VS5MDbqzy7TTDUiNOyF+Qhu86bv917Er6FahYSYW25Q6yN35MkKjR1T0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cdc2e8f-3e7c-4abf-88a7-08d62dc2717d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2018 08:37:27.4680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5343
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

This is a new clock type introduced on i.MX8.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/clk/imx/Makefile       |   1 +
 drivers/clk/imx/clk-frac-pll.c | 215 +++++++++++++++++++++++++++++++++++++=
++++
 drivers/clk/imx/clk.h          |   3 +
 3 files changed, 219 insertions(+)
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
index 0000000..030df76
--- /dev/null
+++ b/drivers/clk/imx/clk-frac-pll.c
@@ -0,0 +1,215 @@
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
+#include <linux/bitfield.h>
+
+#include "clk.h"
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
+	u64 temp64;
+
+	val =3D readl_relaxed(pll->base + PLL_CFG0);
+	divq =3D ((val & PLL_OUTPUT_DIV_MASK) + 1) * 2;
+	val =3D readl_relaxed(pll->base + PLL_CFG1);
+	divff =3D FIELD_GET(PLL_FRAC_DIV_MASK, val);
+	divfi =3D (val & PLL_INT_DIV_MASK);
+
+	temp64 =3D (u64)parent_rate * 8;
+	temp64 *=3D divff;
+	do_div(temp64, PLL_FRAC_DENOM);
+	temp64 /=3D divq;
+
+	return parent_rate * 8 * (divfi + 1) / divq + (unsigned long)temp64;
+}
+
+static long clk_pll_round_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long *prate)
+{
+	unsigned long parent_rate =3D *prate;
+	u32 divff, divfi;
+	u64 temp64;
+
+	parent_rate *=3D 8;
+	rate *=3D 2;
+	divfi =3D rate / parent_rate;
+	temp64 =3D (u64)(rate - divfi * parent_rate);
+	temp64 *=3D PLL_FRAC_DENOM;
+	do_div(temp64, parent_rate);
+	divff =3D temp64;
+
+	temp64 =3D (u64)parent_rate;
+	temp64 *=3D divff;
+	do_div(temp64, PLL_FRAC_DENOM);
+
+	return (parent_rate * divfi + (unsigned long)temp64) / 2;
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
+	u64 temp64;
+	int ret;
+
+	parent_rate *=3D 8;
+	rate *=3D 2;
+	divfi =3D rate / parent_rate;
+	temp64 =3D (u64) (rate - divfi * parent_rate);
+	temp64 *=3D PLL_FRAC_DENOM;
+	do_div(temp64, parent_rate);
+	divff =3D temp64;
+
+	val =3D readl_relaxed(pll->base + PLL_CFG1);
+	val &=3D ~(PLL_FRAC_DIV_MASK | PLL_INT_DIV_MASK);
+	val |=3D ((divff << 7) | (divfi - 1));
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
+	struct clk *clk;
+
+	pll =3D kzalloc(sizeof(*pll), GFP_KERNEL);
+	if (!pll)
+		return ERR_PTR(-ENOMEM);
+
+	pll->base =3D base;
+	init.name =3D name;
+	init.ops =3D &clk_frac_pll_ops;
+	init.flags =3D 0;
+	init.parent_names =3D &parent_name;
+	init.num_parents =3D 1;
+
+	pll->hw.init =3D &init;
+
+	clk =3D clk_register(NULL, &pll->hw);
+	if (IS_ERR(clk))
+		kfree(pll);
+
+	return clk;
+}
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 8076ec0..13daf1c 100644
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

