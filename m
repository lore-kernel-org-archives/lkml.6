Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3A7C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 08:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE45F2089D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 08:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MEtqaHWi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE45F2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbeJIPxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 11:53:31 -0400
Received: from mail-eopbgr00087.outbound.protection.outlook.com ([40.107.0.87]:11264
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726563AbeJIPx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 11:53:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJsxzwWmsU3u6U3+iUBL8XegvbIV2DJhdrOtba0mlCw=;
 b=MEtqaHWiE845AbINaFdxAslmDB6Lvx4/tvzceFmecBXDcbmRGGpSN/LLq0QkE0i2nhXrjKfzP1bP/0yCJhkNZFAzTkBKcRPQbCk+cSHNoUX6ki+nxfpq5Rosls7PPFo1Qnh3jg6yjuIlO1R6o2faTWrWMIjg/EcZvRqid6v1Hh0=
Received: from VI1PR04MB1613.eurprd04.prod.outlook.com (10.164.84.147) by
 VI1PR04MB5343.eurprd04.prod.outlook.com (52.134.123.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.26; Tue, 9 Oct 2018 08:37:30 +0000
Received: from VI1PR04MB1613.eurprd04.prod.outlook.com
 ([fe80::f014:635a:bee7:76b3]) by VI1PR04MB1613.eurprd04.prod.outlook.com
 ([fe80::f014:635a:bee7:76b3%3]) with mapi id 15.20.1207.024; Tue, 9 Oct 2018
 08:37:30 +0000
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
Subject: [PATCH v10 4/5] clk: imx: add imx composite clock
Thread-Topic: [PATCH v10 4/5] clk: imx: add imx composite clock
Thread-Index: AQHUX6tQJ9541kIf10SWRaGOsstznA==
Date:   Tue, 9 Oct 2018 08:37:30 +0000
Message-ID: <1539074230-27277-5-git-send-email-abel.vesa@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5343;6:J5MGx9KTThcebspO3m7EaHEcj7sI7BnQAV2F/ZYpaMiEILHpYrn3v+Y0hIfiecKobye+rxV+XAX8pIc15DS8yA8Z1k9JWbHz8hezFjJ67bNf8o31OEIZD79bhaayrIeQckSwOH57YNduvwWVBUdfmkY7Dq3pz0rHKnh5qdbGZbh0rrJPGxlFnr5UEoBiyu8aaFBu2VsCtpeS78U49dgB/zfdOxNpJmQwNfpDc2BlGN8/wgeZ/TVAnelOm+OLcAW3hGARKhXVp8fo2YK6IfEoxeilsFd2vkrDbugwcmFBL8blhmexleOptANbEhS895BjoRFh/eJmmd7p2RcgBBEhg9rR0TOyiRCIiIEy7EBR1XN293taT5PXYNoOkPHYDsmPmze20D+X12V7sWzAYZzZcH5SQYzAibbL5XhCnRwh+HpDB3sYk2mX+ozrvRdGqfyf8cZZ1mFWjiaoaZPTs4hJIw==;5:2GkRS7G8CRL0+vurELsIuFSQ5y2vzfIOi5KeGcsQMNIG3CUzopTzfVvpzaWjni604FrYge91QJ0mZPNVp+8YUwLvlvfljWH0A+VuLsD41DuHL7tmkyu0jnFQ6seNmzpWKh6qnGY4LMwtRvrtToepCCb0KAZdrGcLfi8GzeBlEms=;7:TYxS7rZLQ54KLyaJnHJdwXPJYDWc7o4PxQ1NV6RQeDYGaohKEtE6WQP0vjstKehSsGM5f9L7TrV9gk/TDzZQMoxIZErBkdFLty5Io97ACr5xczobh/jdGBdmalVZbHUgqSMzg9XOMHe2jw5zmkZ50av2sXgdULisOuFxjcH5DoNV4AQD9sLy7b9j/8/yvbG4kQfiazPtHSr5D5pgPH9CdYsu/TGfdnazzVoy9JE3oYv+vxsQDjJktyuPhznSTxBB
x-ms-office365-filtering-correlation-id: 9a88cbc0-220d-43f4-b3b9-08d62dc27349
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5343;
x-ms-traffictypediagnostic: VI1PR04MB5343:
x-microsoft-antispam-prvs: <VI1PR04MB53432F17996D2280039B4FCEF6E70@VI1PR04MB5343.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991055);SRVR:VI1PR04MB5343;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB5343;
x-forefront-prvs: 08200063E9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(346002)(366004)(376002)(199004)(189003)(476003)(486006)(44832011)(6512007)(446003)(6636002)(36756003)(5660300001)(2906002)(5250100002)(68736007)(2616005)(11346002)(6116002)(3846002)(106356001)(7736002)(305945005)(105586002)(81166006)(81156014)(8676002)(71190400001)(52116002)(110136005)(71200400001)(25786009)(14454004)(478600001)(256004)(86362001)(6486002)(575784001)(2900100001)(14444005)(4326008)(186003)(6436002)(54906003)(6506007)(8936002)(386003)(66066001)(7416002)(102836004)(6346003)(53936002)(97736004)(99286004)(76176011)(316002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5343;H:VI1PR04MB1613.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-microsoft-antispam-message-info: duGSNflW+2nr9bhVQ2NrO2s+yf06xBYEdMiuSi16cGuZXW6Li6ZelhMQzJIsRTHdkeTg2tYUB6hRsqc4Z0A9y95B1T+MZ1aF0LP7wy5wmE9o3ZP+NVRQYifVhSXehbcvdZgQmVrOSi2gEyZgdPq8HzrC1e4UYOYkvrsuCvznjIsb1UmDwFiNoWvVLewFpI9HzmNFkC6v6Vz7mdj/3PW9+OGOotnx6T3ExwNgs5Br1x+bc7GSqEsuevnI/68c0gOed5NIab/bh7fBo61qNKD6lIPMomWe9X1tys/Y2YxRRr234eOkcgIcIRlTnho3t6wmZu6uAATsUCTRR3gkVD32HUFH2qsiMpIHeOO3CLRWhzg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a88cbc0-220d-43f4-b3b9-08d62dc27349
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2018 08:37:30.4681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5343
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since a lot of clocks on imx8m are formed by a mux, gate, predivider and
divider, the idea here is to combine all of those into one composite clock,
but we need to deal with both predivider and divider at the same time and
therefore we add the imx_clk_composite_8m_divider_ops and register
the composite clock with those.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Suggested-by: Sascha Hauer <s.hauer@pengutronix.de>
Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/clk/imx/Makefile           |   1 +
 drivers/clk/imx/clk-composite-8m.c | 181 +++++++++++++++++++++++++++++++++=
++++
 drivers/clk/imx/clk.h              |  16 ++++
 3 files changed, 198 insertions(+)
 create mode 100644 drivers/clk/imx/clk-composite-8m.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index b87513c..237444b 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -3,6 +3,7 @@
 obj-y +=3D \
 	clk.o \
 	clk-busy.o \
+	clk-composite-8m.o \
 	clk-cpu.o \
 	clk-fixup-div.o \
 	clk-fixup-mux.o \
diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-compo=
site-8m.c
new file mode 100644
index 0000000..a28f6ac
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
+static unsigned long imx_clk_composite_8m_divider_recalc_rate(struct clk_h=
w *hw,
+						unsigned long parent_rate)
+{
+	struct clk_divider *divider =3D to_clk_divider(hw);
+	unsigned long prediv_rate;
+	unsigned int prediv_value;
+	unsigned int div_value;
+
+	prediv_value =3D clk_readl(divider->reg) >> divider->shift;
+	prediv_value &=3D clk_div_mask(divider->width);
+
+	prediv_rate =3D divider_recalc_rate(hw, parent_rate, prediv_value,
+						NULL, divider->flags,
+						divider->width);
+
+	div_value =3D clk_readl(divider->reg) >> PCG_DIV_SHIFT;
+	div_value &=3D clk_div_mask(PCG_DIV_WIDTH);
+
+	return divider_recalc_rate(hw, prediv_rate, div_value, NULL,
+				   divider->flags, PCG_DIV_WIDTH);
+}
+
+static int imx_clk_composite_8m_compute_dividers(unsigned long rate,
+						unsigned long parent_rate,
+						int *prediv, int *postdiv)
+{
+	int div1, div2;
+	int error =3D INT_MAX;
+	int ret =3D -EINVAL;
+
+	/* default values */
+	*prediv =3D 1;
+	*postdiv =3D 1;
+
+	for (div1 =3D 1; div1 <=3D PCG_PREDIV_MAX; div1++) {
+		for (div2 =3D 1; div2 <=3D PCG_DIV_MAX; div2++) {
+			int new_error =3D ((parent_rate / div1) / div2) - rate;
+
+			if (abs(new_error) < abs(error)) {
+				*prediv =3D div1;
+				*postdiv =3D div2;
+				error =3D new_error;
+				ret =3D 0;
+			}
+		}
+	}
+	return ret;
+}
+
+static long imx_clk_composite_8m_divider_round_rate(struct clk_hw *hw,
+						unsigned long rate,
+						unsigned long *prate)
+{
+	int prediv_value;
+	int div_value;
+
+	imx_clk_composite_8m_compute_dividers(rate, *prate,
+						&prediv_value, &div_value);
+
+	rate =3D DIV_ROUND_UP(*prate, prediv_value);
+	rate =3D DIV_ROUND_UP(rate, div_value);
+
+	return rate;
+}
+
+static int imx_clk_composite_8m_divider_set_rate(struct clk_hw *hw,
+					unsigned long rate,
+					unsigned long parent_rate)
+{
+	struct clk_divider *divider =3D to_clk_divider(hw);
+	unsigned long flags =3D 0;
+	int prediv_value;
+	int div_value;
+	int ret =3D 0;
+	u32 val;
+
+	ret =3D imx_clk_composite_8m_compute_dividers(rate, parent_rate,
+						&prediv_value, &div_value);
+	if (ret)
+		return -EINVAL;
+
+	spin_lock_irqsave(divider->lock, flags);
+
+	val =3D clk_readl(divider->reg);
+	val &=3D ~((clk_div_mask(divider->width) << divider->shift) |
+			(clk_div_mask(PCG_DIV_WIDTH) << PCG_DIV_SHIFT));
+
+	val |=3D (u32)(prediv_value  - 1) << divider->shift;
+	val |=3D (u32)(div_value - 1) << PCG_DIV_SHIFT;
+	clk_writel(val, divider->reg);
+
+	spin_unlock_irqrestore(divider->lock, flags);
+
+	return ret;
+}
+
+static const struct clk_ops imx_clk_composite_8m_divider_ops =3D {
+	.recalc_rate =3D imx_clk_composite_8m_divider_recalc_rate,
+	.round_rate =3D imx_clk_composite_8m_divider_round_rate,
+	.set_rate =3D imx_clk_composite_8m_divider_set_rate,
+};
+
+struct clk *imx_clk_composite_8m_flags(const char *name,
+					const char **parent_names,
+					int num_parents, void __iomem *reg,
+					unsigned long flags)
+{
+	struct clk_hw *mux_hw =3D NULL, *div_hw =3D NULL, *gate_hw =3D NULL;
+	struct clk_divider *div =3D NULL;
+	struct clk_gate *gate =3D NULL;
+	struct clk_mux *mux =3D NULL;
+	struct clk *clk =3D ERR_PTR(-ENOMEM);
+
+	mux =3D kzalloc(sizeof(*mux), GFP_KERNEL);
+	if (!mux)
+		goto fail;
+
+	mux_hw =3D &mux->hw;
+	mux->reg =3D reg;
+	mux->shift =3D PCG_PCS_SHIFT;
+	mux->mask =3D PCG_PCS_MASK;
+
+	div =3D kzalloc(sizeof(*div), GFP_KERNEL);
+	if (!div)
+		goto fail;
+
+	div_hw =3D &div->hw;
+	div->reg =3D reg;
+	div->shift =3D PCG_PREDIV_SHIFT;
+	div->width =3D PCG_PREDIV_WIDTH;
+	div->lock =3D &imx_ccm_lock;
+	div->flags =3D CLK_DIVIDER_ROUND_CLOSEST;
+
+	gate =3D kzalloc(sizeof(*gate), GFP_KERNEL);
+	if (!gate)
+		goto fail;
+
+	gate_hw =3D &gate->hw;
+	gate->reg =3D reg;
+	gate->bit_idx =3D PCG_CGC_SHIFT;
+
+	clk =3D clk_register_composite(NULL, name, parent_names, num_parents,
+					mux_hw, &clk_mux_ops, div_hw,
+					&imx_clk_composite_8m_divider_ops,
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
index 12b3fd6..37c8c4a 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -232,4 +232,20 @@ struct clk *imx_clk_cpu(const char *name, const char *=
parent_name,
 		struct clk *div, struct clk *mux, struct clk *pll,
 		struct clk *step);
=20
+struct clk *imx_clk_composite_8m_flags(const char *name,
+					const char **parent_names,
+					int num_parents, void __iomem *reg,
+					unsigned long flags);
+
+#define __imx_clk_composite_8m(name, parent_names, reg, flags) \
+	imx_clk_composite_8m_flags(name, parent_names, \
+		ARRAY_SIZE(parent_names), reg, \
+		flags | CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE)
+
+#define imx_clk_composite_8m(name, parent_names, reg) \
+	__imx_clk_composite_8m(name, parent_names, reg, 0)
+
+#define imx_clk_composite_8m_critical(name, parent_names, reg) \
+	__imx_clk_composite_8m(name, parent_names, reg, CLK_IS_CRITICAL)
+
 #endif
--=20
2.7.4

