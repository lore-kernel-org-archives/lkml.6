Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1210FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 09:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B18DC2081B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 09:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sVYmOeoo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B18DC2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbeK2Uea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 15:34:30 -0500
Received: from mail-eopbgr60050.outbound.protection.outlook.com ([40.107.6.50]:2224
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727347AbeK2Ue3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 15:34:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1HTIs0HIkQmyS5azJTEGlvOkh6BvPA/Kfw/MovTUmQ=;
 b=sVYmOeooJHmBivb3IobuBrUzDzYGad7DuO0Hi6RDK1kEE/LMMMxnWeThQK7HhftPxO68GfqDPIcGkHvTJquUq3vOsRUlkS8mcaOuvrObgpc9AdqxTPigUqtJ8FN1RRiJe2ySXb7t1xcI2n4UCSQUZsrDklC5sRfwuCyABvF7Fl0=
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
Subject: [PATCH v14 3/5] clk: imx: Add SCCG PLL type
Thread-Topic: [PATCH v14 3/5] clk: imx: Add SCCG PLL type
Thread-Index: AQHUh8Xno+5g76TEFUuUlHzqB+nHVw==
Date:   Thu, 29 Nov 2018 09:28:35 +0000
Message-ID: <1543483640-4585-4-git-send-email-abel.vesa@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3560;6:YATKs1sXH1UxPiGEzdsDfbiEdBwFMzCQid+JLrMsj2gYPUK/AiPxoKWxfq4E+9b+sXiMqYJ9tXQ6jHkJZYjOY/Hpjdz3ur0rpiWSec+bheZNXVm8WArZOPs1zGS2mBfDAwC/O/x79FMjwbbJwAfElf7D422Ha93ZdLTFcWM3/OkoKQ7nOjUwXbw8MmUIV4UBnVYoKsL89GjBIfOpbf+SN4Hme18WfpcAxezVxdSRA3pf6AW/zd7g/03wF7re521/CunvJjsvNFhL88464FYqrQ0lp48uSshuafIEg+lrfUrbh+pAzswlEYeo3ycG5IBAk7+eF50VWEyUqjkG1o+14JHqBqIVMFc4rDeEeWfESj77NQJDNQvoSospMdC3tSanJzPk2ifihaKVRD7FsKzwJ3qaWZYBp4HKvH578NTQx6/QDFJYwhO03/4m66ScDKJ8jtCbBj8Knv+/gNtp+o9IYQ==;5:Vt2S//Pm4YdQjWZZET3boRKK4OtrIS+WfGBSuSEjo3JgsMlctwM+N74CFzvo28qKrxMxgdzKRd+w/FEZX8js8ZDfbRhF6z4XGYFqCW7B4wN+lpvUmC1IsnivTgA4CD5eG+CwopeaJi25ji8pA1XJUZk4jAFOgt8cxeiCvpHPgrc=;7:0CYdfOjtRq3LBQ5WGsqcl2YHpnu2WLGakSEdfQBCwrcWvnc2iPLFDoQbBKa/pZpvaJ/Qouv0GCJO9H+9vyj5HoMZZYb6Elj3GYA8mnQnldtxJ9zlUl61iqtOG2Ai3N1ADN3SNdJvN0ZZUtl5ges9hw==
x-ms-office365-filtering-correlation-id: 82c99beb-cd7b-4776-7541-08d655dd0964
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3560;
x-ms-traffictypediagnostic: AM6PR0402MB3560:
x-microsoft-antispam-prvs: <AM6PR0402MB35605B9F73DCAFC9CCF177CAF6D20@AM6PR0402MB3560.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231453)(999002)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM6PR0402MB3560;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3560;
x-forefront-prvs: 0871917CDA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(39860400002)(376002)(346002)(199004)(189003)(4326008)(105586002)(6486002)(26005)(478600001)(966005)(97736004)(106356001)(217873002)(3846002)(14454004)(44832011)(2906002)(2616005)(5660300001)(71200400001)(7416002)(446003)(71190400001)(316002)(11346002)(66066001)(486006)(6506007)(81156014)(305945005)(7736002)(6436002)(25786009)(36756003)(81166006)(14444005)(6116002)(8936002)(110136005)(256004)(8676002)(476003)(6666004)(102836004)(54906003)(6512007)(6306002)(76176011)(68736007)(99286004)(52116002)(186003)(386003)(86362001)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3560;H:AM6PR0402MB3654.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5cJSOsPXl9CXrC9cFl+sTpC0ppvCBwAvmRb8pkQYdChJmFbtYmhEqyoAx3OvJ+3cwvjklS6nL2mr4TPX1Pog7eV4hgyzR5hEEZ4A3W4FhOy3QfJaRBuHm8h9n81scQUqqYKeeQB9cgx6+aEUWK0EESBTBEiBhhlrbPFxKrvdAB4fOUPEqK92I2xolasuF5iwzw+8f0JVpPtkftBgF6uhPP137T0zX77Ixu/7HuKTZxYNrSsCd2VeBm2y7HHkwQWKqRpQcfoOoFyCIFPcgIG66cTxhD97lK4cv3EhlAFFTDN6riu77qKo5dguiCGHwWWTuBTAuYJCw/7hYKnr+SlJlfMgpfIzSq4wAG63ESCRcYc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c99beb-cd7b-4776-7541-08d655dd0964
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2018 09:28:35.6028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3560
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
index 0000000..ee7752b
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
+		return ERR_PTR(ret);
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

