Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EDEC65BAE
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 10:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC6CE20868
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 10:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NARM6Q94"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC6CE20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbeLAWFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 17:05:03 -0500
Received: from mail-eopbgr30068.outbound.protection.outlook.com ([40.107.3.68]:30848
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726416AbeLAWFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 17:05:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZgzOe7kBz4UVK7FMBeKY05ANyrk/XsY6zsxOzXMGMw=;
 b=NARM6Q94/8r3Mi0VHumRCLnSUgc9oXv3p887xBisJHUwJMTCdamWQwbPhUAYcEMdqoF7fG6d1QpEOzI412QRuRgs9XPL2oZZ+JwZrnLqLGpqZtEOzgh9xugGk6CfMymkXYK3EuZ5ebbua2DOf8Qq/PORIen1JB2VusAIiSTyvTQ=
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com (52.133.28.145) by
 AM6PR0402MB3622.eurprd04.prod.outlook.com (52.133.20.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.20; Sat, 1 Dec 2018 10:52:11 +0000
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::c46b:915c:7a03:123d]) by AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::c46b:915c:7a03:123d%3]) with mapi id 15.20.1339.036; Sat, 1 Dec 2018
 10:52:11 +0000
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v15 2/5] clk: imx: Add fractional PLL output clock
Thread-Topic: [PATCH v15 2/5] clk: imx: Add fractional PLL output clock
Thread-Index: AQHUiWPp5Giqzab550C+sU1thANSlA==
Date:   Sat, 1 Dec 2018 10:52:11 +0000
Message-ID: <1543661502-18573-3-git-send-email-abel.vesa@nxp.com>
References: <1543661502-18573-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1543661502-18573-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR0402CA0017.eurprd04.prod.outlook.com
 (2603:10a6:209::30) To AM6PR0402MB3654.eurprd04.prod.outlook.com
 (2603:10a6:209:19::17)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3622;6:7qwVhexFefZd5ONJAVNe0STvaeUnNDPp2IALQKQkRlE+lo2Lf0X66njcg21GB9qL3mLoTSaOHDpOlVSAwdmKgJRvhZkp9+EL7txNXu9+2MN4GBYTHHB6Rv0/wNh5EWjp7R0m2hLEZwB6BaTTHnCgaO413J25wE6CQ64mGWfSmlumy8qWTWWuR0uVak3QaGSe0MDE6xUdpGWs7Xf/TYrGtLlJ3ZnYTNNhFcZ/imyrMXg29Tt+aTc2d7xyAf3YSgz0jk7x9kQgtzyEmJb9Q2Z7jbovy6YHvPYYJJAmvdiyzHVbMz8s/VrTi25sTpoTgwtvMD05BA/Wl+CnNWdR7PY6wAR+54Cvv6Mx2hcQXRszRIQ2Ty3qkjvRTYLu7i5O8NULGknEjeMm6aaJGUoqb1hWasZNOdVmPWlauLuQPgptRF+EhIvvdntqDUGNcqi/WKQndrSd5a/AKINpet3239CpHw==;5:08+1f6w5mOSO2JCVB7dg8Xdvzgt/Fa6bFAPs2W+d+DxA4utnxN2/V5p1+LElyO7KOsYi5Q8xlegKFpooTMOkdE6o7AAqEszhikXJdlRXyR0BtZXZyKpKySC9ygdpsHQ6Lx8xvpdnGsWpq68f53gOE0jTEqKmYs3xtmDqYxu8CuU=;7:ONPm7YznlEdJyXC/XQ8GHaLIicdOxtQ4eLWETE1ZKQE17Ee447b0AbSTQVVXnwsVA4RhHfzXfxjVP834m2i5VkLaxy09luE9yOdrhwnL9nan+QoG47+fid+dQXDGluzBjYPNmS5erbdSDc3PET7v7A==
x-ms-office365-filtering-correlation-id: 653aeb96-571e-41df-5acb-08d6577b0c23
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3622;
x-ms-traffictypediagnostic: AM6PR0402MB3622:
x-microsoft-antispam-prvs: <AM6PR0402MB3622BF8F8CE2363965D65422F6AC0@AM6PR0402MB3622.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231454)(999002)(944501410)(52105112)(93006095)(93001095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM6PR0402MB3622;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3622;
x-forefront-prvs: 087396016C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(396003)(346002)(376002)(189003)(199004)(305945005)(76176011)(53936002)(316002)(52116002)(99286004)(54906003)(3846002)(6116002)(575784001)(86362001)(6512007)(106356001)(6306002)(110136005)(966005)(81156014)(81166006)(8676002)(2906002)(14454004)(476003)(11346002)(2616005)(446003)(105586002)(256004)(8936002)(478600001)(66066001)(71200400001)(44832011)(486006)(97736004)(6486002)(6436002)(14444005)(26005)(186003)(102836004)(7416002)(5660300001)(71190400001)(4326008)(36756003)(68736007)(7736002)(386003)(6506007)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3622;H:AM6PR0402MB3654.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: U5sm1TP6a5Olm8BuoTnd0E5xFTfAMlzwry40duSu7pcCrzGbeqVUMjosR/L4v5JHV2AtpToxUyU7T8GYxomjka0Up3YP2+xTo37k3f7ZgVj8t8xo2WYoKxc+t3JJrebRXGLJ997Mtsieba2UnvHqT8VB0NW9UEup1dYRbWlkt783bQJ0kEHFH1Jg20cXBbtdvyZaAv6UX9Z5YWU+iJjl/CKpTdUfP022j+z/vBfZoVpoqg+KufRu/7zmdKD3I4zkgnEgaskUoZCwF/VgwLNjM+r6B4gw6O/20cvVP6qw5xlXJWy0EGpnG/gOjUm6BSDXrLs8DATPJZRTxi9hT4ZxqyKnX7IMKdgqobvLKnXXqWk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 653aeb96-571e-41df-5acb-08d6577b0c23
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2018 10:52:11.9178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3622
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
 drivers/clk/imx/clk-frac-pll.c | 232 +++++++++++++++++++++++++++++++++++++=
++++
 drivers/clk/imx/clk.h          |   3 +
 3 files changed, 236 insertions(+)
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
index 0000000..0026c39
--- /dev/null
+++ b/drivers/clk/imx/clk-frac-pll.c
@@ -0,0 +1,232 @@
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
+	u64 rate;
+
+	val =3D readl_relaxed(pll->base + PLL_CFG0);
+	divq =3D (FIELD_GET(PLL_OUTPUT_DIV_MASK, val) + 1) * 2;
+	val =3D readl_relaxed(pll->base + PLL_CFG1);
+	divff =3D FIELD_GET(PLL_FRAC_DIV_MASK, val);
+	divfi =3D FIELD_GET(PLL_INT_DIV_MASK, val);
+
+	temp64 *=3D 8;
+	temp64 *=3D divff;
+	do_div(temp64, PLL_FRAC_DENOM);
+	do_div(temp64, divq);
+
+	rate =3D parent_rate * 8 * (divfi + 1);
+	do_div(rate, divq);
+	rate +=3D temp64;
+
+	return rate;
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
+	temp64 =3D rate;
+	do_div(temp64, parent_rate);
+	divfi =3D temp64;
+	temp64 =3D rate - divfi * parent_rate;
+	temp64 *=3D PLL_FRAC_DENOM;
+	do_div(temp64, parent_rate);
+	divff =3D temp64;
+
+	temp64 =3D parent_rate;
+	temp64 *=3D divff;
+	do_div(temp64, PLL_FRAC_DENOM);
+
+	rate =3D parent_rate * divfi + temp64;
+
+	return rate / 2;
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

