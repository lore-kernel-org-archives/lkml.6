Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1CEC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 09:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A32B72081B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 09:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Yh+yFbwv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A32B72081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbeK2UeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 15:34:10 -0500
Received: from mail-eopbgr60050.outbound.protection.outlook.com ([40.107.6.50]:2224
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726683AbeK2UeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 15:34:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+abvOdcKaisVbElv1YkVGpLnBJwgNVpsNVW7KVpzZg=;
 b=Yh+yFbwvZu2h2Pfqvb8nIH/W2llb+09BX5OjZ+Rn5+zVPhj/IBzwVbGcmyonC/jPj40wFVtl9wW7IVG7YwrvITGkOm8HKZymIQsCLdGnVCHJlDBtHDwuTxEj1cOaT3Cw7fxIrstp4zXwC+uuOWd+BpgE62WqK6AhzT9UN8Byezc=
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com (52.133.28.145) by
 AM6PR0402MB3560.eurprd04.prod.outlook.com (52.133.19.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Thu, 29 Nov 2018 09:29:01 +0000
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::c46b:915c:7a03:123d]) by AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::c46b:915c:7a03:123d%3]) with mapi id 15.20.1339.032; Thu, 29 Nov 2018
 09:29:01 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Aisheng DONG <aisheng.dong@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>
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
Subject: [PATCH v14 2/5] clk: imx: Add fractional PLL output clock
Thread-Topic: [PATCH v14 2/5] clk: imx: Add fractional PLL output clock
Thread-Index: AQHUh8XmCNIGBwWsh0+TkrBbYHgw/w==
Date:   Thu, 29 Nov 2018 09:28:34 +0000
Message-ID: <1543483640-4585-3-git-send-email-abel.vesa@nxp.com>
References: <1543483640-4585-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1543483640-4585-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR06CA0032.eurprd06.prod.outlook.com
 (2603:10a6:20b:14::45) To AM6PR0402MB3654.eurprd04.prod.outlook.com
 (2603:10a6:209:19::17)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3560;6:4w+qM3M4SEh3yYbKZvM1yt/HFNXI+bgSpfRlH2wA3rXXnslznFRBmSnlSdV7QrhdxksvlOdSYxXwdlQ05CO2GOd3RppJ+mkb7N+Wd1WYFg1JRwsGvP4WSB6An3Epqi/Pfe1KClfzXuLG85vgfP7BEVuWF9gRQGpulPEwYoM7IYSW/8MzxiaSffUOQzOW8Uzl2+fIpgT9KQRwV/JtoA1QkcZzpBduhOXvS3XroIAM7gsOJiYQLFCwKuF3RTSXxJmGbIwoEFRuMPZqOJTzlLXaqyQbUXAVyE9afWosngg0vSTPZIqeHFxKXpfxO3UZNdp3Js5z5vntQrHbevcap6dEZrytPvzHPNOPXRLXQJkjakin/acNob8VNUQztn+7iI6Z4wx/TXJi31lQpPUOgpQiKqUUnQKFtspTdSenlpLYTYhSWN3iYhNmlU8/BMnQP3OheEwSHFk+gufyiKHWlcliAg==;5:PkqIWVORn5PkUL4nUBQbEnnA827C1Q8kOKAvTCM4xG+330NjIEJEGAky4XsJcAEmfs10DY26bnoYPOz+bZ34m2rVYsT/aAhJPEcIwAj1JgLtbL5oww9zjyatxWj5F/dAxtTMXWTuKCZNMEDjnJy9l7t4Z5Wb8Ur6FOh4gV+eqL0=;7:XxetkdacgjOGiY081BQ/Ec/LnuH/ZIt5GSRpJo7kMz5vB+vC3SC6BSRmKp2gG2kORutkRuHZKLsASnPaImf8FFMDmskSKZRHc2HFkE4/F7vXedo+EKB4kXAHQeQPA+7IH+2bN7aB33hQXkB6qNzd2Q==
x-ms-office365-filtering-correlation-id: bf7d853c-bf0d-4b48-f2b3-08d655dd08bf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3560;
x-ms-traffictypediagnostic: AM6PR0402MB3560:
x-microsoft-antispam-prvs: <AM6PR0402MB3560DF2B0D768FB959C05391F6D20@AM6PR0402MB3560.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231453)(999002)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM6PR0402MB3560;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3560;
x-forefront-prvs: 0871917CDA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(39860400002)(376002)(346002)(199004)(189003)(4326008)(105586002)(6486002)(26005)(478600001)(966005)(97736004)(106356001)(3846002)(14454004)(44832011)(2906002)(2616005)(5660300001)(71200400001)(7416002)(446003)(71190400001)(316002)(11346002)(66066001)(486006)(6506007)(81156014)(305945005)(7736002)(6436002)(25786009)(36756003)(81166006)(14444005)(6116002)(8936002)(110136005)(256004)(8676002)(476003)(6666004)(102836004)(54906003)(6512007)(6306002)(76176011)(68736007)(99286004)(52116002)(575784001)(186003)(386003)(86362001)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3560;H:AM6PR0402MB3654.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: mTF4gkOdv1vbZQOaWLWh/cyTEXY2qq2gmR28mcdVEUlin8dO6cIOpynradJoboCvwE9na3NuqRh6W4P2l/EIqxlwWse+ShXLKaXY4kpXNMK1vPz2Xaaj+GxqrGZzl/OxFOvmTFJ7ZCF5KMtQd78QJ1iOxsa0qKKsJ6llHtvbiONQAJNMestpG6LBv2etcmIXptDpENE+QGa6BksGcacri3kMBpZBwf7/yZ5uC7dato6OQl74h/RITFO5PVn8EmbYnDIoJWQPUp0MNzdgjJcIiJ5lLrzfkHNbRTcCLDfSi2/GD6LoF8G6m7ZZ3VAOykzb252LEac8jFDHGCAHLFyZN4JpUvFVnAp4kcTuX7RAjfc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf7d853c-bf0d-4b48-f2b3-08d655dd08bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2018 09:28:34.5090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3560
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
 drivers/clk/imx/clk-frac-pll.c | 223 +++++++++++++++++++++++++++++++++++++=
++++
 drivers/clk/imx/clk.h          |   3 +
 3 files changed, 227 insertions(+)
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
index 0000000..9872620
--- /dev/null
+++ b/drivers/clk/imx/clk-frac-pll.c
@@ -0,0 +1,223 @@
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
+		return ERR_PTR(ret);
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

