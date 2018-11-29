Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D923C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 09:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F0BE2081B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 09:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ADluaiP6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F0BE2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbeK2Uih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 15:38:37 -0500
Received: from mail-eopbgr60050.outbound.protection.outlook.com ([40.107.6.50]:2224
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727615AbeK2Uih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 15:38:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9oLdGrbrumszVQP77qQN7tHMWaLYSe8v/cMPZ7dqFY=;
 b=ADluaiP677Lbf/ul3gUbRHuIsUCNWNa7OZix8p4KcXMpn7S9nU1xDZazpYFSuUZaiLKv6FVLFTURS/UYBjJcWzxbeMdtfy/2GFYiJ4+LxhOLXPWcl9GBbGdkJBDaDePtM493braD1lRpNTTre+zqSUGGq7fZlZ496vZMflFHdwM=
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com (52.133.28.145) by
 AM6PR0402MB3560.eurprd04.prod.outlook.com (52.133.19.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Thu, 29 Nov 2018 09:29:02 +0000
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::c46b:915c:7a03:123d]) by AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::c46b:915c:7a03:123d%3]) with mapi id 15.20.1339.032; Thu, 29 Nov 2018
 09:29:02 +0000
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
Subject: [PATCH v14 4/5] clk: imx: Add imx composite clock
Thread-Topic: [PATCH v14 4/5] clk: imx: Add imx composite clock
Thread-Index: AQHUh8Xnev8gNY0FdUi072Pco9P9OA==
Date:   Thu, 29 Nov 2018 09:28:36 +0000
Message-ID: <1543483640-4585-5-git-send-email-abel.vesa@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3560;6:1/9rmGLPNleMbVW+u1VEz5uVYu0tbJVVlVQACBJsleApUp2xVARYmbi3xxKnIsDVvqPsA1tB335oxDAnnsbhYu+HzL+igWrh/4tHt0luHa1vIYGP/s8oH+aQYIRmpVmyaabl01peYKZnwUf1Cq8TKl/iRxDL10WPkvZ3M/erUIVFugx5EpOGm9+KOmnce1o32QBYiAgYJW9lfzDtaAkkE7FicmEa52B6TC/52S+9CNIDa0k7UNs8kkWnOzoM6SbfAzVeI/+bt84RYA6aaq1QxZfqWDnpStTj2Ip9zs11+BJJ16WnNkVGMoEOlirSGq4GQ5JBcBHLJZFdfan8wAk7doc0agLKvYzTeppqPy9tyOFFSXMAAt+U/SCuDlqqpjek1XLj4bUCBsLxsxGdECtSBJE04i6ImHk5//+q1z1ewEojX5OKTXLCHJJmJ389YIvGlEBzgCYW+z1TdUIKzwDazA==;5:v2Hv33XzuHBbiq6l4CialKS3BoigiXaWpJ8jANfd1S5qkna0qoqpz0oKybcHKqHjx1G01jF68xgozx/gbXybvj1FfrfsrDTqlztuPZCnjkFQKkHR3DS27gb9FtoaddvHkcPJg96h/+P7onK3izwBhQEzhdCHJDinlCMNX4nre/c=;7:qWA45F8jCV9gq+eCUE31g8Xnlfll/RBHV3HU5NSdyIrkdNOV+0n7ZLzI5wLtMsYXIm1aGIK+/RJTo/RrStXbKjIwfZanQTWgN3zf/mkaA0UUM1SlmITgxIlldpQkBMInC0wXSH1sT43aN2TiY6U1lw==
x-ms-office365-filtering-correlation-id: 6582f551-7d0b-453b-5a11-08d655dd0a0b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3560;
x-ms-traffictypediagnostic: AM6PR0402MB3560:
x-microsoft-antispam-prvs: <AM6PR0402MB3560D4B297ADE6C752F341BAF6D20@AM6PR0402MB3560.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231453)(999002)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM6PR0402MB3560;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3560;
x-forefront-prvs: 0871917CDA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(39860400002)(376002)(346002)(199004)(189003)(4326008)(105586002)(6486002)(26005)(478600001)(97736004)(106356001)(3846002)(14454004)(44832011)(2906002)(2616005)(5660300001)(71200400001)(7416002)(446003)(71190400001)(316002)(11346002)(66066001)(486006)(6506007)(81156014)(305945005)(7736002)(6436002)(25786009)(36756003)(81166006)(14444005)(6116002)(8936002)(110136005)(256004)(8676002)(476003)(6666004)(102836004)(54906003)(6512007)(76176011)(68736007)(99286004)(52116002)(575784001)(186003)(386003)(86362001)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3560;H:AM6PR0402MB3654.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0GqOfDuc4XDBMn2Qvjc/PFKvt1sJx6jKmWwGy+mJMDefx1uJWB/JzCNfbU+0RcAYl77CxKNvEJUf/IXmgoJS/XJYdn3FT/PT01N9IRh5ntDPi+rwrl1NtLTHzbL4sPMECkrW8Oj6hPccWuGcH+G5bQfmLhDbObfXtqgMtGH+o5F34KunOsyJMLUxQrMDlbMdRoK+sMac2rqEkUupEzbJ5BI2E3IWGOiTJm1eeMxbGbsjhJYwDGAWw3lWbp7NY0vtn8HX3LuwpKsLJhHbamKJyEQaqWvIvwI3jag0A1VHQzhWF5M1YoP1efhvCF6PDrLioJgDIcjjTRJ0x0CrVWLNiUoQDQl5X94A/UiHIt32Dxs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6582f551-7d0b-453b-5a11-08d655dd0a0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2018 09:28:36.6965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3560
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
 drivers/clk/imx/clk-composite-8m.c | 178 +++++++++++++++++++++++++++++++++=
