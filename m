Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A38C0044C
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A2DD223D0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 16:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QmdxtfiL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A2DD223D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731013AbeKNCXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 21:23:07 -0500
Received: from mail-eopbgr60045.outbound.protection.outlook.com ([40.107.6.45]:37052
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726459AbeKNCXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 21:23:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwnztoQH1KrtAgE2pm8PGQog3cKpXNUfx9Vua0NEWkk=;
 b=QmdxtfiLRn0UVul3wCMTikwObOTd0ocy9B1RK70KOlWoueTRgaW8WJGzZ6dMGbcHIaZTFh3Zqe7aoF/rX/YrQbnaDQO30oVl483BYuTPB005Ffqt571Un6Ka9F2ubncA/0/ZJeHwgOChQ62/7r9DrWtUsZSQVQBO3sLdNbSGpgY=
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com (52.133.28.145) by
 AM6PR0402MB3750.eurprd04.prod.outlook.com (52.133.29.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Tue, 13 Nov 2018 16:20:00 +0000
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::5195:5e4c:be83:408b]) by AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::5195:5e4c:be83:408b%4]) with mapi id 15.20.1294.045; Tue, 13 Nov 2018
 16:20:00 +0000
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
Subject: [PATCH v13 4/5] clk: imx: Add imx composite clock
Thread-Topic: [PATCH v13 4/5] clk: imx: Add imx composite clock
Thread-Index: AQHUe2y5M2CYbJVqGEqsp036cvwO6A==
Date:   Tue, 13 Nov 2018 16:20:00 +0000
Message-ID: <1542125975-8448-5-git-send-email-abel.vesa@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3750;6:kcqPmMllbldbwTjN6A4QFzntHarIRNY04G9eBq2epLfFvLRK1KecUiIghH1C7LI/XNPvAZhcGd5N84ZjM+1c90HHxOQLQpU/eHY/law36Kw0yp+FEfSwlj8KHtki384JGMQgz8cMhwZcvmsOj4bJUTJXbbbFbVWUVrvRFy1PUVOmWhiTJeBBsL7y2MRbvUEsk2dc2/MJHaegevD1/Da23P1L5rqolcg2V0S3h7cdMVLe29h/vAUFRmoEkrH2lVmak0edV9t222QDHf/iDPFoPpGYuK4fOotIPk7hDMkaO/1GH99KjwGjSS+WVVidx8t5kpOXf++2A/7UGsACCXUimtE7hgSFL15gQodIkzsXlgo7ZjyOUkzKqcd35BT8kKkOIJnvShSL853Q1+l2AAj8bhPLj1e4UFDAroLRqCAc607r0MolJyqHep9sGZSb+sUQYckJ+eT3rE79SEY6BThh2w==;5:9Ud/VHmtaPHzYRT0semawsjLz2cP8XHDK2BgEg1mJTiMsPxkEH6DcYhG4Zeawv/THh0vXeeCvS2Aqr7IvU/+EFXl0xfNFkLZ0cY3K2I+0hNf/gy3M4lgHArlkAVN4fvFlea2OLnPXc5+8+PgC/KUVL7zu/bYu/uLFX0tzCYg5ZA=;7:UQRzZ0GbF/vsJZzpxJznRXLNrRr0/0EOav8/zFnr/R/iL/qTgu4Ck7Q9JBjEp13oZpX2ziRR11blw18GityWMt3yKJJ+29bZeHV1PtMSApjII++2OzQaWQiCvTGVOw2bx3cJzQR77T0zXCQIBxVLAg==
x-ms-office365-filtering-correlation-id: 3f146422-ad7a-4fc1-2c19-08d64983dbf8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390060)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3750;
x-ms-traffictypediagnostic: AM6PR0402MB3750:
x-microsoft-antispam-prvs: <AM6PR0402MB3750C679AE85CFFF7B3A910DF6C20@AM6PR0402MB3750.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231406)(944501410)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM6PR0402MB3750;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3750;
x-forefront-prvs: 085551F5A8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(346002)(396003)(136003)(199004)(189003)(105586002)(2906002)(44832011)(7416002)(386003)(6116002)(106356001)(26005)(3846002)(76176011)(446003)(5660300001)(11346002)(316002)(4326008)(478600001)(68736007)(14454004)(186003)(7736002)(110136005)(54906003)(305945005)(52116002)(2616005)(476003)(102836004)(6506007)(486006)(14444005)(71190400001)(71200400001)(53936002)(86362001)(2900100001)(6486002)(575784001)(99286004)(25786009)(6436002)(6512007)(8936002)(256004)(97736004)(81166006)(36756003)(66066001)(81156014)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3750;H:AM6PR0402MB3654.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: U+9FOFcMJWnVrfs4KMSm3bSom+dVQIXUHPkxiA1M3fkNW1NG5ZacHesPjtJy9ilLJpVeHVekxytQWEg2FTGvUJ9h+iQwLZRw8e207Th8IVeMYDB7aw1obozhtVpYZtAsAvNvGkP05/D5cpIsAGV9JVvcc3xDDWiSh3ocVCCmPB3ddoGCt6dgQisXp/OgHmuHCWH7eO6DR8UFhpbxiGOWl6F8rFnFPxxlTP8J9hAZwiAynm5VqbU0GOlqOWtoQf2lHC5MV2DRY96MR0DGuMK3/AeyT6MAfnFXuVf8L4d9uBEA2J2c+awYfolK0/sXnhtKpAVvb1LgEGhOaxaG9jc0htKKOEsNQ2XxJwS8C7tlgGU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f146422-ad7a-4fc1-2c19-08d64983dbf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2018 16:20:00.4165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3750
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
index 0000000..bcd31d8
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
+	struct clk_hw *hw =3D NULL, *mux_hw =3D NULL;
+	struct clk_hw *div_hw =3D NULL, *gate_hw =3D NULL;
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

