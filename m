Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CAF3C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42831223C8
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="m+/Jh3DD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42831223C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731157AbeKNCTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 21:19:00 -0500
Received: from mail-eopbgr60045.outbound.protection.outlook.com ([40.107.6.45]:37052
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726612AbeKNCS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 21:18:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZmnwFUaqJLDVMS/hTwjucTd905DYQlzJUDIq/3+b8U=;
 b=m+/Jh3DD5giUTFe8zRGxlxVRrQsM8Ousim3rchIlm0BIAwEdGcxc9BQvfGaog+EttQj6UIDS9rDtHcI0WVFF52+D//IZ1WwdOUKMBJ4IB+3U1adPj9Ox/dilU0GSlO8ucnxHAlzoAf1Lxsab0ewtqzcruUl1XjHwF1s7yrLJypo=
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com (52.133.28.145) by
 AM6PR0402MB3750.eurprd04.prod.outlook.com (52.133.29.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Tue, 13 Nov 2018 16:19:59 +0000
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::5195:5e4c:be83:408b]) by AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::5195:5e4c:be83:408b%4]) with mapi id 15.20.1294.045; Tue, 13 Nov 2018
 16:19:59 +0000
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
Subject: [PATCH v13 3/5] clk: imx: Add SCCG PLL type
Thread-Topic: [PATCH v13 3/5] clk: imx: Add SCCG PLL type
Thread-Index: AQHUe2y4WLp/zWkV8k2TBFyLrWllqg==
Date:   Tue, 13 Nov 2018 16:19:59 +0000
Message-ID: <1542125975-8448-4-git-send-email-abel.vesa@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3750;6:uRSpVSY3W15J37Fqn0L8DaWvsVfKaXesNUM9uOgyFrn3RpzCxtISyNLi/25ZTzZfhnUf6sqSavv7BDG/xSnZmT+SLguzjlAit5DGBqQh6X2/qdUbcBmxjTyQfm5AnTtCjVr8S3MrhCfS5YU+74mP0rDi0eOEUROgH2QM4kde2zWXKgivZtyhIx4ckGM40SjIQ0Tv/aHQ7CkPwPdn9n3iQjaC31u66CIrjH4qHjQJb/LldODITOOUOYanwEhu6tZxn9UcXqJXDxb83TRSy32TZsdfn4uKtZWOIPje3HwicAZRPHlUwtaGEdp6AX7+5ix83K62smgHHlTxCa0Dyd/wndnFp0d8xAR1AsCmZKMRl2pL/WjzJkQYFolIkJIWZpuyExffqHjIYY63MHEX7VvwEs5T5ixiUAhTHnN1/DSQFCZT/tlFWwH8mI3FAyLQuHuspg6RnDC1FoVw90e1BoguQg==;5:7qwmCZW8Yr+HaAE61Joycw5H5h9XlsGMOtLmWlgdfAcEGH0eCysJjDb1raFCZFG37RMEQj0PW1gVuI5aHrDPNUjty/9En9unVP9HI6xAIZg8Ti+JFkwSuJzIcurcLWx8divWUifn1+VOMXWzi0VdMdXOOUGd4dZKrAsh6DrFrJM=;7:i18uq1lV9uRMnxL4QGXPlaAxHdf6pXzvOXrYDrNIa4pQ/sDJMTxEzx2/4tZBdYSkrDTcoCmKH77D92+OYu/xhYUbEBTB0qJAo+hy+5N07RneHDR51d6bFOTpoNCAsYYF2m/XS9oB3eg1fAtJFEH/Jg==
x-ms-office365-filtering-correlation-id: 19acad5c-f1e8-4c73-a6ee-08d64983db52
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390060)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3750;
x-ms-traffictypediagnostic: AM6PR0402MB3750:
x-microsoft-antispam-prvs: <AM6PR0402MB3750B23500B2B312E6B58962F6C20@AM6PR0402MB3750.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(264314650089876)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231406)(944501410)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM6PR0402MB3750;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3750;
x-forefront-prvs: 085551F5A8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(346002)(396003)(136003)(199004)(189003)(966005)(105586002)(2906002)(44832011)(7416002)(386003)(6116002)(106356001)(26005)(3846002)(76176011)(446003)(5660300001)(11346002)(316002)(4326008)(478600001)(68736007)(14454004)(186003)(7736002)(110136005)(54906003)(305945005)(52116002)(2616005)(476003)(102836004)(6506007)(486006)(14444005)(71190400001)(71200400001)(53936002)(86362001)(2900100001)(6486002)(99286004)(25786009)(6306002)(6436002)(6512007)(8936002)(256004)(97736004)(81166006)(217873002)(36756003)(66066001)(81156014)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3750;H:AM6PR0402MB3654.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: AQ12c3jvzZz5TbtMSSWe79UaT2VTcrj3ns7r6NPcu5z9AeawqvDLVLpIBgLxNaq2La/k+Pi+W0UMn4YGld6dzFyVBjvftwgk8uHajsIq0079/JkMoWbFZ5AOhpsl9l02MrDK1aGR6CUAjRpiUyIj7LaL8N1cHfYRFfb5rQOyRyixDYNImFoU8tCxhDgMaL7SpW0uxm0N8fR+fXLVlGUYEDpOI770Xe3iW5YfOvBi3WOT6dZHBgWb/iu9VzeN48VIqx6ziHFGsMnnQ333/mlBPlfm4oWdvkUkMZ7AdXX4YhM13FADteZGzMS6PHKGMDHAKW1EUiW77Dyw4jp+JxdPSgkpT+O4WYmZ5kvx3uyHEGE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19acad5c-f1e8-4c73-a6ee-08d64983db52
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2018 16:19:59.1356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3750
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