++++
 drivers/clk/imx/clk.h              |  16 ++++
 3 files changed, 195 insertions(+)
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
index 0000000..6d9d371
--- /dev/null
+++ b/drivers/clk/imx/clk-composite-8m.c
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2018 NXP
+ */
+
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/clk-provider.h>
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
+static unsigned long imx8m_clk_composite_divider_recalc_rate(struct clk_hw=
 *hw,
+						unsigned long parent_rate)
+{
+	struct clk_divider *divider =3D to_clk_divider(hw);
+	unsigned long prediv_rate;
+	unsigned int prediv_value;
+	unsigned int div_value;
+
+	prediv_value =3D readl(divider->reg) >> divider->shift;
+	prediv_value &=3D clk_div_mask(divider->width);
+
+	prediv_rate =3D divider_recalc_rate(hw, parent_rate, prediv_value,
+						NULL, divider->flags,
+						divider->width);
+
+	div_value =3D readl(divider->reg) >> PCG_DIV_SHIFT;
+	div_value &=3D clk_div_mask(PCG_DIV_WIDTH);
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
+	int error =3D INT_MAX;
+	int ret =3D -EINVAL;
+
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
+static long imx8m_clk_composite_divider_round_rate(struct clk_hw *hw,
+						unsigned long rate,
+						unsigned long *prate)
+{
+	int prediv_value;
+	int div_value;
+
+	imx8m_clk_composite_compute_dividers(rate, *prate,
+						&prediv_value, &div_value);
+	rate =3D DIV_ROUND_UP(*prate, prediv_value);
+
+	return DIV_ROUND_UP(rate, div_value);
+
+}
+
+static int imx8m_clk_composite_divider_set_rate(struct clk_hw *hw,
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
+	ret =3D imx8m_clk_composite_compute_dividers(rate, parent_rate,
+						&prediv_value, &div_value);
+	if (ret)
+		return -EINVAL;
+
+	spin_lock_irqsave(divider->lock, flags);
+
+	val =3D readl(divider->reg);
+	val &=3D ~((clk_div_mask(divider->width) << divider->shift) |
+			(clk_div_mask(PCG_DIV_WIDTH) << PCG_DIV_SHIFT));
+
+	val |=3D (u32)(prediv_value  - 1) << divider->shift;
+	val |=3D (u32)(div_value - 1) << PCG_DIV_SHIFT;
+	writel(val, divider->reg);
+
+	spin_unlock_irqrestore(divider->lock, flags);
+
+	return ret;
+}
+
+static const struct clk_ops imx8m_clk_composite_divider_ops =3D {
+	.recalc_rate =3D imx8m_clk_composite_divider_recalc_rate,
+	.round_rate =3D imx8m_clk_composite_divider_round_rate,
+	.set_rate =3D imx8m_clk_composite_divider_set_rate,
+};
+
+struct clk *imx8m_clk_composite_flags(const char *name,
+					const char **parent_names,
+					int num_parents, void __iomem *reg,
+					unsigned long flags)
+{
+	struct clk_hw *hw =3D ERR_PTR(-ENOMEM), *mux_hw;
+	struct clk_hw *div_hw, *gate_hw;
+	struct clk_divider *div =3D NULL;
+	struct clk_gate *gate =3D NULL;
+	struct clk_mux *mux =3D NULL;
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
+	hw =3D clk_hw_register_composite(NULL, name, parent_names, num_parents,
+			mux_hw, &clk_mux_ops, div_hw,
+			&imx8m_clk_composite_divider_ops,
+			gate_hw, &clk_gate_ops, flags);
+	if (IS_ERR(hw))
+		goto fail;
+
+	return hw->clk;
+
+fail:
+	kfree(gate);
+	kfree(div);
+	kfree(mux);
+	return ERR_CAST(hw);
+}
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 864cd8a..cb3e92c 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -239,4 +239,20 @@ struct clk *imx_clk_cpu(const char *name, const char *=
parent_name,
 		struct clk *div, struct clk *mux, struct clk *pll,
 		struct clk *step);
=20
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
--=20
2.7.4

