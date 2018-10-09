Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD76C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 08:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8A21214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 08:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TmHaUGqf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8A21214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbeJIPx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 11:53:28 -0400
Received: from mail-eopbgr00087.outbound.protection.outlook.com ([40.107.0.87]:11264
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725861AbeJIPx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 11:53:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ya/fdEE8TRNaTNBm4CSTHVnR6V62rTvDH8GZFOGaFCo=;
 b=TmHaUGqfKzDxoI6N/0T+aTvwitZb5cHlgTwvHG+3rUGIKCfSvZ8MwTb4C/RASFSVs6eeZBA/pcLjtiCo948buDFWtWuZHQXJ4MaX5AETaVa+LNsVak5lIiHO06TRz5RjnF9qGWFAw9LKGNJpxJs7FzC/rj2pFhr3+pltLWm0w0M=
Received: from VI1PR04MB1613.eurprd04.prod.outlook.com (10.164.84.147) by
 VI1PR04MB5343.eurprd04.prod.outlook.com (52.134.123.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.26; Tue, 9 Oct 2018 08:37:29 +0000
Received: from VI1PR04MB1613.eurprd04.prod.outlook.com
 ([fe80::f014:635a:bee7:76b3]) by VI1PR04MB1613.eurprd04.prod.outlook.com
 ([fe80::f014:635a:bee7:76b3%3]) with mapi id 15.20.1207.024; Tue, 9 Oct 2018
 08:37:29 +0000
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
Subject: [PATCH v10 3/5] clk: imx: add SCCG PLL type
Thread-Topic: [PATCH v10 3/5] clk: imx: add SCCG PLL type
Thread-Index: AQHUX6tQ/Bo5W6SYIEqYUDYNmW32Fg==
Date:   Tue, 9 Oct 2018 08:37:28 +0000
Message-ID: <1539074230-27277-4-git-send-email-abel.vesa@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5343;6:LmgiYtYP1BS3tCjtN3e7T1j0ktNsTULwBM0m+XE7VEhPsgDb2fsXfRtfKd0ODPThFp/kYCynh8Ab5qzkJUxpD7KT1zipUT4D4FldRr1+JrFuXajXhIXiWaApa7OuIKFWcWbIdHMIJMOLEdSTlaPDbywdAkkjYl0qGuB7+3KJGLtTMcC0PPCbEQ/6wIGHHxR5UYAU2Wgu4yILko3aoqKl5pO4q3RiTEFVXa0PgQk6GWgOUiukpPNPN7CWm7y45nZabNZM9CnE4DYoSXX5Kz/sP0DMrXSKypHmEV12VmihxPxKUlALoQi/b+DsL7/l1zXPXn4I2SbdaPhuVzWbmcxJlWZn7nqmPrexTM0g/t1e0oX/aY32ZCAAMD81d2cD/P+qgdnc4pbW44lK6/U6CKO3DE4eLbblRqKNtvyX1KqjfF037edb0kqF1tncCYAI3ohCgpq86EinSILuOS1kSZOxJg==;5:xNAZQznKFpYKCLexqe63WmwGzhRLZTnb3UorLNdMehuO9dsdhxeIT00IW8HLhFZRHUSrk+7Fg/NsIx5FWEHihd8n1d8oAqodvseE8iH1J3jRNHqRJM3X1ONWgkNv05kIoaM8pc+YIIIQW4jnHomM9ws+ar3qjl/cgosQ6bTDc4A=;7:mh9FcIXVieSvZhvSyR2USEkLtM3U7iGZcyYc86qhYMLRHNlhwLjXnydn/D4oq5lQZHvFDS6l47RkOYGFf3kIGk5ZbCbopaon8zawpG+SOLF328hrbgXJm5BgCwTjHAYPMTwEr0FQrR3VR4y+DUVop/fr0GXbSVkgMQhr0NVoleXsXHSTfsREoQ0mQSC8b7Be0ex+wp06y9NXfouJKqqvfzBUnXCha5FwJNcgcOo5fhgzWX+YKxK3KloqYT/b/Bwd
x-ms-office365-filtering-correlation-id: 3aeecd6f-439f-48a2-0a9c-08d62dc27260
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5343;
x-ms-traffictypediagnostic: VI1PR04MB5343:
x-microsoft-antispam-prvs: <VI1PR04MB53432F82167AD4EF9ACA010AF6E70@VI1PR04MB5343.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991055);SRVR:VI1PR04MB5343;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB5343;
x-forefront-prvs: 08200063E9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(346002)(366004)(376002)(199004)(189003)(476003)(486006)(44832011)(6512007)(446003)(6636002)(36756003)(5660300001)(2906002)(5250100002)(68736007)(2616005)(11346002)(6116002)(3846002)(106356001)(7736002)(217873002)(305945005)(105586002)(81166006)(81156014)(8676002)(71190400001)(52116002)(110136005)(71200400001)(25786009)(14454004)(478600001)(256004)(86362001)(6486002)(2900100001)(14444005)(4326008)(186003)(6436002)(54906003)(6506007)(8936002)(386003)(66066001)(7416002)(102836004)(6346003)(53936002)(97736004)(99286004)(76176011)(316002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5343;H:VI1PR04MB1613.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-microsoft-antispam-message-info: 2geuTDrZ0XLpgKtQCb/zdpKeJ9MRgp161BsHCwnuBc86ZHDnt6fpKDxdDcLxuadwmPgvVV1YtgVmxHMheOqNPoIfaZMo7+nQi9xqLG/ub0RinRTa96z27O9M7iql1ohYylQ/LHq/BvynTREyT3drTDV9J6hJEU8HwoaPBH019pzl+PfMBG5MkfqlmSjgDBN03jgmxU5qXMZcPPX03J/SLVBwlTgYWFLhCLZfeyBXfheNGSHj5fNXrJjobUTgHsYrpNSASvbyhw+9PjeAtheShdtJYXGlKxQ6rksWjEGOAGzO5jO3ADRi+KZhQVYBdN8J4GupD5m47Os0OvpkoIk11Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aeecd6f-439f-48a2-0a9c-08d62dc27260
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2018 08:37:28.9993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5343
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

The SCCG is a new PLL type introduced on i.MX8. Add support for this.
The driver currently misses the PLL lock check, as the preliminary
documentation mentions lock configurations, but is quiet about where
to find the actual lock status signal.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/clk/imx/Makefile       |   3 +-
 drivers/clk/imx/clk-sccg-pll.c | 237 +++++++++++++++++++++++++++++++++++++=
++++
 drivers/clk/imx/clk.h          |   9 ++
 3 files changed, 248 insertions(+), 1 deletion(-)
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
index 0000000..a9837fa
--- /dev/null
+++ b/drivers/clk/imx/clk-sccg-pll.c
@@ -0,0 +1,237 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2018 NXP.
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
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
+	return (unsigned long)temp64;
+}
+
+static long clk_pll2_round_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long *prate)
+{
+	u32 div;
+	unsigned long parent_rate =3D *prate;
+
+	div =3D rate / (parent_rate);
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
+	divf =3D rate / (parent_rate);
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
+	struct clk *clk;
+	struct clk_init_data init;
+
+	pll =3D kzalloc(sizeof(*pll), GFP_KERNEL);
+	if (!pll)
+		return ERR_PTR(-ENOMEM);
+
+	pll->base =3D base;
+	init.name =3D name;
+	switch (pll_type) {
+	case SCCG_PLL1:
+		init.ops =3D &clk_sccg_pll1_ops;
+		break;
+	case SCCG_PLL2:
+		init.ops =3D &clk_sccg_pll2_ops;
+		break;
+	default:
+		kfree(pll);
+		return ERR_PTR(-EINVAL);
+	}
+
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
index 13daf1c..12b3fd6 100644
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