The SCCG is a new PLL type introduced on i.MX8.

The description of this SCCG clock can be found here:

https://www.nxp.com/docs/en/reference-manual/IMX8MDQLQRM.pdf#page=3D834

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/clk/imx/Makefile       |   3 +-
 drivers/clk/imx/clk-sccg-pll.c | 256 +++++++++++++++++++++++++++++++++++++=
++++
 drivers/clk/imx/clk.h          |   9 ++
 3 files changed, 267 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/imx/clk-sccg-pll.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 4893c1f..b87513c 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -12,7 +12,8 @@ obj-y +=3D \
 	clk-pllv1.o \
 	clk-pllv2.o \
 	clk-pllv3.o \
-	clk-pfd.o
+	clk-pfd.o \
+	clk-sccg-pll.o
=20
 obj-$(CONFIG_SOC_IMX1)   +=3D clk-imx1.o
 obj-$(CONFIG_SOC_IMX21)  +=3D clk-imx21.o
diff --git a/drivers/clk/imx/clk-sccg-pll.c b/drivers/clk/imx/clk-sccg-pll.=
c
new file mode 100644
index 0000000..4666b96
--- /dev/null
+++ b/drivers/clk/imx/clk-sccg-pll.c
@@ -0,0 +1,256 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2018 NXP.
+ *
+ * This driver supports the SCCG plls found in the imx8m SOCs
+ *
+ * Documentation for this SCCG pll can be found at:
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
+	struct clk_sccg_pll *pll =3D to_clk_sccg_pll(hw);
+	u32 val;
+
+	val =3D readl_relaxed(pll->base + PLL_CFG0);
+	return (val & PLL_PD_MASK) ? 0 : 1;
+}
+
+static unsigned long clk_pll1_recalc_rate(struct clk_hw *hw,
+					 unsigned long parent_rate)
+{
+	struct clk_sccg_pll *pll =3D to_clk_sccg_pll(hw);
+	u32 val, divf;
+
+	val =3D readl_relaxed(pll->base + PLL_CFG2);
+	divf =3D FIELD_GET(PLL_DIVF1_MASK, val);
+
+	return parent_rate * 2 * (divf + 1);
+}
+
+static long clk_pll1_round_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long *prate)
+{
+	unsigned long parent_rate =3D *prate;
+	u32 div;
+
+	if (!parent_rate)
+		return 0;
+
+	div =3D rate / (parent_rate * 2);
+
+	return parent_rate * div * 2;
+}
+
+static int clk_pll1_set_rate(struct clk_hw *hw, unsigned long rate,
+			    unsigned long parent_rate)
+{
+	struct clk_sccg_pll *pll =3D to_clk_sccg_pll(hw);
+	u32 val;
+	u32 divf;
+
+	if (!parent_rate)
+		return -EINVAL;
+
+	divf =3D rate / (parent_rate * 2);
+
+	val =3D readl_relaxed(pll->base + PLL_CFG2);
+	val &=3D ~PLL_DIVF1_MASK;
+	val |=3D FIELD_PREP(PLL_DIVF1_MASK, divf - 1);
+	writel_relaxed(val, pll->base + PLL_CFG2);
+
+	return clk_pll_wait_lock(pll);
+}
+
+static int clk_pll1_prepare(struct clk_hw *hw)
+{
+	struct clk_sccg_pll *pll =3D to_clk_sccg_pll(hw);
+	u32 val;
+
+	val =3D readl_relaxed(pll->base + PLL_CFG0);
+	val &=3D ~PLL_PD_MASK;
+	writel_relaxed(val, pll->base + PLL_CFG0);
+
+	return clk_pll_wait_lock(pll);
+}
+
+static void clk_pll1_unprepare(struct clk_hw *hw)
+{
+	struct clk_sccg_pll *pll =3D to_clk_sccg_pll(hw);
+	u32 val;
+
+	val =3D readl_relaxed(pll->base + PLL_CFG0);
+	val |=3D PLL_PD_MASK;
+	writel_relaxed(val, pll->base + PLL_CFG0);
+
+}
+
+static unsigned long clk_pll2_recalc_rate(struct clk_hw *hw,
+					 unsigned long parent_rate)
+{
+	struct clk_sccg_pll *pll =3D to_clk_sccg_pll(hw);
+	u32 val, ref, divr1, divf1, divr2, divf2;
+	u64 temp64;
+
+	val =3D readl_relaxed(pll->base + PLL_CFG0);
+	switch (FIELD_GET(PLL_REF_MASK, val)) {
+	case 0:
+		ref =3D OSC_25M;
+		break;
+	case 1:
+		ref =3D OSC_27M;
+		break;
+	default:
+		ref =3D OSC_25M;
+		break;
+	}
+
+	val =3D readl_relaxed(pll->base + PLL_CFG2);
+	divr1 =3D FIELD_GET(PLL_DIVR1_MASK, val);
+	divr2 =3D FIELD_GET(PLL_DIVR2_MASK, val);
+	divf1 =3D FIELD_GET(PLL_DIVF1_MASK, val);
+	divf2 =3D FIELD_GET(PLL_DIVF2_MASK, val);
+
+	temp64 =3D ref * 2;
+	temp64 *=3D (divf1 + 1) * (divf2 + 1);
+
+	do_div(temp64, (divr1 + 1) * (divr2 + 1));
+
+	return temp64;
+}
+
+static long clk_pll2_round_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long *prate)
+{
+	u32 div;
+	unsigned long parent_rate =3D *prate;
+
+	if (!parent_rate)
+		return 0;
+
+	div =3D rate / parent_rate;
+
+	return parent_rate * div;
+}
+
+static int clk_pll2_set_rate(struct clk_hw *hw, unsigned long rate,
+			    unsigned long parent_rate)
+{
+	u32 val;
+	u32 divf;
+	struct clk_sccg_pll *pll =3D to_clk_sccg_pll(hw);
+
+	if (!parent_rate)
+		return -EINVAL;
+
+	divf =3D rate / parent_rate;
+
+	val =3D readl_relaxed(pll->base + PLL_CFG2);
+	val &=3D ~PLL_DIVF2_MASK;
+	val |=3D FIELD_PREP(PLL_DIVF2_MASK, divf - 1);
+	writel_relaxed(val, pll->base + PLL_CFG2);
+
+	return clk_pll_wait_lock(pll);
+}
+
+static const struct clk_ops clk_sccg_pll1_ops =3D {
+	.is_prepared	=3D clk_pll1_is_prepared,
+	.recalc_rate	=3D clk_pll1_recalc_rate,
+	.round_rate	=3D clk_pll1_round_rate,
+	.set_rate	=3D clk_pll1_set_rate,
+};
+
+static const struct clk_ops clk_sccg_pll2_ops =3D {
+	.prepare	=3D clk_pll1_prepare,
+	.unprepare	=3D clk_pll1_unprepare,
+	.recalc_rate	=3D clk_pll2_recalc_rate,
+	.round_rate	=3D clk_pll2_round_rate,
+	.set_rate	=3D clk_pll2_set_rate,
+};
+
+struct clk *imx_clk_sccg_pll(const char *name,
+				const char *parent_name,
+				void __iomem *base,
+				enum imx_sccg_pll_type pll_type)
+{
+	struct clk_sccg_pll *pll;
+	struct clk_init_data init;
+	struct clk_hw *hw;
+	int ret;
+
+	switch (pll_type) {
+	case SCCG_PLL1:
+		init.ops =3D &clk_sccg_pll1_ops;
+		break;
+	case SCCG_PLL2:
+		init.ops =3D &clk_sccg_pll2_ops;
+		break;
+	default:
+		return ERR_PTR(-EINVAL);
+	}
+
+	pll =3D kzalloc(sizeof(*pll), GFP_KERNEL);
+	if (!pll)
+		return ERR_PTR(-ENOMEM);
+
+	init.name =3D name;
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
index 44a1f14..864cd8a 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -21,6 +21,11 @@ enum imx_pllv1_type {
 	IMX_PLLV1_IMX35,
 };
=20
+enum imx_sccg_pll_type {
+	SCCG_PLL1,
+	SCCG_PLL2,
+};
+
 struct clk *imx_clk_pllv1(enum imx_pllv1_type type, const char *name,
 		const char *parent, void __iomem *base);
=20
@@ -30,6 +35,10 @@ struct clk *imx_clk_pllv2(const char *name, const char *=
parent,
 struct clk *imx_clk_frac_pll(const char *name, const char *parent_name,
 			     void __iomem *base);
=20
+struct clk *imx_clk_sccg_pll(const char *name, const char *parent_name,
+			     void __iomem *base,
+			     enum imx_sccg_pll_type pll_type);
+
 enum imx_pllv3_type {
 	IMX_PLLV3_GENERIC,
 	IMX_PLLV3_SYS,
--=20
2.7.4

